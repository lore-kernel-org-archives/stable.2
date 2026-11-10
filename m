Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329433;
	b=KjUHK/uUDIHIG1XIoRz3OdSk1ukq8Mtei8JSJ0vqxBT4tAkv4lXDVgd4WEOId0ovnCXe
	 2u4qqXd3Vlrf1jX0Rw88mBsMYaoLd8qW4X4kuEcxoo1Ozr3QNaUcz3zOK/DoD4FXE04Y9
	 g7IySOaX4nCuIdZBcn75IARI1QoTiVwzLmEadl9X4sOZvhm0Vm3pwbU53Bx+dhpAt3RWR
	 a4I47Wf/2OkgS70hFNZs/SK4wE99Z2KTiaGf2GJBCEW9Drz1YpK8xFlGkaw6DJGd6FIAr
	 t01+V/XZdfTErxAUiZLElbhxS1z/wDLxBcwn9wpmTiPjIMSlZXu2INxCMYsZmyGT7fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329433;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A9SBMfYRbNz59u43LpGJw7HuHEYNzvW0jZss9Jw1b0s=;
	b=Dsv3wMGXGj5jR10aNA4dNGjnxydoKdKeupo0KYOHtBCt6tUlFibldPfA9mQU5Rx5nJ/v
	 YKnVFEAHJRl3rvmuyZJFV91aZInYB9kKNtirOtFt/utusowOF8SWeAEhDzbN1mVLQvSeO
	 z7pOJA7Ma6kbU1yUNKTMNzAnr3Bi/nmStQDZE9fhXnSjg+r/C/PL6Gm8o+NSifkW03F1K
	 1qTtXOkjw2yqm8a1ZQPtWBUTGBwNfa8bc5cpqEO4sJHVWkOG+9FkN2xiS435AVVkm1nzF
	 g+isuBhK0ehmQTmJmbOTE15QgNUf9t5REZOcrLvZLQGq3x0aYWA01zgU5Fapr1Aqjfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2eEIInK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6DD606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2eEIInK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E28E1F008A4;
	Tue, 10 Nov 2026 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329432;
	bh=A9SBMfYRbNz59u43LpGJw7HuHEYNzvW0jZss9Jw1b0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2eEIInKrYRUqZVcS452pFMhvU9DCsqhh38l29nbTOybfoYUWJ5AvDqAggE1kyYO0
	 jjHpbR1fvLMaP6T1+p+WZgBb7EOpNo8lL/NwsMPgn5xD7C3zwtzrdbQZ+PKHGhK/bx
	 uHgCAg3sZ9B7od+33C20LGPoNYe22XIyE4j05XmYai9fawAkwl99gLLmERk/DdR+AC
	 Hma1o7ZcxhrwclYfOs6qFEUAf52boyV2vXyTfDP3jXFehuIE2kAAua5d4Ti5Zk8ZfA
	 Mx7ayGRXE0pBW7aMcsfcVZUuSoD0akHUpZUGEkKNXNNm2eiAgrozfcjUlCozbA7LeU
	 xNkNiROrBUpMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] power: supply: core: get rid of of_node
Date: Tue, 10 Nov 2026 11:50:28 -0500
Message-ID: <20261110164953.2511682-3-sashal@kernel.org>
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit 134254038739a6c6ecb7548a2f895d89a0dc9d2a ]

This removes .of_node from 'struct power_supply', since there
is already a copy in .dev.of_node and there is no need to have
two copies.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20250225-psy-core-convert-to-fwnode-v1-1-d5e4369936bb@collabora.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 6bd80f22c764 ("power: supply: core: Honor supplied-from with CONFIG_OF=y")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 17 ++++++++---------
 include/linux/power_supply.h             |  1 -
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 252930b54138d..3d4856ae2e798 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -197,11 +197,11 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
 	int i = 0;
 
 	do {
-		np = of_parse_phandle(psy->of_node, "power-supplies", i++);
+		np = of_parse_phandle(psy->dev.of_node, "power-supplies", i++);
 		if (!np)
 			break;
 
-		if (np == epsy->of_node) {
+		if (np == epsy->dev.of_node) {
 			dev_dbg(&psy->dev, "%s: Found supply : %s\n",
 				psy->desc->name, epsy->desc->name);
 			psy->supplied_from[i-1] = (char *)epsy->desc->name;
@@ -232,7 +232,7 @@ static int  __power_supply_find_supply_from_node(struct power_supply *epsy,
 	struct device_node *np = data;
 
 	/* returning non-zero breaks out of power_supply_for_each_psy loop */
-	if (epsy->of_node == np)
+	if (epsy->dev.of_node == np)
 		return 1;
 
 	return 0;
@@ -267,13 +267,13 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		return 0;
 
 	/* No device node found, nothing to do */
-	if (!psy->of_node)
+	if (!psy->dev.of_node)
 		return 0;
 
 	do {
 		int ret;
 
-		np = of_parse_phandle(psy->of_node, "power-supplies", cnt++);
+		np = of_parse_phandle(psy->dev.of_node, "power-supplies", cnt++);
 		if (!np)
 			break;
 
@@ -598,8 +598,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	const __be32 *list;
 	u32 min_max[2];
 
-	if (psy->of_node) {
-		battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
+	if (psy->dev.of_node) {
+		battery_np = of_parse_phandle(psy->dev.of_node, "monitored-battery", 0);
 		if (!battery_np)
 			return -ENODEV;
 
@@ -1384,9 +1384,8 @@ __power_supply_register(struct device *parent,
 	if (cfg) {
 		dev->groups = cfg->attr_grp;
 		psy->drv_data = cfg->drv_data;
-		psy->of_node =
+		dev->of_node =
 			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
-		dev->of_node = psy->of_node;
 		psy->supplied_to = cfg->supplied_to;
 		psy->num_supplicants = cfg->num_supplicants;
 	}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 565a40172cc30..efd5f0ae397a9 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -287,7 +287,6 @@ struct power_supply {
 
 	char **supplied_from;
 	size_t num_supplies;
-	struct device_node *of_node;
 
 	/* Driver private data */
 	void *drv_data;
-- 
2.53.0

