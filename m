Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FBB3AB27B
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791071081; cv=none; b=XxjosfIQX9dfCe1Xqiipr63jSVqrcqPsXD8Xzrw+La25Sz36DJ3kes9DR6CXQ+4ucTZJlIa7q3usQTEVcJi1WM9Jpley/KvGkWd0D1ckRVyPXiC9xa0UPWJElCbPHeyjGQqumnGv0bO5/xPiXtA43vkEnn1ANraZWdQniJu47Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791071081; c=relaxed/simple;
	bh=9+UpFpAmeTUduBXkPfwuLJ3UldOnicmZkubldFXS2b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYruA8PTSQ2tp/ihflV6dCHAh4w21jGmHskJ9LN6O6TfnmK7PrEuTHYAuspGXh2E414ekCI7V3SZnJiysQ6KuqF8adOQjNtilw1X5ApmF7ZPLPjlwdhw4hXowaKIEeZEFC/GGKuilucr5wjeoEzeEMb333QmHAgQllBoN19nHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0tb6koJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0tb6koJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496651F0089B;
	Sat,  3 Oct 2026 23:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791071079;
	bh=v5moHOJctoWOzf/DMrJ5n0Y0E1+DFx1k+5yofLhxNNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i0tb6koJ3yISHxKUWv4ItHEAQ/Z7xKBIYQHK6cNeYpJ5wUYCOQ7Dj8mRzrJw6lMAO
	 HTDPrElmTY4FbGiCVF0GTT2kDXMREGikpLdgTS36Zfeornp9iqWVefZ8lTOgfCwnaE
	 Iio+ogbzt2f3V93DCS/593i21L80v9idIgoFIMZ4bF4eNjmhf213CY8SfLFBaSY0Ub
	 lk79T+TQvip3egdKhuDXJw85T4DB37shSvz9ERJmIiG06jnlR4tEODlQ81gvgO9uHQ
	 CkXcLjVhcFYZwPpbJGQBGWL4G3L+ncx7s0V8MgtZJpHRNR9azh4Y4pYDm+BfP82gIy
	 g1MOL1RxNyUgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] kprobes: Fix coding style issues
Date: Sat,  3 Oct 2026 19:44:18 -0400
Message-ID: <20261003234356.710783-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003234356.710783-1-sashal@kernel.org>
References: <2026100344-anchor-outpost-f7ad@gregkh>
 <20261003234356.710783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 223a76b268c9cfa265d454879ae09e2c9c808f87 ]

Fix coding style issues reported by checkpatch.pl and update
comments to quote variable names and add "()" to function
name.
One TODO comment in __disarm_kprobe() is removed because
it has been done by following commit.

Link: https://lkml.kernel.org/r/163163037468.489837.4282347782492003960.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Limit the comment cleanup to optimized-probe lookup and its callers.
Convert get_optimized_kprobe() and arch_within_optimized_kprobe() to
kprobe_opcode_t * addresses, including all architecture implementations.
Scale byte-sized bounds by sizeof(kprobe_opcode_t) when doing pointer
arithmetic. This supplies the context needed by the subsequent fix for
overlap checks skipping disarmed probes.

Keep the existing externally visible kprobe_disarmed() and the existing
optimizer cleanup, blacklist and module validation behavior. Omit the
unrelated comment, instruction-cache and error-code changes.

