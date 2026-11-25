Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628981;
	b=MmESA3ofqV9TPJL9kUbPqc0zIDofn1QQfAnIDr/K0vrAfgGEgwalFH2uxMCWeDF8m+zB
	 lYuMjV4e+k8wy67fu5QE1vfTsTJQYmWe3Z7f3tpM+6TkyvIhOEdQQtwPgvP+wDCdu2mIe
	 JlOap8S6xypDxq55Km5kA4z1ugmqb3AGk/hRFBIl4iSEA8dYdjied8pfsvj3R6GUJGDaU
	 hRcOcrigs6U0gJrHB9zmBSnlHqOL5VnLwyUFb+yBGFtK9KGMWRXpJ5WKaAOtXX9F3/4be
	 rsPVAi93oQy7UMhbjRxD3kyuncFifvM2JGmXYtWTHnQrJzHvQV1LprOftLK10o2tvPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628981;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uySkP+5sxNylgt6fs5CpygCl25AsXDw7BalnMfsy3/o=;
	b=jPkyQV8fhHNjJtPi1pW+Xbn27xQ9KVMzgR3mmplQunHU2BhBt1N3XZih1BLg8PhSK/hJ
	 pr05TUiJnGJwT2rjOZQo/rkPzTJUgJhpAs9F6zhi5sqvAzwceqzO8YPQ+xBlM7k7Jde+a
	 OOdEMSuO+VrMPJNsR7lbZY9Vu65x+nQ/YxpsDN3fDMFBFYmFnP53esbe26NvNjGlSAnUS
	 +0pv33GsNdj/sZJCqBQKHgX1V03Gk68V8Q0eZO+5YYJypFTvdemoE5peh9UCUgfMGfibE
	 JEEKYKGy1b0Y+Sci3O+sr8AmG6cuUbODnVKJe+yFdrJnJXulm0/l1yGPV1CYWj7PXJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3vA8WgA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685FE606A332
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3vA8WgA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387AB1F000CA;
	Wed, 25 Nov 2026 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628980;
	bh=uySkP+5sxNylgt6fs5CpygCl25AsXDw7BalnMfsy3/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3vA8WgAMPxGtVsUaVczZ8NJcJ5EsiQKn5607WbXKZNLQy73QAhBghpr5D9AX0vr+
	 v5YXF8y8mo9JvdrbyztJOBQxZDe2eQfdRohizm0N2A8H2NhVglTFj89/JYqCCLMVuI
	 HuGREaOdNe4qFZXjx3RX86gH8RBLgIk4ge5xFa/IkjjTPQn23snTw2LIe0QU32ESwE
	 FxP66A3zs93KFZ1wPQIU8FYwlZOv1EdksJhAz3bGjY9StNjCqcjal05zFE2lYZAA9U
	 OeOBj1kxIfeSFwSdzjj/CPADt2VOSQ5v+Kje9M3oRCzBFgA9yufnlgMVWQOa9zOsb2
	 lb/LhN9NXP8Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] kprobes: Switch ftrace ops when adding probe with post_handler
Date: Wed, 25 Nov 2026 12:49:38 -0500
Message-ID: <20261125174917.1037795-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112529-observer-seventy-3bee@gregkh>
References: <2026112529-observer-seventy-3bee@gregkh>
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

[ Upstream commit f60f98881b54b0cf36b61f41c91fbd93b76a2d9c ]

When an ftrace-based kprobe is registered without a post_handler, it is
armed using kprobe_ftrace_ops. If a second probe with a post_handler is
subsequently registered at the same address, register_aggr_kprobe() sets
ap->post_handler to aggr_post_handler, but leaves the probe armed using
kprobe_ftrace_ops.

When the probe is later disarmed or disabled, disarm_kprobe_ftrace()
checks whether p->post_handler is non-NULL and attempts to disarm from
kprobe_ipmodify_ops. This fails with -ENOENT, decrements
kprobe_ipmodify_enabled below zero, leaves the probe armed on
kprobe_ftrace_ops, and aborts unregistration, leading to a use-after-free
if the probe module is unloaded.

