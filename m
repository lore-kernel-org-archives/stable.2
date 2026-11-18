Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044811;
	b=gyR91WMGGFAHIoxkKuSVdgQ/YgEBNQ/o56ecMgNRKdT5TjmP/iR924d7pCz/ss5OXnT0
	 z8RsCCBdsyLYLmQ2//XzTwBffYNM2rKu/WRq8v9br3+YRyT3ga6RWpEQmSvittBr4eiEd
	 lnIHy7WQGFvGGq5FauMP/fQyhKVdevl8kV6tnT9ciza5pPRGirLeB0VCXDZBtx+LALmlp
	 Ouw9kdQMGXf5jacrplTt3XcsXvjuxZ54cTB54uQZsUWgzFRcDwhYTrDYSgLDH/KkkT8ef
	 qoh0kqyuyPadXMPPZr3Plodn12gQxjfq9PDrOLBlgs4qXIJf8w15azyL+mVgRnhadlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=PNUicm6w6p3F05spqUThapxYplTksbIeS4ZiNmAJwHM=;
	b=szu9RafdWLBC31M2axuSVFlZyJZNm2gCQYCZ8TNKCsI9/9nfynFAxtvoNf0ZJp625/5f
	 7J6WhinuRg5JFVRy5KFD9rZjVdtrKFkuP0Ur57Mg5Tcr0/z7S2pgLD25M1l3egS5ms/sB
	 d06OW1Kzfq1i5aJ2j2WvH4pyr10OFKZJ0CR7BIuW0zB5gY4g23ZRxl++Bu8EyD+CbOEvU
	 lo7U8KUGNG1oWs4REfJAOjWicyCFV2Xv0rb8O9sthyeGaYsYc4rhu3fkjAV/li8SDvLcq
	 1IvkjO0iVsMC1D9bVXIfMjH3Sq8ufy70eD0NEIrrCLm9rzOx5A3pUTvXFd7GksKuEBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=edera.io;
	spf=pass smtp.mailfrom=edera.dev;
	dkim=pass header.d=edera.io header.i=@edera.io header.a=rsa-sha256 header.s=google header.b=Fa77AbV5;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780560A2634
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1780560A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edera.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edera.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=edera.io header.i=@edera.io header.a=rsa-sha256 header.s=google header.b=Fa77AbV5
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0dba37a7fso15157137b3.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edera.io; s=google; t=1795044810; x=1795649610; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PNUicm6w6p3F05spqUThapxYplTksbIeS4ZiNmAJwHM=;
        b=Fa77AbV5Wz7hzzOU0fzCo9suZaYBeh40z4Tjp4SiV6DO9XX4y6E5RPqRuQFoI0bxsL
         p3RzJY+ASh3AGmK1B3TiIcaCmOgi6bpK7VNmP/HMDCIrg5NtqIrVM+/BmvXc/RvD9jmZ
         vYWWhJTSs3th4Z6NtNFrkWx5Fq9qzuQIIQoQFPYzhhvB5KbeQgRzpWlW9xEiGNN6KwN1
         v6tBoqIUebiQIys9KETnhSnMoyFDBzzNqNMg/mbuWJ4BnKXjFg8rH7uGU73fxnMiGPqp
         ZjllM5vkUxcR3zWULTcnbKSbiwFX2ZMiy69IdedjjV1x0cRqwimcukDe63aGY6z7Cuq3
         Qxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795044810; x=1795649610;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PNUicm6w6p3F05spqUThapxYplTksbIeS4ZiNmAJwHM=;
        b=wegs4mTc9czh1s+0S3DcSEu8huZkXljTM3seGI6sQ5rdLh929bU9QjqQf+TLzZRWTO
         4O+lFnUWZgStGgrrhHjZZBBl/8BopvK3rSamiG3p+vWbT25wav8xnAEwnqz6b0PPmfeT
         wG4V9YLbEHB3/qTAgjECmdNGfWhhwIpyDXwtLAc3Nkb7TT6X5EOiTO3DcDK1GwKDKH/J
         ETawwm9qs426JwyYcoskYsGLzGiNv9UUmpPnHisY4NZ0ePhHsPrq/Jd2e7BP50zPaGYc
         E7EK1SOIDzHl/BWtsPfD4OnyC1kB4LAm31bOn1IESHgh/On+e0lNngqgySNCg4d08ZQb
         CRvw==
