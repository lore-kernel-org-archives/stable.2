Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641C3E5EF8;
	Sun, 20 Sep 2026 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905772; cv=none; b=Ul2ZbD8fGKMjLsNeDFBaysYW2y5ruRc6SopCixFkVBDjHLvysd5w+5obVnMm18RM4HjRA3JpPhvaeqzPJqq2iVU1A5r4n6tvgesEPUO8i9e1iPMrdOUd1oSQ+LGO6oK9yo1zU58sJjljRjlnw2eyj+9UGgQ/LytmmZiAplfqLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905772; c=relaxed/simple;
	bh=EmlQF7MKA+mSQxHFuLAhipdko6cuIMhOh4NeHmdUiNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSSGcW8CRZEhUgLuGJi9agpRoAZxOLG0KkHQ3e1FFD2gBuHn6+Y/MCO6Cw0a3ydC3VBCwxn+63hTfFqzaQh8MooA7Hssc5UEJ0dBPvZlFtrAlnYchnWxEYow2Cv2XpAsJELr6zI+4LBHpFh+EAdvbh7Tl4xvsvifr3MAq6pJI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoNB6j/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoNB6j/S"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1404BC2BCF6;
	Sun, 20 Sep 2026 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789905772;
	bh=EmlQF7MKA+mSQxHFuLAhipdko6cuIMhOh4NeHmdUiNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UoNB6j/Sig6nuLWPcm+RHSGZ8zYCe7G7aIUU6lYpRikjQMtou0c3S4Gza9rungwfK
	 g4JaKV19jIun6G3vG7OMBOarxbOl83sILFwatqqzJtMRZNyUW1PrVJ22PPIcG9NnTm
	 ygpHEnyCpcMqqeOOCbouLiR1whwxP01A/nrrzXcgXBmnwElCVy87waiNTYjBn4XUfM
	 0RE2ddWTVtAiF7cVpOo5Z+kisvz/Ttj7zh6IUPs+kNbhN1samBpt9bRG1OhfsoZkUX
	 +l+f6S0Erp/ojp9dfC4mvCsaaNwXYO6oji4Y94S3XYrZX44DnnxqFUv+UuSxv1oMa2
	 oLRaYJZvbWdJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EA6C982EB;
	Sun, 20 Sep 2026 12:02:51 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Sun, 20 Sep 2026 20:02:07 +0800
Subject: [PATCH v4 2/3] pwm: loongson: Reset the counters before enabling
 PWM
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260920-pwm-loongson-fix-v4-2-41b36b3c6497@gmail.com>
References: <20260920-pwm-loongson-fix-v4-0-41b36b3c6497@gmail.com>
In-Reply-To: <20260920-pwm-loongson-fix-v4-0-41b36b3c6497@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789905770; l=1375;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=NyDNTlsnJdK4cl0ga4IeWZLMrmPfP3DVW7yBKqicjC4=;
 b=/Ly+hsfIlgz3pdAE1Sn8R2ixiFAUhwfEbv8E/4H2cjhVMkTojBjj4aAHFVbxAza5y5pS40oEg
 fvjNVzJg++YCwVn/bKGFN38eCoq0TFqK34L+aGve13mcv+iqyi0Gy61
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

The PWM controller may retain its initial hardware state when the driver
binds. Reset the counters before enabling to ensure that the PWM starts
from a known state.

Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
Fixes: 0de9b836a3bc ("pwm: loongson: Reload PWM configuration through counter reset")
Cc: stable@vger.kernel.org
Suggested-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/pwm/pwm-loongson.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 7af5d4ce1060..977d867bdb8a 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -110,6 +110,14 @@ static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
+
+	/*
+	 * Ensure that the values of LOW and PERIOD are sampled into
+	 * the shadow register when the hardware starts running.
+	 */
+	if (!(val & LOONGSON_PWM_CTRL_REG_RST))
+		pwm_loongson_writel(ddata, val | LOONGSON_PWM_CTRL_REG_RST, LOONGSON_PWM_REG_CTRL);
+
 	val &= ~LOONGSON_PWM_CTRL_REG_RST;
 	val |= LOONGSON_PWM_CTRL_REG_EN;
 	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);

-- 
2.43.0


