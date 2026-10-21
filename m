Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597654;
	b=fZP8wNSeuoTMaFnmU2oR8k/qZJuYJUCZkWXyO31kUUmuc80Gw5rJXRX0UuShbzGFYqpt
	 x97diUp+6c69eGWZRLy5cvG04BdbnoyWYXO87gEYVUacAC4UnnS/y6Sv4ZS7Tw/dGRd0Z
	 vnDAsMvOgjiNMZjhb1wWWxfqHxFNevE7IYtfjIW3+5P/tQhRBCjzLkn5N3ULZE3qYERQi
	 7G7t+PvfLzkSOvXyc+u39DhG7mu6MTcdcaa/WbpUIIzs/e3VoQjyQk271xmDdzYsVKeTA
	 Naw/EDi6XO3b84SPRseGD9iq2XdoddmZ7N+/UoJ0R94v4ws71Az/3P8QoTUsd+eW3dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597654;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=qGmeNCDLQlJnxwGmUoF1LBpA1R4h4DtBiIgIdxz7k78=;
	b=2Ou/JKcSm2PUZzXxorOC4e2kh5GcLsZaw6xlzBRTt116mxq/Gm8tgqh8sE0B9W1HvEgJ
	 IxWbjiRd//I+2h2Lhgf/8FqbpVwyVFtFEm2CX2wFYUMpasTvhYpOHd8jm1S5i5vY1R3ZT
	 l7R16wN/XGBJ0BT3Vw1FwEb+KrEYzhG1c9RVp4bNKnkZAyunGUNBOa9PvSDNukhELgs7M
	 9uuKoP1yvABYSk23tt/H68O6qeU7O0QqDtBjF5GuKc3wOoLASZqD2MViz/EdPVhsRczZ5
	 0oUhCpfHLEzHQxe5+fYJ2JyWNRDrd2MYHEep9Kbr8D/tY81DNQkEakUTQ4GTsyp7MIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OWyNzCya;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF6606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25EF6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OWyNzCya
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792597653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGmeNCDLQlJnxwGmUoF1LBpA1R4h4DtBiIgIdxz7k78=;
	b=OWyNzCyaMstyp6ifhaCnmA+0JPScg+OskXwsSMGhsVHK8ra/v1Y6zJXg4EQ4naB9kAmi2P
	mYxea39E9nnZQa7qwz8z14WJp5cG6+j+DcAK6U4SlwKe8DA02c+NSpPAkGpv22ScO0jNAB
	YtuzzLd6T6hjvrG3I3uudXJrWB9+ie4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-kMCyQc_0PROK3TIc_TM9xw-1; Wed,
 21 Oct 2026 11:47:29 -0400
X-MC-Unique: kMCyQc_0PROK3TIc_TM9xw-1
X-Mimecast-MFC-AGG-ID: kMCyQc_0PROK3TIc_TM9xw_1792597648
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBE7819560AD;
	Wed, 21 Oct 2026 15:47:27 +0000 (UTC)
Received: from loberman-thinkpadp16gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CA0318005AD;
	Wed, 21 Oct 2026 15:47:27 +0000 (UTC)
From: Laurence Oberman <loberman@redhat.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 5.10.y 01/16] cred: clarify that task_struct::cred is only for the current task
Date: Wed, 21 Oct 2026 11:46:50 -0400
Message-ID: <20261021154705.2737365-2-loberman@redhat.com>
In-Reply-To: <20261021154705.2737365-1-loberman@redhat.com>
References: <2026102131-walmart-preschool-d157@gregkh>
 <20261021154705.2737365-1-loberman@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Jann Horn <jannh@google.com>

The `cred` field in task_struct is currently marked as __rcu, but that's
not true: It can point to credentials from access_override_creds(), which
do not get freed with RCU delay.

What actually protects task_struct::cred is that accessing it is only
permitted for the current task (except for setting up a child during fork()
or tearing down a dead process).
(There is currently code in Smack that violates this rule, but that's a bug
and causes UAF, I have sent a separate fix for that.)

