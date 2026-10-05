Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2130D40E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 04:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791174874; cv=none; b=JzrFpQwuV/oD3IGp52dRJUZYDdyRIGNGWRsGBEbn43fMlXaLbHNY4N05C0HpaH3Fhl/rM7RrdUfWAVSgekRF0sNRo5wH8mTGNMKFMQP2erbAM/R2puaEABq8czNEJKQsLz6A//nUIN9SF6XWC6qj4cAIRV/2hWOPfHr4SztqwX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791174874; c=relaxed/simple;
	bh=ukXN69U8z8iXicGURksaSKA7Zt19bApUnrE9iFavSAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg0u5RcOeYFXGB3Trlx3/ow8wFf3oio8JoAQarJvv53f+4gwI9ySA3BEv8AOKt/Krikq1qu0BtACfqjuhHFd0mDDWKjnvt6hxacS6itxEw3YwmJbSaJyUlqlxLHvGArfLFGltL2fRr77MK0FCjNZYLrfbPvBXWNH1oh/t6vsXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastmailteam.com; spf=pass smtp.mailfrom=fastmailteam.com; dkim=pass (2048-bit key) header.d=fastmailteam.com header.i=@fastmailteam.com header.b=oePbKpB1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iz49i13p; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastmailteam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmailteam.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmailteam.com header.i=@fastmailteam.com header.b="oePbKpB1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iz49i13p"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C5E41D00218
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 00:34:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 05 Oct 2026 00:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	fastmailteam.com; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1791174870; x=1791261270; bh=a32W7RYq0HtXFnYarxvWXJ0ZArZ5aM9F
	U6p683UZepA=; b=oePbKpB1NaZXIojYV6HVSA1O23vsIOVOnDRL41iJqe+g6CsL
	+Aq5DLcHEtwLUUSAgXCBGyCEqA+kzsCmXOq/F0itmOpxa0+zwX2nvTxIMTaQWO1n
	O4EfPcF9r78FjvEs1eDhfUJqtNEDFc3jxdp3x1QavZ2vgsMCRYI13XANut3Fjraa
	HkSJ1E48ouAfaiqc38al0hDxMWeM+7OFfhRCTp+00S583TeGO/UG4WbIV/+OPuYv
	i5YI8wb6CW+6BPbNjlJJIisUTIoxW0uuEGwfK+nRnILRqrzoaheGodkeKeipiOH+
	b16Lo3GPUCmRNE6DL0Sg9opquNYNxBWL6fTnlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791174870; x=1791261270; bh=a
	32W7RYq0HtXFnYarxvWXJ0ZArZ5aM9FU6p683UZepA=; b=Iz49i13p7Kao/nXQb
	isAeeGBHYFMXYCtFG99YUgT9SKK3kXFLoH5PwfgHRk2rUbX5OCxt3NwzuF3JEB0R
	I6QGcgca1A80rhz0oZsgzKLpLxPVq0k2uSAVdTfWzKOqIRQxwS64kA0C9koFEwmH
	ScUcoelEg9Ck25SuoAUAgkwLJB/Wnz/tbzWf2ZFK7GPzk4dxBh2MZPia2aJczDJM
	pXC542BY03isGDFPaHQMb1wY/gi0x91LHfnRHlOkavx3JNYElnQildpSaUOKFfuX
	7oRj4JIq7a73KX7Uz/CxGWeKX5j9Er5lsfqjyg5LdLu3GECbNE/xRXxOBpkBdnKf
	q2onQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmailteam.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791174870; d=fastmailteam.com;
	mf=PGFuZHJld0BmYXN0bWFpbHRlYW0uY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:oAjkN1XB9JoIOnNYDaKY+8kX+enm/YGkTE22UiNMfqPfpxk
	yJyxLw3Zn6Z6pJseBr/1BZOt/LdrVmo8GlqM5aO4s22SthgHPk0e4Llo4ZvjBb9w
	4/uPzATvPr1wLtclirEI8jIXDugCKPRDa8ckSFOQ8fDQP0BAegK8R1vDJLV+sX0P
	xLhS+bq7I0QiTTdSLrOfzKtAGFT/HyvmMWzy89TaXPuki4hG3Ekzpqq3HK3CgYb1
	plfq+38oJe+hT13kitKAVzhoFd0Bkbugw0/Bv68YKGlj7684+Re/tkxuaAFNdUUo
	V08xr9E4tpAJBV0jN06qYzd2vj29qYMHstvLHOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Me50Q++Q9ZKRuT3KIRwXrAR13jXACDuL3rFM/g518pA=:ukXN69U8z8iXicGURksaSKA7Zt19bApUnrE9iFavSAg=;
