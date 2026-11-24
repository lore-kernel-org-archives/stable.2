Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537253;
	b=ySO4NFV2y6vHxWfMrrqUpSe0ZdfHa+ixy1di3ZlXrihzrK5+NOAWDRnwRJ8NzfP7MXEr
	 OjpZuFlEdokB77lyutCq3u6cDJaggAvNGNodsxUzW2EpmHg47oOENf9EhXn0QRs7AZOiW
	 XfEtdZ9OVFv5XriAjPdcRmXsbGsZgQItXgOaK73b/YzUa46up6Kzs7fn0OCjUmV/m6ndk
	 U1sY1ou+fVI8/e9vLO7eiGT7JNn6TcMOCbWEnaprUyZA6yJe+jOhWnRQi9XbV9q4pMc4b
	 WREyCy+4OTrLH28DepuRzKb+wtEOCRH4LebZuZXujAkaY2j61Ri/9PQjP571Lo339CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537253;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K1IVmqjVuSEX+KqD0ppV/9OnyzGxfs37dPZx3G7QH6w=;
	b=GecwharH3ifUAdsnk24ibmkAa3Gedlvp+yGNax6bHJq5ha2xCEEGY7x4LaqLVGfh7P8y
	 jZ+yEVPZNL82RdbLwa4rftupCwKoW0+VafQeNLIy5srJplM4wT/xCRAPzw64kj+2h9G0A
	 3H2WFCJGbo0gjz4mFuYymiicmh2Y9mH96l+gK11YZQ+NlZSfie9YVA9lx5EYMpQbzZtWu
	 mLcuTG+GE2J+/dlYUMx/TZqnDxu16OhjrxU2+t9svGSPDrBylBtZGDwOn3GqodVTS8p8z
	 9r6+x1QPG6FDK67B3Rf4BipYqz/OKE/JXcddF8rmQJRT9u4fYbQGPoLw1kRhORh0Icw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0yndJjw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C153606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0yndJjw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9176C1F000CF;
	Tue, 24 Nov 2026 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537253;
	bh=K1IVmqjVuSEX+KqD0ppV/9OnyzGxfs37dPZx3G7QH6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V0yndJjw+MNYPiyxU7/VYZMsI1LgZslnoy38o1sRSTfE3IljRA+78OK2rRm3Dkk4Y
	 DuWLU4i3j9mix4pkZ+PD3R/oa4BWL5ZWbrGmxn/nBeo5emLT72RalgibShUWKIhHSl
	 kyX/5EiLyCgXgNjLAm488LfwVdcALZzSbP8fn7wddt/MgXFmXHfh7JJ4xwu8JSDVSO
	 1ngyshnKdPRqek+c6RB3SgGSafItSQNH7rU1l5WOvgn032E9NSLy/A29v9YfhXlEAp
	 XvA77uxIl3PqOX1kUE78eYgrVdBaV8TytgT7Z+P1P/4qk/Jf8Jk4GD5aYZ6tgh87xA
	 ybcz0bgNfLGvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] kprobes: Validate re-registration earlier in register_kretprobe()
Date: Tue, 24 Nov 2026 11:20:50 -0500
Message-ID: <20261124162040.947082-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124162040.947082-1-sashal@kernel.org>
References: <2026112410-hurried-barbell-533d@gregkh>
 <20261124162040.947082-1-sashal@kernel.org>
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
index 7b3fe9307fb1a..bc77406e5d7b0 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1483,52 +1483,61 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
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
@@ -1665,7 +1674,7 @@ int register_kprobe(struct kprobe *p)
 		return PTR_ERR(addr);
 	p->addr = addr;
 
-	ret = warn_kprobe_rereg(p);
+	ret = check_kprobe_rereg(p);
 	if (ret)
 		return ret;
 
@@ -2200,20 +2209,19 @@ int register_kretprobe(struct kretprobe *rp)
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

