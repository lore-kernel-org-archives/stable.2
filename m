Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366138F934
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558954; cv=none; b=HubngjWtzhffsohz2TAWq92O4XnERaT8YeiPDcvaNW72pKc5XerzAqG68UuxbNhGOM0fr4RBkT6mACz48/DXG3WicKTXUS1PEbEf9EYLs9M0zZLO5C48ybuFgGDUlC7ngK/vFEE3hlhExiJZBoWfm5W54jm3rnvHbEXTjZgamc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558954; c=relaxed/simple;
	bh=9hV0XGQ+G1fg3arV97mFJRsZ0HSfb/nbSiYs29LwVU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hF/GbpRNExZ/GtQA4bz69LA1sSaEKkScOFwlnorVlw7sTniqSQhQxaw8SSmnf1IR4gAHDTD7BD8b7GWlrSI8AFgJn8djXDcBg97X22+OvfhyRcPJ+1z5GNIe05Kdk4MrbOh1Q7fBOZDUv62fmEzwRFVg/CxafCRPEKcmkM8rVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY7QZ1dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY7QZ1dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097B41F000E9;
	Mon, 15 Jun 2026 21:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558953;
	bh=g2Fdl4K7J+hXWQqq0+FgsD/6uQAvINwJ5xdytovGxoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lY7QZ1dp24By6zQk4ftDmPW4iflxoLd8m5vq2OsanV9jH8PX+0JYFgm7C3LROmsho
	 SYYpIOwuOkWBBNuvrGTuFdah/PBtdnmM+sT2INM87ggBM+J6vvAzlzEkOnjiW+LWph
	 PeoJbE9AftlQahGUCwnCPse1SndJc5yqJBfFy6m8PJdbtVsbSaD5MZuDfaizgkAYAL
	 shVlZvKrzfNWo0t9X15KeE4jpl7RSQjQ6etFvimlJHhPLaEW2gE8Qxex//4cNEkq8g
	 cTSKu0YsuESgmsmfbBW8NVZQvSX7vUHq+6kbz3qNYbJF6VwJnlSW2hBFqYYytX9Zh3
	 89XcmJ6cFWScA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] RDMA/umem: Move umem dmabuf revoke logic into helper function
Date: Mon, 15 Jun 2026 17:29:08 -0400
Message-ID: <20260615212910.2473729-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615212910.2473729-1-sashal@kernel.org>
References: <2026061551-manor-verbalize-74cb@gregkh>
 <20260615212910.2473729-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 797291a66ce346c96114b72222fc290d402da005 ]

This same logic will eventually be reused from within the
invalidate_mappings callback which already has the dma_resv_lock
held, so break it out into a separate function so it can be reused.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260305170826.3803155-3-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: badad6fad60d ("RDMA: During rereg_mr ensure that REREG_ACCESS is compatible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/umem_dmabuf.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index acb0922a786131..be5977daafa1de 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -198,6 +198,22 @@ static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
 	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
 };
 
+static void ib_umem_dmabuf_revoke_locked(struct dma_buf_attachment *attach)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
+
+	dma_resv_assert_held(attach->dmabuf->resv);
+
+	if (umem_dmabuf->revoked)
+		return;
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+	if (umem_dmabuf->pinned) {
+		dma_buf_unpin(umem_dmabuf->attach);
+		umem_dmabuf->pinned = 0;
+	}
+	umem_dmabuf->revoked = 1;
+}
+
 static struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_and_lock(struct ib_device *device,
 				   struct device *dma_device,
@@ -265,15 +281,7 @@ void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf)
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
 
 	dma_resv_lock(dmabuf->resv, NULL);
-	if (umem_dmabuf->revoked)
-		goto end;
-	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
-	if (umem_dmabuf->pinned) {
-		dma_buf_unpin(umem_dmabuf->attach);
-		umem_dmabuf->pinned = 0;
-	}
-	umem_dmabuf->revoked = 1;
-end:
+	ib_umem_dmabuf_revoke_locked(umem_dmabuf->attach);
 	dma_resv_unlock(dmabuf->resv);
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_revoke);
-- 
2.53.0

