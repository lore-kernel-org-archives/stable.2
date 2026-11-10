Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352236;
	b=dCMsigBvltvC1nDk5MElWawhkP02ZTsV1C14FSI2/aeHjSEUatsT4bxRSos8qFzsSdec
	 xMPjhYQvYyJqK735NPP7xAEJ0c9FxD2aGLz4ypDfY2V/LrhcwFprdU+8i+vhSpO1z8Vny
	 7LYF40M47X8hCqyTuV05T5UVmkL07E6SN265hj/LeeWwOx4o+93OnQxosVtlz0ObocQzr
	 RYy/Y1dCR/T2mjAKw8dJ/4e/OXjsRrnhlsRjmHrQfEMd9STocjE02a8HHT4Ltcqdx/ztg
	 jsejMRPV/lNZEdtVMvAlJx1D1kAauXLwtyRAy/Ms9iyt0M+VYICmpCeHNdzuLpGIGRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352236;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k6TvenYSPLPcsEIsG+oIMXknZt2ligHLCJOdFuHpi/0=;
	b=lC/zEKFciSHmxCjgdDDi6Y05qwUrgCERhkzZtz5L2t/POKf9qcuDlRJy81HEfhhS44f9
	 6o0VeRPKqrY85mQnMPkdtVAJ+lCICWzV7NYrVxQddN1Wucq9Dg3JwWdm/X3vNiDDpT/vS
	 iOG7OEKMMebCHlG+Xij9tCo5Bc+SCOhJqZkOGQ0VeB6+6E/g3mbQwhf8Wu9YV+a6F3yfL
	 ECod3BiVM/hqvNATrvVnA0FWVh1UkFKYodKXO+uRhjY/+3U3EopW/BPHgrSAddcpvSjI3
	 uof4/cgpc9HmCx8I8j5eo/oLYfm8mnCZ1REATNQzdlL/isEigxz812NVNz0jBI3Oefg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYZvDiVh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D0606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYZvDiVh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BC21F00A00;
	Tue, 10 Nov 2026 23:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352235;
	bh=k6TvenYSPLPcsEIsG+oIMXknZt2ligHLCJOdFuHpi/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UYZvDiVhNiHE/x4pN+K2lUIh6+faANjNnlC1aemv3k/2bIkU7WN+X4qcioBfYGeBw
	 MPhqRwUV9kv9GQ5SxIgDkDT7Iu9C6kxKEtVat3zpWMTQeOfld7MBH4HBkL4fPnv0o+
	 4slT7Ose3sAOIy1V9IxusJ9gMrqKh5j2KXz8a77f+Ff0BcIdZbLgyAPPhasg09SpAp
	 qbzlzRV6w3eLoYJMu51kytCQV8Ek+5LSs0l56SVgHhbO8JeVMLXe1ujF4ayqVaWaQK
	 BXc7vcITl+6+uKnirBwzC7K7pdkd1P+eZIlWC8xXGaNHWdYIb3tVDuoNuElNfJtbIb
	 jgTVXT3Dv3buQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/7] power: supply: generic-adc-battery: style fixes
Date: Tue, 10 Nov 2026 18:10:29 -0500
Message-ID: <20261110231006.55369-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231006.55369-1-sashal@kernel.org>
References: <20261107060802-failed-5.15-8ae5a3f40045@kernel.org>
 <20261110231006.55369-1-sashal@kernel.org>
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

From: Sebastian Reichel <sre@kernel.org>

[ Upstream commit 7cc7478e093782d2ac176c11a966de00bd0792dc ]

This does the following code-style changes:

 * fix inconsistent indentation in 'struct gab'
 * remove unused cable_plugged from 'struct gab'
 * remove pointless temporary is_plugged variable
 * add gab_ prefix to read_channel

No functionality changes are intended.

Signed-off-by: Sebastian Reichel <sre@kernel.org>

Omit the temperature-property call-site rename because temperature
channels are not supported here. Rename the existing voltage, current
and power channel calls only.

Stable-dep-of: 8ae5a3f40045 ("power: supply: generic-adc-battery: fix status with no supplier")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 24 ++++++++--------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index be22fe9ae90bf..cac0ac5caa142 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -44,12 +44,11 @@ static const char *const gab_chan_name[] = {
 };
 
 struct gab {
-	struct power_supply		*psy;
-	struct power_supply_desc	psy_desc;
-	struct iio_channel	*channel[GAB_MAX_CHAN_TYPE];
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	struct iio_channel *channel[GAB_MAX_CHAN_TYPE];
 	struct delayed_work bat_work;
-	int	status;
-	bool cable_plugged;
+	int status;
 	struct gpio_desc *charge_finished;
 };
 
@@ -86,7 +85,7 @@ static bool gab_charge_finished(struct gab *adc_bat)
 	return gpiod_get_value(adc_bat->charge_finished);
 }
 
-static int read_channel(struct gab *adc_bat, enum gab_chan_type channel,
+static int gab_read_channel(struct gab *adc_bat, enum gab_chan_type channel,
 		int *result)
 {
 	int ret;
@@ -110,11 +109,11 @@ static int gab_get_property(struct power_supply *psy,
 		val->intval = adc_bat->status;
 		return 0;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		return read_channel(adc_bat, GAB_VOLTAGE, &val->intval);
+		return gab_read_channel(adc_bat, GAB_VOLTAGE, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		return read_channel(adc_bat, GAB_CURRENT, &val->intval);
+		return gab_read_channel(adc_bat, GAB_CURRENT, &val->intval);
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		return read_channel(adc_bat, GAB_POWER, &val->intval);
+		return gab_read_channel(adc_bat, GAB_POWER, &val->intval);
 	default:
 		return -EINVAL;
 	}
@@ -124,17 +123,13 @@ static void gab_work(struct work_struct *work)
 {
 	struct gab *adc_bat;
 	struct delayed_work *delayed_work;
-	bool is_plugged;
 	int status;
 
 	delayed_work = to_delayed_work(work);
 	adc_bat = container_of(delayed_work, struct gab, bat_work);
 	status = adc_bat->status;
 
-	is_plugged = power_supply_am_i_supplied(adc_bat->psy);
-	adc_bat->cable_plugged = is_plugged;
-
-	if (!is_plugged)
+	if (!power_supply_am_i_supplied(adc_bat->psy))
 		adc_bat->status =  POWER_SUPPLY_STATUS_DISCHARGING;
 	else if (gab_charge_finished(adc_bat))
 		adc_bat->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
@@ -177,7 +172,6 @@ static int gab_probe(struct platform_device *pdev)
 	psy_desc->name = dev_name(&pdev->dev);
 
 	/* bootup default values for the battery */
-	adc_bat->cable_plugged = false;
 	adc_bat->status = POWER_SUPPLY_STATUS_DISCHARGING;
 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	psy_desc->get_property = gab_get_property;
-- 
2.53.0

