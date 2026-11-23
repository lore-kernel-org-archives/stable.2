Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452847;
	b=BWeTRKTFGxY027p4COArqN6pKJab9kg0Ua4EBEekBlofBYG7JfGKj8bwTcRH+lGhSCdz
	 OyCgYAHuYCMOV8cyWkK+LZqRQmi9AAdhAH1BVX3A/lvHWKTrf5EeBGA0VxdHcsoxF9xkJ
	 KFI5FP8HdFwUwHqHsYY+xMX7sVaCGU2g4XCZww+q3plpykQFSt7SMW6+pRJ+9MZJkS2ro
	 5xz7+R61VgB01TAFbJTHPdagLC/nkXzm0K/723zpolrIc1A+vMRAorF8ZmajdwD/1tRHm
	 DlrApj1zN1nhoLaP5tktkvA0Z428jnxVFcwkf0dWMqyKA4H87ff647iKRh+6fUAZsHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7UR94Er5BqhFrRYk1QbhHUlLQc2SlLi1Cmg4CSQYG1U=;
	b=RBmixpaw32ILwZ+Dkh80fPBOtSOfvw6zSWYSal7WUhapFfRIzZcZWxjZS+jso5tH2dhu
	 4rpUSqFghf0wXp84yPKML7kwRkxMzaRafDl0+PDB8mfeHm9JnLE9bhSvIulxRUQMX2De9
	 nnEwBzjWrW36UMF7P/uIBdskAua8FyOGMd5WvKgQVfMXKEvvJ0/aFLQkQ8WxqXYNMV8iW
	 hRAo7xcFXriAke6NriUBFzFOjP4qF8l6I1g5g1oOyTlvTZVQLO7rKxUzsyxS6OHcGCaMq
	 BM/aRUZvABsSvnX/ntE5Dr/tSilNCD/Z9k+uOhFoRm3ZGzPydp8AaZcbBtu3JbbdR9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxzOSLtG;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE44606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DE44606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxzOSLtG
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3b4be95e0afso182556a91.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452846; x=1796057646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7UR94Er5BqhFrRYk1QbhHUlLQc2SlLi1Cmg4CSQYG1U=;
        b=sxzOSLtGJQ+BuRHajhKDGpJSMRmx8ZiqROL8NCU/7vmoobzr3tFNkiO/Le+/wFPCN4
         L7vqiTnL7HEUwtaRINp2urMi4hUR+a0b4CMwUba7xTwapJI7n2sonB9JJ3183agZwxMi
         ZgyG6yJDQ9HtJjs8W0+8FfqI5mbxMGDr0wqgp5i7jPiSN1fCZKQbTpd6gGhbMImT0u1d
         7jaPuRDk2mcY71gWdI+RmvSB0Dznrp/G6rcbucrN1FQMgGOa8v0Pqa+ym2MoF71WQLXm
         OXq6f747kU3pBef3r06/Z2+bWAzWx4HT1Nw9FTgxrGRENaG7cz5neMhpbKUDV79qzZps
         DQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452846; x=1796057646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7UR94Er5BqhFrRYk1QbhHUlLQc2SlLi1Cmg4CSQYG1U=;
        b=FSooG1fcK27rLIWNOGnOTBhkvFsoUudIDr/bpfiXeSeWPBKp0os81b8QfmbsWagoim
         Dc6jCjyKSrJnmMDIJqlIK6FfuTdAIDkQKvQIBzkAwbxbcq8BfQX0ZPEUM9JBwKE5M7eb
         dpDevOANWQkuUAZE7rAhIgnRFl1INa4nj6JRxXMIMeVZvPGlqGOKNouaAE01Y4f9NJy8
         7pmAe+su89HyN+kJIuhgI4ott5g0LUVPFEFUaWE7aUR2686i31PEpbXHkFB15hb3+lyl
         GgqYaxw5SOvvF8/7eQtQCG1zongB3UKanlcFmofLFPQ9n9AdflOuw0OZOXXq9RNasEud
         al0w==
