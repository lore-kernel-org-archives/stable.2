Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B84AE12F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211362; cv=none; b=ZMk5ng34ZTpl2GI4ryX9LOjEqObnvQA6NVggDtIQ5BcACgy0XZFBJWmj6/fAX2tzg0M0682VLayZ2c+kH1TMZdWKw9/0RSzKUy23lVGO0p1HqZbPldJjDdDayaZ8opszp+M845KMKMyutLlGzlRdq/n+og0LFX8hy9U+Xbds9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211362; c=relaxed/simple;
	bh=b/kvS8l2Hb3kFzbK+OA3Ai+fxTjyJOjHGECSs4pIdxw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YNWUDQI3/I8bcuKdffhDe6DmAtGWPPoaXgHoP81oruksCx+BY+RVzpMJuW7r6njHZQo4G0Tgfn8pXkJuVeQxpzKgH8sH+Cqjtixn5Jlk2tZD3gHUUgWUNyGjmRorni9U2S7qQ4EujT3B1PAkN0GBHxPOrkoU3aThzlWvnsudJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VOkU+bqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VOkU+bqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9641F00893;
	Mon,  5 Oct 2026 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211352;
	bh=37PIrxdqhuWC742fBo22Lx7smDyGMr8DikQtsvDN5iY=;
	h=Subject:To:Cc:From:Date;
	b=VOkU+bquvEvFVqqF2KFxl/MZ4A5j0CpCxBxqR80k30U3fik40dLYthju5J0u3j/Lq
	 kfU21+iUt7oM4cfgvBlDpj2GwffnweNxDIicjcKeWkhcbOCZ/zu8OOrZ+p3tObOqP6
	 z0+LfVVSXjx7MX1cctYOcFc0IsYQE0q4physPBAw=
