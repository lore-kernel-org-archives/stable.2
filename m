Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903454280A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079574; cv=none; b=pZpvjs7Ixhr0+FYdoaBuAPLVbTx+S0G7ZKehzWQ4JZZ9RG72zxdhivllfmGKbQOXZv9DFcG+Bs60gQPU4zNTVW9gz+RKdPwzoFdgvbHI3jZWcmQTsR6tCF57DK/cai7jr3JJupkFGwkK2I3HtHL3YAxR19CJIZlB2rKHVsWhSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079574; c=relaxed/simple;
	bh=3C3mg8dnCNinxBTrOP0hXW1eHiUTDPsblxnMfZjjoSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3Xj4KycyxZ6LjQPo4IkKJhfe+rqnhVgb9ccLWDtHosPc8zhCg7u7Qntj/ahoRcLk2DNkQNfs643SbLSlct9S8GZcZ8TaRwHCTjWMaxiiz8znSzPFzrpajSXrSnz6tXogHfl56rt2pmK7h/wqWapsl+4Y62VmnGQ64rcAm8KcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZXj88we; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZXj88we"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587871F000FF;
	Tue, 22 Sep 2026 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079572;
	bh=8WPIl3tU96gRhKgFcpCnsm7c3cPSo8LI/9QgvSHC6RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AZXj88weRG/MZsmsFwa7jkeStHgHNJD9aGfrKQRzTvNd7mdSaz7T5cvPcK5XjRe92
	 kZTz0ix7IGuGstm7Ylc9nNHUz1c+mDvGqTDW7JdXKkonRMCC+texAN0aGyH3dpmChk
	 AGMPm6RrBlhN9j4xd4QAYdEOfolgESyAjN5m3cUjdY7nfkvvMD0Ckb2/XIZqL+Y2up
	 nRoLYNJEaLVwNM5JEmMCyVnqF2BLM/VvphqeUFfCFTBrhu9XALh4LzTcqpy+QmYOKl
	 ELEXQY+X/BrxOJksYGKl5nLCGGsjrlbl1S/IS/SGqrLGmbMVeIXDZYqdsrBs9t3lBb
	 g6vyCqVXEk1DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()
Date: Tue, 22 Sep 2026 08:19:29 -0400
Message-ID: <20260922121930.2214519-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092255-unstamped-imprison-dfc7@gregkh>
References: <2026092255-unstamped-imprison-dfc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Zekun <zhangzekun11@huawei.com>

[ Upstream commit aa3ca1faf3222af7aaa194a910995820135fc54e ]

for_each_child_of_node_scoped() can put the device_node automatically.
So let's use it to make the code simpler by avoiding the need to
explicitly call of_node_put().

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Link: https://lore.kernel.org/r/20240810023426.110624-1-zhangzekun11@huawei.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Stable-dep-of: 0d1cb83337f1 ("ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libahci_platform.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 1153b9f7ff12a..91d44302eac92 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -419,7 +419,6 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
 				      struct device *dev)
 {
-	struct device_node *child;
 	u32 port;
 
 	if (!of_property_read_u32(dev->of_node, "hba-cap", &hpriv->saved_cap))
@@ -428,14 +427,12 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
 	of_property_read_u32(dev->of_node,
 			     "ports-implemented", &hpriv->saved_port_map);
 
-	for_each_child_of_node(dev->of_node, child) {
+	for_each_child_of_node_scoped(dev->of_node, child) {
 		if (!of_device_is_available(child))
 			continue;
 
-		if (of_property_read_u32(child, "reg", &port)) {
-			of_node_put(child);
+		if (of_property_read_u32(child, "reg", &port))
 			return -EINVAL;
-		}
 
 		if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
 			hpriv->saved_port_cap[port] &= PORT_CMD_CAP;
@@ -483,7 +480,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	int child_nodes, rc = -ENOMEM, enabled_ports = 0;
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	struct device_node *child;
 	u32 mask_port_map = 0;
 	u32 max_port;
 
@@ -605,7 +601,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	}
 
 	if (child_nodes) {
-		for_each_child_of_node(dev->of_node, child) {
+		for_each_child_of_node_scoped(dev->of_node, child) {
 			u32 port;
 			struct platform_device *port_dev __maybe_unused;
 
@@ -614,7 +610,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 			if (of_property_read_u32(child, "reg", &port)) {
 				rc = -EINVAL;
-				of_node_put(child);
 				goto err_out;
 			}
 
@@ -632,18 +627,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			if (port_dev) {
 				rc = ahci_platform_get_regulator(hpriv, port,
 								&port_dev->dev);
-				if (rc == -EPROBE_DEFER) {
-					of_node_put(child);
+				if (rc == -EPROBE_DEFER)
 					goto err_out;
-				}
 			}
 #endif
 
 			rc = ahci_platform_get_phy(hpriv, port, dev, child);
-			if (rc) {
-				of_node_put(child);
+			if (rc)
 				goto err_out;
-			}
 
 			enabled_ports++;
 		}
-- 
2.53.0

