Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410BA53C3DA
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084460; cv=none; b=j/9InwlmPM+fYZO2SkscB56RDbQjR3jxG8589y+fdYggech+ntOw17TWP70KaG8uQxDj4hNz4HEiApf3Lg3e46H65sCJbmRskpYo8VjwlB6tSnwRZiTryhsBMZfBgPYs10VALh9FkCG+w2IzgmPqaV6zz2/2LPDqQCqIKGGgdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084460; c=relaxed/simple;
	bh=6KR4kCbIgUGRrqCZ2hGfLyMyAJSDphIFYbJFGbKBhhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSIJQC3eMRDx0bo2SaBZcBMFFqNJ0VWPbFLK1AW5TIYzttyhI85wqunDwqJAq1KuKZUjZ295S8lBXG8z0enfdtzKQmuMz18R18Hju3CArXoZ/J+lEwp2He9tLp/TlXj1PZtCwyA0Rq9+AKl2TRbpVbzRv04OskHs3g2BFDQTa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV8VpH+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV8VpH+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D561F00893;
	Tue, 22 Sep 2026 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084459;
	bh=izi43BGN9ENjMXFfdx3pfWPNZmxML2CgOIQwrRsKH6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eV8VpH+m2naCT42hHd33viZcWTQueLOyP+tvpy/iIqshksWiJ+4Wt0+7fzv8XhzOc
	 1RIF8Sda0+5h2UkftJbNt/kQP6kDTq0vcfUNI2TG6feI0QhcmYrMzyltV+B/gA8wsa
	 exLqtEkpDItyjkhEyfbbnQdO5A+h0yxprqIyHgvORpxuXuZXeQyTrJVTmrS3g8Wbwc
	 8zySZiJjSS8AmoUXLbQKzJ4UjHwObSqsqfM9YglawdSMiNrJoEZ6DsNDcALT6l3wKb
	 xe8K87AmvzggZ574BACnU6mOfdvpTE7VfKj3eLRH7Bqj36jata4HMHs5kSl2OK68g/
	 1P3JJLrsZPYog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()
Date: Tue, 22 Sep 2026 09:40:55 -0400
Message-ID: <20260922134056.2503713-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922134056.2503713-1-sashal@kernel.org>
References: <2026092256-genetics-desecrate-9b80@gregkh>
 <20260922134056.2503713-1-sashal@kernel.org>
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

Backport notes for Linux 5.10:
Drop the changes to ahci_platform_get_firmware(), which does not exist in
this tree, and retain the existing clock and loop-index declarations.

The scoped iterator declares its variable in the for initializer, which
is incompatible with this tree's -std=gnu89 build. Instead, declare child
with __free(device_node) inside the child_nodes block and use the existing
for_each_child_of_node() iterator. This keeps automatic node release on
all exits from that block, before devres cleanup on error, without adding
functions or changing the kernel's C dialect.

Removing the explicit node puts and their now-unnecessary braces also
allows target commit 0d1cb83337f13af082afb68b28d3fdfe29cde7fb to apply
unchanged. The platform-device reference fix remains in that target.

Stable-dep-of: 0d1cb83337f1 ("ata: libahci_platform: Fix device reference leak in ahci_platform_get_resources()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libahci_platform.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 64d6da0a53035..d79e8d46d30e0 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -388,7 +388,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct clk *clk;
-	struct device_node *child;
 	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
 	u32 mask_port_map = 0;
 
@@ -487,6 +486,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	}
 
 	if (child_nodes) {
+		struct device_node *child __free(device_node) = NULL;
+
 		for_each_child_of_node(dev->of_node, child) {
 			u32 port;
 			struct platform_device *port_dev __maybe_unused;
@@ -496,7 +497,6 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 			if (of_property_read_u32(child, "reg", &port)) {
 				rc = -EINVAL;
-				of_node_put(child);
 				goto err_out;
 			}
 
@@ -514,18 +514,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
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

