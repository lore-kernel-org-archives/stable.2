Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745E418A39;
	Sun,  4 Oct 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109909; cv=none; b=l1s6LYwLSyPO/BqifJSjtqvNxJTP2hj7SPnY0HgEDsm0nmswFo0Z7D9DR6DpN+PlOhLdALE4Dr+9V8G18HFTJdWd//G4VmYDPNjD295iZZti1IKNwogn62Ric2lwmrZ9TpwbB4hAs0Unikt7l3dwQLceSYII612XCNLWvk/Z6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109909; c=relaxed/simple;
	bh=LzP4K+Hy+lrpGtA2alfOBHAKktLOo62uHwqvAHYYIc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qUwbAz2YfDUJEy4zkc3GfyYh1eRYZ46k6jxnR2IeYa2mKuKe10xoYQEvk6IIWupIl66zvhoQIDOKlcN+kz7xRhU8+nlHxXO/aVjtGdbIBy/Wvv15ppD2VYdu1BF5Q9vP+KiTa59RoP+sy1WR48DR5ZJHkdZvqGZ4Ju+Inq4jaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=N6Kgbwwe; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="N6Kgbwwe"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4feb7a9b1;
	Sun, 4 Oct 2026 18:31:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net] net: ibmvnic: defer close from reset allocation failure
Date: Sun,  4 Oct 2026 18:31:31 +0800
Message-Id: <20261004103131.1205618-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa106782b4b03a1kunmbc768e8c338b56
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTB5PVkJKTUsfGktDQh5DGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=N6Kgbwwe2tF8Qar+ypwMokXB7CfsMi6TyJUqbGTK/OVplPwJHccEzmd+g6rltyM+w3EkkhhdbL3KColHbnOoyA+tjQAGaK6tmMZYyk0sl9XgTyVkZzvJyXyoaiZBcaXiaUs/DIDTRJoAtWE4hdF1JbveRkNXIzOCKr70u7AsLsU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=O+46VD+H9Rar1sjoDBo4y4zvWHDRInLA900zopAROnE=;
	h=date:mime-version:subject:message-id:from;

ibmvnic_reset() can be called by the CRQ tasklet. If allocating the
reset work item fails, it currently calls ibmvnic_close() after
dropping rwi_lock, but ibmvnic_close() reaches napi_disable() and
other sleepable teardown paths.

Defer the close to a work item and keep the work within the adapter
lifetime. Track removal separately from the visible adapter state so
ibmvnic_close() cannot make removal look active again after remove()
has begun. Check that monotonic flag while scheduling reset and
delayed reset work, and drain all work before releasing the adapter.

Use complete_all() for probe_done because the reset and close workers
may wait for probe completion concurrently.

The issue was identified by code inspection. No runtime reproduction or
real hardware testing is available.

Fixes: ed651a10875f ("ibmvnic: Updated reset handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 54 ++++++++++++++++++++++++------
 drivers/net/ethernet/ibm/ibmvnic.h |  2 ++
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed33..4da3fd7ce0 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2152,6 +2152,26 @@ static int ibmvnic_close(struct net_device *netdev)
 	return rc;
 }
 
+static void ibmvnic_close_work(struct work_struct *work)
+{
+	struct ibmvnic_adapter *adapter = container_of(work,
+							struct ibmvnic_adapter,
+							ibmvnic_close_work);
+	unsigned long flags;
+	bool removing;
+
+	/* The close path can sleep, so run it outside the CRQ tasklet. */
+	wait_for_completion(&adapter->probe_done);
+	rtnl_lock();
+	spin_lock_irqsave(&adapter->rwi_lock, flags);
+	removing = adapter->removing;
+	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
+
+	if (!removing)
+		ibmvnic_close(adapter->netdev);
+	rtnl_unlock();
+}
+
 /**
  * get_hdr_lens - fills list of L2/L3/L4 hdr lens
  * @hdr_field: bitfield determining needed headers
@@ -3229,9 +3249,12 @@ static void __ibmvnic_reset(struct work_struct *work)
 	if (adapter->state == VNIC_PROBING &&
 	    !wait_for_completion_timeout(&adapter->probe_done, timeout)) {
 		dev_err(dev, "Reset thread timed out on probe");
-		queue_delayed_work(system_long_wq,
-				   &adapter->ibmvnic_delayed_reset,
-				   IBMVNIC_RESET_DELAY);
+		spin_lock_irqsave(&adapter->rwi_lock, flags);
+		if (!adapter->removing)
+			queue_delayed_work(system_long_wq,
+					   &adapter->ibmvnic_delayed_reset,
+					   IBMVNIC_RESET_DELAY);
+		spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 		return;
 	}
 
@@ -3265,7 +3288,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	 */
 	need_reset = false;
 	spin_lock(&adapter->rwi_lock);
