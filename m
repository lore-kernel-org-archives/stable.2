Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080AC3D88E3;
	Fri, 26 Jun 2026 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457617; cv=none; b=etdYcuYSDl1v7nTVlzreN5ucIs/zb1ZGH3DgJNIWJLuuzoy++0Zpnc3S6UskSI6uQyUeoNm3wsrtj1Oe8fIdqnV5GwoO36O9Gptuk+oeVHt43uH9Fsk6LspakYcTSeBfm0s4P5uG69KIOLimh64w5WqMz6YEplrzu8xVmMgaFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457617; c=relaxed/simple;
	bh=Nb9xg8I7O5dI9Quw5ZIkI7Mjl17b1sJ8iAmhI9Cf1tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uG3iGC5MF7qtjm2V3af/RNqF5L+pTYcZI1TODlm6smbHhaLG+jp5V0ooAEuZTihRcLkin/IjVu/NwgHlzCqYFk5d+F0l4OEdK+kVG5Z145Z5PgSxZjMm+akeddUb+XgXXShsFpjlzlkZUxg3SQ+ZQS22Z8wLxfusn9vcn476YZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=e4nlL3id; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="e4nlL3id"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782457589;
	bh=Y4W/r58Q3W/dWz2m7sS0Ii3kXhsGKStDl7s2/hoHkxQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=e4nlL3idc29w8pWdKLa025YG9KYcGH+NvY2ybfze5VPZ2Qzb4I2nWKdFveiofatKu
	 W8L/cGx4RcwrGqdBu7jd+uZ4RTIlC3c7Df0T1ZgOt1VUcuF/+WRz6YAXF168GWUQYo
	 b0Yaiq9U1vA+O1/v/eJcwh0Sp3EbUMMSHPBj/ZuA=
X-QQ-mid: esmtpgz12t1782457571ta26b18e1
X-QQ-Originating-IP: BpomGn1BFIDJ/YTZkQXfR4Y5obiQ7PKkNtMtN8XtDJc=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 15:06:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11897432787244039745
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] USB: usb-storage: ene_ub6250: restore media-ready check
Date: Fri, 26 Jun 2026 15:06:07 +0800
Message-ID: <F42641386E32404F+20260626070607.4119527-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NWujniBqiFoNpJH9EpvNOowZ6Rgffau97gsI5BJwYrqety1klK/GGQIa
	HOwee4ZnABMm00n3nGPxxmd1PiOUaLK0vD0sbHrWE0KuCirpvykIOmiv68ZH5daZsitKVOH
	ZDE0USsbh+mLyK1uHyGCabi9AzFKisB5f7ixudvjY0N+UGl0BioGtnZfCfD5Y6e24VNfQ6t
	06LJ8Jgw+5MLTnbcEoeipcHVlib0KYIQV2vB98fc4drybO3G21Y7vrFyq93O6IUgNZEMxyw
	68mcScDujSu+q4PMpK9m7a2JHNj5+98FuD2DUoxquQp4kRmK98kbz/z4Pflm4R+ChYzYcGV
	od8cvvwU0F/WOB7vyzmosRXX8zmNu5n8vluMm8rnRot2YJ9aAxgKSnHwqQHjVlQ6Yms/YyG
	is2p7hirw+zGT1zQ8iKKFWPBHAMK99gU8jl4yt7TwUpMzSpwpIxJrVBHqM8MX2nYlBLScIg
	IKnSoiPRPXWL1f1wmYL0qq9p330OqOZXtzMj6ITUdr5oh+lvhPDm6ZXtqNrxNy7cqOt53gD
	MmF7EZMAh/ZJ/N2IoYPflUU0CC9UpSzYmnjbmo52lx/rj2bYF3DDABd8wBqGjrZ2fxg+7nQ
	DZz16tPklDLZCl+u/6lI7ObwQrn2sULuVjLmaBMK7Y6EtysJsPGB/6XisercGM/Hhw0s55A
	QgD3abJsUygSjMgYi+QKGN4o9+I8/lvpr4/u57toUlfYXZLOtWvsNaO4Gpdaava+gXmTAEa
	ukZEOGUZeNW5QuiKIjtjW20hVwZNh0g1K7hh9axmwwV3kKm0YPBCWf4qGY3HB+0TuBBz8PN
	s9VFNivIiXjY4Cmfp52MW8CeWCmJ9VlkMCrjmUH2po3JjbT+LqNgoQuNG5cn+HnLzPdmE9u
	jrRanCd48qTtOicfPHHE4gBs5yIqRQJgZ3VwAFhU5iPolorFF3LG975xbbHWpTHin2AJ6m1
	1boQ75Kcc8JPowNBkYnd8fMZ9iT5LXiHQ/l+30wqG1Q8Oo2MqXQwjwzQ6EAj95s26QZA8hG
	FZf5QqPQbTIy2mbYT64fX2jBQcmjWUVs6Zn5R7FdheTP7h3c9/yNAccmN3rtM6diyUfOT9X
	w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

Commit 1892bf90677a ("USB: usb-storage: Fix use of bitfields for
hardware data in ene_ub6250.c") converted the media status fields from
bitfields to bit masks.

The original ene_transport() test called ene_init() only when neither
media type was ready:

        !(sd_ready || ms_ready)

The converted test became:

        !sd_ready || ms_ready

This is not equivalent. Restore the original semantics by testing that
both ready bits are clear before calling ene_init().

Fixes: 1892bf90677a ("USB: usb-storage: Fix use of bitfields for hardware data in ene_ub6250.c")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/usb/storage/ene_ub6250.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 8770de01a384..ed49a3bc859c 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -2305,7 +2305,8 @@ static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)

 	/*US_DEBUG(usb_stor_show_command(us, srb)); */
 	scsi_set_resid(srb, 0);
-	if (unlikely(!(info->SD_Status & SD_Ready) || (info->MS_Status & MS_Ready)))
+	if (unlikely(!(info->SD_Status & SD_Ready) &&
+		     !(info->MS_Status & MS_Ready)))
 		result = ene_init(us);
 	if (result == USB_STOR_XFER_GOOD) {
 		result = USB_STOR_TRANSPORT_ERROR;
--
2.50.1

