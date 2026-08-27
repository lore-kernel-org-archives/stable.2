Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708C370D54
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804311; cv=none; b=tIthcFyRn0rA+zVQ83sGoIfjOf/TZ2Witxtu5NAyX2XoqLY1uCWPNszhP82YzSWLoe+nfVovuHfinzeBCvUD1KVmSYWo8ummGL2bnX7Yg+OFLh7B0pt8mlUTdJfKiiW97rc/hJCL3l2FGhY9HHfvNE81ChvxNUiac9Zq1trc9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804311; c=relaxed/simple;
	bh=uSMkf3RwzjItLUAPe9EhTmetvptyKOyoUUkhMvsgRCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PtJHTWwXKODlmr45Baf6W4iFPt9LA8Fy/kJ1UdFCspNShxGRYn7l0dsxG02n74HknRiP25iiCM82no7zA/cwKCuBadSqWw0AX4YhbLyrZqJ81CDhnTOmpdNzvPQpif+ff4GOg4YP5QyBBDEtMDUTXMaOwnCR8bQj4wSGUnaOenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw5dYrta; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw5dYrta"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso2369375e9.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 21:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787804308; x=1788409108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tSfRa8BgrZI/TGibDtUnpQi8XG0Nol/aLRpoLE1ncnY=;
        b=Fw5dYrtaeB3jCEnXs6TWFROTJIFbx+YCORThlSVQXWM3SrfXsEBICVbNTicynxwWRv
         LDwqg2OP4tL1PB5gBQ3XqZ1IqqEFAJUhxWQVyxeMR9lh7hcZ9OaaUhJjHiWVdrs9IOxW
         AYugMe4IkbEwSimVQbCWc68Hpx/rRO/ZBD8x5EDd26e9ubcMTgN/UJjJxW/95Ru0bMvC
         IRyugGf7WC1umwBsFdRQiYGQqEuYH4LyfVuRQx0sqlMLtvcZPnKqWNjAVMrfEI2dhQby
         3eoFFLTPzZWnkZzlNKTZrpWjoYKWLuT5mEJrHCA48vh5U9Irz7uM+CCcyAMR0Zjr+6oT
         ZBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787804308; x=1788409108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSfRa8BgrZI/TGibDtUnpQi8XG0Nol/aLRpoLE1ncnY=;
        b=KIOIORTiwO5MTnBSqjSe0p9k8pMI0h1HitUphQ+ZS8zQyYSTaBG8wlKRfSzggWO/J2
         UZ53zULOTaUr4ivgNBAW4LarsDcfzkGSJCUUzdOzLTq/HO1d8iGlFTH6Kr6UQ3VwyLhc
         QImQf/h38Ige1KX65PE8ZB3Z0t+cipyc1OMYz72ddQ+sknoUaSLTg2sK50/O4b9vLkX4
         2NXp+s1zeRqN6lqzuLP9X6Pay618mcUG4BcCWr5fZKNROxLmzKeNZWYZ21/b+tTRh1Kd
         SRLLpGXCjKYkuhHy0HLkBAq9VEvJhpKJc8KC4Ufyj//cGQ5feMFqXMLxowgSazEHpGWh
         EISw==
X-Forwarded-Encrypted: i=1; AHgh+RqH2LP1UQQ0GCHigrwj3PV1fB/oxGCCnDqFVlI9RaMD0OOurgabUWJvbZm0uhp23X4GZf2hW0E=@vger.kernel.org
X-Gm-Message-State: AFuF++lSsXusaPU+N2qB7YYW1i/xH6cFZIr29sLkBh9GFQ6p4gjQvpUH
	jTw8wO5L5ovU2XWbMqQC3lSNTR7XLA3LffLnd4MQckkCD7WLmAYkwJSI
X-Gm-Gg: AR+sD127TfpUNDLQv6vXundHj1fQcnnobFkVLV7wl2psmpdABbzCBosgKmalzBXu4Lp
	AJmBm2Mb2XPCQrFzhro1SdthNEF6a3KbHWhqgJe+MM+ZXcXzA4VaoiZ2XKmM2WYaewk38z0U04V
	ZTvqTTi0YTXPtKchWAT71Kh9DEwpmHu8Thh6eDRENekroz8326IwNWhQkLbOR37uF3y8DP0GoQq
	jZExX85ZFTz4D1AG0lAzn4lzsfsqdVWhmmR3S1qB3zE7o0nnFnbWq9mlT2f6tOK/WotKQS1L+B/
	8oGyXkr/tKFUr2JXRr4TkXeRFQBSeBfKcUOSRa2DRw00h4RaPh32DQtHwSSCy5dgGJkH3N4zHAh
	zMZnWheg3OeBg8rWnkUmKegk4e1A+ObFjc/AR00NFmS4eiL3Q/nxBYFD0gd+Xjqg9jp9QyEbp5s
	glKkzGdBIaytVXSLPdyxK/iKOR0uZu02ypNaEBHLRAG2V9FYzl7UPrptRyHGfclQ4vkrNaTUteO
	zxImBw9MqB2BbkcR73GZh/5KBK5xHIoqqGBrOcEts8FfYCVIDIxT6os9A8c6ZvPZRM1FGdlcEs/
	kiYJeeIxwnOt6a5hVR879JQ5Gw==
