Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E88003D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630661; cv=none; b=DMINK6wbgvkwMoH9NOM9bjX3XQ583qTWCzL86KVprkYkTA8nULR/jJz/mZIALxEyhzSGdnJUKZvxd1PBmsQNr+JIIu9u1WAbC1dGjoA6mhOA026LIl1oXhrkACH0kxVruUQLxY46KgZujqVbFGSr2PWUwAVZrtbIRH4BLPlovvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630661; c=relaxed/simple;
	bh=SoTvn6u1nBsHaKXnWNHeQ87Z/kyy/lzwbSFW5uKNLKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xlix3aNfUIVQ9tCDLwDHPNqpZQtD8qRIl/gVPpag9qFA9k9ejvKH5K+k4EmQYYk9lCHKmUp4y8/BAg/p8A51mX3plU0h4qQPDvtbONI2uh2cXslDKeS1E+mhqcRGpFfj6Rj8utuunV0NtbEr+xS/Ts1QyYaDBwpSr/NsIAdMjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvKj/ACu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvKj/ACu"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so5956777a12.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 21:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787630658; x=1788235458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIz1d+M2XopEmaZu4JMwJQJno6roCNCxkVfrOrxuSFI=;
        b=mvKj/ACugcyKt/F/1km4HzrIxX3rdOVBEaei48buJYQk3hRoHW0YMxFNDLYQYWcKFI
         VcQiFe/6iTmH+yLvIgP+dohIPoX80hAFJ8zN8zdzZtkASHxmJOhcv+gRu3dFZ8c1/gIs
         0NDu8Z26joB5A/fuVvdTFkRxc0pXrxckk4yq08KwSsfyc/A0DQnasEOxNiqfgaxyPMoM
         PkZu+fKK4QbyZGVyPfv7vUUVmp85gPdHIAaCoyKGGFyABccjPAKQ5bKGjs9YYfMBIArR
         xmSCnGxV4FqWmlBY5md1KhGYAvDeb+GIdQloXN5PBplRa51BcU8xxZkvF6SzUJmkHhtz
         XdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787630658; x=1788235458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIz1d+M2XopEmaZu4JMwJQJno6roCNCxkVfrOrxuSFI=;
        b=sDhkh+PR8ZaQihAiliBN+0CUyOfxULNVvrmubcvPaQSxvOjY11OlqIYHKhyRg236cT
         V6jaVDegAjupLkYZP9UcSfyIMiO+kZB/pBPou9t+pk9pKnFCpb3of5soVlCyDYM+vocz
         QobSRyPu0e0b3Dvr9BDXGZwiC9usOD0zjDhxjNmrAF4oW7NywfTnSeE0Hp6vfg/FSM1N
         iCxTGHI1NAmBq5k15XDmsz/yOvOeVHWY5Ms72UlqMS1wrA1ZAeR9gOmrfwVEV9x2kv+5
         uFLZtSeZY6PIp4CDsiBauf5XkBXLl2drrVcGjljQClU4H/61aCG5qdAj4CHDvY4H62Wb
         2how==
X-Forwarded-Encrypted: i=1; AHgh+RpPq0iNO7RQzPH4jNIlZUGHrT/35dPZxEBOPvpSk6PU57oxct5sjfwcV2V2ES9g2FwiEZHj1Zs=@vger.kernel.org
X-Gm-Message-State: AFuF++nPumMXdKoeRuWVzYkDAgkLOSyR0BEqqiQRyS1fQRfXHa4XCiCT
	3ZtOIVmhqV3R+IAn0+bxarp6JMOuXhIbZvnDrVO1CtS4dv+vqPDigFqkR4HvklqL
