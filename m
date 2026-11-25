Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628598;
	b=lBr2bH1XWU2OsZNbgAYHSI8II8QZiKm8lvtJEtOFyk8KozEIJ+lm1LRsgLZrOqAcketX
	 d1KVY6Jny5/Z9+8nv1yMCl8vh37QvEiTiqP6XLld1KYVZVqMtuBf6XF8imJQk1QMyNxv4
	 fM7sF48b+NWpmQNVB7XAOgfAL3ImlUfNwxvcAbiHH7b69yEubNZOWPGFTNxzjgF90ll5p
	 oSepGx7gv7aFmHoz4ZKjVnFgNUwPmd4nkdv5dxJRRENgcZlAnbRPfKSaanQe/Oxz2mezl
	 UpI3y/t/tyeSVMg8SCNEAxxUAS3coJpxpxvfKA9UOzYli/u8ct1XCi8jMrb531T8JDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628598;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MJL2DtF94FxZY9fvDdmfoldX2GX6/hBotVa7aFs77ag=;
	b=x0EfzpdG3mbevCCoCU+otwz8c1G3VmWLebhevhaJpv8OAARl9HiW62XXAi9666E41Cy/
	 QUZNdNiWey35FMJ5CejVHiSzz/vxLkeLUYeXA/NxonJksnkvNUiAPZCa/U5p4lRPwsctf
	 NF98ld7Ha9KpFQ6jyBfk9g14wOd3t7VPfXBn8s7V4BajqbC0OcpL4Yn8PU7JRPZaBzudJ
	 IwEd7V0xl6O93C/fOoWIlrKgnAPPCrQrV+RxVDHAJ7Q9KKX3IjdBiOjMFoP+IWoKlXRqk
	 VK2cTNYTQ65D80ZzQVDInSbkibfzKoPw9M4R+bQvwC39xbaUqj0n4qhRGE1ZVSxfG8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Pp/fT7Na";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FA606A682
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pp/fT7Na
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BC61F000EC;
	Wed, 25 Nov 2026 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628597;
	bh=MJL2DtF94FxZY9fvDdmfoldX2GX6/hBotVa7aFs77ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pp/fT7NaJydDv8HazgCh+Nax6tLapQ51kaRNb2mv+yBv/nWsTITAXo3IAIu1mcpzY
	 FRQZvwB5pelFCVGKiMjBF10ANvwCAf53ob3nG7aAkQLUTSflSObGmWn/aXfjSPkZj2
	 Yc1kfWxPU3jwoMsXhulbWysqqVWcRMgrEprGJgsetJdcvoB8+UsC8mgXq7zFtpn426
	 zg8BmWc1ZZB4j8K6gvnbb97AiGj9cBfzmClhd3UzvalrNQqlWXO5ktvxTF7/jsQ12G
	 ApKiZTIxiApmpymi24grlpriGo5glLD37ggLdAQHkZu3vmQaaeBzivTBMkzXRo8DSw
	 Im0Z+OP6L1OJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] kprobes: Switch ftrace ops when adding probe with post_handler
Date: Wed, 25 Nov 2026 12:43:15 -0500
Message-ID: <20261125174255.1021104-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112528-barn-hardhat-f9d4@gregkh>
References: <2026112528-barn-hardhat-f9d4@gregkh>
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
[ sashal: Adapted to the older code by replacing scoped_guard(cpus_read_lock) with explicit cpus_read_lock()/unlock calls and dropping the kprobe_unused(ap) check in add_new_kprobe(), with the ftrace ops switch placed after the unlock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 58c04d6d1b375..3ae0dd128bb9b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1123,9 +1123,14 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
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
@@ -1255,16 +1260,12 @@ void kprobe_busy_end(void)
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
@@ -1297,6 +1298,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 {
 	int ret = 0;
 	struct kprobe *ap = orig_p;
+	bool reset_post_handler = false;
+	bool ftrace_switch_ops = false;
 
 	cpus_read_lock();
 
@@ -1346,15 +1349,45 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
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
@@ -1362,6 +1395,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
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

