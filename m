Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804604;
	b=e/Pc/7RswH6pjaCTbQb6DZkNLJj1XWAYHc+YQQZyNGhLgrnP9ZbW5BRisQ6TyQjVQHvX
	 KDxg9z4sOexpepQgX9P4YqJ/CzzRMpQNigphhnYmsHMCD7/LjrR1pbAhj2e/C0gz4+ojv
	 LbGah+kNpM6k3Sx5+pptyPLt9EScwof0yrdH7Vl2nNq3dzmW4TaqPqSc4OuENdFsxkfML
	 yTq4Cj8ghllnBPOnMK6YC8o2fUKjxY1NmZUmQpBstiPJZKLHplR0Se9GHRsp781ZirNT/
	 5ea9o1YyPOJt4XpinjmNWIZedDmsD922qEEDUtzwadhjWrSK/qaioUatr0y661rIekg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804604;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q/DHnuShonHGs9vWHUGnG2mho9rRsXgmGDFHaiX+Sh4=;
	b=SY0gc6qaYE8SCg8L9lxjiWAYT16nH3y2oX2t4eL8kIP7XeOIFQI4KxRnRyNgMcpHn+Qc
	 5S2PXh3sIZDern1BYoRWM5l8XyEEZVImit57W1Y8aWo+witur0QKP8bp25+R0jf1meado
	 L4UHL3mFeQJop4iUhu29etaYknBm7QEp6h0XRDoIle6A1Jv+93wjtVeuNJMymRUUTV6D9
	 +6y56r1dHY81Irr1BMhLjXUgzMnLN2JU6Cg1uuzocq2YXfB6np8A33lfqj2PVB/PJHPQ6
	 W5Lovj3oJhrHQsmIKSEeB5rTxuD7pZ8ANU4Yd3Blq8Cp+Gz8DKjB/44BVtbi4jpnZHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0ESB5Ee;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93CE606A31F;
	Fri, 27 Nov 2026 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0ESB5Ee
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20751F0089A;
	Fri, 27 Nov 2026 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804604;
	bh=q/DHnuShonHGs9vWHUGnG2mho9rRsXgmGDFHaiX+Sh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j0ESB5EeNqlAOU2eBXcocvNl6deO85SOix6KahEA+hAbrDTJ8bBXuuhrfAAroePWW
	 hrWU4csBnvN7I3fKhcS32MAmhZhlyoMQ8/Tmg484Wm4OEWLNGgedXreMdlyWs6TjlW
	 vypncicDPvhq9ijEmDQaQmpBEn1BLTiwkUV9yCCO8Cws3frt2PGP1OG0+5GWhlAMd9
	 BKxMfw4OWNqzMSxtWX2ZxRsIdF3arhNoPnR6N7fCWnbTKy+QC5dzS/82L3PmzSV7/u
	 r+xbMhOPyiPkHoTfs9SAo7MTG4/JZNwMVaDTB8MhVowlRlE/oSftWIxiapYNtPHUJn
	 x6Oow8NCspkaw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gyungoh Yoo <jack.yoo@maxim-ic.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	Eduardo Candelaria <jedu@slimlogic.co.uk>,
	Stephen Warren <swarren@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/8] regulator: max8907: Duplicate of_regulator_match table per device
Date: Fri, 27 Nov 2026 18:35:42 +0000
Message-ID: <20261127183624.3341010-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127183624.3341010-1-lee@kernel.org>
References: <20261127183624.3341010-1-lee@kernel.org>
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

max8907_regulator_parse_dt() passes the static global max8907_matches
array directly to of_regulator_match(), which populates init_data and
of_node in place and registers a devres callback holding a pointer to
that array.  With multiple MAX8907 instances, a second probe overwrites
the first instance's entries and subsequent unbinds invoke of_node_put()
twice on the same device nodes, causing reference count underflow and
use-after-free.

Mark max8907_matches const and duplicate it per device with
devm_kmemdup() before calling of_regulator_match().

Fixes: ffee19091a4e ("regulator: add MAX8907 driver")
Closes: https://sashiko.dev/#/bug/linux-295d0600-9849-4e47-802c-7e7a883167aa
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/max8907-regulator.c | 57 +++++++++++----------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index fd227fd13612..7781901ed115 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -186,7 +186,7 @@ static const struct regulator_desc max8907_regulators[] = {
 		.driver_data = (void *)&max8907_regulators[MAX8907_##_id], \
 	}
 
-static struct of_regulator_match max8907_matches[] = {
+static const struct of_regulator_match max8907_matches[] = {
 	MATCH(mbatt, MBATT),
 	MATCH(sd1, SD1),
 	MATCH(sd2, SD2),
@@ -218,54 +218,44 @@ static struct of_regulator_match max8907_matches[] = {
 	MATCH(vrtc, VRTC),
 };
 
-static int max8907_regulator_parse_dt(struct platform_device *pdev)
+static struct of_regulator_match *
+max8907_regulator_parse_dt(struct platform_device *pdev)
 {
+	struct of_regulator_match *matches;
 	struct device_node *np, *regulators;
 	int ret;
 
 	np = pdev->dev.parent->of_node;
 	if (!np)
-		return 0;
+		return NULL;
 
 	regulators = of_get_child_by_name(np, "regulators");
 	if (!regulators) {
 		dev_err(&pdev->dev, "regulators node not found\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
-	ret = of_regulator_match(&pdev->dev, regulators, max8907_matches,
+	matches = devm_kmemdup(&pdev->dev, max8907_matches,
+			       sizeof(max8907_matches), GFP_KERNEL);
+	if (!matches) {
+		of_node_put(regulators);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = of_regulator_match(&pdev->dev, regulators, matches,
 				 ARRAY_SIZE(max8907_matches));
 	of_node_put(regulators);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Error parsing regulator init data: %d\n",
 			ret);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
-	return 0;
-}
-
-static inline struct regulator_init_data *match_init_data(int index)
-{
-	return max8907_matches[index].init_data;
-}
-
-static inline struct device_node *match_of_node(int index)
-{
-	return max8907_matches[index].of_node;
+	return matches;
 }
 #else
-static int max8907_regulator_parse_dt(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static inline struct regulator_init_data *match_init_data(int index)
-{
-	return NULL;
-}
-
-static inline struct device_node *match_of_node(int index)
+static struct of_regulator_match *
+max8907_regulator_parse_dt(struct platform_device *pdev)
 {
 	return NULL;
 }
@@ -280,12 +270,13 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 	unsigned int val;
 	int i;
 	struct regulator_config config = {};
+	struct of_regulator_match *matches;
 	struct regulator_init_data *idata;
 	const char *mbatt_rail_name = NULL;
 
-	ret = max8907_regulator_parse_dt(pdev);
-	if (ret)
-		return ret;
+	matches = max8907_regulator_parse_dt(pdev);
+	if (IS_ERR(matches))
+		return PTR_ERR(matches);
 
 	pmic = devm_kzalloc_obj(&pdev->dev, *pmic);
 	if (!pmic)
@@ -315,11 +306,11 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 		if (pdata)
 			idata = pdata->init_data[i];
 		else
-			idata = match_init_data(i);
+			idata = matches ? matches[i].init_data : NULL;
 		config.init_data = idata;
 		config.driver_data = pmic;
 		config.regmap = max8907->regmap_gen;
-		config.of_node = match_of_node(i);
+		config.of_node = matches ? matches[i].of_node : NULL;
 
 		switch (pmic->desc[i].id) {
 		case MAX8907_MBATT:
-- 
2.56.1.839.g22a8290db9-goog

