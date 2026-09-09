Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02B5328CE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952893; cv=none; b=QTcy/FPF6yG6hSNwiJfFWApe+R+em0zUxKugn6yXB44oNnxibsiwIp/KIfPygZgAoCQc2JLoEwuaEajcJ7LHhBqTDKJ3HCirUH5715d0jjpTaDoJX4uyM5wJfyuHSMlmEyJuUNq2/BjQnYNSXQwuGvd5EKO2Er8XRfkJNOEUWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952893; c=relaxed/simple;
	bh=u/2GJxZ+n+ruSXlcQtqEtjKO3oCUXg90AuvV67OIWHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcoAv26eMJtualneixz6UKq50UEnfBa2VV5HoU57Qqxhpqu/RuErcASnRlps4C3km4/OmLpS6W/km3q4OItoSlonLiY1d0QYcFD2GmLm+i8A13ev3CWgJ7k0itmE7Eau2FLJ28yBkJtZsHreH1m358AvWf0kw4PhGq0/60y7ePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5dWySBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5dWySBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624721F00A3E;
	Wed,  9 Sep 2026 11:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952891;
	bh=1E0vvRCH7NB9ku+fwGZSd3kOWbV+JEVpOiejigHIKVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N5dWySBeWsvLTDWE0S0jiI1q4ot0bpkvd7c+u8we8/lVjTplvKeKeYKpISD0WymCl
	 Ndk6SaeIMuezNFoCMbdODb5rbfLLT56y3wujNPDi/Erhou1MaW12LA+kPYYIw14CcG
	 XefbpSO7kelFJo3ES3MY69nhauSdRoTz9dnPeUUQJnRZUY+GNQD5/cN6qXghAPZVzr
	 j2ZFd+EE+MqmxQWOeCOgg2OgpBYMDsryQvx1JHoWDy7kit1EYG81m48k+mMRSn5H5e
	 Gr/QOndwae1wVqrMDUS3OBYpKI5dtSVx1qH07TZdoyzgs2NGmM9ylJmHr03mha7MAN
	 ug1ugJ8VZ7rLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] power: supply: max17040: Convert to i2c's .probe_new()
Date: Wed,  9 Sep 2026 07:21:27 -0400
Message-ID: <20260909112128.1815387-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112128.1815387-1-sashal@kernel.org>
References: <2026090305-streak-absinthe-62ae@gregkh>
 <20260909112128.1815387-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit a07fca69378c26ea034826feb0011256e25ad237 ]

.probe_new() doesn't get the i2c_device_id * parameter, so determine
that explicitly in the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 4e4b9f5ce9df ("power: supply: max17040: drop incorrect I2C functionality check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index a9aef1e8b186e..d1075959dd466 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -430,9 +430,9 @@ static const struct power_supply_desc max17040_battery_desc = {
 	.num_properties		= ARRAY_SIZE(max17040_battery_props),
 };
 
-static int max17040_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int max17040_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
@@ -599,7 +599,7 @@ static struct i2c_driver max17040_i2c_driver = {
 		.of_match_table = max17040_of_match,
 		.pm	= MAX17040_PM_OPS,
 	},
-	.probe		= max17040_probe,
+	.probe_new	= max17040_probe,
 	.id_table	= max17040_id,
 };
 module_i2c_driver(max17040_i2c_driver);
-- 
2.53.0

