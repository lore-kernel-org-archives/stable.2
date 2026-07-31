Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1934A796;
	Fri, 31 Jul 2026 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785469920; cv=none; b=t3kjk7oKxobFn0z7kqvRSqCQvvxbt90OHd1S7qZ0WABxwNSIeHQ/cY005HresN57WWhI2joC+V8pBMkgWBoDDez/cjo8zTBhxwOh+AmPjP5ZO6eaS50A3co361Q0DElacpjxbeyq7gpby8BYhPo83ivbCuCtSTc4CLtgM2kkWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785469920; c=relaxed/simple;
	bh=SOMjTG5aLGc2Ocou/k8Gs4US8R9zVKGd6sMIuOTRvoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWTHPxvQa/qwRmo2ebnlniw0Fk1T9r+OJp2qGWHW+OqLlAL6C+4OLPR2EZIiUXRrOWrRFldqUwj2y1fcfgb2vJLCQmk6DYHWi+LcxjCZGkFNRtfOrV+UfkUbZyu3r1jTYTfJ1YWWnDWWRlDwT41m0hQhwTQJBvxDccC8obKW9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 270a41b68c9311f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2a583355-6c76-4c4d-8bc3-96601639bebb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:59a1792aedf43d9be303b4be9ed2709d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 270a41b68c9311f1aa26b74ffac11d73-20260731
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1946430259; Fri, 31 Jul 2026 11:51:46 +0800
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
Subject: [PATCH net 2/2] net: guard refcount against tracker double-free
Date: Fri, 31 Jul 2026 11:51:35 +0800
Message-Id: <20260731035135.3917308-3-yijiangshan@kylinos.cn>
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

As a defensive measure, guard netdev_put() and netdev_ref_replace()
against refcount corruption when ref_tracker_free() returns -EINVAL
(tracker already freed).  Currently __dev_put() is called
unconditionally, which over-decrements the device refcount on a
double-free and can cause netdev_wait_allrefs_any() to return
prematurely.

Change netdev_tracker_free() to return int so callers can detect
the -EINVAL case.  In netdev_put() and netdev_ref_replace(), skip
__dev_put() when the tracker was already freed; ref_tracker_free()
has already warned and the first successful free already decremented
the refcount.  The -EEXIST case (NULL tracker, untracked reference)
still calls __dev_put(), preserving existing behavior.

Fixes: f12bf6f3f942 ("net: watchdog: add net device refcount tracker")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 include/linux/netdevice.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d63..5e8cf3f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4512,11 +4512,13 @@ static inline void netdev_tracker_alloc(struct net_device *dev,
 #endif
 }
 
-static inline void netdev_tracker_free(struct net_device *dev,
+static inline int netdev_tracker_free(struct net_device *dev,
 				       netdevice_tracker *tracker)
 {
 #ifdef CONFIG_NET_DEV_REFCNT_TRACKER
-	ref_tracker_free(&dev->refcnt_tracker, tracker);
+	return ref_tracker_free(&dev->refcnt_tracker, tracker);
+#else
+	return 0;
 #endif
 }
 
@@ -4533,8 +4535,12 @@ static inline void netdev_put(struct net_device *dev,
 			      netdevice_tracker *tracker)
 {
 	if (dev) {
-		netdev_tracker_free(dev, tracker);
-		__dev_put(dev);
+		/* Skip __dev_put() on -EINVAL: ref_tracker_free() already
+		 * warned and the refcount was decremented by the first
+		 * successful free.
+		 */
+		if (netdev_tracker_free(dev, tracker) != -EINVAL)
+			__dev_put(dev);
 	}
 }
 
@@ -4569,11 +4575,10 @@ static inline void netdev_ref_replace(struct net_device *odev,
 				      netdevice_tracker *tracker,
 				      gfp_t gfp)
 {
-	if (odev)
-		netdev_tracker_free(odev, tracker);
+	if (odev && netdev_tracker_free(odev, tracker) != -EINVAL)
+		__dev_put(odev);
 
 	__dev_hold(ndev);
-	__dev_put(odev);
 
 	if (ndev)
 		__netdev_tracker_alloc(ndev, tracker, gfp);
-- 
2.25.1

