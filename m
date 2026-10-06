Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1774AF678
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327367; cv=none; b=a/uC8f2P5XocOIeieeEv8qK2P1gGfv8/KPRS68cmbLH3INKmZJ3Dof/bCTtBd7/GmdAqn1rUh6IzbJHtAl4cVbHiSA5OPTlY3yU8ET4ln8/Pbxn57O+uSoBx3Z5+wg6mHPMSY+XRI3LVNcj8NH6Q5QoNtsQJXJUPruztMnSj+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327367; c=relaxed/simple;
	bh=qVu2peO8dW8wJ98nngjwnufMcbkVC4y1/uO1UrMswHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqSPiQmTzD4nFsPbau0KCOhpIcAhtaLaJH6QfnjNDbkBdln43rpco4Uoo9nvskY8fU0EGEAbwFIp04S38JNNQG+GMB6KldYB/cOYW3kzFI5pDpVlgVzKQA0s8tDdWUYELfFMA/MS+N4ok/vI30AaqH4b1FW8CycmtqA6uQE5Wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH2uQ0Ls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH2uQ0Ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BF01F0089B;
	Tue,  6 Oct 2026 22:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327366;
	bh=urAd1hvdh4eXnWxA9X5t72XO1lJ/Rna2DPPJPqUxvsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KH2uQ0LsZVkegXn6NgWMjFg/ueKZGQbGST8rgyzw1oLVgJQ6YTfTa2QqFH1Uar6V6
	 dnG2bVGL+jm/UgBIEPvZtcsvqVkEfzBAs2rEY3IzHRdEfyG9g+QDXEL2dJ8Zb0wZW4
	 mVGAIIFskmnzbzKokvDi82xpn684eqls5sIJxFN40DFK/EcG0sKy1ni+umxEbvxQdW
	 0L6FrZQV/ZL474wLWq4DZWb+ELh4lExchJgelOH58dNn4rR1IJeblRx6ZO/J6WJmL/
	 JOupo2BOXGORuJVbuqVI/p3wC+97ioKZ4S0RfSU0XdmDYel1QRx53emN+wls6yKKNb
	 GY+gBJiwpVW/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] thunderbolt: Fix KASAN reported use-after-free when request is canceled
Date: Tue,  6 Oct 2026 18:56:03 -0400
Message-ID: <20261006225448.1129500-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100521-substance-schilling-0095@gregkh>
References: <2026100521-substance-schilling-0095@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit a02188ddc24b7872f0c5e0c5873f827318717803 ]

