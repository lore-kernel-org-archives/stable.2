Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8F4252A8
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625870; cv=none; b=Nu1rrUBEkkPcqu6EoVSpX05VYIM41NjcTLtNuC2iGEDpGDjFSeGykMbAeaVBfPYFMaF+iA/HxjQifwuudbRlPXWttsyG20cnY088P/KHJgeg6Hc7LjcYMyul2YgDXEF7CPRA3evfU8GDg4DMPUC2jptpDQbnVoGLKecvPnW41W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625870; c=relaxed/simple;
	bh=Hizi7unoYKirLNuFJ1v0rjJVuLqFfK1sgmvooosRoB8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nMb2JUWrselfgGCJzS2q2KcEkc+TFKQ72wiXdTwNzjmCOCns2pswpCM/eSNwq7SGb9Am3P+UfcZwD7ug/dytYqquoPIM8FmsUfCGdm3Ho+OOq9qkRMRq7p9cxWOrKGc0OdIaA/k9SAyi2Wa7FJlwoJI4zukvMdc7gntCpDEp7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0DrEfU2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0DrEfU2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC4E1F000E9;
	Tue, 21 Jul 2026 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625868;
	bh=Jqfwah5KnuRWhhmdHCVPCgmuThlfbx3cVcQym0yo2es=;
	h=Subject:To:Cc:From:Date;
	b=0DrEfU2QvKlIWkA0BAqzmP48qrII/VLdGz7vgDUXZYK5Q+WxbUx9N2DjhUacFI2hR
	 JM+G5gE4mGbWS+XU1mjH7A3UBv9mDr9mI3rCCli6WxcKVvdIm6l8NCBJK8Y321oZN1
	 Fxz6ptsBePAblLHKbhLlVtQKa8zVdqADYYoIJ4T0=
Subject: FAILED: patch "[PATCH] pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for" failed to apply to 6.1-stable tree
To: guoniu.zhou@oss.nxp.com,Frank.Li@nxp.com,peng.fan@nxp.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:22:59 +0200
Message-ID: <2026072159-perch-phrase-e8f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 99611233f8cda833169fa6487d5dacdf189e5cb0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072159-perch-phrase-e8f9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99611233f8cda833169fa6487d5dacdf189e5cb0 Mon Sep 17 00:00:00 2001
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Tue, 9 Jun 2026 14:26:41 +0800
Subject: [PATCH] pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for
 DSI/CSI

The MIPI DSI and CSI domains share control bits for clock and reset, which
can lead to incorrect behavior if one domain disables the shared resource
while the other is still active.

To fix the issue, introduce a shared MIPI PHY power domain to own the
common resources and make DSI and CSI its subdomains. This ensures the
shared bits are properly managed and not disabled while still in use.

Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 1afc78b034fa..243ce939ba68 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -48,6 +48,8 @@
 
 #define PRIO(X)			(X)
 
+#define BLK_CTRL_NO_PARENT	UINT_MAX
+
 struct imx93_blk_ctrl_domain;
 
 struct imx93_blk_ctrl {
@@ -68,12 +70,18 @@ struct imx93_blk_ctrl_qos {
 	u32 cfg_prio;
 };
 
+struct imx93_blk_ctrl_subdomain_link {
+	struct generic_pm_domain *parent;
+	struct generic_pm_domain *subdomain;
+};
+
 struct imx93_blk_ctrl_domain_data {
 	const char *name;
 	const char * const *clk_names;
 	int num_clks;
 	u32 rst_mask;
 	u32 clk_mask;
+	u32 parent;
 	int num_qos;
 	struct imx93_blk_ctrl_qos qos[DOMAIN_MAX_QOS];
 };
@@ -203,6 +211,13 @@ static void imx93_release_pm_genpd(void *data)
 	pm_genpd_remove(genpd);
 }
 
+static void imx93_release_subdomain(void *data)
+{
+	struct imx93_blk_ctrl_subdomain_link *link = data;
+
+	pm_genpd_remove_subdomain(link->parent, link->subdomain);
+}
+
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
 static int imx93_blk_ctrl_probe(struct platform_device *pdev)
@@ -302,6 +317,34 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		bc->onecell_data.domains[i] = &domain->genpd;
 	}
 
+	for (i = 0; i < bc_data->num_domains; i++) {
+		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
+		const struct imx93_blk_ctrl_domain_data *data = domain->data;
+		struct imx93_blk_ctrl_subdomain_link *link;
+
+		if (bc_data->skip_mask & BIT(i) ||
+		    data->parent == BLK_CTRL_NO_PARENT)
+			continue;
+
+		link = devm_kzalloc(dev, sizeof(*link), GFP_KERNEL);
+		if (!link)
+			return -ENOMEM;
+
+		link->parent = &bc->domains[data->parent].genpd;
+		link->subdomain = &domain->genpd;
+
+		ret = pm_genpd_add_subdomain(&bc->domains[data->parent].genpd,
+					     &domain->genpd);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to add subdomain %s\n",
+					     domain->genpd.name);
+
+		ret = devm_add_action_or_reset(dev, imx93_release_subdomain, link);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to add subdomain release callback\n");
+	}
+
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable pm-runtime\n");
@@ -326,8 +369,9 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.name = "mediablk-mipi-dsi",
 		.clk_names = (const char *[]){ "dsi" },
 		.num_clks = 1,
-		.rst_mask = BIT(11) | BIT(12),
-		.clk_mask = BIT(11) | BIT(12),
+		.rst_mask = BIT(11),
+		.clk_mask = BIT(11),
+		.parent = IMX93_MEDIABLK_PD_MIPI_PHY,
 	},
 	[IMX93_MEDIABLK_PD_MIPI_CSI] = {
 		.name = "mediablk-mipi-csi",
@@ -335,6 +379,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.num_clks = 2,
 		.rst_mask = BIT(9) | BIT(10),
 		.clk_mask = BIT(9) | BIT(10),
+		.parent = IMX93_MEDIABLK_PD_MIPI_PHY,
 	},
 	[IMX93_MEDIABLK_PD_PXP] = {
 		.name = "mediablk-pxp",
@@ -342,6 +387,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.num_clks = 1,
 		.rst_mask = BIT(7) | BIT(8),
 		.clk_mask = BIT(7) | BIT(8),
+		.parent = BLK_CTRL_NO_PARENT,
 		.num_qos = 2,
 		.qos = {
 			{
@@ -363,6 +409,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.num_clks = 2,
 		.rst_mask = BIT(4) | BIT(5) | BIT(6),
 		.clk_mask = BIT(4) | BIT(5) | BIT(6),
+		.parent = BLK_CTRL_NO_PARENT,
 		.num_qos = 1,
 		.qos = {
 			{
@@ -379,6 +426,7 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 		.num_clks = 1,
 		.rst_mask = BIT(2) | BIT(3),
 		.clk_mask = BIT(2) | BIT(3),
+		.parent = BLK_CTRL_NO_PARENT,
 		.num_qos = 4,
 		.qos = {
 			{
@@ -404,6 +452,14 @@ static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[]
 			}
 		}
 	},
+	[IMX93_MEDIABLK_PD_MIPI_PHY] = {
+		.name = "mediablk-mipi-phy",
+		.clk_names = NULL,
+		.num_clks = 0,
+		.rst_mask = BIT(12),
+		.clk_mask = BIT(12),
+		.parent = BLK_CTRL_NO_PARENT,
+	},
 };
 
 static const struct regmap_range imx93_media_blk_ctl_yes_ranges[] = {

