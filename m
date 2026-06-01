Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5338735A
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344018; cv=none; b=ch6WcXu9z6MVRrLmgXjy6iHYr+66tIiNOizHPHToSGg94pXhHZ0CDfsdEg5DUSUjJd0sjnONFab6COfGoUKA7ECQiWy0STfyYzBi3PvGzHG/qnc/Kud1pAOgv8cYy3qVukCWZB749/zpPVd36eacRDWhHz19yf0XyQ5yGvHzNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344018; c=relaxed/simple;
	bh=oyRMYCBipJFGfyqAL11a48wj6WtAhuqVNSVZiDf1eLI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BBk3r6eHtTuI8tD6/Czn1f7PySDCsh1ZhW0/ek9Z2JhRBMigjSoOViLuCMHWyov27ScNKC0Osp329aRzz9PY9EOBfl2GfTMTNjILBXt1YFq24kwboWtqM3VPmL9bWHxKjZIjLGLdJN6JBW5R9tYLo/dovbNe85Yt4FWAKefRMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDHDznwi; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDHDznwi"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-9157a31ac37so8647285a.2
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780344016; x=1780948816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msbNDh9TiShw7R12hj6rcfm+XGYU44qZJxoBlWEONAk=;
        b=CDHDznwiq0j6K9sq4AIkVFeqNLP5QqSrI8nemAd0XRksZoinE7W/mpWiRtYVqLbj/k
         TuRjevMST1wvtW6iCud8yua2kqBWGXO2NhMoqLnsY6bkkixnwAqz4Betcy0MeFhMrB1W
         ECVpL31TqN6fQaeYsIpYlhADCi06obFO7PeKH2uy37KszFpb5+eZ826dmcClQoIVM7Ao
         6lxm5yTxcupeFAQI3oL87LfCttljq0kIzJxMtc99uKuJEd55fSITjG/MOrNTYPBDXapM
         dvPDrPmhHa0OSaMd8ZTbNkYzZBiIYURNspyEAuUgYfW9/tLuXs49PGEmDfBRJ8lTc5Rl
         FaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780344016; x=1780948816;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msbNDh9TiShw7R12hj6rcfm+XGYU44qZJxoBlWEONAk=;
        b=aVZikao5Lx9g5QDks+FmIx1L9zy/rUe4ql9i9lvXStWxxpo+SOxJDriXVs/dCjz9Ix
         5PNHBX0cxG2a9vLBfpDkjH78pjxDXKUDpeRMc+cKSvCe8gHsGrqIF6G4kBNzQmkkF62/
         bzz686vCjLc3ikp6DRcR0mcFy2uEbaVicarBVoyN5f6CnDMypZbQftuQGZuUGawPi31A
         inrLqMwx0JcHBhs6CgoMz5ASKNPoj5ghHRcaRKXiHnsufJla3LtmL87TYOtQC67h6W7+
         DgZuuxhV89v7XADQlfrqys7gaJgy8hECEjFiJj02HNqaBVJdZfg9g4BCtTCg+dRU9emS
         5lVA==
X-Forwarded-Encrypted: i=1; AFNElJ/mGMV274pP6wuVQhonWPF76aqsSc4zTVnzvhdK9WNo+2JYGCm7f5QN7tCGrtLFJOy6kD5xuAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGW10w/B791QCopPj/ZUQhcauYJVcWhkHRrpEo9PBbes2FvS+N
	kSCqeRMGmLZAW84scWMcFWzxJUecePZjXS61AzwiqTzxmfzHVePsSNi7BhYDWzZLjOSttkk07mR
	TeQ5/D1w+dztF
X-Received: from qknxz25.prod.google.com ([2002:a05:620a:5e19:b0:910:b90:6ec6])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4612:b0:915:5930:94f1 with SMTP id af79cd13be357-91559309603mr1224141185a.47.1780344015096;
 Mon, 01 Jun 2026 13:00:15 -0700 (PDT)
Date: Mon,  1 Jun 2026 20:00:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260601200012.3872274-1-xuehaohu@google.com>
Subject: [PATCH v5] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, David Hu <xuehaohu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In case MMIO size is bigger than 4G and peer2peer DMA goes
through host bridge, we trigger a code path that assigns the
total linked IOVA (which is greater than 4G) to mapped_len.

Previously, `mapped_len` was declared as 32-bit `unsigned int`.
When accumulating `size_t` lengths, this leads to a silent wrap-around.
This truncation causes truncated lengths to be passed to functions
like `fill_sg_entry()`.

Fix this by changing `mapped_len` to `size_t` (64-bit). While
at it, fix similar potential overflow issues in `calc_sg_nents`
by using `size_t` for `nents` and checking against `UINT_MAX`
and using `unsigned int` for the loop iterator in `fill_sg_entry`
to match.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v5:
 - Removed WARN_ON_ONCE from calc_sg_nents() to avoid log noise (Jason).
 - Added explicit check for `!nents` in dma_buf_phys_vec_to_sgt() to
   cleanly return -EINVAL on overflow (Jason).

Changes in v4:
 - Added WARN_ON_ONCE() to the nents overflow check to prevent silent
   failures (Claude Bot).

Changes in v3:
 - Removed leftover sentence fragment from the commit message.
 - Kept `nents = 0` initialization (previously stated as removed in the
   v2 changelog) as it is strictly required for the `+=` accumulation
   loop in `calc_sg_nents()`.

Changes in v2:
 - Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
 - Added Reverse Xmas tree formatting (Pranjal).
 - Folded in extra bounds checking for calc_sg_nents() (Pranjal).
 - Folded in type consistency fix for fill_sg_entry() (Pranjal).

 drivers/dma-buf/dma-buf-mapping.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..607b7998463d 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
 	unsigned int len, nents;
-	int i;
+	unsigned int i;
 
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
@@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 				  struct phys_vec *phys_vec, size_t nr_ranges,
 				  size_t size)
 {
-	unsigned int nents = 0;
+	size_t nents = 0;
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
@@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 		nents = DIV_ROUND_UP(size, UINT_MAX);
 	}
 
+	if (nents > UINT_MAX)
+		return 0;
+
 	return nents;
 }
 
@@ -95,9 +98,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 					 size_t nr_ranges, size_t size,
 					 enum dma_data_direction dir)
 {
-	unsigned int nents, mapped_len = 0;
 	struct dma_buf_dma *dma;
 	struct scatterlist *sgl;
+	size_t mapped_len = 0;
+	unsigned int nents;
 	dma_addr_t addr;
 	size_t i;
 	int ret;
@@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+	if (!nents) {
+		ret = -EINVAL;
+		goto err_free_state;
+	}
+
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;
-- 
2.54.0.929.g9b7fa37559-goog