X-Forwarded-Encrypted: i=1; AL+hErFN+WaUeCKH9fBJYvgYKISKbqncp1bWYIk0JeX0VHxblWdF/wZQ2vXBfQZmp3c1FCZnkI/wAvE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lmEdq9lOAoW2/HqdImBXJEoGPOyAztF7zDjDq8kg2Emh96kxE
	qEStJ1NkLIg3p8bxhhCNYoAbzwXflfFqtN+LebMixpg/WWdSvUo9W4nPUh9WYaWuFU0=
X-Gm-Gg: AZFdTZdF0LoUuQsyMNXwfmLoMgZasCMVijfVchc1mixPGzhb2acg7mZ1D4LqJZnlfr3
	EVlv4oeBXni1a+MseeGff7fdTCVchyQ5Vox6Co9ObYy5et/SyQvOsTXGP1q9+IPu+EBaDVn24Ps
	VejqUTQg5QT/YT5t2cDl5s9oe06zj0r0u7i+uDvSwwIQR7aDqL8RN6fqGlsl5qNsrnBlYPRE6us
	kg9arH20yT10WzE18bbFgwMQnwJ/T4eulguPVkgPMQtlWOLHLBJA2hJXpLTXcxW9ofmzqcqFUd0
	KrwhXZqcYD6cTMxfT48qBu23kkDj0NFXRMZSpSyonZ5RtYTYTwKpYnL0jzDbn7CaSfAKJAKZBMI
	tjlQcCxgQNdYSsFPC4KBtGJW+UpQN8U8aL7awycgZzsFssDxd0GS932BXSMi4feg3vVnbVRl4Zk
	3qTeISxYQ6sZWTj20K10TuNCcDLQ4mhXGiL3rEHz32Po5OztZL0o0faX2ykw7b/kLzDWswt+h9A
	1QqEDV/X52lLqC3H3YT2Kmbu9YjGvj2WXpHUyOdKJDrYgN2dTYIfSMhmHrYNYlRfJN5A6DLhkyS
	WFfzXz1w8Izzx8N+60ZNGUsAAgtOz9Pu
X-Received: by 2002:a05:690c:6990:b0:8a9:e801:231c with SMTP id 00721157ae682-8b4fecfa8f1mr13807737b3.20.1795044809832;
        Wed, 18 Nov 2026 15:33:29 -0800 (PST)
Received: from [192.168.1.113] ([174.80.170.224])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe07408esm25655797b3.22.2026.11.18.15.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 15:33:29 -0800 (PST)
From: Benjamin Leggett <benjamin@edera.io>
Date: Wed, 18 Nov 2026 18:33:20 -0500
Subject: [PATCH] xen/xenbus: don't deliver user replies under
 msgbuffer_mutex
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-bleggett-xenbus-transactions-mutex-v1-1-6669e3f54955@edera.io>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3NUQrDIAwA0KtIvhtWhZXhVcY+1KY20KXDaBFK7
 z62C7x3glJhUvDmhEIHK+8C3tjBQFqDZEKewRtwo5ustQ+MG+VMtWIniU2xliAaUuVdFN+tUsc
 U3OzGyd0XO8Jg4FNo4f5Pnq/BQAxKGEuQtP7oTnLbWFpHoV7hur6c6XP6lQAAAA==
X-Change-ID: 20261118-bleggett-xenbus-transactions-mutex-ca2d20625f10
To: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Benjamin Leggett <benjamin@edera.io>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795044808; l=6966;
 i=benjamin@edera.io; s=20260806; h=from:subject:message-id;
 bh=ikAauzb6a0/TX+AaZ3i5klnB/Enh22StcWv0nCHLJ5c=;
 b=RLLXy9iwdkw+0NAICJ6pY0UIbDJdVn2v9NrZpZkeQU7PkoPiDhV/PNyblSYbIINtz6MdRSlDM
 0Xgqwz+KA+EARPVQkN4W8z0ZLukGG01j+JOACoSonNQgjxlcKjV4Z/6
