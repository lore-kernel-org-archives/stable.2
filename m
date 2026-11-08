Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181797;
	b=2f3uB+5fHo5ScCToNYqk8igJj6nlpXL+sy79Q3/fq7cSQdKb6QgZ4A3ESnEIoGEB1zNj
	 eydq0ZRC3K8WuYCrzfOcDrT2yuJuiwhtYegkDidkJDxG+lVrB7e1cBzTuyBemocN5wJb3
	 2CaYZVnDk0Lo/zjL1ymhNFp5jd5qIRep7I27azdDTjk+K+j2N9RFJrAmkLDuw121Unt2C
	 kGYnP643RtlqnWYXy1LvzfAaTt0tGq3wPn2UCB/cwAbbcLQcSp+hpY/Yis1mzfNhm3jAz
	 4ZG2GhBKpscwn7GXOmd0uGRq9lBzMxUDXqotBkawHAqXs7ZfDfqnrsURaRLxpsfe5Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mapGuynXXw7KDW6DKyURQpWmkV/D5C6EmEzFKbFPSPE=;
	b=YTLnxFMIY7Hbn6m+HK5X9ozId8QeDR8qDRHzc+iX/NbtVpunM+7szR/FwqXRWZGIdIb3
	 MSybhP4PTMp0Tjg3h8zIbubk+nb7Et/W25I0en+njY2faobUzEffgjrOH4FA1iCVyuTyt
	 hSGbVHy5Toe1KGXc8Z2qErjW/lvLSPWQT+bIUH67JzVEP96ztirTGCo3GmQUTNpus9HQp
	 T6yBgkZlXDDvA+SNesYw5AuTWsDZP7uWMNdLvBMQOw9l8X+RLjSuV1FClsJT+QqEzHaPO
	 E+x0oHtFrMD7TMBO/xFaOftBTI7S7cGNoUIabqqb0rT4mED6kvHOzHLSl9vd5HmOpyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wuWN4VLt;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28D606A337
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 23:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E28D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wuWN4VLt
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8470d7d430fso157748a34.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 15:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794181788; x=1794786588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mapGuynXXw7KDW6DKyURQpWmkV/D5C6EmEzFKbFPSPE=;
        b=wuWN4VLtBvxp7KFKzhSQZX8X2vptRXmHNBjyd8ECRmgHFlyM08P9oyyVqfWxlJ/9s4
         3xdS/NSI25rWZJO8xP4YoAVYGN5mWRSPaKJytX3sHp4qMnCH7/20mJpI9OL/VJ3R2aZM
         hvbMdLPUhmfSR8iOftWUBcGk+opXpVz9Al86yWN1TlcA42/x+YbeyhNG5ouTKyyWQHcl
         ijRuPo6TpR2MR9uwOJhD2DT0BdX6n48Qtz0wx3jCLY1WWukQJdPW3fhMfUhvDZAgRqh/
         ZoXwRv9PlOOZJ7be0yeTAyGKJC8+D3ko0FN6Ufv5fvbHIZgYWcvUabwtnlgeUx53NUy1
         kFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794181788; x=1794786588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mapGuynXXw7KDW6DKyURQpWmkV/D5C6EmEzFKbFPSPE=;
        b=N7kVsAtRjrXpgOL7uxEbMdSvyaoYECJxTpSY5ldDg9rxhsedP6LhoUhG/YYcSJxxoL
         eSA3pbIQCwGAe5Tqu8uK3stHppJ2Dgv3CtmRdrt4tuCZOoQIKpfxfo9dAqebMlap/I5o
         0mfvCK4sprof2rKDHNN6zxMGMVlrALi2g2dAuPbVOSuFOlLeKvqEup/DfNORqkB6kLUi
         LhhDdOAz3nKGlq8otu0fLIpuqwWb2bF6NFTlG67b5ZSLUaWp34ddMu/DJlc41xUyvgWu
         5rgN9ByzJF2FEig1Nvh3IUHGipDIcTe7zVSvkbOg5Fak+tZ2j74grfWqRcxZGv/NlvpU
         BF7Q==
