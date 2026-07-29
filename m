Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC53C1D72
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348136; cv=none; b=DDc0STaCijA2UX+WWK4X+QA2fhuxYU7rBOuqjCtY/SbJIWG55RBWTQgq1PO1rXtUcljNaOY6LRi4Nr0wZ82xkbjlGfrNkiRlqZw5XToD0T/9l07Ns1nsZBOqLrwuCieOAr+ScZvcRivlz/ye4WCjL+RO5Uc5UeS4Lt1rAv0lAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348136; c=relaxed/simple;
	bh=dcEXgyaUp6LnFABMO5BYuVZ8UuDkk6TEzLpyYESTLeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4dD5HJP3TyN7BFR8xR5vAbIVm3Cm38Y59jUhL+LYnP2d+vxMZ95aKod3xodg2DlJ7KNFPQUAygDtk6gR+UNOCnhp5PPGWN0x+B9xIDKfrcHOrPLNBPKuQaVPVoPVBNsf7fNYwa9jFgaYZ4rpDwp1WQgc3NCxJhB7dTqV1R0q9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c34AMYaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c34AMYaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1937C1F00A3A;
	Wed, 29 Jul 2026 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785348130;
	bh=DdE/D4xI0fn7rN0a0WOo4+QQ1G3/Rvr0J2/7YNbT+yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c34AMYaT9MK0Zrjz4QmRtQpz8qkugW/WzkI4tyFblsiKGbBxOS7ZjBP7u0CwoY3kq
	 Z8SLkDZpHbRjMhDnm5kaMy54YtbsVGU/wCN91yVaXyNbGmPx8L5o8gJ5635PnMUXLd
	 6XxNLiyO5yxy9DhPUkJbo6edVJtjLeTC7oQ6ybYD47VGeysVs4a3gnRJdVGf8UIvrN
	 CCVVrOm0+FYBleYOCBW9zwGuPXHGH9ZEdOTxDQxgne6Pw9zm0qF/CKVAk+XjAQKt/u
	 jp5HDcsMdQgGSMnjn6Imf/XsJTQVmSeZMNICCFY9t+Rmh5VDJ57efhbT/AFY5TUi0C
	 ZSO+u3ja71oVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] pmdomain: imx93-blk-ctrl: convert to devm_* only
Date: Wed, 29 Jul 2026 14:02:07 -0400
Message-ID: <20260729180208.3683189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072158-traverse-ladylike-5e02@gregkh>
References: <2026072158-traverse-ladylike-5e02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 52becc142280eeef828d19f9cd01fd653b588786 ]

Convert the driver to devm_ APIs only by making use of
devm_add_action_or_reset() and devm_pm_runtime_enable() to simplify the
probe error path and to drop the .remove() callback. This also ensures
that the device release order equals the device probe error path order.

Furthermore drop the dev_set_drvdata() usage since the only user was the
.remove() callback which is removed by this commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 99611233f8cd ("pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for DSI/CSI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 66 ++++++++++++---------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index e094fe5a42bf64..325711323ba4f6 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -188,6 +188,20 @@ static int imx93_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static void imx93_release_genpd_provider(void *data)
+{
+	struct device_node *of_node = data;
+
+	of_genpd_del_provider(of_node);
+}
+
+static void imx93_release_pm_genpd(void *data)
+{
+	struct generic_pm_domain *genpd = data;
+
+	pm_genpd_remove(genpd);
+}
+
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
 static int imx93_blk_ctrl_probe(struct platform_device *pdev)
@@ -258,10 +272,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 			domain->clks[j].id = data->clk_names[j];
 
 		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
-		if (ret) {
-			dev_err_probe(dev, ret, "failed to get clock\n");
-			goto cleanup_pds;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get clock\n");
 
 		domain->genpd.name = data->name;
 		domain->genpd.power_on = imx93_blk_ctrl_power_on;
@@ -269,11 +281,12 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		domain->bc = bc;
 
 		ret = pm_genpd_init(&domain->genpd, NULL, true);
-		if (ret) {
-			dev_err_probe(dev, ret, "failed to init power domain\n");
-			goto cleanup_pds;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to init power domain\n");
 
+		ret = devm_add_action_or_reset(dev, imx93_release_pm_genpd, &domain->genpd);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to add pm_genpd release callback\n");
 		/*
 		 * We use runtime PM to trigger power on/off of the upstream GPC
 		 * domain, as a strict hierarchical parent/child power domain
@@ -290,39 +303,19 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		bc->onecell_data.domains[i] = &domain->genpd;
 	}
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable pm-runtime\n");
 
 	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to add power domain provider\n");
-		goto cleanup_pds;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add power domain provider\n");
 
-	dev_set_drvdata(dev, bc);
+	ret = devm_add_action_or_reset(dev, imx93_release_genpd_provider, dev->of_node);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add genpd_provider release callback\n");
 
 	return 0;
-
-cleanup_pds:
-	for (i--; i >= 0; i--)
-		pm_genpd_remove(&bc->domains[i].genpd);
-
-	return ret;
-}
-
-static void imx93_blk_ctrl_remove(struct platform_device *pdev)
-{
-	struct imx93_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
-	int i;
-
-	of_genpd_del_provider(pdev->dev.of_node);
-
-	pm_runtime_disable(&pdev->dev);
-
-	for (i = 0; i < bc->onecell_data.num_domains; i++) {
-		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
-
-		pm_genpd_remove(&domain->genpd);
-	}
 }
 
 static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[] = {
@@ -457,7 +450,6 @@ MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
 
 static struct platform_driver imx93_blk_ctrl_driver = {
 	.probe = imx93_blk_ctrl_probe,
-	.remove = imx93_blk_ctrl_remove,
 	.driver = {
 		.name = "imx93-blk-ctrl",
 		.of_match_table = imx93_blk_ctrl_of_match,
-- 
2.53.0

