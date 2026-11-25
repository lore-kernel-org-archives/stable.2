Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628371;
	b=a9SgYVw5CbxbI4HVmAqQVQXpXweaAUL6hqmxoKDvdQanQYE11mtrSc/L5p5EI8qUW0ZD
	 dxTThYDgoRnlQ/Ui2AjbNBBvaWnycyvAAMRa35D2cl+PIWCEJlBzWxW401Gq1tDKfYlLf
	 s0d8dBy+qLub/xdzUi0AxYSwUzFWPlsL4q0BJpopV7NjxoK5422S6aZeXZHJzm3PmYE0j
	 u+p+1JSTv0tosFOdjEhoCtbPQ08GM75gyut6GDyBHikbuqAa/MSLO2VqLc8BbP8C17qaw
	 VKdKwlKr0nPkhMuIhP2fDXoID9Yg8Qkt2MBR5h0cAknOZoEzW5Yn9xMtvuG78d4o4sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628371;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z0Mu5AO/BhqAsXLQBQ8Tmme9Vp9ROIqs5UO8CZxowhs=;
	b=0nMZNbB7WBgmOi4kNg4FGmBAwbUToiCPIBoZ/S/m6K5J+iPsaYjoSxhzRVxtaFc0NM6n
	 AUiz7Dj1ZZ/Tp7rT8wykUSq4qXBePZai6JN6n6NRlH8FWgSaa8v8Z4FDdg1d9Bn4/f1tL
	 H3pjveZLqZswcZpxIK4N+lLVAjxFJ0qomTBqb2BWW61ULAa1I8K7pFRWoiNAsYTaGEcGx
	 0tgpP4/0bmYDjPwdX0g0hR2CY10VvT3g5Q0VGCCWmeY/s4TzqrFGNxtOfU0N+XzWSTOI/
	 VwKYN0u/BG+rg9vWWq+qWC+IF+sbV5lnUelNnS3rcO539EAacK1UvxUunOHjMOhFaug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbxkC5k5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A10606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TbxkC5k5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616231F000C6;
	Wed, 25 Nov 2026 17:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628370;
	bh=Z0Mu5AO/BhqAsXLQBQ8Tmme9Vp9ROIqs5UO8CZxowhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbxkC5k5jDd3ajTk46RK4UYYwPjGtYhGe0Ei2wWoElA5M+MKlLiiW1Mq5zsz0LABr
	 qDhOTnHbPa3dok5GIMR2AODCw/2+HalCrkFNc1ZjyQXTreSAzD6+ADQYODX3wZdHFp
	 jW+ZaFv0IJby1tzjjvK2vEZR161eVEKB8qy5bjvyYJ/tI9waNvNfBqTfhn1aw7Us7i
	 +HXJOPI0sAFfeaX6y6NY/BxjFU7MOHvKdKKczVwsBuYI7raMhUay6vzucQofWSfLKv
	 XgIedPN4CC+y8mzxIVRQ4ra5aXvLFOrhC4yXArbSmfOaWXrWqyAgNYxO6VFHXPYmg4
	 pGJRmgGs5EYUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] kprobes: Switch ftrace ops when adding probe with post_handler
Date: Wed, 25 Nov 2026 12:39:29 -0500
Message-ID: <20261125173911.992833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112528-ascend-plastic-6007@gregkh>
References: <2026112528-ascend-plastic-6007@gregkh>
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
[ sashal: Replaced the scoped_guard(cpus_read_lock) block with explicit lock/unlock and an out: label, and kept the ret == 0 guard on the later disabled-state check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f05688f3acc55..4562a7d06c28e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1128,9 +1128,14 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
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
@@ -1265,16 +1270,12 @@ void kprobe_busy_end(void)
 }
 
 /* Add the new probe to 'ap->list'. */
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
@@ -1307,6 +1308,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 {
 	int ret = 0;
 	struct kprobe *ap = orig_p;
+	bool reset_post_handler = false;
+	bool ftrace_switch_ops = false;
 
 	cpus_read_lock();
 
@@ -1356,15 +1359,45 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
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
 	/* Copy the insn slot of 'p' to 'ap'. */
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
@@ -1372,6 +1405,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
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

