Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C763550DDD
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083124; cv=none; b=YE9GtnvYuzbOMe5oIHhjaIWDyJvE+niXTnV7BAP2iQBt7kfPMgJLWUSW2gWbJ6DUw33IUr5eVXpXeaI1pVoL++qYzj/hKvcxSz72IQu7UAOhk8o++SsVQ8WTXdjtlCUaoZM3633LGOWRGzYWzuQ5FfdFZzJTsxW7p1wTEGIGApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083124; c=relaxed/simple;
	bh=AJuB92cFEjnxHELO3gMxptAxmolfoHROCc25mxXSBio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPXNgCRm+XEz2Ujbixm79la6TRQFQUE9RgCKDOYL+0Jfme214OYwtTIk8q7yvTfMH8y56GV700HG46IzS8W5ZnjwmKKP5Agy07wy8hTGM9ekbMBre3K61/t8BL1SzJx4ktUso91VQWJ0/LABFNzrOwMhwqIF82IcxLDRmUr8eAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEg+LOnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEg+LOnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850611F00893;
	Tue, 22 Sep 2026 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083123;
	bh=G2jYXHTwWB9kTF+TARWTfSFB1x4BJ/kQFam46BWiMGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dEg+LOnUPlWU3sEchXLbHsWUKtlPS4QHwbgvd7PvS3nmu/QhONFkNo+MPXuzX7yQ9
	 /uVit9aI7VcIKxOuHiAdPKIK7bogw3T2vsog9U5HLSllOmYiaIyjUKU7EWX6C7g9jj
	 wAMQd43ZrNzkTmQDm8niBPVs0oO6E7MwddabJVIiGMqJqS9tHv7NFMMawS1C6NrOew
	 hUyBhvGYJzTqx914Kfz2/6xX1SgF1tuKbtqpBo7VrdTUN58/zNx5tv+z56VGbltgp5
	 xNe1S4ElVZabAc100qB0AjMmH3onE0f3u4gx7QEdE4VubfALUUgg6d1bT2H0WMMle2
	 VdaykeVgfCWtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()
Date: Tue, 22 Sep 2026 09:18:39 -0400
Message-ID: <20260922131840.2444454-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922131840.2444454-1-sashal@kernel.org>
References: <2026092256-flyer-contusion-4709@gregkh>
 <20260922131840.2444454-1-sashal@kernel.org>
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

[5.15 dependency adaptation: Drop the ahci_platform_get_firmware() hunks,
as this stable tree has no such function. Keep automatic child-node
cleanup in ahci_platform_get_resources(), but declare the initialized
__free(device_node) variable at the start of the child_nodes block and
use for_each_child_of_node(). The scoped upstream iterator declares its
variable in the for initializer, which is not supported by this tree's
-std=gnu89 build. The existing cleanup helper releases the child on each
error exit; normal iteration releases each node and ends with NULL.
This retains the simplified regulator error path needed to apply
0d1cb83337f13af082afb68b28d3fdfe29cde7fb without adding functions.]

Stable-dep-of: 0d1cb83337f1 ("ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libahci_platform.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 43380d1a410e2..9b8e30fd6e865 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -407,7 +407,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	int child_nodes, rc = -ENOMEM, enabled_ports = 0;
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	struct device_node *child;
 	u32 mask_port_map = 0;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
@@ -520,6 +519,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	}
 
 	if (child_nodes) {
+		struct device_node *child __free(device_node) = NULL;
+
 		for_each_child_of_node(dev->of_node, child) {
 			u32 port;
 			struct platform_device *port_dev __maybe_unused;
@@ -529,7 +530,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 			if (of_property_read_u32(child, "reg", &port)) {
 				rc = -EINVAL;
-				of_node_put(child);
 				goto err_out;
 			}
 
@@ -547,18 +547,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
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

