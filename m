Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847051;
	b=m/p/Zlz7+ffsCkpb3pCKEntz307pgDDk3ACjl8qL8MxbxmgrFsWxb5hPuSUWI6GuQkDJ
	 LpJhaqs/XZukUZaHzBHoQv42nexc3q9OYL7+0mFl3gwmcUgtXqSyH0etf/bbtUbml0qYP
	 dXxFAT679g6APQ6B3QFUkP2PNBLa7hrMyTPW68mccopOBBMV63x/1G7zqTnBpANzOnx62
	 RLLcehjCEKkjxseQBlRGUq1qRiEoY61/hTESSM6cbIirLJ2iZE5wBIm91mVuwQbkfj2ZA
	 kWybWAhftd1oKMjB4o4a+tU0e70SQLy5O11MN6HXCdfhIn2fSQFdZpIb5HLDi0Dr8tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hi1qcCC8EcE/ARzFL+mTdQwX6UWc+I7qO4OZRyVpPMA=;
	b=huFGU1YMYf5TZhn9jHCs72WRZ6UsEfRGvphGJlrRf25UyKNQUNsfjEcA19puoxGbutZZ
	 zWRirsE0YD14xC9k7pKz2p+wA1VzAIZH55jLDrwHgG+LDZzQe7Qwsuna0ryATOwbEW6lb
	 jZcO78rGDsSnrfvdPggftnfw6f3Nkq6TgVBxe9hxhwe5NpO0/YTS5/UNqZQcwwo+O4h6T
	 QolCYOj3nPQDXDEfFM7jd0puMCwToB/5ns8UWeGmbJGnewqHBr5KuNYSpMSNluIP+e6Gj
	 V2ZzWAIM/85vxOEC4cfREiufOPgPD221VmDZFQTbsxLWt2pGoyzV7gK34wfEGptruHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akIGX9QE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5EC606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akIGX9QE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37A41F00919;
	Thu,  5 Nov 2026 02:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847050;
	bh=hi1qcCC8EcE/ARzFL+mTdQwX6UWc+I7qO4OZRyVpPMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=akIGX9QE0/213DOiCBnK2qThOHUjCIRHBqoPyEioO5wqLPKEGAMMpcbsCIMlhQ26h
	 K4eRD8gd75xNxA++Z4Seo36UcS0K/7GwW0AzM8ZW9EAsGs4aAUjlkNVedoK8XB2tfw
	 3KKRPQzB7kH2KxhHZ+AhGNbgAznbiSLZshU1OorP8P53SEgz3ApHzGjwerByuVkz5v
	 PiSOqvlJPojsAvvT8NTMVR/dR/UNtvnmr5toI6hA5qM+DiBXr0D5tWb6oIZepnmT4/
	 h/Tx0jpstrCYtNe1VMWPiy3NbYjr1NOhJyL2GnZEIE9SfhtfBgr/fBU2VA7PMmoYUC
	 cAM0vQFGDmZrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: rc: Fix ABBA deadlock by making locks more fine grained
Date: Wed,  4 Nov 2026 21:50:48 -0500
Message-ID: <20261105025022.1173951-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110415-mocker-phony-91d4@gregkh>
References: <2026110415-mocker-phony-91d4@gregkh>
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
[ sashal: adjusted ir_raw_event_unregister() context for del_timer_sync() and the existing teardown sequence ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-ir-raw.c | 38 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index c65bba4ec4739..304cc47e781ed 100644
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
@@ -634,15 +628,18 @@ int ir_raw_event_register(struct rc_dev *dev)
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
@@ -666,8 +663,10 @@ void ir_raw_event_unregister(struct rc_dev *dev)
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
@@ -683,6 +682,8 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 	 * "device gone" is checked.
 	 */
 	mutex_unlock(&ir_raw_handler_lock);
+
+	mutex_unlock(&ir_raw_client_lock);
 }
 
 /*
@@ -705,15 +706,24 @@ void ir_raw_handler_unregister(struct ir_raw_handler *ir_raw_handler)
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

