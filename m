Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351480;
	b=nRXgDl6ez9QIgkhPfPgZFjiS7r35UAkpJW9ygA0vu807EfmnJ4/u0tnQTe/thsrt/K60
	 PKljfKCa1Z1MsJz8TMsw2oELkxieMooCV4xgR9gMBbl8WiSuNz77HAcR+D3ZchTfvcaa2
	 7l+qfXcl+wDuZVkE8BmBK8UE3GTBevoeGg/A8zkg4MbWJSb2f0cRtKh/vlINA1Jb8ay0O
	 bzB+3ksrK8LiNGpRNW+radf2/PoXLw2+byHDZyEeosTQ4Tff7NRtP3KYivNU4PTLhG2+G
	 ijy3DFVmtyepLFZR7pz2SoetVUxd9YBCH98IS1eeBa59Nz+6efQv+K12SMCNFFz5p2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JB7dFdZ7Wls301f+d5k+a8ex5sKXgOo6ldVv3GwAMTw=;
	b=N6Rh/GUn1CYgjtwUpTedr/tPjvnWcu0jqN9O/SEZarQXfeamPxvbWe6YfyMuUSu5Q6WC
	 H3NzyQJe6fHQDhG0ooNcUGC4V3dW1DdzyqeBd9PqYlMXsEarGV5qWOTRSyOmrC3qHBkt7
	 lmgJiKeI54mjtR/CIB49Pp9AYU4hXELdpFSLpvLY+LOJb1Sf0sdgyV2QuWep2OA+XzPWt
	 W9TFcAqMYrkVCBw88xiOGvLT2RdCCSsfqbe4LjZj75hrI7aPFB7oRcwf5AxXiLb46aKhV
	 pRUYu02nt0RJ9yS78vm76QuEhQjumbBoNOGV0ZeVcw2JAtq/pgN3gK2LqecB1YloH2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gX9bYzf9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3853606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gX9bYzf9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A79C1F0093C;
	Tue, 10 Nov 2026 22:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351479;
	bh=JB7dFdZ7Wls301f+d5k+a8ex5sKXgOo6ldVv3GwAMTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gX9bYzf9fLa2F72kwh6DxrQPsaOfbSZqT5uwvYrA+J/hcEZ/caR0fyWvz4cBj4hgG
	 9G54dG2lFGd//XgWDSsBP/OmaA2Ip1gHST5AAdj1VMKo02WTvbdZVOMzGN3/KWXBB7
	 1c5Q7+JHRu1N5H7/cPkFy9jYC5960kFGc2iMe8nME5Myh9QxTdapJzqXV6CHxWJSxf
	 7/muGyUQwSaKbEqR7orsHLIsn8/4jQV/LRcS0CaN+E0TfhEbV99Ml60AoygaOf4zgs
	 6XjMCId1eYIc0gh3Ikt6N+ZrEEy0dB5IE4t4EIi1BloDKnbFrQFOPENZAxYyEVxBmu
	 8WrKyoheMGInQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/7] power: supply: generic-adc-battery: style fixes
Date: Tue, 10 Nov 2026 17:57:52 -0500
Message-ID: <20261110225738.4066560-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110225738.4066560-1-sashal@kernel.org>
References: <20261107055053-failed-6.1-8ae5a3f40045@kernel.org>
 <20261110225738.4066560-1-sashal@kernel.org>
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

