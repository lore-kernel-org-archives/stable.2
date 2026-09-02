Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76873A255F
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381426; cv=none; b=k1tA3Z7k3d4Aph2OMd7dV+2Yz8IxkIhNPH875MK7RT3KUEXDIscByrhzqfen5BgEbaYL/A/9qNI5X7ScxMxwq6bouZyAk7RkqW9yHCUnbAx9zzCfC8BaZo/sxjK+I901v5uP4Zcm75w+hcPvLKCw8rgDnz5O5XGd9DK2fg5LYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381426; c=relaxed/simple;
	bh=HCyWfdZphcYau0fYYUAqLOKget0oXna5JKrdT18pOyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sP382X7nHzXqMypDkvQ0gRV2MOP2YBTTMY7p5xsy3lPwaqjjp5kRIuE2yG6whyNknLCV61YIdtiTX2AwMMkKoKrSJo7z6x4OpZcko8N1g6qGo6P9NBHwm5/ZiYKTfPPH6bwwmOfdAson5gmE5M1y2dHnMI8TWM8vQmog/Cr+7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+ZB5qN4; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+ZB5qN4"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b396d2fb9bso832580b6e.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788381423; x=1788986223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pab9MovL5V6IqQA5mU5VDCmIqD2b0v4m2h5+1m/xuv4=;
        b=m+ZB5qN4NQ/blbQRCds1bNgZmmZKAHTMAQ/jf3RN3vJlDV50Pfp6/bg0bj0/HFfTNU
         2kbHRSK9v98r4dQa63f9+EYoHi0gu5jbBojRMgJmjI3hwL95rDkFrYd1q10wu77vqwQ8
         yHjEyDiQEkCkydrj+Cysi9AdXsdq1ZGyqQaXYHQFFqt5woR1EWyWGHOlFwxOLPUDgSJg
         xrSslccOXsnV619yJWPfePgG0ie9l8+XXmG6ax0a7MTTUSApbiRTjfufx+3/S8zK6Ws8
         QEHV9P0Px63rmcaB8wQLH0kiMrz3SzuEv0yEOimyF0gwvV7zFIfl+tUm88IvorYDM9kr
         6lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381423; x=1788986223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pab9MovL5V6IqQA5mU5VDCmIqD2b0v4m2h5+1m/xuv4=;
        b=RNrQ+FXAXyvQdyrf9nn9CqlYWsFLEgV2jZlV2yvvLPmzFDyAvHn9mIM9GfyRGRDr+h
         uIr8g2f56xBZ6Xhu5LbvOM267mK17xD5apK3lxpNjWBufHW21O2BsDXFoZ0oryI5HLZM
         7y6V0uhVLDqM1cG2wKJy8bf81dtXRImlsgv92OAbnxQBxspZcJrE0Pl8L51e8KltaG27
         eJOPPfqZ3w1/qceO298LqY90yQwdL08tO7y2KyW0X51Kz0Zv7HMD03fjUbT7QMlLYNSm
         cj1w/AGWY/72ZXLqAAEKxPdpXPPR/rH0lRNPVlaVGB4He0lU7APVUum0CLvl6TGY+3W9
         c89g==
X-Gm-Message-State: AFuF++l9xusK6eDUwnspYAYGkLedcwW1ArElWo4QQWZY3A9YnXkwXf2s
	vwUt/1jozqDXDS3uGXYE/3oA3q2C8411mLXmUDP2C4iSMR9BfoWnfSwrXGK2sHPN
X-Gm-Gg: AR+sD13GMtqZHXfco+odyXEWstdPk+LCbS1C62+Ya9ImYzXnd43tOVD5wuL9B7ni519
	2xCmFzFxSiQkEEazUlpf0+q+zMbAKSlRsiBp2VOUkbelP7mkkiSfngMRORidjHZmkaTycO46WLn
	iIsFApHsiJF/j8LYR/UKkqs2fbGo8JDMpZjZA5TDMSnpecI0BObIoD3Odboe5mdweFNOOrGsGtU
	AbN44TefxhDvAx5pYcIDS7DfbY9vyqG67zSJgp/GiBQa4vP+qa5UNJvkB6/X8IbMbaghn2rFcBK
	i1zds9tJNztWX4Vuit3qbvA/Wiy8bTvBv/QZTY/kxldAXg5G2FQEgQSBp6LdjAkJ5bvz30fGPzB
	9/fulKg0XCZu0mzmSgqu+Mm8TrT3DWy/S0RPmZAc41t/fSNk7Q5zcrQYkPIS+qX3tX5rvXBZQdO
	cV/OPP1fc9QivwnwZpPxDAEf4J2Cu9R3S9GTnx4x9tFDoR73mADpGVJvqUgResQ5MrGfaZsHF8q
	RY=
X-Received: by 2002:a05:6808:250c:b0:4b3:880a:f08a with SMTP id 5614622812f47-4b6bee6b1bfmr5791576b6e.15.1788381423310;
        Wed, 02 Sep 2026 13:37:03 -0700 (PDT)
Received: from localhost ([2600:1702:2f06:6c0:72f2:e1f9:8fe4:eed8])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b69b215f1fsm2820048b6e.11.2026.09.02.13.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:37:02 -0700 (PDT)
From: Jack Boykin <jtboykin.jb@gmail.com>
To: jtboykin.jb@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmf: Fix power_supply refcount leak in amd_pmf_get_battery_prop()
Date: Wed,  2 Sep 2026 15:36:33 -0500
Message-ID: <20260902203638.60139-1-jtboykin.jb@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

power_supply_get_by_name() takes a reference that is only dropped on
the error path. On success it leaks, five times per policy evaluation.
Unregistering the battery later trips the use_cnt WARN_ON in
power_supply_unregister() and never frees it.

While here, return -ENODEV instead of an uninitialised 'value' when
no battery matches, and stop at the first supply found rather than
letting the last one in the table win.

Found by reading the code. Fix and changelog drafted with Claude Code
(Fable 5.1) and reviewed by hand. Compile-tested only (allmodconfig,
W=1, sparse); not run on Smart PC hardware.

Fixes: f4627dfd0e19 ("platform/x86/amd/pmf: Add support to get inputs from other subsystems")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse
Signed-off-by: Jack Boykin <jtboykin.jb@gmail.com>
---
 drivers/platform/x86/amd/pmf/spc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
index 94355b435..ba852397c 100644
--- a/drivers/platform/x86/amd/pmf/spc.c
+++ b/drivers/platform/x86/amd/pmf/spc.c
@@ -199,13 +199,11 @@ static int amd_pmf_get_battery_prop(enum power_supply_property prop)
 			continue;
 
 		ret = power_supply_get_property(psy, prop, &value);
-		if (ret) {
-			power_supply_put(psy);
-			return ret;
-		}
+		power_supply_put(psy);
+		return ret ? ret : value.intval;
 	}
 
-	return value.intval;
+	return -ENODEV;
 }
 
 static int amd_pmf_get_battery_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in)
-- 
2.55.0

