Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998333B19DE
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253423; cv=none; b=TycePLyu9oDk2yDhUzslS4wNToiJ6NGH1zRENk+gI76pzaJuy5jS03LUYqOKvIlPvbGa4ko5te7ffLdiqvgka6VE+sGOzHuTWwY6OaliFy+oB4mTJ/V7wEHvri9AZWV0kHZ37JwDvjn6l7kw0JL3MtQpeW6/ZiB73Wb6WlY/58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253423; c=relaxed/simple;
	bh=W/mBxSG15ETKgXpBAMGW0xDEaozGO1kzb1T9IrZf+4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZHnlj+a0BUuDIrgARJ9hO6NdHPz0LlJ2T+EW/oteiFSWnnvNPMoudce9zjiS+zW+ujtAhDk6kFhJs/tF2M8toFp0OHHjKlZEgptsAyjn4kcaOCAF+dSLWuf0g0+s1ivncV4cVvD16NFIqrH326Y6EQBfkpCyayS0lTySZfoUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGl8s1sW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGl8s1sW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC071F000E9;
	Tue, 28 Jul 2026 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253422;
	bh=tWaAkymaFXazeaSHLxKqY4hy4dLxA2kQ51lwVswxr2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGl8s1sWSNIJPnjTUP8EOgBsEajhPPQulhgXwv3DpO61e+y29y8yNbYhybP/XcHhQ
	 ncspgQOsiolGcbpEiMRXbfOmeuudsr5PCV425SW0cnG0384+D5caj7b9XDh+xeeVyV
	 3ub3GKTuU8EdmcWhPq3ZpAjj+wzoBuUEIQfpqOBZt1Fw3r0gVvAQiPxksylFi6I2Yp
	 BeZcrUIk/CQfCEoAyddrJk6vieG0UtX9QdqjpcXpTjGIwuoPy0b/mdilxbjxltaV5s
	 wN+jx3CosCD5clsnwxXCEGrxZjXkGwSTAPPTb3k2BGYqqBH+bUrK3mLAbK6oVJGQZJ
	 Dj+KAxKySRi5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF
Date: Tue, 28 Jul 2026 11:43:39 -0400
Message-ID: <20260728154339.4192777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072017-lullaby-pancake-44fb@gregkh>
References: <2026072017-lullaby-pancake-44fb@gregkh>
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
index df662d07a5e9c7..2ff9974a47ed7f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -440,7 +440,7 @@ struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc)
 		return &rvu->pf[rvu_get_pf(pcifunc)];
 }
 
-static bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
 {
 	int pf, vf, nvfs;
 	u64 cfg;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 77a03e29a77116..34b2a16e88446b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -825,6 +825,7 @@ int rvu_get_pf(u16 pcifunc);
 struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf);
 bool is_block_implemented(struct rvu_hwinfo *hw, int blkaddr);
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc);
 bool is_pffunc_map_valid(struct rvu *rvu, u16 pcifunc, int blktype);
 int rvu_get_lf(struct rvu *rvu, struct rvu_block *block, u16 pcifunc, u16 slot);
 int rvu_lf_reset(struct rvu *rvu, struct rvu_block *block, int lf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 4a3370a40dd887..eee467c5bc89ce 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -178,6 +178,15 @@ int rvu_mbox_handler_lmtst_tbl_setup(struct rvu *rvu,
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

