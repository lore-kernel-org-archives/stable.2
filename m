Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532998;
	b=tFK6N/KErpA2CZlUnzh1mxaCuRWW47t+xP+C0Ng2mbH702eELN3Y1/xCO3N4Ih+eWnST
	 TTMlaPIZc3Swi8YXRrs2/IPvTwXU2q6/ylOud/VZiVdRoBEfJb+J0Jo/3/YdzDFYI11cz
	 1+fdNMG2MQB2dC7Eq0PPnjh8D6ZCYyHai+UO4jEOD/g+JsFenR4OrKNhzedwYUKRSJlXX
	 E0Zw5iR5Y7YMp9ifKKCGuYHa283OJR0emlbER7ebO4OhEoj2+ZcwF1BcGZ5WA4n9qLI7W
	 v2pCu1EyjA1s5ik4rjYwr3VnSvGFUQ1ya8thCdKGIigrLMUgvUZOWfdpRG2E3ERMaxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532998;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=a96j+xjfTvIXX0pnFukaF3wruc4qXTkWNBrIQWWi70k=;
	b=uXkPm/Sj5KRRY6xPDlDrI47FRbcBq2RcW3oWdyRxpX2oDvJmAVu9Ep+/yGrzf5imMw1A
	 5Z6wK5QzAeDv+D8DJa+qfVmFK+SpDTqmh8hlHhZq1qUbv6SLVOVq3ip1WsEotrydJTvjk
	 PlyBtGrbOFypcvScL1RzN3V8ZEeNrYUHCrfC1MXqgU0zdc4ImSXOKJircG9xMKboW9k6A
	 6Gs7tl491H1S/9XdAubMxwYbcQES7Kq4hXcvmc4BqCBfpZTMfZTZ/FPtJ7dVfv6Ebsnd3
	 1zFY+9gsZ/LSu16qNEEpp30B+i3o6UCdZlrH85pssmcvMmGoafzJ9qJprwyQ8y5c+BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TNj97sc1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0498606A329
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TNj97sc1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65541F000C4;
	Tue, 24 Nov 2026 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795532997;
	bh=a96j+xjfTvIXX0pnFukaF3wruc4qXTkWNBrIQWWi70k=;
	h=Subject:To:Cc:From:Date;
	b=TNj97sc1ll1qadfZcRG1FUFCy3kzx40QfFxYckBa+OfoOYjfl0P+OP9L0SvNi7NJA
	 HwkeiJQhjoX5NumOL3JT920x0DSA1f9hrFamiVV4oQiSEoFiyt57y1TjhxG8vlIDgS
	 E4m+aOH5TDJfY9Bsk6lOYrbWfTcF9np2AX5MA9qI=
Subject: FAILED: patch "[PATCH] kprobes: Validate re-registration earlier in" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:10:10 +0100
Message-ID: <2026112410-hurried-barbell-533d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a553b499f22bf054964d4fd16d136f3d4f836c23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112410-hurried-barbell-533d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a553b499f22bf054964d4fd16d136f3d4f836c23 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Wed, 4 Nov 2026 08:58:45 +0900
Subject: [PATCH] kprobes: Validate re-registration earlier in
 register_kretprobe()

register_kretprobe() only checked for re-registration if rp->kp.addr was
specified, skipping the check when rp was registered with symbol_name
and rp->kp.addr was NULL. In that scenario, register_kretprobe()
proceeded to allocate a new rethook (or kretprobe holder), and when
register_kprobe(&rp->kp) subsequently failed due to re-registration, the
error path freed and NULL-ed rp->rh (or rp->rph) on the still-active
kretprobe, leading to NULL pointer dereferences when the active probe
was hit.

Resolve the target address via _kprobe_addr() up-front and check whether
the probe is already registered at that address via
check_kprobe_rereg_at() before allocating any resources, and drop the
WARN_ON_ONCE() in the re-registration check now that re-registration is
gracefully detected and rejected.