X-ME-Sender: <xms:1ijDakfhD1amQIeycuoM5mNCbunVkcNn-JQbez1g-VaEq_d4DZcnaQ>
    <xme:1ijDaiAgzuWBmPO7zDWg-hLy1cXyBkFaFtIWdp0FCHyL_6_SZGyOya8Gi6SVV3Fh5
    JKuGj59ht1dFWjWPlQiTl1VASsPshKRbLlxhJsDTJMrC9jEqPY>
X-ME-Received: <xmr:1ijDag6ncS_EldaxKMBtcDrnmoLFTCLzNT-I2T7UJMr9RK8_j9CqZAOPtoyADKvW8FcQc3zqbpNpV_UN-_s86CfKZKlXyo6zyuUnvactnxI>
X-ME-Proxy-Cause: dmFkZTFfHMeNvSQJjFCmCucv+Vrjql370IkICRIyzCBVh22Ru31snipQ3H0h7MH5Ygkafs
    nsmcvYVG/IXnJScHwi0ktidbF5rlMNUcIwpCnD21CRgcg5bCJ81DPJIQLcEdo4AYOrWASL
    UMhaVMyHjf/+wrq3nBKyWCxJy513E2PHueL/uLTDZiyh/2VsiEb/KeifB3rgZWS+7buQ8t
    yGCU1VR060DN/E6TMSvDuL6r4CujOB1A2PcPi/2byg5cBrZaJY96BKU0yE/tB8NSaj14Dw
    oqe7scETYf1N9MvxEcoSiokjuLc0kFiOaj6g3EIM04PAZ81iboERh7sFnrE3rLug8WBLRK
    GjCIiXzIBuGbSrP3ELbC0yIaBg+wJ9PKYkn1BsUrrZeeocREYMDKltbILkXsHU1Qi5qI9q
    AAVtRJxd1kS0ZiN+ufgI77YDJduwi4DrF0Xq9FmGJiDIxJTsGk2BxOstMq7lzAvUN8As8l
    D7EpQogM9RYO6qnr0eM1uunQAFpcNHPO/0UZSyd5DtjveTRCnN3hUXNUF9cqIgn7f9REgb
    /xxb1yqeMRkX/5917HzV0/1ib/M8EVaCkrP9+eMBj4iEO2lC/5J9O9CD+suyeqsnvoL9tt
    WrENQjsyjpA5g4uRZeytifqj9z2mkkw33iap+gdBRVtG0sXAQfPiHRYo1uyA
X-ME-Proxy: <xmx:1ijDajfyEKc0L5jT3iREJpnIZKb1qzN9UEgbEnt4VS06dYS6ENbGuw>
    <xmx:1ijDaushE5910B2abfkHGsH_vpdgt1OBwHyHKXt1scIr-fShYic8Yg>
    <xmx:1ijDarlkQSX6roenlBT9SyBbT7hcipXXG4ZfPghv6wDa_skgu6o42g>
    <xmx:1ijDapQme69lX7aaPVTFNqf6XxpARRy62YnrHW2h6kgvW4sgXvnxTQ>
    <xmx:1ijDavDpGeXNwFN6_dy6pfZ0xmOkz5ZzGmQNqpL-nfl7Lp1knW5VkcVq>
Feedback-ID: ib8be4bd5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 00:34:27 -0400 (EDT)
From: Andrew Pam <andrew@fastmailteam.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Matt DeVillier <matt.devillier@gmail.com>,
	chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Pam <andrew@fastmailteam.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] power: supply: cros_charge-control: restore EC state on resume
