Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF64BE45E
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052242; cv=none; b=FTF9g1Q8w8lUZEfauPqfin56Z/rRxvu9w7OLTHV3QxeG+UpWR9QbF0mGNyVUlghduWl2BAyU0gDGKtqAcqwcjtqFcIMfvuyEtzi9VyJ5kedEuSVELyJ3dtvHYBjxKAb2PxZP+nsyB8dVg+yl15j69U/tuQgUjYwIZIOJ9HHIVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052242; c=relaxed/simple;
	bh=aHFmT3y6Nn1rDrMIF/pHxFvBoyUQ6LXdwrnFCsyc19s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WAJgCKNQy/j8Utx5ze4O+hJleb8CeRmO7s48d5kArHuxjn0qBgyoHkZVLIHHDqcdpUbTxybAoOnNPXgaqOZDJUh34o/tCrm2UF+1nsJMN5fv7GS/a71KX8GcVLSriTA2CdnZAs2IG8g4IYm6Lr6pVpxR0NYxdYn5ajJI4KJY1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XoqhS59x; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoqhS59x"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a019d53f46so14072025e9.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792052238; x=1792657038; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7qcABzzji+bihcE8z5CZtBejGLs7WH+bh5VllZSZyQE=;
        b=XoqhS59xfqiAQ/iNoKnHwBccRKXgvEDM0ZzJ2/0oK/FcCke7M+I+UcekeWTrSOEl1v
         1cZG5ojw0w+hQSm+PvdS1ZDxe1PN2OZ/sWCK9hMpIJIPI864731Z0w1Przk87WtHe5hz
         sU3rbeiEWMGEfv3PhA2jgGki5ZAqa8248s3alkpDES0EAysNt+n4/zQeT4ySkSXwnxUL
         QokOoFOBgykG8kAolus+yvPWVQ+OIJBkAQMYsPTxI7AcQp1ql7hyeuzEWVarpAdOe/oY
         42hYgYEuFim9vH9Tf6gzcpI+hA6Kg03ulq/hUDzIZKGcV+uJg/m2NpqKekwyjNJgte9c
         GWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052238; x=1792657038;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7qcABzzji+bihcE8z5CZtBejGLs7WH+bh5VllZSZyQE=;
        b=bRW5G0eGK7+w1fMIRirdAgbN/GfNEjYbYs5ICofgnnO3mjzDXyvblwi/mOdMGPh05R
         ay3WMe/4scLMlNQTnpfhjEvcARpoAgSul/1KYWLLKNXQNkxHYw8cGgdgfnzpr6exkw8j
         S07OuP5cAylmRR/GdUDeQJaqComx4T/H6w/rycT6iqC2y9xPP9oza6agKypaP18z2OKl
         MQtDc24tVtYPdpy0M48Vktk/JCT9CuHSwdjtcjQ9L9TG/ysh78t4OgUsXF/zINijaX6V
         40kmNZgsx2nFepRhc/9Y1XOXbQc4TxiKASDdo3FvNPQH6/QYeq7ZeQf0HsLxdfsvw6Po
         QzVA==
X-Gm-Message-State: AFq9FYLJd0CnnpR2uoBI9NLzEv/Fy6910ov1wei2D5Q5yA5qQNxuReey
	0+8n9fa88O7zjEpSKL5YXn0DOORjVAYKkYHOtZ7IAcx5Tyzzy21Uxyq7M3VaFRBGF6RPKa1gmy7
	2kEore/NIUioY7n0g8exkrglVMPHIg0AQkPHDTf+FfA2QF9YMWtn6nanfRmuXh991RYcOLB2sgC
	69kFiqnrPAuNblgKiEgkQfpTwArVDZztQj+HRiBfQvej04Z1ivFmDR
X-Received: from wmop14.prod.google.com ([2002:a05:600c:468e:b0:4a1:8ab4:b338])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e89:b0:4a0:22d5:908c with SMTP id 5b1f17b1804b1-4a18e4a4976mr397363895e9.12.1792052237245;
 Thu, 15 Oct 2026 01:17:17 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:16:27 +0000
