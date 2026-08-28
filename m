Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E943DAAC5
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787916174; cv=none; b=UwOTJwysOAz/KRnrYd3woxC2pvlDujKN6zZgo5m/LGP2z8CCXWREG/4WtWfWGMlaZkCSNzLx7/S73T+PDmDa5ce7T0dMphJSxYFT4ftRuczNhszUzFvH665lEFTU8Num6hEz0SPeG627yyuj9LW/hMeTJws26UfEHVAHQZT81RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787916174; c=relaxed/simple;
	bh=OxFQh/aLZ1OUP2E1LefOggZ7DwLj/Zk0YBH/aEcICnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARwENd3d4LAP8LynvJF8SEbKAXJIbU0oFBIZza96tAl9L6fyX2nffpNsz2xgYLhGgp8m9s8xO2GFPWplMY1u924dfhsrg1SlYPCxb7/u1KmOUl987OgYLKGhzf2Y7/M0MEKhSCwANHjCLHq+zqrNi9Z3fwuo4N2eyJL3ZIK0MoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brZEtbdB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brZEtbdB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so11821545e9.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787916171; x=1788520971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1FBr2xjXI0W0kVvyJ3QGqA4i4KCrVvOwh1gtI60HpT4=;
        b=brZEtbdBgVvv/bmqZ59/aDSktlynXGJk3SDskdXYPh3MVXvdwpODkxpIFjhZLrkcin
         4FggJ2PxPLaeuNN1DQS8lbzo2id/0+wzPZy6p8vxdvyQbbWX6qLBzXjMQqLkq70TwfRn
         kldTdjCyb6ASglyuqoYkFJCsZKDhA/OMl2WEI+ZhMGrDQxe1JAPCBY7j+ggBudvkVNeb
         NxKJIFz/ck41YI/qPWcHPnbEYVljkm4FAvnswqzUb1f9qfrL3diK1TA8lD8LCy79kg60
         ocIAQ/cd/hB2jQngdPf5FWIoTSdEjkXwVaSGuQLnallpSO9xXQQRdvpLPxuYTAPXuI4n
         t0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787916171; x=1788520971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1FBr2xjXI0W0kVvyJ3QGqA4i4KCrVvOwh1gtI60HpT4=;
        b=QcsYWnQTDcCyGfHk4OclShFrMqv8n7DYnQx2fLKT4dffrEa3Apgk7JPIb+SldBnANk
         n929OwX1OaFCjE7MLMGiZdoxJT6I05gxGOh4NcMceu7MuQJkM/sNihq1phY/zBTwoIa5
         5LPaUAVnLEC8G0pVVxc24eJ9pHgGwpWLNBEmfLToJbXSuQLCR+exgPEgcZ+TjIPJ5FPP
         ZsrnfIDX9Q5SSQJSuIk8OS4Em7vkJQL4yVTCn34fPS/3yol7gxScddIEr+ap7NUm00/P
         mL/W0ZQ+b9RwTVMQx7IfbFvYo3HfTOEdqVS5zc3uzLHiNsin33NruwZ8jOrg8pWZBZaR
         K/Rg==
X-Forwarded-Encrypted: i=1; AHgh+RqOkHppamop4QLIxRknNPID8dou3F1ITxA5RHGm6h0faEaHL+4i2DWk6yCgwmpOrmiXqyJpSos=@vger.kernel.org
X-Gm-Message-State: AFuF++mApbc/VbHkHaa5QwudNe/XMqO+DB9OfYHkAf1xMi/kWO0NwV/m
	59CWudyciCH2RnO4m0mQvf126E49BrjpJYfsIUGBa208kM+39bXUj87sWyeNFfo6NmMe4Q==
X-Gm-Gg: AR+sD11FilY5dW1gq2sDeDvAyg+7Mbps5vPWzM6E4xv7ak+pzphiuuOUhvf8NAVHgnp
	fvn5PtoigmB5pnayfK139Fl/6df8w4ckRHMOHIeHJNLmAe4Fy6ebf0Pn3yWaGFERW32jSYnQw/l
	+nRZ7/lvyVfesJbH+Vbwlchbq2v8LfdkbWs/9Rln69K/5WrX3sFa2cLDG6NhmT+IlmrzpEEEMl/
	PIFp6aVylQl1CwihC8LH9ILa3be2VFrcyJ3Q/nYaiLzDNKSqYJunhhzEOwJfmNpZG1UPxMWqmmL
	6cdGkerQcAbbMQivmIIGab//s2pbD01s8pbfJj8rGBKk8rXR3MntcdFFBGPj5FCabJ3iZCfSQ0C
	+Gg/G73a7B81BJG4a1hvacJCEwPZF+dnRQYLfcpMHkDturjikkzy08MH44gjE2cVgNSMbH3LIbx
	DDyMSCSbJoL3HHJ30tsKbA5GrLTI+qCGv3B5bo473EhxML+FieBdOmOTp6+j4WsLc=
X-Received: by 2002:a05:600c:4f95:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49b91a2b7eamr64094345e9.1.1787916170837;
        Fri, 28 Aug 2026 04:22:50 -0700 (PDT)
Received: from cachyos-x8664 ([212.227.119.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b95013d1dsm40237315e9.13.2026.08.28.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 04:22:50 -0700 (PDT)
From: Alexei Turtanov <9alexei9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexei Turtanov <9alexei9@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro 16 2026
Date: Fri, 28 Aug 2026 14:22:39 +0300
Message-ID: <20260828112239.18081-1-9alexei9@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal keyboard of the Xiaomi Redmi Book Pro 16 2026 (board TM2425)
does not work: atkbd_probe() succeeds and every command is ACKed, but no
scancodes ever arrive afterwards.

Testing on the hardware through serio_raw shows that ATKBD_CMD_RESET_DIS
(0xF5) is the culprit. After 0xF5 the embedded controller keeps ACKing
commands but stops delivering scancodes, and neither ATKBD_CMD_ENABLE
(0xF4) nor ATKBD_CMD_RESET_BAT (0xFF) bring them back. Only re-enabling
the keyboard interface at the controller level (i8042 command 0xAE, or
rewriting the command byte as i8042_port_close() does) revives it.
Running the init sequence without 0xF5 (0xED 0x00, 0xF3 0x00, 0xF4)
keeps the keyboard working.

'i8042.dumbkbd=1' also works around this, but then the driver never
writes to the keyboard and the LEDs cannot be controlled. Use the
existing atkbd_deactivate_fixup quirk instead, as done for the sibling
TM2424 by commit 3a046db33bb9 ("Input: atkbd - skip deactivate for
Xiaomi Book Pro 14's internal keyboard"). Tested on v7.2: keyboard,
Caps Lock LED and s2idle suspend/resume all work.

DMI: XIAOMI REDMI Book Pro 16 2026/TM2425, BIOS RMAPT6B0P0909 05/22/2026

Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Cc: stable@vger.kernel.org
Signed-off-by: Alexei Turtanov <9alexei9@gmail.com>
---

Notes:
    The DMI match is deliberately limited to the model I could test. The 14"
    Redmi Book Pro 2026 most likely has the same EC and needs the same
    quirk, but I have no unit to confirm it on.

 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 4c82e98..5041443 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1954,6 +1954,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Xiaomi Redmi Book Pro 16 2026 (TM2425) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XIAOMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "REDMI Book Pro 16 2026"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
-- 
2.55.0

