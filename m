Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0494F7999
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602823; cv=none; b=QoV/9m7kVwPc743x9jV39ApT7cw+JcvEjRIwp95UoLsraC/VNMPseoIeyWn3ilr/BafRoWfg0/fGPTQ2u00ZFe0GMpMw3zjKfdpQNhidrOINItbNtuB1yUKkmHfK8otaWLgdxBBcrSIeBMWuRECY2PG1Ot7coqCkdoWfyBP+H6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602823; c=relaxed/simple;
	bh=u1YTfYJ65/QpqMtLdafo9vINj4yJUYJQIPDeIuAjzYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jePpUNw80D+HDBY/3RM3Ez0Gul4kDCE8h8jlv/q6kZlLJJweL0tGw5sjWs74m3PamxHJmjCZlmMBBn+q3qKOuF+c5o6qjdlh9VE1EiQFfrmrsZjPwhNXEareyVIFL8gFxKD8IJpNsfS1gyDwXh13tkVvyHANOWBo0/ZRlIv+f4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzwiBGdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzwiBGdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991D01F0089A;
	Wed, 16 Sep 2026 23:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602822;
	bh=SZ5cG6QyfI/ytplmkHd+Zea1Wo6H1gKaF+8Zrd7bjL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzwiBGdV8SEBibPZroIt7XxSnTja8iLGl73clgRyOsPbelLrTBlw9TKYbrkzvXEAD
	 Y9+aez8MXu255WZ8H7eL2cFiUP/ZD7lnPJZ/0mM39W3WpKzrN3BnD5RBU3vYkes8ys
	 7X+DOc01ZxkyjoKIPWEuPN3rU+LHnYcXLwBvzlb4VwdWeSeCUf0E7ww3u7jKsr6D83
	 uc+wBs6e64+/kP3sEtKuvQENv1JuIfXfOcj2yAvpPEkYg+mqNHhs1O211MGHeNca2w
	 L4xyNx71ls1E+pmYS5sEh7nfnFn5uIZSKh99cDf8V9ZYU60ClKSxjQOKrrWLYVkwkN
	 4Dlq9XTWQGAEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] net: macb: unify device pointer naming convention
Date: Wed, 16 Sep 2026 19:53:37 -0400
Message-ID: <20260916235338.3313589-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916235338.3313589-1-sashal@kernel.org>
References: <2026091642-wasting-vagueness-0a57@gregkh>
 <20260916235338.3313589-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 07362f68e61d82ee53da0e9ae2c7f981c3538861 ]

Here are all device pointer variable permutations inside MACB:

   struct device *dev;
   struct net_device *dev;
   struct net_device *ndev;
   struct net_device *netdev;
   struct pci_dev *pdev;              // inside macb_pci.c
   struct phy_device *phy;
   struct phy_device *phydev;
   struct platform_device *pdev;
   struct platform_device *plat_dev;  // inside macb_pci.c

Unify to this convention:

   struct device *dev;
   struct net_device *netdev;
   struct pci_dev *pci;
   struct phy_device *phydev;
   struct platform_device *pdev;

Ensure nothing slipped through using ctags tooling:

⟩ ctags -o - --kinds-c='{local}{member}{parameter}' \
    --fields='{typeref}' drivers/net/ethernet/cadence/* | \
  awk -F"\t" '
    $NF~/struct:.*(device|dev) / {print $NF, $1}' | \
  sort -u
typeref:struct:device * dev
typeref:struct:in_device * idev        // ignored
typeref:struct:net_device * netdev
typeref:struct:pci_dev * pci
typeref:struct:phy_device * phydev
typeref:struct:platform_device * pdev

Also fix some printk() calls to use __func__ instead of hardcoding.
This silences some checkpatch.pl warnings and doesn't deserve a
separate commit.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://patch.msgid.link/20260812-macb-context-v9-2-7ddbf5f715e0@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Backport note: retain only the dev-to-netdev rename in gem_ptp_init().
The target e1406330d70e ("net: macb: initialize PTP state before
registering clock") needs this spelling in its ptp_clock_register()
context; its macb_probe() hunk already applies to this stable tree.
Drop the unrelated driver-wide renames and logging cleanup. In
particular, do not import newer EEE, interrupt, DMA, queue, or probe
changes absent from this branch. This limited rename changes no
behavior and adds no functions.

[ sashal: Reduced backport -- upstream 07362f68e61d8 touches 4 file(s), this
  backport carries 1. Not backported here:
  drivers/net/ethernet/cadence/macb.h
  drivers/net/ethernet/cadence/macb_main.c
  drivers/net/ethernet/cadence/macb_pci.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e1406330d70e ("net: macb: initialize PTP state before registering clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index f2b09100f710e..085795e8aae72 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -322,9 +322,9 @@ void gem_ptp_txstamp(struct macb *bp, struct sk_buff *skb,
 	skb_tstamp_tx(skb, &shhwtstamps);
 }
 
-void gem_ptp_init(struct net_device *dev)
+void gem_ptp_init(struct net_device *netdev)
 {
-	struct macb *bp = netdev_priv(dev);
+	struct macb *bp = netdev_priv(netdev);
 
 	bp->ptp_clock_info = gem_ptp_caps_template;
 
@@ -332,7 +332,7 @@ void gem_ptp_init(struct net_device *dev)
 	bp->tsu_rate = bp->ptp_info->get_tsu_rate(bp);
 	bp->ptp_clock_info.max_adj = bp->ptp_info->get_ptp_max_adj();
 	gem_ptp_init_timer(bp);
-	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &dev->dev);
+	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &netdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		pr_err("ptp clock register failed: %ld\n",
 			PTR_ERR(bp->ptp_clock));
-- 
2.53.0