Subject: FAILED: patch "[PATCH] thunderbolt: Fix KASAN reported use-after-free when request" failed to apply to 5.10-stable tree
To: mika.westerberg@linux.intel.com,alan.borzeszkowski@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:42:21 +0200
Message-ID: <2026100521-impale-unsettled-8d6f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a02188ddc24b7872f0c5e0c5873f827318717803
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100521-impale-unsettled-8d6f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a02188ddc24b7872f0c5e0c5873f827318717803 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Thu, 7 May 2026 08:06:48 +0300
Subject: [PATCH] thunderbolt: Fix KASAN reported use-after-free when request
 is canceled

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

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index cd47b627f97b..965988b18608 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -73,7 +73,6 @@ struct tb_ctl {
 #define tb_ctl_dbg_once(ctl, format, arg...) \
 	dev_dbg_once((ctl)->nhi->dev, format, ## arg)
 
-static DECLARE_WAIT_QUEUE_HEAD(tb_cfg_request_cancel_queue);
 /* Serializes access to request kref_get/put */
 static DEFINE_MUTEX(tb_cfg_request_lock);
 
@@ -133,41 +132,42 @@ void tb_cfg_request_put(struct tb_cfg_request *req)
 static int tb_cfg_request_enqueue(struct tb_ctl *ctl,
 				  struct tb_cfg_request *req)
 {
+	tb_cfg_request_get(req);
+
 	WARN_ON(test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags));
 	WARN_ON(req->ctl);
 
-	mutex_lock(&ctl->request_queue_lock);
+	guard(mutex)(&ctl->request_queue_lock);
 	if (!ctl->running) {
-		mutex_unlock(&ctl->request_queue_lock);
+		tb_cfg_request_put(req);
 		return -ENOTCONN;
 	}
 	req->ctl = ctl;
 	list_add_tail(&req->list, &ctl->request_queue);
 	set_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
-	mutex_unlock(&ctl->request_queue_lock);
 	return 0;
 }
 
+static bool tb_cfg_request_is_active(struct tb_cfg_request *req)
+{
+	return test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
+}
+
+static bool tb_cfg_request_is_canceled(struct tb_cfg_request *req)
+{
+	return test_bit(TB_CFG_REQUEST_CANCELED, &req->flags);
+}
+
 static void tb_cfg_request_dequeue(struct tb_cfg_request *req)
 {
 	struct tb_ctl *ctl = req->ctl;
 
-	mutex_lock(&ctl->request_queue_lock);
-	if (!test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags)) {
-		mutex_unlock(&ctl->request_queue_lock);
-		return;
+	guard(mutex)(&ctl->request_queue_lock);
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
-	mutex_unlock(&ctl->request_queue_lock);
-}
-
-static bool tb_cfg_request_is_active(struct tb_cfg_request *req)
-{
-	return test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
 }
 
 static struct tb_cfg_request *
@@ -178,7 +178,7 @@ tb_cfg_request_find(struct tb_ctl *ctl, struct ctl_pkg *pkg)
 	mutex_lock(&pkg->ctl->request_queue_lock);
 	list_for_each_entry(iter, &pkg->ctl->request_queue, list) {
 		tb_cfg_request_get(iter);
-		if (iter->match(iter, pkg)) {
+		if (!tb_cfg_request_is_canceled(iter) && iter->match(iter, pkg)) {
 			req = iter;
 			break;
 		}
@@ -512,8 +512,11 @@ static void tb_ctl_rx_callback(struct tb_ring *ring, struct ring_frame *frame,
 	trace_tb_rx(pkg->ctl->index, frame->eof, pkg->buffer, frame->size, !req);
 
 	if (req) {
-		if (req->copy(req, pkg))
-			schedule_work(&req->work);
+		scoped_guard(mutex, &pkg->ctl->request_queue_lock) {
+			if (!tb_cfg_request_is_canceled(req) &&
+			    req->copy(req, pkg))
+				schedule_work(&req->work);
+		}
 		tb_cfg_request_put(req);
 	}
 
@@ -525,11 +528,10 @@ static void tb_cfg_request_work(struct work_struct *work)
 {
 	struct tb_cfg_request *req = container_of(work, typeof(*req), work);
 
-	if (!test_bit(TB_CFG_REQUEST_CANCELED, &req->flags))
+	if (!tb_cfg_request_is_canceled(req))
 		req->callback(req->callback_data);
 
 	tb_cfg_request_dequeue(req);
-	tb_cfg_request_put(req);
 }
 
 /**
@@ -555,10 +557,9 @@ int tb_cfg_request(struct tb_ctl *ctl, struct tb_cfg_request *req,
 	INIT_WORK(&req->work, tb_cfg_request_work);
 	INIT_LIST_HEAD(&req->list);
 
-	tb_cfg_request_get(req);
 	ret = tb_cfg_request_enqueue(ctl, req);
 	if (ret)
-		goto err_put;
+		return ret;
 
 	ret = tb_ctl_tx(ctl, req->request, req->request_size,
 			req->request_type);
@@ -572,9 +573,6 @@ int tb_cfg_request(struct tb_ctl *ctl, struct tb_cfg_request *req,
 
 err_dequeue:
 	tb_cfg_request_dequeue(req);
-err_put:
-	tb_cfg_request_put(req);
-
 	return ret;
 }
 
@@ -588,9 +586,10 @@ int tb_cfg_request(struct tb_ctl *ctl, struct tb_cfg_request *req,
  */
 void tb_cfg_request_cancel(struct tb_cfg_request *req, int err)
 {
-	set_bit(TB_CFG_REQUEST_CANCELED, &req->flags);
-	schedule_work(&req->work);
-	wait_event(tb_cfg_request_cancel_queue, !tb_cfg_request_is_active(req));
+	scoped_guard(mutex, &req->ctl->request_queue_lock)
+		set_bit(TB_CFG_REQUEST_CANCELED, &req->flags);
+	cancel_work_sync(&req->work);
+	tb_cfg_request_dequeue(req);
 	req->result.err = err;
 }
 

