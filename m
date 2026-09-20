Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E643935C
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908289; cv=none; b=eIzbuZs1uvTCY5GTfVaSl4GZVXxcJjJ975dEKLp4NMkaNA56VMZ1USx+8VO16plFGvuR+FlUQLi5mlka9cOgneAFsd7ZsZPneyfdI+cyG1BLfn96/hEPjKk2Z3/j02Ijwnk5tfcut4pUkal9R6ahXsvd/XSU7GW4JHH3+U+5TBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908289; c=relaxed/simple;
	bh=pdIcOCdMEJnJtRqKd878DBEtlofcZZ/DpvvS3BcXm04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i8FdZ1Pk6E1pP5PqPMm4o/GhbfdEgPT61Vn0groYuEL6igFb/PO+sNrpnxYMfsFzghCb8hTd1OucyJ5h91hMUsV6HmNNSCZM033xcYAt0yzOkf6L7UbEaTsnoZcMSH4tWZie58Sa3jGa4ltADSOG/otvdRM8VcYqBsOQICalNlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyOYmoKv; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyOYmoKv"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1943551a91.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908273; x=1790513073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgxu6KR4qNVjVUFuEvkNGl+6Doloj9owoTA1i8y+nGM=;
        b=OyOYmoKviiFBOgRx4IKfXdJisVk8m7oWXHKh/0pgF6aB5Wyd2M7nzWtrJvPXpy11mm
         nzGnA/+uTjxuCeBOW4nX82yc5O9T2JQckPyZbIjg+/mHQYPexpbim3C8VQto2JEmN9cy
         qAkCUZdJE5V7r0ghcht6U7XCzLbig8+i0pHi9qoH1fYD5Yk81GzYiv+IRbzd2LogE8sR
         bUAOPOxEHfC6NcjVDT99M0bH+ZvFtxyoeLLieHx8dfibwZ7eOhsqmHGpfau1b3IsFatc
         eYLh1sSwsyLmOFKE3vhP4tpkaXN6Y4uX+iGTiqzHtnIt0YWZp/FoeSil9r0/tvguX6X1
         siow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908273; x=1790513073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgxu6KR4qNVjVUFuEvkNGl+6Doloj9owoTA1i8y+nGM=;
        b=j+JbaNxxtNFUbAcTnhzQmE/QkIFTjgbyb66bPaORw+vX4w7tSQeu/XneWo4fJqdgGv
         ZHt/ZvP0aLopMlyKieCvXLXH2sA38aBZAso8Wlo6PdOZoOKERF4j8b0Ymc+8bol+7grs
         sK7RQNZGBsdbhp8MTrzjpc36E2eZnyAPu9ZCuRUYXurlwQv3oVc5xLrZK8Cpi5cjVQvY
         4i7HDHUEQCUnaTgybTzDszzr7CgkADeBiWR3EOv3DzwxWiHlmUQNste3vhCsUiWvcXvR
         b9UEV4Sctngeiqb5BxNS+piuqj07qlz7aHAedCqcpb/kDlcVIYr+WDROnCh+SDZOldds
         l3vw==
X-Gm-Message-State: AFuF++k78ZXBZYrD0+0WG6Wr9JvOgBZwJDtO28+UvzMyoeMA5dbRATMf
	UqhINkXqN/DIBthJE2KCBDEtPCCOQSUN1aykHv/UHx9uCvFhbyvoGkdj
X-Gm-Gg: AYBFou3YeDrsOjubZQSy6XGRJuefHTuZaR+nUBGEQM2QTh/rB/NunYjdYSrlK4FUQcR
	28Lqbwk4AuFeccuceJ3t8tq19aiEl5oCiKFm532zmvhSqGeiA3MKOP/31Zs8kMSFrCcGdm06ChW
	caCqius9H8S8mwg+dRm9gCHUQIFiePx67mOO8EmYerFTHaZBt5dG+1vjMPv7tQGFEDKsEGmn/I7
	m1WTrgRhaaAt/Sty9BwpWCKd0kVcgB5fu0NsS1iIJ1y5qGj2oYHg+mfrUJcXEBlTsZq+sPCgZaq
	53/JnV+mKXR9J/OI3WudF2kK2DkaffQOvKMawkbQYGYUeNO441k7gBNBwK3hunF5W1eS8/mcxLO
	Odm8La+qs9nJHHkLjieRKNLWbqEapncZ+ZYFXiYHURle00Tk2btoBHFgsSMFLdrTgU0hKhHp3U9
	R6I4/XGn3aD/wH1WPy2ShSpe6jG/7LbIa6xR7C9BO3upqdPUIBjtJxUgH2UEL4UuNA0EUCImN97
	4ewftWfMBU=
X-Received: by 2002:a17:90b:4ac7:b0:39e:6c6a:4b6b with SMTP id 98e67ed59e1d1-39e6c6a56acmr6170308a91.53.1789908272709;
        Sun, 20 Sep 2026 05:44:32 -0700 (PDT)
