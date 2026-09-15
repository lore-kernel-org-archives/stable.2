Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56978477280;
	Tue, 15 Sep 2026 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461188; cv=none; b=f55iW6ERSx+hunFutnV2jT3oNYg7dgMdJdHrjSwXjj7L7wfjaZF5p7O9dfKEU0ifrvzlE+TKNPZggZObbY/6YkC6WQniM5jk3/swkCRr7HWAwUlH5MCuqfgN0Z9zGT6gKEUS9VcsmnWZHyLmEFl1qNMlqPLcQ9+IO0tT2QLBIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461188; c=relaxed/simple;
	bh=54wSBEW+EhzqVtFbaMH00jb+rHZnRFDdB1tI01AWQGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e68eH/674/LdpkYHcPLSWwh5DbrjXPogQGNlMzIjBtV9i6WoxwRNcoWSJMYUSYXvSAarsQozgOCpy8/B8v/UhBolezhoi79j3oTxwfnpRPPIfQxmIfY2eKg0ZQ8RPWx2DgyMgPS7zftDNrxw+2XzBfHCBMMVSMciXzvSDH/i4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=qKeFMEZi; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=RpPSKvPo; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="qKeFMEZi";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="RpPSKvPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461179; bh=54wSBEW+EhzqVtFbaMH00jb+rHZnRFDdB1tI01AWQGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKeFMEZiutJi9+qhpHW8QF6F92//epP25uhEVkcSQoxlxk78s3Inq4WpcHtIyGTOh
	 17IZ7JnWa9GYNRkuShIPUyJxZmFFhgjMbZk/cl7qVxicm9O5tqBJQmFUy5onNASHHy
	 Lc+jnN7Wy8g5XSOf/X9HXTxQgDmT14RDZqQyOQcrM3am5yqV1I4VlBnmsxmobu/x5h
	 FlSXaFYVzAHMYe4g0N6MG0Xtc2cIDbaZ3j1j/4okdHl9wzJtPlHDsBPzUeoDGTwMl4
	 pG/0vEr8YZsIdA4/h33ZLRGUyjdHf0eRFYgwWlxGeNEnbZJlu1G3M+6cn0yDnhN7SC
	 A4+vmqpsoSF2w==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 3B77340BA2; Tue, 15 Sep 2026 09:32:59 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461178; bh=54wSBEW+EhzqVtFbaMH00jb+rHZnRFDdB1tI01AWQGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpPSKvPoeKQgvNZ3PKjEcR3weba/zZwDm9C/jeFPc8sEHLIBNRRQTvyLjhiJjrKFJ
	 iOolR3yMzJovi+F/S1jtpqeb2CI+EcSR5R0w0QLiGsfJsg1RuzwbB+PRMTIHkRH69X
	 zvC0A/i0NdRC+YnrKcddprTrTNCqfD9MDNFt3/pUH9Aj1EI9oQKgemAHatP5lxTlxO
	 VECMgVkyhGKwqqaZwENgbRVIscWm4T6JhU0pB2rZc2nQiqnG1o9qUDi7eRIoq9Vxxb
	 xyOQlPe01+eI3O6MVKahcxH5tdrRnLQ/DHTYxk8JR2aXkVCLCvnHjonsZTYmhY2jdv
	 VXTIhkGkr303g==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 2291340155;
	Tue, 15 Sep 2026 09:32:58 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/20] media: rc: Fix ABBA deadlock by making locks more fine grained
Date: Tue, 15 Sep 2026 09:32:13 +0100
Message-ID: <e0950481292d002958cc28e744742f0a84444e14.1789460680.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789460680.git.sean@mess.org>
References: <cover.1789460680.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ir_raw_event_unregister() function takes the ir_raw_handler_lock
first and then the rc_dev->lock. Other functions like change_protocol
do this in the reverse order.

This means that an ir decoder module unload and writing to the protocol
sysfs file can cause a deadlock.

ir_raw_handler_lock protects the client list, amongst other things.
Split this out into a separate lock so we can ensure the locking
order is always the same.

