Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D903387363
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947807; cv=none; b=i+xeJ6E8jjN/NTVquuxco/lIqa0kMRBoXI8ijGhAPN/3oIrWWDTagROkqs1P613nU2P2XziaGdEe3uvS0xnq6aAsux0LNdkWjLC4q0WU1LuZIUGqb9Cs7H7Pa1E8dyv88FXqZRxN3v/7wMXPUSayFKfq6K3Jc4MOydmTJ402gzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947807; c=relaxed/simple;
	bh=gJ6qO82cunFkHH/YI0cpZWB+99vzwtO076qzoKQb8zA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m4ipUXhT8a9th1gG0fWd7Mmyqo9M5BvGSBqqRe2D62FFgVErb+LF+K1nHTaMFFoui917NtWvHChHb8hgfkziD62xMPT5pbIwuRLZlSL2jYlTegKNQf5GFrSoP9O/TpQFZmVVR6wBQi7vch2jPEoN/PmEmkrr8VNjWRi7AUpjZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UINqabH2; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UINqabH2"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-517c65e497eso7381911cf.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780947804; x=1781552604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v1WPgK4XhrSsWKxtc0VlcZjNH1lHogrTgrVmSMDXRnU=;
        b=UINqabH2uO+66H5EoeRt+plG6DMjsyTLma14AVhprh1pyA297JvCWI6zIVAYwRqp5s
         mqt5sVB92TzNwynHeLDSVfso6RLK8+1xtlXIwUbvGhPycf2Ji/KpXSlr4GPs9azZnGdj
         pDMX8TwNgK/1FlRUEQa49mT2cIkU/a8RxgxYqTMq99IWEyw9JB8g6g04xs/LomfbzdXj
         I6wW7NIAPLAPcRRwypRphYAvH7XcWeJ9TWiE+zpP5Ulweo0Erhl3Fln8nidCZbAVo02o
         CGXEOtWQvAVyW8xSZfLNfsU+zDyG7ivFKZ4+pxoh8R3WqzGrT5LQcLccqmI5VGnYqA9b
         MeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947804; x=1781552604;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1WPgK4XhrSsWKxtc0VlcZjNH1lHogrTgrVmSMDXRnU=;
        b=g0HNh2Dz2Xi1peA7Qzpe9tiI71q2pf0p4lXTVlWpgjVdn8VRoCnmJ91R3r4WhAZpPG
         +qHN3fxF4iarEgbnxOTDoRVMLhH9XL3t30X9V0fFkKITBdQuEJzkYF5CqxB3ufC0sdOT
         N26uSHZiOZFc0N+kH6VrVabXD/+RqulyBIEVK29/FuYGLlpADG3xQr24O78umklKm/hE
         zJOK9GYBOsZ+E2Q0WFwVf4p826JZtyRLbuPzziczy2fr3/R7rIHXZtGJjvvv2S8ko7TL
         tInSD3noZFcO2wt1ZLYSG0z7MFtG/8h2NOzr8DySX0dMr6fVFZOnU0MJdQHlSUaLpj0c
         yRew==
X-Forwarded-Encrypted: i=1; AFNElJ8s835+Km2K/9l0mJWK73wIQ6gb3HeK+NHG7Af40yjmZZlSc67KrpWcapfh7hZwOEUVqhDQGBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmTllFJF4DRKuv20zj8xEgZgBlDNs/sKyRUgjys0zoBnbWQpv
	NY/QRbhUL1wD+IKwNHjQplIHTgZ4rdiRIVB+cUvkiyT4vb5FHEWwN6CO1/zrxKYUZ7AyILHrBvM
	KW9IGLXv0zgVk
X-Received: from qtss4-n2.prod.google.com ([2002:a05:622a:a9c4:20b0:517:85d0:ad3a])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5cd1:0:b0:516:df62:bde3 with SMTP id d75a77b69052e-51795c47f23mr242075611cf.54.1780947803937;
 Mon, 08 Jun 2026 12:43:23 -0700 (PDT)
Date: Mon,  8 Jun 2026 19:43:21 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260608194321.150838-1-xuehaohu@google.com>
Subject: [PATCH v6] dma-buf: Fix silent overflow for phys vec to sgt
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
by using `check_add_overflow()` for `nents` and using
`unsigned int` for the loop iterator in `fill_sg_entry` to match.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v6:
 - Used `check_add_overflow()` in `calc_sg_nents()` for safer
   accumulation (Leon).
 - Dropped explicit `!nents` check and added a comment noting that
   `sg_alloc_table` handles `nents == 0` (Leon).
 - Collected Reviewed-by from Kevin Tian.

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
 - Collected Reviewed-by from Pranjal Shrivastava.

 drivers/dma-buf/dma-buf-mapping.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..67a8ff52fb8f 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,12 +5,13 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/overflow.h>
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
 	unsigned int len, nents;
-	int i;
+	unsigned int i;
 
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
@@ -40,8 +41,11 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
-		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+		for (i = 0; i < nr_ranges; i++) {
+			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			if (check_add_overflow(nents, added, &nents))
+				return 0;
+		}
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
@@ -95,9 +99,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
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
@@ -133,6 +138,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+
+	/* sg_alloc_table will cleanly fail and return -EINVAL if nents == 0 */
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;
-- 
2.54.0.1064.gd145956f57-goog