X-Developer-Key: i=benjamin@edera.io; a=ed25519;
 pk=prj3m3DtYeYw1akLHnM/sXm8eau0Ar/IO93YoYnOr+I=

Found this while testing, and wrote a little reproducer. Seems like the
guest kernel's xenbus thread is stuck waiting for a lock, so no xenstore
replies reach the guest once this happens.

The lock involved, from what I can tell, is u->msgbuffer_mutex in
drivers/xen/xenbus/xenbus_dev_frontend.c:

- xenbus_file_write() takes the lock. For XS_WATCH/XS_UNWATCH it keeps
  the lock while it waits for the xenstored reply
  (unregister_xenbus_watch() -> xs_talkv).

- xenbus_dev_queue_reply() takes the same lock. The xenbus thread
  calls it to deliver the reply of an earlier request on the same fd.

So if a fd still has a request waiting for its reply when it gets an
(UN)WATCH, the (UN)WATCH holds the lock and waits for the xenbus thread.
The xenbus thread waits for the lock, and at this point the whole guest
xenstore connection stops.

  sysrq: Show Blocked State
  task:xenbus          state:D stack:14672 pid:42
   __mutex_lock.constprop.0+0x3a2/0x9e0
   xenbus_dev_queue_reply+0x49/0x330
   xenbus_thread+0x221/0xa40
   kthread+0xff/0x250
  task:xenbus-unwatch- state:D stack:12760 pid:1353
   xs_talkv+0x27d/0x3a0
   unregister_xenbus_watch+0x171/0x320
   xenbus_file_write+0x491/0x670
   vfs_write+0x109/0x460
   ksys_write+0xc8/0xf0

This is reproducible by opening /dev/xen/xenbus, writing an XS_WATCH for
any path, then on the same fd write an XS_READ for that path followed by
an XS_UNWATCH, without reading the READ reply first.

Fix is the following:
 - xenbus_dev_queue_reply() needed the lock only for the transactions
   list.
 - That list now has its own mutex, taken in xenbus_write_transaction()
   and xenbus_dev_queue_reply().
 - xenbus_worker() keeps walking the list without a lock, because it
   runs after the last reference is gone.

On an unpatched guest kernel the first XS_UNWATCH never returns, and the
guest's watches stop firing. With this patch, a guest kernel built with
CONFIG_PROVE_LOCKING=y completes 100000 such rounds without a stall, and
lockdep stays enabled with the new lock ordered between the existing two:

  /proc/lockdep_stats:
   debug_locks:                             1
  /proc/lockdep:
   &u->msgbuffer_mutex
    -> &u->reply_mutex
    -> &u->transactions_mutex
   &u->transactions_mutex
    -> &u->reply_mutex

