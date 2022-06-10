import tensorflow as tf

from tensorflow_manopt.manifolds.manifold import Manifold
from tensorflow_manopt.manifolds import utils


class Sphere(Manifold):
    """Manifold of unit-norm points.
    Bergmann, Ronny, et al. "Priors with coupled first and second order
    differences for manifold-valued image processing." Journal of mathematical
    imaging and vision 60.9 (2018): 1459-1481.
    """

    name = "Sphere"
    ndims = 1

    def _check_point_on_manifold(self, x, atol, rtol):
        norm = tf.linalg.norm(x, axis=-1)
        return utils.allclose(norm, tf.ones_like(norm), atol, rtol)

    def _check_vector_on_tangent(self, x, u, atol, rtol):
        inner = self.inner(x, x, u, keepdims=True)
        return utils.allclose(inner, tf.zeros_like(inner), atol, rtol)

    def dist(self, x, y, keepdims=False):
        inner = self.inner(x, x, y, keepdims=keepdims)
        cos_angle = tf.clip_by_value(inner, -1.0, 1.0)
        return tf.math.acos(cos_angle)

    def inner(self, x, u, v, keepdims=False):
        # return tf.reduce_sum(
        #     u * v, axis=tuple(range(-self.ndims, 0)), keepdims=keepdims
        # )
        return tf.reduce_sum(u * v, axis=-1, keepdims=keepdims)

    def proju(self, x, u):
        return u

    def projx(self, x):
        return x / tf.linalg.norm(x, axis=-1, keepdims=True)

    def exp(self, x, u):
        norm_u = self.norm(x, u, keepdims=True)
        exp = x * tf.math.cos(norm_u) + u * tf.math.sin(norm_u) / norm_u
        retr = self.projx(x + u)
        return tf.where(norm_u > utils.get_eps(x), exp, retr)

    retr = exp

    def log(self, x, y):
        u = self.proju(x, y - x)
        norm_u = self.norm(x, u, keepdims=True)
        dist = self.dist(x, y, keepdims=True)
        log = u * dist / norm_u
        return tf.where(dist > utils.get_eps(x), log, u)

    def ptransp(self, x, y, v):
        log_xy = self.log(x, y)
        log_yx = self.log(y, x)
        dist_sq = self.dist(x, y, keepdims=True) ** 2
        inner = self.inner(x, log_xy, v, keepdims=True)
        return v - inner * (log_xy + log_yx) / dist_sq

    transp = ptransp

    def geodesic(self, x, u, t):
        # return x + t * u
        norm_u = self.norm(x, u, keepdims=True)
        return (
            x * tf.math.cos(norm_u * t) + u * tf.math.sin(norm_u * t) / norm_u
        )

    def pairmean(self, x, y):
        return (x + y) / 2.0
