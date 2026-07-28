Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087C39CCE5
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258434; cv=none; b=qIiwnvD8w/1pMAdjJIEpBoMceRFz+TL1oCWaLmuUbkGNvrYY5xeeUBpHyyyjYmxMoIZeD0EGEULnoIztR2I+rDm7GywkA/kRjD5Gz26wkjxxF6rFWargWXkVUKXM/+YhJC3W1AE1EN0UKB460HwqeiZvfc0K/GSG2tmqH4It1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258434; c=relaxed/simple;
	bh=3jtcPkRza/4Exlmk5hSEcgY48TOjmgnozCTVUQlX6nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMvyoktI86aoo9Xyj2fS40D1XwLwRbAXd0RbPPrIZqlglq2rnqDpBAbwM1w6eGdyFDh9d7Az22jJIkQE9wc0lxW7DKo3T7TeoF6hBGMDBCsvkRYQy7Ck7W7bHBlBgnQ2KEkDDT9/+T7SYVh3iIBZqXyzJhyPJkz9tZEd5RGU/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIrf/Mah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIrf/Mah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE021F000E9;
	Tue, 28 Jul 2026 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258433;
	bh=lewkHitlRH4XPm9GrHuyrhpoz2oTVOfpBo8tdYLef14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LIrf/Mah2KABc3wDR/kkXhRfZfLSbzIofn8AJ0m1p5epY0SD/BrWbAbyfV6rD22Fv
	 3hhoT5lKeb4Z6nmbQF+oMsXmdbsalVbs+Sz/qM9q5txMLOaui4KVonyZAMz5Me0kvA
	 ydsSmfRa+mxVE7HV2V+xDnyyAC78kQ1maT0NKXm3GYI0FVlQh98xvR3hFz/Z+q0v2k
	 x71VgoBnZggRiheWD6/SAFIkjnOA/qIvH9fwZr0L4JYyER2mCLP0DZwOIkY3VbXnOm
	 QzgvmbhUip1f3RJWBsziTpVagR9R05CX1YRtWxvDB+x2kZkilSSIfh8W3MKC5BgNe6
	 tcqo96FGUobHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF
Date: Tue, 28 Jul 2026 13:07:11 -0400
Message-ID: <20260728170711.183670-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072019-delusion-tattling-6520@gregkh>
References: <2026072019-delusion-tattling-6520@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 8cdcf3d2caacdee7ddd363705fb4d93b0c1a0915 ]

rvu_mbox_handler_lmtst_tbl_setup() uses req->base_pcifunc as a direct
index into the LMT map table to read another function's LMTLINE
physical base address and copy it into the caller's own LMT map table
entry. The mailbox dispatcher authenticates req->hdr.pcifunc from the
IRQ source, but req->base_pcifunc is a separate payload field and is
not sanitized.

Reject the request with -EPERM when a VF caller's base_pcifunc is not a
valid function under its own PF. is_pf_func_valid() bounds the FUNC field
to the PF's configured VF count, keeping the computed index inside the
caller's own slot block.

Fixes: 893ae97214c3 ("octeontx2-af: cn10k: Support configurable LMTST regions")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB78811656934E713B77DA6CEDAFE62@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Dropped `rvu->pdev` argument from `rvu_get_pf()` calls and folded in the `is_pf_func_valid()` de-static plus its `rvu.h` declaration from commit 2156a29aecff. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c       | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h       | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 8c1ed8dd50787f..e00f7b71cb022d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -441,7 +441,7 @@ struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc)
 		return &rvu->pf[rvu_get_pf(pcifunc)];
 }
 
-static bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
 {
 	int pf, vf, nvfs;
 	u64 cfg;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 9ce7c78e512759..dbfcf751d0bc8f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -693,6 +693,7 @@ int rvu_get_pf(u16 pcifunc);
 struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf);
 bool is_block_implemented(struct rvu_hwinfo *hw, int blkaddr);
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc);
 bool is_pffunc_map_valid(struct rvu *rvu, u16 pcifunc, int blktype);
 int rvu_get_lf(struct rvu *rvu, struct rvu_block *block, u16 pcifunc, u16 slot);
 int rvu_lf_reset(struct rvu *rvu, struct rvu_block *block, int lf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 39870e419ccb04..0d3ee264e82372 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -175,6 +175,15 @@ int rvu_mbox_handler_lmtst_tbl_setup(struct rvu *rvu,
 	 * pcifunc (will be the one who is calling this mailbox).
 	 */
 	if (req->base_pcifunc) {
+		/* A VF is untrusted and must not redirect its LMTLINE to
+		 * another PF's region, so confine VF callers to their own PF.
+		 */
+		if (is_vf(req->hdr.pcifunc) &&
+		    (!is_pf_func_valid(rvu, req->base_pcifunc) ||
+		     rvu_get_pf(req->hdr.pcifunc) !=
+		     rvu_get_pf(req->base_pcifunc)))
+			return -EPERM;
+
 		/* Calculating the LMT table index equivalent to primary
 		 * pcifunc.
 		 */
-- 
2.53.0

