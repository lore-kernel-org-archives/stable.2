Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360136A351
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122165; cv=none; b=pcZFwHU18xNJThCiUuK7pN3Y4/2b4ndldBWd7CrZ3Ams5fiJ0cSUv5qZfFHzazb3bWRKn56820SPkQP4kbVh7MBbiUzH69MdoUQeVcrzFdFsWFqyibNqpJAEvTNKbq4nRF64xj9J2rLQh+zFpyWTy3eulMZK3bh63qg49u1w6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122165; c=relaxed/simple;
	bh=Yo+XdXlxLoz5ZYa3j78M5XKfgXccjx38Une31IU2XJ4=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dqCgJeFVJKIpIl/1vA5MfJ3mIVxui82nzHuKVDCdiE9eXlYMCba13pzIA62QQZvieOLGPsbIzfoERuFxbRWmOlGhj1yeMTYbBo+M0bPLHu7IaCWekuSLs2eHfCDgPDsuG/OiDdWhGXRAWTT1d8VifKldKLgBYF4EpGChDzuRv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIIFu0C+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIIFu0C+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A06E1F00A3A;
	Mon, 22 Jun 2026 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122160;
	bh=sZ6eoOk2tITVjOI7lanlWM2UVaST5QCySFClfPM+Ea0=;
	h=Date:From:To:Cc:Subject:References;
	b=fIIFu0C+DSQzDHkwJAzfGG4Em8PoFpMpubZgQyPibzteZxawBMsm2aZCQgS/erTbf
	 W1ZstuBlw+fJ0bN/r1wlWVi9ScbRv/yUkkWOZdi0Eu6Hi1OhhcRe/WKH2VO6aT4T/g
	 2orf5u6O8qJmnJFBSofgZ+6G0dApIVd1Jj80K26/dbtiWQr1dJEwcZpnMBzCQIJCie
	 rZcpy503SQ96VzZDwe5z+oJetC848L406QIAM+MDwOPnM+zz3z5y5ULkzoU921syEp
	 lveHewW1s7w1sbqxQwY1TuzSoSccVK0pzZaKCe4SQpzp8dcxzlgvsxriPYyJX4NBh9
	 mZ9l7BM4ypKJg==
Date: Mon, 22 Jun 2026 11:55:57 +0200
Message-ID: <20260622094802.208050985@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.1.y 3/5] debugobjects: Use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
References: <20260622094345.511524619@kernel.org>
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
@@ -608,10 +608,10 @@ static void debug_objects_fill_pool(void
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

