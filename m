Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6C4229D8
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433872; cv=none; b=VL1wmzenKuwonD9aMphDTkX/kJ2BMM+wHdsqbip6HxWXxw1J05lSoEThQ/N0h0uJOwW+yhurArWs1NGdYPpRlpQV5I7wnRdBzVEffBJyfIPdJZMAOKK1/c1qMqarOS3ZUFIQLGcVHFynyh3yJqLe46GqNnF3/1TVS9gn/th5Xts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433872; c=relaxed/simple;
	bh=JNRMrbb5OEze61V+JypFOazAcSxi7/13i/xrfkhYpUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKGDe7PT89ey7WjiVMoPLwC0Yhk+xy48AVQ0dQO6ly53ylHryVtPu8Hcd+Q7t/pnQhkyqfEuH28squWVG8wnYCMnVAPJ/xYlo4rmLESmYRc06qm+G1jxitNHZLujymcJEOnRri9llwtAj3zpOVSzWyv+JVtwW9CgYjkacDtHtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MIXsec/a; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MIXsec/a"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1276b8c7e2so433176466b.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783433861; x=1784038661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHI2Oy1d15fEP4M9liye51QpOZL8T3aeN/VQtQoMGgQ=;
        b=MIXsec/aVbobYu/Uf9o86l7StzmlDAOuk/H/lELvIfJjPT4xU0xZ5b3Uo4zqD2x9hr
         qRp/p25n2EzvQRi2wxuwZRpqvBstTuZ00l4nGeBxkWnNRR/iLILxX9jmFZMaxYZZ7miV
         qFaP3kSH//FU3hktZt+aGuYxtG0076WkUzPAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783433861; x=1784038661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHI2Oy1d15fEP4M9liye51QpOZL8T3aeN/VQtQoMGgQ=;
        b=BOez9XKzP37sQXtepNQqmeWzldG0UGfAb+77SZatSPl0o6GixU9hfYxsFJX153eTMh
         8bz50XzqyyEHy8LJV2tAeYO1WdnQWOHX6cesFn8RkLhsA5RLqRlJWdPDqhq+1HSmXqUy
         D6AI72uCanQMoVOBlnEt/eZBNYs0RS9gg49/cEefliMSJR26hmsQO7ZcHP2xH/j/YL/e
         1DVKdVEBE/lCtRYj8GjlwSR7sCLGylIGvhpnSh4UFle0aNFoO07iLXa1ZLb3FZG8SL0G
         b40ZGbKMsaDFajgict0nPXDMThmM3K+71/yls/nzP2nvb8KUetaAPBK60Gj+CrudXLYV
         ka2A==
X-Forwarded-Encrypted: i=1; AHgh+RpmrMHb2aiytH6jr1WGIqGHuvqXavunQ3yI8N/GFJSHOs+2jthBbkAxKSu0vtyBwOtSxtTjufY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PbL4ymOT+9Pb8vlKa3J81IS3Yqc8+f5bX1mRAd7UJy8aUAl9
	lRerluv2n+VelHpE0RtHLV/DFJVU2QTa9yJfgWxliPjRFkV6r3BOdcqqNbD8LB99Mw==
X-Gm-Gg: AfdE7cnQ5ipy7/2FLd4VvmreEqJxLGwegyvMjUExZDE5tytTo9PqNONY8shSKvblkNs
	ult95zRQOV2XGgoofAU9jAGfCedP+dnUVkD2u9b93Lcoke7EpuzaGZdPw0Kko8w/k9XUVA2wRLW
	INIVGY/bRPSadf9GSKOyME4Vg8+zzmAuftjeAJBQpav0k5BVEJfuZ8NixE3vxSlHu4KVNSLPral
	3z5MJZh8SbdLhEEV/6agl/u2RVij9sZIfKe4C5nYfQv5EsFAex/TD5PgzkFROspzYYoYEdCn6Y7
	uuva8udqcNVPPU3oZtSSoqcWrHtwcUSljRpg/4t+72Z3nUz7clTSpn7kkxqEcqjoyU6vJoDfCBh
	MOe76Uf/o/+wOXQ0gtq32fJb4MPLakU8c4Gl1IAeg6LbuJNWpZ/0c4EiEZ6FjdoP1SvxjZ+hemi
	xiX3Vsb+VJQimTKKF4EOMA57X9rm5GUtMCaGEWm2Mn2vFRwuPYqmd1xp9LU0KIapQYo2j2/Jp0C
	lblNaU4EQ==
X-Received: by 2002:a17:907:d301:b0:c12:c936:86f6 with SMTP id a640c23a62f3a-c15a676c68amr319735666b.12.1783433861112;
        Tue, 07 Jul 2026 07:17:41 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (12.127.147.34.bc.googleusercontent.com. [34.147.127.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad882342sm144491666b.28.2026.07.07.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:17:40 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Johan Hovold <johan@kernel.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Fix race condition and ordering in port unregistration
Date: Tue,  7 Jul 2026 14:17:36 +0000
Message-ID: <20260707141736.1635698-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Cc: stable@vger.kernel.org
Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
Fixes: b13abcb7ddd8 ("usb: typec: ucsi: Fix NULL pointer access")
Fixes: fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items are flushed")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 82 +++++++++++++++++------------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 92166a3725b16..d9668ed7c80ea 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1845,6 +1845,42 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
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
@@ -1971,22 +2007,8 @@ static int ucsi_init(struct ucsi *ucsi)
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
@@ -2194,33 +2216,7 @@ void ucsi_unregister(struct ucsi *ucsi)
 
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
2.55.0.rc2.803.g1fd1e6609c-goog

