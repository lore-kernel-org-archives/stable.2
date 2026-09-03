Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A60386453
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461259; cv=none; b=WYm1y2rf/weIATWDllmfAiVp1ls1Qgi5OzVwfsj7AIv/8VjvxTczH+eIr7+v8eV4XPqGZg3BMkI2BxIS/kv6oXZAY9+lf2aETIdeKcdEzhqdwo8JJ+9h28ZL1BOxc4DVRDXYqCZP2lta1/LkJlJpn9jcWwyRAsO2pnqLRaOvZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461259; c=relaxed/simple;
	bh=OrzdtIHg1O7QHbi/P9pBk/tU9yeKrecL83x7SWQQj4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K594Iv/VtcWgcZ9ufBaG3FjvHl958eBgXD1lbp3e70M2vkkQ/aLkOxE/oD3G/l8HGKbpS9it8lZbQEk8vfDyXCauri7kWkcQ/trve9l5V4wncbo+UPQcfPZzpGyX4eGzhg74Gw2maQyC2Gz+1i0It9BCJMjYwBmmx+tsoNoCzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abmlioJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abmlioJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B5E1F00A3F;
	Thu,  3 Sep 2026 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788461258;
	bh=qr5vjsiHSuUVLXExWi2FPZRGg6ZZrYsQVSsKYMHDPMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=abmlioJhlpcfdvi8QcKpO1Dn3KEGTdlbtQ6iPuYGaZdPO2/L+zbR6KWvVUrkkUhpb
	 ZtafR37UuyzcDhxEkMlnk1zOrhZH+cvy5ulG03LAJZU0Wtsx5VrxApsStHuMlbJmRH
	 4EaLih5uA3Nd+LM6WZePFqALTH5RZ5yoSJ/eBr4GuWYODkAigKbvXpTHV0Nfj1yvcR
	 3SYgeDGe5ZLNP5b3YhfkIeNtIe+io849bUxirCFo3nPufWUB33mNZAeu1wtSzC/59M
	 TachsqBnV4fxFwinyJefQEsz359QMtHdQLxrXeSoT/2f7QDaoMz3NKHG23waXfqDRF
	 ycN4gE4EUvl+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/7] mm/kmemleak: prevent soft lockup in first object iteration loop of kmemleak_scan()
Date: Thu,  3 Sep 2026 14:47:29 -0400
Message-ID: <20260903184733.1484444-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903184733.1484444-1-sashal@kernel.org>
References: <2026090333-boney-opium-0272@gregkh>
 <20260903184733.1484444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 6edda04ccc7cfb281d139e352dbd5dd933bd2751 ]

The first RCU-based object iteration loop has to modify the object count.
So we cannot skip taking the object lock.

One way to avoid soft lockup is to insert occasional cond_resched() call
into the loop.  This cannot be done while holding the RCU read lock which
is to protect objects from being freed.  However, taking a reference to
the object will prevent it from being freed.  We can then do a
cond_resched() call after every 64k objects safely.

Link: https://lkml.kernel.org/r/20220614220359.59282-4-longman@redhat.com
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5d10d4e19e6d ("mm/kmemleak: avoid soft lockup when scanning task stacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index f7e12d12b5b8e..e52f0cbed6f2b 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1413,12 +1413,16 @@ static void kmemleak_scan(void)
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
+	int loop1_cnt = 0;
 
 	jiffies_last_scan = jiffies;
 
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
+		bool obj_pinned = false;
+
+		loop1_cnt++;
 		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
@@ -1433,10 +1437,32 @@ static void kmemleak_scan(void)
 #endif
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
-		if (color_gray(object) && get_object(object))
+		if (color_gray(object) && get_object(object)) {
 			list_add_tail(&object->gray_list, &gray_list);
+			obj_pinned = true;
+		}
 
 		raw_spin_unlock_irq(&object->lock);
+
+		/*
+		 * Do a cond_resched() to avoid soft lockup every 64k objects.
+		 * Make sure a reference has been taken so that the object
+		 * won't go away without RCU read lock.
+		 */
+		if (!(loop1_cnt & 0xffff)) {
+			if (!obj_pinned && !get_object(object)) {
+				/* Try the next object instead */
+				loop1_cnt--;
+				continue;
+			}
+
+			rcu_read_unlock();
+			cond_resched();
+			rcu_read_lock();
+
+			if (!obj_pinned)
+				put_object(object);
+		}
 	}
 	rcu_read_unlock();
 
-- 
2.53.0

