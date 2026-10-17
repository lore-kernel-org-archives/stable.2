Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCF37C109;
	Sat, 17 Oct 2026 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279022; cv=pass; b=eqkRNMP4XEaoUy1qgglprNxYI4yYLyzJoJgnqkTJEXnsPpqiUN4hYI6CytXmPx3sshVYdXw171oZsAmS5JAgmHEmb8L4HbIujkWTd3dAWiFt3ROA5uZZauNkDr5f5RZzMKihiBsMUbtpI6snloS+GVK6p2d0FlUKZI6sm2AyYNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279022; c=relaxed/simple;
	bh=xEjVJUn2jchKsr7a/nuGGORxpQsRK2wY1OkwS7PMiTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hq73z3S+7WTF5rymI/1x2GcSYM0oiOOXTylFyrDRklTD7OZb9JSoV0awKrM8AhI7eJ8LckaN4hsmeeM7PCkBwTxMiK28HFMPdBriFyohNLAS+54QalIuCCVoKhGuvK27uGNTFQTak31Gkfr6f2EeqAcXUe+7CJ/WrYRXChekPfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=bkON4ab9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="bkON4ab9"
ARC-Seal: i=1; a=rsa-sha256; t=1792278998; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iGdJ8mOrKFaj9UQ5wVhwSgLKu07Lp9S4n73l0Sr78844BIHCC8tXLTu3Fyyi/LkbNBaNBkzC5vNBM5u4Puf65fN7HyOaZt3EJP+6tAmjp9Jp/K0R45gF3RRz+Yl6JSnPB5oYlAuatW8+WwpyjwdcJpab2yAHsolBxQln/ipvGrw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792278998; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fpj70h+YMxh/9cV7c0OqU07ipcQW2cUm2yU3eOs0RVo=; 
	b=CsLBEme+yt3F0/XxHIBG57y742AhhYhM+EEDKkpSfDloABVrUV4c39lc7YjU18jA5aJLCzGLkEftgI3L0ut+2ZCBY/NcfMir09CwCjIoglczP3Hnimq+H/I1OiXAD1eozKdI610obZzoQmA8/YP72qK6bTXKg5H+DyQx1guUYBE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792278998;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=fpj70h+YMxh/9cV7c0OqU07ipcQW2cUm2yU3eOs0RVo=;
	b=bkON4ab9Ri+2VcZucqGGTcs8r6m0zynakktKDTdnh3UddqoB3sP1gbt+NJe+krzk
	RQQVbGzD//Cbbw5EzC8nMVORcmh+RChgDscB/hA3Kff+2a9F5iKl2PACOHSsdlPiC2K
	PPa2QdwaQTnFMIgeqq1T4equxVnDywAmGpZsz5wAJaplKUMksFAfz4jXWRveZ6lretS
	0sZMw9TkzDaGLoyCE/VN/Kys4JbRj2mNY8VMH6fc7ihCFoLrsniZuvWX13PP9ChKDbC
	YKciKj3yozzm+kx4PFr6FOrVW0gVkgXr0fhB9Wk5axQXYU2wlt5F/if2CSncZnImDjz
	nUTYXkfPbw==
Received: by smtp.zohomail.com with SMTPS id 1792278997262913.4076067434765;
	Sat, 17 Oct 2026 16:16:37 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sun, 18 Oct 2026 07:16:19 +0800
Subject: [PATCH 2/2] platform/x86: ideapad-laptop: Fix unexpected
 charge_types on probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-ideapad-fix-charge-types-v1-2-db52e3bb061a@rong.moe>
References: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe>
In-Reply-To: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-73bef
X-ZohoMailClient: External

It was reported [1] that some unfortunate combinations of BIOS and
Lenovo utilities (e.g., Legion Go 2 + Legion Space) may enable Rapid
Charge and Conservation Mode at the same time, which is very out of
sepc.

If both are enabled during a previous Windows boot, ideapad-laptop will
see both bits set and correctly shout "unexpected charge_types".

A planned BIOS update will address this. Before that, if unexpected
charge_types are encountered on probe, enforce [Long_Life] to prevent
the device from operating in an out-of-spec state. On check or fix
failure, skip registering the battery hook and the conservation_mode
attribute.

Note: the switches never enable themselves autonomously, so there is no
need to fix it during runtime.

Fixes: 90430ea98f55 ("platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid Charge)")
Cc: stable@vger.kernel.org
Closes: https://github.com/ValveSoftware/SteamOS/issues/2876 [1]
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 56 +++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index 40dab4d321a4..31f74a2021b1 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -2156,6 +2156,50 @@ DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(ideapad_battery_ext_v2,
 				       BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE))
 );
 
+static int ideapad_battery_check(struct ideapad_private *priv)
+{
+	enum power_supply_charge_type charge_type;
+	unsigned long val;
+	int ret;
+
+	/* Not acquiring gbmd_sbmc_mutex as race condition is impossible on init. */
+	ret = eval_gbmd(priv->adev->handle, &val);
+	if (ret)
+		return ret;
+
+	priv->features.conservation_mode = true;
+	priv->features.rapid_charge = test_bit(GBMD_RAPID_CHARGE_SUPPORTED_BIT, &val);
+
+	ret = priv->features.rapid_charge ? ideapad_get_charge_types(priv, val, &charge_type) : 0;
+	if (ret) {
+		/*
+		 * Some unfortunate combinations of BIOS and Lenovo utilities
+		 * (e.g., Legion Go 2 + Legion Space) may enable Rapid Charge
+		 * and Conservation Mode at the same time, which is very out of
+		 * sepc.
+		 *
+		 * If both are enabled during a previous Windows boot, we will
+		 * see both bits set.
+		 *
+		 * Conservation Mode should override Rapid Charge. Before a BIOS
+		 * update addresses this, enforce it by selecting [Long_Life].
+		 */
+		dev_notice(&priv->platform_device->dev,
+			   "selecting [Long_life] to fix unexpected charge_types\n");
+
+		ret = ideapad_set_charge_types(priv, POWER_SUPPLY_CHARGE_TYPE_LONGLIFE);
+		if (ret) {
+			dev_err(&priv->platform_device->dev,
+				"failed to fix unexpected charge_types: %d\n", ret);
+			return ret;
+		}
+
+		/* Best-effort only. No read back. */
+	}
+
+	return 0;
+}
+
 static int ideapad_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
 {
 	struct ideapad_private *priv = container_of(hook, struct ideapad_private, battery_hook);
@@ -2194,12 +2238,12 @@ static int ideapad_check_features(struct ideapad_private *priv)
 		priv->features.fan_mode = true;
 
 	if (acpi_has_method(handle, "GBMD") && acpi_has_method(handle, "SBMC")) {
-		/* Not acquiring gbmd_sbmc_mutex as race condition is impossible on init */
-		if (!eval_gbmd(handle, &val)) {
-			priv->features.conservation_mode = true;
-			priv->features.rapid_charge = test_bit(GBMD_RAPID_CHARGE_SUPPORTED_BIT,
-							       &val);
-
+		err = ideapad_battery_check(priv);
+		if (err) {
+			/* Continue with no battery hook or conservation_mode attribute. */
+			priv->features.conservation_mode = false;
+			priv->features.rapid_charge = false;
+		} else {
 			priv->battery_ext = priv->features.rapid_charge
 					    ? &ideapad_battery_ext_v2
 					    : &ideapad_battery_ext_v1;

-- 
2.55.0