X-Received: by 2002:a05:600c:6088:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-499dc6f3248mr130645735e9.3.1787804307537;
        Wed, 26 Aug 2026 21:18:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-154-097.95.114.pool.telefonica.de. [95.114.154.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dd5616f7sm44613445e9.2.2026.08.26.21.18.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 21:18:27 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] klist: avoid accesses after waking klist_remove()
Date: Thu, 27 Aug 2026 06:17:08 +0200
Message-Id: <20260827041708.31682-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klist_remove() waits until a node is unreferenced so that its caller can
free the containing object.  klist_release() currently publishes
waiter->woken and wakes the waiter before its final accesses to the waiter
and node.  klist_remove() can then return, allowing its stack waiter and
the containing object to be freed or reused while klist_release() is still
running.  In particular, bus_remove_driver() can free drv->p while
__device_attach() walks the same bus klist with bus_for_each_drv().

On an arm64 Cortex-A72 system, an unpatched 7.2.0-rc3 kernel with
CONFIG_PREEMPT_RT=y and CONFIG_KASAN=y reproduced the bug through the
in-tree I2C/at24 path.  KASAN reported a use-after-free in
klist_dec_and_del() reached from klist_next()/bus_for_each_drv() while
at24 was being unregistered.

Clear n_klist and take a task reference before publishing woken.  Use
release/acquire accesses for that publication and wake the referenced task.
The task reference keeps the waiter task alive if it returns and exits
before wake_up_process().

Fixes: 8b0c250be489 ("[PATCH] add klist_node_attached() to determine if a node is on a list or not.")
Fixes: 210272a28465 ("driver core: Remove completion from struct klist_node")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
- Explain the use-after-free and document an in-tree driver path; drop the
  syzbot tags (Greg).
- Keep the mb(); removing it was NAKed before:
  https://lore.kernel.org/r/20220614144443.6566-1-wuchi.zero@gmail.com/
- Add an arm64 Cortex-A72 PREEMPT_RT + KASAN reproduction through the
  in-tree I2C/at24 driver path; the first run hit KASAN after 32 module
  unregisters and 397 device operations.

Link to v1:
  https://lore.kernel.org/r/20260825040408.59225-1-kmehltretter@gmail.com/

 lib/klist.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/klist.c b/lib/klist.c
index 332a4fbf18ff0..f133740b1c2cb 100644
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -36,6 +36,7 @@
 #include <linux/klist.h>
 #include <linux/export.h>
 #include <linux/sched.h>
+#include <linux/sched/task.h>
 
 /*
  * Use the lowest bit of n_klist to mark deleted nodes and exclude
@@ -187,18 +188,24 @@ static void klist_release(struct kref *kref)
 
 	WARN_ON(!knode_dead(n));
 	list_del(&n->n_node);
+	knode_set_klist(n, NULL);
 	spin_lock(&klist_remove_lock);
 	list_for_each_entry_safe(waiter, tmp, &klist_remove_waiters, list) {
+		struct task_struct *p;
+
 		if (waiter->node != n)
 			continue;
 
+		p = waiter->process;
+		get_task_struct(p);
 		list_del(&waiter->list);
-		waiter->woken = 1;
+		/* Publish only after the final waiter and n accesses */
+		smp_store_release(&waiter->woken, 1);
 		mb();
-		wake_up_process(waiter->process);
+		wake_up_process(p);
+		put_task_struct(p);
 	}
 	spin_unlock(&klist_remove_lock);
-	knode_set_klist(n, NULL);
 }
 
 static int klist_dec_and_del(struct klist_node *n)
@@ -250,7 +257,8 @@ void klist_remove(struct klist_node *n)
 
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (waiter.woken)
+		/* Pairs with the release store in klist_release() */
+		if (smp_load_acquire(&waiter.woken))
 			break;
 		schedule();
 	}
-- 
2.53.0
