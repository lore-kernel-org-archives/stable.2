Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9543DA5E
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908294; cv=none; b=JjO6XsVCAYMVdAk/k/rRA3GaPpCY3ihIJb0Q8BdiNtk3nvH/d5rJkDTu8HolLBJQpr7a05en5ytJXVHkeT8oLUMVeohabSIfx4DJ3KMGy754cfyQMDO543LhMrKQz1bqX7gps+4+PJwryaHxHgjE33VmjU8vGqQECw3DAAuXzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908294; c=relaxed/simple;
	bh=fl9NM6z7Kbi9xrCLl80WgNMmyzJKnYD+ReHdg5r/mfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yg1gL4arDcx6i44Sjh0JEwdBX8PWzz3CWy1tXSgmjsSGjoP1rI1F5lmsW5DI4eAB0Zl4jlDsP/k2TtneONe6jEHnKd5icWCJKDiqcEiE2py/83yn7TMtO8f2eYSWHdyjntLcH5hayibb7DHNowqyno3DZQU45oQPvZMNzNwZe6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFe/wvTu; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFe/wvTu"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1864979a91.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908276; x=1790513076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ouAjj7KGeSeJFCpDwXc8k+67Akobcfv7wh2wetP0tXE=;
        b=nFe/wvTu04vnUm2PxfZOV9UqtqfqiY1NvgO9u2sT0t79YToYu61zzDM/vG+fk9ceQO
         cR4p0z17dabbKhfhm/fAw75ZiUC4K19fXRUeWBkB03kdKVv4aFGhOT44gRULdAt5hj5U
         U0b2d6aeLPO2Wxu1imGY0VkA2t9WNCFNMZY9NL3tJPCC3uyYt7BYX3HONMr82UC6ojXD
         +XXYZVwGraYwjOUE5DRRlM5N1GU7X8bzUp9zEQOnmFyHzevqQAfsPJVlDJ1Ws/MVlNCN
         eypig7FVm830JkeB+xcqE0SU9m1OYB4Srjin67ius9pJUVZsOKnPq0YJVy/BkczWHlS+
         suZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908276; x=1790513076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ouAjj7KGeSeJFCpDwXc8k+67Akobcfv7wh2wetP0tXE=;
        b=nFLX3eNXxYkofyRhhBxQ+Lap9bqY8x+fqE3Uf6GpLomOY3vm2RTXA1sBsNqAdhQKjl
         SGGLOoyWEYmNH/fhtbxrNeEhInDs25mvCI5KvSI+FqYHaAtBvyp3k6Z6lAAJjajBdx7T
         xb5fQvfPwPTIkr1Fw3MEHLsAiaFnkRnpMdVFq59teJPLDDoxu7TAytlRrFl2cSwarwsh
         fDOZW9jh41s3qHRzcVPss/1qw1U2VwjfGvJ6e757RIWlw5y3HhiEzQscTtpT6dVTSvT8
         5VJFhRjT/XSUn4ERlXPeoMalNN1V6wVzWXUyNe6G5rSsmOVQVEliC9DL5qhQdS+2LKEF
         0nYA==
X-Gm-Message-State: AFuF++n/181xPxcfUaWG0dxpKnPunxci/7xDBMU5z6r1TlfKTahWxa+9
	lTjq80qon+srOJyS3uxWEDpFfKopD75z+mlc/rgzcMd9aaHncWVzohzOm8EbHQ==
X-Gm-Gg: AYBFou29ZJaxIFiYrP6C6GpIzvbW5H5Z0ngrGyJFeyQjAZ2/kjpAht85W/jrrtk4Z4z
	0ZWrM8H1Kmzz6xawHDB8+jDnUhLg7ujtguHdf2E2JtLAuSh9y8f4A4UMrVOkn7Rw1Ytq1WcuEWa
	KyuSSNiLg7Qd0RRS8YmLGxMmSWjv1xjzXkqxUNu0kzQSB2torrrqXNHzG8JtEJpqEVnSePETc72
	1CH6qWzwDA5RGtObHA1ulSKtj58U+vaxxg9QpJ9dhd2xC3jNweUhNNLbUGTcb6s/b19sTGet2AU
	wxTAlsWnkmDpSyQiLMNYSvM8B2bAf0tffWGU0E9UcPbmeELpGjId22buEAjszgUcsIq4BFVH2eZ
	tf1atsQHIJGDExO9u2L3k8MiMpaWqr82VWN2l9eprhV5kbYbOAk/IE1WHCJAqnuTOdHX5pBOTjo
	8t6PfcCuUYMkGXsGdXkyzKx3yTUGry9B5KtvS5h+SQv4aaY38/hd/kS9cO12m5Wgq323kY69sVy
	FEczJJRYdA=
X-Received: by 2002:a17:90a:c089:b0:39e:6c68:c78c with SMTP id 98e67ed59e1d1-39e6c68ca3bmr5493279a91.66.1789908275770;
        Sun, 20 Sep 2026 05:44:35 -0700 (PDT)
Received: from localhost.localdomain ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55b83602sm6080026a91.1.2026.09.20.05.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:44:34 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 20 Sep 2026 20:43:45 +0800
Subject: [PATCH 6.12.y 2/2] net: cpsw: Execute ndo_set_rx_mode callback in
 a work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-v6-12-cpsw-v1-2-b8490c4ef019@gmail.com>
References: <20260920-v6-12-cpsw-v1-0-b8490c4ef019@gmail.com>
In-Reply-To: <20260920-v6-12-cpsw-v1-0-b8490c4ef019@gmail.com>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.17-dev-5895e

