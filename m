Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795385284;
	b=g7WTGnAHmgMkW6r8aiWyTWC51LbssUY2dhAMG0EuuSkrOGDsw3ca5LMK7MgbhL8BqDUY
	 bKVBRxkYOMUxUDpSRCfnFMuTb2saObXx4K/xwgJl8sVwg1/4yCqLRmF97s5ItJvcpCYRH
	 EQVwOs6q0VOF6bJt04ak8J3gyAyOHT97VmVR8ReTNF7JBXgmEf5j6vGwUyObMnQwVyodC
	 l6FeQ76L1aRjxKpw+YqwheyBpyD1X3o6XVzREQKLkvkYawsvs24QeYOOWf/tla+qUjw/B
	 jrAMGhHQdDMi0SLd1STAIBxd14cNaNISzLR0W1BagLTJM1jPCXrqms25fsEMKbHsLbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795385284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Q5dcjCE+LP3xpWENmxAai1dabC7JWByJcjJkMNepDg=;
	b=IpamI8vT2doQ99XF+fK6I0yBhixCQ2NY8v2V8TkJOK9I3EGzXReQb1LY54N0CCP++sHb
	 gF9qXijtN00PBB8PsO0L6dKKhBAm/opuHg1KfBL8rjhQ+efr1gg04qXtDic8MPlJtADWp
	 ovZVIAzfMEZ/ssVXr3Gl3S21xgL3awnBtHiMYgdqik3pe9x96QmxUE8qTrjXyZtjNRgBw
	 nz/ixU/+4zGhsNtfWuA1mbclAstqu2lnE3qtfl9KPuBnzcpNuD6VyfH58K+KUsaTaF3x0
	 MFICgjA7OwM2OZfhCnqPL0CBd3MWRXEtSATdHWyYB4r+hxiJvk3XOVeKEn4OeyUgg3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v1IO52/E";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0E606A31A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B0E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1IO52/E
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso1738687f8f.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 14:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795385282; x=1795990082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Q5dcjCE+LP3xpWENmxAai1dabC7JWByJcjJkMNepDg=;
        b=v1IO52/ERL61wtFGSYzZ5A2fdTot9lQdD0FYuRsYmQGqrBk/l8MTDkniqoYn0pB57x
         bINUnoE9wNBDQygFCTfws4L+EuJ7H9v/jRQdxwtegKFN6b+OjMfZZ4cpxsXuiYREP22m
         mA2OQDPJTDSSkAds4sSkC9IPb6MvJXpxWBeCsAJKzNg2Fnt+Rfm4qk7uyRPeJaCXPUYl
         fcti3Bx+Og9NCZCiDlDMFlrGOC7lr/cl1ZTHZPofbZRIUlOoBSUN5myHqdXM0GIAPmIS
         suCF0s2NzBFSxVpGmMgzyRn59DEsmD4zL2OZzFFUhFVciH3w4qNJcXUT/Riqh+iR6OSF
         UdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795385282; x=1795990082;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Q5dcjCE+LP3xpWENmxAai1dabC7JWByJcjJkMNepDg=;
        b=K5TxQ/8Z4ySW53D/2u2dPa6WRA7cKm8QT9+l6Am7pz7OtVOgT8MyaD8r0uNP4/2Wuj
         4KmDj9rSElF1PQ/NTAUNMfax+mmvNQX1LD2xrcQjH7rzTGuLBziL1yDG3awprlWH9tdL
         refxyUkMaNkxVXQOHQrIgQu5Z9gXpTAjDdvYkUfVEcRI591Lsl35MYQTXDN3dob3T8vb
         wH2N3fqJwF1eiXLD0xPbCHWeGDaZzFN2RsMMsAitbHdApnPqjVtplJ6SdKFqfLasKjnX
         Y//5LLkNj372OhuD42xVdmF2jYTm/6ZPkIer6xyWSuD48NQyJVIklPzyD1V0yj6zrr9l
         2sIQ==
X-Gm-Message-State: APuU4Z9AfRzmT+2lrr7Ey0+PIgrbMmh71dMa8+AidR1makMRkqh4pFS4
	chHOq04LTTCJXQMRwHC44PDuhVeONSQ33t5iEGmc9CNC4dJ8Nw8JlOsHEgRRM1tt
