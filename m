Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329434;
	b=nXNI2DyWQjadDjz5lLHacAOHK3K8IJMhFApD/XOyOSxZcE9VSAjOdUGkJm/25Yuqs0/f
	 ta9XQ4veNYbq0/30hRbn665u3SO5vCoyXJlQgjNC7wbq+HGlUpmf9KrErK56Xv1ZLsFAm
	 FbaTTI/sVcbXeErlpoQ43nQ+3Z6MBCqIykymBuFmCPrFy6LUKF6RK6nTiwRlfYsZ6xBGo
	 iLHp3w1N6AGehyIDWoUn/9j+6r8EuES0oXPYjz4F6OGXQuvUL1DMmDwEh7fhzZ4VkF07D
	 etF592nQ2baFFVRACDQHKamqPRi9ZHRaBRXrIkr3jodaqpSWLAjgwP3kJ/BuqP5iQZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XrbxJn+okl7GEQTexEgF3q6V7hJ8/nJ7zmyL/xdwdEo=;
	b=ioYdKslAl4WRNl8l5BQaMJoZcvhIu68V3DH6Ks2pi5miBb4hfhZRf95i8gUjMXyOyqcX
	 CsOzpISg+28GEIb5WU3Xm8nKA2sqUXbiILvynX7mtJZa6J/iidCQ2zbIthFOv1miTjhzM
	 yjAcra1hOphNTntY0Lg61KATA7Z1ilBrbS4JU3hZm06KqmxMS6pHuCI+fftaT0Np/EYzR
	 qpkKA9MhEvm2iFjUphO93/WxW1GZloG6wHwPVk5CtRtNhKC3cmbdQzo5jdqtB8OQZctfu
	 +64CIkT5+4WXfWMyCMkiihL0R6J0rq2m0Hxm5yucQJUmt3Rm7L+DFp+6GUv9dh4tZOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEVHTF98;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F20606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEVHTF98
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3551F008A5;
	Tue, 10 Nov 2026 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329433;
	bh=XrbxJn+okl7GEQTexEgF3q6V7hJ8/nJ7zmyL/xdwdEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEVHTF98oul+iP3sNicmfp2VWoAEbQqrUivYWRYyivWqKAWXp0ZX7VOZj19hn759z
	 CWd1nOQah4i5cyFz+W9tQd7APlWSYCN2OG+lwYCY3IpMrVAo88VBGcTP1MzgYjnNfA
	 XdqTaZv3Mownx+PhKLqeZzdvokyxeYXqHFMrnFeEbJHNs7Oavj/TgXGzWkggTamU8P
	 CgsA334bPS4kKJLP4po5cVEbHOEdTN/2H8REyE923uXb4nBd9Pv37f3SR4OomSI1JB
	 AgK38zxBhkoeXNiUu/javi8HS3Y1NDieygnmMTdzRM2vVkNByCy14MrAYqC6YQihsk
	 C6arCX68GBUhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maurizio Casciano <mauriziocasciano7@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] power: supply: core: Honor supplied-from with CONFIG_OF=y
Date: Tue, 10 Nov 2026 11:50:29 -0500
Message-ID: <20261110164953.2511682-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110164953.2511682-1-sashal@kernel.org>
References: <20261107051904-failed-6.12-6bd80f22c764@kernel.org>
 <20261110164953.2511682-1-sashal@kernel.org>
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
[ sashal: adapted firmware-node supplier lookup to existing device-tree APIs using of_parse_phandle_with_fixed_args() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 90 ++++++++++++------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 3d4856ae2e798..b02a9123b30a1 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -188,7 +188,35 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 		mutex_unlock(&psy->dev.parent->mutex);
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
@@ -259,73 +287,45 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 
 static int power_supply_check_supplies(struct power_supply *psy)
 {
-	struct device_node *np;
-	int cnt = 0;
+	struct of_phandle_args args;
+	int cnt, ret;
 
 	/* If there is already a list honor it */
 	if (psy->supplied_from && psy->num_supplies > 0)
 		return 0;
 
-	/* No device node found, nothing to do */
-	if (!psy->dev.of_node)
-		return 0;
-
-	do {
-		int ret;
+	for (cnt = 0; psy->dev.of_node; cnt++) {
+		ret = of_parse_phandle_with_fixed_args(psy->dev.of_node,
+						       "power-supplies", 0, cnt, &args);
+		if (ret) {
+			if (ret != -ENOENT)
+				return ret;
 
-		np = of_parse_phandle(psy->dev.of_node, "power-supplies", cnt++);
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

