Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A693FFFA7
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525893; cv=none; b=W7f4ptISFLhPygK3jq3sokLREjVeVKGr6VX7UXGzQoVc8XiP4VW1EGnVIwdlfmyFUPWBvHPOByTRo3Q2zw/M04aAGxlC3/55FXv7qqlN0rWaxQoMwUtMkknNeDnkZ1BlDmV7/KWh6pQ4+dw+fGzDgPmVJyc1guvWCs0JwRKAKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525893; c=relaxed/simple;
	bh=B6LF8XDCWToQ9g3x21Nyz4IhzEzH084686Oe4CqehWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahW3mdc/8RLr6JixjE7h7f68kH/+3MDXlexT1WG/8IwEZ8T6WIQe2wixeNkiJqSZcWGkhDppEtYIzIL6NrtgwsPaUCf8TVXorRV2eazXBO+S3nHkhSU2K3HCNIxgF6lh6xhthi+dNiSMj8DLwuUlY1Hbi8xdaQ3mgfqzt/uwOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nltc+AN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nltc+AN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85A51F00A3A;
	Wed, 12 Aug 2026 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525889;
	bh=YR4cW3Wx10icDMplgLko1grvf/i8dWRirlO40znW8VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nltc+AN98YIbB5SI98DhvSqv3QTUTSn7seJXVn86vQMZCZcKDX3Xze7UzA98zaUOb
	 Wfk3o/ZOhv8klDxa96t2JB81SygldGwhtJOa/CMiU3Sy+yjARz7L/JRlukRH+vapm2
	 JD+M/F6MxT90mIB42CvEqCVXwjwzHi9OwfjwV9b+qBxs7xFwF6KM5jHxVq2Y4YQDtB
	 YGJlGIBOBd/9HqfEd1tbhWMRH+3etk9WbQBlEZcovTq7NhMg5ErFuiUMtQzNtPx0T6
	 F8XsNJ/hVrz7t0iiCyrU54C0In5Iql0V5W+zXEe+gZ8Y4K/EUvzHFGoruYIRxgzUkx
	 qPv0R8Iv6rDWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] vxlan: Do not alloc tstats manually
Date: Wed, 12 Aug 2026 05:11:23 -0400
Message-ID: <20260812091127.1349673-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080500-gloomily-getup-2a3e@gregkh>
References: <2026080500-gloomily-getup-2a3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit e28c5efc31397af17bc5a7d55b963f59bcde0166 ]

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of in this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the vxlan driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Link: https://lore.kernel.org/r/20240311112437.3813987-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: b9553558b48d ("vxlan: use pskb_network_may_pull() for transmit path header pulls")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0e9aeb03fcc73..752015accf586 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2990,15 +2990,9 @@ static int vxlan_init(struct net_device *dev)
 			return err;
 	}
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats) {
-		err = -ENOMEM;
-		goto err_vnigroup_uninit;
-	}
-
 	err = gro_cells_init(&vxlan->gro_cells, dev);
 	if (err)
-		goto err_free_percpu;
+		goto err_vnigroup_uninit;
 
 	err = vxlan_mdb_init(vxlan);
 	if (err)
@@ -3009,8 +3003,6 @@ static int vxlan_init(struct net_device *dev)
 
 err_gro_cells_destroy:
 	gro_cells_destroy(&vxlan->gro_cells);
-err_free_percpu:
-	free_percpu(dev->tstats);
 err_vnigroup_uninit:
 	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
 		vxlan_vnigroup_uninit(vxlan);
@@ -3041,8 +3033,6 @@ static void vxlan_uninit(struct net_device *dev)
 	gro_cells_destroy(&vxlan->gro_cells);
 
 	vxlan_fdb_delete_default(vxlan, vxlan->cfg.vni);
-
-	free_percpu(dev->tstats);
 }
 
 /* Start ageing timer and join group when device is brought up */
@@ -3269,6 +3259,7 @@ static void vxlan_setup(struct net_device *dev)
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	INIT_LIST_HEAD(&vxlan->next);
 
 	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
-- 
2.53.0