Date: Mon,  5 Oct 2026 15:34:18 +1100
Message-ID: <20261005043418.243937-1-andrew@fastmailteam.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004225606.30577-1-andrew@fastmailteam.com>
References: <20261004225606.30577-1-andrew@fastmailteam.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EC resets its charge control configuration when the AP powers off,
so configured sustainer thresholds and charge behaviour are lost across
hibernation.

Nothing notices the reset. Commit 4fc88ba435da ("power: supply:
cros_charge-control: adopt EC charge state on probe"), in the
power-supply tree, made the driver adopt the EC's charge state, but only
at probe, and a resume is not a probe. Sysfs therefore keeps reporting
the configured values while the EC charges the battery to full. On a
Framework Laptop 16 (Ryzen AI 300, charge control command version 3)
with charge_control_end_threshold set to 80, a hibernate and resume
cycle leaves the attribute still reading 80 while the battery charges
past it to 100%.

Add a system sleep resume hook that reprograms the EC from the cached
state. The same EC behaviour and the same fix already exist for another
driver, see commit 2643187ccb86 ("platform/x86: ayaneo-ec: Add suspend
hook").

Reprogramming the EC is only strictly required after hibernation, but it
is cheap and idempotent, so hook every resume path rather than rely on
the EC preserving its state across each kind of sleep transition.

Note that re-reading the state from the EC on resume, by reusing
cros_chctl_init_state() or otherwise, would be wrong even on the command
versions that support GET: the EC has been reset to its defaults by the
time the hook runs, so adopting that state would silently discard the
configuration the user asked for. The driver's cached state is the only
remaining record of it, which is why it is pushed to the EC rather than
refreshed from it.

Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Andrew Pam <andrew@fastmailteam.com>
---
Changes in v2:
- Use dev_set_drvdata() in probe, symmetric with dev_get_drvdata() in
  the resume hook (Tzung-Bi)
- Log an error if reprogramming the EC fails on resume (Tzung-Bi)
- Use a nested .driver initialiser in struct platform_driver (Tzung-Bi)
- Update the resume hook's comment, which still said the driver never
  reads the state back from the EC; untrue since 4fc88ba435da
- Add Fixes: and Cc: stable tags
- Commit message: say that 4fc88ba435da is in the power-supply tree, and
  reword its description

v1: https://lore.kernel.org/all/20261004225606.30577-1-andrew@fastmailteam.com/

 drivers/power/supply/cros_charge-control.c | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 07bcc6a9aeef..e5841b40563e 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -13,6 +13,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/types.h>
 
 #define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
@@ -420,6 +421,7 @@ static int cros_chctl_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 	priv->cros_ec = cros_ec;
+	dev_set_drvdata(dev, priv);
 
 	if (priv->cmd_version == 1)
 		priv->psy_ext = &cros_chctl_psy_ext_v1;
@@ -439,6 +441,28 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	return devm_battery_hook_register(dev, &priv->battery_hook);
 }
 
+static int cros_chctl_resume(struct device *dev)
+{
+	struct cros_chctl_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * The EC resets its charge control state when the AP powers off, so the
+	 * configuration is lost across hibernation, while the values exposed to
+	 * userspace still describe it. The cached state is the only remaining
+	 * record of that configuration: reprogram the EC from it rather than
+	 * re-reading the EC, which would adopt the reset defaults instead.
+	 */
+	guard(mutex)(&priv->lock);
+	ret = cros_chctl_configure_ec(priv);
+	if (ret)
+		dev_err(dev, "failed to restore charge control state: %d\n", ret);
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cros_chctl_pm_ops, NULL, cros_chctl_resume);
+
 static const struct platform_device_id cros_chctl_id[] = {
 	{ .name = "cros-charge-control" },
 	{ }
@@ -446,7 +470,10 @@ static const struct platform_device_id cros_chctl_id[] = {
 MODULE_DEVICE_TABLE(platform, cros_chctl_id);
 
 static struct platform_driver cros_chctl_driver = {
-	.driver.name	= "cros-charge-control",
+	.driver = {
+		.name	= "cros-charge-control",
+		.pm	= pm_sleep_ptr(&cros_chctl_pm_ops),
+	},
 	.probe		= cros_chctl_probe,
 	.id_table	= cros_chctl_id,
 };

base-commit: 5c1c602463d597c5189ddc5a73dece588ba2c57a
-- 
2.53.0

