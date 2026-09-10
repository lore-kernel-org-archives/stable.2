Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20E4B4892
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058592; cv=none; b=AdTLEfxv6wyIQ4oZ3aTsRLMjAl3n1bnZ+Jh0c/2KPxROgjKy4ketOWwbIjxcvXugBnrXBpfv6AuM9MTCXeEiFYK/Zl+VDrHYKu4TYW/F6SHSrslhU84UpfV/xjTdPEAcTtaTRRRn4l0IIt+G0mH73P7k5uNlecqjH29bbxi/BSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058592; c=relaxed/simple;
	bh=SBmZN+rHLsRQYrqnN4o+pXUWtCKO096LlStKw2DshMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBxSh3SwzpTXHxIdNIJK1E2V49S7os5eU0WUV5Y+rYlWcIF7HYoY/FIkotTyUIAvRxZbnG5S0bd9pVsB3e56P+nMAl92+AmZnypPmsh1zhPbQmziZOVXj2UqaD11OVUSa95IR1CJXK06HJJCq949hPJLJxQ6jvR5oYqoMzHtteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfUCahKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfUCahKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A29F1F000FF;
	Thu, 10 Sep 2026 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058590;
	bh=wdfzPmtioQGBKI4DqS4C2sUl7V/PiaBx+4PBDkfBquM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IfUCahKp+76Apg2YVFQK/MrKnwKp6ERJ8CcorvgGEeXnH/CttRk7LbdVkmEK90CP+
	 VmxM/NfwKGnCvz2wJJZgXUw7lcWuIV7DqgSqTJzTynE3d2m52yTqntzvG/7mbG+hLK
	 1uNKLvh5bkKLkGeoB/Fsze/WoNWjELfMUa3XetMd7j8PTtz8B39xQDoD2FdjGInyOD
	 FjwOjZ1pyCzWuGitB6iIu/lfB0KBvdeHSbArJlCmGhbIpJR7MhibEKn/6S8XVKa5zH
	 qVkdbb4QnEAs/zAxklIO4N7aakFS+JkteoUX3zJKtv2oQNZtXZCk5RpPQQMp8E0fLB
	 ASIxvP+QOqkQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baineng Shou <shoubaineng@gmail.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
Date: Thu, 10 Sep 2026 12:43:06 -0400
Message-ID: <20260910164307.1247027-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090821-regroup-crunching-93c8@gregkh>
References: <2026090821-regroup-crunching-93c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Baineng Shou <shoubaineng@gmail.com>

[ Upstream commit 30d0aff2c65a277135cfd8ea28fa1ee75e0ea4e0 ]

DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
caller's fd table via dma_buf_fd() -> fd_install() before
dma_heap_ioctl() copies the result back to userspace.  If the trailing
copy_to_user() fails, userspace never learns the fd number, but the
fd (and the underlying dma-buf reference) are already visible to
other threads in the same process and are leaked for the lifetime of
the process.

The obvious "close it on the failure path" fix is unsafe: once
fd_install() has run, another thread can already dup() the fd, send
it via SCM_RIGHTS, or close() it and let its number be reused, so a
subsequent close_fd() from the ioctl path can operate on an unrelated
file.  This was pointed out by Christian König on v1 [1].

Restructure the allocation path so that fd_install() is the last,
unfailable step of a successful ioctl:

  1. heap->ops->allocate()      creates the dma_buf.
  2. get_unused_fd_flags()      reserves an fd number in the caller's
                                fd table without publishing it, so
                                no other thread can observe it.
  3. copy_to_user()             delivers the fd number to userspace;
                                on failure the fd is returned with
                                put_unused_fd() and the dma_buf
                                reference is dropped with
                                dma_buf_put(), leaving no user-
                                visible state behind.
  4. dma_buf_fd_install()       publishes the fd and emits the
                                trace_dma_buf_fd tracepoint -- from
                                here on the ioctl cannot fail.

A new dma_buf_fd_install() helper is introduced in dma-buf.c to wrap
fd_install() together with the DMA_BUF_TRACE() call, preserving the
export tracing that dma_buf_fd() provides.  dma_heap_ioctl_allocate()
is refactored to return the struct dma_buf * directly (returning
ERR_PTR on failure) so the caller holds the dmabuf reference across
steps 3 and 4.

The failure at step 3 is easily reachable from userspace: pass a
struct dma_heap_allocation_data that lives in a page whose protection
is flipped to PROT_READ between copy_from_user() and copy_to_user()
(e.g. via mprotect()).  Before this change each such ioctl leaks one
dmabuf fd; after it, the fd table is unchanged on failure and only
/dev/dma_heap/<name> remains open.

No UAPI or heap-driver interface change.

[1] https://lore.kernel.org/dri-devel/175e98de-f414-47d7-81c1-c0fe0a8f7f62@amd.com/

Fixes: c02a81fba74f ("dma-buf: Add dma-buf heaps framework")
Cc: stable@vger.kernel.org
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
Link: https://lore.kernel.org/r/20260817050457.1005285-2-shoubaineng@gmail.com
Signed-off-by: Christian König <christian.koenig@amd.com>

