Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFC38BF75
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558954; cv=none; b=nMlGst30KydUXWA84NG6VJhCnrjJN/3KaTxFGmfSPncy1EjUTA7a8GVk50ysKHsR4lx/4cg1ZAnSJTiDTHiXsFIM8M4T+iHYwCUEJcqYbqHbTSHrsFdhq6AwctWyWKoOBLiu/O3ZpjrTPZHBofkq1iBpzeQ40EI4R9o+kQ0F8zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558954; c=relaxed/simple;
	bh=1JKrmjf7fPdQ3viG2ZM7U0knx0ZDMAgdtttN6vJirwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8gwO1qJ8DjYSr+TIJGcONySiTT4yM5a15XkvmTYQomEwhLSSLhoNSERB5TK4s/qUF4OdLlRPDD1s/GocajVb1lCcht3aJIuzGaWdv5L7P+j8bvvdjpu84EdungGg+AxHlBD0dNx+eGoeRvJdonMNuxeMVlNAkj7XW7wrNVnb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fshQ14mN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fshQ14mN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F56A1F00A3D;
	Mon, 15 Jun 2026 21:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558952;
	bh=piBfKzqz6iwFbEkNY0vkoSqRLKP1mD/h90Z608UmbAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fshQ14mNTrjTy+9WGiGCDXG/Wwap75ZEIyZTW5WXbO99yXGYzQBWFBLiP4g1G0QAu
	 liRgYn/k0Alf5wJOlkjgwAtki7c5BYz32jMHwhAnqVJKjxl86/6RFqKhSU8HEMgzEo
	 qqitwCm5B2fiEuPXUpLQc1wUVaOKIiAMOptLKXw+/d04kVgSoiDo/rV/q+8lv+qomW
	 SkExlK1bw37nR/vI4TWy4YYanRisfj3VdTcpY2ZgPR0rRijHZJkJ/IHCetaR0GG7bl
	 M9xvvZEkIP6cSRLFO5eS7L6Bs/2tyeYz4k75iuo0ZF3xYF2qRzfoQcGvVI8/OzcgaO
	 3TX6++Uow1wkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock helper
Date: Mon, 15 Jun 2026 17:29:07 -0400
Message-ID: <20260615212910.2473729-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061551-manor-verbalize-74cb@gregkh>
References: <2026061551-manor-verbalize-74cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 553dfa8cbd0c6d36adae042d9738ddf8f8765ac7 ]

Move the inner logic of ib_umem_dmabuf_get_pinned_with_dma_device()
to a new static function that returns with the lock held upon success.

The intent is to allow reuse for the future get_pinned_revocable_and_lock
function.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260305170826.3803155-2-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: badad6fad60d ("RDMA: During rereg_mr ensure that REREG_ACCESS is compatible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/umem_dmabuf.c | 35 ++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 44bb7449738cf4..acb0922a786131 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -198,18 +198,19 @@ static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
 	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
 };
 
-struct ib_umem_dmabuf *
-ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
-					  struct device *dma_device,
-					  unsigned long offset, size_t size,
-					  int fd, int access)
+static struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_and_lock(struct ib_device *device,
+				   struct device *dma_device,
+				   unsigned long offset,
+				   size_t size, int fd, int access,
+				   const struct dma_buf_attach_ops *ops)
 {
 	struct ib_umem_dmabuf *umem_dmabuf;
 	int err;
 
-	umem_dmabuf = ib_umem_dmabuf_get_with_dma_device(device, dma_device, offset,
-							 size, fd, access,
-							 &ib_umem_dmabuf_attach_pinned_ops);
+	umem_dmabuf =
+		ib_umem_dmabuf_get_with_dma_device(device, dma_device, offset,
+						   size, fd, access, ops);
 	if (IS_ERR(umem_dmabuf))
 		return umem_dmabuf;
 
@@ -222,7 +223,6 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
 	if (err)
 		goto err_release;
-	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 
 	return umem_dmabuf;
 
@@ -231,6 +231,23 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 	ib_umem_release(&umem_dmabuf->umem);
 	return ERR_PTR(err);
 }
+
+struct ib_umem_dmabuf *
+ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
+					  struct device *dma_device,
+					  unsigned long offset, size_t size,
+					  int fd, int access)
+{
+	struct ib_umem_dmabuf *umem_dmabuf =
+		ib_umem_dmabuf_get_pinned_and_lock(device, dma_device, offset,
+						   size, fd, access,
+						   &ib_umem_dmabuf_attach_pinned_ops);
+	if (IS_ERR(umem_dmabuf))
+		return umem_dmabuf;
+
+	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
+	return umem_dmabuf;
+}
 EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned_with_dma_device);
 
 struct ib_umem_dmabuf *ib_umem_dmabuf_get_pinned(struct ib_device *device,
-- 
2.53.0

