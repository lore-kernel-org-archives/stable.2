Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7EB3AAF5B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058727; cv=none; b=Ql8F3i5l9wdpsoVzGNoi1ef384g6yNWTXNz0dWP4cseNg3ufr6pRTUmbscobYCjDMDJBZzeJoTr/v13khwCAOXmOln8FfVPa4/qu0473EhPUSSN/L1Jbru1hWLH7E2F38VrqlnZa2MaDx5Eiiv7K7uMGWt40jcn7oFXJvaPFvkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058727; c=relaxed/simple;
	bh=20XYGRolyVaDa4tmt5fWA4f/9wSm/LqJjSTpw05nkZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqBPnIUOnTJs405bhpUgt9BOIrorLkJqYZxajboenCZk6LiNCLGJ8Yzqcp4hykL/76mKUJXW1BH3z6QfYuRq1I4tcrqLdFJmYed7rojVl56jUo4HAsH/SvwdBh/Lvgnnjs7nEXpFmzUH2VeprOg3QnkeNRjegyWfTJZxIf3o8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMb0OZEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMb0OZEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B53F1F00898;
	Thu, 10 Sep 2026 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058725;
	bh=FgD5BvbP/h0iyyQ1g9wNUCb5ZiBRHDWujdXHiu4wglQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMb0OZEoVjU+21rS7UX/rYYlsck62zhuxH7KcrZ91cA6ujIp9il6d81O03zS/Tx4a
	 OQDzK13bAEjGDZ4Ne6Q9pt4FUNErwNvIu24R1dBF2SrSoaQUCRhxMOQOwlOSO8dRd9
	 /XwM4PAYkSVHGNkpIYD8ibObi4+8yST+fX1gLYWWDC8+OYlY3a7efzpnz9P/NlaucB
	 +E9s6b/zYch+Qm0UjIoMvb3OEwqVINE6vYFXXfbH00esYYvjidWd2BVinm3jnBHz30
	 Ki/cneCOnm2AJJPVxnQuT19i3uCjrJgE/UuIdqSyvKwV/Y9Umskiy7Rn8oLE4ZGiLS
	 lJAUhOyAk9Utg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yilin Zhang <yilinzhang@moonshot.ai>,
	Kimi Security Team <bug-report@moonshot.ai>,
	Peter Zijlstra <peterz@infradead.org>,
	Weiming Shi <shiweiming@moonshot.ai>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] perf: Fix use-after-free when perf mmap() revival races with the last munmap()
Date: Thu, 10 Sep 2026 12:45:22 -0400
Message-ID: <20260910164522.1249555-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910164522.1249555-1-sashal@kernel.org>
References: <2026090946-pacify-trodden-af31@gregkh>
 <20260910164522.1249555-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yilin Zhang <yilinzhang@moonshot.ai>

[ Upstream commit 58a8108bc73de0740d5b88150465d6690ea5f85f ]

perf_mmap_close() drops rb->mmap_count *without* holding
event->mmap_mutex (the refcount_dec_and_test() right before the
refcount_dec_and_mutex_lock() of event->mmap_count). A concurrent
perf_mmap_rb() can slot its entire "revival" path into that window
(perf_mmap holds event->mmap_mutex for its whole duration, including
rb_alloc):

  munmap side (perf_mmap_close)          mmap side (perf_mmap_rb)
  -----------------------------------    --------------------------------
  rb->mmap_count 1 -> 0   (no lock)      (holds event->mmap_mutex)
                                         inc_not_zero(rb->mmap_count) fails
                                         ring_buffer_attach(event, NULL)
                                         rb_alloc() + attach new rb
                                         refcount_set(&event->mmap_count, 1)
  lock; event->mmap_count 1 -> 0
  ring_buffer_attach(event, NULL)
  ring_buffer_put() -> frees the *new* rb

The revival's refcount_set(&event->mmap_count, 1) is an invisible
1 -> 1 write: the close frees the just-revived buffer although the
other process still has it mapped -- a page-level use-after-free
allowing local privilege escalation to root by any unprivileged user
(default kernel.perf_event_paranoid=2).

Swap the order of the two counter updates: event->mmap_count is
dropped first via refcount_dec_and_mutex_lock(), so its 1 -> 0
transition and the ring_buffer_attach() stay serialized with
perf_mmap(). rb->mmap_count == 0 then implies every event using the
buffer is detached already, so the result of the rb->mmap_count drop
can gate the remaining teardown directly and detach_rest is no longer
needed.

An earlier fix for this race from Kyle Zeng and David Lee takes
event->mmap_mutex around both counter updates [0]; here the not-last
close stays lockless.

Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_count")
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/linux-perf-users/20260804060931.711308-1-david.lee@trailofbits.com/ [0]
Cc: <stable@vger.kernel.org>
Cc: stable@vger.kernel.org # 6.18+
Link: https://patch.msgid.link/20260831162155.1437652-1-yilinzhang@moonshot.ai
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b27d51a51ef37..76d048a488270 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6753,7 +6753,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
-	bool detach_rest = false;
 
 	/* FIXIES vs perf_pmu_unregister() */
 	if (unmapped)
@@ -6784,17 +6783,18 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		mutex_unlock(&rb->aux_mutex);
 	}
 
-	if (refcount_dec_and_test(&rb->mmap_count))
-		detach_rest = true;
-
-	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
-		goto out_put;
-
-	ring_buffer_attach(event, NULL);
-	mutex_unlock(&event->mmap_mutex);
+	/*
+	 * Drop references in reverse order of perf_mmap() to prevent
+	 * rb revival after rb->mmap_count reaches zero.
+	 */
+	if (refcount_dec_and_mutex_lock(&event->mmap_count,
+					&event->mmap_mutex)) {
+		ring_buffer_attach(event, NULL);
+		mutex_unlock(&event->mmap_mutex);
+	}
 
 	/* If there's still other mmap()s of this buffer, we're done. */
-	if (!detach_rest)
+	if (!refcount_dec_and_test(&rb->mmap_count))
 		goto out_put;
 
 	/*
-- 
2.53.0