Received: from localhost.localdomain ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55b83602sm6080026a91.1.2026.09.20.05.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:44:31 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 20 Sep 2026 20:43:44 +0800
Subject: [PATCH 6.12.y 1/2] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-v6-12-cpsw-v1-1-b8490c4ef019@gmail.com>
References: <20260920-v6-12-cpsw-v1-0-b8490c4ef019@gmail.com>
In-Reply-To: <20260920-v6-12-cpsw-v1-0-b8490c4ef019@gmail.com>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.17-dev-5895e

commit c0b5dc73a38f954e780f93a549b8fe225235c07a upstream.

Commit 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.") removed the RTNL lock for
IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP operations. However, this
change triggered the following call trace on my BeagleBone Black board:
  WARNING: net/8021q/vlan_core.c:236 at vlan_for_each+0x120/0x124, CPU#0: rpcbind/496
  RTNL: assertion failed at net/8021q/vlan_core.c (236)
  Modules linked in:
  CPU: 0 UID: 997 PID: 496 Comm: rpcbind Not tainted 6.19.0-rc6-next-20260122-yocto-standard+ #8 PREEMPT
  Hardware name: Generic AM33XX (Flattened Device Tree)
  Call trace:
   unwind_backtrace from show_stack+0x28/0x2c
   show_stack from dump_stack_lvl+0x30/0x38
   dump_stack_lvl from __warn+0xb8/0x11c
   __warn from warn_slowpath_fmt+0x130/0x194
   warn_slowpath_fmt from vlan_for_each+0x120/0x124
   vlan_for_each from cpsw_add_mc_addr+0x54/0xd8
   cpsw_add_mc_addr from __hw_addr_ref_sync_dev+0xc4/0xec
   __hw_addr_ref_sync_dev from __dev_mc_add+0x78/0x88
   __dev_mc_add from igmp6_group_added+0x84/0xec
   igmp6_group_added from __ipv6_dev_mc_inc+0x1fc/0x2f0
   __ipv6_dev_mc_inc from __ipv6_sock_mc_join+0x124/0x1b4
   __ipv6_sock_mc_join from do_ipv6_setsockopt+0x84c/0x1168
   do_ipv6_setsockopt from ipv6_setsockopt+0x88/0xc8
   ipv6_setsockopt from do_sock_setsockopt+0xe8/0x19c
   do_sock_setsockopt from __sys_setsockopt+0x84/0xac
   __sys_setsockopt from ret_fast_syscall+0x0/0x5

This trace occurs because vlan_for_each() is called within
cpsw_ndo_set_rx_mode(), which expects the RTNL lock to be held.
Since modifying vlan_for_each() to operate without the RTNL lock is not
straightforward, and because ndo_set_rx_mode() is invoked both with and
without the RTNL lock across different code paths, simply adding
rtnl_lock() in cpsw_ndo_set_rx_mode() is not a viable solution.

To resolve this issue, we opt to execute the actual processing within
a work queue, following the approach used by the icssg-prueth driver.

Fixes: 1767bb2d47b7 ("ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260203-bbb-v5-1-ea0ea217a85c@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/ti/cpsw_new.c  | 35 +++++++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index fa161a109604..1eddfffc3158 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -248,16 +248,22 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 	return 0;
 }
 
-static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+static void cpsw_ndo_set_rx_mode_work(struct work_struct *work)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
 	struct cpsw_common *cpsw = priv->cpsw;
+	struct net_device *ndev = priv->ndev;
 
+	rtnl_lock();
+	if (!netif_running(ndev))
+		goto unlock_rtnl;
+
+	netif_addr_lock_bh(ndev);
 	if (ndev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
 		cpsw_set_promiscious(ndev, true);
 		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, priv->emac_port);
-		return;
+		goto unlock_addr;
 	}
 
 	/* Disable promiscuous mode */
@@ -270,6 +276,18 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
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
@@ -1391,6 +1409,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 		priv->emac_port = i + 1;
 		priv->tx_packet_min = CPSW_MIN_PACKET_SIZE;
+		INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 		if (is_valid_ether_addr(slave_data->mac_addr)) {
 			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
@@ -1440,14 +1459,18 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 
 static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 {
+	struct net_device *ndev;
+	struct cpsw_priv *priv;
 	int i = 0;
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
-		if (!cpsw->slaves[i].ndev ||
-		    cpsw->slaves[i].ndev->reg_state != NETREG_REGISTERED)
+		ndev = cpsw->slaves[i].ndev;
+		if (!ndev || ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
-		unregister_netdev(cpsw->slaves[i].ndev);
+		priv = netdev_priv(ndev);
+		unregister_netdev(ndev);
+		disable_work_sync(&priv->rx_mode_work);
 	}
 }
 
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 1f448290b9f4..bacaa855e614 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -391,6 +391,7 @@ struct cpsw_priv {
 	u32 tx_packet_min;
 	struct cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct cpsw_ale_ratelimit ale_mc_ratelimit;
+	struct work_struct rx_mode_work;
 };
 
 #define ndev_to_cpsw(ndev) (((struct cpsw_priv *)netdev_priv(ndev))->cpsw)

-- 
2.55.0

