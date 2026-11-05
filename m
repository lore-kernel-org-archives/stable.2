Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881252;
	b=uCzfDer4nYLDGEc0Naye0Htq9JGudLwcwGlNDlCZLLphWxR4KUmSaMI2xV9DsX7FmqAW
	 GPKkB4WrEkBYSjYlbMBVntQGI/YKTlwBedZs9FShhqCy+A1Z9IL19Bzj6oqxGrDsIqEuy
	 oVYrNoQF+rXEUg9ZzeLaZX0PyC623tA2AzznRLiBHPaj7BKn00DUMOtjDzdVke+hKVlvG
	 jUnMF/fnWugJj8lVAMAVnouLpow75m1dgyWY7yp5DA+3C1WH1IgGNKvqSCAEpFbZ3OO/g
	 GMPCS/CFnbRyuP0dl9Hh2V/1LzukZUBH0p0RnEIhJoScpsymbwM3EkAjCtuES/nWK2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881252;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Knums40XXvOhxh70354koYPopqiwtaa7ppDUEvWAPfM=;
	b=OjrgCe/qdZEM9j2lWB5I/nOskeLXMrMMQYO3Cm3Yr/werX59qWOUp6t1bykzKNyab+Rm
	 XetdJcqUYlO6s6GM1t9fSS9KsEIlgFZt5bsQLATyZ8JaV02iDSIGGcdof7lpsPTC1CCW8
	 wyuOYvXDpZFT0t0pNpnXtsfO9T4lPrq4FQx/KrvhAI5ghBxHuwa15BxcQDWoj0VqUSSFW
	 RqbJ33A0vR80XlVB4o1D6XHwx3FbtgH5+L8HzWknL7eycr7pOK3puzUrPYYluX7svIXPm
	 hPPlY5dJlMydzvqHRLiGnBHVC0G0GPL3Z8+9Ztj8c9BSwUN1s3CNriU8xNt8jcjp5TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBct6Lbg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B2606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBct6Lbg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651931F00919;
	Thu,  5 Nov 2026 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881251;
	bh=Knums40XXvOhxh70354koYPopqiwtaa7ppDUEvWAPfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XBct6LbgsYAph1j627ORvtH7K/k1K5F3i1G4m4nL/9W0pOYxpve9L/pate/oQJ76g
	 +4JxINurCDKXVC4BeXZbVpC4W4SO7pH4Hlv6tEEZQ3pGaeXsZLQYwKul9o443XEhGO
	 6RGIM7kZm7xK+BKpdBQHHIG2zo+zcFUrEKv4SKfm0AvL2JVYFHdmE9Uws0CPrZ+VRq
	 htcC1xZUSx1W6FwM9/TfhruW4Zi/3/Oz0+j61VL4pKsL6WfsMjHnfh1SbGOpx0hv6T
	 91ZAOQEgYON1yiGQ2JOwHTpBSM3HqKi5PFR9XYfpZIHxYkrIx8dqoH4+5vnKOHwDRs
	 /ArCawOehpvew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: rc: Fix ABBA deadlock by making locks more fine grained
Date: Thu,  5 Nov 2026 07:20:50 -0500
Message-ID: <20261105121917.1229283-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110415-swiftness-afterglow-8cfd@gregkh>
References: <2026110415-swiftness-afterglow-8cfd@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Young <sean@mess.org>

[ Upstream commit c6d68866ad8aa1e957a3e5a6ede971148f1e3d59 ]

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
[ sashal: replaced unavailable lockdep_assert_not_held() with a CONFIG_LOCKDEP-guarded WARN_ON(debug_locks && lockdep_is_held(&dev->lock)) check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-ir-raw.c | 40 +++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index c65bba4ec4739..d5f960b3d1a47 100644
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
@@ -290,13 +291,6 @@ static int change_protocol(struct rc_dev *dev, u64 *rc_proto)
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
@@ -634,15 +628,20 @@ int ir_raw_event_register(struct rc_dev *dev)
 {
 	struct task_struct *thread;
 
+	/* Holding dev->lock could result in a dead-lock */
+#ifdef CONFIG_LOCKDEP
+	WARN_ON(debug_locks && lockdep_is_held(&dev->lock));
+#endif
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
@@ -666,8 +665,10 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 	kthread_stop(dev->raw->thread);
 	del_timer_sync(&dev->raw->edge_handle);
 
-	mutex_lock(&ir_raw_handler_lock);
+	mutex_lock(&ir_raw_client_lock);
 	list_del(&dev->raw->list);
+
+	mutex_lock(&ir_raw_handler_lock);
 	list_for_each_entry(handler, &ir_raw_handler_list, list)
 		if (handler->raw_unregister &&
 		    (handler->protocols & dev->enabled_protocols))
@@ -683,6 +684,8 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 	 * "device gone" is checked.
 	 */
 	mutex_unlock(&ir_raw_handler_lock);
+
+	mutex_unlock(&ir_raw_client_lock);
 }
 
 /*
@@ -705,15 +708,24 @@ void ir_raw_handler_unregister(struct ir_raw_handler *ir_raw_handler)
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
2.53.0

