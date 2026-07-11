Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5C2882C5
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743321; cv=none; b=tdCBS3P5Hi9ihReWF4IK7UiZOGJ0DSbzPb5amgbQ4TX0Vt9LJn+FFF4gM+bVPEJZp5c5CMRWEjjQXC4HQsNYaTW3pWxg4Iz4Oj/FL1yBJNhVJtyREwPOigQxsosY+xamvDEyAg2Eq9Y8WOjDb5rqictIpxJ5UCDOhwnBztSTKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743321; c=relaxed/simple;
	bh=8vG0uFf7MGyfNi8QjsYZ/kY/b8C6FJhsshR30bcjGio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IP6Bhjhwk7IyREWv+fZcXbgJO65Pfe00fQ/IA/fulCJ6u7HW2GOtWRXoJcEqdsb2A/4N8VDgc1YOEsGHHn87lv1lBBQQZTdQ6sL2I+1LZ6CgtHjoaTsJ7Y0xEH3r3Wu+6LO+XkOJKkKZXyuTMOoAODmJNi5PLbk99qCeMowTNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeV1sFhd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeV1sFhd"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c999f162c9aso854580a12.3
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783743308; x=1784348108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cVmjO8YLPA661gTc9yInoWvB2zcY0L5sJjMyBUBdtk0=;
        b=FeV1sFhdBJ8B7/NKTxFMiPAN/xHBvSeoB1QjOo/lMiUsJV5NXDcVfIkBvebRx9E3G2
         CaVj2rPx6Dwl5czFaubiz6PUWkkulTqkuFP5fm8FwBrrYhHLwf+ByGh4ePMbcRsRwNyY
         ZyJ/KlyMI+6RCc1g9nVU+RYHzyU+cZwB4eT5R1SHyvBLYaSPxR6iBz8mD2t84VawZBbm
         piOIxzaaYU8v+y4J+nTxQ23ZqFhdd9dOEthyFbM0HzbVGTqRWLdjnJkHFs9VjI6hE/CY
         HlhZ8Zdhxr9hjJZQi9aPk1vLbbHiaPnKzSlPtloc7q3/mi9hbX4PxRzEQnv0qDgmscCQ
         e4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783743308; x=1784348108;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cVmjO8YLPA661gTc9yInoWvB2zcY0L5sJjMyBUBdtk0=;
        b=aVMhh9JN1BIqriV9sR0hfrcpM+zKRK6bpXO5X9MRv8xPgluXncLjPxwxNeMmOjwpK8
         oeqPI1880K4W/sMHSG92OnSXSygVTDsj4b3FS9YPrLY1m3jnXL0gApFwKYC0/7AHU2BM
         lElBonuwtTvgrP9H1JVkSLFkSA4d79JDfdPUk3SJSj+a8/SCYZ7FeezLvesZei9Cc0G/
         N8ANAOa259NIMmrxeL6EVaGlC4Bn6wLpdJpkeQmRtypcaWi1vTjeBWiEMNTCOKcxtR36
         djjX8kiKHgTA0CDiLtKjGeTUJQSbCnWoosekOLjOc/GVcvBwKmMNqf15goOTfFB///cU
         LgYA==
X-Gm-Message-State: AOJu0YxOzy5lKL8Ay61QOjF98ocaTNkkmMAZkyGSS3gp65Lym5lMd2qx
	QAy2QxKymJEjCf4AXgaAiywggiiD4+kWd8+5EVx0GoO1lKNFzLKH68YW
X-Gm-Gg: AfdE7cn6YDfcSDsecgVBXU7DoIePoTwtiXkk5Hn2DMnWjElA84ZMhFGFFFzlP61HKUR
	CBuAvyzAlkT6ci8gf5rEF4kNU9i0H8c+iR3ZCZVMiLwgfuHiOjj1kromnOcEWp3RjeQC1PeS1tS
	2jPhIdKQ61HRe+IkUmZxLvOsBlgOYcH4CmWzSl4020PdOXEFQB0I3+3epHzyFn3K5cETD3EIYtQ
	ikSsvqgRY3GAN/3ooDe1uhkfN9RrYmbfogeSJlG4kPQxJhHeLU+69nDtF3qTmk0usEsZLglgAe7
	s8XWr/AcEvbNn2GdYZ64H9MgZGQqH/9ZlPhWKeYtWi7yosGXdZKD6Fl0hfT/sjmKqOvDXcluzig
	1zkv15v0gfajdaFRU7lEHPqzkE5qN0CHNWsNBaTYi/XfpVGeVTZIMEyvk4M8c/chRlzxl42GG8n
	Jj+TcYLIUgsajxb8BrtRvbFNzkFyQ=