Alan reported that when doing stress testing sometimes KASAN notices
use-after-free during control channel operation (stripped down keeping
the relevant parts):

 BUG: KASAN: slab-use-after-free in tb_cfg_request_sync+0x240/0x250 [thunderbolt]
 Read of size 24 at addr ffff88811067f290 by task kworker/u40:2/1760
  <TASK>
  tb_cfg_request_sync+0x240/0x250 [thunderbolt]
  tb_cfg_read_raw+0x367/0x510 [thunderbolt]
  tb_cfg_read+0xec/0x240 [thunderbolt]
  tb_port_get_link_generation+0x258/0x420 [thunderbolt]
  tb_usb3_consumed_bandwidth+0x1c1/0x2c0 [thunderbolt]
  tb_tunnel_consumed_bandwidth+0xfd/0x910 [thunderbolt]
  tb_available_bandwidth+0x5f2/0xeb0 [thunderbolt]
  tb_recalc_estimated_bandwidth+0x2a0/0x1bc0 [thunderbolt]
  tb_handle_dp_bandwidth_request+0x1897/0x5e20 [thunderbolt]
  process_one_work+0x675/0x1230
  worker_thread+0x5e6/0xf70
  kthread+0x365/0x470
  ret_from_fork+0x54d/0x710
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 Allocated by task 1760:
  __kmalloc_cache_noprof+0x1ee/0x550
  tb_cfg_read_raw+0x1d3/0x510 [thunderbolt]
  tb_cfg_read+0xec/0x240 [thunderbolt]
  tb_port_get_link_generation+0x258/0x420 [thunderbolt]
  tb_usb3_consumed_bandwidth+0x1c1/0x2c0 [thunderbolt]
  tb_tunnel_consumed_bandwidth+0xfd/0x910 [thunderbolt]
  tb_available_bandwidth+0x5f2/0xeb0 [thunderbolt]
  tb_recalc_estimated_bandwidth+0x2a0/0x1bc0 [thunderbolt]
  tb_handle_dp_bandwidth_request+0x1897/0x5e20 [thunderbolt]
  process_one_work+0x675/0x1230
  worker_thread+0x5e6/0xf70
  kthread+0x365/0x470
  ret_from_fork+0x54d/0x710
  ret_from_fork_asm+0x1a/0x30

 Freed by task 926:
  kfree+0x18f/0x4a0
  tb_cfg_request_put+0xb7/0xe0 [thunderbolt]
  tb_cfg_request_work+0x82/0x120 [thunderbolt]
  process_one_work+0x675/0x1230
  worker_thread+0x5e6/0xf70
  kthread+0x365/0x470
  ret_from_fork+0x54d/0x710
  ret_from_fork_asm+0x1a/0x30

 Second to last potentially related work creation:
  __queue_work+0x575/0xd00
  queue_work_on+0x77/0x80
  tb_cfg_request_cancel+0xc7/0x260 [thunderbolt]
  tb_cfg_request_sync+0x1f6/0x250 [thunderbolt]
  tb_cfg_read_raw+0x367/0x510 [thunderbolt]
  tb_cfg_read+0xec/0x240 [thunderbolt]
  tb_port_get_link_generation+0x258/0x420 [thunderbolt]
  tb_usb3_consumed_bandwidth+0x1c1/0x2c0 [thunderbolt]
  tb_tunnel_consumed_bandwidth+0xfd/0x910 [thunderbolt]
  tb_available_bandwidth+0x5f2/0xeb0 [thunderbolt]
  tb_recalc_estimated_bandwidth+0x2a0/0x1bc0 [thunderbolt]
  tb_handle_dp_bandwidth_request+0x1897/0x5e20 [thunderbolt]
  process_one_work+0x675/0x1230
  worker_thread+0x5e6/0xf70
  kthread+0x365/0x470
  ret_from_fork+0x54d/0x710
  ret_from_fork_asm+0x1a/0x30

The last stack trace is helpful because it shows that we are cancelling
a request and looking at tb_cfg_request_cancel() what might happen is
that tb_cfg_request_work() completes right before tb_cfg_request_cancel()
starts and because of this it will call schedule_work() queueing the
same work to run again. However, it is already removed from the
request_queue and reference count is dropped so when
tb_cfg_request_work() triggers again it will access memory that is
already released.

Fix this so that we first make sure a cancelled request is not handed
away from tb_cfg_request_find() or scheduled to run. Then instead of
relying on the worker to clean up the request we will do it in
tb_cfg_request_cancel() after the work is canceled from running. Make
tb_cfg_request_dequeue() release the request only if it was actually
removed from the queue.

