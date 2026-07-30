Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839B46C843
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440346; cv=none; b=dtAUge2FjV53BcpD8f9qr2dW77sDCzXPDCPpkjhTfzRCxTilhfI10qZluPKuj3vbRQtlW2NSwFONGZpHSGqe4zvnqHJo/sm+H14/zxL1/QHoqBh9D6M83XLGI1YZm9UOdQINBntnckUf5miIMkHdRHR/2gQWsAsVmWLzL5CCYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440346; c=relaxed/simple;
	bh=2rilZPg2dFloAAP8UOREurQKQzCGfKHJfz3rLbzTx4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aC61aXdFhx8mce3jZTGgV8MaK5igPkumEv3VFQf8Xv0Fq8DnLUsuzxBfPUtMANqS8FMfIvWIO1+ZOVv9eJgYpUtbWl3fYQzRn0ziWpfZRWv1ZJhaaWIkedGjiSwxQToL/n3dcmrQQmrgQBoq/P17DLxCIl7Zhaw0xCGpecAcZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0XTF1Vj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0XTF1Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27F81F00A3E;
	Thu, 30 Jul 2026 19:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785440342;
	bh=zOD02eM+WEYViY3bc+BHyjAxsl6KCsE6BNFZFGTFdns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X0XTF1VjMxK7Y9UuSA2vRefhOee/RKpeOyNR2m5uAo1mYysdF8V0Th0mnsTkRIVz7
	 9W34meo01quAZE4PeK+yE6u2QSlU51uGwWP0pk2qyVLgw0H6qpNQD8CZM+i80MhAzB
	 eQx1zT7WRs2HIhYc3KD7tPHyag3z9mVk2X9OH/BcvkTwz11a7qIXpb7A/097BVhbo8
	 ZWklFbzXiOb1q2S11uSpcQ0NPL9CqhyDbdmJc5t6mJdgzf3GvK0dxOVaEBK22svon6
	 b6vuPjyzp15uqswA0PTf5+lci+sKzrfj1vuKjSbr1il6HGNyqJ/ShDgeIv7q/Q3zCY
	 r/rJnKLij6gbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] usb: typec: ucsi: Fix race condition and ordering in port unregistration
Date: Thu, 30 Jul 2026 15:38:59 -0400
Message-ID: <20260730193859.3130212-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730193859.3130212-1-sashal@kernel.org>
References: <2026072726-limit-wikipedia-5852@gregkh>
 <20260730193859.3130212-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrei Kuchynski <akuchynski@chromium.org>

[ Upstream commit 7aa7d4bf9d3fa9a6a47b640ad103ab433b7ff261 ]

A synchronization issue exists during port unregistration where pending
partner work items can race against workqueue destruction, leading to
use-after-free conditions:

  cros_ec_ucsi cros_ec_ucsi.3.auto: error -ETIMEDOUT: PPM init failed
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:__queue_work+0x83/0x4a0
  Call Trace:
    <IRQ>
    __cfi_delayed_work_timer_fn+0x10/0x10
    run_timer_softirq+0x3b6/0xbd0
    sched_clock_cpu+0xc/0x110
    irq_exit_rcu+0x18d/0x330
    fred_sysvec_apic_timer_interrupt+0x5e/0x80

Fix this by ensuring strict ordering and proper serialization during
teardown:

1. Move ucsi_unregister_partner() to the beginning of the teardown
sequence and protect it under the connector mutex lock.
2. Ensure all pending partner tasks are explicitly flushed and finished
before the workqueue is destroyed.
3. Switch from mod_delayed_work() to a cancel_delayed_work() and
queue_delayed_work() sequence. This guarantees that items currently marked
as pending won't be scheduled an additional time, preventing a double
release of resources which leads to the following crash:

  Oops: general protection fault, probably for non-canonical address
    0xdead000000000122: 0000 [#1] SMP NOPTI
  Workqueue: cros_ec_ucsi.3.auto-con2 ucsi_poll_worker
  RIP: 0010:ucsi_poll_worker+0x65/0x1e0
  Call Trace:
  <TASK>
    process_scheduled_works+0x218/0x6d0
    worker_thread+0x188/0x3f0
    __cfi_worker_thread+0x10/0x10
    kthread+0x226/0x2a0

To ensure these rules are applied identically across both the normal
teardown and the ucsi_init() error paths, consolidate the cleanup logic
into a new helper, ucsi_unregister_port().

Cc: stable <stable@kernel.org>
Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
Fixes: b13abcb7ddd8 ("usb: typec: ucsi: Fix NULL pointer access")
Fixes: fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items are flushed")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Benson Leung <bleung@chromium.org>
Link: https://patch.msgid.link/20260707141736.1635698-1-akuchynski@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 82 +++++++++++++++++------------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index e2d436eee7ac..89fb632f77d2 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1719,6 +1719,42 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 	return ret;
 }
 
