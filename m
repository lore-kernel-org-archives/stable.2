Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DF3806D9
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908497; cv=none; b=U/OtZ2xtyD1yr02P3YAncNxAOucE21l5SKYtbjGzIzu1/AmFAh2JNyeA2WnolOLs/sKF4XQqiqHVKZPfZMwVkBReE8S3cnBG4ttFvpdMkClzmFyowwa4AxHD7nQAqQIXPEiykQ+p2Hip5F27acfOzs6nc6VQ5/9UdEgcFD48Zmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908497; c=relaxed/simple;
	bh=yzoC6rMtaXeJ3iZI8tF44d+5VOjEHSHGniA5r9Rv/EM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTaHq/nJo7+nL+qAE9KvMMslkDW/4EYyDS/TSdGw3eeTOTNYsamAqioiB46db2uO+33tEip/foUy2dIJDn6J5gVGcL48udjgRzIsJOsJEL2K6tFfTiM57yjfyuLjPETzoDELbFD57/FaE5ElOqz29JtlwZwvv/9D2CZ209eHLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgTLSjw9; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgTLSjw9"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so26247845ad.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908466; x=1790513266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uKbi5okAzrUH87Yif/aS/25Wc98begFci+VP++qviSo=;
        b=PgTLSjw9XXe7GXqvsrAQ2CpyMO0mpXSMfxt+YxXugfi2ig/Y0jtrKtTUqNejIhuLIE
         j3JvnRhR7nZERrksx7LYxhu088GaabcKX6Zrh7iZeoxkmh2FIE2F6/OXR5oC3UjtgNXi
         MOl4I7c92mniIqsc55Iu5K0zptr5xG2zVnPyCKtAhv8HC+0G57ali8NDH4U0gwmPJ9PR
         8ZDXnN5+w77P0OB6hhlti+Lpnc7wk25pZjnBAlkIwQB8w8ShWIFjj83wkmT4w37h3tuh
         IotMyG3BRLl2yhCDiZrPqmqTv6g6ZUH+/PY6DY9UvLP8gINt5yibLQ8cSeNqSjihQZWa
         xKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908466; x=1790513266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKbi5okAzrUH87Yif/aS/25Wc98begFci+VP++qviSo=;
        b=lbkPrWqL/2Obr4d3XVm7eBDsNwAgsXkwTKWKZ/i/1hiDlXULuWlAiB9gHIibZn18PW
         CZeJdJ6FwPfQyacXtroic/7LbnXJQHe+Jgh+v4Lnrow8z1fDmemWeRRWTb1JdZxJqwSV
         Lx02snycgxytQryEBpzdsoyxHVz4MclWul1OtZidkAjZa0wBFW2YME8F9Dbj07l8fpzS
         WZ0hGLf++G092N1voLXj9PG5tQRjvqNvqrqDZIXchGyCXIRxbhVNLJjUCj5vq0SmtyZZ
         coYErewX9uC58vBU2hdIzWuVHnuhv6IlRNQRltouhm3sVy3j3NL4kGaXg7Nj1XVLtIpK
         IEHA==
X-Gm-Message-State: AFuF++l5aW89U29+JsyW/1KE9cxQvauHr/7Ll0kwGK2RLA/hlp/gndpH
	BHbKwhu+R0Lr+/ch2P0dAvz3BKF5OFNREqzqbQNVeQCX76+FIrC66Zl/megLa13T
X-Gm-Gg: AYBFou0p+uJOgjOsWolxFodDJwJI8HbZ5VcSUA9I6fMlop1TFYIL4BLLWM5PwyBNioa
	7+FYQCc242oVNYCxPN1S1dMmLHgZuD0FKZR9U9w/FSzNOL2R6tyIQsb76oWkbbudtDb7GWzKOyB
	TmTwUVTnD7jUrycyjCJ5HZfXGRS8drjXOfvhBDZmf3C/SQjMASxVAWI424j1bPfjwmlorDOf7i0
	moy2MQO1LU9DzjsIpgNtbXy1l9D5QD1Pj9kS+mgGCz9UKpttqoDWBvvaSCjcVmnYABe46zocH6o
	C3PSCEUDiSpugxpps8u5W8JJ7k15d2okT44rRELQfvV5xXM2qsLK2BDpUyE89PWpI7WqmqTeX86
	T1+iR2tvDRM6BF2FGyB+RLyO/vch8pgyjCI04Omr/oShG9TKalxI7GUUJsQ/K9oPtpoJuQexuKP
	GnzwAVbJnZBYqhhTwuxGIYKVrsqvF5QYkGKufGrAd3Lt4Ykx7cPGO0vLfSiFwF+74xDmNA4LcAz
	jZgyPOJ1Go=
X-Received: by 2002:a17:90b:4fc1:b0:39e:6c68:c777 with SMTP id 98e67ed59e1d1-39e6c68ca8dmr6653551a91.45.1789908465978;
        Sun, 20 Sep 2026 05:47:45 -0700 (PDT)
Received: from localhost.localdomain ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c164c18sm9089410a91.1.2026.09.20.05.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:47:45 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 20 Sep 2026 20:47:31 +0800
Subject: [PATCH 6.6.y 1/2] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-v6-6-cpsw-v1-1-a4a4b3dd4eb2@gmail.com>
References: <20260920-v6-6-cpsw-v1-0-a4a4b3dd4eb2@gmail.com>
In-Reply-To: <20260920-v6-6-cpsw-v1-0-a4a4b3dd4eb2@gmail.com>
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
index 64f527ba9a47..3b02168929cd 100644
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
@@ -1439,14 +1458,18 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 
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
index 0e27c433098d..3f1572a02af2 100644
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

