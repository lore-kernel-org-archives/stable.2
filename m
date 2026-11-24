Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536393;
	b=OrzwuiGZV/wW9N9DfdOUGhljfnCdiNaRhszjrltS0v/kO6VM1z0skkzNSckDVRE+l5sW
	 vxS8eDpspjmnnvf7ygt70fQcfrQwsYIbAhj4k/ur03Fv5ro2AmAnFR/8hUo290A77zXsO
	 mzScK+fosOFSM3jZl+8rQ7VMF9DOiyKRNAu/O/v2oC0Jhq7XdPm2Jgk5jsjL8zZMjX73d
	 nJisphA4VKCs5TxZ67bheb2+Bw7Qsg6+2kNMSnM/qd3Gy3kUHrH93XI1Zk3oB/rLWtchl
	 kT6CshBRT8dFU2Fc1Uzbe4rPuIGAbVVXAZeKRnb7RmXZnuyqCYY45aHEdKstoU8EeRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536393;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GWetdlmfONo11YQTk/X6+IcmwdbOhBtD/XPAvzey1EU=;
	b=5ZY6N3TOg+uwUlMyfKaHMuEQ3q6HP/oyF6WF+DD3S+MRGVHHWSiOqq5FpGiKdoXTq07C
	 qD8lXnsvr1udW4h59i7A53TgAmU9UzR6U/bGE2+e+Pozavh5ZntAMwrkGyyWZFdaIuTCZ
	 nycp4o6AL2MPNEd/X5AREFZbNIk/QrK6auMsUhGerZcdyCeGKE1NwbwJGGbcFH2N03CiU
	 T6oSE5PnYnGvV9pfhHmaN0zSQDoaztIEfVTtv5Si8OvlFKW2LKRZb9wHO07OcqFuDit0b
	 oaBUoOMv29kQqz+8XtOVBZWI1qW1msGXwYMerlW5YbquRJOnXmpOx65qS4goY09wmHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEzO2s8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA167606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEzO2s8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4839F1F000D3;
	Tue, 24 Nov 2026 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536393;
	bh=GWetdlmfONo11YQTk/X6+IcmwdbOhBtD/XPAvzey1EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AEzO2s8sZ0dFxEJemzYq3uZ5NDH5xwpX76JtovNB04rDuMKBe6OYdCeQU7Y3+gKGm
	 b5qLihgjRezK447DiC6Tt4B0VOpOifFFmJWgL0JWfeR0MQf9JSwp4Qmdo4nxLpu/nl
	 dpTVMccwVeI/phWGai3X+HcnfDdQgJXhKQ+xTzY46Vc7cIdsHWr21wtvocem1D0brJ
	 s2iC25VuHG0ZYWRAx+vp6Zbxm6SzlFXi320Ej6JvVeRV2dXqiAbw4IwEpfdXHxNms/
	 QhAnywGChYAySjyZv6rL9uOpUUTUt5y29tsP3htE7RIfgfUjnomXgG+fFmvTjlL3Yp
	 k9nUP9Qvivb5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] kprobes: Validate re-registration earlier in register_kretprobe()
Date: Tue, 24 Nov 2026 11:06:30 -0500
Message-ID: <20261124160620.845524-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124160620.845524-1-sashal@kernel.org>
References: <2026112410-footman-resume-b431@gregkh>
 <20261124160620.845524-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit a553b499f22bf054964d4fd16d136f3d4f836c23 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 72 +++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 8eb092fa66a82..c70f99610a78c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1493,52 +1493,61 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
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
@@ -1675,7 +1684,7 @@ int register_kprobe(struct kprobe *p)
 		return PTR_ERR(addr);
 	p->addr = addr;
 
-	ret = warn_kprobe_rereg(p);
+	ret = check_kprobe_rereg(p);
 	if (ret)
 		return ret;
 
@@ -2211,20 +2220,19 @@ int register_kretprobe(struct kretprobe *rp)
 	struct kretprobe_instance *inst;
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
 		return -EINVAL;
 
-	if (kretprobe_blacklist_size) {
-		addr = kprobe_addr(&rp->kp);
-		if (IS_ERR(addr))
-			return PTR_ERR(addr);
+	if (check_kprobe_rereg_at(&rp->kp, addr))
+		return -EINVAL;
 
+	if (kretprobe_blacklist_size) {
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
 			if (kretprobe_blacklist[i].addr == addr)
 				return -EINVAL;
-- 
2.53.0

