Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0112FF675
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474655; cv=none; b=BjzltTW7ntI/JdgiG9G/7KRfSJZpFhLuUPZAcTzFJ0pB2K+7mBQT1xuh6cjpx+RmscQZ86OANeOqetoM+hfpU2XF4/HL5CI73xcrAgNqdiHpypeO8LVHj3HYJECkV0D1cwjTrgK8rnvFRvoxel78txaFEGxV68QxjEAL+/sI9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474655; c=relaxed/simple;
	bh=M9z+qEZHjmQwV6/knKWEPprmMTNuUL97ShNztQDIEMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3ArQJeURefX/6jJCu33afecFcZ4DI0w8kOg1ssgHbWj7s2e9ZYN73y1kTZCMFpfu+zt0B8IzwBZ0SQg2pjuBKbbIsyYXlo+CiWqlrmWgIakcn1J3AcIRSE69PH/rHPAMLIo3yt1o6vOm5mCcoVJObghBwRLORvmHsgJC9Th24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDRh5CCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDRh5CCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42561F00A3F;
	Thu,  3 Sep 2026 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474653;
	bh=j24y1DloQWA69EzB9YpTEqGN94rEuy+RUrAJdOLuEt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cDRh5CCJTpBeAbKAqvF6ElKhiwomdQQ1iT6SeKQge9lxKVGFVtTsPmBla9d43sj0i
	 xVAwW3wvaWox6lOiH2hpJoslRIxeMKyXMSZr9Wd133q3HkYSQvP11zM7+PDzK+K0dU
	 t06H0ultZIKG7Rdwrw3U9UeGx2P8R4UiOz/o+/HdD4Gv7hmeEOSwWg8LlDw77Z44Kq
	 F/Cb/HOQNf1cokRF7BRRLV08i6ZdeUFjcXWHJ8ryxy5nbnSTn23U7RcouiByG4j25d
	 TCfPNtHiCoaiVVQvk1Yc97VTSOee4RTK/uHWlAp//77fn+Gcdj5cwYsry+bjyD6F+o
	 pR3aUay4XFRRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/7] mm/kmemleak: prevent soft lockup in first object iteration loop of kmemleak_scan()
Date: Thu,  3 Sep 2026 18:30:45 -0400
Message-ID: <20260903223049.1740340-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903223049.1740340-1-sashal@kernel.org>
References: <2026090334-dreamboat-playpen-3c4e@gregkh>
 <20260903223049.1740340-1-sashal@kernel.org>
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
index 1d59667fb24ee..276c8a1e2476f 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1411,12 +1411,16 @@ static void kmemleak_scan(void)
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
@@ -1431,10 +1435,32 @@ static void kmemleak_scan(void)
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