In-Reply-To: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7044; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=aHFmT3y6Nn1rDrMIF/pHxFvBoyUQ6LXdwrnFCsyc19s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq0IwJlFA2hjbpArhzZQU/Lpz79MNJ0CXSwlCQA
 PqosOipJJ2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCatCMCQAKCRAEWL7uWMY5
 RhtWEACGn3M1Rn6T8pFyzYDcAXbdQmXGuj/uqnO/X2z+QFC3lLU2Epx/mypu9wpXoq5o6j0clu1
 /frKp68tYZRQ1O+IA4zzIkMZmphJSnGBC7PGD3rl9vG6SrelECyyUw33ftWLYJmWpIujJ7Vdbjr
 Kc0qe6nAJrSmfkEBDBeMhuSeUJbej9BvQ8Fo37numIdgQ1pmNtchmmF9F0dFt4yI+kdDaJA1MC6
 9XWfGQqsU93iWsc+uu3oXLYKvP9IG+FNfzcLUik7zW2QFumEGs2Dp4+Az59ZdOqpPvbjgjsUjU7
 9Cq8LX1LSZDYs5Xyb1Zfv0JSqIc44UCwzyjSdqFA31RUElGctfP8MMxl4v+eO/+hWd+8cAa+bYn
 0Sc+9F4y4At2sHHjeQ+ypEsxXYnzi6fVxtoYj7fQ9i8kpfKNy6aghUWM3nGt5Dj3T7mhvKBCSJb
 VAlOHmgkxvCsErCdnEin7d/gSOSdmUSJEe5yyLSx1hW5xAfAmFQZ7tuSE5sPH0yqmEf1WEZaLuZ
 M+Df/Z8zEscgW0zpcQw6lFnHvCTBj86yfRcKS+gbyqDiXSNI1Bjf8mVu5PmbhmEDXHM4dBhRoQH
 C2wtEKm0Q4ZaeU3kqzaUW6e/BLpT79WmDawSCiRxnaByqyJyVJgHVMCixHm2qjAePz1FKYD/rWR dhDl152J9Gt8IYA==
