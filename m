Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79AC4457A3
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515536; cv=none; b=iy9oNjFJz/Cji51u2x4/s5FREQ+uGeKYOvAUigCkxi4EiYUa7v5G3VZgnARPc0+YgUWAnyr1RRLS2ouP/7jBIYjJEyjXulsqb90oq5S68cfxYBeq7xJNoNL/E0g75zs88d+EvcHoaXj9Eg0JTVGDR146oDVQ21BTLppzHxxtPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515536; c=relaxed/simple;
	bh=WLuAx9dL8Uhq9q7tDcC3t3WqKTRHxDSaOFzJ3KhkEZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyKWegftpAzxOTduoLTGJ7QeNTVgYwHOZVvXXRNl53QYVz1ShPFIhlxPyAZzEmqZCIW32EqluAMUzAhRMXFPMGV4fTchr2ZSuP2lqZbqcd4EURjwLElZcJnnAXBPrDh81tOPHfmQIO9IzmVlR+mDTDVVdFNxFV6ESjQGWjn3bf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7p/1V9D; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7p/1V9D"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so6430825e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788515533; x=1789120333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7tPZxOd/jUEm4iyVSqikL97T5ZOmda/lLmug2pbNFbY=;
        b=r7p/1V9Dq7hHSQ0s6cNy2nQ1DcjNQLZRH7N3Fr3ZradUUMzKI23sdjadesUrWjv7L6
         +Bpn+yIUj7+WhbprQabmAqCqI5A90BJs/PPXyda6jkV0gwDzUuoVEJinzNW8TNx2M2YO
         WgH8s95OwTO9dzY5yn1MGHu/t0Z/QeaxSD/X9yMxGteB0F6SdKULXCduS3KKGTslsu3P
         AMzEqP0L9kVkCv7BpuQBz+OD+k5M8RYu3z/EQnJM77uDTjtnEzk7eUZKRbQvCgzOJcH0
         4KYxDUsP9Gu074M+WPxO7pdv4ejXAZit9AAb5jPednUDpZdRoj4e0dPHeq66mZM6DxTZ
         cVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515533; x=1789120333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7tPZxOd/jUEm4iyVSqikL97T5ZOmda/lLmug2pbNFbY=;
        b=obkWLKXoU2cF58KcSf6c7az3dBfNcSQK38dTSp2ivsK/byfXo2iukqjlueRX9mT2Cr
         BBZoW8tleRltTx658rSSbsM0Ve15zFNKuDWoqUPSR4Dow46PzcQd57I3chLX18mGOCT2
         Y+XJtP58w0Ue9DrBy7Oebch040cuZXfxsNjwRsySTWr+P1qgFQ/8Yg8qMrmYi+Dvo3eh
         tLB0o2eNk3eieXKpa3dFQfj3QWmQqdqU+vNlxO3/eMj7MKdLUg/XKGN9hA/VKW1hhwjD
         7QIFfjZWZdB9QKBjjIqW6K/0rUA/6q74hwU15kVlc7gT8dB59z7XGmc+dsjhSZQcfp3+
         RsVA==
X-Forwarded-Encrypted: i=1; AKwUvBzwmJGCuiVhEwrg1WPNf11Fh8/8Gbtp3oo2e9x4aODUps+Btf9wt5SznyHrLeL7m0IAfxaebSk=@vger.kernel.org
X-Gm-Message-State: AFuF++krsaJ5EmKZEbUAgfsCEI1iMhRuicELOFpsETxKcD3wCovf9q4A
	INWrc6FZo+BWGTcxlnXQfqA/U9zb4fNwwRoIu9B7UFjLtKEH2s0MB0Y=
X-Gm-Gg: AYBFou10zA0RTWZUIiKYj0d2H580W6zdXQdDLyTItc6hGAo8hm2IH4ajSm6Dxy+7jq8
	gFqBsJuZwkGbbV51AtbiVWfcUyZFR4nb+S2fjys6FY91UkDhEJiels/YJzWEAA3DKp1JJXw51zA
	LtbMt+oRVj/ymqRUId/KCBC3El66NR9OQaZXcvbw1EhkYIXOONEfRjGSU77xBbox1Jmcu2NGhUN
	V1zqQQ8u2ky9rRASIBAUs5wdKO7ifipo18cFVAxH0RGCk1w6xh+W6lEeXOL7QEn/1GbLUDux0u+
	iVPBa1jxf/kroaaXYnfi0TimtINmykoilm8UYczs/KZg3EqQAs65Dk04L8PmXIVcHghPMZgwFGP
	DNFdP/MBcrY3OT71e5ujMFC9kJQheGFT08c1WVjsj2BacXyAyTEUjQ2UDs19gd5iiUhMXQAnyaZ
	WOGi63MYa1MpGgCO8C1fvkfN9A6QTqFg==
X-Received: by 2002:a05:600c:5247:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49cf81dadcamr43236695e9.2.1788515532842;
        Fri, 04 Sep 2026 02:52:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5952560sm168466065e9.3.2026.09.04.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:52:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ALSA: usbusx2y: validate URB actual_length in interrupt callback
Date: Fri,  4 Sep 2026 09:52:11 +0000
Message-ID: <20260904095211.3906038-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904095154.3905899-1-tristmd@gmail.com>
References: <20260904095154.3905899-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

i_usx2y_in04_int() processes the interrupt URB data without checking
urb->actual_length.  A malfunctioning USB device could send a short
transfer, causing the handler to process uninitialized heap data from
the kmalloc-allocated in04_buf.

This is problematic because in04_buf is allocated with kmalloc() (not
kzalloc()), so uninitialized slab data may be present before the first
full transfer.  The data is then copied to us428ctls->ctl_snapshot[],
which is mmap-accessible to userspace via snd_us428ctls_mmap().

Fix by:
1. Using kzalloc() for in04_buf to zero-initialize the buffer
2. Adding an actual_length check at the start of the callback to skip
   processing on short transfers while still resubmitting the URB

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/usb/usx2y/usbusx2y.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 4190227c5a2a5..5744a873aac26 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -189,6 +189,9 @@ static void i_usx2y_in04_int(struct urb *urb)
 		return;
 	}
 
+	if (urb->actual_length < 21)
+		goto resubmit;
+
 	if (us428ctls) {
 		diff = -1;
 		if (us428ctls->ctl_snapshot_last == -2) {
@@ -253,6 +256,7 @@ static void i_usx2y_in04_int(struct urb *urb)
 	if (err)
 		dev_err(&urb->dev->dev, "in04_int() usb_submit_urb err=%i\n", err);
 
+resubmit:
 	urb->dev = usx2y->dev;
 	usb_submit_urb(urb, GFP_ATOMIC);
 }
@@ -305,7 +309,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 		goto error;
 	}
 
-	usx2y->in04_buf = kmalloc(21, GFP_KERNEL);
+	usx2y->in04_buf = kzalloc(21, GFP_KERNEL);
 	if (!usx2y->in04_buf) {
 		err = -ENOMEM;
 		goto error;
-- 
2.47.3

