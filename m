Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDBF41DEE7
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290318; cv=none; b=SzILmXrF67TckSt+hq5ULdFq+wyzQNOBf/z+TXJZjCMbc8s2tC9RZlfXDYcD1WB6dZ7Qu2EXtjQyfXKHbhZjGQ/IGGd5IIv54QeVPkDRXRPzCpN7Utjv0p2YkuzxaVOiqee3lEyRqUT7xk6ytd9doqR9hyNjZs4gqNxe5zaEp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290318; c=relaxed/simple;
	bh=62XiZv6zk3rTKUR1/CJN607c+3Nv6L/9YqYGWxYk92A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgN1xTHWQhOg3DrjeJo1+G2/vfPmTv8kYvhB0YfQVI9p4d4alLGv/GX2BUEJ7aXxKax5ILc5HdC3BNHsAYy2d6dIaFUcYQu4aQE32FDjPzF/b2rMpenLUcsXnD54hSRBOeuO0Ivcv0pEt/tTcfvejLpW07AU/S01v8YT0KMVak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr7MkNWE; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr7MkNWE"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so2287765e9.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790290315; x=1790895115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DY4/sCTlc60wxmtt4c/QaqdPIrvNF/5bj6Z1Qp+fliA=;
        b=Jr7MkNWEv9EYHPscJTXfpurWeYrYnCM+0e9DH3RLK9v+Nzxzgy3jxSmw3Rz3HEmIeM
         vc8RvLFYRO3qGRbf2Ab6qQZd8G+2zmeNFT1kR7r0K1BIumx0TyHU+TPNUmg4K7itAeCt
         KqSB8clSDNfg6p2TZHy/2Xg+HH9Y70oOO+JLGLlPyAtpB048S9L9LfO8EiyEPT9w5ncO
         O9xTcLFXKKweYgvlRQoGX7c9W0QaNUKpi3OTzmA7r0lvpgI5Mtubsx9+3vjF7lnwRrYq
         HvPGtjDoVqqmO3uNUaE01pxfloL+FrLDw2FtO9/QOI+DzuBwtCVFKscHyN2qzVb6EvJF
         veTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290315; x=1790895115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DY4/sCTlc60wxmtt4c/QaqdPIrvNF/5bj6Z1Qp+fliA=;
        b=u7Q1oho7AOt5ATYr0lBcEkRLiYeFWOVGmo0YaTVGdXJ7R754/S3yBqH9HgNN6/xfod
         ZHAhpCn3yC7Fj5PepuBPD+C0Dew9+x3uGixd/gPnBYQkqG6WC4das009cNcQSLTGgFt/
         Dgbu9jCLffxJ3464BN1nYWjHcAlk6AeN3kjconSySZP5wMrrUMel7qXGarUW81BrTbAM
         VTkxasR//AOj5P8e+414F5dh/3yJiGQBuZBjTLbxvTpok+eXXaiaDlLUbQb9h/WUgMb3
         5hIus8s/MksKmrxUCqiJ3wt6rvIm7a+MyR9jpeJ+4VQWqnUnKiEAwXbtSFzfhcCGNoiH
         dPMw==
X-Forwarded-Encrypted: i=1; AKwUvByyNhJoClW7/QIWPhRICb9zCjGVZkfkdyxkTXOv7tg1IEJObLwYquXOCq4RuGZkQ/1Bfnjeirw=@vger.kernel.org
X-Gm-Message-State: AFuF++mmokf7aB60MO6pBVic6YsK5Q36P2XXG5NQ2xuB1yD0Q+5gtoWa
	4Yh6M7jh50ROtKzxpEAUQZYxr7VihpJwONSLT159humOdDFf8C/YsFsF
X-Gm-Gg: AYBFou2e86BU0qGYtKh4a8qY/00RJ0/ZjvtxBgbqLPEsx27WDOvKq45SC34apOKWerr
	KpKiFR8XKDQvnwMgGefPMmwvdpt0R3dpOj3YvCeBU9mMt2NFotDesMUGr9UjrVzvFG8m0DNftTb
	fFR8DUFYt5DVCyhkcN/rkn3fUFJlA7DUdfrL3OKLre+GDbDNsjiJSialRbEKdPlZCgjS3Vqf9ZS
	uXM5PFqwzNpPrByBoDEBri8Qe01izSPyEUnkM8/cld9CmS2r9RtYUSMOGX0iB0I6g8E0dOR68c+
	pTt6pgQjOmbXO9XT6G7huNV7AVg1v+qZxNpHksrBlw0v7bNx/x7fbtOiAu2uKEkaDO889Pp4T1I
	XuxFI6H1VFAMfp6yaNyXtFITTgiJJDbhfw0M0Q7hZRi+5XKwXpWIivGbkwehlC2kIHJoXW/i9ja
	VLrzOmsr0sJ17pHtfL6xbKotP7jZaACl6z/nnBSo6MQYRDB3J7FZEdwUki/64AYAhtr53yoGlwV
	EUeV+uguyXDZspGeQTlSMITIHlDKFJdclnK1uXslS9OSLnw48zooNB7dym6P5WyDmtTccaIai25
	5Z2sB90OnSyu8X9ZtZM1aCCTe6M=