[Backport to 6.6: resolve removal of dma_heap_buffer_alloc() against the
older unsigned-int argument types, without importing the newer
mem_accounting module parameter. Keep the allocation, fd reservation,
usercopy and publication ordering in the existing ioctl functions.

This tree has no DMA_BUF_TRACE/trace_dma_buf_fd infrastructure. Replace
the new dma_buf_fd_install() function, declaration and symbol export with
a single-evaluation macro around the existing fd_install(). This retains
the interface required by a4a1a2bfcb29 ("misc: fastrpc: don't publish fd
before copy_to_user() succeeds") without adding functions or tracing
infrastructure. The dma-buf.c hunk is therefore dropped.]

[ sashal: Reduced backport -- upstream 30d0aff2c65a2 touches 3 file(s), this
  backport carries 2. Not backported here:
  drivers/dma-buf/dma-buf.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: a4a1a2bfcb29 ("misc: fastrpc: don't publish fd before copy_to_user() succeeds")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma-buf/dma-heap.c | 80 +++++++++++++++++++-------------------
 include/linux/dma-buf.h    |  4 ++
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 59d158873f4cb..38b425c8e1119 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -49,33 +49,6 @@ static dev_t dma_heap_devt;
 static struct class *dma_heap_class;
 static DEFINE_XARRAY_ALLOC(dma_heap_minors);
 
-static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
-				 unsigned int fd_flags,
-				 unsigned int heap_flags)
-{
-	struct dma_buf *dmabuf;
-	int fd;
-
-	/*
-	 * Allocations from all heaps have to begin
-	 * and end on page boundaries.
-	 */
-	len = PAGE_ALIGN(len);
-	if (!len)
-		return -EINVAL;
-
-	dmabuf = heap->ops->allocate(heap, len, fd_flags, heap_flags);
-	if (IS_ERR(dmabuf))
-		return PTR_ERR(dmabuf);
-
-	fd = dma_buf_fd(dmabuf, fd_flags);
-	if (fd < 0) {
-		dma_buf_put(dmabuf);
-		/* just return, as put will call release and that will free */
-	}
-	return fd;
-}
-
 static int dma_heap_open(struct inode *inode, struct file *file)
 {
 	struct dma_heap *heap;
@@ -93,30 +66,42 @@ static int dma_heap_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static long dma_heap_ioctl_allocate(struct file *file, void *data)
+static struct dma_buf *dma_heap_ioctl_allocate(struct file *file, void *data)
 {
 	struct dma_heap_allocation_data *heap_allocation = data;
 	struct dma_heap *heap = file->private_data;
+	struct dma_buf *dmabuf;
 	int fd;
+	size_t len;
 
 	if (heap_allocation->fd)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if (heap_allocation->fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
+
+	len = PAGE_ALIGN(heap_allocation->len);
+	if (!len)
+		return ERR_PTR(-EINVAL);
+
+	dmabuf = heap->ops->allocate(heap, len, heap_allocation->fd_flags,
+				     heap_allocation->heap_flags);
 
-	fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
-				   heap_allocation->fd_flags,
-				   heap_allocation->heap_flags);
-	if (fd < 0)
-		return fd;
+	if (IS_ERR(dmabuf))
+		return dmabuf;
+
+	fd = get_unused_fd_flags(heap_allocation->fd_flags);
+	if (fd < 0) {
+		dma_buf_put(dmabuf);
+		return ERR_PTR(fd);
+	}
 
 	heap_allocation->fd = fd;
 
-	return 0;
+	return dmabuf;
 }
 
 static unsigned int dma_heap_ioctl_cmds[] = {
@@ -132,6 +117,8 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 	unsigned int in_size, out_size, drv_size, ksize;
 	int nr = _IOC_NR(ucmd);
 	int ret = 0;
+	int fd;
+	struct dma_buf *dmabuf;
 
 	if (nr >= ARRAY_SIZE(dma_heap_ioctl_cmds))
 		return -EINVAL;
@@ -168,15 +155,28 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 
 	switch (kcmd) {
 	case DMA_HEAP_IOCTL_ALLOC:
-		ret = dma_heap_ioctl_allocate(file, kdata);
+		dmabuf = dma_heap_ioctl_allocate(file, kdata);
+
+		if (IS_ERR(dmabuf)) {
+			ret = PTR_ERR(dmabuf);
+			break;
+		}
+
+		fd = ((struct dma_heap_allocation_data *)kdata)->fd;
+		if (copy_to_user((void __user *)arg, kdata, out_size) != 0) {
+			put_unused_fd(fd);
+			dma_buf_put(dmabuf);
+			ret = -EFAULT;
+		} else {
+			dma_buf_fd_install(dmabuf, fd);
+		}
+
 		break;
 	default:
 		ret = -ENOTTY;
 		goto err;
 	}
 
-	if (copy_to_user((void __user *)arg, kdata, out_size) != 0)
-		ret = -EFAULT;
 err:
 	if (kdata != stack_kdata)
 		kfree(kdata);
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 9c31f1f430d8e..d0991ef660c3a 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -615,6 +615,10 @@ void dma_buf_unpin(struct dma_buf_attachment *attach);
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
 
 int dma_buf_fd(struct dma_buf *dmabuf, int flags);
+
+/* Publish a reserved fd only after all fallible work has succeeded. */
+#define dma_buf_fd_install(dmabuf, fd) fd_install((fd), (dmabuf)->file)
+
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
 
-- 
2.53.0

