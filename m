Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9C483811
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282560; cv=none; b=kd4w+dopORBZg092318xv5picN1+NviGSZQ58Isn95L0dfThyBuGysIgs75PMyQJ8Xqgvu6YO3GlFImMW0oXilPkE5i+3zOH2FzWykIRhpSDP89dgUYDrFeiD7+eQqVtlLRlkiwzRyy1k21bASx/fy3JthNBeoKp5L/jBCjJ79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282560; c=relaxed/simple;
	bh=eMYBy3+ZGvIA2q+GBQf+ypcxSsYooXlDBhWmvVgQbzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLZxvgVHU9gE6wDSDUA3FJBtZ0KTRQB48i9jPfcKaaS5FdVBnQdJqibglVNAxuH2CiOxNJUdpe2kqdngEzMPOqeVddVvgvEKzDEaVKRPXGkOBwjSkB7CAfErQ5egYkG9ISLoG/tTsNPjVf7meESNkxtZvpMfAvSpMFbyA5J/MDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co; spf=pass smtp.mailfrom=x6u.co; dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b=R5ladlPa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x6u.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b="R5ladlPa"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-865bdc6ed72so3271457b3.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x6u.co; s=google; t=1788282558; x=1788887358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbWwW5sIPuPDCzD8yPpWzav/RwZMe+wNYupbv2vHzg4=;
        b=R5ladlPaVjKn/CzSa9QpM3vsU13PagmbWYzoNP4pMZe7Q/tc3aBojgIhmPO9FVdc4a
         HBydGnoe2BAxxmCcvQgFJHVdLnX527j1BqKP6e0VBy+/oQMAi+qiKh7wZwudFuwsOuNI
         kreDHgdjHyyeUX5+iKr/CL9VBXzFxVIGFoLfjpjgXkPVshLwUdXkqaSHMp/XkwH4mb9x
         DsdcTfQFGdW3kA+089vSvRMOKA1gfX28BUJizpEbpjKyV5EoDC8uYNpOzpArStugFfux
         /SHKwIPdsoIqWBao2/G9MWcLcGlDd3I0gkxsc6IkZ/+9DqN4Vm/G1l0RyOzkfUbe8XdV
         1Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282558; x=1788887358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbWwW5sIPuPDCzD8yPpWzav/RwZMe+wNYupbv2vHzg4=;
        b=VH4CxP/+XGll9D9nhdNBEetZxMbSiueF9msJFNRgYs4RgV9u+qZncUYLYTed72KnwG
         5L2X8vDqdE1tW0zOFRZ7XsAxVhB0ZeUzQtdLdQr0qBsR1OkVTpV89TcjRU90ZgeJwuJe
         OHgR0rAmTLnByVGJYo3/qZ1UobqBSZ9BreWZ44ugSfexzA+jFMPnlhIN6re6qJM5oYI+
         lQ4uObXRvy5rF0hDvVtVaYKd7PzyBFh0bRotP/fkYIZ20/HDTOcigyLm4Tvg0MqxHlID
         m1p/TREpo2YfP9EnqX6rPL5tkUCwMFScvY7X+WsnoVS0bPofwg1QtmetjIyUKHuhh2++
         DTZQ==
X-Forwarded-Encrypted: i=1; AKwUvByHSQWArxI+3+PnuA5kmxImtJz8zLLrdi5QbVnElkxZUgXRPmjiF7RwxHoYe5npcfwspxmvJNY=@vger.kernel.org
X-Gm-Message-State: AFuF++mTOFDoBSyWqccvUlHzMPEl2acL3fwz0Qd9VsMS8w5Pnhdo5gCb
	Pqfx05B4yerXPDG+KTN/Lf2Psd2VWo46Obd8omgTnsRonGa4c0nIDKIpPjBRVtFQCarG
X-Gm-Gg: AYBFou3vzqrsq1spVx4ZeWlUjvWbrhuCt7eQGB8J1AW9vjIFbE1h/YJQQeAYWImqC6S
	YOUepfbtIAbCud5fEluVodZjrXZTYYLyhJooSQrxcuvpiP3Vo6SYACO2XgY17oDzht63PgLfy7W
	0pDS4pZcZRZUxCkEmjFHiuS+7GmoU2X/EBeoLjLL8iQDT8L4FF4I2RrRTCpiUOkns+xkFuMBmUq
	ljw1wnr1Rw9ZPDp/3Njnm+ehdm/oUv6du59OYWF8Y4NAy6c5/vfhvSIYmyyeKmlpc2B2Zv5MIUW
	KpCpfaTfGuYt2C7wU1cr2Mf1meN6Vy8GRWQ+b4UJ3ZNj7ZXmPAX/d074x+Jesud0hY31ym3h6rX
	bdJEyGcbV9n7I6Gw5I15UhA8L8h0Mj9L3dRu5Mt5UKAjOlgsjzKF4ZlqbIVTe7pgiGO+/dJF3Bi
	f55GQZ3DIXh9w+jZR95kQBFi5q1uuNTHJzaaPXOyhjc+0AxGAm4DlB3utmysF+s+kXCZnmR6Xzh
	4O1igjukKIsLjwtjnXnRjXluR+/1fo3H8aybgEnujgFoDzivhFZ3ZxzQrPnjBB9PpTHPxX+4Xze
	4g==
X-Received: by 2002:a05:690c:a7c2:b0:854:74e:ad6b with SMTP id 00721157ae682-8686ff0ecabmr35913247b3.15.1788282557505;
        Tue, 01 Sep 2026 10:09:17 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e65f146edsm79761867b3.32.2026.09.01.10.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:09:17 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: alex@shazbot.org,
	ankita@nvidia.com,
	chriscli@google.com,
	david.laight.linux@gmail.com,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	jmoroni@google.com,
	kevin.tian@intel.com,
	kpberry@google.com,
	leon@kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	nicolinc@nvidia.com,
	praan@google.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	viursachi@google.com,
	xuehaohu@google.com
Subject: [PATCH v8 1/2] dma-buf: Fix silent overflow for phys vec to sgt
Date: Tue,  1 Sep 2026 17:08:48 +0000
Message-ID: <20260901170849.4052816-2-dhu@x6u.co>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
In-Reply-To: <20260901170849.4052816-1-dhu@x6u.co>
References: <20260901170849.4052816-1-dhu@x6u.co>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hu <xuehaohu@google.com>

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
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v7:
 - Added a missing blank line after local variable declaration in
   `calc_sg_nents()` (Leon).
 - Collected Reviewed-by from Leon Romanovsky.

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

 drivers/dma-buf/dma-buf-mapping.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..80f6ab2f4809 100644
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
@@ -40,8 +41,12 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
-		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+		for (i = 0; i < nr_ranges; i++) {
+			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+
+			if (check_add_overflow(nents, added, &nents))
+				return 0;
+		}
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
@@ -95,9 +100,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
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
@@ -133,6 +139,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+
+	/* sg_alloc_table will cleanly fail and return -EINVAL if nents == 0 */
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;
-- 
2.55.0.897.gb25b4bd76c-goog

