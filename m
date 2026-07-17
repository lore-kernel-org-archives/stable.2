Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AB3EC6B3
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287125; cv=none; b=Wca6SL/07jyzstUZW/rXe97bTQrKqxhltRuhP4P2DzJ8eTel1RHrBMzCs86EtxycFkVTdtwQw0QzTuMaHEg+9f6Xm/VuUmEu8BJBg1iL2H/USVCSRr/N7Uuye/C/3fs3uL6/1KYpzRUY9siiYIXaPAXVYfPUI1NN7XNd1iT5tm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287125; c=relaxed/simple;
	bh=e/Jzk4/U3voeN9phPaXPpO3ES4tygaxZQ9vxVGL9lyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLuD5pe6ESBtnn9xr8IbDTEkLW45Txh3hNumWSGxE9FwbytPQpoNJzri+zJWNCvoxj10jiuQqVeASRb4cXd/PtUgOrlDGQS6090Se5qIriHTs/kLi6kxqx76BFRgyzVt5TUOhAnjNo94GuJ4tMxDR292TJCj9xPErLukCyi8xGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIy7X1d3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIy7X1d3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEF21F000E9;
	Fri, 17 Jul 2026 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287117;
	bh=T96fQeMHUHzraCujdEXqgHYMYHn0tCmsDc+hevBAMPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QIy7X1d3KDSR+ipvEGKiFWInW+6zw8Pa7lTr7u9LoFRSj5ExrNvVpw/kL0+MEvBn6
	 +0jn9KDz3M23UC4k2SW6CPselIOBfkSiF3DlZ0B2JnPxla4G3OLICwuPN/mxGLA4gQ
	 2uWVhHxp/M+VCJ7Pstljb+xkbOHO27tFEUR0+CpNZJR6lMHqmEnKQaOiPbnqPQrn0q
	 zyMSJykad7rwQxbkAVmeF/LyhGNAlZXeGpFPnbWCqJvmAS24i5x3uCJ+922GKV4w0k
	 yZ3qXiv89iqR50b1uKGaKJ9KWluwxCL3sUnjBcxx876EnyM5WVJQu7IJGnDuRAa6u5
	 vPKTqpLJ6N+qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] seqlock: Introduce scoped_seqlock_read()
Date: Fri, 17 Jul 2026 07:18:32 -0400
Message-ID: <20260717111835.1574543-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071444-fraction-t-shirt-9b49@gregkh>
References: <2026071444-fraction-t-shirt-9b49@gregkh>
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
index 5ce48eab7a2ad7..b7bcc4111e908c 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1209,4 +1209,115 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
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

