Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD6541453
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080485; cv=none; b=od5nkGzm1YbIn2My3rx+kOEvV1gNwjyMuBe9sOchuA5GQ3DPjnDv9Y9JrlkC8RQia5MWguX5iAI2lLyXkpjQooi1Pj95oD5r22QoAWin/svNHebWhpjdbv6FtMXM6e7MTjJQ0PlhwDpKl2Qn8jbg/Io6EeiFLfM2G/o3PBLDdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080485; c=relaxed/simple;
	bh=dBg1rvPQz0WA683QxAOoMgPuXEN/iu167f/jrjEy3rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxJEPvClyhSsgleDv6YKc+fG0zM5ap5EFy9tbkX5c0J3D0Xl/ZLoQoRD5i0JVzEutwrcoYTiMChw1o4OQif+b8Ygikfb6jDlwOkULfAQ1ww/kB+EfkAlEci3al+eFmIduJRKbaxr+eDf3Vk7hUjnWjHm+A9E8CcS3rhvXLjuUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvJkheKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvJkheKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801011F00898;
	Tue, 22 Sep 2026 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080484;
	bh=rJclwSE6MP6QcUQr+trUt24c//8t/uJ7wyHNqbdwFzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EvJkheKeuUGujonInY+/MasknyNnVM5YVDvum7iDMz/Ylcl0S/vfec60jA0DyXwg+
	 aPkyI8w2NHjvTxAecn2EKi5WP/MWT8hV0h1AT8fIkUQgX5E0ahdbu73GLjE1Ytaf9o
	 FJ/jwm0RyOQa0Qugi1D7/Hd1fecfezX+BkjhF7RClgjhmJm3G6e94FsQoU6kM+iF9S
	 9N1r/JQH+RYYW9N20YXt5743FZ0KCJuenbtIq6hhP5aVSBhOuyeJv5OoaTe1/SnQ6b
	 E/hUyscm1uq2tWKPFn4WqkluCNPLj5h17MLko2nqwG86846CIz5cUIWZvzV2xq9VDC
	 bk5tfuI4xtEGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()
Date: Tue, 22 Sep 2026 08:34:41 -0400
Message-ID: <20260922123442.2257247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092255-disaster-skittle-8855@gregkh>
References: <2026092255-disaster-skittle-8855@gregkh>
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
index d4fccc0625800..50aaa82d4971a 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -418,7 +418,6 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
 				      struct device *dev)
 {
-	struct device_node *child;
 	u32 port;
 
 	if (!of_property_read_u32(dev->of_node, "hba-cap", &hpriv->saved_cap))
@@ -427,14 +426,12 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
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
@@ -482,7 +479,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	int child_nodes, rc = -ENOMEM, enabled_ports = 0;
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	struct device_node *child;
 	u32 mask_port_map = 0;
 	u32 max_port;
 
@@ -604,7 +600,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	}
 
 	if (child_nodes) {
-		for_each_child_of_node(dev->of_node, child) {
+		for_each_child_of_node_scoped(dev->of_node, child) {
 			u32 port;
 			struct platform_device *port_dev __maybe_unused;
 
@@ -613,7 +609,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 			if (of_property_read_u32(child, "reg", &port)) {
 				rc = -EINVAL;
-				of_node_put(child);
 				goto err_out;
 			}
 
@@ -631,18 +626,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
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

