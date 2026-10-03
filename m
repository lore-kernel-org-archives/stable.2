Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE43B27FA
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791071074; cv=none; b=Adz69bcWJtDxx8HQ9RbdTUyRVvP1G8hm2bkawKg0i8Vv4jkyg26UPpk9tejv40wq6IJNCp62qY3ZG16RnIqTxltKSyBIr505ktlLB9N2BH7NJpBjhhbyKnUChdlRYuZNJnXrDLo3JiCZFoV6+JIK5bIXerHzvsQbZ0KYabCKkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791071074; c=relaxed/simple;
	bh=h2/g5wJ+UbYnQF9tvBP56Zsp+ZLj/GIGrPgMZ/mZVDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHmkACVjBoYhXPpj0R8E59OSbwCJV5ZtLtyA3Gh4sQNhwEcSp+zuXu+z7DAvwSO2BFR4EYgU/Og2vjIGCvMVNazTDGvjprOOxk0DGQS4rNbo4F+2fw9nxhdWvcpMC6eRHvTQVLNvxFeFUeYYqm/Jg/vY7913NyjqudKHHXkm/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olJ2KT9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olJ2KT9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3388A1F0089B;
	Sat,  3 Oct 2026 23:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791071073;
	bh=0b1dqBxPoW13xkHOrdWtkL1nJWsyztYuKDQScNlU8uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=olJ2KT9tb/ZP7EadRHIPy8AlagMf5aqTHi7zBuG/1xYWcpp5gDENs+SdhxdKiR/fK
	 Lyw36T8jgKO0xzugTnHLSwPFPfjhPYg6V0WueihZfXee7stJ8uPeEdRVuA8slHdsAI
	 YKKufnIaYZaBOK8jV76TI7bfo8aHl2Eds5gn8KAPBmDvrfRz2Pg+r1Qo+/GhaIeRHB
	 4rvoUpj9En4uuX/4GxPEUR6dllvyjuc8WoMKMhesILGQ6l0Ve5xX+rGuztPTuY6bCz
	 Sg6Use4shvPm+r4TGpIbxoawGrEp6SO4thjoCjynW0wpS4zVUzGM8FQFMqDCndiBbe
	 uXbVa3eP9ap1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Punit Agrawal <punitagrawal@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] kprobe: Simplify prepare_kprobe() by dropping redundant version
Date: Sat,  3 Oct 2026 19:44:17 -0400
Message-ID: <20261003234356.710783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100344-anchor-outpost-f7ad@gregkh>
References: <2026100344-anchor-outpost-f7ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Punit Agrawal <punitagrawal@gmail.com>

[ Upstream commit 02afb8d6048d6526619e6e2dcdc95ce9c2bdb52f ]

The function prepare_kprobe() is called during kprobe registration and
is responsible for ensuring any architecture related preparation for
the kprobe is done before returning.

One of two versions of prepare_kprobe() is chosen depending on the
availability of KPROBE_ON_FTRACE in the kernel configuration.

Simplify the code by dropping the version when KPROBE_ON_FTRACE is not
selected - instead relying on kprobe_ftrace() to return false when
KPROBE_ON_FTRACE is not set.

No functional change.

Link: https://lkml.kernel.org/r/163163033696.489837.9264661820279300788.stgit@devnote2

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: 7a39c732a22e ("kprobes: Skip disarmed probes when checking optkprobe overlap")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kprobes.h |  5 +++++
 kernel/kprobes.c        | 23 +++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e5262feff8267..bc9f7fdc82e16 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -356,6 +356,11 @@ static inline void wait_for_kprobe_optimizer(void) { }
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
+#else
+static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	return -EINVAL;
+}
 #endif
 
 int arch_check_ftrace_location(struct kprobe *p);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 69d166f42d04a..92ddd2842e55f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1033,15 +1033,6 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
 
-/* Must ensure p->addr is really on ftrace */
-static int prepare_kprobe(struct kprobe *p)
-{
-	if (!kprobe_ftrace(p))
-		return arch_prepare_kprobe(p);
-
-	return arch_prepare_kprobe_ftrace(p);
-}
-
 /* Caller must lock kprobe_mutex */
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
@@ -1108,11 +1099,6 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
-static inline int prepare_kprobe(struct kprobe *p)
-{
-	return arch_prepare_kprobe(p);
-}
-
 static inline int arm_kprobe_ftrace(struct kprobe *p)
 {
 	return -ENODEV;
@@ -1124,6 +1110,15 @@ static inline int disarm_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
+static int prepare_kprobe(struct kprobe *p)
+{
+	/* Must ensure p->addr is really on ftrace */
+	if (kprobe_ftrace(p))
+		return arch_prepare_kprobe_ftrace(p);
+
+	return arch_prepare_kprobe(p);
+}
+
 /* Arm a kprobe with text_mutex */
 static int arm_kprobe(struct kprobe *kp)
 {
-- 
2.53.0

