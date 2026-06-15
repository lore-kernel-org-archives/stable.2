Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BEC2F7EE5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558179; cv=none; b=oip5hWCql0j4vPmph8AS2KRWFhwvxxIoiE/PiER9gNOQaUqAYPOF6in3egZe/R1mw4fDxgoN+uxFYfAWqR4FXDZRkSJ/gZzuLPKANjAb6kb2pkMNhbf0yu/TPrnmFEd1Dq8J8SWcZKipgumkQ7K9itmWNvsIP5zF3QT5LMmAMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558179; c=relaxed/simple;
	bh=yJGWcQ6IELS1y9y7+HZXl0+l1lwaC+8QZa7LIgtdf3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFOftHfI2XR3yCzpyGgzapS0tzF1adKl3xfB+jyqkLobhi+IwUph6gKttFBMhB6XoYkRQKGhxQO/jXwYt3rUi3ps0j7zL7Jo5JqYzdPfMZCmg5Iwom2rd+QE+4Iufq99f+DrGIAt+H1uAimolEid/JX+xg3+82+5L6oqa78QcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auBaBFpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auBaBFpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73551F000E9;
	Mon, 15 Jun 2026 21:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558178;
	bh=CNhagq5u5ewT+yAUnuEis//mLMud3uPz6O1z/1OWULE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=auBaBFpxrfbcxyR5EhPP7HxYFHL/TEfRqK3ytNFSTaJMb/NcqB5RJFGtGAM/XlruF
	 hnC6AJS1E/Xk/8iC7ISb0SjsXWliIKmJXIqE9AHajEsyRWWbRNhcbWqKd6XSC5j5U+
	 7te56HiLrzFosntiAA5sQbR1rYo87uCJu5RRlNATab0jOIViQ7kGKViAwIgp3xOueY
	 iR27V/OOmkJmrQEJ9PLOoq6V3g6wtT9Lc9cBfXlLzGNzw+xNaM5wv5NSvZ6dHn+Myc
	 h0OY+h5FqeayHCN9eLsktp+8/FYyLB91BLCtzQNMCcwZQogSL8vbziccXZftKXkvhL
	 oBA8WIJz1u53g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock helper
Date: Mon, 15 Jun 2026 17:16:13 -0400
Message-ID: <20260615211616.2460210-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061550-repaying-riddance-1fc6@gregkh>
References: <2026061550-repaying-riddance-1fc6@gregkh>
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
index 17b16fe0e49d94..09ab54950e2fac 100644
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

