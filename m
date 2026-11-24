Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540893;
	b=gAEIi/1Bz8sljFShj+EZUhpnrvBYOgBGP0eibvjCmAfi0ixkvUI+98gBV5q68IuxknDl
	 KIM3jR06RSEOjsgwfNY5L4qmRdFZJX04gCE7JCwBasfwudAeDm/079BtVMh/7vOTikDRK
	 ChnOuwOr3VWru24JAX4eLQVcm+Yk3AmEHcHJo44VRzwNJP+30VR6eAo4rxe3V0lt4oM/X
	 Ck60KXGqsSE3Y/JyISYjfW76nuBikEA9ryLkI9vU6xvZhFcfUIwXEFfT6PwH3JURL/YgG
	 IkRFEaN3HiKAR9xhAIn1xgEQj6hZgTuzD460uFHdcCDB3c4Bs1OfgXPilbcsFAtlzhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uwY/0A1OSyJ1Rbh//vO8ifmxEm4TO3RKzRf4I66f87M=;
	b=slbycOTe5te1xgyHcslbrSIi5oK+53IIpIW+itJI3P64L3k/jngyktSZzWhQiXbBVzLa
	 JcJDEJLxLLbl2H+IpjXzjikvg/5MqQ6rHVXcAgZJZyEfO9U3y9ftKkm6lj1fpUXw8nDdw
	 AhQgYoDPPrHIGIaZP1A/SiVgyEkZEK4W0kk4+vCULamrcKhq3DUhjZhthmUaSa001Clea
	 n6rE87SZMb3HEck1XSPBjUxJXAiGjAnkbGB79wUEXnaArMwXKhDIf6SRhKjYhqj/zTNom
	 zNF6tMCqrErp/H7r8GLVY4S/OAPrvTcm0sol1GwaIMfJThUM6y+WdcrUPm3MErCescQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WG2Hs1so;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E2606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WG2Hs1so
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FF51F000D0;
	Tue, 24 Nov 2026 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540893;
	bh=uwY/0A1OSyJ1Rbh//vO8ifmxEm4TO3RKzRf4I66f87M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WG2Hs1so7sPaCqwQYAcBTGp8HmDs5UuHyOZzLKf/2y1jV7BrpkmpUQaxCfrKasa7J
	 hY6dTWsAJ+M8Z9q8PzjZnwvi+K+CM/L98bF3IWAVcEpmG6dmJAv8f6FNMB42rQfkFy
	 Nv42vOZjnnBzHO4VqCsP63rATS1KjUM8uIQ38Cl7wNaljK8XHQd082fOtL2uFeTNQN
	 Fn1PX+Yocn1b/qatuw7R9CujCKe4rN7u7/udc4A+cmIR6N6guX8Frytwh2HCYHdr6h
	 IPnKAd1JJCDDrw7s565qdYC0xeP9Df3G3Eoo0KUYsZYso2AoNxorHrW+oxXTOZCqiG
	 WZF8ly0HPPT8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] kprobes: Validate re-registration earlier in register_kretprobe()
Date: Tue, 24 Nov 2026 12:21:31 -0500
Message-ID: <20261124171956.1702364-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112411-outpost-baked-168d@gregkh>
References: <2026112411-outpost-baked-168d@gregkh>
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
[ sashal: Replaced the combined address and function-entry check with kprobe_addr() followed by kprobe_on_func_entry(addr, NULL, 0). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 54 +++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4f2d0638644c8..7ec55356c82db 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1584,34 +1584,43 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 }
 
 /* Check passed kprobe is valid and return kprobe in kprobe_table. */
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
 
-	if (p != ap) {
-		list_for_each_entry(list_p, &ap->list, list)
-			if (list_p == p)
-			/* kprobe p is a valid probe */
-				goto valid;
-		return NULL;
+	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
+	hlist_for_each_entry_rcu(ap, head, hlist,
+				 lockdep_is_held(&kprobe_mutex)) {
+		if (ap == p) {
+			p->addr = addr;
+			return ap;
+		}
+		if (ap->addr == addr && kprobe_aggrprobe(ap)) {
+			list_for_each_entry(list_p, &ap->list, list) {
+				if (list_p == p) {
+					p->addr = addr;
+					return ap;
+				}
+			}
+		}
 	}
-valid:
-	return ap;
+
+	return NULL;
 }
 
 /* Return error if the kprobe is being re-registered */
-static inline int check_kprobe_rereg(struct kprobe *p)
+static inline int check_kprobe_rereg_at(struct kprobe *p, kprobe_opcode_t *addr)
 {
 	int ret = 0;
 
 	mutex_lock(&kprobe_mutex);
-	if (__get_valid_kprobe(p))
+	if (__get_valid_kprobe_at(p, addr))
 		ret = -EINVAL;
 	mutex_unlock(&kprobe_mutex);
 
@@ -1716,7 +1725,7 @@ int register_kprobe(struct kprobe *p)
 		return PTR_ERR(addr);
 	p->addr = addr;
 
-	ret = check_kprobe_rereg(p);
+	ret = check_kprobe_rereg_at(p, p->addr);
 	if (ret)
 		return ret;
 
@@ -1797,7 +1806,7 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
 	int ret;
 
 	/* Get an original kprobe for return */
-	orig_p = __get_valid_kprobe(p);
+	orig_p = __get_valid_kprobe_at(p, p->addr);
 	if (unlikely(orig_p == NULL))
 		return ERR_PTR(-EINVAL);
 
@@ -2149,19 +2158,18 @@ int register_kretprobe(struct kretprobe *rp)
 	int i;
 	void *addr;
 
-	ret = kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset);
+	addr = kprobe_addr(&rp->kp);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
+
+	ret = kprobe_on_func_entry(addr, NULL, 0);
 	if (ret)
 		return ret;
 
-	/* If only rp->kp.addr is specified, check reregistering kprobes */
-	if (rp->kp.addr && check_kprobe_rereg(&rp->kp))
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
@@ -2345,7 +2353,7 @@ int enable_kprobe(struct kprobe *kp)
 	mutex_lock(&kprobe_mutex);
 
 	/* Check whether specified probe is valid. */
-	p = __get_valid_kprobe(kp);
+	p = __get_valid_kprobe_at(kp, kp->addr);
 	if (unlikely(p == NULL)) {
 		ret = -EINVAL;
 		goto out;
-- 
2.53.0

