Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331282;
	b=49A+mx9IMdwCPfS4PRr/Ppl/vKgmZ8Sbh3gTYXmxZJ7FH4xcsX5yLq3fesnC+VSypnJ0
	 8GDJgZnArnutiikRkscM2+TWsKBLNgoBRLCLEBvNBCTMtJ94YumVhr/qvweW7fSu5xGaw
	 P1dxammoWvgNy4eA2rC5ZDKxHJoVMEYIGENR0sYvPq4o4G7+EfSKC8vXwCd5UNgPogf6A
	 Cg5xZxYdAXp5wEJPaCMP4Nw2L6ji8B/dynEBhN9rdC02T/aB5WeghTggFl34GkJ59gJ/t
	 ZMBNJMnNndxh0DIQ0PGwyi4sLFTk9MgY5NKnSBq3VR6QiNI/rSze3qEjCYOrt0CEqgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331282;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ysDi/1BhKDqVkZc1CTRcsq87mMcsesZ571bsRnnwg1U=;
	b=OAS57fhzyXt11gHrVKIr2cekQD9DbWV5DROxhOInHChqzOR2RoarbqjtOwyUzwF+kNLE
	 isHxn4mLCO+EYBEMAqvrFurVxZiVAjdrKMDzAlGryeUKbyTBeolv4evHYZL9nmEhNfsDl
	 ygDyfSLoNMUD916gmy9DOn/D/a59eDYaW7mNUDukIJ4/JA3HMBc0vOimZUKI3SQPn9ArF
	 Tsv5xmq1/EVCZFxd7a/vUjo1puJ10+uHTQR+v7nLoMa+IL/5DIuAbORz8L24pohGqAslF
	 43XoguevgRuH2Ray+WLMoL0cVAgXxektjCinklCX5aiVpGDEH9BAQZBbZ6fGyctNBYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nqrpkB/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3932606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqrpkB/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A001F008A4;
	Tue, 10 Nov 2026 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331281;
	bh=ysDi/1BhKDqVkZc1CTRcsq87mMcsesZ571bsRnnwg1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqrpkB/GSHgg/vnOqQLnJnpQY7YL0gYzDktFhdI35KAEyIo+NAmkeh3eEauUlyE5d
	 JqO8vhGEq4WzZ9zm3k1P1FsF8vA3yoQ4B6VTNC1qM3jXJa23KbpxniCJsa6VJVuBxn
	 g/FsMpkMYZ3n4pEeSqBICexjDqYIK2beE+sZxSwOfezgJrtHVt8utfurwGXai1MhvL
	 KfWM5D3zwFxhug1lApV39CMoPmgzzW2nW5H9trY829ed1tQV9j7wTuPPBwzs6VkC6i
	 ZBGByerIt0Pa3KqiYtP12KZWAE7z7jfsLw03viXWb+uojQThJklAA4cKhQFxA/iF1b
	 we6eKps+N2Ljg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/7] power: supply: core: get rid of of_node
Date: Tue, 10 Nov 2026 12:21:12 -0500
Message-ID: <20261110172014.2622013-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110172014.2622013-1-sashal@kernel.org>
References: <20261107053127-failed-6.6-6bd80f22c764@kernel.org>
 <20261110172014.2622013-1-sashal@kernel.org>
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
 drivers/power/supply/power_supply_core.c | 16 ++++++++--------
 include/linux/power_supply.h             |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 2929e21b82032..a55b85ffe3337 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -194,11 +194,11 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
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
@@ -229,7 +229,7 @@ static int  __power_supply_find_supply_from_node(struct power_supply *epsy,
 	struct device_node *np = data;
 
 	/* returning non-zero breaks out of power_supply_for_each_psy loop */
-	if (epsy->of_node == np)
+	if (epsy->dev.of_node == np)
 		return 1;
 
 	return 0;
@@ -264,13 +264,13 @@ static int power_supply_check_supplies(struct power_supply *psy)
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
 
@@ -595,8 +595,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	const __be32 *list;
 	u32 min_max[2];
 
-	if (psy->of_node) {
-		battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
+	if (psy->dev.of_node) {
+		battery_np = of_parse_phandle(psy->dev.of_node, "monitored-battery", 0);
 		if (!battery_np)
 			return -ENODEV;
 
@@ -1390,7 +1390,7 @@ __power_supply_register(struct device *parent,
 	if (cfg) {
 		dev->groups = cfg->attr_grp;
 		psy->drv_data = cfg->drv_data;
-		psy->of_node =
+		dev->of_node =
 			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
 		psy->supplied_to = cfg->supplied_to;
 		psy->num_supplicants = cfg->num_supplicants;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 4b231468c3f1d..84cff00720d03 100644
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

