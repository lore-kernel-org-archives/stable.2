Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806946;
	b=vPo7gp+n/L/EB0+JW8SdILtCmcY7OogbUSng0aMtn7bsKbo5PGakj06Hn1vthSWcDRWe
	 3Jjy2zf8Be69XIlIerCk8Y8PDGNqXHX4SL+pXIiO4JnIdwRUP1bBTrDu5BPWwUvGSWsDv
	 J7hddwXgLiPt2DC7ach1YzTXbV00vbYwBXfdt3fmb77PHbyQB341jgxOxu30BHnKvilPs
	 EYJc1poU3eDqbubdp7ETID+pBPL/ac6jWYmzng5zwX6mHmkJAZWnmS+ql1kXRT1c4yC+A
	 qSGm3aCG8ukdit23/x2hYsW8p0Q7z3B4lgiNqJmON7MTmdbDpAMJ5EaPYTlD9uKvrWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806946;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:
	 Content-Type:CMS-TYPE:cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:
	 References;
	bh=U5PQg/K60zOvaI9X1XNSQFLTUzY3suF9si7SMaK+wro=;
	b=YkuL+MxxK0fwvZdQY9uZjX6r2tU/y3c0/uUj8SL8o09Ot7gX1zGlLxxuaHl7yGpafz8X
	 pg72nObsK1H8ohcgRuforxncdyo625g93V0+eiKMJkEg1rwnfL/dZDeapJiJEFsivRnM6
	 sSCrSFujbRIzl1YevFeJZ1Iw2neC4vOIWeZziKcul/AyFgacJeuc5IfLFOaRHmdSHVOH5
	 IyA0pmdTTLUJr9Luuck3kbuL7fTbRqIsRxxCQYJA36oqjJWqq36xzpbHwjGudpDtKz+GD
	 Dd5X6KOs4uhuImsv1OzEKW5BocaBCyXb84NvJun5CwKQYQ0Nt4Mz+qcqtSS2mFXt29w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=LDjlDuy6;
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFD606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEEFD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=LDjlDuy6
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261116052857epoutp047b5dad470a1218b7a899e0af6703c501~ob2ZvaCqo3185231852epoutp04E
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:28:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261116052857epoutp047b5dad470a1218b7a899e0af6703c501~ob2ZvaCqo3185231852epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794806937;
	bh=U5PQg/K60zOvaI9X1XNSQFLTUzY3suF9si7SMaK+wro=;
	h=From:To:Cc:Subject:Date:References:From;
	b=LDjlDuy6ho4cioLZw1y2jCQLhdCvlOlEwdlePpt4j89dOSco/kU18BYm04Zxfha+y
	 kdk4IJUJR4yMVjsHaCIDYashuTTTZ9xyDwZ2vKvHqpgHLCdFeIwQqYH5Tw6KqF4twe
	 AjlARD5LPqHCBTDwK1qR9RMAvM3+7IKfY8OXbF24=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20261116052856epcas1p3918ff298c297b56faa97959b1da0b813~ob2ZWU7bb2735427354epcas1p36;
	Mon, 16 Nov 2026 05:28:56 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.195]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4jSby02zj4z3hhT3; Mon, 16 Nov
	2026 05:28:56 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20261116052855epcas1p403c518b90d70d98752ad0ca2d9ac05e9~ob2YgxVEN1801918019epcas1p4T;
	Mon, 16 Nov 2026 05:28:55 +0000 (GMT)
Received: from VDBS1420.vd.sec.samsung.net (unknown [168.219.244.32]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261116052855epsmtip26e2c05f4d73416da30deab5e21cd0249~ob2YeU5m23106931069epsmtip2L;
	Mon, 16 Nov 2026 05:28:55 +0000 (GMT)
From: Gichoon Han <gichoon.han@samsung.com>
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gichoon Han <gichoon.han@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: host: ehci-sched: Don't let a bogus siTD remaining
 length underflow
Date: Mon, 16 Nov 2026 14:28:51 +0900
Message-Id: <20261116052851.2272125-1-gichoon.han@samsung.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261116052855epcas1p403c518b90d70d98752ad0ca2d9ac05e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261116052855epcas1p403c518b90d70d98752ad0ca2d9ac05e9
References: <CGME20261116052855epcas1p403c518b90d70d98752ad0ca2d9ac05e9@epcas1p4.samsung.com>

sitd_complete() computes the received length of a split isochronous
packet as desc->length - SITD_LENGTH(t), where SITD_LENGTH() is the
"Total Bytes to Transfer" count the controller leaves in the siTD.
Nothing checks that this remaining count is not larger than what was
programmed.  If the controller reports a larger value, the unsigned
subtraction wraps and the class driver gets an actual_length of
nearly 4 GiB for a packet that can hold at most 1023 bytes.

This was seen on an ARM32 system (vendor 5.4 kernel; this code is
unchanged in mainline) with a full-speed UAC1 microphone behind a
high-speed hub.  snd-usb-audio trusted the value and read far past
the URB transfer buffer:

  Unable to handle kernel paging request at virtual address e8756000
  Internal error: Oops: 7 [#1] PREEMPT SMP ARM

The register state at the fault is only consistent with a wrapped
actual_length coming from this path.

snd-usb-audio now rejects such packets (commit eed0e9583a29 ("ALSA:
usb-audio: Drop capture packets with bogus actual_length")), but as
noted when that was applied, the bug really lies in the host
controller driver, and other class drivers trust actual_length too.

Treat a remaining count larger than the programmed length as a
protocol error instead of reporting a wrapped length.

Link: https://lore.kernel.org/r/87se19ufoi.wl-tiwai@suse.de
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gichoon Han <gichoon.han@samsung.com>
---
Compile-tested only (ARM32, W=1) on linux-next.  I could not capture
the siTD contents on the affected hardware; the wrapped value is
inferred from the oops above.

 drivers/usb/host/ehci-sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 57d07d1c2dfa..12a10248a4b6 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -2241,6 +2241,10 @@ static bool sitd_complete(struct ehci_hcd *ehci, struct ehci_sitd *sitd)
 	} else if (unlikely(t & SITD_STS_ACTIVE)) {
 		/* URB was too late */
 		urb->error_count++;
+	} else if (unlikely(SITD_LENGTH(t) > desc->length)) {
+		/* controller claims more left than was programmed */
+		urb->error_count++;
+		desc->status = -EPROTO;
 	} else {
 		desc->status = 0;
 		desc->actual_length = desc->length - SITD_LENGTH(t);

base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
-- 
2.25.1

