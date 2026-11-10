Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332573;
	b=pPTljCnNheFlQnQTmAelhVokiSZH2zMFDNlGvoBjMbWuQzMeErioKkP8LYmyFytvDfMV
	 84vNhL9fDDvMV8bXTEMWagB7PSnzvDXnvxXpofVHecbKrtEQyJrNlCVpuo5P+X3d42R1C
	 gKrfa/PJG445Y8UTasO5j1YHh+UnmvxhHwre/G8bTZih8jvP+Q8GqfGqgdrq84jQ/n/0y
	 /wp2n8dE1wG5Te7MVG4AD9cZF/+d/cFDuGLWRFo6k8D+9j8gGghazDt0F58vDqT2KeZ8c
	 1NpsuKcJSOJjEkXjDQpIRHSEQPRNhAeISzIgCLheYIT1cH/G7y66VDQrh5tOQhATRwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332573;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7L1VibNKvGKUF6dxTmm6umm5njsYe57Ryd6Oy5GeP6E=;
	b=n88SdEm43dNZ1SEMK8IgfY7Xz8WMCJzDPQnncJSEdFarhlWMX4+NEXNfTxZd6toGIdu9
	 EcBoXjOUVCsA26MjI+ZVRTqxEAiB3kv1MR3iLA/8AipLXd2ZLvTC8HeGuw9Y29r8cKmTs
	 GEbKh9BS455uGj1v6rm5PDvJcZyYbOXfFBiR2rfMut69VKHnj7kEeIXqXW5D0mES1IAkH
	 qTzEMHgOM5nCqtKILfbIz5+fG1LV66VT9QFdcmT6g5GLVnC+kwTqLWopF91r9tkHMBUQi
	 OrmKzwZP1ZtAU9EOvUuvBzx4CqO8nbnzwcsHXS4BB4xYchazF5FbAx79yL8hVZZwEdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXbawpIE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD860A2616
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXbawpIE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE4E1F008A6;
	Tue, 10 Nov 2026 17:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332572;
	bh=7L1VibNKvGKUF6dxTmm6umm5njsYe57Ryd6Oy5GeP6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dXbawpIEZb76G3iZ91q8RDKWIXuBpPWC9+XS5hisjN1TZ+SUdt9uXZSgQEPn1+g6/
	 EMq5wzf8hEWncL+1OMUe63zBR2eNHnfV/6FsTYCGKc4qMAc//pmn2H7Wi9j9Q8ps5+
	 7imn9iA1fYeGn+lRk2hKSA4bZWiKUFoJ0Sr2Hz1zsAXLFDwJ6pw+JHRbhp/4OFOUv6
	 mLaURZonrcHSjsIHhW5uUPwSQAILMmdgDwkvxHy4DYrWq34T3qC+s8YYeDmJBMHS8g
	 m5l1ZcQ1C+eIqNu6N1nu4mgFGtL+xDullAURCigbjy/lRF2t8sR0fBZJTiu6iFKTly
	 lt/21+vOeoq0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maurizio Casciano <mauriziocasciano7@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] power: supply: core: Honor supplied-from with CONFIG_OF=y
Date: Tue, 10 Nov 2026 12:42:50 -0500
Message-ID: <20261110174222.2915106-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054415-failed-6.1-6bd80f22c764@kernel.org>
References: <20261107054415-failed-6.1-6bd80f22c764@kernel.org>
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
[ sashal: Replaced fwnode_find_reference() with of_parse_phandle_with_fixed_args() to use existing OF-node interfaces. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 67 +++++++++++-------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 54a1d8dee95dd..1b4b8c7a5fd3a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -156,7 +156,6 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 		mutex_unlock(&psy->dev.parent->mutex);
 }
 
-#ifdef CONFIG_OF
 static int __power_supply_populate_supplied_from(struct device *dev,
 						 void *data)
 {
@@ -231,65 +230,62 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 
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
+	}
 
-	/* All supplies found, allocate char * array for filling */
-	psy->supplied_from = devm_kcalloc(&psy->dev,
-					  cnt - 1, sizeof(*psy->supplied_from),
-					  GFP_KERNEL);
-	if (!psy->supplied_from)
-		return -ENOMEM;
+	if (cnt) {
+		/* All supplies found, allocate char * array for filling */
+		psy->supplied_from = devm_kcalloc(&psy->dev,
+						  cnt, sizeof(*psy->supplied_from),
+						  GFP_KERNEL);
+		if (!psy->supplied_from)
+			return -ENOMEM;
 
-	return power_supply_populate_supplied_from(psy);
-}
-#else
-static int power_supply_check_supplies(struct power_supply *psy)
-{
-	int nval, ret;
+		return power_supply_populate_supplied_from(psy);
+	}
 
-	if (!psy->dev.parent)
+	/* Fall back to the name-based property if no references were specified. */
+	if (!parent)
 		return 0;
 
-	nval = device_property_string_array_count(psy->dev.parent, "supplied-from");
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
 
@@ -297,7 +293,6 @@ static int power_supply_check_supplies(struct power_supply *psy)
 
 	return 0;
 }
-#endif
 
 struct psy_am_i_supplied_data {
 	struct power_supply *psy;
-- 
2.53.0

