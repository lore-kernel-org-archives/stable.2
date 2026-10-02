Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA8453A3C
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977463; cv=none; b=tRRkvusp5vGLdR5B0GaubOj+7jy8ypbmsMFRE5ceWMvw1TTMqtXaB1Wk1uaO2guee/xO96zEt2laDQONYdL4Vg14PO4k04aVyraw1HLK6QbmrRkkNEXI+iRP+ZE7M8uY4kneC9aDplJikPSQJFyQQidvJto4o3AScP5HJWJP8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977463; c=relaxed/simple;
	bh=ZCaeiEXn07+Csr8kWh7m58CfL0dqAr0onVKjEQ2TCUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2OcfeL43KhPrUS+uYUBtffiojvzcWb/kRzjRbHR/lbmgQCLebNq9C0Z0p2BWRH+0mGtn37n9p3a9Jzbe22akAp5a2Dw/rrp227xGTi1HD6f2QR07RPNoKnILMNI3dWRkK0bC165PgaiSrBnoipP9cQvPf500W+CGnmnNISCH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTpEq5QY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTpEq5QY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5338c1197easo197291cf.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790977461; x=1791582261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=731GWBd8bmU4NH2SwdaToIMYTPusA7UXCs0lvTfehWE=;
        b=aTpEq5QYLS6xiS4P0Qjvjklm+3wdDQqV1rXFmSgeQNcLXmLqmdrThNDBRmd/fEzoyZ
         xnjg8u44B5JaKFwTaAKDvfJEm0h6R3De5UP7p1QDVu4ResjqClhtv2tL3RQ6qDWocgmD
         47GEpowVFAb2lI4bl895oBqdDQtgniBk0GzU9bdoEI0FC2Flkd3P08SSrYX1fcGXZ8Yd
         srQ4uWXGSQyn/XIeuW8KzuhfOfyrIQxkZaMzjGVhU/TnOL6L4UrTLDNFzP8ACHEsKDoV
         ycJ9o01EsGNl7T8CYp/PdTDYKYw4kMyJGfy2JPnkThErGaTAEHW2fPf2evdEkS32uaW7
         Kyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790977461; x=1791582261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=731GWBd8bmU4NH2SwdaToIMYTPusA7UXCs0lvTfehWE=;
        b=ovm3UZWiR/+30ldOOMzj8DYZMEEo6UEhsGgyhPkla5vSpnPoQ+Rm0mrxb33b3p+/yy
         bszOxj5LuZB9VeWYpxmwfwxB+OEDeMUo3P7aBe4ff6WhbiNwP0L/v8Gl6dInAwDiWO+f
         fsEjzHFTxm6lHq+XStHOzoQvdSRABaW3y2Be27kxxw5/0P0w1uwF6K60Jy5KrKDBe2xi
         r0hh1lwEqM7nr80KHvvOUv3mDP+wC8VEL/7K/wnZ7IQ49PX56q8Hmx/JlGAmWWLVE/m0
         rt9YhUMMrBWUfbUiY5Dj/iDwV+DISctaNdcUqCa1y6AztiK4X1iCngeO0DsZqa1NrKuW
         2r4Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6TCUK3kwTa8NparV7EJ0/m1Pniy4xj8BeOiZeJtH6DvBy88LQ5GsYZth0D1Ql+NDioteneho=@vger.kernel.org
X-Gm-Message-State: AFuF++lCT3I34Om2eZmRakWIDbJXPhW2BTnVzfUjQD6AQOX/oE79QVIO
	bATRIak66eejxR9Y8DksSFbGlADA3S7A6kbdXFAdqJAsTrzPFI1rHq0=
X-Gm-Gg: AYBFou2d5qbAnczl0xjhMaJi4SWPBF8GcMgIOlZNrradKgYCtDQF/kgVycLXTQRICJV
	r9cGapNs50kFVgGaDxxO1WZ0/UFYERL/PNWUgq4UB73x9hjt970Z2drliPEPybpnZcU73jL3LKx
	sonY3+/0QCYfW42vKe6Lcrz8rdD4LP7ADLugkensg41NbcQ1e1/p94SXPq0aF3k9PU7e/wIjL7e
	pAkVd5lxXOZSb9SlTHakAyrgbiZ2dPm6vWI2Io8zOJ9NPgN4Fx2qabVCg3mAjUtRDXraiWgq33k
	YcZV/2cw1hpoItZxWct5M3ujIl5jPLo3iAco5AY9MMh7ggtoETFp/+mZexAV7ifoCUcKOuykgot
	BZkQgmKFqRdKhJh5Xs7z/DglQuhFaQujcXryxq6ZtLrG5Ki79Xb0LncEVSMDU/2X0UXlw7Udyqe
	E+5qyyHzVFaPoUFk3qGb5A/PTB4YvTGPL1Zd45bLzwMD8u1pSCC/K29hFTgTi2KJelpSVG2jbLq
	W+cE7epDNdrcz4QK59eYM+M1Q6TxKa8DlZL8IvplGx0SkUXYmYa1hFJ1Tu+KRCdD72Oo0VBTKcb
	tT31ipaFQn5BGTctl44W4WQdBSDuo5fUICWt9S0=
X-Received: by 2002:ac8:5a46:0:b0:535:958:b9c1 with SMTP id d75a77b69052e-53511d18e2emr12544691cf.11.1790977460535;
        Fri, 02 Oct 2026 14:44:20 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398aa36e6sm36669261cf.15.2026.10.02.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 14:44:19 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Rishi Gupta <gupt21@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] HID: mcp2221: always initialize and cancel init_work
Date: Fri,  2 Oct 2026 17:44:16 -0400
Message-ID: <20261002214416.459795-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The writable gpio_mode_enforce parameter can change between probe and
remove.

If it changes from false to true after probe, remove skips cancellation
of init_work. Pending or running work can then access devm-managed
driver state after teardown. Changing it from true to false can make
remove cancel an uninitialized delayed work item.

Initialize init_work whenever IIO is reachable and cancel it
unconditionally on remove. Keep the parameter check only for scheduling
the initialization.

The false-to-true cancellation gap was previously reported by Sashiko.
We also encountered this issue during our static-analysis research.

Fixes: 200e6c6e94fa ("HID: mcp2221: Add module parameter to enfoce GPIO mode")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-input/20260715143415.916A21F00A3A@smtp.kernel.org/
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index d52ce3531ab706db8ec908d57ad0383af9fafb1e..6515692b408ee7b6ee318cfa3f240321c133f2c4 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -1072,8 +1072,7 @@ static void mcp2221_remove(struct hid_device *hdev)
 #if IS_REACHABLE(CONFIG_IIO)
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
-	if (!gpio_mode_enforce)
-		cancel_delayed_work_sync(&mcp->init_work);
+	cancel_delayed_work_sync(&mcp->init_work);
 #endif
 }
 
@@ -1347,10 +1346,9 @@ static int mcp2221_probe(struct hid_device *hdev,
 #endif
 
 #if IS_REACHABLE(CONFIG_IIO)
-	if (!gpio_mode_enforce) {
-		INIT_DELAYED_WORK(&mcp->init_work, mcp_init_work);
+	INIT_DELAYED_WORK(&mcp->init_work, mcp_init_work);
+	if (!gpio_mode_enforce)
 		schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
-	}
 #endif
 
 	return 0;
