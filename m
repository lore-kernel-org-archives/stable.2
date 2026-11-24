Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533001;
	b=IIYxvhO6uZHCfMfASzNdAIU0E/XpHZrjzHMwCAmzfwoXphhIQ1p2/eVlWCeOpQeIhMpk
	 64ytbPALuk3dOQjroWBvXaau5CuZjnaqgKqljgJc9DB+qhtyyHvVgUZUUyjcAwQWF4LJ+
	 fCs8Bsv9jE4DnZBAZO2NU7SZrfZ0YKFiNtGgDDUx76jqVjdNuHPSYTqEWsFgjB5r6E38z
	 wBds4pW51+xO3T8LivvXp8XOEQL6nVwrgXlNOsbGYLZG1p7ufy9SWIQCC8LIddPoT8enh
	 Qrh+IlG4DJ2E3eswae293TnK2BZoIxhV/YV6UFhHUrsfxzKjrFIHJR7gTfx6++EMjRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533001;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TeJRNInMMsHMddEsWhUefmS/VlfrGiisvSC6v7+LDDY=;
	b=yYMhVN7l7fxPZF/AQVyOopPNEu4fRlNOiptL4FPlQQFH1Am7OZ+y/CSs5Q8s5KJsswjQ
	 qRFGzFaHq7bMwyoHzrsDskXmaCwsC82s/dgg+iiG5BX7u38QdwtGmp07/s7V2h95KGxpR
	 UdcVkEn6X0zcqAcUm30onzuP04FgzqpV3PApuSSCLEl5dIzneXTDJrMsfT5Ujr3LJHpVj
	 dRBCWi8+S/PEX+O13BILzJg8c9Rs/xPOhXDjjmkE8lLlIVabbS6hwBtMvvAjD3/kSlQK8
	 +2IqJvpBEClZ0oKbe80ZKZUEGHcMoUEs7flS8lfaAlhvr9OJYEY+oJSE7ULv/xORewQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b0V2HqLY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A656606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b0V2HqLY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4F11F000C6;
	Tue, 24 Nov 2026 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795533000;
	bh=TeJRNInMMsHMddEsWhUefmS/VlfrGiisvSC6v7+LDDY=;
	h=Subject:To:Cc:From:Date;
	b=b0V2HqLYMwcoaQc7X0T81O+UbW52HdyRIKlDyi1QZfc1u00KkNrNtPkKgUv+M49SP
	 oILdr2cchIoVvmwSIkfhgKDwJazfSYezZmVHa37Prnn3ve6SycbeLZMt0SJp9CzudO
	 /IYsTrkAQaWithLlqwTjszXdeMotgzKfaY4vgDJg=
Subject: FAILED: patch "[PATCH] kprobes: Validate re-registration earlier in" failed to apply to 5.15-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:10:10 +0100
Message-ID: <2026112410-imitate-account-4881@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a553b499f22bf054964d4fd16d136f3d4f836c23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112410-imitate-account-4881@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

