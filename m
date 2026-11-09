Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215866;
	b=WzYrz4DMcCQhpPAxvxwPuS+NiXPA1wPhNbAtuUbN7WpWhMvcXLjfjl0FjbmpqoYzKr3n
	 U2gs3CI0COVqDh4FPXS0ftoqiEm3M/YzwZU209AJNKzqvrS2A88IInZTxmloSORAhwvNz
	 xzC6zbxQ1Enfp+DN4ztEp0wVLZhLxdTD5cyZ8QV6+ByHtY9xduUBFqlY/qJVlA6P/RY+M
	 PMEt4pB3Iys5U6fsQl6xeRSrcGalpkk8xYMOjl19uvwP3dDPrq9DKzT4TCql6PUrhWtoq
	 Oif/FjgAqxNLC+yfu3lXT1i3B3NzIZuc32g8Ha8H3OwRvTQxo/QckbwjqSZDcAlmNfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215866;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=PE8ROAj7hSNHqWjiYJSntP8vFL1MKg1nqIFENVfUdxk=;
	b=20VeTS9FXIZ+tw4mEAJ9EKGWF2QOQ0PmFG3TszcLq75La9dhGgde7i9iJev3Smy1wK/Z
	 2tX7t1rDAW/vR8VHuEkt/dQ/kZ7S8jrV5+eXgfnYAmeY+D9KpColL7FWvAoMwyFep+Aq3
	 rsFkCD4ESSbMQekdzlq/xsIHK4CsyuHz8BEQ64OmcgFC91pxNl5apvQq7/mg7Rh8wxAUU
	 MgBd3clEqz/zAXaFVq2gvZjImDTXXz227yLzx5+sOx/DJd269Wx+tmZBMJVQuYtPzSy1S
	 w0hm1tcRrBZez9GFhdfv4Ggbt0us3AJ87Nn/PgO8VN7QR3CXKWMMB1Lm0+4QadI4nsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=UOf+d8CV;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B6606A325;
	Mon,  9 Nov 2026 09:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E72B6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=UOf+d8CV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794215843;
	bh=PE8ROAj7hSNHqWjiYJSntP8vFL1MKg1nqIFENVfUdxk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UOf+d8CVVF4hyOBG4wQGL6EHYkjHjhxOsvjbcCH1FDkAAQ4rlwksOLuAANS5+0n2g
	 xHCYaejc2OWgrdXKgALCpsA4YcnZd4OZWi8NIBEqSBczxIo/2BQ18Turqfzr+PjXWM
	 ns9Cjtz+8R9NjY9Hj2Bx6qLNmSvvHMsvFo3Zj2x0=
X-QQ-mid: zesmtpgz9t1794215828td078ff89
X-QQ-Originating-IP: HMAx/E4sdEzNWVkPzRO+XK9Bilk0fjeWGVF6RhGsWCs=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 17:17:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 608388538444243691
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: lgirdwood@gmail.com
Cc: broonie@kernel.org,
	jonas.andreasson@axis.com,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] regulator: tps6287x: Supply range data during registration
Date: Mon,  9 Nov 2026 17:17:05 +0800
Message-ID: <132236D9B1D977C5+20261109091705.3768527-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MvyKdZyVtFx34q0jfdGPm0MMtsU1hbvsQSiVSO3YT+rai9cuVNpq1rAq
	eP8OfLPXpVhT0N8/yS2Cky5Fc+9198FiaNqOK5x17aYOlg9UTwwSHzfqhr+8p4M8R4atIBP
	ZE+xwQBd4Iz2UxnLbCGQJvGM1toM3LbvxKCMRKmpVzT4QG3QqVRC9WkeuWFVrfepcmiPPBv
	2Df0PYTFeLAVwsAGZR6kRbonIPZQs0VKkyb/wkvT/kg0n/SRs5SH+9gbfMyegLlPNmB+2PN
	uQVAGGD0FxIK6/WNyaaSUAFVRHSDQrOvoqIwI5JIcPYvfkBNRjeKOSaR6TESDs+jSX13j6Y
	MaUsEusV6TZlNkglu+eTb6qxBfYVokbiCvGbiMo67ztBLg0XEOWXvP04FFgjIbSOcnBKdyz
	iJmj+XaEubRjD8BuJK2AZxdJ9bDUgOlkmyx71Gt7OkkAaowqfg4EjpOhqF5a6ZvAOUVz7S7
	60OT9uVWnLp8g3b4aFM0LgfHR+rEHjSdDYjPwIAMuSDo/3VCjRXjT4rKd+3ah99QTmMqE46
	zZMf3KraujRYfImklEqOVrBLm/MlGO4PGJ9EtVLI4p9XL1kqV/ObhLaMAJ/paiUQsxClc1I
	K1ddcuZM6Dc3GaJIJYKP5PUhqHpbT1Mi3ev/NRANqgaCUYH671xencnXnGUlzgLe2hWGM0i
	X1MABcPs2kEU7QuZFLMVu0052F8kPvPG3ACf2O9T5zpTSe6Sh2G4y38+wg7VxOz1wjPGFBB
	9+4fqzUX2aTPyyELG8nAfwjo85GVEngb7GVuT0sOpyiXxc0fC3+k1g9e0XbvXvy4jHUrLQI
	i4ToxgApsK7vlI3w48kkhNDrLaQ285BXTHMYWWqiePgV09xpeZfpc+EozfuCMAQZDWRdVJM
	YU1PGpvZLBUSx9W+ADqwsksQuFq7aJAhbU8QRnEhfmS+LKL9+3sr6rNqn4WzQJU/HyFbVre
	Yom0yCFPDK7JSqkIuVwmU3OpEk5iQ+t5CEgNS1O8GFBqUJxYZOMs12nnu7YaD9RfWvc1O27
	nestO3v2Ko3AnU3RZmQhzLwJhLB+csg7WAnIZNP425wSZzY0J2nKkfQxqpCQ2XSp1alMokn
	A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The regulator core can call tps6287x_map_voltage() while applying
voltage constraints during registration. However, the driver only sets
rdev->reg_data after devm_regulator_register() returns. The callback
therefore falls back to searching all voltage ranges instead of using
the range selected from the DT constraints.

For example, constraints of 600-900 mV select VRANGE 1. If the initial
voltage is 500 mV, the core raises it to 600 mV during registration.
Without the private data, this selects VRANGE 0. A later request for
800 mV uses VRANGE 1, causing a range change on a running regulator.
As described in the range-selection fix, such changes can bypass the
configured slew rate and cause a current surge.

Pass the initialized range data through config.driver_data so that the
core installs it before applying constraints, and remove the assignment
after registration.

The supplied fix was reviewed and this commit message prepared with
OpenCode AI assistance.

Fixes: 3028583d1314 ("regulator: TPS6287X: Use min/max uV to get VRANGE")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 drivers/regulator/tps6287x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index e6403398facc..6367c35dc98d 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -204,6 +204,7 @@ static int tps6287x_i2c_probe(struct i2c_client *i2c)
 						      &tps6287x_reg);

 	reg_data->range = tps6287x_best_range(&config, &tps6287x_reg);
+	config.driver_data = reg_data;

 	rdev = devm_regulator_register(dev, &tps6287x_reg, &config);
 	if (IS_ERR(rdev)) {
@@ -211,7 +212,6 @@ static int tps6287x_i2c_probe(struct i2c_client *i2c)
 		return PTR_ERR(rdev);
 	}

-	rdev->reg_data = (void *)reg_data;
 	dev_dbg(dev, "Probed regulator\n");

 	return 0;
--
2.50.1

