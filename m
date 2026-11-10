Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337128;
	b=W57BRlOPG7jVYXF2RUoUZJiS6eIDFCwU8tKSsKRAJd0YsZvwwmL0ueQ4qLLHfCJOITPN
	 Ucy80DV9dQ+KA4aqYYHJVXzdSiaLBqoy07TJtHZQ9ohNw4/cHHXBAzlWPm0bKv9Zx/eSI
	 5q3+roZsVlA/06YpHVEs6H1FwnheQUUkMjGqYBgcMe/bHFl59vJ6PP5OAo4a0VaV/ctGI
	 hjKysNdUiRSaQpOmkCPKI2jL4vwLIqgq9+VbHGIqsko9GJTsRr0c62lJmREILeb7VUF2D
	 frBuEHZnNEzQiBlC796TqD2rsOZu5+7tES2xhBr38jJIM0ZBgggQagT7Hzak/Mg01xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3MfLhiXmCdKjfh/U63R9E12Tm3m3iFr7FoCaumnMt8w=;
	b=wQShnrt3hf8dplIQfcPQ+GkN7x7drht5FT07tOHRhG3uJB1tMwtIAZ1Fe0PDYHrlgD87
	 BJdwSwTyxVKciXk7YsiVHojh1F6+9UggVrDIeBsf1lu6IM2yRELgtxq8QSXiGc4mRonNA
	 dn38QcsFVgGyCXvWYqVsifJiUIgOTpaz8CKwuiZPbg5X/TeNkW565hvlbI0st11n5nqlx
	 7AG2QlhtnBbX/2Lcyh8i1uJa8QqTBOVHFntkyNUeDUgBP9ary/uIUcg42vu59mnLODlvQ
	 ZK6z+FzGjq3bzqse4OgmukoZNSvUaO0VlAm0EPPZxsoITCYdxH8jk7+/dXNfh1W0Krg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dObQw0pK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B56606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dObQw0pK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157BA1F008A1;
	Tue, 10 Nov 2026 18:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337127;
	bh=3MfLhiXmCdKjfh/U63R9E12Tm3m3iFr7FoCaumnMt8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dObQw0pKN3BI0SoGz3ca/FEF7clj0jKxgVm8D5bIsdZJn5MHJKcGatDmMZue7seIh
	 OG73YEXUI/pEj/xR0N4eAVSQBbz0eDLk4tCbcPJ30R6z2KaDr6RF5/HdzYDRqtP9Ud
	 CAEXV+Osvuhstu3PMOoTgZQupzve3ko4GTaY5+pGcQsA9P5u0WQ9TwyrPbzNXyih28
	 Wvq8P5lr822XdkUm3qe5ko9mE/6jYnJFMkUF6fP5IjC2M2PTJsjYs/GnkF1tEetxAt
	 OQ3JEppwc6y7yD/+ukUmBWeYVLdme3o+Cg0EHDIPgmVZxtFKm3l5gT6yghH6lBa7vM
	 3LnwsPV4phVyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maurizio Casciano <mauriziocasciano7@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] power: supply: core: Honor supplied-from with CONFIG_OF=y
Date: Tue, 10 Nov 2026 13:58:45 -0500
Message-ID: <20261110185826.3102342-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061846-failed-5.10-6bd80f22c764@kernel.org>
References: <20261107061846-failed-5.10-6bd80f22c764@kernel.org>
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

From: Maurizio Casciano <mauriziocasciano7@gmail.com>

[ Upstream commit 6bd80f22c764fe8c56c62c118387f86a3ca98cff ]

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
Link: https://patch.msgid.link/20260924225152.985489-1-mauriziocasciano7@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
[ sashal: replaced fwnode_find_reference() with of_parse_phandle_with_fixed_args() to use existing OF nodes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 81 +++++++++++-------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 61ba2b343b938..2a382617900ef 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -154,7 +154,6 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 		mutex_unlock(&psy->dev.parent->mutex);
 }
 
