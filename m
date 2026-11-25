Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602893;
	b=dMNzqNiL4t/t7vYVHg0/yzSOIDMJPJILkwzhuE/uNsg9T+vwUWXxz90R/XMKEPqaXCci
	 GyMdHYURd0MTGuTft4UzT4USK/eDCat9R8T6Y0J4g0zkPSmQQLtjv1o0f8Q5XCQ5Ndk9M
	 cr4LRiRsagy6UCgLOTwl/1gWSgBqzi36/aBL+bXFysV8EbhTP+H4zVZ8p7QUETy3lEMic
	 Mnw4mnC7x9uTDY8iELJV42EHNexQ6a4zY8F6AJaB0ob5wxEHaR5RJA5MfwCQRFxK4HGUc
	 ND4nHozlxfiTmKcTV7qMp3xpORoCcDb8hf2CG1h85lIFJAwJCstBTDCd+HLJv3R72hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602893;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZWckMRa8W7xp8SSnG48IyPuD0jWdz+4JJrcFBOBzFpg=;
	b=HAd4bOyg3NocbqxPdS1OrUX2veuP3EYrSWTTG3zdkbQ3Rby3lojuD8FPMBL3vvlkvad7
	 sPag2/Z7gmGtcsuje8XUqC+je6bLkauLZ039UaVwtIRgS4LEuwXf6LQI4IvEW4RGn8kuG
	 uxcUQJjC1NBJpGKINbNI35GtLQLDrazyJ1bTp+sDTYCpmU9r9qSnf5CuJ+RXR+yyLaZFp
	 TTl+PuOru0utsUKpOjiVWqFlYGQV1YE2xroJ2zaRBz3GXk3WpjmdeW2RBAPbcWjcPxwHy
	 p7k3BsvhBs36G0IVHMebGr8f/wEtFfzP4/kHeSMvevH/CqXdGVR3bxa6zlu4f6bOmoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=p91sMKa0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A50606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=p91sMKa0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27891F000C6;
	Wed, 25 Nov 2026 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602893;
	bh=ZWckMRa8W7xp8SSnG48IyPuD0jWdz+4JJrcFBOBzFpg=;
	h=Subject:To:Cc:From:Date;
	b=p91sMKa0gICNB79RlkkKY6GXz+H7bv14+UaS6BEDjVBWLYLKptNBsZYOfvGAMHqkb
	 2nasWFK6MGl4wMk791OWaYtpcGlzY6JNFwcNodjuGx9lCynPeBqNWdTffumrQspdJa
	 2QOp0s0S+fYxFUrFckD9kILpHuaBWbvsLVkY7lz4=
Subject: FAILED: patch "[PATCH] kprobes: Switch ftrace ops when adding probe with" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:17:28 +0100
Message-ID: <2026112528-barn-hardhat-f9d4@gregkh>
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
git cherry-pick -x f60f98881b54b0cf36b61f41c91fbd93b76a2d9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112528-barn-hardhat-f9d4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f60f98881b54b0cf36b61f41c91fbd93b76a2d9c Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Wed, 11 Nov 2026 23:13:31 +0900
Subject: [PATCH] kprobes: Switch ftrace ops when adding probe with
 post_handler

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

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dddad1e01866..b6ff971df451 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1444,9 +1444,14 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
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
@@ -1575,17 +1580,13 @@ void kprobe_busy_end(void)
 }
 
 /* Add the new probe to 'ap->list'. */
-static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
+static void add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	/* A reused cooling probe is already unoptimized */
 	if (p->post_handler && !kprobe_unused(ap))
 		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */
 
 	list_add_rcu(&p->list, &ap->list);
-	if (p->post_handler && !ap->post_handler)
-		ap->post_handler = aggr_post_handler;
-
-	return 0;
 }
 
 /*
@@ -1618,6 +1619,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 {
 	int ret = 0;
 	struct kprobe *ap = orig_p;
+	bool reset_post_handler = false;
+	bool ftrace_switch_ops = false;
 
 	scoped_guard(cpus_read_lock) {
 		/* For preparing optimization, jump_label_text_reserved() is called */
@@ -1664,18 +1667,50 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 					| KPROBE_FLAG_DISABLED;
 		}
 
+		if (p->post_handler && !ap->post_handler) {
+			reset_post_handler = true;
+			if (kprobe_ftrace(ap) && !kprobes_all_disarmed &&
+			    !kprobe_disabled(ap))
+				ftrace_switch_ops = true;
+			else
+				ap->post_handler = aggr_post_handler;
+		}
+
 		/* Copy the insn slot of 'p' to 'ap'. */
 		copy_kprobe(ap, p);
-		ret = add_new_kprobe(ap, p);
+		if (!ftrace_switch_ops)
+			add_new_kprobe(ap, p);
 	}
 
-	if (ret == 0 && kprobe_disabled(ap) && !kprobe_disabled(p)) {
+	if (ftrace_switch_ops) {
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
+	if (kprobe_disabled(ap) && !kprobe_disabled(p)) {
 		ap->flags &= ~KPROBE_FLAG_DISABLED;
 		if (!kprobes_all_disarmed) {
 			/* Arm the breakpoint again. */
 			ret = arm_kprobe(ap);
 			if (ret) {
 				ap->flags |= KPROBE_FLAG_DISABLED;
+				if (reset_post_handler)
+					ap->post_handler = NULL;
 				list_del_rcu(&p->list);
 				synchronize_rcu();
 			}