Fixes: 93cffffc18f6 ("[media] media: rc: fix decoder module unloading")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-ir-raw.c | 39 ++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index 54b323becb1f..75dee4a483d4 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -10,7 +10,8 @@
 #include <linux/sched.h>
 #include "rc-core-priv.h"
 
-/* Used to keep track of IR raw clients, protected by ir_raw_handler_lock */
+/* Used to keep track of IR raw clients, protected by ir_raw_client_lock */
+static DEFINE_MUTEX(ir_raw_client_lock);
 static LIST_HEAD(ir_raw_client_list);
 
 /* Used to handle IR raw handler extensions */
@@ -273,13 +274,6 @@ static int change_protocol(struct rc_dev *dev, u64 *rc_proto)
 	return 0;
 }
 
-static void ir_raw_disable_protocols(struct rc_dev *dev, u64 protocols)
-{
-	mutex_lock(&dev->lock);
-	dev->enabled_protocols &= ~protocols;
-	mutex_unlock(&dev->lock);
-}
-
 /**
  * ir_raw_gen_manchester() - Encode data with Manchester (bi-phase) modulation.
  * @ev:		Pointer to pointer to next free event. *@ev is incremented for
@@ -615,15 +609,18 @@ int ir_raw_event_register(struct rc_dev *dev)
 {
 	struct task_struct *thread;
 
+	/* Holding dev->lock could result in a dead-lock */
+	lockdep_assert_not_held(&dev->lock);
+
 	thread = kthread_run(ir_raw_event_thread, dev->raw, "rc%u", dev->minor);
 	if (IS_ERR(thread))
 		return PTR_ERR(thread);
 
 	dev->raw->thread = thread;
 
-	mutex_lock(&ir_raw_handler_lock);
+	mutex_lock(&ir_raw_client_lock);
 	list_add_tail(&dev->raw->list, &ir_raw_client_list);
-	mutex_unlock(&ir_raw_handler_lock);
+	mutex_unlock(&ir_raw_client_lock);
 
 	return 0;
 }
@@ -656,16 +653,19 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 	kthread_stop(dev->raw->thread);
 	timer_delete_sync(&dev->raw->edge_handle);
 
-	mutex_lock(&ir_raw_handler_lock);
+	mutex_lock(&ir_raw_client_lock);
 	list_del(&dev->raw->list);
+
+	mutex_lock(&ir_raw_handler_lock);
 	list_for_each_entry(handler, &ir_raw_handler_list, list)
 		if (handler->raw_unregister &&
 		    (handler->protocols & dev->enabled_protocols))
 			handler->raw_unregister(dev);
 
 	lirc_bpf_free(dev);
-
 	mutex_unlock(&ir_raw_handler_lock);
+
+	mutex_unlock(&ir_raw_client_lock);
 }
 
 /*
@@ -688,15 +688,24 @@ void ir_raw_handler_unregister(struct ir_raw_handler *ir_raw_handler)
 	struct ir_raw_event_ctrl *raw;
 	u64 protocols = ir_raw_handler->protocols;
 
+	mutex_lock(&ir_raw_client_lock);
+
 	mutex_lock(&ir_raw_handler_lock);
 	list_del(&ir_raw_handler->list);
+	atomic64_andnot(protocols, &available_protocols);
+	mutex_unlock(&ir_raw_handler_lock);
+
 	list_for_each_entry(raw, &ir_raw_client_list, list) {
+		mutex_lock(&raw->dev->lock);
+		mutex_lock(&ir_raw_handler_lock);
 		if (ir_raw_handler->raw_unregister &&
 		    (raw->dev->enabled_protocols & protocols))
 			ir_raw_handler->raw_unregister(raw->dev);
-		ir_raw_disable_protocols(raw->dev, protocols);
+		raw->dev->enabled_protocols &= ~protocols;
+		mutex_unlock(&ir_raw_handler_lock);
+		mutex_unlock(&raw->dev->lock);
 	}
-	atomic64_andnot(protocols, &available_protocols);
-	mutex_unlock(&ir_raw_handler_lock);
+
+	mutex_unlock(&ir_raw_client_lock);
 }
 EXPORT_SYMBOL(ir_raw_handler_unregister);
-- 
2.55.0