-#ifdef CONFIG_OF
 static int __power_supply_populate_supplied_from(struct device *dev,
 						 void *data)
 {
@@ -229,71 +228,68 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 
 static int power_supply_check_supplies(struct power_supply *psy)
 {
-	struct device_node *np;
-	int cnt = 0;
+	struct device *parent = psy->dev.parent;
+	struct of_phandle_args args;
+	int cnt, nval, ret;
 
 	/* If there is already a list honor it */
 	if (psy->supplied_from && psy->num_supplies > 0)
 		return 0;
 
-	/* No device node found, nothing to do */
-	if (!psy->of_node)
-		return 0;
-
-	do {
-		int ret;
+	for (cnt = 0; psy->of_node; cnt++) {
+		ret = of_parse_phandle_with_fixed_args(psy->of_node,
+						       "power-supplies", 0, cnt,
+						       &args);
+		if (ret) {
+			if (ret != -ENOENT)
+				return ret;
 
-		np = of_parse_phandle(psy->of_node, "power-supplies", cnt++);
-		if (!np)
 			break;
+		}
 
-		ret = power_supply_find_supply_from_node(np);
-		of_node_put(np);
+		ret = power_supply_find_supply_from_node(args.np);
+		of_node_put(args.np);
 
 		if (ret) {
 			dev_dbg(&psy->dev, "Failed to find supply!\n");
 			return ret;
 		}
-	} while (np);
-
-	/* Missing valid "power-supplies" entries */
-	if (cnt == 1)
-		return 0;
-
-	/* All supplies found, allocate char ** array for filling */
-	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(psy->supplied_from),
-					  GFP_KERNEL);
-	if (!psy->supplied_from)
-		return -ENOMEM;
-
-	*psy->supplied_from = devm_kcalloc(&psy->dev,
-					   cnt - 1, sizeof(char *),
-					   GFP_KERNEL);
-	if (!*psy->supplied_from)
-		return -ENOMEM;
+	}
 
-	return power_supply_populate_supplied_from(psy);
-}
-#else
-static int power_supply_check_supplies(struct power_supply *psy)
-{
-	int nval, ret;
+	if (cnt) {
+		/* All supplies found, allocate char ** array for filling */
+		psy->supplied_from = devm_kzalloc(&psy->dev,
+						  sizeof(psy->supplied_from),
+						  GFP_KERNEL);
+		if (!psy->supplied_from)
+			return -ENOMEM;
+
+		*psy->supplied_from = devm_kcalloc(&psy->dev,
+						   cnt, sizeof(char *),
+						   GFP_KERNEL);
+		if (!*psy->supplied_from)
+			return -ENOMEM;
+
+		return power_supply_populate_supplied_from(psy);
+	}
 
-	if (!psy->dev.parent)
+	/* Fall back to the name-based property if no references were specified. */
+	if (!parent)
 		return 0;
 
-	nval = device_property_read_string_array(psy->dev.parent,
-						 "supplied-from", NULL, 0);
+	nval = device_property_string_array_count(parent, "supplied-from");
 	if (nval <= 0)
 		return 0;
 
 	psy->supplied_from = devm_kmalloc_array(&psy->dev, nval,
-						sizeof(char *), GFP_KERNEL);
+						sizeof(*psy->supplied_from),
+						GFP_KERNEL);
 	if (!psy->supplied_from)
 		return -ENOMEM;
 
-	ret = device_property_read_string_array(psy->dev.parent,
-		"supplied-from", (const char **)psy->supplied_from, nval);
+	ret = device_property_read_string_array(parent, "supplied-from",
+						(const char **)psy->supplied_from,
+						nval);
 	if (ret < 0)
 		return ret;
 
@@ -301,7 +297,6 @@ static int power_supply_check_supplies(struct power_supply *psy)
 
 	return 0;
 }
-#endif
 
 struct psy_am_i_supplied_data {
 	struct power_supply *psy;
-- 
2.53.0