Reported-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Fixes: d7f781bfdbf4 ("thunderbolt: Rework control channel to be more reliable")
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
[ sashal: Replaced guard()/scoped_guard() with explicit mutex locking for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/ctl.c | 47 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 7c070a58f4b95..36c64ed467d55 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -65,7 +65,6 @@ struct tb_ctl {
 #define tb_ctl_dbg(ctl, format, arg...) \
 	dev_dbg(&(ctl)->nhi->pdev->dev, format, ## arg)
 
-static DECLARE_WAIT_QUEUE_HEAD(tb_cfg_request_cancel_queue);
 /* Serializes access to request kref_get/put */
 static DEFINE_MUTEX(tb_cfg_request_lock);
 
@@ -123,11 +122,14 @@ void tb_cfg_request_put(struct tb_cfg_request *req)
 static int tb_cfg_request_enqueue(struct tb_ctl *ctl,
 				  struct tb_cfg_request *req)
 {
+	tb_cfg_request_get(req);
+
 	WARN_ON(test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags));
 	WARN_ON(req->ctl);
 
 	mutex_lock(&ctl->request_queue_lock);
 	if (!ctl->running) {
+		tb_cfg_request_put(req);
 		mutex_unlock(&ctl->request_queue_lock);
 		return -ENOTCONN;
 	}
@@ -138,28 +140,24 @@ static int tb_cfg_request_enqueue(struct tb_ctl *ctl,
 	return 0;
 }
 
+static bool tb_cfg_request_is_active(struct tb_cfg_request *req)
+{
+	return test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
+}
+
 static void tb_cfg_request_dequeue(struct tb_cfg_request *req)
 {
 	struct tb_ctl *ctl = req->ctl;
 
 	mutex_lock(&ctl->request_queue_lock);
-	if (!test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags)) {
-		mutex_unlock(&ctl->request_queue_lock);
-		return;
+	if (tb_cfg_request_is_active(req)) {
+		list_del(&req->list);
+		clear_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
+		tb_cfg_request_put(req);
 	}
-
-	list_del(&req->list);
-	clear_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
-	if (test_bit(TB_CFG_REQUEST_CANCELED, &req->flags))
-		wake_up(&tb_cfg_request_cancel_queue);
 	mutex_unlock(&ctl->request_queue_lock);
 }
 
-static bool tb_cfg_request_is_active(struct tb_cfg_request *req)
-{
-	return test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
-}
-
 static struct tb_cfg_request *
 tb_cfg_request_find(struct tb_ctl *ctl, struct ctl_pkg *pkg)
 {
@@ -169,7 +167,8 @@ tb_cfg_request_find(struct tb_ctl *ctl, struct ctl_pkg *pkg)
 	mutex_lock(&pkg->ctl->request_queue_lock);
 	list_for_each_entry(req, &pkg->ctl->request_queue, list) {
 		tb_cfg_request_get(req);
-		if (req->match(req, pkg)) {
+		if (!test_bit(TB_CFG_REQUEST_CANCELED, &req->flags) &&
+		    req->match(req, pkg)) {
 			found = true;
 			break;
 		}
@@ -496,8 +495,11 @@ static void tb_ctl_rx_callback(struct tb_ring *ring, struct ring_frame *frame,
 	 */
 	req = tb_cfg_request_find(pkg->ctl, pkg);
 	if (req) {
-		if (req->copy(req, pkg))
+		mutex_lock(&pkg->ctl->request_queue_lock);
+		if (!test_bit(TB_CFG_REQUEST_CANCELED, &req->flags) &&
+		    req->copy(req, pkg))
 			schedule_work(&req->work);
+		mutex_unlock(&pkg->ctl->request_queue_lock);
 		tb_cfg_request_put(req);
 	}
 
@@ -513,7 +515,6 @@ static void tb_cfg_request_work(struct work_struct *work)
 		req->callback(req->callback_data);
 
 	tb_cfg_request_dequeue(req);
-	tb_cfg_request_put(req);
 }
 
 /**
@@ -537,10 +538,9 @@ int tb_cfg_request(struct tb_ctl *ctl, struct tb_cfg_request *req,
 	INIT_WORK(&req->work, tb_cfg_request_work);
 	INIT_LIST_HEAD(&req->list);
 
-	tb_cfg_request_get(req);
 	ret = tb_cfg_request_enqueue(ctl, req);
 	if (ret)
-		goto err_put;
+		return ret;
 
 	ret = tb_ctl_tx(ctl, req->request, req->request_size,
 			req->request_type);
@@ -554,9 +554,6 @@ int tb_cfg_request(struct tb_ctl *ctl, struct tb_cfg_request *req,
 
 err_dequeue:
 	tb_cfg_request_dequeue(req);
-err_put:
-	tb_cfg_request_put(req);
-
 	return ret;
 }
 
@@ -570,9 +567,11 @@ int tb_cfg_request(struct tb_ctl *ctl, struct tb_cfg_request *req,
  */
 void tb_cfg_request_cancel(struct tb_cfg_request *req, int err)
 {
+	mutex_lock(&req->ctl->request_queue_lock);
 	set_bit(TB_CFG_REQUEST_CANCELED, &req->flags);
-	schedule_work(&req->work);
-	wait_event(tb_cfg_request_cancel_queue, !tb_cfg_request_is_active(req));
+	mutex_unlock(&req->ctl->request_queue_lock);
+	cancel_work_sync(&req->work);
+	tb_cfg_request_dequeue(req);
 	req->result.err = err;
 }
 
-- 
2.53.0