X-Forwarded-Encrypted: i=1; AL+hErHapvwB/IycK49WffherCwYlLnEi2zkWBuPJtcEknN9nQx+5oCmQl/T7qevRh+5qC0CmAP/Hmw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bbSLH+jTMMh6KbCUQPtpLxaU1yeVMKmVdmOadmQ6ajIo6+Z5w
	JE2N0rhPmnXhud/8KfmSmycBZABP7zOWekYHc0A5JUDZZidC+AoNppUg
X-Gm-Gg: AYBFou3NE34u5fLrVroJ12i1HmZWWifc1LZwAfFk2YGKgMsrAZZriOx2cutfYyUtCa1
	+Al2gcMby9RYopjRc3d5ggkrc2EcZhMrS330kqBvex1jAG+5fdFV0CPpQcSN2n3Fu10/4Cp8xtR
	UTXfNReMPtjiiw6N+izR9HnHkxLOQCy4B8SASuRVKlFrAWuXEaBXN/OTtYUM0b6aJtRt8rohVme
	6SJ/xr3WAzk9qVXnuB2g+KYvln9PBTWq+Fl4A8pbiEhieWJlFRWjBLmCA9QMH+/pe5VHWSbhUvd
	OrLMY80qfLAk/bVEbzxnJn8JMCC/b7VaZpx9ibgbzOEEUsNkcJdMqflq16SmtfVM5xV+c2KS11p
	Db0ZI5Sc5chWAy3JsR4t6p2Z4taLELEIMye+VVBJkcqtdD+rEBbcii6PBV11S/U4rZuBAYXuaxD
	Gaj6xXB6PVFHUQSfu48SqogppnDo3JHpyCGlxe7d4JVax3pjIfEv7OrbggMNz3ZuPEEe38GXYRt
	CBryeDU52gR2h8wLObPsYT13Xc9m3Ax8ka3qdzfvQXF/Ly0viSrV+5l6yNwufChHxOcnpNcEyKc
	uBNTJ7eoOARykybbZxB13bwCyx1QD6Y5gUN+uCwgD4PTFpkjq9FSD4WWzxV42TUcn/Mn2ciJNg6
	Ry+bOO7DjRsN0fR9U3wr/zrB48r1OZurYJUlH1ffSBr9i+fQ/dyfEcTsSNhrgx5/8bGlXfpTfIq
	MHzpbQy0u3L55TEW9CLeEPH6pVS/viOr6QEDxK+mneTF8LY8dYIkw=
X-Received: by 2002:a05:6808:bd1:b0:4f7:f874:8cba with SMTP id 5614622812f47-56814714267mr1383882b6e.48.1794181787763;
        Sun, 08 Nov 2026 15:49:47 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813ac6352sm3019435b6e.1.2026.11.08.15.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:49:47 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 16:49:14 -0700
Subject: [PATCH v2 3/4] mtdchar: keep OOB chunks aligned with their data
 pages
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
Message-Id: <20261108-submit-mtdchar-page-chunking-v1-v2-3-838cf8934ba6@gmail.com>
References: <20261108-submit-mtdchar-page-chunking-v1-v2-0-838cf8934ba6@gmail.com>
In-Reply-To: <20261108-submit-mtdchar-page-chunking-v1-v2-0-838cf8934ba6@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

MEMREAD and MEMWRITE advance the flash address by the data bytes
transferred. OOB-only operations transfer no data, so another buffer-sized
chunk starts at the same address and repeats pages.

Advance OOB-only requests by the number of pages transferred. Round
non-final OOB chunks down to whole pages so the next call starts at the
next page, rather than repeating a partially consumed page. Allow the
buffer to hold at least one page of OOB and reject requests when the
selected mode has no OOB capacity.

When OOB is the limiting buffer, also cap the data chunk to those same
pages. Otherwise a combined request can exhaust its data before all OOB
has been transferred.

Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE ioctl")
Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdchar.c | 53 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 189e462a9df0..85e98905f732 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -589,6 +589,30 @@ static void adjust_oob_length(struct mtd_info *mtd, uint64_t start,
 	ops->ooblen = min_t(u64, ops->ooblen, pages * oob_per_page);
 }
 