+static void ucsi_unregister_port(struct ucsi_connector *con)
+{
+	struct ucsi_work *uwork;
+
+	if (con->wq) {
+		mutex_lock(&con->lock);
+		ucsi_unregister_partner(con);
+		/*
+		 * queue delayed items immediately so they can execute
+		 * and free themselves before the wq is destroyed
+		 */
+		list_for_each_entry(uwork, &con->partner_tasks, node) {
+			if (cancel_delayed_work(&uwork->work))
+				queue_delayed_work(con->wq, &uwork->work, 0);
+		}
+		mutex_unlock(&con->lock);
+
+		destroy_workqueue(con->wq);
+		con->wq = NULL;
+	} else {
+		ucsi_unregister_partner(con);
+	}
+
+	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
+	ucsi_unregister_port_psy(con);
+
+	usb_power_delivery_unregister_capabilities(con->port_sink_caps);
+	con->port_sink_caps = NULL;
+	usb_power_delivery_unregister_capabilities(con->port_source_caps);
+	con->port_source_caps = NULL;
+	usb_power_delivery_unregister(con->pd);
+	con->pd = NULL;
+	typec_unregister_port(con->port);
+	con->port = NULL;
+}
+
 static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
 {
 	u16 features = ucsi->cap.features;
@@ -1844,22 +1880,8 @@ static int ucsi_init(struct ucsi *ucsi)
 	for (i = 0; i < ucsi->cap.num_connectors; i++)
 		lockdep_unregister_key(&connector[i].lock_key);
 
-	for (con = connector; con->port; con++) {
-		if (con->wq)
-			destroy_workqueue(con->wq);
-		ucsi_unregister_partner(con);
-		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(con);
-
-		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
-		con->port_sink_caps = NULL;
-		usb_power_delivery_unregister_capabilities(con->port_source_caps);
-		con->port_source_caps = NULL;
-		usb_power_delivery_unregister(con->pd);
-		con->pd = NULL;
-		typec_unregister_port(con->port);
-		con->port = NULL;
-	}
+	for (con = connector; con->port; con++)
+		ucsi_unregister_port(con);
 	kfree(connector);
 err_reset:
 	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
@@ -2087,33 +2109,7 @@ void ucsi_unregister(struct ucsi *ucsi)
 
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
 		cancel_work_sync(&ucsi->connector[i].work);
-
-		if (ucsi->connector[i].wq) {
-			struct ucsi_work *uwork;
-
-			mutex_lock(&ucsi->connector[i].lock);
-			/*
-			 * queue delayed items immediately so they can execute
-			 * and free themselves before the wq is destroyed
-			 */
-			list_for_each_entry(uwork, &ucsi->connector[i].partner_tasks, node)
-				mod_delayed_work(ucsi->connector[i].wq, &uwork->work, 0);
-			mutex_unlock(&ucsi->connector[i].lock);
-			destroy_workqueue(ucsi->connector[i].wq);
-		}
-
-		ucsi_unregister_partner(&ucsi->connector[i]);
-		ucsi_unregister_altmodes(&ucsi->connector[i],
-					 UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(&ucsi->connector[i]);
-
-		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
-		ucsi->connector[i].port_sink_caps = NULL;
-		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
-		ucsi->connector[i].port_source_caps = NULL;
-		usb_power_delivery_unregister(ucsi->connector[i].pd);
-		ucsi->connector[i].pd = NULL;
-		typec_unregister_port(ucsi->connector[i].port);
+		ucsi_unregister_port(&ucsi->connector[i]);
 		lockdep_unregister_key(&ucsi->connector[i].lock_key);
 	}
 
-- 
2.53.0