X-Mailer: b4 0.14.3
Message-ID: <20261015-spinlock-irq-6-18-v1-1-72c58975994e@google.com>
Subject: [PATCH 6.18.y 1/6] irq: Add refcounted local interrupt disabling
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Rust's SpinLockIrq abstraction requires refcounted local interrupt
disabling so that nested critical sections can be released in any order.
Upstream commit e901c1510e24 ("irq,spin_lock: Add counted interrupt
disabling/enabling") implements this by carving HARDIRQ_DISABLE_BITS out
of preempt_count, which requires invasive architecture-specific changes
across x86, arm64, and s390. Thus, for 6.18, implement the same API
using a dedicated per-CPU nesting count and saved irqflags word instead.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/interrupt_rc.h | 26 ++++++++++++++++++
 include/linux/spinlock.h     | 61 ++++++++++++++++++++++++++++++++++++++++++
 kernel/softirq.c             | 63 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
new file mode 100644
index 000000000000..64564bfd715a
--- /dev/null
+++ b/include/linux/interrupt_rc.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_INTERRUPT_RC_H
+#define __LINUX_INTERRUPT_RC_H
+
+/*
+ * Refcounted local processor interrupt management.
+ *
+ * local_interrupt_disable() disables interrupts on the local CPU and may be
+ * nested; interrupts are only restored once the outermost
+ * local_interrupt_enable() runs.
+ *
+ * Unlike local_irq_save()/local_irq_restore(), the saved interrupt state is
+ * held in per-CPU state rather than by the caller, so the regions do not have
+ * to be released in acquisition order. That property is what allows Rust's
+ * SpinLockIrq guards - which are ordinary values and may be dropped in any
+ * order - to be built on top of this.
+ *
+ * Since the implementation depends on local_irq_save()/local_irq_restore(),
+ * this lives in its own header to make it easier to include without hitting
+ * circular header dependencies.
+ */
+
+void local_interrupt_disable(void);
+void local_interrupt_enable(void);
+
+#endif /* !__LINUX_INTERRUPT_RC_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3561c4a080e..bb067c652fbd 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -57,6 +57,7 @@
 #include <linux/linkage.h>
 #include <linux/compiler.h>
 #include <linux/irqflags.h>
+#include <linux/interrupt_rc.h>
 #include <linux/thread_info.h>
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
@@ -455,6 +456,66 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
 # include <linux/spinlock_rt.h>
 #endif /* CONFIG_PREEMPT_RT */
 
+/*
+ * spin_lock_irq_disable() and friends behave like spin_lock_irq(), except that
+ * the interrupt disabling is refcounted (see <linux/interrupt_rc.h>).
+ *
+ * Two differences from spin_lock_irq() follow from that:
+ *
+ *  - Nesting works: an inner critical section does not re-enable interrupts on
+ *    exit while an outer one is still held.
+ *  - If interrupts were already disabled on entry to the outermost section,
+ *    they stay disabled on exit, as with spin_lock_irqsave().
+ *
+ * Unlike spin_lock_irqsave() the saved state lives in per-CPU state rather
+ * than in a caller-provided variable, so sections need not be released in
+ * acquisition order. These exist for Rust's SpinLockIrq, whose guards are
+ * ordinary values and may be dropped in any order.
+ */
+#ifndef CONFIG_PREEMPT_RT
+static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
+{
+	local_interrupt_disable();
+	spin_lock(lock);
+}
+
+static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
+{
+	spin_unlock(lock);
+	local_interrupt_enable();
+}
+
+static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
+{
+	local_interrupt_disable();
+
+	if (spin_trylock(lock))
+		return 1;
+
+	local_interrupt_enable();
+	return 0;
+}
+#else /* CONFIG_PREEMPT_RT */
+/*
+ * On PREEMPT_RT spinlock_t is a sleeping lock and spin_lock_irq() does not
+ * disable interrupts at all; mirror that behaviour here.
+ */
+static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
+{
+	spin_lock(lock);
+}
+
+static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
+{
+	spin_unlock(lock);
+}
+
+static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
+{
+	return spin_trylock(lock);
+}
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * Does a critical section need to be broken due to another
  * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 77198911b8dd..3d17cf5ff790 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
+#include <linux/interrupt_rc.h>
 #include <linux/init.h>
 #include <linux/local_lock.h>
 #include <linux/mm.h>
@@ -88,6 +89,68 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
+/*
+ * Refcounted local interrupt disabling; see <linux/interrupt_rc.h>.
+ *
+ * @local_interrupt_disable_count is the nesting depth on this CPU and
+ * @local_interrupt_disable_flags holds the irqflags captured by the outermost
+ * local_interrupt_disable().
+ *
+ * Both are only ever accessed by the owning CPU with interrupts disabled, so
+ * no atomics are needed: local_interrupt_disable() disables interrupts before
+ * touching the count, and a non-zero count implies interrupts are disabled.
+ */
+static DEFINE_PER_CPU(unsigned int, local_interrupt_disable_count);
+static DEFINE_PER_CPU(unsigned long, local_interrupt_disable_flags);
+
+void local_interrupt_disable(void)
+{
+	unsigned int count;
+	unsigned long flags;
+
+	WARN_ON_ONCE(in_nmi());
+
+	/*
+	 * Disable interrupts before touching the count, so that an interrupt
+	 * handler on this CPU cannot observe or modify a half-updated state.
+	 */
+	local_irq_save(flags);
+
+	count = raw_cpu_read(local_interrupt_disable_count);
+	if (count == 0) {
+		preempt_disable();
+		raw_cpu_write(local_interrupt_disable_flags, flags);
+	}
+
+	raw_cpu_write(local_interrupt_disable_count, count + 1);
+}
+EXPORT_SYMBOL_GPL(local_interrupt_disable);
+
+void local_interrupt_enable(void)
+{
+	unsigned int count = raw_cpu_read(local_interrupt_disable_count);
+
+	if (WARN_ON_ONCE(count == 0))
+		return;
+
+	count--;
+	raw_cpu_write(local_interrupt_disable_count, count);
+
+	if (count == 0) {
+		unsigned long flags = raw_cpu_read(local_interrupt_disable_flags);
+
+		/*
+		 * Restore rather than unconditionally enable: the outermost
+		 * local_interrupt_disable() may itself have run with
+		 * interrupts already disabled, in which case they must stay
+		 * disabled here.
+		 */
+		local_irq_restore(flags);
+		preempt_enable();
+	}
+}
+EXPORT_SYMBOL_GPL(local_interrupt_enable);
+
 /*
  * SOFTIRQ_OFFSET usage:
  *

-- 
2.56.0.385.gd3acb90ef8-goog

