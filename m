Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633803;
	b=tt6gqgrEJgLZy2nKitHVUYqPeGa7SQ45kIzMatwf1s14MKAObB3oSO5jd/gbzfLi0VbV
	 aKeFN1uOzmb2kA3vjm14JU4/Xt8kMHwXU5aYEogdEhRRiqbcfN7na2fVq+oeIbUciecWo
	 rJVWcoQ1pteLLo8R/lB2amxeY+cG8ne6ZHCeNPRs/zfCRPMF32PzxLbnvzYcI4oNtj8zh
	 hic70HU1hDOktgJY+ac4hETmkS/tzvP2EHp6lc3v1TJvG6W+6vYzF8CXBBX4WDvoULbHu
	 5x6WHGWXxYgaG8fgRgdCLzG0SKZwfsXgOskRsf8GHeG5ZjV+8S1gslxAfsGIPRI/DHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633803;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gOpgw26BkAM6OVgsQ9x/EjM0hqSkQJncuegsJomBOso=;
	b=o/iqaZvbWw12g2xJOPSFvQwMJ3+OkegQ+P7/MOThbLh5uMAixTd9+kN8pLeBB+5XVay2
	 jKAT47cZxG2ALOsv9N/VVUHSCKxtznT+hom0QwhK0KvmiRBFwGgdC8T2NMmRNYZ6IFgOw
	 RRGDprZtFhHIa3B56OJDolhSn+x4kCS/uDqWpnbRAOPaq/+XZcvPz1w+Lc9SfzO6F7aym
	 C6LCXU1sax5AeNwARj5MUbryD3JpcY/kPkv2N4oigZ1XkmI6N10T+UOxYiWxhUiChpDSU
	 rvYJv11TEl+/b2lk6dXi7GZMe5g8LQ0D0VQ+p/uRmrb8xzU1nijFX7Edwc9PQgYL9WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHtCbpuA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D3606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHtCbpuA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B001F000C4;
	Sat, 14 Nov 2026 05:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633802;
	bh=gOpgw26BkAM6OVgsQ9x/EjM0hqSkQJncuegsJomBOso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AHtCbpuADMRrpIB9Tpy00Xn9MGVS7h6WyM+yE+ZT6uvLl/W7a5KdLBac43t+FS4oe
	 7DXw6QS2+9SEvvLc/UXhuaJyljYnk4WB2iPtXqZfeJ/oMLdCT9RFrrxZyqrotg4pQB
	 jcaeYE+Wrjyxc/qIIAWibhjvMVsv9jZsTJzUF0A7rnFLeH3h562xUABSyGP6T5cXoh
	 QFE7t5xD2lvqLvO7eVybeRpKAzNk9BLqNwC7CzeIThkLd7swr4FbLP9vJba2Ejvc2o
	 PpKW14lAaxB9AooGNKkKHk81me3Ep40B/xb43weApm2iuxgl+FI30NmdpH8Jhxrflk
	 D+XVPNZ8VK5AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexei Solcanu <alexei.solcanu@pm.me>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] hwmon: (gpd-fan) Reset both fans to automatic on duo boards
Date: Sat, 14 Nov 2026 00:23:20 -0500
Message-ID: <20261114052312.3079056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200325-failed-6.18-d1f60971fbf8@kernel.org>
References: <20261109200325-failed-6.18-d1f60971fbf8@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Solcanu <alexei.solcanu@pm.me>

[ Upstream commit d1f60971fbf85c243ab6c78f6535fbc88fa640ce ]

On boards using gpd_duo_drvdata (GPD Duo, GPD Win 5), writing
pwm1_enable=2 only returns the first fan to EC control. The second fan
keeps its last manual duty cycle, e.g. full speed after pwm1=255, so a
fan control tool that exits leaves it running at that speed.

gpd_duo_write_pwm() writes both fan registers (pwm_write and
pwm_write + 1), but switching to automatic only clears pwm_write.
Also clear pwm_write + 1, so both fans return to EC control.

Tested on a GPD Win 5 (G1618-05). Not tested on the GPD Duo.

Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexei Solcanu <alexei.solcanu@pm.me>
Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20260926-gpd-fan-duo-auto-v2-1-0a2ea41ee3b5@pm.me
[groeck: Dropped obsolete 'Assisted-by: tag]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: adapted gpd_ecram_write() to the two-argument interface using global gpd_driver_priv.drvdata instead of per-device state ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/gpd-fan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
index f81c3bc422f4c..310f461e1d633 100644
--- a/drivers/hwmon/gpd-fan.c
+++ b/drivers/hwmon/gpd-fan.c
@@ -412,6 +412,7 @@ static void gpd_duo_set_pwm_enable(enum FAN_PWM_ENABLE pwm_enable)
 		break;
 	case AUTOMATIC:
 		gpd_ecram_write(gpd_driver_priv.drvdata->pwm_write, 0);
+		gpd_ecram_write(gpd_driver_priv.drvdata->pwm_write + 1, 0);
 		break;
 	}
 }
-- 
2.53.0

