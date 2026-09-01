Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE940F73D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274328; cv=none; b=eWBf5CFVXufwz8NBC8ByvY89hCQW0ZYYkerUxbpQNSpeZ1n4wwH3+X59xMK8Jktw3A0vDZS4p68K6aK8GwtyAsEbD+8a1ocnByrfIdnTHvxghDsJkbU/eqG+mLUwMxwtBDGOh+s2ATNrTxygtAc+I3oOZ7ujz4+iAcbOlVAqgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274328; c=relaxed/simple;
	bh=Dq2ONeIQ6dz6p5yBwZaXTI0eVkhwNMnqnsfeGFeKWaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwB31qKNsMnmHOYOFl0MTUWI+nnJIe09MxSAl7bxMeBbmaRv4xbPTVrhJPPFeGskXIe4zJuCwLLDqHJzBIopq2LR/ZJXj3g+jsO8ytYU9FmosuZ5iq6t7qjo6Il032ZYRcAG12gxwWhqtylX8yhY6b5PixUqwstmuBaA/vaY6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C518d74M; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C518d74M"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48442ea8f59so712542f8f.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274324; x=1788879124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lfynG4oSDnoX9s67oXdlrf551e25UO4n7DRdlwRDghw=;
        b=C518d74MCw2EdYw3lchXCmIXx3thtTPm1eTolofYOnJRIENcDdJtaH1q2mYWy8rPtI
         +cRQdyG//cfkaEZHPxdLeC512Tz5+v5S5wJZZAg7SsdT+S7i1aR7eRm6fsPo84iY0V8T
         KyUA1pyKgCdHB/iv4fsevSGed7VGneuITtm63CgAiF8mqXBi72xQ364/fWmo2TL4QxFR
         klaMAB4b/N+knlQjbFnU1s+SeipygI7R+Veko9jg4OcyZrzGZ+krSoNXMxOBdGKs7wtx
         3yffic7rKvM1j6vwMHBBAmA/7m4otS2SvqHyAkBM958duyvMyokEkY6XttfPWk+uScNN
         BTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274324; x=1788879124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lfynG4oSDnoX9s67oXdlrf551e25UO4n7DRdlwRDghw=;
        b=AflHieePruvAFsj9dB7G4IZEFHYEtopVEMAPxXMetd0sSe0wiTUMkIpOtCNsMVW5m5
         MowPNtVeJoN2557cjz0ex7otwwx2BXVdm7U17oX1nt753OYFfxVJvelb3CGhNVE0kAmF
         MnmE91HXyfkwmJTXZdSL7kbBo7EpjI9U6QMNKguuPK4zPCJobXBiFSuWnrIwEg3OmP35
         x92ayeHzEfPSCMyO9Y/fkE0F2RDCbnSWs0AgN11SnqRF1cj4CCuyCl3Ppnp4umLkepOP
         uO2FbnBfbj2PtQAa8bNFDf3w0Yg0X98NsJvAq65pwgoO3SSgFhIAG/IsJSMcA37u2srA
         36zg==
X-Forwarded-Encrypted: i=1; AKwUvBxGPxC/tia3KKC5m0jmkes3VSNcvZAxeiOsk2GJLFG3psMn25uG1q9L7esHxfIohetnmuocL60=@vger.kernel.org
X-Gm-Message-State: AFuF++noViOBC5TSNPJKHHUtOJ+dx2Bug/QA8oAYDKwtARbHdazAa4OW
	sRZEM5RknApSqMxBSvmqV5frEwCPI7cSOXlPHNQxBDPUhJph4ASGKKjD
X-Gm-Gg: AYBFou2ZU4PhkTDvEVWNHIGlxQlIiMMnCsti9EP9S7xXtFNcuoloa26452OKLmHtDTB
	29AGa1fCO0qe8PKnJNmo0jNVoLl8aS+aSczJFvrG1PavMJtbqLsOZaVjG9RgBJP0qA0qEk9eiBT
	2DV3YXKRaaiReojIxV5h+dsbKtRVjhxO2vOeTaJq9BCIfCoMuV6DClq+fIKtWF0sIfmNws3fB6Y
	3YNB1jagF/cTHg5120qno3wk5wR4QANQbGPVyYu7fWU0PbHxUB5WRSQwUkV8EhIjiAFbomX5o5P
	ls+kiwIabEeyFnXYK3w9BRfF6fGjA1CUe/epJbeBfURL0TVaQg1twCGonyBPqbn+2m1cg8Y6OBB
	KY54dGUGGZHXZUkXxZ+mVGqhVzY9G2YgFY4bdT8BZGo12Nuw19wUCxa0tpyS29t9gW4zWjTP5Sv
	Bdo25UPQT3qgC9TDc/Ms01E7ty8Xk3N/BHTKPUFOkN0vj3GGrOpfBHpmrKrnY7+ShgxQftJpZeB
	wn8c4V31eqEnN//IlRG1V0ZNxQgkxJJe+xfzZNsUw==