Link: https://lore.kernel.org/all/179375032568.247640.17429793187163536192.stgit@devnote2/

Fixes: 0188b87899ff ("kretprobe: Avoid re-registration of the same kretprobe earlier")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 7a3da809bac7..0b41d69540ae 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1793,52 +1793,61 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 	return addr;
 }
 
-static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
-{
-	bool on_func_entry;
-
-	return _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
-}
-
 /*
  * Check the 'p' is valid and return the aggregator kprobe
  * at the same address.
  */
-static struct kprobe *__get_valid_kprobe(struct kprobe *p)
+static struct kprobe *__get_valid_kprobe_at(struct kprobe *p, kprobe_opcode_t *addr)
 {
+	struct hlist_head *head;
 	struct kprobe *ap, *list_p;
 
 	lockdep_assert_held(&kprobe_mutex);
 
-	ap = get_kprobe(p->addr);
-	if (unlikely(!ap))
+	if (unlikely(!addr))
 		return NULL;
 
-	if (p == ap)
-		return ap;
-
-	list_for_each_entry(list_p, &ap->list, list)
-		if (list_p == p)
-		/* kprobe p is a valid probe */
+	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
+	hlist_for_each_entry_rcu(ap, head, hlist,
+				 lockdep_is_held(&kprobe_mutex)) {
+		if (ap == p) {
+			p->addr = addr;
 			return ap;
+		}
+		if (ap->addr == addr && kprobe_aggrprobe(ap)) {
+			list_for_each_entry(list_p, &ap->list, list) {
+				if (list_p == p) {
+					p->addr = addr;
+					return ap;
+				}
+			}
+		}
+	}
 
 	return NULL;
 }
 
-/*
- * Warn and return error if the kprobe is being re-registered since
- * there must be a software bug.
- */
-static inline int warn_kprobe_rereg(struct kprobe *p)
+static inline struct kprobe *__get_valid_kprobe(struct kprobe *p)
+{
+	return __get_valid_kprobe_at(p, p->addr);
+}
+
+/* Return error if the kprobe is being re-registered */
+static inline int check_kprobe_rereg_at(struct kprobe *p, kprobe_opcode_t *addr)
 {
 	guard(mutex)(&kprobe_mutex);
 
-	if (WARN_ON_ONCE(__get_valid_kprobe(p)))
+	if (__get_valid_kprobe_at(p, addr))
 		return -EINVAL;
 
 	return 0;
 }
 
+static inline int check_kprobe_rereg(struct kprobe *p)
+{
+	return check_kprobe_rereg_at(p, p->addr);
+}
+
 static int check_ftrace_location(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long)p->addr;
@@ -1969,7 +1978,7 @@ int register_kprobe(struct kprobe *p)
 		return PTR_ERR(addr);
 	p->addr = addr;
 
-	ret = warn_kprobe_rereg(p);
+	ret = check_kprobe_rereg(p);
 	if (ret)
 		return ret;
 
@@ -2505,20 +2514,19 @@ int register_kretprobe(struct kretprobe *rp)
 	int ret;
 	int i;
 	void *addr;
+	bool on_func_entry;
 
-	ret = kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset);
-	if (ret)
-		return ret;
+	addr = _kprobe_addr(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset, &on_func_entry);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
 
-	/* If only 'rp->kp.addr' is specified, check reregistering kprobes */
-	if (rp->kp.addr && warn_kprobe_rereg(&rp->kp))
+	if (!on_func_entry)
+		return -EINVAL;
+
+	if (check_kprobe_rereg_at(&rp->kp, addr))
 		return -EINVAL;
 
 	if (kretprobe_blacklist_size) {
-		addr = kprobe_addr(&rp->kp);
-		if (IS_ERR(addr))
-			return PTR_ERR(addr);
-
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
 			if (kretprobe_blacklist[i].addr == addr)
 				return -EINVAL;