X-Gm-Gg: AZFdTZcGpDrRzLHkus9AfgkY2ORoi9ptrDMRx699h3gtiUfYWkcDFRpUimHwCQIhpjy
	rhxELG30JIFIwT0OFAV7n1JqLtIx+m9QACjaY/JfdFa4JTYaUS8SzbIxyGY9ZtEC1HDHZobtKA9
	FD5nEFZZI+h3Tu5v0guA94462EKK903brg2Tj41T60209KK1BkIPOzFC3u+ktwxqSMIVAYofVxV
	a2cpwz0/tOR0AjY2yMWgUayMf/G2Ha9i2aRWKYKCYIxcHcnyjtCHCe228Z6YMvf1/08ibIun7Uf
	35BgU/1TtE02pr1nCXHSK2N3eXDPXwp8nKBTaeVZ+lBSx749GZFcgE5QxPvG1DNaLczp3526HSE
	PvsIdW8xMcA3oZ1/KoyUakhyE8CFC2UW1G6925yj49DANl08ll61xgrNCaq1FUBrpQCa9aWggdJ
	/Fo5OzD0FKXgkxDdyfExl3kyCkDYMX3BKCbQG01vo45K+tGAujG2fcjkyvSdUy0hUUKeq/XQ3//
	HvI5RC/a3gFdJXyo9zaaiMJZ+R1tIMlnzcQX6ydjoZqgGvfZGBWA4H4wcP5EfZGBXTUyjIUhyvA
	7ib3iVqZhcUgZkM8DcxHPrHcvmauAFHC3dhpM+iOWeJErom7di1+u0d+b3PRPVnwKZc1bu0kYhL
	6t4PXsGLBUdIcmUuXlV72ea4XHYt7J+9UsPo4nrxtkgBr9T0EHYg+6IhWzkxZmuWacreDh4Gd2a
	tiotrlawStWw5sao7X+Bf5ZdSBci5YsBIn8krCU0tgw5FgeNh31wcygA==
X-Received: by 2002:a05:6000:288e:b0:49e:4ba2:a775 with SMTP id ffacd0b85a97d-4abb86e50eamr18986206f8f.56.1795385282098;
        Sun, 22 Nov 2026 14:08:02 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-20fd-ec9f-e3f8-60d4.ipv6.o2.cz. [2a00:1028:8388:a84e:20fd:ec9f:e3f8:60d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm17186632f8f.34.2026.11.22.14.08.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 14:08:00 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] net: sfp: add quirk for Lantech 8330-265D
Date: Sun, 22 Nov 2026 23:07:59 +0100
Message-ID: <20261122220759.72495-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 86a8e8e0ddbc3d14c799536eb888180b84d002f3 ]

Similar to Lantech 8330-262D-E, the Lantech 8330-265D also reports
2500MBd instead of 3125MBd.

Also, all 8330-265D report normal RX_LOS in EEPROM, but some signal
inverted RX_LOS. We therefore need to ignore RX_LOS on these modules.

Signed-off-by: Marek Behún <kabel@kernel.org>
Link: https://patch.msgid.link/20260128170044.15576-1-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjusted context. 6.6.y uses SFP_QUIRK_M instead of SFP_QUIRK_S and has
  other entries next to the Lantech one. The added lines are unchanged. ]
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
The upstream commit is in 6.12.y and 6.18.y, but it does not apply
to 6.6.y. Build-tested on 6.6.162 for arm and arm64.

 drivers/net/phy/sfp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 38ab35e57127cd6863c7682e8260781dc6350f2c..e6fa6020ea81172d83fac9c63190bd1fe16b506e 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -533,9 +533,13 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// FS 2.5G Base-T
 	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 
-	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
-	// 2500MBd NRZ in their EEPROM
+	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
+	// incorrectly report 2500MBd NRZ in their EEPROM.
+	// Some 8330-265D modules have inverted LOS, while all of them report
+	// normal LOS in EEPROM. Therefore we need to ignore LOS entirely.
 	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
+	SFP_QUIRK("Lantech", "8330-265D", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_los),
 
 	SFP_QUIRK_M("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
 
-- 
2.54.0 (Apple Git-157)

