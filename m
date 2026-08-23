Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D4368D71
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507959; cv=none; b=urNBq9r2wN7AInL0bKJoEAjVqRNTbOW6IhBrtO9y/q3NbSEd87omOonK4PpiqCchVuXK8C5Dc10b87Ds7Tj7nE1G4Ji8+y32zXGSP+RSfgbSl2fanaqztPS+S3/sGZU8h0V3RVodxy9yz5b1nOUQBqeBw2s2JJWRY7CvkC/GXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507959; c=relaxed/simple;
	bh=OLd9jwlnqoCKmW05aLl+FzhuGsqsi3L3dHXRNy9HTLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TC1eNhcnj6W1eBrvFkRmmF/LiF7FaEopvHyT0wPdJuIG27Dn8nFM1NyryuQASVVpqiK4Radl7N7Cj7TpoDZiCOAS76EKPm4nuSB0WzsXriOloJnl88HULk/neW1DuZn/q9m875qOMEHR22nWL0Rii10/oe3BwyHZVVkk3WVopn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCM5N3IQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCM5N3IQ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a3819e8be8so5766614a12.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507954; x=1788112754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qm1o//RsN8ARpvy9uYBLbnotafV4ghP1JDsyKT1NBig=;
        b=mCM5N3IQj1JRU+PbU0ZRvis4itS6zEYzfPHvIy+RIt6++uGLJovzoSu8ce5wt4d1aE
         HvtyEwsLbSdHhqL+qFDOobanwzo9iiFht5fkx4CGBz4dpSoNdLxNA/a6nc39waq79J8L
         z7ytypvX4jmJKBbJiGPIBnkYOzQrKVeI8DkARd6NQN6R83R9qTYIwgbbJZY+u1dbooxJ
         Xxupd2hq5/RBPIMvpHVvz16tuNPBv0R7kLfTGQ8ils8qraUcaLCyUvMYlpauCwmWTI6k
         qAQAL2XdgHX/iuICEFTqGf1RFwHkpZCd2WsN/JZvxs9RVyRUaeg6QbxT6mMoQSx/NP2w
         96Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507954; x=1788112754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qm1o//RsN8ARpvy9uYBLbnotafV4ghP1JDsyKT1NBig=;
        b=HZ+2c3oUYs3DWaimH6BuT9BONhrK1vUgyQLbeJN99w+jcHYYc52IXLP74yfskDGprA
         5WPK388PZvufKzWVVHO1n7C5MahxtvaxFldvP1kD8bfPuQNlxhc9PknNMmVEP22mhFSc
         hd15ckuU9I3t1QatTa2FkKvIbyNck3HjbdlsEbFmgNqHoLcySgiIhgCe7F2v7emHxxxe
         5QpSlaQYiRWoeWkWSAGBZeWXkBDbn5SX33ZUQeTrsTTtl4wRGJunAoLHatU7i9k989xI
         SreStVkb+TymRmHoSC8+s+dVeQWjNe+s7VEVJIIm+qL4pG6CUy3xLvALaUb2vgJ5wPqs
         6aqA==
X-Forwarded-Encrypted: i=1; AHgh+RomeYp/fQPCN1U1Yh6CEGQPKmFUq+mPv9+eH3d0UMDwBEYKR+dF+2Em43Mt+6QUxRpp+poUItI=@vger.kernel.org
X-Gm-Message-State: AFuF++lIFuSCMoXlnEjOPXWbd7sXGkTCeUEkLxRlfjWD9tiXZbSg4Pgm
	FXLHBvjy3VDjN6zhHIgxd3YmJdG8s5w+AfL3FVlBgMrYGUyczipb6pZe
X-Gm-Gg: AR+sD10DcTVbN+PdUFBdg1ii5nx86k/2PvUvO5PUmQqHw788bxsGooMs9k/TFt0Dxbg
	UEY9dEdVq6zncjDebfjdD4ELPyfS0dHZ1i9D49IKxxLjCrTWtWK4ezLf6FyM2zvHzz/IPvSfPhM
	cVmrNujg31Snpz9qTd0RAl1rLXXUJQ4DP0FILCvc5fHsrU2NnfxRGHCzGc0sh1FVl3yLJlJ0ytb
	Mz13z89eW11yaBOMt+fJWncQh7ZYT8CgjISkO3QVe4Y92+WVBMy01eFMSLk+16fy//wbTCiga78
	nu2Q7B5GX+K5AdnJ4mcxoGSrapZB02YePPYJrwtU4oZIK3UUBu94z79juAj90Zs/vI2vkmzwPYL
	hK5w45gvHJzmHyZHj975Kj78v4EjuBp2SBLZtQhe3Pd+k//SRHbBGJENvpEUeye2+6lMxnBAfqx
	yb67LrhpI9UMbUcOv8GMielapuk0OYe0VBrpqgohS/iEYomQZ+2x0OG8uKH7+u3u2KhKZ8THnRp
	CSTdA==
X-Received: by 2002:a05:6402:52c3:b0:697:8b0c:36e1 with SMTP id 4fb4d7f45d1cf-6a430bf0c5fmr20193459a12.4.1787507954379;
        Sun, 23 Aug 2026 10:59:14 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:9afb:38d7:b606:f380:289e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199cb8sm4153933a12.16.2026.08.23.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 23 Aug 2026 19:59:04 +0200
Subject: [PATCH v2 4/4] hwmon: chipcap2: serialize access to low/high_alarm
 indicators
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-chipcap2_locks-v2-4-6a26c8e9e2fc@gmail.com>
References: <20260823-chipcap2_locks-v2-0-6a26c8e9e2fc@gmail.com>
In-Reply-To: <20260823-chipcap2_locks-v2-0-6a26c8e9e2fc@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787507945; l=1558;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=OLd9jwlnqoCKmW05aLl+FzhuGsqsi3L3dHXRNy9HTLo=;
 b=wBQvzQDC8odzNuxzagOcjihZm5c0lGbgrQQo+evF/jVZS/Mn2j1GIkc8cfunXhm5Us1debSId
 84Vva+ooobHCdbsSBNw0XyH+vY2mIXHH+J6M+u6fiyyv12b0Ywgnwae
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Access to low_alarm and high_alarm from the threaded interrupt handlers
and sysfs is not protected by any locking mechanism at the moment, which
can lead to missed events.

Use the hwmon subsystem lock to serialize access to the alarm indicators
and update their state before generating the corresponding event to keep
a consistent state.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 57d22d65612c..0a56c55e9394 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -495,9 +495,11 @@ static irqreturn_t cc2_low_interrupt(int irq, void *data)
 	struct cc2_data *cc2 = data;
 
 	if (cc2->process_irqs) {
+		scoped_guard(hwmon_lock, cc2->hwmon);
+			cc2->rh_alarm.low_alarm = true;
+
 		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
 				   hwmon_humidity_min_alarm, 0);
-		cc2->rh_alarm.low_alarm = true;
 	}
 
 	return IRQ_HANDLED;
@@ -508,9 +510,11 @@ static irqreturn_t cc2_high_interrupt(int irq, void *data)
 	struct cc2_data *cc2 = data;
 
 	if (cc2->process_irqs) {
+		scoped_guard(hwmon_lock, cc2->hwmon);
+			cc2->rh_alarm.high_alarm = true;
+
 		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
 				   hwmon_humidity_max_alarm, 0);
-		cc2->rh_alarm.high_alarm = true;
 	}
 
 	return IRQ_HANDLED;

-- 
2.43.0