X-Gm-Gg: AR+sD11nspG2B2eF3ZzXA/GYdDDD2AMvLkrJ/cUJnB3tqlWiLrnb/KeeoSBPum3gOzP
	qOSfEsAu6lOiXVr0wUI1i6OB9NlQbFahTB62eyce4RtKm+aSL3sZkmrT3DgQHJTL34eMbLxcekX
	YEwqoWKNILe61+Tf36pL37zvh90oJ+r1KRfSyJYynWPCTjWMSlrJpuHj/G8N3O3eAAR/O93GdYs
	wOUv829Xx/afOjjs4CHfscMV3M0C7ZAPI8u7l2Ou1CBtD0x7LCwfyMti/rX1MW3DxM5EUvGBtSx
	JcHDkImkhioa31BDoVafEaRBk5wiB9l/qrthF2aIs9SsFWy0cebD8u69UzTYQBtXNTcascFlTn2
	AA8A8C73rbN6a3vMbAhDY/F02j2jiu/HWrBrU0mihE/NyK/pjqOtTIPn0tQCz2owGt3btZmLZhq
	hvj7PGK9QJ6VeDFrxY1W3pEuMZO18AbWs9mwOBkIAMGfC1Co2ROMU72Zo8d9no9s1b26xkdkpfT
	gwSQ+VLSEfUzK+DhhNfV8FxL8oDyKYjhj/njYgH2w2yDIfmNpl5nbB7Zhz2S40hnxgEJZfdKHtx
	m1vcG9aVLIOULICx6htbD3R/msUsCBYQH/PuxTBhXXf238rJBhWN4RXmj75QSVAepZvT
X-Received: by 2002:a05:6402:e09:b0:6a1:f95b:8cff with SMTP id 4fb4d7f45d1cf-6a42f14d945mr36628081a12.1.1787630657941;
        Mon, 24 Aug 2026 21:04:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-af54-b201-7419-a557-62e9-4d13.310.pool.telefonica.de. [2a02:3100:af54:b201:7419:a557:62e9:4d13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00108asm17474345a12.2.2026.08.24.21.04.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 21:04:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] klist: avoid accesses after waking klist_remove()
Date: Tue, 25 Aug 2026 06:04:08 +0200
Message-Id: <20260825040408.59225-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klist_release() publishes waiter->woken before its final accesses to the
stack waiter and node. klist_remove() can then return, allowing the waiter
to go out of scope and its caller to free or reuse the node.

Clear n_klist and take a task reference before publishing woken. Use
release/acquire accesses for that publication and wake the referenced task.

The task reference keeps the waiter task alive if it returns and exits
before wake_up_process(). wake_up_process() provides the full barrier
required by the sleep/wakeup protocol, so remove the explicit mb().

Fixes: 8b0c250be489 ("[PATCH] add klist_node_attached() to determine if a node is on a list or not.")
Fixes: 210272a28465 ("driver core: Remove completion from struct klist_node")
Reported-by: syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9cb1ac7fce4944ba9165
Tested-by: syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 lib/klist.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/klist.c b/lib/klist.c
index 332a4fbf18ff..7242f4cc1c1b 100644
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -36,6 +36,7 @@
 #include <linux/klist.h>
 #include <linux/export.h>
 #include <linux/sched.h>
+#include <linux/sched/task.h>
 
 /*
  * Use the lowest bit of n_klist to mark deleted nodes and exclude
@@ -187,18 +188,23 @@ static void klist_release(struct kref *kref)
 
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
-		mb();
-		wake_up_process(waiter->process);
+		/* Publish only after the final waiter and n accesses */
+		smp_store_release(&waiter->woken, 1);
+		wake_up_process(p);
+		put_task_struct(p);
 	}
 	spin_unlock(&klist_remove_lock);
-	knode_set_klist(n, NULL);
 }
 
 static int klist_dec_and_del(struct klist_node *n)
@@ -250,7 +256,8 @@ void klist_remove(struct klist_node *n)
 
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (waiter.woken)
+		/* Pairs with the release store in klist_release() */
+		if (smp_load_acquire(&waiter.woken))
 			break;
 		schedule();
 	}
-- 
2.39.5 (Apple Git-154)

