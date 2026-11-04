Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802736;
	b=ZszYzm+5DnIIVgiZUAXvw3v3DqbQOT1nZMjbXorGt3+qUF2+VO1oWLszJHPtwq8BNa2j
	 o6IRncnY7Tr3x2FndvmDsSiWm+fwqah3gfvYe19fcEdmGe0orM+GZnRjiz8BMFURCie7i
	 OwNpdQ+U0RP0UY/yRPe/x7JOlF3j1Lu5B5Nz/TNTDZEVVqg1P5Fi75wHXOnnQmPiWc+jz
	 aQghKKswUlLHpmhCYGVBYU1q3PqCL8yRRBh3B83V4pNkQYDzpk3aXvzYj6exEz+53pziI
	 MjipemXhygy1KUQR17ZoYuh8pRgEfPK4qJnL/Sm3dH0bTyMLkNlazIUzxwM4SO17gWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802736;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nYJHjcvU3C8ufKKarGHA8plCjwV6/fU4TEXnnxEEFBA=;
	b=qWp7J3K5e50dcolWn7G1aRDcpyh8oujmzolFHUiEgiTu4WbsADiI7UqpTuw7B+8dkoEI
	 0n5qQZKlRPN/C3lEiYeXIhdElMoHeQr4MP2a8Aq6P1USJzb9gHqJCet0xX5FGVUceCUKi
	 IfAJWG6wXkWfKEZVqCE7zA68quzZXcX9NwyNWOCA5sDyoszN2wST5ersM/qxjrMTb7FDK
	 DhzA+uyBYxNYKUOFnnf7pxV7DZl7hoOn14Fgh+FL3BNRvGOcc8Nmqqvx702or8cExi63J
	 Qk29048taRpAHKHvpLwUGtx4bAVBdTAgPE4ofjBAPSgWe4YrgeaBwyvJ1XVkV3EYiag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hBEOsepj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E4606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hBEOsepj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78581F000C1;
	Wed,  4 Nov 2026 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802736;
	bh=nYJHjcvU3C8ufKKarGHA8plCjwV6/fU4TEXnnxEEFBA=;
	h=Subject:To:Cc:From:Date;
	b=hBEOsepjoSYmKQI8Te5HuOzIlHAAPFlh5AazY5FoDhFBrSzwyK404wbr7ECV/dxXo
	 vCEmS2g+Ou3Kxo1ovjQp6zo7OieQCGM+l96PeZPVOI7lLta+TA8XZ/i3Wf9V4kCPj/
	 BzRAvu/WpPmn3r1SNJplX6Y8P0lhBA1/ccHUNq+g=
Subject: FAILED: patch "[PATCH] media: rc: Fix ABBA deadlock by making locks more fine" failed to apply to 6.1-stable tree
To: sean@mess.org,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:32:15 +0100
Message-ID: <2026110414-outsource-laxative-3178@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c6d68866ad8aa1e957a3e5a6ede971148f1e3d59
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110414-outsource-laxative-3178@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6d68866ad8aa1e957a3e5a6ede971148f1e3d59 Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Wed, 12 Aug 2026 15:46:42 +0100
Subject: [PATCH] media: rc: Fix ABBA deadlock by making locks more fine
 grained

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
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

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

