#ifndef __PYX_HAVE__ckdtree
#define __PYX_HAVE__ckdtree

struct ckdtree;

/* "ckdtree.pyx":811
 * 
 * 
 * cdef public class cKDTree [object ckdtree, type ckdtree_type]:             # <<<<<<<<<<<<<<
 *     """
 *     cKDTree(data, leafsize=16, compact_nodes=True, copy_data=False,
 */
struct ckdtree {
  PyObject_HEAD
  struct __pyx_vtabstruct_7ckdtree_cKDTree *__pyx_vtab;
  std::vector<struct ckdtreenode>  *tree_buffer;
  struct ckdtreenode *ctree;
  struct __pyx_obj_7ckdtree_cKDTreeNode *tree;
  PyArrayObject *data;
  __pyx_t_5numpy_float64_t *raw_data;
  __pyx_t_5numpy_intp_t n;
  __pyx_t_5numpy_intp_t m;
  __pyx_t_5numpy_intp_t leafsize;
  PyArrayObject *maxes;
  __pyx_t_5numpy_float64_t *raw_maxes;
  PyArrayObject *mins;
  __pyx_t_5numpy_float64_t *raw_mins;
  PyArrayObject *indices;
  __pyx_t_5numpy_intp_t *raw_indices;
  PyArrayObject *_median_workspace;
};

#ifndef __PYX_HAVE_API__ckdtree

#ifndef __PYX_EXTERN_C
  #ifdef __cplusplus
    #define __PYX_EXTERN_C extern "C"
  #else
    #define __PYX_EXTERN_C extern
  #endif
#endif

#ifndef DL_IMPORT
  #define DL_IMPORT(_T) _T
#endif

__PYX_EXTERN_C DL_IMPORT(PyTypeObject) ckdtree_type;

#endif /* !__PYX_HAVE_API__ckdtree */

#if PY_MAJOR_VERSION < 3
PyMODINIT_FUNC initckdtree(void);
#else
PyMODINIT_FUNC PyInit_ckdtree(void);
#endif

#endif /* !__PYX_HAVE__ckdtree */
