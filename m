Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0733A16B6;
	Sat, 17 Oct 2026 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279015; cv=pass; b=DtR+0FdIfhVlsBZVJ2FLwVk/9z2UtNuLcXvb2S+QDb9CzZH51PeS13BBxQdPixxEKGpDZruv5Oi9mbs2XtU2qJIKckOs46jlfBtfijX0GqfIQ1I7ghH/phZyhTd4GN4KK/mv1oywT1+o0XBae732JdN4Hhm2NbVGAps0H6qb39k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279015; c=relaxed/simple;
	bh=iFIPStZDojt/0dFKPSnhUK47K8YCnf4XB7gAAwiSdEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5gjQ8Ti+4ihggUpTiZJbCFZ6pNODqMhJ67YPpIVXHWoFIz5RlA/Cl+pfhyyFdmQuBQTythne3oWpCv0mSODHf1seesujlzP6wQj7kLLxxM1C0VC01QC5QOFLCM+XTTSZIOuYVP5nH/SSNZ0g/hpX+R/P0EFDVoPqdl/eoRwSSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=QdyRQKgl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="QdyRQKgl"
ARC-Seal: i=1; a=rsa-sha256; t=1792278996; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L0lUBrrM31eF64v96YtedPWE1BvR5Ywf7pYmvx/13nj5rorO5wygsHka4s6SQ/OcJkTSIA6F72aeIkkTjkrLbNWT34W5XLKgATm8eu0wCiJt8pmsoV/nx0vl6/xrbit0bFXMyb9GiuSwZqxRi/Dd8oWb9WTSSREQpT5w3wl3vCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792278996; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zPevRjE77HhG3MyzQJneX/ZZy+eBkZ/PmQKRThSSdWA=; 
	b=miHZPxLzbSRoCFyOZ630OfHIWLEBjAq0VDnj3CaLrID3MUFJpROCUuFQpS+eGlAK4QxSfhNWC4uNkaMUE6P2ip2u9j1kPX/vii4Rf/Fs9hshbhk0XolckC9IyL7ufOTHu9Zw2q9ceVyjBjh5h25aj2ue9+M8TPwyt9Yvd80jwJ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792278996;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=zPevRjE77HhG3MyzQJneX/ZZy+eBkZ/PmQKRThSSdWA=;
	b=QdyRQKgl6ZxAh73L6JwuOJ6IyWzcp4l/HH9HrzOlNBY3tZdvRBAz/xM0mmK+umL3
	39UdXEUoiSzIusnJE/PqWaGa8/8LqtW1AEppc9XSLf1bNTILGRO1Un/0djftygopMc3
	Vzwja1X96rgGikFPmazXNjXCWdiOD2jvYeEfQB286IaOrhCCTtyEBz9ewA13jbVTTSc
	Gt9R6rkL9aVyd4wEMMz0UsljjJtzaUShjr9iTWZ+dqI5DhMO2/946I2CYPOnLSPeT+n
	TlB2mxCQ83qf5+3n5+tNmAD4R2l/eM3+MzyFrGbiUGnwSP1V2bNA94sQmjhcKLHckyB
	kTcjFQ5I7w==
Received: by smtp.zohomail.com with SMTPS id 17922789948651016.2491665596064;
	Sat, 17 Oct 2026 16:16:34 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Sun, 18 Oct 2026 07:16:18 +0800
Subject: [PATCH 1/2] platform/x86: ideapad-laptop: Factor out charge_types
 methods for internal use
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-ideapad-fix-charge-types-v1-1-db52e3bb061a@rong.moe>
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

In the following changes, charge_types will be checked before
registering the battery hook.

Factor out charge_types get/set methods for internal use.

Fixes: 90430ea98f55 ("platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid Charge)")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 57 +++++++++++++++++-----------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index 8213524504ee..40dab4d321a4 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -2032,17 +2032,13 @@ static const struct dmi_system_id ctrl_ps2_aux_port_list[] = {
 	{}
 };
 
-static int ideapad_psy_ext_set_prop(struct power_supply *psy,
-				    const struct power_supply_ext *ext,
-				    void *ext_data,
-				    enum power_supply_property psp,
-				    const union power_supply_propval *val)
+static int ideapad_set_charge_types(struct ideapad_private *priv,
+				    enum power_supply_charge_type charge_type)
 {
-	struct ideapad_private *priv = ext_data;
 	unsigned long op1, op2;
 	int err;
 
-	switch (val->intval) {
+	switch (charge_type) {
 	case POWER_SUPPLY_CHARGE_TYPE_FAST:
 		if (WARN_ON(!priv->features.rapid_charge))
 			return -EINVAL;
@@ -2074,22 +2070,19 @@ static int ideapad_psy_ext_set_prop(struct power_supply *psy,
 	return exec_sbmc(priv->adev->handle, op2);
 }
 
-static int ideapad_psy_ext_get_prop(struct power_supply *psy,
-				    const struct power_supply_ext *ext,
-				    void *ext_data,
-				    enum power_supply_property psp,
-				    union power_supply_propval *val)
+static int ideapad_psy_ext_set_prop(struct power_supply *psy, const struct power_supply_ext *ext,
+				    void *ext_data, enum power_supply_property psp,
+				    const union power_supply_propval *val)
 {
 	struct ideapad_private *priv = ext_data;
-	bool is_rapid_charge, is_conservation;
-	unsigned long result;
-	int err;
 
-	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
-		err = eval_gbmd(priv->adev->handle, &result);
-		if (err)
-			return err;
-	}
+	return ideapad_set_charge_types(priv, val->intval);
+}
+
+static int ideapad_get_charge_types(struct ideapad_private *priv, unsigned long result,
+				    enum power_supply_charge_type *charge_type)
+{
+	bool is_rapid_charge, is_conservation;
 
 	is_rapid_charge = (priv->features.rapid_charge &&
 			   test_bit(GBMD_RAPID_CHARGE_STATE_BIT, &result));
@@ -2102,15 +2095,33 @@ static int ideapad_psy_ext_get_prop(struct power_supply *psy,
 	}
 
 	if (is_rapid_charge)
-		val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		*charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
 	else if (is_conservation)
-		val->intval = POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
+		*charge_type = POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
 	else
-		val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		*charge_type = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
 
 	return 0;
 }
 
+static int ideapad_psy_ext_get_prop(struct power_supply *psy, const struct power_supply_ext *ext,
+				    void *ext_data, enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct ideapad_private *priv = ext_data;
+	unsigned long result;
+	int err;
+
+	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
+		err = eval_gbmd(priv->adev->handle, &result);
+		if (err)
+			return err;
+	}
+
+	return ideapad_get_charge_types(priv, result,
+					(enum power_supply_charge_type *)&val->intval);
+}
+
 static int ideapad_psy_prop_is_writeable(struct power_supply *psy,
 					 const struct power_supply_ext *ext,
 					 void *data,

-- 
2.55.0

