Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181790;
	b=nHajTixMw70zfhUOvE1sHC0oh7lda+uaY0LGmZ2M0LsWc5UJRnkjDMEiyZCgmt0PX8Rw
	 7ViLhu+zPsd9N5bpHVV5K0Q8HvEgR3Zu6Kv2wgWuOlqXyYs2QJvDYPOcRARSd34iToshC
	 mRS0KCINVFGC9QSRRwfJzKxt5m2+HWhSlj7IaJf8caAp3puRjOQAyHUJ8IPE7P9N4tuK2
	 QP/ZRrwflQNCYyrtJMwwjrJ4sWsCqa7P4ntELm569cYfX5W+F+AMs4q/2h3pWISrdMBnj
	 Fn3Nr3fiDjcQWbw7FEQrSpqgh4R/4pEH7PJ3DHiDLvS70k3y567L8/v+4dsYRye+DEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=g2nfNoHKtlD4mhlL1Yw0iPJLjruMz9pBLydXH0Gv9Rg=;
	b=4mUkmHCEg/xePh9n8aazjpnU5hck7H/PLad86dh/NVs3xi9kSALstrwMMM/N88q2Z8iu
	 X8QAjTJvC2vCi3HwcJXaDj4CFNg6Ul/UObSo6gnjzPdKDaeDeoRui0I2UCAU4DFaPLjBg
	 yUuMh/L7VjyhHfybRb5O4DYa9BvHWtUKKhN9ggMWh+Cy/T5BNqngt7oBwa17xBMGhsTYU
	 9sJcR8bazoPO0AwnVk6e1uudT/VNGebPfMXwML8CGjF9XvOKayvJHFCuVTz39yNLJsblD
	 yAXof7lCsZpM61vY/lsvNuU88BBU6u9xfysZVU+FKMLczzIakvSneoosyVbIeucracw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UiTM0hsu;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239EF606A332
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 23:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239EF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UiTM0hsu
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a71d0c4233so121767fac.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 15:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794181789; x=1794786589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g2nfNoHKtlD4mhlL1Yw0iPJLjruMz9pBLydXH0Gv9Rg=;
        b=UiTM0hsulXcCxCo6asD3MHWcaqFz0any3chKiSrpCnK9k1VaFW6O9BeYEeksbGA6Aw
         lb6yAONV1yRzRDwcdWb9DpIjMgCIbA1svI5Hhcyk6xBqj2fNVOzlhQvg8Wb3utCtsVN/
         QBwXByMLZhdPb8yxxHReefMLa7tqzlduhZcM34TyBzGRe2Sr+zCWdppi83txZmkx28Ic
         cOELcV+jVkUr3iNkhLxUUd0WKzW2ySUkbERTFJB3Vn2WKPtnludyHI+A0l9iXpo33QE8
         q0Hvor09q23MFjwbHykOjvoQtHTf7bfWp4Nb+qE9A/GeO1EYiGdUV/+UlVhbxHgQ35vl
         gW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794181789; x=1794786589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2nfNoHKtlD4mhlL1Yw0iPJLjruMz9pBLydXH0Gv9Rg=;
        b=igwP52awoImvoFiR2N9H5wpJ/8rMHRzIYt5g9Ngf5I7T+dAAX1bo3vdnEZo+BE/w3w
         6uzSd/PriJsuUEluHx7ToLvSNu/r828vgBxQ6Sdfk4CVI59Qt4aZVp7HQAUFEyek+yb4
         c9ftvzoaOZDNH7a8uBTOItUR9rgVPm087VsjRbZdf1RfKoaUIfCEwi5iDFySb1r14ctq
         IJYxW09AYuoei9FIQHT3H+WIF3mA3U137RXth0vWQWBF6D+vT/FXoEYn57+9v/uVuhhU
         LqSzAy8Y50qMsO8QwV7N2VkK1RBUzg6vdPPmh3RqBZSoqO7MtaRzxKdtcXmWKM2V9lyb
         aEPg==
X-Forwarded-Encrypted: i=1; AL+hErFTfCZ0KBFvCdjuq4OInAwJgDCJD4DrCINtLIA0wgbUC8ejuGflZf1JTufckfkHVOrNoZURhzE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+7qZTE3956bEV361PKf3pT213IVs4EpEQSkeEjxHxp/zSgAzr
	g5Mt/q1nOXmWfW2aPooi1WijTl7McXZTlzykVpYvCchudD1RlEBgkLj2
X-Gm-Gg: AYBFou15bkma3L8ubLM2cD4FUfdlfSSbzQqAgMLuzZS294DsPGwYsxPOt/p/WJ3P4Fo
	LAtIclon2F0mPQGnmVHxEVs8euzSrNDGWbs6UX9Eq4MT5L1kjcOj2rXKDGzC6F11Bd5cY9NTnP6
	PpK8Z4UiEfn9Liv3Zcd1GYPf3+YMbaoELE86LlxIc4Ru+Flhos4MwPEPn5Iufrrj1arFLPBDUcH
	FqRFdPCuoT8I01HJsgu2QPzsQTkXdhE6UYOAvUcd2/nJdW4OfF+oOBKItSexJLdnzGt7uEF3v10
	/J2+hBO6wlv2Zd8vpmPAVqiI+0GlK/rVJaf9tJLR58jP8PTG07xJmTJ9cWpVCHntTgH1MiRJod0
	IVUjm1bCPgySRBRi8tOdmOGMNds/Mv9D8zQPIM3cYd8aL9MXC3c7XTDyn1CrzNFziDDM8wrpxjv
	KOmUJMsmnaU51/NPebEDG5hbPtCuZTkjImrnvlHBrPQovgsZ1AgIWu0cM7Rcg84cn7Nx71csKJ9
	+Nngd5Jzm7qCwV5PfFhwqMqS8nU7TAjtlJgnthNowfGG07TPi5uHV7pvU7+UEMocPT5imlvAj1R
	ht8jWMfdLXwSx34acFLJz3yYbLtJ2DgUwja5JtQVuEjpsgzquZe0rhBP2KVdVAWHyOO++E3bnjB
	minqFrMnEqkKWP5rfigHYBRVhEbyyxezDJZtbmj9pfwD5Qt9iz/XjPT5+gBuNO62vtKM6AQrjCS
	hEjZ6Ov2pqj1Hzu7rSnSeosuxHII7NcypAGrjrOaNLgrjdg0aJJ0fN