Switch the armed probe from kprobe_ftrace_ops to kprobe_ipmodify_ops in
register_aggr_kprobe() outside of text_mutex and cpus_read_lock to avoid
lockdep and deadlock issues when modifying ftrace code. Defer adding the
new probe onto ap->list until the ftrace ops switch completes so that the
new probe's handlers are not published prematurely while ap is still on
kprobe_ftrace_ops, and mark ap disabled if rollback re-arming fails.
Also restore ftrace ops registration and counter if ftrace_set_filter_ip()
fails in __disarm_kprobe_ftrace().

Link: https://lore.kernel.org/all/179440641120.328088.15542754095040659094.stgit@devnote2/

Fixes: 5dd7caf0bdc5 ("kprobes: Skip clearing aggrprobe's post_handler in kprobe-on-ftrace case")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ sashal: Replaced scoped_guard(cpus_read_lock) with cpus_read_lock()/unlock(), placed the new ftrace-switch block accordingly, and kept the existing ret == 0 guard; newer-tree context lines are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f2bcfae09fd9d..e392d4dedb84b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1096,9 +1096,14 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	(*cnt)--;
 
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
-	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (error %d)\n",
-		  p->addr, ret);
-	return ret;
+	if (WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (error %d)\n",
+		      p->addr, ret)) {
+		if (*cnt == 0)
+			register_ftrace_function(ops);
+		(*cnt)++;
+		return ret;
+	}
+	return 0;
 }
 
 static int disarm_kprobe_ftrace(struct kprobe *p)
@@ -1297,16 +1302,12 @@ static inline void free_rp_inst(struct kretprobe *rp)
 }
 
 /* Add the new probe to ap->list */
-static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
+static void add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	if (p->post_handler)
 		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */
 
 	list_add_rcu(&p->list, &ap->list);
-	if (p->post_handler && !ap->post_handler)
-		ap->post_handler = aggr_post_handler;
-
-	return 0;
 }
 
 /*
@@ -1340,6 +1341,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 {
 	int ret = 0;
 	struct kprobe *ap = orig_p;
+	bool reset_post_handler = false;
+	bool ftrace_switch_ops = false;
 
 	cpus_read_lock();
 
@@ -1389,15 +1392,45 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 			    | KPROBE_FLAG_DISABLED;
 	}
 
+	if (p->post_handler && !ap->post_handler) {
+		reset_post_handler = true;
+		if (kprobe_ftrace(ap) && !kprobes_all_disarmed &&
+		    !kprobe_disabled(ap))
+			ftrace_switch_ops = true;
+		else
+			ap->post_handler = aggr_post_handler;
+	}
+
 	/* Copy ap's insn slot to p */
 	copy_kprobe(ap, p);
-	ret = add_new_kprobe(ap, p);
+	if (!ftrace_switch_ops)
+		add_new_kprobe(ap, p);
 
 out:
 	mutex_unlock(&text_mutex);
 	jump_label_unlock();
 	cpus_read_unlock();
 
+	if (ret == 0 && ftrace_switch_ops) {
+		/*
+		 * Must switch ftrace ops outside of text_mutex and cpus_read_lock
+		 * to prevent deadlocks when ftrace code modification acquires text_mutex.
+		 */
+		ret = disarm_kprobe_ftrace(ap);
+		if (ret)
+			return ret;
+
+		ap->post_handler = aggr_post_handler;
+		ret = arm_kprobe_ftrace(ap);
+		if (ret) {
+			ap->post_handler = NULL;
+			if (arm_kprobe_ftrace(ap))
+				ap->flags |= KPROBE_FLAG_DISABLED;
+			return ret;
+		}
+		add_new_kprobe(ap, p);
+	}
+
 	if (ret == 0 && kprobe_disabled(ap) && !kprobe_disabled(p)) {
 		ap->flags &= ~KPROBE_FLAG_DISABLED;
 		if (!kprobes_all_disarmed) {
@@ -1405,6 +1438,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 			ret = arm_kprobe(ap);
 			if (ret) {
 				ap->flags |= KPROBE_FLAG_DISABLED;
+				if (reset_post_handler)
+					ap->post_handler = NULL;
 				list_del_rcu(&p->list);
 				synchronize_rcu();
 			}
-- 
2.53.0

