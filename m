Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD07363C61
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122122; cv=none; b=QTLXZwr0L4PCOImbdqNma0fBsib6alMyHNDKoY4hE5o5y3VqVpV1VdARksT/hXv1hJqSEvRyxWYR99WdH+vw28TnkUlRY+lGdHIGxAMXfhRzBzqPwAtYOSoAhMtEITBok4Zjc3byC2hGo90p/QS9fG+DC2OiqIQg2WDFg0Fs5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122122; c=relaxed/simple;
	bh=SOhInYWTQ5UtICjPJT3uiOdGUUbgCTBWgSVNrdikzMA=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VM+udLF+jj4fWYhX0Ss6wkLS3Fa0m/iMx+bPFx0yZpdXBs9jjXuc14rPVoJGU9rrTzPFMWpbtA6bS2+r4q3rYUC4cUwVDmARhltm2VFTFgdng+K1fTLEV1UuAMJs9GsP8RjJ/Ud67f+WIYecFxwMJeDVXSIBcS04/Aqcg7fwrmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC29BI8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC29BI8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C351F000E9;
	Mon, 22 Jun 2026 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122120;
	bh=ctv6fbdxaDpI+sI/V8Xf/PRR1bHYqCqUr36kISnx67o=;
	h=Date:From:To:Cc:Subject:References;
	b=fC29BI8nKAaKVOH9kjZ38OoJRGA2ZdE0cs6tv9MjGx1ADq27Cc6/yEsoJncumZ6AR
	 xudKHXwo45ikhi+S9sKKiXdXxeXtDbZ1J9rByCVPE33Z/sVbR+Ej3++51e9MVvU94h
	 vj4j6Uq+BtmYRmHFKo/xRLA8p5hzlgc8WMkK+EYcYlevlL8hwRSFC+HytrGhhiZZPv
	 6XVURlgw3ese4wgumgIwJaDVYjv9YkI2K1U5LwqEe5gqEYdlf+ISVXvMulM7VJzyFF
	 Pxu7LiOjqIjKqMLFskL+pDxVjDyLIxu4yz5X7ybjVQaGq7Y05c4Dd27Z3pR0B6v3GN
	 kJxjxXfjybX1w==
Date: Mon, 22 Jun 2026 11:55:17 +0200
Message-ID: <20260622092952.142642776@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.6.y,
 v6.12.y 2/4] debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP
References: <20260622092400.929691694@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 37de2dbc318ee10577c1c2704de5a803e75e55a2 upstream.

fill_pool_map is used to suppress nesting violations caused by acquiring
a spinlock_t (from within the memory allocator) while holding a
raw_spinlock_t. The used annotation is wrong.

LD_WAIT_SLEEP is for always sleeping lock types such as mutex_t.
LD_WAIT_CONFIG is for lock type which are sleeping while spinning on
PREEMPT_RT such as spinlock_t.

Use LD_WAIT_CONFIG as override.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127153652.291697-3-bigeasy@linutronix.de
---
 lib/debugobjects.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -607,10 +607,10 @@ static void debug_objects_fill_pool(void
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
-		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
+		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
 		 * the preemptible() condition above.
 		 */
-		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
 		lock_map_release(&fill_pool_map);