X-Forwarded-Encrypted: i=1; AL+hErFxcXAywxdS1iNSs/E3rVsxutAIwvML0CTjvzWGyT0aFSXxdJume5lszqQ5ZAxSJ8jOAH0KBR0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G7HUafV93JwWZ2Vct2qjw+Z8k9X1McxcMb4ellivUOZFyNKds
	z7k40BcKHqJovaCnu84mIpSEl+5n/s4bTtwEqeQcRI01I4OWwk/4SuCE
X-Gm-Gg: AZFdTZdsFs2S74LiaR3Zttkco4OL6PSBB5rxxi/ixf6NDmGI66diS+7nBo3TBVkH9aF
	nUsB76KiAj55HBk7QEOeYF02HIt/m39ZJXkHZz9bAzZFx6UhAcaTfJGuvY/sClsj6CelLvhrO/f
	24uCV7of3ejE0fRkJwiu+l63i+/Sewd0HkkbOboBbVp76wE49oF0QZLgnfYAdV8zTzboLqZllli
	HRDXsR2uCyRNYfvHfCHInPho/grwcZxgfqAbQ5and1NG86BU35DrKXNkm76JYMrHUMbq6ckWQAN
	NZ3IRvOoW8VDEs/qw7CafWX+UkBM3SEAeY8mrgpC08i860iG61P2LuOHe0+bs5R5X0VohIyRJmu
	+8CeVGp3Ze1GIFmEBO0kHgFTTGQJqhzMpW9DNIImtg3Hdwj/+9I845A9PeNDM3lGn50bqJbjLlH
	OCCYhO/1Ohs3O0bEGQ89l26r06JPzSkUtv+zVtyAApjD6bzcYQpeWzA8sX2vAOnEfbMDIdTNHcK
	6ehvsuR/8DW1QN/j8GZaFb4lH+s2T8peSPx7zutexIKL3AuhIpTF34E6le+O5zKEeNKPn71RmzK
	J+VdYFW++oU8VtSw/xP6vdb0epyjacltCVzSKRmLexRz4NenH6OUZLiYf2MmKCoMrCM5eeLTa98
	/VQ==
X-Received: by 2002:a17:90b:4ac5:b0:3ad:b7d1:8631 with SMTP id 98e67ed59e1d1-3b41c8d95cfmr11438729a91.17.1795452845785;
        Mon, 23 Nov 2026 08:54:05 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b457a58d04sm6880922a91.0.2026.11.23.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:54:05 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: kees@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	john.johansen@canonical.com
Cc: linux-security-module@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] yama: fix use-after-free read of a dead PR_SET_PTRACER tracer
Date: Tue, 24 Nov 2026 00:53:57 +0800
Message-ID: <20261123165357.4092273-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A PR_SET_PTRACER relation stores a bare pointer to the tracer's
task_struct.  When the tracer dies, its task_struct is freed via
call_rcu(), and the relation is only marked invalid from
security_task_free(), i.e. from the same RCU callback that frees the
task.  A reader that enters rcu_read_lock() after the callback was
queued is not protected against it: ptracer_exception_found() can read
relation->invalid while it is still false and then dereference the
already freed tracer in task_is_descendant().

This is a slab-use-after-free read during ptrace access checks, e.g.
via process_vm_readv(), on mainline v7.4-rc4 (KASAN build):

BUG: KASAN: slab-use-after-free in task_is_descendant+0x1a3/0x1b0
Read of size 4 at addr ffff88810a46c598 by task poc/167
CPU: 6 UID: 1000 PID: 167 Comm: poc
Call Trace:
 <TASK>
 kasan_report+0xce/0x100
 task_is_descendant+0x1a3/0x1b0
 yama_ptrace_access_check+0x2ea/0x410
 security_ptrace_access_check+0x34/0x50
 ptrace_may_access+0x26/0x40
 mm_access+0x139/0x200
 process_vm_rw_core.constprop.0+0x1ab/0x7c0
 process_vm_rw+0x188/0x230
 __x64_sys_process_vm_readv+0xdd/0x1b0
 do_syscall_64+0xea/0x4f0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Keep the tracer's struct pid alive for the lifetime of the relation and
