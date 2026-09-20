Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648D33DEC0
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908491; cv=none; b=gdTXJrgbZKgRqB52dkZm9nRSRl9Fjk6BrFL5QDp6ZYW8CDdGnXGehscStEZkpXPDfr/8P839/Hl4EemKiW14DX65K+K6HHoRWzEwEZvPeVW1lmIiQ6ouiy1QYR7Vrr++cE0fZnlvX0jwYZ80VLH+kRPX0OsUwSdqImvHqX0jPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908491; c=relaxed/simple;
	bh=Fa8vqyKUtrDeZJphRsKJgfeDBNSlBcvvjv7ZCgcD7UY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ex9hrYvJUWt2fmJVta+nx+MDrH9RbhZ6nW7RxEDKJwHu6WK6lcRlxTnTHmgX4bCNKDWuWxSn7YzEV57PESq8sBv0JwP/eqHr5NvhfwjDflP418nXaSgNKFE8uEsaqKRkwLqxKV4vu5mj6Q5yD+8iGVv4dlcV6SsaHS+WF7iJJK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWzFf1B/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWzFf1B/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso1905522a91.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908468; x=1790513268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNBcY1e2Xd4hGPwfcLgCeUhqP6q79/netVjNEQK7cuQ=;
        b=iWzFf1B/jghgKvvH90FDakye9F6vPlBtCNPflgvduCkGImF4GIWiyASzYknSO+x2GF
         xCLEnBXUQxXX9WZiKgdCpVfNvGprpROubdVOERhbhq5s1xjvHo6oK1Nv4oVc8kLu3ToX
         uR0ajmvJdLDRqWkGpgOmIc+Ea8t1guoiato/rqP/Ixbz7S181csdoxM4ItySNdy6WNLx
         T7kksQjTHuvthpM3KqI1cBtRiYUK7DDbPRRF0/Hz0QX8/q9ygybJne1WDkDdU6oN90hF
         tfugVD90Bnc4vKNOfi6gJ/uDZAA37JdHAsdspEF9blVHrs9LSX1xji0yUm8PqAf7YzMJ
         E/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908468; x=1790513268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SNBcY1e2Xd4hGPwfcLgCeUhqP6q79/netVjNEQK7cuQ=;
        b=fSZ/ucnNZIVgir/qtIB1KP6idfjsmJMFsbJeePNu/x9DPV/cUiBcT+zhmh3IlYrhQW
         4DeQs5plnbTsWUX+EoqNI1diaVmuxWWxN6ovvuPe8Y8pDFdDHIvKttaJc/V7XWHXzKTy
         U9P66RNQMbnRiV+Ei6YHYn+C1i768V1+Pu1l79yI58BL/oPjbym9ZyTMGE7fL1/12Tqq
         MuUU1N3NtLke+DejjfjIbjAR5joWGGZgFvWxlr8lFAiVM0ZP0wT4DmNPkAM8RAJj3aHg
         DuVyJvUi/iPtpF+2BHUilQ73CFtHp+M+2+ZbZyOvyxQDKuNmHxaKs/qSS0W87uUkhYXw
         PLOA==
X-Gm-Message-State: AFuF++nwz1xJB7pjzpS5FV8YpNliv9Ha757wFsttkOKUczXgyDAAwIA0
	k3rQahwTRT+S78AKUrgvtJDgOxdx69U6DCpvRdicm/s5U3M019mTt8+a
X-Gm-Gg: AYBFou2ZR60U0wbvX7fitEYSqIwsNcqvhVB4vNQGy64JjwixrUFMiAhWZAaRhVjRTkg
	k6h48aCYsP1eLTu11saZB2vZXdanLj633LVuo91gCc7cbzUrT592TK6E+GZBa9Y+fpoYvhkZvto
	vUlt17kzDPCh2wNVMqJCqI0O3A9w7KGNHA7BhXM7BdVJPiQNdMM5ZW1QsLCzbXKquXi7nsccRuf
	Lee17DVCCRPPdjRpqQBylkbrj/PjDa9G+bX7meRZUS1ZeTD0mikXzAJsapiBZT3iyVR7m4dVmsq
	FtLUHxH+igmXi1a83nAptOJH1IyjD9ryL+wZWlws+qYuppbvD2X6SIawV/SlVrEwjBfJDmo2DGA
	FwRrvSPfqQAZLKJEfRGqsNU6TdiurGd0Ca9Pz3yojpDwPmQ0LwUn8oKB60UApOzPQ+TtDJBpfCh
	sVFOTYYaDfD/VXZoHZITCYtGI0YAa0TVHAGM8myc9B9MBcXEXCE9F0xsHq2Fdmh37g+YASUQsBn
	jkhkL0NUJo=
X-Received: by 2002:a17:90b:4b45:b0:39d:f7dc:61e4 with SMTP id 98e67ed59e1d1-39e54b204c5mr12812771a91.9.1789908468408;
        Sun, 20 Sep 2026 05:47:48 -0700 (PDT)
Received: from localhost.localdomain ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c164c18sm9089410a91.1.2026.09.20.05.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:47:48 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 20 Sep 2026 20:47:32 +0800
Subject: [PATCH 6.6.y 2/2] net: cpsw: Execute ndo_set_rx_mode callback in a
 work queue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-v6-6-cpsw-v1-2-a4a4b3dd4eb2@gmail.com>
References: <20260920-v6-6-cpsw-v1-0-a4a4b3dd4eb2@gmail.com>
In-Reply-To: <20260920-v6-6-cpsw-v1-0-a4a4b3dd4eb2@gmail.com>
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
[Kevin: Replace disable_work_sync() with cancel_work_sync().]
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/ti/cpsw.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 2ed165dcdbdc..f174de968d77 100644
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
@@ -1727,15 +1748,23 @@ static int cpsw_probe(struct platform_device *pdev)
 static int cpsw_remove(struct platform_device *pdev)
 {
 	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
+	struct net_device *ndev;
+	struct cpsw_priv *priv;
 	int i, ret;
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		return ret;
 
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
+		cancel_work_sync(&priv->rx_mode_work);
+	}
 
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);

-- 
2.55.0

