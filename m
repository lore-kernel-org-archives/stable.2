Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844118;
	b=gdxOtFa/v6Fwg9jv+3Epr40uUhZDshmm4OHREOQTgA2Uogfld39J33aQLMqb5dNULXgj
	 WUuIxSOm65DiblVVWYUNis8ZaWsjQm9/tQeG9gjfy7uQx/MlfKmYKUcpiBlrC2GPPt8kc
	 tsVmusgYuZzinE/zpMW7IXfVU875lbDFnAAms+J3IQTotPYtn1nMgLQQUXPvOw8Y6wmRv
	 wTn3QzV9qH/XcieSacucsTYNgKTYtYw6gyFbE0uCy/zbXmrggevgPb5I+BhpOM5PHa0gJ
	 d+EI+T5QfZN7doWQ85AaTZ2t1UpqXjbUOkNpOyMY15PqibnM2Gf2u6xrIGr0pCuu7Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ELcgfz6ChtNwW6CDjkwXPF2lAOc+SLg0gHzUsi9Fyqw=;
	b=hfCL1NQw4co+ByvUMkbBDEdhwLHqjWo87KDmA5GW+iu3wUlR+wUr/Nrlm4IkHnEvGQm2
	 VdtzRIF1zHGsVVJ16e3Px5gHiriyqoozfy7YOhIVexooQXeD8eQ9CtQaQlxL42JwISW4p
	 6TFMpwvuB/HQ+oTFy0Un3VeepwHkYxJa14s3KFdQn4tJ2TE0ne7moiaiasfi+bJa0dHbG
	 2GtI11Q73WhcSZT3xFxAU22jNx8Mx7PyrD3gcYY0pjAEOHvU63e0SKFPpi94RlXYCEb8f
	 D5sUexYvY8HcN+9eNjv4UgHenYEG/r6Pms6M7BSAw4xpLGDFuNM1JVixVJq2+/eqinQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qer+Jy3K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEE606CC09
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qer+Jy3K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7361F000C1;
	Thu,  5 Nov 2026 02:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844117;
	bh=ELcgfz6ChtNwW6CDjkwXPF2lAOc+SLg0gHzUsi9Fyqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qer+Jy3KORxPBJgDrzsVtsIfgjHZayB8yRGCHNTThfE+zz8vVMi0XgnzHLT0j4Iia
	 Tl1wALkFo00sDWDWvUtilY/pegZgEa9OcGvZO7OOt/R6j7OLNLAqnEaxOIyRMzcvPv
	 zLn2wjcDtmTQF7wTAxtVlNadr2I9+CIeok9BicOJ6AqWvgODUlJ0SBg4p5zJp/Xqd+
	 NlnzUgO0ArufdO4oE2Frts+0QVkJDgtqCcsNTOuGqWmserrSHxGeGv5CySuWDiyL0T
	 RCR9UKgn5iOOUjiEW1IWX/wPvHtRRS4ihxQj+7ibGH9fRKu416M53bbGO5sDjgJzUY
	 7sBCpofY2trEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: rc: Fix ABBA deadlock by making locks more fine grained
Date: Wed,  4 Nov 2026 21:01:56 -0500
Message-ID: <20261105020044.1081944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110414-outsource-laxative-3178@gregkh>
References: <2026110414-outsource-laxative-3178@gregkh>
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
[ sashal: Retained ir_raw_event_free(dev) before releasing ir_raw_handler_lock to preserve the existing cleanup layout. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-ir-raw.c | 38 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index 16e33d7eaaa2d..d1c551aec63ca 100644
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
@@ -288,13 +289,6 @@ static int change_protocol(struct rc_dev *dev, u64 *rc_proto)
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
@@ -632,15 +626,18 @@ int ir_raw_event_register(struct rc_dev *dev)
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
@@ -664,8 +661,10 @@ void ir_raw_event_unregister(struct rc_dev *dev)
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
@@ -681,6 +680,8 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 	 * "device gone" is checked.
 	 */
 	mutex_unlock(&ir_raw_handler_lock);
+
+	mutex_unlock(&ir_raw_client_lock);
 }
 
 /*
@@ -703,15 +704,24 @@ void ir_raw_handler_unregister(struct ir_raw_handler *ir_raw_handler)
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

