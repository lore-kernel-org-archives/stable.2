Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D944AA03B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151095; cv=none; b=kASgc0oFvnT81P2n5AAOD711nO3j7j4fDLdb2gaA5D7Z/ipf/U0qQ1v4q4Wm1cpKur4vWcvnlGfNan+ldZOrmKqGbTYGS1s1K0I9wkaq4+9odrGAdywKVDT39sEek0poRsmLHwkBCL5wc4B3p07VgRA7vz/yuBJyDQuUcaL1Frs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151095; c=relaxed/simple;
	bh=1LM1njdi12j0PGJlFDlq2HtxK5cpMY8FwY19TyBMIj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPWQLQ0VAbEhJGc9yQjPh4Y3lWwNLHtKs7FHi+7lratpjeLkkivsR7jTMUm6j+xR5RhTHZUw3BpVjGtEhsWUD/3DcLCsq15ZF3jnKs5LfvXkeLsy7oaEF6ozslrH04fFcq0Nid1W8y26CPRQ7+sp0VJAftxzOtCyWXUFPSPvQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRNuRvEI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRNuRvEI"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48436216a98so782691f8f.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789151091; x=1789755891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=54zB5CgKeOfrsrOhVVVkcG2Pd6Kk/5fQ65j8geodZKE=;
        b=GRNuRvEIQBVhGQvZGXroLC9MiHjbDInW2prMHl1jbc8BakQUl0ypf2JW85vdPOmfHS
         FbhPJTkeDST+emR0wZYREGpEFV4of5g2D3lYSyB0AwuWBOAVxb0LqMHsMr8iiGHC3dGC
         40tD2/Mbf/fQ+7ZMWJ/SCKpFkDB5laEVOFLjcXyqU5Vl3NPiYvBrwVN0DrNr0IUv+9vL
         kp+MBVNpqhdj1py3FpEr7BbgyKyaWleqlvHaJ3fpCGCnZQxQpftxna4bdA3x0rKriNl2
         5qvvk7YxtLiM6Z3IR+tWFx2u5iETzhbzjufTrR2CmMu36JCrwSXt6HO1M48hG7lkqiyb
         8Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151091; x=1789755891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54zB5CgKeOfrsrOhVVVkcG2Pd6Kk/5fQ65j8geodZKE=;
        b=GS8bpCj9FKQCg3KIm5xC9LDAU8Rg3ogV8ONMoleNQ4mc1Gx3X/uyqVrKH0KO9r4ueq
         3uTzTx6f92N7eYMLD35yMqzCEBCO3P8/EEeLgGtFK1+Lejl76C7HM+SoRapZpS5dRfqT
         6ITPmU0kBbLKTTsp+di33+9YGLSYfcxYV2lQSTsdDNqjMj+GSc3yJs/Y8Eli7/2YSove
         MUUYt3LPGQeieQCVDTgaJSQutqpLvNeos33Ke1Xv6F3zye0010904Vj8hpAWNuVWi78j
         qLgvBKUa4wOw5c3dOiOmpHs3yov435GKjKXe6nyKNPD71BGGf3RL2vNZNqzpFMyghPrS
         inEg==
X-Forwarded-Encrypted: i=1; AKwUvBwc2Sbx9YrJxeSs7j4TsQE68QppaQjtRLWwPgkROzWEtVQqOYFOBAmGS45I+/vLLnCV6M1oxQk=@vger.kernel.org
X-Gm-Message-State: AFuF++lVQGwYagimE6Od181IIoxNZH82KTjKzJlKJosCzyqRuAvnhrep
	v+zthbzPlnEAqfPn7CAn8QYLQR7P3Ez88AQEDq7unWNDrSocVUi/NilZ
X-Gm-Gg: AYBFou2xqfaD5ak4TX2oe5Qp5W3hyIOD5PsyQQFU0DeD2jhm7xhZFxQy9Af2S31yIQf
	ooxOWKdviqhfQP/Hw3MFCb0dzqL9TxyAl20O+jVn8zL6DsMb+NYYY2GE5Et95xFAbflzrtXsVJs
	hIUgvtrdlt+0SHCsvLwGjGFcBW3diTlSoGBQLVpuu6rvioXwmrKsMbf/4v2O183qMn8uHmAMckw
	kysr4m8oR5ug8E+l7J/HQZni1r80wlsFXpRPoLiM64XEXFz1Yih23cyVM1bNA0ZnaqCtEkAWDux
	eAkKhxv6NSeuttvdADlv8d8Vg6V+qWwFZazyoBnINNRZ9WLTwnn1RF3F9YAZFOcKztSwHMfjFEn
	vQd+Ib3BuT7be5x7flv3UAMSgcEQap63Cb/9QzMAkV8Vmu+VE38QOsiFW4XONHr6FdPdew20Q7J
	0o9lc+I5MO81egBVGSVNf+q9z6CXUz8f0OZO5PzMQAxbITRkKN4RZysTe6euhiVViCiOS93+5lq
	Gab6zLlAAyroi/FILCKGH6wZk0=
X-Received: by 2002:a5d:59a5:0:b0:486:f4cc:408e with SMTP id ffacd0b85a97d-486f4cc40bemr1428270f8f.22.1789151091444;
        Fri, 11 Sep 2026 11:24:51 -0700 (PDT)
Received: from fedora.lab.notiustin.com ([2a02:2f07:7211:b100:4ff4:568d:f2c6:5ab5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee5csm7810131f8f.20.2026.09.11.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:24:51 -0700 (PDT)
From: Iustin Ivan <iustinivan2002@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Iustin Ivan <iustinivan2002@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 14IWC11
Date: Fri, 11 Sep 2026 21:23:28 +0300
Message-ID: <20260911182328.9267-1-iustinivan2002@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal keyboard on the Lenovo IdeaPad Slim 3 14IWC11 (83RQ) does
not work after boot. The keyboard ACKs every command during probe,
including ATKBD_CMD_ENABLE, but never sends any scancodes afterwards.
Booting with 'i8042.dumbkbd=1' makes it work at the cost of the
CapsLock LED. Adding the atkbd_deactivate_fixup quirk fixes the
keyboard and the LED natively.

DMI: LENOVO 83RQ/LNVNB161216, BIOS U2CN19WW 03/30/2026

Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Cc: stable@vger.kernel.org
Signed-off-by: Iustin Ivan <iustinivan2002@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index b9ad2381f885..923f77808381 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1938,6 +1938,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo IdeaPad Slim 3 14IWC11 (83RQ) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83RQ"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {
-- 
2.55.0

