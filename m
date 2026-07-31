Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE753E51D4
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496252; cv=none; b=my9D9eBXuGni6LREV1P2sc2b2RfTqEmPHbDrI3pkI+dnKMQSUmG1vZhS2NHV+TbZm8PZPytZ1CK3P2DKiZTDqqKkoe1vc0HFd+d8S3BaHgoc612j+4Nj+SdwlS3/dJIp+IFCa2Zx0Aop3o+y5ErHdGx6CbspLwEMJnsQ0cgA7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496252; c=relaxed/simple;
	bh=XLxEvXrH+mTTfn1Lts0xI4Lwp/p7mUYszlsfDZHQFLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSnP4IPP0GTJ+TcbZwLKalkc5s6m/ZQv1uLXqa4KFC+vAvbUXQuMAZ1WJFlKg6M4LqWRAGJTsN3AbHVgxPqf1r/6jBmvAlQv599r+pdlayFhsD1HS0Zq9o0zhee8ebZ2ykfEkGDJEOHBVfzLstJjxMjVGRBZ4q8gemM7dpN9P7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qcj7L92y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qcj7L92y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9C71F00A3E;
	Fri, 31 Jul 2026 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785496250;
	bh=76GoNaqxNXEK/7TfvUviPoxnknN+BHlpVGQQYoy6ABs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qcj7L92yLVexMORiaFU/udPGmgZwNd7t/SkmVwzhY91kLVAu3RIzTp7bgO2Co5+FP
	 Per0hxbhObGZekyVkrRJRO5t4RHzG9SyWcv7I8E+qYGwODafq3ZseQoF9v1XIF/PZ6
	 S7hh3J8y1zhyqRFoQAsQZg60QmTOxnV/DmbSAcduDwE3gkjjiH3a1pG+Zo26cQwitX
	 FXwZ/1VDUdIoLzt8NzuGYVE0qWZkm0kunepV2QKVm9jKm/GrFG3KhrH1mYgwrfLiet
	 eDjQvn6gWz4e17AB98YG1KfuO9X1f1y4Y4qVzMCVsrUuxctc+voLe8ahTtngaX1iak
	 9eb0Lzy1oGRqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] usb: typec: ucsi: Fix race condition and ordering in port unregistration
Date: Fri, 31 Jul 2026 07:10:46 -0400
Message-ID: <20260731111047.3593727-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731111047.3593727-1-sashal@kernel.org>
References: <2026072727-scarring-railway-c5d9@gregkh>
 <20260731111047.3593727-1-sashal@kernel.org>
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
 drivers/usb/typec/ucsi/ucsi.c | 62 +++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index b71c56f43780..73774cb9bf28 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1255,6 +1255,36 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
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
+	typec_unregister_port(con->port);
+	con->port = NULL;
+}
+
 static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
 {
 	u8 features = ucsi->cap.features;
@@ -1363,15 +1393,8 @@ static int ucsi_init(struct ucsi *ucsi)
 	for (i = 0; i < ucsi->cap.num_connectors; i++)
 		lockdep_unregister_key(&connector[i].lock_key);
 
-	for (con = connector; con->port; con++) {
-		if (con->wq)
-			destroy_workqueue(con->wq);
-		ucsi_unregister_partner(con);
-		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(con);
-		typec_unregister_port(con->port);
-		con->port = NULL;
-	}
+	for (con = connector; con->port; con++)
+		ucsi_unregister_port(con);
 	kfree(connector);
 err_reset:
 	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
@@ -1584,26 +1607,7 @@ void ucsi_unregister(struct ucsi *ucsi)
 
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
-		typec_unregister_port(ucsi->connector[i].port);
+		ucsi_unregister_port(&ucsi->connector[i]);
 		lockdep_unregister_key(&ucsi->connector[i].lock_key);
 	}
 
-- 
2.53.0

