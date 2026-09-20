Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4E43F0B7
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908644; cv=none; b=j6+ZDaHVS5aKZ6s6AbldGXCkh5CCyDYC4bMQbBj6ONgFd0t46+UmRQclzlsevqCsqJasNvWS/A/sJ4L2ANrAH8I6xkm44VhPGdoILaBnsgVroEYvRqF+szJdmopr4sS2VEkRd0nAFCBQ0uNk7f9dtPS+W4tTH0yLFVXpPS56h0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908644; c=relaxed/simple;
	bh=oJHjqlRYyysa5DRxEZuabSOxNXjBT9WivnSc5xZNVPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0t8/4J/DmIDTM+XNE8skpY0r8sshyyJYX31k+hgl4tUEdrPKxXj7QtjKoUGlRI/DzUlM6bXD7qK8yhZFHlJibssAW8HGsFrp1AdntRDiSQyS0/JGCMWX4qWoA58gv/Vojn50NKyMGXJpqNXUwl2wR7wmNLk4qE+C2wH6pklxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAsXzQIX; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAsXzQIX"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1768213a91.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908631; x=1790513431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFwb/vvl58mJL9kq5VSEIjlj/FtKSH2fCabthC0DfbA=;
        b=IAsXzQIXnrb0z1e+NXM4/jj0MS97K1DhhWbUsifmvsCYKI+5o6O5qspuT3KOWw4uqx
         K+wjTa9j+XJiDc9Bq/JwW6YGN5hVcepvnONl4gHANuNox9DMrcIu7BLb00Tx+3h2nKw7
         xeptEO6WFcXaMI1ICq9GSZQpcBBK3E9mpnCu3wDiTwAu3TJ200eIUTtt3SkDwABoEM+e
         ad3f2C7S4rhiZHR0f4vQX8OCWwp97aOaMO6iFl1JAwEbWqqq6IR3el29tZB9M2B7O9Br
         JBwJrghz8ujr14PNhNTsEE30IxMgFLPSoaF8frfMhyWY4gVyYvdFiJc9DLMz0TC0PMMv
         iNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908631; x=1790513431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFwb/vvl58mJL9kq5VSEIjlj/FtKSH2fCabthC0DfbA=;
        b=uE6Bm4Aj1Shzhs1Nojc2iye4SuPj7RHVEp0+6xGI5eXojpmk+K93LNiOvg3Wwyv2G3
         5qwZj/ZYKdZhdq63mwvOqMzF8/lgpDQLnXSSx2CSMH5gtvUzhqI6Z4bHsImRB3KFRhly
         P8jORc70uVyQwUd0SmyN+DkklGNSlAdXt7tXc0H5DoQclh4WrjfzDXFU7OJcW82kn32G
         zX4bpxLd2PcvoUS1XgAjj3wsGjeNGJq9jBWs9aVVGCvMAKcENYm0drplacy8RSZKlyG5
         zxRf7QkkbCatcepsXnmPB475wbNfHL4ev9lgT3gCcggDEWuOvK0nKp5Gy+wzbVCztIiG
         qtwQ==
X-Gm-Message-State: AFuF++mvsYtGvI989yvnY7zOCKZ/TR7n26RHO8s1pd2+EVUwR4MLh75R
	wRYi0219eNEw7vLhCoIc68DMxrrfHY7zbRcLC9Vuw+33YVOMtDCcWWV1
X-Gm-Gg: AYBFou03ZcKvvaZeuBQCZZhAzLKcSP/xQa17hgFZxDAhrACp4i9K52nBGi9/fGbn3jz
	eD6LZj3Vjbpku7Zx4VgHJYhCsYRKqB15mEsRWx2SuvFZLxRF6S35MVKaJUYEHVzj/bpsGMxEIzx
	QEUjIeIJa/hdv+OOX8hhA3BX3IVcuCEF/l8Jf2DQh4lZ1asA3pcAXpJiuntAIvjAwPbfk7Mj+g1
	PXXQ1Xucr7vZSlhI2Ax0LGG2JZa2PbC1K4IURyXYk07un+AZ9BykOn1+z2rN7DczaH/D2KJl0NU
	CKG4zZ8vV1ckuqaE5fihdrQXSUeCu8PipaxWR68XHKfL095XCpRvTDbWQGCcm/SnAREHaFyBj4h
	RgXj6JVhvN1Vk2mvo9rRtceGame/+ZjJko3iCes9qMYIV72os1H3gLB60ctvSqTw4e9N/2L0lEB
	dLibcPtU1hncyF5Z3jZS4jP99qWAwFY2kY8IkGKo/YtitB0jojnBZNvTXuXceE9AhJ3RrxKK3Pg
	6hfNKqAluC3
X-Received: by 2002:a17:90b:164d:b0:39e:6c69:7776 with SMTP id 98e67ed59e1d1-39e6c697956mr7570890a91.31.1789908631030;
        Sun, 20 Sep 2026 05:50:31 -0700 (PDT)
Received: from localhost.localdomain ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6caefa5esm9034132a91.12.2026.09.20.05.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:50:30 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 20 Sep 2026 20:50:18 +0800
Subject: [PATCH 5.15.y 1/2] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-v5-15-cpsw-v1-1-208e80dc0f51@gmail.com>
References: <20260920-v5-15-cpsw-v1-0-208e80dc0f51@gmail.com>
In-Reply-To: <20260920-v5-15-cpsw-v1-0-208e80dc0f51@gmail.com>
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
[Kevin: Replace disable_work_sync() with cancel_work_sync().]
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/ti/cpsw_new.c  | 35 +++++++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index bef2c71b9059..f0ef23c0ac10 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -247,16 +247,22 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
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
@@ -269,6 +275,18 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
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
@@ -1397,6 +1415,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		priv->msg_enable = netif_msg_init(debug_level, CPSW_DEBUG);
 		priv->emac_port = i + 1;
 		priv->tx_packet_min = CPSW_MIN_PACKET_SIZE;
+		INIT_WORK(&priv->rx_mode_work, cpsw_ndo_set_rx_mode_work);
 
 		if (is_valid_ether_addr(slave_data->mac_addr)) {
 			ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
@@ -1444,14 +1463,18 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 
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
+		cancel_work_sync(&priv->rx_mode_work);
 	}
 }
 
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 435668ee542d..e81a4b12847e 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -382,6 +382,7 @@ struct cpsw_priv {
 	struct cpsw_common *cpsw;
 	int offload_fwd_mark;
 	u32 tx_packet_min;
+	struct work_struct rx_mode_work;
 };
 
 #define ndev_to_cpsw(ndev) (((struct cpsw_priv *)netdev_priv(ndev))->cpsw)

-- 
2.55.0