X-Received: by 2002:a05:6808:3096:b0:4bb:ac05:9ebf with SMTP id 5614622812f47-5681431e1dfmr2132113b6e.14.1794181789040;
        Sun, 08 Nov 2026 15:49:49 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813ac6352sm3019435b6e.1.2026.11.08.15.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:49:48 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 16:49:15 -0700
Subject: [PATCH v2 4/4] mtdchar: finish OOB transfers after the data runs
 out
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-submit-mtdchar-page-chunking-v1-v2-4-838cf8934ba6@gmail.com>
References: <20261108-submit-mtdchar-page-chunking-v1-v2-0-838cf8934ba6@gmail.com>
In-Reply-To: <20261108-submit-mtdchar-page-chunking-v1-v2-0-838cf8934ba6@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

A combined request can consume all of its data while OOB still needs
another buffer-sized chunk. The ioctl loop then stops because the user
data pointer remains non-NULL. MEMREAD reports a short OOB count and
MEMWRITE can return success without programming the remaining OOB.

Continue until both streams are exhausted. Limit combined operations to
the pages covered by their data and pass a NULL data buffer for the
remaining OOB-only operations. Advance past the pages visited by either
stream, including a final partial data page. Limit OOB-only writes to one
page, as required by the raw NAND write interface.

Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE ioctl")
Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdchar.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 85e98905f732..cbbc258109f5 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -613,6 +613,20 @@ static int mtdchar_adjust_io_lengths(struct mtd_info *mtd, uint64_t start,
 	return 0;
 }
 
+static u64 mtdchar_next_offset(struct mtd_info *mtd, u64 start,
+			       struct mtd_oob_ops *ops)
+{
+	u64 next = start + ops->retlen;
+	u64 pages;
+
+	if (!ops->oobretlen)
+		return next;
+
+	pages = DIV_ROUND_UP_ULL(ops->oobretlen, mtd_oobavail(mtd, ops));
+	return max(next, start - mtd_mod_by_ws(start, mtd) +
+		   pages * mtd->writesize);
+}
+
 static noinline_for_stack int
 mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 {
@@ -662,12 +676,12 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 		}
 	}
 
-	while (req.len > 0 || (!usr_data && req.ooblen > 0)) {
+	while (req.len > 0 || req.ooblen > 0) {
 		struct mtd_oob_ops ops = {
 			.mode = req.mode,
 			.len = min_t(size_t, req.len, datbuf_len),
 			.ooblen = min_t(size_t, req.ooblen, oobbuf_len),
-			.datbuf = datbuf,
+			.datbuf = req.len ? datbuf : NULL,
 			.oobbuf = oobbuf,
 		};
 
@@ -684,6 +698,10 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 		if (ret)
 			break;
 
+		/* Raw NAND accepts only one page per OOB-only write. */
+		if (!ops.len)
+			ops.ooblen = min_t(size_t, ops.ooblen, mtd_oobavail(mtd, &ops));
+
 		/*
 		 * For writes which are not OOB-only, adjust the amount of OOB
 		 * data written according to the number of data pages written.
@@ -703,11 +721,7 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 		if (ret)
 			break;
 
-		if (usr_data)
-			req.start += ops.retlen;
-		else
-			req.start += (u64)(ops.oobretlen / mtd_oobavail(mtd, &ops)) *
-				     mtd->writesize;
+		req.start = mtdchar_next_offset(mtd, req.start, &ops);
 		req.len -= ops.retlen;
 		usr_data += ops.retlen;
 
@@ -782,13 +796,13 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 		}
 	}
 
-	while (req.len > 0 || (!usr_data && req.ooblen > 0)) {
+	while (req.len > 0 || req.ooblen > 0) {
 		struct mtd_req_stats stats;
 		struct mtd_oob_ops ops = {
 			.mode = req.mode,
 			.len = min_t(size_t, req.len, datbuf_len),
 			.ooblen = min_t(size_t, req.ooblen, oobbuf_len),
-			.datbuf = datbuf,
+			.datbuf = req.len ? datbuf : NULL,
 			.oobbuf = oobbuf,
 			.stats = &stats,
 		};
@@ -806,8 +820,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 		ret = mtdchar_adjust_io_lengths(mtd, req.start, &ops, req.ooblen);
 		if (ret)
 			break;
-		if (ops.len < req.len)
-			adjust_oob_length(mtd, req.start, &ops);
+		adjust_oob_length(mtd, req.start, &ops);
 
 		ret = mtd_read_oob(mtd, (loff_t)req.start, &ops);
 
@@ -826,11 +839,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 			break;
 		}
 
-		if (usr_data)
-			req.start += ops.retlen;
-		else
-			req.start += (u64)(ops.oobretlen / mtd_oobavail(mtd, &ops)) *
-				     mtd->writesize;
+		req.start = mtdchar_next_offset(mtd, req.start, &ops);
 		req.len -= ops.retlen;
 		usr_data += ops.retlen;
 

-- 
2.53.0