Fixes: fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Leggett <benjamin@edera.io>
---
 drivers/xen/xenbus/xenbus_dev_frontend.c | 46 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 61db6932a9d2..92ddc37311cf 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -89,8 +89,12 @@ struct xenbus_file_priv {
 	/*
 	 * msgbuffer_mutex is held while partial requests are built up
 	 * and complete requests are acted on.  It therefore protects
-	 * the "transactions" and "watches" lists, and the partial
-	 * request length and buffer.
+	 * the "watches" list, and the partial request length and buffer.
+	 *
+	 * transactions_mutex protects the "transactions" list.  It nests
+	 * inside msgbuffer_mutex, and xenbus_thread takes it alone to
+	 * deliver a reply, so a (UN)WATCH that holds msgbuffer_mutex
+	 * while it waits on xenbus_thread cannot stall that delivery.
 	 *
 	 * reply_mutex protects the reply being built up to return to
 	 * usermode.  It nests inside msgbuffer_mutex but may be held
@@ -99,6 +103,7 @@ struct xenbus_file_priv {
 	struct mutex msgbuffer_mutex;
 
 	/* In-progress transactions */
+	struct mutex transactions_mutex;
 	struct list_head transactions;
 
 	/* Active watches. */
@@ -369,7 +374,7 @@ void xenbus_dev_queue_reply(struct xb_req_data *req)
 
 	xs_request_exit(req);
 
-	mutex_lock(&u->msgbuffer_mutex);
+	mutex_lock(&u->transactions_mutex);
 
 	if (req->type == XS_TRANSACTION_START) {
 		trans = xenbus_get_transaction(u, 0);
@@ -391,7 +396,7 @@ void xenbus_dev_queue_reply(struct xb_req_data *req)
 		kfree(trans);
 	}
 
-	mutex_unlock(&u->msgbuffer_mutex);
+	mutex_unlock(&u->transactions_mutex);
 
 	mutex_lock(&u->reply_mutex);
 	rc = queue_reply(&staging_q, &req->msg, sizeof(req->msg));
@@ -413,7 +418,7 @@ void xenbus_dev_queue_reply(struct xb_req_data *req)
 	return;
 
  out:
-	mutex_unlock(&u->msgbuffer_mutex);
+	mutex_unlock(&u->transactions_mutex);
 }
 
 static int xenbus_command_reply(struct xenbus_file_priv *u,
@@ -453,6 +458,8 @@ static int xenbus_write_transaction(unsigned msg_type,
 		char body[];
 	} *msg = (void *)u->u.buffer;
 
+	mutex_lock(&u->transactions_mutex);
+
 	if (msg_type == XS_TRANSACTION_START) {
 		trans = kzalloc_obj(*trans);
 		if (!trans) {
@@ -462,24 +469,27 @@ static int xenbus_write_transaction(unsigned msg_type,
 		trans->generation_id = xb_dev_generation_id;
 		list_add(&trans->list, &u->transactions);
 	} else if (msg->hdr.tx_id != 0 &&
-		   !xenbus_get_transaction(u, msg->hdr.tx_id))
-		return xenbus_command_reply(u, XS_ERROR, "ENOENT");
-	else if (msg_type == XS_TRANSACTION_END &&
-		 !(msg->hdr.len == 2 &&
-		   (!strcmp(msg->body, "T") || !strcmp(msg->body, "F"))))
-		return xenbus_command_reply(u, XS_ERROR, "EINVAL");
-	else if (msg_type == XS_TRANSACTION_END) {
+		   !xenbus_get_transaction(u, msg->hdr.tx_id)) {
+		rc = xenbus_command_reply(u, XS_ERROR, "ENOENT");
+		goto out;
+	} else if (msg_type == XS_TRANSACTION_END &&
+		   !(msg->hdr.len == 2 &&
+		     (!strcmp(msg->body, "T") || !strcmp(msg->body, "F")))) {
+		rc = xenbus_command_reply(u, XS_ERROR, "EINVAL");
+		goto out;
+	} else if (msg_type == XS_TRANSACTION_END) {
 		trans = xenbus_get_transaction(u, msg->hdr.tx_id);
 		if (trans && trans->generation_id != xb_dev_generation_id) {
 			list_del(&trans->list);
 			kfree(trans);
 			if (!strcmp(msg->body, "T"))
-				return xenbus_command_reply(u, XS_ERROR,
-							    "EAGAIN");
+				rc = xenbus_command_reply(u, XS_ERROR,
+							  "EAGAIN");
 			else
-				return xenbus_command_reply(u,
-							    XS_TRANSACTION_END,
-							    "OK");
+				rc = xenbus_command_reply(u,
+							  XS_TRANSACTION_END,
+							  "OK");
+			goto out;
 		}
 	}
 
@@ -490,6 +500,7 @@ static int xenbus_write_transaction(unsigned msg_type,
 	}
 
 out:
+	mutex_unlock(&u->transactions_mutex);
 	return rc;
 }
 
@@ -669,6 +680,7 @@ static int xenbus_file_open(struct inode *inode, struct file *filp)
 
 	mutex_init(&u->reply_mutex);
 	mutex_init(&u->msgbuffer_mutex);
+	mutex_init(&u->transactions_mutex);
 
 	filp->private_data = u;
 

---
base-commit: 2b66f2cc753243a6adb3e9a5c038b0fc59ba7ec9
change-id: 20261118-bleggett-xenbus-transactions-mutex-ca2d20625f10

Best regards,
-- 
Benjamin Leggett <benjamin@edera.io>