-	if (!list_empty(&adapter->rwi_list)) {
+	if (!adapter->removing && !list_empty(&adapter->rwi_list)) {
 		if (test_and_set_bit_lock(0, &adapter->resetting)) {
 			queue_delayed_work(system_long_wq,
 					   &adapter->ibmvnic_delayed_reset,
@@ -3422,7 +3445,8 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 	 * a failover reset scheduled, we will detect and drop the
 	 * duplicate reset when walking the ->rwi_list below.
 	 */
-	if (adapter->state == VNIC_REMOVING ||
+	if (adapter->removing ||
+	    adapter->state == VNIC_REMOVING ||
 	    adapter->state == VNIC_REMOVED ||
 	    (adapter->failover_pending && reason != VNIC_RESET_FAILOVER)) {
 		ret = EBUSY;
@@ -3458,11 +3482,11 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 
 	ret = 0;
 err:
-	/* ibmvnic_close() below can block, so drop the lock first */
-	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
-
 	if (ret == ENOMEM)
-		ibmvnic_close(netdev);
+		queue_work(system_long_wq, &adapter->ibmvnic_close_work);
+
+	/* ibmvnic_close() can block, so defer it out of atomic context. */
+	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 
 	return -ret;
 }
@@ -6466,6 +6490,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	SET_NETDEV_DEV(netdev, &dev->dev);
 
 	INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
+	INIT_WORK(&adapter->ibmvnic_close_work, ibmvnic_close_work);
 	INIT_DELAYED_WORK(&adapter->ibmvnic_delayed_reset,
 			  __ibmvnic_delayed_reset);
 	INIT_LIST_HEAD(&adapter->rwi_list);
@@ -6568,7 +6593,8 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		goto cpu_notif_add_failed;
 	}
 
-	complete(&adapter->probe_done);
+	complete_all(&adapter->probe_done);
+	flush_work(&adapter->ibmvnic_close_work);
 
 	return 0;
 
@@ -6591,10 +6617,14 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	/* cleanup worker thread after releasing CRQ so we don't get
 	 * transport events (i.e new work items for the worker thread).
 	 */
+	spin_lock_irqsave(&adapter->rwi_lock, flags);
+	adapter->removing = true;
 	adapter->state = VNIC_REMOVING;
-	complete(&adapter->probe_done);
+	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
+	complete_all(&adapter->probe_done);
 	flush_work(&adapter->ibmvnic_reset);
 	flush_delayed_work(&adapter->ibmvnic_delayed_reset);
+	flush_work(&adapter->ibmvnic_close_work);
 
 	flush_reset_queue(adapter);
 
@@ -6620,6 +6650,7 @@ static void ibmvnic_remove(struct vio_dev *dev)
 	 * from the flush_work() below, can make progress.
 	 */
 	spin_lock(&adapter->rwi_lock);
+	adapter->removing = true;
 	adapter->state = VNIC_REMOVING;
 	spin_unlock(&adapter->rwi_lock);
 
@@ -6629,6 +6660,7 @@ static void ibmvnic_remove(struct vio_dev *dev)
 
 	flush_work(&adapter->ibmvnic_reset);
 	flush_delayed_work(&adapter->ibmvnic_delayed_reset);
+	flush_work(&adapter->ibmvnic_close_work);
 
 	rtnl_lock();
 	unregister_netdevice(netdev);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 480dc58707..d8c8a6d230 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1045,6 +1045,7 @@ struct ibmvnic_adapter {
 
 	struct tasklet_struct tasklet;
 	enum vnic_state state;
+	bool removing;
 	/* Used for serialization of state field. When taking both state
 	 * and rwi locks, take state lock first.
 	 */
@@ -1056,6 +1057,7 @@ struct ibmvnic_adapter {
 	 */
 	spinlock_t rwi_lock;
 	struct work_struct ibmvnic_reset;
+	struct work_struct ibmvnic_close_work;
 	struct delayed_work ibmvnic_delayed_reset;
 	unsigned long resetting;
 	/* last device reset time */
-- 
2.34.1
