Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD936B901;
	Tue,  1 Sep 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272730; cv=none; b=jVouNfVfm/0F/xDMeLLQ7bpJYyChWQhgnr37Kkn42ZryH/AiR1USERui0/aud68y7cDvqWQH/MMqB8uu8BqlPyhAYhc45XXG24plmHYjB6qtkIe8byYnkzUkv8KJR17lwcZwI48nlzmQfuChba9YI6ReTB061JapScvQiR3yqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272730; c=relaxed/simple;
	bh=54wSBEW+EhzqVtFbaMH00jb+rHZnRFDdB1tI01AWQGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LL7xUhibHQoMuGdEgxFcdcCKU6+y5TO6X1SK45XxzlQpgjT1aMew9gKuRwUf5nFAoateeytMurHmymTESrj5vfmHtZiZfT9H4YZ1qGDCHushBksw9koYHQow/5aQdiPhc/gDwbLXEVU77VxCXPBc3Rcvr2XeTHzlnXEncRbjOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=D0cOPPw5; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Copar5zd; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="D0cOPPw5";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Copar5zd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272727; bh=54wSBEW+EhzqVtFbaMH00jb+rHZnRFDdB1tI01AWQGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0cOPPw5t1adGDgEEOtNKywdt2u7oq+SfGAWRrCBEme4cPLLy/CgTZTjQVBa9eNIb
	 Aj2c5oOo+7DVcJ2j84XMYkgZZdsvQ7ZXu22MJBLONdgCHjbvegvUGlHAJBoJnXIC7J
	 waAA510rsSN/jhUhs84vTHUCn+HRq7GldJTPv1KGBYjosQ5HylgDKkYNveVfXJgw0V
	 X4RIYs+sW4Iz/VZUoAyMiVrtn9xFNhT/z69vGRfix66sTPQhpcvHnjxBJX2HTiOl5L
	 yyPGV4Jy0y5UVp5lKuUlO98R7S1IqZDo0rxoRJHRr4PWW1VeOnxegsxOcYfWi2JkAe
	 5c+AUHjCPuPFQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 767BE41454; Tue, 01 Sep 2026 15:25:27 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272726; bh=54wSBEW+EhzqVtFbaMH00jb+rHZnRFDdB1tI01AWQGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Copar5zdog8ef4lf8D43QVo1QZCN3/Y50G1TEBV5J7JciEoG4TfpaV2O9SLQh9VU4
	 K6clQbFAwoybd5uWUA5OpA94qjuiFnuWucfaeBAeeNkdJ3F6A5lJNZkJuawmKBe6Vb
	 zwIDUiGOZ2fX3cacFxNCU0iNU9vhNv8gt2JjU83WCKr3TZywkp1pZqwjDLdbIYzqI0
	 DhGCmrfRmjhK59svMvVAyb7jeO3M8TdWd57753IRZKTJRAgefO2XQR9Amdw95gCQ1U
	 YoD3236I3NY7Jojsn9zGjPH6whHM46wge3aM0tBWWuN/KBXb4BDOpiduWxzu1P1JCs
	 JFfG/r1q868KQ==
Received: from maru.home (host86-128-233-22.range86-128.btcentralplus.com [86.128.233.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 8A2D14144B;
	Tue, 01 Sep 2026 15:25:26 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] media: rc: Fix ABBA deadlock by making locks more fine grained
Date: Tue,  1 Sep 2026 15:24:53 +0100
Message-ID: <f640f1266326b29814315cf1505f44de5bb20917.1788272198.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788272198.git.sean@mess.org>
References: <cover.1788272198.git.sean@mess.org>
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

