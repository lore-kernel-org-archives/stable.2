Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218563F1044
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341394; cv=none; b=XjgEyAXuuL0BGqYNtylv4QkzfEDLfVnTGuyHUeXN0IxxyUFMnLzGeTJr6t/i/ybJtUE0LN/eascbIyiTbp5Z9Lv3IY1Q3cm+KI+ilp6P0uPhpiM2qEOz1Hm2HU6iHkZCGX9xbZVWeRux82Y9i4aO9v72EobH4bT9V5mLa55iXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341394; c=relaxed/simple;
	bh=1206x6K8a9ICANECB2z1av+VARsTQzPmVYCJuXW4jkQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=k/bAHiGfgiLWQ8cgdBsH+5cG9iVLv1m325cxAHU9b2vkbF8HYt8FlHwcpz7zqh62X4BEPgryFVInqG50XSH/fqGuO0OZ+fKR34THSMWrV6VWfLEdUVaUuAbI9LNwBbruhJ2KQ1MBP4cW+2L3AmnKLwinJ7OyzFO/92XYBarSNjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=willbush.dev; spf=pass smtp.mailfrom=willbush.dev; dkim=pass (2048-bit key) header.d=willbush.dev header.i=@willbush.dev header.b=lYKzUJi3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbyAxFIo; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=willbush.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willbush.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willbush.dev header.i=@willbush.dev header.b="lYKzUJi3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbyAxFIo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF4FE1400107
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:36:24 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Sun, 18 Oct 2026 12:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willbush.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1792341384; x=1792427784; bh=3t
	GoBjVzGZKF3e9XOxGK5DBNmYAUi7baXlpnnVm/Z3E=; b=lYKzUJi3M3GXQPl6Eu
	OxmLhF00+esvTt2lxajrUvAONrZ1UHMSK/lkQOu4CVi5p8m2vXOEwHrulmhsSR9e
	UMNw3ZOQZD45T6HObUTTAAgXrYdssOB5VyDZyAi50EmTFF/SgRf+cHa+Rl0UEUJ8
	xYfTq9sqSH8QwfkVKMsPqB3PmtP5GBCSxK6+b4HdMQxBMCww6DzSsJnwg5J4/xNm
	eXAdgfk9mhx/IKsCc7uCBYvGGaJPqg4fUpbLHG0K5tXrlbWKEHkKHrSP4O0XQMtA
	Ne9pCy7F1QEoJKoHZHpmAAJ54vur+E9UfxCaO3ZMWS9kdaEXjBsIauIeg34HIUn3
	uzvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792341384; x=1792427784; bh=3tGoBjVzGZKF3e9XOxGK5DBNmYAU
	i7baXlpnnVm/Z3E=; b=HbyAxFIo459zrV+gweoJ3VnrGHcnvr7yGM3xCCjd9kfU
	wct+tX7EYnLzqe10R5S5DjbY7ul51xd8Zrs9wSHkayadXL4EmZqOJQ0jCe5rXTQG
	U8LknvSfKEZ8Zhrg2WErEDQixgWhGN3sA1ZeEcE2ca0MNCosjyAM/kYMO+okrbpg
	FTEuJbk2LcrJ4NyTu48dEsvOSQ7nzzW2zSX5yCgVIH7dzSnWPEFF2FdI6hDM3Akl
	6dJ3t+8+eDNKvlH32mK32d3RnR34eIkB3agPDEk9Xri9jw4w1+xP0UPogQnfRWB1
	MQniU2gLxt0EhY/QH+ecAnK89SoUl0PmsD737lzhag==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=willbush.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792341384; d=willbush.dev;
	mf=PHdpbGxAd2lsbGJ1c2guZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:OYQKwOmd/DOSpm89SJaC2WjEHwQR33cUFHGx/9rToTRSGF0
	pvsAN5qzV9rsF0J7yQPH4AZcvVoa4R0CYmiVhFKPoaMzUZUN5COLttmpCWvlfrsn
	pXU+Iz23zq8eDqXFjQiI9XpYE6K+hhHhO1V1qdlI6B1nzkyPRIFKw6tLOROhR4zL
	C5QpDfOhlonMnMLIVyGkOTfRoKR6NymsqySHK1mwy99uoUbvB/ds4yC//ar5HIwH
	EGB9QXl564C7xQ2//5/3zMkRpRy6gXOT+/8m1IinQrwrgLIqYwwwWVSaorC5lzNA
	ivUU4bK38cSGttAVAx6Zvt6zx16QXLS1sv05hsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:VyqkAny2DlF94PbEW/U6krYIS9vjRI0OHL+QyT+KFWo=:1206x6K8a9ICANECB2z1av+VARsTQzPmVYCJuXW4jkQ=;
X-ME-Sender: <xms:iPXUarlCO74UqomhNfK6oJCRMOe_QxmEPyZqaR5Og5Gjck6rqckurw>
    <xme:iPXUappySAnDJnF208TqYQrD85S4B0w7I9kmkoW7jqzFJWvKc5IhTlSeNT4iy581K
    8rELZ8Or-qh-1mWFDlpvm9YqqDYcJbPwNTMU5za1Z_23Awx9219PAA>