X-Received: by 2002:a05:6a21:4d8f:b0:3bf:d1f9:b1df with SMTP id adf61e73a8af0-3c110d2f025mr1812527637.54.1783743307902;
        Fri, 10 Jul 2026 21:15:07 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afbc1208sm5769419a12.9.2026.07.10.21.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 21:15:07 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Sandeep Patil <sspatil@android.com>,
	"Andrew F . Davis" <afd@ti.com>
Cc: stable@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v2] dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
Date: Sat, 11 Jul 2026 12:14:55 +0800
Message-Id: <20260711041455.3375292-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703080922.1838362-1-shoubaineng@gmail.com>
References: <20260703080922.1838362-1-shoubaineng@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
  4. fd_install()               publishes the fd -- from here on the
                                ioctl cannot fail.

To make this possible, dma_heap_ioctl_allocate() is refactored to
return the struct dma_buf * directly (returning ERR_PTR on failure)
so the caller holds the dmabuf reference across steps 3 and 4.
The fd is written into the kdata buffer before copy_to_user() so
the reserved fd number reaches userspace atomically with the install.

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
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/dma-buf/dma-buf.c  | 20 ++++++++++
 drivers/dma-buf/dma-heap.c | 80 +++++++++++++++++++-------------------
 include/linux/dma-buf.h    |  1 +
 3 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..4c9add51f9ef 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -803,6 +803,26 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
 
+/**
+ * dma_buf_fd_install - install a reserved fd for a dma-buf
+ * @dmabuf:	[in]	pointer to dma_buf
+ * @fd:		[in]	fd reserved with get_unused_fd_flags()
+ *
+ * Publishes a previously reserved fd into the caller's fd table.
+ * Must only be called after all fallible work (e.g. copy_to_user)
+ * has succeeded, as it cannot be undone safely once called.
+ *
+ * The caller is responsible for having emitted the trace event
+ * (via dma_buf_fd() or get_unused_fd_flags() + this function)
+ * before calling this.
+ */
+void dma_buf_fd_install(struct dma_buf *dmabuf, int fd)
+{
+	DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
+	fd_install(fd, dmabuf->file);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_fd_install, "DMA_BUF");
+
 /**
  * dma_buf_get - returns the struct dma_buf related to an fd
  * @fd:	[in]	fd associated with the struct dma_buf to be returned
diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index a76bf3f8b071..43c32fb28313 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -55,33 +55,6 @@ MODULE_PARM_DESC(mem_accounting,
 		 "Enable cgroup-based memory accounting for dma-buf heap allocations (default=false).");
 EXPORT_SYMBOL_NS_GPL(mem_accounting, "DMA_BUF_HEAP");
 
-static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
-				 u32 fd_flags,
-				 u64 heap_flags)
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
@@ -99,30 +72,42 @@ static int dma_heap_open(struct inode *inode, struct file *file)
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
@@ -138,6 +123,8 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 	unsigned int in_size, out_size, drv_size, ksize;
 	int nr = _IOC_NR(ucmd);
 	int ret = 0;
+	int fd;
+	struct dma_buf *dmabuf;
 
 	if (nr >= ARRAY_SIZE(dma_heap_ioctl_cmds))
 		return -EINVAL;
@@ -174,15 +161,28 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 
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
index d1203da56fc5..d15b2b31d3c9 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -567,6 +567,7 @@ void dma_buf_unpin(struct dma_buf_attachment *attach);
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
 
 int dma_buf_fd(struct dma_buf *dmabuf, int flags);
+void dma_buf_fd_install(struct dma_buf *dmabuf, int fd);
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
 
-- 
2.34.1