Stable-dep-of: 7a39c732a22e ("kprobes: Skip disarmed probes when checking optkprobe overlap")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/probes/kprobes/opt-arm.c |  6 +++---
 arch/powerpc/kernel/optprobes.c   |  6 +++---
 arch/x86/kernel/kprobes/opt.c     |  6 +++---
 include/linux/kprobes.h           |  2 +-
 kernel/kprobes.c                  | 16 ++++++++--------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index e20304f1d8bc9..da97ee8fa7ac8 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -345,10 +345,10 @@ void arch_unoptimize_kprobes(struct list_head *oplist,
 }
 
 int arch_within_optimized_kprobe(struct optimized_kprobe *op,
-				unsigned long addr)
+				 kprobe_opcode_t *addr)
 {
-	return ((unsigned long)op->kp.addr <= addr &&
-		(unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
+	return (op->kp.addr <= addr &&
+		op->kp.addr + (RELATIVEJUMP_SIZE / sizeof(kprobe_opcode_t)) > addr);
 }
 
 void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index c79899abcec84..325ba544883c5 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -301,8 +301,8 @@ void arch_unoptimize_kprobes(struct list_head *oplist, struct list_head *done_li
 	}
 }
 
-int arch_within_optimized_kprobe(struct optimized_kprobe *op, unsigned long addr)
+int arch_within_optimized_kprobe(struct optimized_kprobe *op, kprobe_opcode_t *addr)
 {
-	return ((unsigned long)op->kp.addr <= addr &&
-		(unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
+	return (op->kp.addr <= addr &&
+		op->kp.addr + (RELATIVEJUMP_SIZE / sizeof(kprobe_opcode_t)) > addr);
 }
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 98d0e2012e1f3..2cba90c44b451 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -355,10 +355,10 @@ int arch_check_optimized_kprobe(struct optimized_kprobe *op)
 
 /* Check the addr is within the optimized instructions. */
 int arch_within_optimized_kprobe(struct optimized_kprobe *op,
-				 unsigned long addr)
+				 kprobe_opcode_t *addr)
 {
-	return ((unsigned long)op->kp.addr <= addr &&
-		(unsigned long)op->kp.addr + op->optinsn.size > addr);
+	return (op->kp.addr <= addr &&
+		op->kp.addr + op->optinsn.size > addr);
 }
 
 /* Free optimized instruction slot */
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index bc9f7fdc82e16..4b6ead1c488e7 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -334,7 +334,7 @@ extern void arch_unoptimize_kprobes(struct list_head *oplist,
 				    struct list_head *done_list);
 extern void arch_unoptimize_kprobe(struct optimized_kprobe *op);
 extern int arch_within_optimized_kprobe(struct optimized_kprobe *op,
-					unsigned long addr);
+					kprobe_opcode_t *addr);
 
 extern void opt_pre_handler(struct kprobe *p, struct pt_regs *regs);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 92ddd2842e55f..5b52dc2a34145 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -480,17 +480,17 @@ static int kprobe_queued(struct kprobe *p)
 
 /*
  * Return an optimized kprobe whose optimizing code replaces
- * instructions including addr (exclude breakpoint).
+ * instructions including 'addr' (exclude breakpoint).
  */
-static struct kprobe *get_optimized_kprobe(unsigned long addr)
+static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 {
 	int i;
 	struct kprobe *p = NULL;
 	struct optimized_kprobe *op;
 
 	/* Don't check i == 0, since that is a breakpoint case. */
-	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH; i++)
-		p = get_kprobe((void *)(addr - i));
+	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
+		p = get_kprobe(addr - i);
 
 	if (p && kprobe_optready(p)) {
 		op = container_of(p, struct optimized_kprobe, kp);
@@ -955,8 +955,8 @@ static void __arm_kprobe(struct kprobe *p)
 {
 	struct kprobe *_p;
 
-	/* Check collision with other optimized kprobes */
-	_p = get_optimized_kprobe((unsigned long)p->addr);
+	/* Find the overlapping optimized kprobes. */
+	_p = get_optimized_kprobe(p->addr);
 	if (unlikely(_p))
 		/* Fallback to unoptimized kprobe */
 		unoptimize_kprobe(_p, true);
@@ -975,8 +975,8 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 
 	if (!kprobe_queued(p)) {
 		arch_disarm_kprobe(p);
-		/* If another kprobe was blocked, optimize it. */
-		_p = get_optimized_kprobe((unsigned long)p->addr);
+		/* If another kprobe was blocked, re-optimize it. */
+		_p = get_optimized_kprobe(p->addr);
 		if (unlikely(_p) && reopt)
 			optimize_kprobe(_p);
 	}
-- 
2.53.0