X-ME-Proxy-Cause: dmFkZTF60ouSx4v/CB2rZwLkCojmMW49pkgKmDBNRc390uF4YMSwxJ+jNb6I9CBnm7ox1F
    Z4jKHIAHpdZigf6UdYARBoyG41hXtIuZ+OgLdv7Rp15fxeo2CXIpBFk15nuvl7vX0b0Zf2
    m5Kb92mDMdj7Vn6dZUHKRagG+inK6bPlrSwibh3IKh8fS1YVfTk2neEkSSAdPU0EW5z6ix
    kGpfNcz4+4fmzaQ1UP3jCqI3P6HFVDoafmt/07TPsGz3XI73yMrm2SkAivSafxxyl4D0PD
    up67XGqJIp5de7BHkcloFhcPsUgX7ZRVelaGxZYMlPSQ4xuu1ynuDzBVEmzC3QlbblKqN7
    mbs/fjX2to2SorxzQMPraQXjoOkyCPz9YqGymZIZ1AP66g8Uo81NfmZn5MWIGlCUZ66bdm
    9r/+nZUll/KEpBwonSVZ9OWjarzXBQmPe/Lw3ss3El+8CkRYgcyzY4/UmCuy8PCrr0lbxE
    Lgk8KDLDJvtwSryJY22wgVhfLxFH6lsB4Zy+KTVSfxtkHCTLspdcRuP2h+/oCQ3hawv1UK
    w5WP4UYShO7X08ERXmMaEYyiTdeQS/PzLn9zZHsahejk/ebpy864nLb82tDYcUrMdAFJIb
    EODpBl5TIbj6Igbk0HFMQOrY5CmQteO5/rxsDdaQ38EmA8WCJ8HqUIkuYgPA
X-ME-Proxy: <xmx:iPXUasLr_N5428jlTcBt1LtrKFCVWRrgSiq3IzCc8HDU4HWVDhtLPg>
    <xmx:iPXUarOowU7nZ8_3sSzfpaPFF8wNIsC2qgJMHAZcW1wuDVkviXjFjQ>
    <xmx:iPXUai5klthezB1OJ04pNHeDv-VpubRNl09UscnMWONUrsizA17oPQ>
    <xmx:iPXUal4ZWwmfoNwu53kKvw8KH7ARQKw5CO95jPfioHIZBTq98Y8svw>
    <xmx:iPXUahKPugSNnyuTaKqpJw_lk8nvb1bORzk65pxFZJKVir8PsS3oatwV>
Feedback-ID: i0f194965:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 10C71700065; Sun, 18 Oct 2026 12:36:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 18 Oct 2026 11:34:27 -0500
From: "Will Bush" <will@willbush.dev>
To: "Takashi Iwai" <tiwai@suse.com>
Cc: "Jaroslav Kysela" <perex@perex.cz>, linux-sound@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 "Jan Lentfer" <jan.lentfer@web.de>,
 =?UTF-8?Q?Sebastian_Dalfu=C3=9F?= <sd@sedf.de>
Message-Id: <45162613-2802-401c-84c9-742f9c8c68e6@app.fastmail.com>
Subject: [REGRESSION] usb-audio: Behringer UMC204HD broken in 7.2.10
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Takashi,

Thanks for all your work on usb-audio. I was updating my system (NixOS), which
took me from 7.2.9 to 7.2.10, and my Behringer UMC204HD device stopped working.

It gets into a loop:

  [  225.148019] blazar kernel: usb 3-4: new high-speed USB device number 19 using xhci_hcd
  [  225.340016] blazar kernel: usb 3-4: New USB device found, idVendor=1397, idProduct=0508, bcdDevice= 1.35
  [  225.366005] blazar kernel: usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
  [  225.366187] blazar kernel: usb 3-4: Product: UMC204HD 192k
  [  225.366304] blazar kernel: usb 3-4: Manufacturer: BEHRINGER
  [  230.493021] blazar kernel: usb 3-4: failed to read device descriptor: -110
  [  230.493313] blazar kernel: snd-usb-audio 3-4:1.0: probe with driver snd-usb-audio failed with error -110
  [  235.612029] blazar kernel: usb 3-4: failed to read device descriptor: -110
  [  235.612302] blazar kernel: snd-usb-audio 3-4:1.3: probe with driver snd-usb-audio failed with error -110
  [  240.732035] blazar kernel: usb 3-4: failed to read device descriptor: -110
  [  240.732461] blazar kernel: snd-usb-audio 3-4:1.4: probe with driver snd-usb-audio failed with error -110
  [  240.732538] blazar kernel: usb 3-4: USB disconnect, device number 19
  [  241.019061] blazar kernel: usb 3-4: new high-speed USB device number 20 using xhci_hcd

Issue seems to be from commit: b5c4823cf3e4 ("ALSA: usb-audio: Apply boot quirk for Behringer models generically")

I was able to patch 7.2.10 to get it working again:

-	if (USB_ID_VENDOR(id) == 0x1397)
+	if (id == USB_ID(0x1397, 0x1234))

Not sure if applying the quirk to every Behringer device is too broad or what
the fix should be. Ping me if you want me to test a patch.

#regzbot introduced: b5c4823cf3e4

Thanks,
Will Bush
