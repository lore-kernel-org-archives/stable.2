Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D015758F064
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067325; cv=none; b=czmwrqM8gTD10Y4bF5xZ6+1Yp1fk60vjgMhTzVjTeglRb59IrCEm07kEBoOQj/8AGithiQ841jhIsZi/e2O8BgsNzxI5w62lbIMMWUqKl2CmGKjeEpZtcewgZ7rmP9NQImgsXRa8O3AP1zZbyVSgeXzGyVZcFZeCG2CATK/+ze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067325; c=relaxed/simple;
	bh=lAjRy+GkK8+lly/vjtjqR/rGIKKDLT/ZzKASVthuCIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzBmM7K/DS+Ccd8I3mLQUylGiO42/w9nq7n0zvSUrKyV6hoyIaQTpSyb4TGL/RdEOD5JZXV+KyHV2kGV6JJwUpQaNUnSj9FQVYRqJoAmBHjgI7tt/rjUOe2K65YBcMrOdg+0MFfrjKB04owBgvDV1PXP2jPTXa/ixMlWGy27FT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSfAYIEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSfAYIEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF481F00893;
	Thu, 10 Sep 2026 19:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067323;
	bh=3k59yMIX/Rx77t+kYwSaPlRjEhgE/T+h0c68ZWee11E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iSfAYIEffh1g2y5qi8dficloz6NyY2J8ARpEZEW3CWWeoHPbeUCEUkLjFJTA4vZqV
	 MTzNC87ClVfSRZ1SBq4a7RwcGII3hCe6EOMjkzaO3k16Plo3BOtc7rOuzQfv/wJTm4
	 UWRAxSAan/HVwQqbDjVFJKJMS0O3/ia9ZYWiWYjvLSM5DDfu8c/2r3KWquxnzLiBf1
	 1ANb7fUykvZmddRg8V3sUYk6JQpVEOsn1k7HUpIfTYzG5TZoW9hDseykYaZsv+aVQ3
	 UGkrbvdMnLn2ka4/S9Su9laBQhBB6R/0WKLjdqTi9EWNGgG+jm2KcGgqz+lgmHvwyn
	 kOT1/apBs+VkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baineng Shou <shoubaineng@gmail.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
Date: Thu, 10 Sep 2026 15:08:40 -0400
Message-ID: <20260910190841.1453617-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090842-deluge-gloss-a643@gregkh>
References: <2026090842-deluge-gloss-a643@gregkh>
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

Stable dependency adaptation for 5.10:

Retain only the dma_buf_fd_install prerequisite needed by
a4a1a2bfcb29785292d634d7787edc6fb550714d (misc: fastrpc: don't publish fd
before copy_to_user() succeeds). The FastRPC target already applies cleanly
to this tree.

There is no DMA_BUF_TRACE/trace_dma_buf_fd infrastructure in 5.10, so map
dma_buf_fd_install(dmabuf, fd) directly to fd_install(fd, dmabuf->file)
with a header macro. Both arguments are evaluated once. This adds no
function or exported symbol; linux/file.h already supplies fd_install.

Drop the dma-buf.c helper and all dma-heap.c changes. The heap allocate
callback here returns an already installed fd, not a struct dma_buf *,
and the heap refactoring would require converting the heap drivers and
their callback interface. Those changes are unnecessary for the FastRPC
target. This dependency adaptation does not fix the separate heap ioctl
issue described above.

[ sashal: Reduced backport -- upstream 30d0aff2c65a2 touches 3 file(s), this
  backport carries 1. Not backported here:
  drivers/dma-buf/dma-buf.c
  drivers/dma-buf/dma-heap.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: a4a1a2bfcb29 ("misc: fastrpc: don't publish fd before copy_to_user() succeeds")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/dma-buf.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 957b398d30e5d..dd7b5f9f7fac2 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -487,6 +487,13 @@ void dma_buf_unpin(struct dma_buf_attachment *attach);
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
 
 int dma_buf_fd(struct dma_buf *dmabuf, int flags);
+
+/*
+ * Install a reserved fd only after all fallible work has succeeded.
+ * This kernel has no DMA-BUF fd tracepoint to emit.
+ */
+#define dma_buf_fd_install(dmabuf, fd) fd_install((fd), (dmabuf)->file)
+
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
 
-- 
2.53.0

