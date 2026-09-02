Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8CE184;
	Wed,  2 Sep 2026 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334055; cv=none; b=QpKguoKqnYprDj+O1Qd7aXQFAe8pJWHAFC/xewlAP8ohZB/mXSUIzhm8XGnTlr5o3wKdCvHP8BaFFK6/Ry58GnbmFGGZ6eb9Ny1dKUeFbEoY7+20TCvz+F8wTGypm+V54nTIe6lacj7ve5CJ0ZBe91bXGowQIBK5dgkRnqYv1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334055; c=relaxed/simple;
	bh=DNWiDm4H2XWb4eP1USzQvIJMOQc1k2fnPNVjgHevJLw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FoB0bB5CzmOa1tTbmgm2ACRmZIUHmv8kIgdEHFLygS8GiWT+XKZGA6HYB+78cYvX69TiwdMf3iZRx6V+dQOtCRgyFsCLxf0+ZYMt0OA9sr/ljzW20Aqse2DWHUpnt0KI30+GeH6gZgI3wKgUQFYcY6XlzALDTjwMBAoHh9MqFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rLM7KaC5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1qpzLxwr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rLM7KaC5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1qpzLxwr"
Date: Wed, 02 Sep 2026 07:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788334051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kotBq/5p7JKbWW9EkDFw5DAgPNb/oqp7riDO6ars858=;
	b=rLM7KaC5f0GQu0rivU9kf1vI3zkEdSL5UmK2IBrvCAz2jwb7hUqHr+NCGeNd5HzePKHx0H
	95T+dH54Lqj3nN22c7vqdK9ixbvEdKNRHZ+ObuL5Hyb0iyEUnT9mB4tyS6UD0uqeZ/X2OY
	frvN1s+AMn2JWSviNBROrYPaTp0qfy/72i7vHTXlJSJwzq4V+YEvCssZINMxJX7TyiabvG
	nRoNRvnsLa9wL//33on56SEduarfXwL+2pt66T4z5mc/uvWDyxmT18bIcuh8ne9KLsx0mb
	wKtxnYqXYNYTQvREq2QQ0SpsEw5BYtAvz34YGw3GURl8hHdz3Zv6DEKmGG7IAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788334051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kotBq/5p7JKbWW9EkDFw5DAgPNb/oqp7riDO6ars858=;
	b=1qpzLxwrOHEIedeLxZCLBcg9kZNLwuHNlhgRATnm0vDCNqCCD/bcaGEHd81c6t2AlbaUKT
	6YuVXrOfc+kqh2DA==
From: "tip-bot2 for Yilin Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix use-after-free when perf mmap() revival
 races with the last munmap()
Cc: Kimi Security Team <bug-report@moonshot.ai>,
	Peter Zijlstra <peterz@infradead.org>,
	Weiming Shi <shiweiming@moonshot.ai>,
	Yilin Zhang <yilinzhang@moonshot.ai>, <stable@vger.kernel.org>,
	stable@vger.kernel.org, #@tip-bot2.tec.linutronix.de,
	6.18+@tip-bot2.tec.linutronix.de, x86@kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20260831162155.1437652-1-yilinzhang@moonshot.ai>
References: <20260831162155.1437652-1-yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178833404967.3717435.15960752495965741775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     58a8108bc73de0740d5b88150465d6690ea5f85f
Gitweb:        https://git.kernel.org/tip/58a8108bc73de0740d5b88150465d6690ea=
5f85f
Author:        Yilin Zhang <yilinzhang@moonshot.ai>
AuthorDate:    Tue, 01 Sep 2026 00:21:55 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Sep 2026 09:18:00 +02:00

perf: Fix use-after-free when perf mmap() revival races with the last munmap()

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
(default kernel.perf_event_paranoid=3D2).

Swap the order of the two counter updates: event->mmap_count is
dropped first via refcount_dec_and_mutex_lock(), so its 1 -> 0
transition and the ring_buffer_attach() stay serialized with
perf_mmap(). rb->mmap_count =3D=3D 0 then implies every event using the
buffer is detached already, so the result of the rb->mmap_count drop
can gate the remaining teardown directly and detach_rest is no longer
needed.

An earlier fix for this race from Kyle Zeng and David Lee takes
event->mmap_mutex around both counter updates [0]; here the not-last
close stays lockless.

Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_coun=
t")
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Weiming Shi <shiweiming@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/linux-perf-users/20260804060931.711308-1-david.=
lee@trailofbits.com/ [0]
Cc: <stable@vger.kernel.org>
Cc: stable@vger.kernel.org # 6.18+
Link: https://patch.msgid.link/20260831162155.1437652-1-yilinzhang@moonshot.ai
---
 kernel/events/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38..f027805 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7029,7 +7029,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mapped_f unmapped =3D get_mapped(event, event_unmapped);
 	struct perf_buffer *rb =3D ring_buffer_get(event);
 	struct user_struct *mmap_user =3D rb->mmap_user;
-	bool detach_rest =3D false;
=20
 	/* FIXIES vs perf_pmu_unregister() */
 	if (unmapped)
@@ -7060,17 +7059,18 @@ static void perf_mmap_close(struct vm_area_struct *vm=
a)
 		mutex_unlock(&rb->aux_mutex);
 	}
=20
-	if (refcount_dec_and_test(&rb->mmap_count))
-		detach_rest =3D true;
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
=20
 	/* If there's still other mmap()s of this buffer, we're done. */
-	if (!detach_rest)
+	if (!refcount_dec_and_test(&rb->mmap_count))
 		goto out_put;
=20
 	/*
