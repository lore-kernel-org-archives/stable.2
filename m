Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B741DDF7
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097525; cv=none; b=fVa3Dv1Yp7JsjTZw8EqrCM2x4VPDKpLBB8bTdXLyZC2mgq/wSj2dFIn8ZVIDWXvY7kcuOTrKjBe2u7idY0heNQbmqSsB8XsQwf5W3zaY22Iomdgn13d2ksVcnDRumKjD7xK2lngnPTBYVGKMYisebFI9rWBDyFyB0oiIiRFSIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097525; c=relaxed/simple;
	bh=lb5lsOeFj44VvYqr0e5zyDhlpbvgh8japzWZ8lWhj9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPSYVLjw6MwFBhEbcBLG5BpyhL7gyG6rxX/EB9hrYz1KZUiPhj3nX8dsAYt+/BNkdS22Mir9ogP35cFuym6BgcwVcyasP04gsV5PnMqrw8+LMA0EUpUmqUuG0B8M8mS11Vipoy1IWfmJeFfd+UHJLiL+RJYIAXbGCJyBmZtZG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEFCj3G+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEFCj3G+"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso2155667b3a.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097523; x=1786702323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8IRM8cZuTQT295+YDoKUSZ1109m/5RG3rOLisZSSj50=;
        b=aEFCj3G+erGatnpfzZVslj1rY8fdhJb2ray9rg9mxUa55xeuNXk28Fz8hp7VdGVsoR
         URhM5/DKpY9T1RUv+FksJYgwROzO6zW0CXdqdCgd4NfiGvmLreeYGl0V7WwIaWqv0zLV
         /wHBUwhnq7XVj/qCaQWYVXC+mwNjuHbnvRKuPd0tYlEWQr3xJLaT7gkA9vCFmfHruo81
         MIEQYu16v+9n3gXR4b4Wu1vNw7z0a6Os27SRwg+VaTTLshlT7sRYDWiu1KhnSLKmbeu1
         QMOBcErT9K+T3tf7tkoscVSV7KYC0DvmpVD1QyZuryJYqePxptkGvOYLpRrQtd+RsPec
         kO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097523; x=1786702323;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IRM8cZuTQT295+YDoKUSZ1109m/5RG3rOLisZSSj50=;
        b=SgmvdaX7Gb32X1HvQHl4dxIhh40tMn9QelqHAWqhR/Jr7Jop1eYZrael7MpA1v2UIB
         37OtJWtfJjpOqvuKfOQrCUcIAT/edJv6U9TDKOZ3LL0XEYSm6LdN8vtbDBIed5uCrDVI
         JKU1V9EJ+tHQa56Slxs3aQNUCRDsoG7G7hyC17YN2vtPG37oHwXr+k44xzL/+g9GUVou
         LQYo8ncJsRC3yaOG/IyQMJGwSThu7LZlQv73XJBDpdInvUPuOVirErem3XD7k/NZiIDJ
         vkifzQsADxn7Qrz4oRKA4gVF8SrKcA615p5wemGJcHlUhn9acFWZLdUXvBSLWiKuvL5I
         bFuQ==
X-Gm-Message-State: AOJu0YyEKEDQTBW/VJ4EJhGYkricMkgFIPLqXpGHpmcHcuR5nQ5cdvCv
	JHIUKcBgQ5KDadEV/vCdq0aUSsY3l6zsCiI3KJ9iMFHdgQaAYNR3nef+
X-Gm-Gg: AR+sD121dzt8fYFwYHvAD9CPIC433iBXCpnt5O9elKVJSLuF0DA4rMuuJj+5tO57BnQ
	VqVnU6ny76LO/TozWRihVyR4m42US/C/94VpmjjsFe3BhRD9UJAKMVVitzXudiES88LB/8ODr2k
	RNoymz0gt4yuQc74dZIKYuWC3SWXiTZ8HCtE2LIwFDZtKIbTdKKacFirVl+RYvKV6g/2W6lEB6K
	3zcg0UON+Rh1GbADQ4PK02wJO0jNLFfIC95E6roYaIp9YmGopE01SBswEB82n6pGTd0zzoI8S0h
	pGWUh19LD103XKx6WtlH99KzbQ6CvD4lSVUsd/Pf79aZhWwB2voUIfo+WWbcgqSPpmXt6gHeV8S
	vjU4VKXeem+DWMdWDV0YewvBWmx/vGrXijgA5B9Z6Rmb5j0irzCk57new8fWV+P9i8mXUSiGfVK
	xqdyWB4sBfefHzv7ta75BKoYXc7snmBy93LOVD2M7LJKNgUFHHC5LyxAR+iZc22gng
X-Received: by 2002:a05:6a00:2ea5:b0:84f:3dc2:31c3 with SMTP id d2e1a72fcca58-84f47dd0b04mr11913332b3a.15.1786097523035;
        Fri, 07 Aug 2026 03:12:03 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a5528adsm797510b3a.45.2026.08.07.03.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:12:02 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Sandeep Patil <sspatil@android.com>,
	"Andrew F . Davis" <afd@ti.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v6 1/4] dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
Date: Fri,  7 Aug 2026 18:11:37 +0800
Message-Id: <20260807101140.1357218-2-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807101140.1357218-1-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com>
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

