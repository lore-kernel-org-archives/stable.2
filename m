Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FF37C927
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791106189; cv=none; b=R7zzRtZsSKWY5W4CdHgUJjGRVaRC9tEE9LTnbrNxlQI1bDXlpbqTAKc2tVSVcUaZOOVLWrR4IOT3Z7PI3r+XWVNZODobSc6YR6UVZpaDniC23ftKyPma7JSSbyca1aIZms5qI9LUw8KlNTq3CI8ydBjn7wKfKVvGBEXRNSdsEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791106189; c=relaxed/simple;
	bh=uTtx0l1HHsAFJjLNQjTtCyXZsSBtULLvmmCHXD2VK3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIl62r24iMsaf8iMgWRndqhA/LM55/0O2B5bL2/0eGRI0HHS8eU241jGy0/dpDJFyJgjk36hs1QmMxh6kG35xDrbQgBhlPid5Gr9+jWSeQsth3q5Xu57HLJw1+vFHI0eEIj/ldQTH9ylj1PbDJHYoeRuSFTtip/1wY0WA6UAWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeZBk1J9; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeZBk1J9"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35122ae71e9so194061eec.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 02:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791106187; x=1791710987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IpxHW0dymvquaBBo+LpsMAQTPRzz86ngEyqNy+obi2k=;
        b=KeZBk1J9w6KEJt0sKNCOzn24agVfrAeAtI37rh/pddA9j2DSIiK218dr53Yq8lvG4h
         5worINRWnXnntjRR3Eeb3y3cn1HNF1KeidJWfasT87vkdL0yKrMVUD+nT5YJbORhZIcH
         ++CdBuOCOEPTfLWXIMuLaQwKqhovbbCv1z7QOU2Gk9BYZKKnc6K7wzlbOypa8BKQupHv
         GJSayPVvgJXoEyGCxkBLx7ucwVIuuDvyZ+89G/38BzS+E+4tblSYkRRZSQh6Jetpp0aj
         IBhYOCMDUvwvwptUbtIIJ/rt+BwTizaU4/LJ0Ui9aUOTM4qTtzCdZLwWhI1Nl0WB186i
         unyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791106187; x=1791710987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IpxHW0dymvquaBBo+LpsMAQTPRzz86ngEyqNy+obi2k=;
        b=H+OJUz8KTMrSYliRCs/+glScAr0RJAGFBJGdF+zywQOyj5WGKDB+GvaY8yxtDu2FIE
         IBvd8mHreAhXWWO2dHd/R0qT48YHnUdtw9BDuUHI+ncJ39Jx9702awRMa2os+xFbail6
         0r4JVg3KjHXiHBzJdmR/zJSeToLPLzOF2nq+2d16FT+TWkpfhtD97mvijP5Ep7QQBvb3
         o5ce8CunA5ykVgPNbmwGaM5kqpqynCepGEsyqLefQzWSOS8ByWcmv7QKGRIJ4TRlm48C
         fUPS6X32+jpUhGp8Od7ZOfe1wMkeLkKtuvOFi8IntrpgQbtOxFAtIVJrGJzlHyWyShHM
         w/hA==
X-Forwarded-Encrypted: i=1; AKwUvBzPndYKVS4peJQi8nEMt3CuKFBk7AsuwVTkM5bmyFrs16KgFAaO/uRf+sLyhzNoT7MV3/3is7E=@vger.kernel.org
X-Gm-Message-State: AFuF++keJ4Y/ITFSx6fRKrhvmF6gYmCi5k9Gk/qonxpv/IMRJS6/y+BQ
	Yc5tEdo+YFtW2i8A1ub1XNlLc8rc5ie1XJkhOFROMfC05f4wViSro/yA
X-Gm-Gg: AYBFou0vGk0PvXfNXFVHe3NkhEzQQ123KH63hmrxhUJrWPlqWoX/wwoPsr6i0hf3uLL
	gFqSedoPKehKpShT/F2MmQpt2vAEyXpEdOZadgpXIIZDJ+cIo3HqVYoZRLEIB8WhJKGntkAeM41
	5dNH9yI4PIbzFhy5SGsH+tc0z2vMsUJQPshQ89wbgvO8ymUxh7U3aoSQJL6XCCwU1C0c7stvy1J
	d8gcEu8G1mkPuoFqz5EsbfnQTE5NRRZkSwmHEBtBN1AUMJOqA8B0vc1lfIG5UVxLsVp5JIBngCb
	p/TAWxXvj4GB4Fhb547P2C2IAULYoL4P+OIk7c0PBoac8hO3Lvc9mbAeRnxqeY3k/mRaqgtPe0T
	GjVM2fgf6GsUDNOzC4aCIrBgd+eSb8Sj8WZdf9V3dZURZ1OvbHSHSX+QS3r6s1GA/BdRn7fxbWJ
	RK7lmMwTmRD5bX8eNtR3cEXwdUt8AFQV5rOof6yac/O9aOsXTPqi+kMLGXBsCPM9Pff1fhBlWKW
	GWuBnXz5v1TJpD2DUgcr8YD
X-Received: by 2002:a05:7301:5408:b0:33c:e82:70c9 with SMTP id 5a478bee46e88-34f21985c14mr9323585eec.32.1791106187024;
        Sun, 04 Oct 2026 02:29:47 -0700 (PDT)
Received: from chitransh.. ([106.192.245.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35128156e6esm3811945eec.20.2026.10.04.02.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 02:29:46 -0700 (PDT)
From: chitranshmandhaniya@gmail.com
To: Chitranshmandhaniya@gmail.com
Cc: Martino Papero <martino.papero@lcb.to.it>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 15IWC11
Date: Sun,  4 Oct 2026 14:59:21 +0530
Message-ID: <20261004092921.69410-1-chitranshmandhaniya@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martino Papero <martino.papero@lcb.to.it>

The internal keyboard on the Lenovo IdeaPad Slim 3 15IWC11 (83RR)
does not work correctly with the default i8042 settings. Using
i8042.nopnp=1 and i8042.dumbkbd=1 restores keyboard input, but prevents
the Caps Lock LED from working. Using i8042.nopnp=1 alone does not fix
the keyboard.

The laptop works correctly when atkbd_deactivate_fixup is used instead.
Add a DMI quirk for the 83RR to enable it.

This was tested without any i8042 command-line parameters. Keyboard
input and the Caps Lock LED work correctly, including after suspend
and resume and after a cold boot.

Link: https://lore.kernel.org/all/4f43465f-98ba-4722-8e29-03df20315369@kernel.org/
Signed-off-by: Martino Papero <martino.papero@lcb.to.it>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Link: https://patch.msgid.link/c0b597b8-e7ad-4fba-a2bb-5d252e3dfbd3@lcb.to.it
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 2627434099ff..15ae5352e14b 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1938,6 +1938,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo IdeaPad Slim 3 15IWC11 (83RR) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83RR"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {
-- 
2.43.0

