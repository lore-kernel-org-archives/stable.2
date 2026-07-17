Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3441BA68
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296829; cv=none; b=sTJFEG69M5+gna8lhGuaaf3sPckuweeFtxIWnTzKVuDMYu47rj9QWf29D/vjjEPKWi+0efcnurqjFQiaIMlEiWFUWcPejVWLfUmUbVGvV/IMofN9mzRVRCwQ9OVniDok8QE77acSEQgO9YoArxNjqjASC8C8cSXy2HeniUWkMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296829; c=relaxed/simple;
	bh=35SzOfw12CkKN2xKbdQN+5Y1yMAtdOwlxv1IeMDyXLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9avuiuUN+FiAv66bBCw5O6I9KufEfaGKBT6x6vkdj2psBcfUAs5YDyltIx/XuYXoYLKR98DYioFgPXXVZRJUy/FCS8YoyxvZkv66zX/Xu+p/Gpvuysr4iEVObESwA/4ddkcxu3i3F25/AMsS82yS+EfdS4pQf1TF1Sc8d9h5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkNf1YQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkNf1YQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8531E1F000E9;
	Fri, 17 Jul 2026 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296828;
	bh=6PlOI7oQA8wHElqK94GEkQYcnDr1ErFEWIWIqvhq19A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RkNf1YQwXgoMGPjoJXi/jvEozK/+aDOIZ5ddRrhNMhXGE7SYemyDQ136sg3JIx3LR
	 R340R0ppplajMaNCvl8pjw4HLGw9ck2BLEww8+p9cC9GHHLXUPPBfWEd75PvyyWZnL
	 OMThu0R574MhIatUSNplvxW9m1rqSZDJ+QG4wLxAi3MPg4CbdWeLwfrfwpNc8kJE2j
	 G10rvUafJNT/egVpHPBX7p6zbeOY8uJDKBYhSysCqYhJyMc/gYMF5tV1HaLKvhIf/k
	 qI3IlElooP5RdFlYmpDp1AnFRaDdtd3jMh7rNTSyoURHx1N8FOjJCvSAUGltL0WC/i
	 baXR3Mx10f8ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] seqlock: Introduce scoped_seqlock_read()
Date: Fri, 17 Jul 2026 10:00:23 -0400
Message-ID: <20260717140025.1717514-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071445-sadden-utmost-ad28@gregkh>
References: <2026071445-sadden-utmost-ad28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit cc39f3872c0865bef992b713338df369554fa9e0 ]

The read_seqbegin/need_seqretry/done_seqretry API is cumbersome and
error prone. With the new helper the "typical" code like

	int seq, nextseq;
	unsigned long flags;

	nextseq = 0;
	do {
		seq = nextseq;
		flags = read_seqbegin_or_lock_irqsave(&seqlock, &seq);

		// read-side critical section

		nextseq = 1;
	} while (need_seqretry(&seqlock, seq));
	done_seqretry_irqrestore(&seqlock, seq, flags);

can be rewritten as

	scoped_seqlock_read (&seqlock, ss_lock_irqsave) {
		// read-side critical section
	}

Original idea by Oleg Nesterov; with contributions from Linus.

Originally-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Stable-dep-of: 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/seqlock.h | 111 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5298765d6ca482..60ba4535358429 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1186,4 +1186,115 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 	if (seq & 1)
 		read_sequnlock_excl_irqrestore(lock, flags);
 }
+
+enum ss_state {
+	ss_done = 0,
+	ss_lock,
+	ss_lock_irqsave,
+	ss_lockless,
+};
+
+struct ss_tmp {
+	enum ss_state	state;
+	unsigned long	data;
+	spinlock_t	*lock;
+	spinlock_t	*lock_irqsave;
+};
+
+static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
+{
+	if (sst->lock)
+		spin_unlock(sst->lock);
+	if (sst->lock_irqsave)
+		spin_unlock_irqrestore(sst->lock_irqsave, sst->data);
+}
+
+extern void __scoped_seqlock_invalid_target(void);
+
+#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000
+/*
+ * For some reason some GCC-8 architectures (nios2, alpha) have trouble
+ * determining that the ss_done state is impossible in __scoped_seqlock_next()
+ * below.
+ */
+static inline void __scoped_seqlock_bug(void) { }
+#else
+/*
+ * Canary for compiler optimization -- if the compiler doesn't realize this is
+ * an impossible state, it very likely generates sub-optimal code here.
+ */
+extern void __scoped_seqlock_bug(void);
+#endif
+
+static inline void
+__scoped_seqlock_next(struct ss_tmp *sst, seqlock_t *lock, enum ss_state target)
+{
+	switch (sst->state) {
+	case ss_done:
+		__scoped_seqlock_bug();
+		return;
+
+	case ss_lock:
+	case ss_lock_irqsave:
+		sst->state = ss_done;
+		return;
+
+	case ss_lockless:
+		if (!read_seqretry(lock, sst->data)) {
+			sst->state = ss_done;
+			return;
+		}
+		break;
+	}
+
+	switch (target) {
+	case ss_done:
+		__scoped_seqlock_invalid_target();
+		return;
+
+	case ss_lock:
+		sst->lock = &lock->lock;
+		spin_lock(sst->lock);
+		sst->state = ss_lock;
+		return;
+
+	case ss_lock_irqsave:
+		sst->lock_irqsave = &lock->lock;
+		spin_lock_irqsave(sst->lock_irqsave, sst->data);
+		sst->state = ss_lock_irqsave;
+		return;
+
+	case ss_lockless:
+		sst->data = read_seqbegin(lock);
+		return;
+	}
+}
+
+#define __scoped_seqlock_read(_seqlock, _target, _s)			\
+	for (struct ss_tmp _s __cleanup(__scoped_seqlock_cleanup) =	\
+	     { .state = ss_lockless, .data = read_seqbegin(_seqlock) };	\
+	     _s.state != ss_done;					\
+	     __scoped_seqlock_next(&_s, _seqlock, _target))
+
+/**
+ * scoped_seqlock_read (lock, ss_state) - execute the read side critical
+ *                                        section without manual sequence
+ *                                        counter handling or calls to other
+ *                                        helpers
+ * @lock: pointer to seqlock_t protecting the data
+ * @ss_state: one of {ss_lock, ss_lock_irqsave, ss_lockless} indicating
+ *            the type of critical read section
+ *
+ * Example:
+ *
+ *     scoped_seqlock_read (&lock, ss_lock) {
+ *         // read-side critical section
+ *     }
+ *
+ * Starts with a lockess pass first. If it fails, restarts the critical
+ * section with the lock held.
+ */
+#define scoped_seqlock_read(_seqlock, _target)				\
+	__scoped_seqlock_read(_seqlock, _target, __UNIQUE_ID(seqlock))
+
 #endif /* __LINUX_SEQLOCK_H */
-- 
2.53.0

