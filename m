Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1B3161BF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604762; cv=none; b=oRyaqZhUpic8jIcdlLKJIQIdWtPnsVQDlJwJYMF+OOdwUM9n4DMdPhazeWx5xZX5zNxzvrSUeZhNldeQMLNBEwxa9c0lmvsLWL2+n5nYhKXr+VnbnYW/RlB943ywyIs0dC/YZI3f/BW9r5RQ32etY+bqZ7BjN9sXZdlTnGwQ/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604762; c=relaxed/simple;
	bh=UFgFqjKHfk16EllBVy6s1gMoFk/3bp2sGwh5clu0cJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qB1O28UHQxQrj+HfzLXA4WaCelun0wMi4d+QoIhQCo9MuT2zQ/aU1OzhlrU2zgiOhJYYA2DMwCkOvaqf1ShJdP7ly2AaWtVw0rwolIHW5thrFSPW8JginP3mL+QaAHtGTGrC6oopYuHxzcHn5dstFSHi7QTAMYvb5FQ3tF9Cf+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKriAStf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKriAStf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301F81F00899;
	Thu, 17 Sep 2026 00:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604760;
	bh=bPvp2biPhdHV05H5GZIFhbr9nwJizfY8EqSms4DhZ1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cKriAStfDKhhTV3micmB4ieUl4vZexG6DJmGKTT+QuCELCTl1zX7n8z4LOHcri03W
	 E07j7VmzfKiBgNwUB1YvYISb6CMdfKM6KVJ7J6hRKYB0y1MXUk7jMnso+o+Jwleibx
	 7IhQaux4e5PvxsBUNm7Pc8cjre+P0if9nnnlAO9oTBngfizhfazbkj/TnFRhkdARxd
	 owA9Hpb2q8XLDpi6k8EzmJ4zJtHgTPurJofIlZf2pq92Wx1SMBpgL3pKkwQgCtyn9b
	 k+mmJRCgZ5PZdy8tUxTj2Qk4sr29uB3HEqZRCeYn+m2TuiFypTvSM4SN3oj73rmT2Z
	 cR8HUKrfk1xhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] net: macb: unify device pointer naming convention
Date: Wed, 16 Sep 2026 20:25:56 -0400
Message-ID: <20260917002557.3379520-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917002557.3379520-1-sashal@kernel.org>
References: <2026091645-winnings-facsimile-bba7@gregkh>
 <20260917002557.3379520-1-sashal@kernel.org>
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
index 874d9577fc290..ec96b17b301ae 100644
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

