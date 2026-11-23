Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461457;
	b=ixM44ZFJ33sRDekIknq6KuCv1mfjWILdHPxdfABf4d/oWzr/kWa2/AvF7xYKWH5htu2F
	 HPRm2gJrC0ipKCUyyN6l41E9JtSjioBtNcSV3rQ1qvO/2d9lxtf7rjsLAQoeopK1EjRKS
	 Hcyd2EKaQb+vqfMaW9ies6SY7sUXNJww5rhTfRANXqwLi6BUk+jG/cuE+0zj0G/kxBf2n
	 7FwZiLB6hqEbZGftfFR/MzTH5QMTNPp9wgl+HUXcVhJjfY56TIV9H13/xtbBghmi+htXY
	 dK+ISoCfLJCknHKAgGWA2ruR6XMAyQk4LhNwqBwCvggjX8uG1sPjchNVzvhNZ8bl6Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6vGaJElMWM2rStgk6mNbr07Zv4kcStJ5HrbIJWU0CZ0=;
	b=2di7xhQB6aejOJe/nqR5mTTCpBDgjl2xmmIaDyGyaO4hYKcq9vPxXa+NcMWCwwj1Brgr
	 jBu5Nxg5eKJrIKLnYfgPv1H7oy4igTDqrdBBwyCgv0CfsDUJzHPk2DXP4poCUtmqeysFi
	 9X4lujSMJJMmPcYxt+I3tog7xP1N39B+DxnaznaYdrwevXZsOiDXLSgl6XQnbBIIwpQwi
	 xwB4RbsQS7NFQU2wjNdQ7vBcQV81OugatZ4d2VSrqHEVXecv/1MAbSxwLdwL8inXO7/a3
	 bqJw40VI2WAexMdy5SMelqkhcHw56CIG/XJJ51J7TN0KBp7HZCPFBb6SDb/nRIDaUHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CEzdOoQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689EA606A31A;
	Mon, 23 Nov 2026 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEzdOoQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E03A1F000CF;
	Mon, 23 Nov 2026 19:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461456;
	bh=6vGaJElMWM2rStgk6mNbr07Zv4kcStJ5HrbIJWU0CZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CEzdOoQ/qfpZkIFa4BHAY2ix+cTc3HKopnS2Us4ELy1dxLBOufi7u7GOlHjIbfNxc
	 +FK0azajpQizVo6b5X5lqGp/o3jIn0YVnPpvKOAfUaqy7yl20Z8rjIJSMA+H4rTRpg
	 DfbZqgxOnoN4X9QGclvs2sx0drLY9pFhs+tMYbwe95JhDHBrhIVmxA03flWf9UgpS5
	 mvjqPUf69RbUKldzyTQj0v2LJbSXFcDbKGQdimIab6qg11a03Cmvl2AnyfOimZ8GlX
	 loRyZggOLLqLy522OYGOw+sews8qJBLwxCAWhMpNraPeGkyqOYsN0IMOvnowBWnNFa
	 ZDvGmR/3T8r5A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Cavium Inc <support@cavium.com>,
	Jan Glauber <jan.glauber@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/13] mmc: cavium: Prevent slot_pdev[] out-of-bounds write during probe
Date: Mon, 23 Nov 2026 19:15:46 +0000
Message-ID: <20261123191703.179283-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

octeon_mmc_probe() and thunder_mmc_probe() iterate over Device Tree
child nodes and store each created slot platform device in
host->slot_pdev[i], which is sized to CAVIUM_MAX_MMC (4).  Neither
function checks that i remains below CAVIUM_MAX_MMC before writing to
host->slot_pdev[i], and both increment i even for disabled or
non-mmc-slot child nodes.  When a controller node has more than four
child nodes (or four valid mmc-slot nodes alongside another child node
on ThunderX), host->slot_pdev[i] writes past the end of the array and
corrupts the adjacent set_shared_power and acquire_bus callback
pointers in struct cvm_mmc_host.

Iterate only over available child nodes, advance the slot_pdev[] index
only when a slot platform device is created, and fail the probe with
-EINVAL if more than CAVIUM_MAX_MMC slots are present.

Fixes: 8fb83b142823 ("mmc: cavium: Fix probing race with regulator")
Fixes: 166bac38c3c5 ("mmc: cavium: Add MMC PCI driver for ThunderX SOCs")
Closes: https://sashiko.dev/#/bug/linux-022f7ab4-a7fe-4881-b87d-613d4b8f010f
Closes: https://sashiko.dev/#/bug/linux-04e9d7cc-573a-4ea4-ab4e-d65b9b0626ac
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/cavium-octeon.c   | 13 +++++++++----
 drivers/mmc/host/cavium-thunderx.c | 11 +++++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 7b75b3dfd3e6..375d8f23b26e 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -262,13 +262,18 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	i = 0;
-	for_each_child_of_node_scoped(node, cn) {
+	for_each_available_child_of_node_scoped(node, cn) {
+		if (i >= CAVIUM_MAX_MMC) {
+			dev_err(&pdev->dev, "Too many slots\n");
+			ret = -EINVAL;
+			octeon_mmc_set_shared_power(host, 0);
+			goto error;
+		}
 		host->slot_pdev[i] =
 			of_platform_device_create(cn, NULL, &pdev->dev);
-		if (!host->slot_pdev[i]) {
-			i++;
+		if (!host->slot_pdev[i])
 			continue;
-		}
+
 		ret = cvm_mmc_of_slot_probe(&host->slot_pdev[i]->dev, host);
 		if (ret) {
 			dev_err(&pdev->dev, "Error populating slots\n");
diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index b8296b2de127..a5346fb96f9b 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -129,7 +129,7 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	if (ret)
 		goto error;
 
-	for_each_child_of_node(node, child_node) {
+	for_each_available_child_of_node(node, child_node) {
 		/*
 		 * mmc_of_parse and devm* require one device per slot.
 		 * Create a dummy device per slot and set the node pointer to
@@ -137,6 +137,13 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 		 * of_platform_device_create.
 		 */
 		if (of_device_is_compatible(child_node, "mmc-slot")) {
+			if (i >= CAVIUM_MAX_MMC) {
+				dev_err(dev, "Too many slots\n");
+				of_node_put(child_node);
+				ret = -EINVAL;
+				goto error;
+			}
+
 			host->slot_pdev[i] = of_platform_device_create(child_node, NULL,
 								       &pdev->dev);
 			if (!host->slot_pdev[i])
@@ -147,8 +154,8 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 				of_node_put(child_node);
 				goto error;
 			}
+			i++;
 		}
-		i++;
 	}
 	dev_info(dev, "probed\n");
 	return 0;
-- 
2.56.1.750.gf70dc682cf-goog

