Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D156C656;
	Tue,  8 Sep 2026 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882858; cv=none; b=JXXXMz0J2xLrRTCfjr9A9eFrQDz7Cwiozs/FOH4nr64+GM09iLUjHIwTP2Y2yFBzRVcgf7BXpMF9jZKFwrcuM+Kjh20gdtlEv8uuTG/Kd9jFd+8MRuxjUOQ7oQgW1F1UDR74MtNTx0tXJt7hhH+7nHPpc53xyiLmZNWMm9ZH1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882858; c=relaxed/simple;
	bh=54wSBEW+EhzqVtFbaMH00jb+rHZnRFDdB1tI01AWQGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcFlEYTQwKO5hlWPycfaJXZ+9fR48n7PsEeuUlOKZgbU3CuQqBYV7Dnj27lecqpr2wsV2YafznjBjd6R+sWuF7bK+LQMqiy7lj9GpGCRyfkMqvWW4kF70Nt3cvEsiFZxa4jQ7Ed0hLHXBy66AuOQJOS1UQVGNpkmMGuV/iDdKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=l87XQ7Qn; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=OJ6i6+4C; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="l87XQ7Qn";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="OJ6i6+4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882849; bh=54wSBEW+EhzqVtFbaMH00jb+rHZnRFDdB1tI01AWQGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l87XQ7QnH0JE+gqwRE2gr6Mlj07oLI4pmgT1rthMTb5aq2YKYfjaj9IoKGPCv67SL
	 syiE0GYT7sRZqFe1+oRMV5VIgjsQjr8Aqvv+eRXJD5OVQwkGLtVnBsp3Ldx3+JEH+X
	 LgyU5bEAtstZ1TJvH0EGFuyr30FW/V+k9rEH3cvipc2yJVQ1WoYl/uL9i3dGTpf6jk
	 xswwjdHv9iBRGXS0OGOYnp0AA7P4YobGzOLmVqW0oY60dfw5Gx7lGw/jAI4V1TYKr0
	 hUA4SjUctpNafDpV4Yj7cY5r2eEdaYiNjciab8QWo13aK1gs223se84oLBIFN8uz4B
	 C/Uy+ENzLIXYg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 0CD644144D; Tue, 08 Sep 2026 16:54:09 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788882848; bh=54wSBEW+EhzqVtFbaMH00jb+rHZnRFDdB1tI01AWQGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJ6i6+4CJzAQfhKWamq0Rh4l92FRTyPlPfTnp6rjdmAuv0cMIREjFwsLFziTgiov5
	 WSxRfDSoIBJbj2iDtfovhpLaaFnfAwGjZifJdMvdBOHgMaUj2tcy0hLwTwgzb7tCjl
	 2k3MXrKFAH1ocucHaNGDi6jAAf3ifFLdf4q7MwfSYozjNvLZa9zeiWfEH7spxJiE/l
	 /BCh7ly/NgYfj/x6ApHY+yr/+X7NsNKtgCJurMPOt/otBccVWjbBx2iiWj3ytqYAg1
	 gZgdbo1S7R5f+DD+fyi3xUIFohS/qMCdux9TDIIgxfCtGtD9Tl2YhCjgNUbRrWFE/D
	 WexRmBZ4bc1iQ==
Received: from maru.home (host86-150-50-53.range86-150.btcentralplus.com [86.150.50.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 128B641450;
	Tue, 08 Sep 2026 16:54:08 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/19] media: rc: Fix ABBA deadlock by making locks more fine grained
Date: Tue,  8 Sep 2026 16:51:51 +0100
Message-ID: <7303eeb261f877e01107f77db5879bc62866ff24.1788882189.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788882189.git.sean@mess.org>
References: <cover.1788882189.git.sean@mess.org>
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