resolve it with pid_task() under RCU at access-check time.  Pinning the
task_struct itself would not work: the relation is only invalidated from
yama_task_free(), which runs when the tracer's task_struct is finally
released, so a task reference would keep the relation, and therefore the
task, alive forever.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: 93b69d437eff ("Yama: add RCU to drop read locking")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 security/yama/yama_lsm.c | 42 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index cef3776cf3b2d..fd394c24e4357 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -29,7 +29,16 @@ static int ptrace_scope = YAMA_SCOPE_RELATIONAL;
 
 /* describe a ptrace relationship for potential exception */
 struct ptrace_relation {
+	/*
+	 * The tracer task cannot be pinned here: the relation is only
+	 * invalidated from yama_task_free(), which runs when the tracer's
+	 * task_struct is finally released.  Holding a task reference would
+	 * stop that from ever happening.  Keep the tracer's struct pid
+	 * alive instead, which is enough to look the task up safely under
+	 * RCU, and use the plain pointer for identity comparisons only.
+	 */
 	struct task_struct *tracer;
+	struct pid *tracer_pid;
 	struct task_struct *tracee;
 	bool invalid;
 	struct list_head node;
@@ -39,6 +48,19 @@ struct ptrace_relation {
 static LIST_HEAD(ptracer_relations);
 static DEFINE_SPINLOCK(ptracer_relations_lock);
 
+/*
+ * Free a relation after an RCU grace period, dropping the reference
+ * the relation holds on the tracer's pid.
+ */
+static void yama_relation_free(struct rcu_head *rcu)
+{
+	struct ptrace_relation *relation =
+		container_of(rcu, struct ptrace_relation, rcu);
+
+	put_pid(relation->tracer_pid);
+	kfree(relation);
+}
+
 static void yama_relation_cleanup(struct work_struct *work);
 static DECLARE_WORK(yama_relation_work, yama_relation_cleanup);
 
@@ -121,7 +143,7 @@ static void yama_relation_cleanup(struct work_struct *work)
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid) {
 			list_del_rcu(&relation->node);
-			kfree_rcu(relation, rcu);
+			call_rcu(&relation->rcu, yama_relation_free);
 		}
 	}
 	rcu_read_unlock();
@@ -149,6 +171,7 @@ static int yama_ptracer_add(struct task_struct *tracer,
 
 	added->tracee = tracee;
 	added->tracer = tracer;
+	added->tracer_pid = tracer ? get_task_pid(tracer, PIDTYPE_PID) : NULL;
 	added->invalid = false;
 
 	spin_lock(&ptracer_relations_lock);
@@ -158,7 +181,7 @@ static int yama_ptracer_add(struct task_struct *tracer,
 			continue;
 		if (relation->tracee == tracee) {
 			list_replace_rcu(&relation->node, &added->node);
-			kfree_rcu(relation, rcu);
+			call_rcu(&relation->rcu, yama_relation_free);
 			goto out;
 		}
 	}
@@ -323,11 +346,22 @@ static int ptracer_exception_found(struct task_struct *tracer,
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid)
 			continue;
-		if (relation->tracee == tracee) {
-			parent = relation->tracer;
+		if (relation->tracee != tracee)
+			continue;
+
+		if (!relation->tracer) {
+			/* PR_SET_PTRACER_ANY: any tracer is allowed. */
+			parent = NULL;
+			found = true;
+			break;
+		}
+
+		parent = pid_task(relation->tracer_pid, PIDTYPE_PID);
+		if (parent) {
 			found = true;
 			break;
 		}
+		/* The tracer is gone; this relation grants no exception. */
 	}
 
 	if (found && (parent == NULL || task_is_descendant(parent, tracer)))
-- 
2.53.0