+static int mtdchar_adjust_io_lengths(struct mtd_info *mtd, uint64_t start,
+				     struct mtd_oob_ops *ops, uint64_t remaining_oob)
+{
+	u32 oob_per_page = mtd_oobavail(mtd, ops);
+	u64 len;
+
+	if (!ops->ooblen)
+		return 0;
+	if (!oob_per_page)
+		return -EINVAL;
+
+	if (ops->ooblen < remaining_oob) {
+		/* Keep a page's OOB together when another chunk follows. */
+		ops->ooblen = rounddown(ops->ooblen, oob_per_page);
+		if (ops->len) {
+			len = (u64)(ops->ooblen / oob_per_page) * mtd->writesize;
+			len -= mtd_mod_by_ws(start, mtd);
+			ops->len = min_t(u64, ops->len, len);
+		}
+	}
+
+	return 0;
+}
+
 static noinline_for_stack int
 mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 {
@@ -628,7 +652,8 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 			return -ENOMEM;
 	}
 
-	oobbuf_len = min_t(size_t, req.ooblen, mtd->erasesize);
+	oobbuf_len = min_t(size_t, req.ooblen,
+			   max(mtd->erasesize, mtd->oobsize));
 	if (oobbuf_len > 0) {
 		oobbuf = kvmalloc(oobbuf_len, GFP_KERNEL);
 		if (!oobbuf) {
@@ -648,13 +673,17 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 
 		/*
 		 * Shorten non-page-aligned, eraseblock-sized writes so that
-		 * the write ends on an eraseblock boundary.  This is necessary
+		 * the write ends on a page boundary.  This is necessary
 		 * for adjust_oob_length() to properly handle non-page-aligned
 		 * writes.
 		 */
 		if (ops.len == mtd->erasesize)
 			ops.len -= mtd_mod_by_ws(req.start + ops.len, mtd);
 
+		ret = mtdchar_adjust_io_lengths(mtd, req.start, &ops, req.ooblen);
+		if (ret)
+			break;
+
 		/*
 		 * For writes which are not OOB-only, adjust the amount of OOB
 		 * data written according to the number of data pages written.
@@ -674,7 +703,11 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 		if (ret)
 			break;
 
-		req.start += ops.retlen;
+		if (usr_data)
+			req.start += ops.retlen;
+		else
+			req.start += (u64)(ops.oobretlen / mtd_oobavail(mtd, &ops)) *
+				     mtd->writesize;
 		req.len -= ops.retlen;
 		usr_data += ops.retlen;
 
@@ -739,7 +772,8 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 		}
 	}
 
-	oobbuf_len = min_t(size_t, req.ooblen, mtd->erasesize);
+	oobbuf_len = min_t(size_t, req.ooblen,
+			   max(mtd->erasesize, mtd->oobsize));
 	if (oobbuf_len > 0) {
 		oobbuf = kvmalloc(oobbuf_len, GFP_KERNEL);
 		if (!oobbuf) {
@@ -761,7 +795,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 
 		/*
 		 * Shorten non-page-aligned, eraseblock-sized reads so that the
-		 * read ends on an eraseblock boundary.  This is necessary in
+		 * read ends on a page boundary.  This is necessary in
 		 * order to prevent OOB data for some pages from being
 		 * duplicated in the output of non-page-aligned reads requiring
 		 * multiple mtd_read_oob() calls to be completed.
@@ -769,6 +803,9 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 		if (ops.len == mtd->erasesize)
 			ops.len -= mtd_mod_by_ws(req.start + ops.len, mtd);
 
+		ret = mtdchar_adjust_io_lengths(mtd, req.start, &ops, req.ooblen);
+		if (ret)
+			break;
 		if (ops.len < req.len)
 			adjust_oob_length(mtd, req.start, &ops);
 
@@ -789,7 +826,11 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 			break;
 		}
 
-		req.start += ops.retlen;
+		if (usr_data)
+			req.start += ops.retlen;
+		else
+			req.start += (u64)(ops.oobretlen / mtd_oobavail(mtd, &ops)) *
+				     mtd->writesize;
 		req.len -= ops.retlen;
 		usr_data += ops.retlen;
 

-- 
2.53.0

