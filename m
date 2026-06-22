Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CD3A452E
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122088; cv=none; b=ftQZ1QxR0IcjooOIZr2gTFeKGzSaHOXk74UB/EDJtY5nR8nzSB0lI4+lImRtRaYQm1/T3rwOxrqhQC7+fYQwCuQJn55RIpXyVN7eCxpMi5lRQNg/rS336N+jf3Z6+sEMzJyo0ApcO4EKhHjyukL9WY8xo36uYVZcHgqsFLTyOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122088; c=relaxed/simple;
	bh=oqiicfY4FIQX0iDyOzCrhT5s6dW5vq8a/rQ2+zX+FK8=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Kn8frrk4tQSx2KqmqR0fbVazGTCYLZlPRyLwEOZ9UYkEwTDuoiIZjlOjNJApQsCxeKdWe6x3xbLp7brqe0p66MyCLXhND3zv7IL2AXDiT/oVdVd6Ii0ZmtuNBHM005flc8Sqn9nP59fCU0gGp2XwxuF3IKCilTsBCUqm2fRReso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVavMTA+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVavMTA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B0F1F00A3A;
	Mon, 22 Jun 2026 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122085;
	bh=R4wbtXHQe1yBTxtj1741PuYiVyXqPIZKeMVUgFa2K6s=;
	h=Date:From:To:Cc:Subject:References;
	b=SVavMTA+B/GfaFmg3qrXLXQ0vAq1Wdlj8It6N7Dm1J3Xir2Ao0NY3fSqF9pAic0O/
	 ajos0FpOg1QZFOZ1idzA2XlclTai4AO9kkdRF76sqnSGVLGy4wYhqBulWXlAsUi4AD
	 UBmSCZL/3PmEjJqPXYtOCRl6QPldWx9bJ+Tm3WyvN0hOYhPdf2z6JsDWpnVVMr8WDT
	 8c2UuISdVJaDeo5XEvoQeozqAfGloXr6Ng1ZBewg4vZSEj469eAx827aQic5WMEhFX
	 L3Y7TWXoCPsq6sStUN2lBOqSgGIME7S3hQeizTHnSYVSCVN5nNWUF194k2oZGuK2xC
	 re/HKNovomR/Q==
Date: Mon, 22 Jun 2026 11:54:42 +0200
Message-ID: <20260622093321.585763770@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.18.y 2/4] debugobjects: Use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
References: <20260622093040.582177124@kernel.org>
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
 lib/debugobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 9d59b797d1b5..4343dc5e5c99 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -734,10 +734,10 @@ static void debug_objects_fill_pool(void)
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