commit 0b8c878d117319f2be34c8391a77e0f4d5c94d79 upstream.

Commit 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.") removed the RTNL lock for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP operations. However, this
change triggered the following call trace on my BeagleBone Black board:
  WARNING: net/8021q/vlan_core.c:236 at vlan_for_each+0x120/0x124, CPU#0: rpcbind/481
  RTNL: assertion failed at net/8021q/vlan_core.c (236)
  Modules linked in:
  CPU: 0 UID: 997 PID: 481 Comm: rpcbind Not tainted 6.19.0-rc7-next-20260130-yocto-standard+ #35 PREEMPT
  Hardware name: Generic AM33XX (Flattened Device Tree)
  Call trace:
   unwind_backtrace from show_stack+0x28/0x2c
   show_stack from dump_stack_lvl+0x30/0x38
   dump_stack_lvl from __warn+0xb8/0x11c
   __warn from warn_slowpath_fmt+0x130/0x194
   warn_slowpath_fmt from vlan_for_each+0x120/0x124
   vlan_for_each from cpsw_add_mc_addr+0x54/0x98
   cpsw_add_mc_addr from __hw_addr_ref_sync_dev+0xc4/0xec
   __hw_addr_ref_sync_dev from __dev_mc_add+0x78/0x88
   __dev_mc_add from igmp6_group_added+0x84/0xec
   igmp6_group_added from __ipv6_dev_mc_inc+0x1fc/0x2f0
   __ipv6_dev_mc_inc from __ipv6_sock_mc_join+0x124/0x1b4
   __ipv6_sock_mc_join from do_ipv6_setsockopt+0x84c/0x1168
   do_ipv6_setsockopt from ipv6_setsockopt+0x88/0xc8
   ipv6_setsockopt from do_sock_setsockopt+0xe8/0x19c
   do_sock_setsockopt from __sys_setsockopt+0x84/0xac
   __sys_setsockopt from ret_fast_syscall+0x0/0x54

This trace occurs because vlan_for_each() is called within
cpsw_ndo_set_rx_mode(), which expects the RTNL lock to be held.
Since modifying vlan_for_each() to operate without the RTNL lock is not
straightforward, and because ndo_set_rx_mode() is invoked both with and
without the RTNL lock across different code paths, simply adding
rtnl_lock() in cpsw_ndo_set_rx_mode() is not a viable solution.

To resolve this issue, we opt to execute the actual processing within
a work queue, following the approach used by the icssg-prueth driver.

Please note: To reproduce this issue, I manually reverted the changes to
am335x-bone-common.dtsi from commit c477358e66a3 ("ARM: dts: am335x-bone:
switch to new cpsw switch drv") in order to revert to the legacy cpsw
driver.

Fixes: 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260203-bbb-v5-2-ea0ea217a85c@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/ti/cpsw.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index c0a5abd8d9a8..2968b5fbe428 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -305,12 +305,19 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 	return 0;
 }
 
-static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+static void cpsw_ndo_set_rx_mode_work(struct work_struct *work)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
 	struct cpsw_common *cpsw = priv->cpsw;
+	struct net_device *ndev = priv->ndev;
 	int slave_port = -1;
 
+	rtnl_lock();
+	if (!netif_running(ndev))
+		goto unlock_rtnl;
+
+	netif_addr_lock_bh(ndev);
+
 	if (cpsw->data.dual_emac)
 		slave_port = priv->emac_port + 1;
 
@@ -318,7 +325,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 		/* Enable promiscuous mode */
 		cpsw_set_promiscious(ndev, true);
 		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, slave_port);
-		return;
+		goto unlock_addr;
 	} else {
 		/* Disable promiscuous mode */
 		cpsw_set_promiscious(ndev, false);
@@ -331,6 +338,18 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	/* add/remove mcast address either for real netdev or for vlan */
 	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
 			       cpsw_del_mc_addr);
+
+unlock_addr:
+	netif_addr_unlock_bh(ndev);
+unlock_rtnl:
+	rtnl_unlock();
+}
+
+static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+
+	schedule_work(&priv->rx_mode_work);
 }
 
 static unsigned int cpsw_rxbuf_total_len(unsigned int len)
@@ -1444,6 +1463,7 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	priv_sl2->ndev = ndev;
 	priv_sl2->dev  = &ndev->dev;
 	priv_sl2->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
+	INIT_WORK(&priv_sl2->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 	if (is_valid_ether_addr(data->slave_data[1].mac_addr)) {
 		memcpy(priv_sl2->mac_addr, data->slave_data[1].mac_addr,
@@ -1625,6 +1645,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	priv->dev  = dev;
 	priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 	priv->emac_port = 0;
+	INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 	if (is_valid_ether_addr(data->slave_data[0].mac_addr)) {
 		memcpy(priv->mac_addr, data->slave_data[0].mac_addr, ETH_ALEN);
@@ -1727,6 +1748,8 @@ static int cpsw_probe(struct platform_device *pdev)
 static void cpsw_remove(struct platform_device *pdev)
 {
 	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
+	struct net_device *ndev;
+	struct cpsw_priv *priv;
 	int i, ret;
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
@@ -1739,9 +1762,15 @@ static void cpsw_remove(struct platform_device *pdev)
 		return;
 	}
 
-	for (i = 0; i < cpsw->data.slaves; i++)
-		if (cpsw->slaves[i].ndev)
-			unregister_netdev(cpsw->slaves[i].ndev);
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (!ndev)
+			continue;
+
+		priv = netdev_priv(ndev);
+		unregister_netdev(ndev);
+		disable_work_sync(&priv->rx_mode_work);
+	}
 
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);

-- 
2.55.0