X-Received: by 2002:a05:6000:607:b0:483:3695:6ea0 with SMTP id ffacd0b85a97d-48441fd1c05mr4187379f8f.8.1788274324143;
        Tue, 01 Sep 2026 07:52:04 -0700 (PDT)
Received: from 1Z10 ([78.213.73.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d788ebsm5528909f8f.27.2026.09.01.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:52:03 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maurizio Casciano <maurizio.casciano@eng.it>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: core: Honor supplied-from with CONFIG_OF=y
Date: Tue,  1 Sep 2026 16:51:55 +0200
Message-ID: <20260901145156.3177187-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maurizio Casciano <maurizio.casciano@eng.it>

The supplied-from device property is the name-based counterpart to
firmware-node power-supplies references. It was added for non-DT platforms,
but its parser is compiled only when CONFIG_OF is disabled. CONFIG_OF is a
global kernel option, so x86 systems commonly enable it even when
individual power supplies are described by software nodes.

Consequently, these consumers never populate supplied_from and supplier
notifications do not reach their external_power_changed() callbacks. On a
Lenovo Yoga Book YB1-X91L, ftrace showed the Whiskey Cove supplier
notification running without invoking the BQ25892 callback, leaving the
input current limit at its boot-time value.

Move the generic supplied-from parser into an unconditional helper and try
it before firmware-reference power-supplies lookup. Keep an explicitly
supplied list at the highest priority and retain power-supplies as the
fallback. With the fix, ftrace shows the BQ25892 callback on hotplug and a
boot-offline test changes its input current limit from 500 mA to 2 A.

Fixes: 58a36bb06891 ("power: supply: core: Add support for supplied-from device-property")
Cc: stable@vger.kernel.org
Signed-off-by: Maurizio Casciano <maurizio.casciano@eng.it>
---
 drivers/power/supply/power_supply_core.c | 61 ++++++++++++++----------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 00d8bc98d588..5101decebb7a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -190,6 +190,35 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 		device_unlock(psy->dev.parent);
 }
 
+static int power_supply_check_supplies_by_name(struct power_supply *psy)
+{
+	struct device *parent = psy->dev.parent;
+	int nval, ret;
+
+	if (!parent)
+		return 0;
+
+	nval = device_property_string_array_count(parent, "supplied-from");
+	if (nval <= 0)
+		return 0;
+
+	psy->supplied_from = devm_kmalloc_array(&psy->dev, nval,
+						sizeof(*psy->supplied_from),
+						GFP_KERNEL);
+	if (!psy->supplied_from)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(parent, "supplied-from",
+						(const char **)psy->supplied_from,
+						nval);
+	if (ret < 0)
+		return ret;
+
+	psy->num_supplies = nval;
+
+	return 0;
+}
+
 #ifdef CONFIG_OF
 static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 						 void *data)
@@ -262,19 +291,22 @@ static int power_supply_find_supply_from_fwnode(struct fwnode_handle *supply_nod
 static int power_supply_check_supplies(struct power_supply *psy)
 {
 	struct fwnode_handle *np;
-	int cnt = 0;
+	int cnt = 0, ret;
 
 	/* If there is already a list honor it */
 	if (psy->supplied_from && psy->num_supplies > 0)
 		return 0;
 
+	/* Check for the name-based "supplied-from" device property first. */
+	ret = power_supply_check_supplies_by_name(psy);
+	if (ret || psy->num_supplies)
+		return ret;
+
 	/* No device node found, nothing to do */
 	if (!psy->dev.fwnode)
 		return 0;
 
 	do {
-		int ret;
-
 		np = fwnode_find_reference(psy->dev.fwnode, "power-supplies", cnt++);
 		if (IS_ERR(np))
 			break;
@@ -304,28 +336,7 @@ static int power_supply_check_supplies(struct power_supply *psy)
 #else
 static int power_supply_check_supplies(struct power_supply *psy)
 {
-	int nval, ret;
-
-	if (!psy->dev.parent)
-		return 0;
-
-	nval = device_property_string_array_count(psy->dev.parent, "supplied-from");
-	if (nval <= 0)
-		return 0;
-
-	psy->supplied_from = devm_kmalloc_array(&psy->dev, nval,
-						sizeof(char *), GFP_KERNEL);
-	if (!psy->supplied_from)
-		return -ENOMEM;
-
-	ret = device_property_read_string_array(psy->dev.parent,
-		"supplied-from", (const char **)psy->supplied_from, nval);
-	if (ret < 0)
-		return ret;
-
-	psy->num_supplies = nval;
-
-	return 0;
+	return power_supply_check_supplies_by_name(psy);
 }
 #endif
 
-- 
With Best Regards,
Maurizio Casciano

