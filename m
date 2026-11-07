Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794028847;
	b=s3/Fnbs9iaoK31XJ/9Jw1M9EJLu/Ji0dnM6YutSo6oAXkGPitYC7vJDtggJ4uydamM+F
	 Hs36oQkniQuMBBLcpuJZrI69l/6bxISreaxcTLvxSqj7tBODICa8IcxVAe3fuKal9wQMq
	 dqmOUyN1pn+HaiAGoH5GvDfcQAPo7vFb3xShrkWBWKQnc3jtqnL7R2WQZ4/XfD1RPDe/c
	 KgoWuSFuS0pM2cN35hKzkWf1WKOAOOCTQExSWQnLPUacLC81AQBpKIIwfDbpif1zcbNwi
	 Daxh2hec/X6og8upqdVp6EdqvomoNLVeyt2EDRq0f4FPYGAZmBxpwB7t8cpGc2uP5xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794028847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mapGuynXXw7KDW6DKyURQpWmkV/D5C6EmEzFKbFPSPE=;
	b=SrwC7OLPUwz9tBuIwvaCqzrUymo9OjqI0pzzutr7vYi0Ue9MgvYMY4Dyn8F+Yh/1Hl2M
	 WgEcGd1r3TzPwDV+2b8u5S2zjfHYgM/U/6IX2Ad1s5QPm/jj6hFe2HT41NqkQfeQ9FJr8
	 fSTqDk4QgMQkoVOz/Az5YKGouy9QzJWDvOTWc7nkgA2yJbjuj2ZVwPt/wSbOWyiwqFnzT
	 HSPX30z1mSVsFLs3vETMEi/dKz1gYclc3AMlK691dveWK3i3WBWNzqPIR32Lg8aW9aA8f
	 ogthvJY2rliI2iw4ZfuVTUiV3iJDbPEmwI9Wp4UaE3cVf+6eABEtyaACRGuK9PeUq8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NdBv65Yw;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511C606A33C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 05:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3511C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NdBv65Yw
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b28d7c729fso967611b6e.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 21:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794028846; x=1794633646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mapGuynXXw7KDW6DKyURQpWmkV/D5C6EmEzFKbFPSPE=;
        b=NdBv65YwE5bvpAEcYqLR7BYHh1iHUsAMeBQavJH2Xy/4T0H6ccBJVot9u4kyOjjjkf
         8eEibxyA3cJHUlKRfltxED6UenL56HW+ArUDRhQjZ1lDOkCSu2la40iJT+A3SftHOMnH
         3qbeo/3Zgj4IAVf90L+e9aPXRcwoHIZJ5bU7re2gAHr1U6waSjoo1py6gWyuezxmryKm
         8OKFxCUW1HHqLV/ZtxwcS84jUmXwdHeRObkCDT1/lOFea++9SH4324u3PWYdoe4dmq0j
         XNA6yAuUygUiKT8pSWr383A4ub6ui42Wa8CoDj8lV3rwfYRAKcDuvza/dVgCI0Zy8QPP
         5ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794028846; x=1794633646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mapGuynXXw7KDW6DKyURQpWmkV/D5C6EmEzFKbFPSPE=;
        b=N+hkty/luIIauX4CMNyY0RCOR2377MPDNnDW0Hjav6h+BJAIxm8MIN0oLxVfYSbJvq
         VdEPk9ZKj4pAdI8nV7Z137nvCL+f0+5XLXKJr1j8ItJ9mXOLJcWb81uNE1qaSLn+oMwd
         aODmAihGRtdtMapmoBrzBTBeog8VkEAyqC5KD/Mu79GVwFsVbg7/7NRfYlJjgkaNii6o
         B4lMdPSSPQOqnzeozTViVzpejLZKLCk0lhTcP86Jhg59CZsi9MGDyrW4Jro0zVNsGJOX
         +I1CYXfFhVttIgaua9sly7zoTcjCYJx1UEOUbk5sh8d1DRdVj24gbQtsrgTyo64ECqpD
         nYcw==
X-Forwarded-Encrypted: i=1; AKwUvBxw4ZyFx1yj2Nmd4cOu/J7Y/2BOEE7hFA2duJpQ6+e1vOGFAzhQw3dt+M1RFbvSXCe+IxhZcK8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s+nrq6k3PYys/H/L0ZD4qICguqI+RyMAT8XzhB+1rezf7MjiN
	uWOPHfHLtu3ZEIkvaN+ByHFufyD8UDYUmroJHyX69Uj9zN0mNM1b+8tLGRcLGQ==
X-Gm-Gg: AYBFou2xSm/7H/tlIPp1wlZpY7nZfNiQ1tUxK87HlKEGVNoOv4By60KFPx7nhN9uXty
	O+aCIAat5GsDN4Zbf4dSg8jlepGSNzSNLoiYl/TTyILkpbnPm05vWsJAm719scHicGsCol4TBkA
	v1yVQBx4t7wUxAAtlf3v6mKofKVnOxQRmh7Vf8n9g5u1+unQi6bpBW5g7CUNvTnmHUdqtKoD1wo
	moPmIAmQ1ZKgGfgzewqSFLuh8jmpNMRXjSw2t+wZMUvT0+wwn26kyyoJP4WPvLaUV5PfaVyUvUq
	y1JAP5y3Do0gdd0iekDMH6QhEAV8FL53dgIxxpW+OwC8Pg9HQ/y+8CIIIhaLVJPL3UH/hJZ9raO
	n5UtT8rWrTzTYj2C0sp8zeF5vF4pXaBF317oa/lptbxIhJ8uszGyez9GUBYGcleXWOssqSycmAe
	c8dghhOgpKmG/4Ep3x3F62gWFy1ZBkwrg204figGzu7Qyq1oassQFytFShH0sBbXDnGm6tIVe+P
	wSkorRvQ5BPSHogxvAJaGAznYB08pSjkqe+L30ppJqJXIGOnt/GjQ52anwQz0Tbf/R9Q7QGV0BT
	VhD5hV836yo4/sG8d8vq+N9MqzwQFHBSO4BnWyRCfBVVhVisaVk4Y17NpFuOTlvXjMwc5XyBHYN
	2tvwyVRzsWOSy07Tj0ZsIZMv8E+89ws1PN1+cplS9f4UPjfy6EeXUeRZCTY1wnOwqB3Wd6B7fRy
	6QfXVd1yOQe0CIREBAZuEOeEf89YCYyOYcLd1u3saIpR+tED2E4Q2QVQ==
X-Received: by 2002:a05:6808:f13:b0:4c3:4e34:c69e with SMTP id 5614622812f47-567e0fa6011mr3158855b6e.8.1794028846024;
        Fri, 06 Nov 2026 21:20:46 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7ebf4edsm3059846b6e.13.2026.11.06.21.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:20:45 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 06 Nov 2026 22:20:41 -0700
Subject: [PATCH 3/3] mtdchar: keep OOB chunks aligned with their data pages
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
Message-Id: <20261106-submit-mtdchar-page-chunking-v1-v1-3-2973a03531bc@gmail.com>
References: <20261106-submit-mtdchar-page-chunking-v1-v1-0-2973a03531bc@gmail.com>
In-Reply-To: <20261106-submit-mtdchar-page-chunking-v1-v1-0-2973a03531bc@gmail.com>
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

