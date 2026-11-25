Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629361;
	b=yxhyErUM0CjnDFSscwikVIIPuCO87fEzqjDKn2SKURSrjMry6zIZo2EHaEJW7jeR4XZ5
	 pXlFnpp1V+Bw7+FfmBgHodVfB225t1PwoMJegQ0fcWUVpmsoDZK/QSnC0m0uMEp5+lfAZ
	 AgpmtKBwgxAplw8c4WVyK7DVUvQsxb7sJvtsjx6kXaB0Uj/JdQ9zVt/P+uT3aaui8RraK
	 d6AgswyIM+0aLL4fcGgAfEvS1TLpX+FtbK7rD2mMfmlXuDETRqZYc5snpSYujMhe/hpn9
	 moRRzoG9TBN84y9ecL0uP5fq0KVva9RWqx9Nnnz9zl/rFoXdxsNBgtrhBEWxOzaoxzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629361;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9IIZfaql8LeK8VO1e8BPbRSxHG7/xq9HBPgSYzMas8M=;
	b=lHx0H7LGtseMsKIqhuVK6UkE/lfSzOPYV/Do+dPlzal7VtUV/urbnNNT6GR6sYGv7lpL
	 gD6MEbTmC06SbPD8MWnJJGiS9jyElL8ewWioJBCYYzkOPScILr4Oed3g2e3nJzy5xG642
	 bGVHsMPqm2FKGk6cJraqaOXf7b+lofCdXJ1ssyxbiOkCRZka03/12F7nT+8hfo6kK9pVH
	 F5LkRaaP6PVyamarrt+7Hso5AN7Np1mC+4WEFaBcHQDypPAhvacHQ6LIggTVl+yDjoVA/
	 DsmdmB/B/KGhCp+9YWUqen7JwYbJ/7c7PVKhPt9y2nthQaSQjMB7ZgF53E2MXbJt/Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/LIYqOa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C81606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/LIYqOa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF41F000ED;
	Wed, 25 Nov 2026 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629361;
	bh=9IIZfaql8LeK8VO1e8BPbRSxHG7/xq9HBPgSYzMas8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y/LIYqOaAMxc/HaoKjsFQ9Eofj0PMu1ORGc4IJHtNqbai3bPFoAXVDs/5c2rVHqtH
	 Mc3gFaEMRb8IfxqjN2F+ArRXmt1X/nsB9VNvXgEGBemxwPg72K5zzXAXRqiKlZPqaN
	 ahzpNoAAFojOmkjI68okgI6EI16i6ASOxlAPFhS8fHwA0fItmxfJdMVf1D8JxI4bGe
	 ZrzypMK4IzBdDsxAQvwv/i+CkhMocUdf5yrBRqq54vb9lLjahlogNCNG83TxxIM8iI
	 FOJLi7DqEL0KMTh/+bsc1pu3VF+nX46dJphj8OT6OxR4WVtohPK2V9rvNZB/WJZA4n
	 p//UIJFL6JAQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] kprobes: Switch ftrace ops when adding probe with post_handler
Date: Wed, 25 Nov 2026 12:55:59 -0500
Message-ID: <20261125175539.1074874-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112529-fragility-commence-4ad2@gregkh>
References: <2026112529-fragility-commence-4ad2@gregkh>
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
[ sashal: Adapted to older context: kept the older error message text, used cpus_read_lock()/unlock() instead of scoped_guard, and kept the ret == 0 check in the final block. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4f2d0638644c8..cc491e663a686 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1097,9 +1097,14 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	(*cnt)--;
 
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
-	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
-		  p->addr, ret);
-	return ret;
+	if (WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
+		      p->addr, ret)) {
+		if (*cnt == 0)
+			register_ftrace_function(ops);
+		(*cnt)++;
+		return ret;
+	}
+	return 0;
 }
 
 static int disarm_kprobe_ftrace(struct kprobe *p)
@@ -1382,16 +1387,12 @@ static void cleanup_rp_inst(struct kretprobe *rp)
 NOKPROBE_SYMBOL(cleanup_rp_inst);
 
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
@@ -1426,6 +1427,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 {
 	int ret = 0;
 	struct kprobe *ap = orig_p;
+	bool reset_post_handler = false;
+	bool ftrace_switch_ops = false;
 
 	cpus_read_lock();
 
@@ -1475,15 +1478,45 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
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
@@ -1491,6 +1524,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
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

