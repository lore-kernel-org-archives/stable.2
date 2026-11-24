Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538162;
	b=u3nYAeYUC6ZX5XONEe8yCBG8Y93i173FWdms5k8CELKZNtRDUp4pnMwhQ1uOYCVfA7yz
	 A17231vHhMsThJ1bIRsFYuMYWTJ519gIZgaPI0eVxjtyIYRG2fKEjpLk2kcGdn0J8J5pG
	 maWUOC+HH0KGaNdD1hlF9MRS4zuooDDV5gdrft6WmVu89dwN3FfgSFIBNJTJDN1+m0/pj
	 GnKPW+jyPsBtqEeJlh1L5cG+jj6BGC4+kO1pTuzp9/9ZTq9nhDWy5QByqlgdPu37Cq77l
	 fTCUa8swg7ChOgSgXnbd7DXEu7MsKFaomX8T4BP9Tg2yz2C+6RNCd/IuUik1UPK+vHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538162;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JkxMY4cgXVG9lMu97Qd48dahWnxl46iqf14LFnOxY9E=;
	b=zLGPyg6atp+QxAdZ9Xlh4Ata0zIt2+jlvUKnDVcVHtkVIHAbqU/fNIROzi2VdRd0uOzi
	 rV2uTVGtwaZgnlf9jgLVlrnMDkpm+2vGIJGUNqdH4uaeAAdMjgw/r5EJwD7Hzqi2RtTHV
	 kxYXVs4XDKGdCyYqUp1qRuowkLPR8qJcvRVydobWPt3WarVS3XR6BGTjKk91gPcZH3m8E
	 DAOSRYCUg+ZMBEToLCsuqzMGUTr1oHV11bHRKoWTAcIaxEjbEuu9aidAnh3RdXUXHh67o
	 sJBINfdD5bU2rpMo2382pUJGO6A8EhFZsindADNog7VM1eYiaZtEUs1+xD5vs0l+spA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBn9t+c2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB7606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBn9t+c2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F671F000C0;
	Tue, 24 Nov 2026 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795538161;
	bh=JkxMY4cgXVG9lMu97Qd48dahWnxl46iqf14LFnOxY9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBn9t+c2scWMK1seJ8veqm+2UffSSojpcQYLNox8d2MqBmY8igeEyxRdC1NuRNC3w
	 vap8lroo6tP3ZKgewPySJFde53PGIKyUZnYL2wo+XBHC0kTdp753y97rcnpgfIvPhL
	 881btaccL4intkVxQA9BBgINB1VL8RFPLrA9zY+ljVN3BoNUz2izYazPHFodO1qnhG
	 bCYszr3JMkVkri+Q0Xsv396hK25TI0klIX1ZOagAQG2OSvR+2Y86udoNOHEh9wU95B
	 TVDZtTxI2AgylAk72GOAM7qJh6yTkWR8c+qIgnDuQpUcoE7RcpBWJr8KdnXa8nqHvu
	 4t6CWn1aGSRcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] kprobes: Validate re-registration earlier in register_kretprobe()
Date: Tue, 24 Nov 2026 11:36:00 -0500
Message-ID: <20261124163535.1338624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112410-imitate-account-4881@gregkh>
References: <2026112410-imitate-account-4881@gregkh>
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
[ sashal: Replaced the combined helper call with kprobe_addr() followed by kprobe_on_func_entry(addr, NULL, 0). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 59 ++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f2bcfae09fd9d..90e58fa507db6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1498,37 +1498,43 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
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
 
-/*
- * Warn and return error if the kprobe is being re-registered since
- * there must be a software bug.
- */
-static inline int warn_kprobe_rereg(struct kprobe *p)
+/* Return error if the kprobe is being re-registered */
+static inline int check_kprobe_rereg_at(struct kprobe *p, kprobe_opcode_t *addr)
 {
 	int ret = 0;
 
 	mutex_lock(&kprobe_mutex);
-	if (WARN_ON_ONCE(__get_valid_kprobe(p)))
+	if (__get_valid_kprobe_at(p, addr))
 		ret = -EINVAL;
 	mutex_unlock(&kprobe_mutex);
 
@@ -1633,7 +1639,7 @@ int register_kprobe(struct kprobe *p)
 		return PTR_ERR(addr);
 	p->addr = addr;
 
-	ret = warn_kprobe_rereg(p);
+	ret = check_kprobe_rereg_at(p, addr);
 	if (ret)
 		return ret;
 
@@ -1714,7 +1720,7 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
 	int ret;
 
 	/* Get an original kprobe for return */
-	orig_p = __get_valid_kprobe(p);
+	orig_p = __get_valid_kprobe_at(p, p->addr);
 	if (unlikely(orig_p == NULL))
 		return ERR_PTR(-EINVAL);
 
@@ -2016,19 +2022,18 @@ int register_kretprobe(struct kretprobe *rp)
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
-	if (rp->kp.addr && warn_kprobe_rereg(&rp->kp))
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
@@ -2216,7 +2221,7 @@ int enable_kprobe(struct kprobe *kp)
 	mutex_lock(&kprobe_mutex);
 
 	/* Check whether specified probe is valid. */
-	p = __get_valid_kprobe(kp);
+	p = __get_valid_kprobe_at(kp, kp->addr);
 	if (unlikely(p == NULL)) {
 		ret = -EINVAL;
 		goto out;
-- 
2.53.0

