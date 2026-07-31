Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD32E736D;
	Fri, 31 Jul 2026 03:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785469910; cv=none; b=Y+RJ0bBcPm5pK2/CGqRn8XxyoNNbTQ0XbIfP7nnn1sTvoz84b7/ze4y94r9qZyVs22d9vaYiPFpT7ib2d599azXjRAfGQJhM3Wpfcvv1L+UG867YU3MsI728t+tPtoYDjkVV0z1hovP31QKnjkk7qevFchNji3an99r92PDGm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785469910; c=relaxed/simple;
	bh=zYkoFHik6BoEr1chN2vwR0Nm4d9OPYH0vgQoQCmg7cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7OKiL87PsMNbK3pTZTqcu4Zp3MMztG7GfaMooBrH03rtIpGettujK0N+UK0BYTS9+l4qzSztAJN+uE3N7pB/n3lA+qY+7ciQcrbOKn6f4REReYeWCVLFS5q2COmqScJXQg3sTwK+GZW7vUOpGrjfnCRK8gvmQtUnXeaddVYFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 250361ae8c9311f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3098ecd3-15d1-49de-a9ac-72b0a60dae0a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b3e397ab0e6f94f3d655e6ecd1a1ab74,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 250361ae8c9311f1aa26b74ffac11d73-20260731
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1556175904; Fri, 31 Jul 2026 11:51:43 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: cancel pending netdev_work on device unregistration
Date: Fri, 31 Jul 2026 11:51:34 +0800
Message-Id: <20260731035135.3917308-2-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260731035135.3917308-1-yijiangshan@kylinos.cn>
References: <20260731035135.3917308-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a netdev is unregistered, pending netdev_work events are not
explicitly canceled.  Only events cleared by ndo_stop() (e.g.
VLAN_WORK_LINK_STATE) are handled; core events like
NETDEV_WORK_RX_MODE and driver events like VLAN_WORK_MTU /
VLAN_WORK_FEATURES remain pending, keeping a tracked reference
(dev->work_tracker) on the device.

During netdev_wait_allrefs_any(), RTNL is released to let the system
workqueue run.  netdev_work_proc() may then attempt to process the
stale work_tracker, triggering ref_tracker warnings at boot:

  WARNING: lib/ref_tracker.c:322 at ref_tracker_free
  WARNING: lib/ref_tracker.c:246 at ref_tracker_dir_exit

Add netdev_work_cancel_all() to cancel all pending core and driver
work, releasing the work_tracker before the device enters
netdev_run_todo().  Call it from unregister_netdevice_many_notify()
after rx_mode cleanup.

This is safe because netdev_work_cancel_all() runs under RTNL in
unregister_netdevice_many_notify(), and netdev_work_proc() also
requires RTNL, so the two cannot execute concurrently.  If
netdev_work_proc() has already dequeued the device, the cancel is a
no-op; otherwise it releases the tracker before the device enters
netdev_run_todo().

Fixes: 12c765be84d2 ("net: turn the rx_mode work into a generic netdev_work facility")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 net/core/dev.c         |  2 +-
 net/core/dev.h         |  2 ++
 net/core/netdev_work.c | 10 ++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5d..b461b01 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12456,7 +12456,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_uc_flush(dev);
 		dev_mc_flush(dev);
 
-
+		netdev_work_cancel_all(dev);
 		netdev_rss_contexts_free(dev);
 
 		call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
diff --git a/net/core/dev.h b/net/core/dev.h
index 5d0b030..d3ac3ba 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -180,6 +180,8 @@ void __netdev_work_core_sched(struct net_device *dev, unsigned long event);
 unsigned long
 __netdev_work_core_cancel(struct net_device *dev, unsigned long mask);
 
+void netdev_work_cancel_all(struct net_device *dev);
+
 void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 			unsigned int gchanges, u32 portid,
 			const struct nlmsghdr *nlh);
diff --git a/net/core/netdev_work.c b/net/core/netdev_work.c
index 3109fae..d69363d 100644
--- a/net/core/netdev_work.c
+++ b/net/core/netdev_work.c
@@ -99,6 +99,16 @@ __netdev_work_core_cancel(struct net_device *dev, unsigned long mask)
 	return netdev_work_dequeue(dev, &dev->work_core_pending, mask);
 }
 
+/* Cancel all pending core and driver work and release the work_tracker
+ * reference.  Must be called under RTNL, which mutually excludes
+ * netdev_work_proc().
+ */
+void netdev_work_cancel_all(struct net_device *dev)
+{
+	__netdev_work_core_cancel(dev, ~0UL);
+	netdev_work_cancel(dev, ~0UL);
+}
+
 static void netdev_work_run(struct net_device *dev, unsigned long events,
 			    unsigned long core)
 {
-- 
2.25.1

