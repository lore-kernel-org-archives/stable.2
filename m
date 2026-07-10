Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945C3FADF2
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681071; cv=none; b=Sth8gUA8LsP1mO1Xw8rRKDToaaWzPiLmD7Yw9NJoLrhaekn7SlFX/AczQOwlu1uZZ4GarH6VsfRIi1YxMnVf0mrz0vyhZLGxWVipRnx1q821fXAd//RlrRM8uFvU4/ie3i1AE1X0dqPtmmoynk4SYgxCg1nm/bGAHcCAA6Fow+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681071; c=relaxed/simple;
	bh=SNlYUPUJEUI2jvPRNYkLrIdw4DID2Mv+Qrs5YaZR2so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIuC+d2ZwRieyEgm2VU0dKMAb/e2H/lTC84fWCf3pK6PJgxvvAfmR7EHhDZ7ygYP49KfG/BW2wDb2NfxLqVPaoX3J+66f2jIlc0JX6NT6+/bbi1Xx14HleDgDSn0mMVxZAWi7TPETbmaIQAATyvmpI2nZcRgyou8I0piMWTPTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmrUQZWp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmrUQZWp"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cae1a3a744so5135325ad.3
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783681069; x=1784285869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PsFAzR3CSZqnZYplCGUu2npXvnWQSXy7x7Ru3MpsHV4=;
        b=OmrUQZWpk8UdPkDUeiTwvxXhBHGGIQmY26C9sb8g9mrl/BuZePSnvAmXk8mIU9RLWj
         O6lGOWgbDWR2KgZAEpdS1BE+YZtYVm49EkJc3iBQQCbp5/GWmZ529iiA+ALrMr8YYzMC
         OCKwv5idvx/tWuN9yES7GCIT2WONsFhkQHVBCVSDa//dYpn9n/z6yHF5w8IuzphgDtKx
         ym5Mgz8BYkCezz81pP7OsZuNOtl0CTUcQ322MRFV3MgXreW9nXMidnG2+TzvdLhUcVD8
         3t1cq17X3xr8TSie4oiYds8//aPV3SEXd6fmwGCZHM2cYLLw6vSuhpE0xeLvYu2i52AU
         XvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783681069; x=1784285869;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PsFAzR3CSZqnZYplCGUu2npXvnWQSXy7x7Ru3MpsHV4=;
        b=FsDKAl6zZinW/1eE/wOatsKi6FWqOvu5rS7WegzDm09jucwmF1KwuiT2b8rF03Uv2l
         J4cmn7P/KtzWe4/3lZnCNSKpLbWRU/tRt8ReiDWlEfmr8aK/3BY9TebN9+JrZmXR/nMI
         rPLRMDDqhMgCtEYQR6ZQjG0U4fUh5VQ9UIbkpciCiHYzqJxxLOHx1PD9v3nNNPKxPckd
         0dB8AYLsCDnOqbhRhyyxCMJViYc4i8NTA9Orcl1ygUkj1u1v2NNrLd0y86Oe8Kdo2IrQ
         b3vZaUHCfkLis03o9aRkocip9nzmzHiXyIrzZ3bzP+d7fBbBd+rYJ3l7zsvYiWvNTrrv
         xFXA==
X-Gm-Message-State: AOJu0YxXJft7/flrymFd9vk9jQ+rE58jy6hwITq2VF3KePbDIW/EsndU
	X2d+KNoDOk1U1hNggaUShjKo8ulmBHijpv3vxdI3CbU4QIu2X+t7usiu
X-Gm-Gg: AfdE7ckwAHDahtwqbBbJBGUfUVUk1R5Yl8j4+OWeITyentA4XqmwWJ9gPLYXmh53KFG
	87KfPsQsiP0JW5Sg5JJdmCaIvfZek46Glbe0e8dCByv7p+Ef75oWoDwkx0HiFoxRvh7XYDHHYeQ
	pEDucHzUfkDdYIDRwmTdg1sMMMaoe8eagA5syYr61pVcpndsXoppOJV/B68VXzpQGitRKj5pDfd
	TfS9PiB3uWjG12LpGVdj9h6AtpJKA0J1q6wxLH9LxANfgUig+pqPK0e0GDcADVuU5M51SweXjcv
	t/eIkbzJqHbjQOF4sVQgowpFjoFFIbCam77QD4aErpiaacmbybbfOT2QJq25OjiOzoxavqG34xh
	z26NTKpBIKyjPCVhXluJ2/G9seenyzKkWp+xnpzYd2Yn6jYP53T4QEaGOnz7WxFTj9k11Bnm9GF
	UsdOTIU9LaWukQZiHN
X-Received: by 2002:a17:903:2346:b0:2ca:f8ef:33dc with SMTP id d9443c01a7336-2ccea477e93mr109979655ad.40.1783681069120;
        Fri, 10 Jul 2026 03:57:49 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bdf5sm57922095ad.73.2026.07.10.03.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:57:48 -0700 (PDT)
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
Date: Fri, 10 Jul 2026 18:57:40 +0800
Message-Id: <20260710105740.3080070-1-shoubaineng@gmail.com>
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
 drivers/dma-buf/dma-heap.c | 80 +++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index a76bf3f8b071..0a9bf62eb06c 100644
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
+			fd_install(fd, dmabuf->file);
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
-- 
2.34.1