X-Received: by 2002:a05:600c:1d28:b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49fe66fc677mr74153985e9.33.1790290314882;
        Thu, 24 Sep 2026 15:51:54 -0700 (PDT)
Received: from 1Z10 (mob-176-245-31-160.net.vodafone.it. [176.245.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5ce4941sm97253225e9.6.2026.09.24.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:51:54 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] power: supply: core: Honor supplied-from with CONFIG_OF=y
Date: Fri, 25 Sep 2026 00:51:52 +0200
Message-ID: <20260924225152.985489-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The supplied-from device property is the name-based counterpart to
firmware-node power-supplies references. It was added for non-DT platforms,
but its parser is compiled only when CONFIG_OF is disabled. CONFIG_OF is
a global kernel option, so x86 systems commonly enable it even when
individual power supplies are described by software nodes.

Consequently, these consumers never populate supplied_from and supplier
notifications do not reach their external_power_changed() callbacks. On a
Lenovo Yoga Book YB1-X91L, ftrace showed the Whiskey Cove supplier
notification running without invoking the BQ25892 callback, leaving the
input current limit at its boot-time value.

Use a single power_supply_check_supplies() implementation for all
configurations. Preserve firmware-node power-supplies references as the
preferred firmware description and use the name-based supplied-from
property only when no references are specified. Continue to honor an
explicitly provided supplied_from list first and propagate errors from
specified firmware references.

With the fix, ftrace shows the BQ25892 callback on hotplug. A boot-offline
test changes its input current limit from 500 mA to 2 A.

Fixes: 58a36bb06891 ("power: supply: core: Add support for supplied-from device-property")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
---
Changes in v2:
- Keep firmware-node power-supplies references ahead of the name-based
  supplied-from fallback, as requested by Hans.
- Propagate errors while resolving specified firmware references.
- Use one power_supply_check_supplies() implementation, as requested by
  Sebastian.

Link: https://lore.kernel.org/r/20260901145156.3177187-1-mauriziocasciano7@gmail.com
---
 drivers/power/supply/power_supply_core.c | 84 ++++++++++++------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 47e307709e5e..945052a8371e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -190,7 +190,35 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 		device_unlock(psy->dev.parent);
 }
 
-#ifdef CONFIG_OF
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
 static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 						 void *data)
 {
@@ -262,22 +290,21 @@ static int power_supply_find_supply_from_fwnode(struct fwnode_handle *supply_nod
 static int power_supply_check_supplies(struct power_supply *psy)
 {
 	struct fwnode_handle *np;
-	int cnt = 0;
+	int cnt, ret;
 
 	/* If there is already a list honor it */
 	if (psy->supplied_from && psy->num_supplies > 0)
 		return 0;
 
-	/* No device node found, nothing to do */
-	if (!psy->dev.fwnode)
-		return 0;
-
-	do {
-		int ret;
+	for (cnt = 0; psy->dev.fwnode; cnt++) {
+		np = fwnode_find_reference(psy->dev.fwnode, "power-supplies", cnt);
+		if (IS_ERR(np)) {
+			ret = PTR_ERR(np);
+			if (ret != -ENOENT)
+				return ret;
 
-		np = fwnode_find_reference(psy->dev.fwnode, "power-supplies", cnt++);
-		if (IS_ERR(np))
 			break;
+		}
 
 		ret = power_supply_find_supply_from_fwnode(np);
 		fwnode_handle_put(np);
@@ -286,48 +313,21 @@ static int power_supply_check_supplies(struct power_supply *psy)
 			dev_dbg(&psy->dev, "Failed to find supply!\n");
 			return ret;
 		}
-	} while (!IS_ERR(np));
+	}
 
-	/* Missing valid "power-supplies" entries */
-	if (cnt == 1)
-		return 0;
+	/* Fall back to the name-based property if no references were specified. */
+	if (!cnt)
+		return power_supply_check_supplies_by_name(psy);
 
 	/* All supplies found, allocate char * array for filling */
 	psy->supplied_from = devm_kcalloc(&psy->dev,
-					  cnt - 1, sizeof(*psy->supplied_from),
+					  cnt, sizeof(*psy->supplied_from),
 					  GFP_KERNEL);
 	if (!psy->supplied_from)
 		return -ENOMEM;
 
 	return power_supply_populate_supplied_from(psy);
 }
-#else
-static int power_supply_check_supplies(struct power_supply *psy)
-{
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
-}
-#endif
 
 struct psy_am_i_supplied_data {
 	struct power_supply *psy;
-- 
2.53.0