Clarify this, remove the __rcu marker, and remove RCU helpers from all
accesses to this field.

Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
[PM: style tweak in security_init(), applied fixup from JH]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/cred.h  | 17 +++++++++++------
 include/linux/sched.h |  8 ++++++--
 init/init_task.c      |  2 +-
 kernel/auditsc.c      |  5 +++--
 kernel/cred.c         |  2 +-
 security/lsm_init.c   |  3 +--
 6 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 6ef1750c93e2..49c26af37349 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -180,12 +180,18 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 
 static inline const struct cred *override_creds(const struct cred *override_cred)
 {
-	return rcu_replace_pointer(current->cred, override_cred, 1);
+	const struct cred *old = current->cred;
+
+	current->cred = override_cred;
+	return old;
 }
 
 static inline const struct cred *revert_creds(const struct cred *revert_cred)
 {
-	return rcu_replace_pointer(current->cred, revert_cred, 1);
+	const struct cred *override_cred = current->cred;
+
+	current->cred = revert_cred;
+	return override_cred;
 }
 
 DEFINE_CLASS(override_creds,
@@ -293,11 +299,10 @@ DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NULL(_T)) put_cred(_T))
 /**
  * current_cred - Access the current task's subjective credentials
  *
- * Access the subjective credentials of the current task.  RCU-safe,
- * since nobody else can modify it.
+ * Access the subjective credentials of the current task.
+ * Nobody else can modify it.
  */
-#define current_cred() \
-	rcu_dereference_protected(current->cred, 1)
+#define current_cred() (current->cred)
 
 /**
  * current_real_cred - Access the current task's objective credentials
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cc..50c7157fee82 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1172,8 +1172,12 @@ struct task_struct {
 	/* Objective and real subjective task credentials (COW): */
 	const struct cred __rcu		*real_cred;
 
-	/* Effective (overridable) subjective task credentials (COW): */
-	const struct cred __rcu		*cred;
+	/*
+	 * Effective (overridable) subjective task credentials (COW).
+	 * Only accessible for the current task and during task creation/freeing.
+	 * This pointer is not managed by RCU!
+	 */
+	const struct cred		*cred;
 
 #ifdef CONFIG_KEYS
 	/* Cached requested key. */
diff --git a/init/init_task.c b/init/init_task.c
index adb207cd987c..ce7c2b07d855 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -160,7 +160,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.sibling	= LIST_HEAD_INIT(init_task.sibling),
 	.group_leader	= &init_task,
 	RCU_POINTER_INITIALIZER(real_cred, &init_cred),
-	RCU_POINTER_INITIALIZER(cred, &init_cred),
+	.cred		= &init_cred,
 	.comm		= INIT_TASK_COMM,
 	.thread		= INIT_THREAD,
 	.real_fs	= &init_fs,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2b9ce0b52511..1b9cf25291e0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -459,7 +459,7 @@ static int audit_field_compare(struct task_struct *tsk,
  *
  * If task_creation is true, this is an explicit indication that we are
  * filtering a task rule at task creation time.  This and tsk == current are
- * the only situations where tsk->cred may be accessed without an rcu read lock.
+ * the only situations where tsk->cred may be accessed.
  */
 static int audit_filter_rules(struct task_struct *tsk,
 			      struct audit_krule *rule,
@@ -476,7 +476,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 	if (ctx && rule->prio <= ctx->prio)
 		return 0;
 
-	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
+	WARN_ON(tsk != current && !task_creation);
+	cred = tsk->cred;
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
diff --git a/kernel/cred.c b/kernel/cred.c
index 3df4e15bd67f..0bd6a58bc12d 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -414,7 +414,7 @@ int commit_creds(struct cred *new)
 		inc_rlimit_ucounts(new->ucounts, UCOUNT_RLIMIT_NPROC, 1);
 
 	rcu_assign_pointer(task->real_cred, new);
-	rcu_assign_pointer(task->cred, new);
+	task->cred = new;
 	if (new->user != old->user || new->user_ns != old->user_ns)
 		dec_rlimit_ucounts(old->ucounts, UCOUNT_RLIMIT_NPROC, 1);
 	if (new->user_ns != old->user_ns)
diff --git a/security/lsm_init.c b/security/lsm_init.c
index a1ad641811de..04b18d06ba59 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -476,8 +476,7 @@ int __init security_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	if (lsm_cred_alloc((struct cred *)unrcu_pointer(current->cred),
-			   GFP_KERNEL))
+	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
 		panic("early LSM cred alloc failed\n");
 	if (lsm_task_alloc(current))
 		panic("early LSM task alloc failed\n");
-- 
2.56.0

