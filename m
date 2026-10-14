Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E963ABD90
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006525; cv=none; b=fFW2BrhXs9emBRKfYOaa+aiZZRYA2ES+7tLuV7Emx2HlpCJILGAboL9UdImk5VG5xF0DOznO42s/6lxnVknUeyCALAww5X+Hv+Ds+jZoljmQ5Ru8xVhPkmpBhu2gM7jhOlWnOt0lJNNMr/GK+BH+hsMZHZIKiJYNvQ5Kp/HvJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006525; c=relaxed/simple;
	bh=4dnmeMF7zoCU9a1ZVsVq0ZVP/okfilairnHl1oavLn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OaCTgMdspr519Fdfem6bPDPLzcj3UkHW5UxXmzh23Mez7joiJ1/YI+h+M3XiZRakoYKhIQxbcoZexHT8ANfPT9PR9jQYEApbI1YD/Z6b9UkLsQ53FkezmB68LnMUGpJhUOKHOOuEg3QZnInqBtwOPov801TEh92qnjwre/4FTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=AAFwkB2+; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="AAFwkB2+"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35f1f76ea84so10016eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792006523; x=1792611323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4FPmxhWBAjTH535ztE6vcCubxQG+ofHQPiEGCh/ifLU=;
        b=AAFwkB2+79Ln8ZJNZIXdKSV6T5H0EOlBMJV6/i3uJFATIfdZIFUCn4CZS1HZtHW3g+
         bDeGHctnGBmLD2w7z+h5Be8Trc06NBaz/k8E3qac79AHLygwOslT0KiYKS8+2RfWVGVb
         RC+Io7vJ1fNlX8j4Dgxz4Qx4Lz66MUKqeKhf3XfcXQRztjQIqPsP6QD9i7IbQDGs7UwV
         8+gULAewXTdreMcoai835SqpZ3BD/QDtxSncMh40QWz2wjmlctEUITebsJ1ve0Jc4XYX
         PA1lfsdBX3AitA2SX+qclMLzgOt/wbCzUdNqwU64Q51PKsKmsBl8MA+dqE2xntjwCWzG
         erwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792006523; x=1792611323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FPmxhWBAjTH535ztE6vcCubxQG+ofHQPiEGCh/ifLU=;
        b=XWCM0nU05SkBfqDlROU2roedEGuu+HhBZMxsJgnUnOjy033zMgzAotqS2wiJ6dzuUG
         Qbg4tH882D6VqPc/v6OfGTdhJzpPsWP6w7YKidKHhyIlAvMOsd6Ql1tOARP4PyJZnA6G
         2bNNZwmEYbsEckxfhqBPGHP2wUmqBl0NI3qIKntTs3p12Rsx9tHn6ORjbxdh8pM8qoiX
         ZkjAtOvZJDNOoH2lcROYTMfXLyihq29AxrlQMR1AP26ekxz/mEIdUAy3CQ31eSt1+pNw
         AJ2bZeaNjtFECrX76vdERKsmJYO+qx//z7kairIYPGxiZHbjSHqX6O1vQI3mAXEN8uDd
         iQWA==
X-Gm-Message-State: AFq9FYI0ZGhmG9UtydigoV6T0mc3N1xErdQnSUisJZjf7+TbIrB8KCz1
	0a6+uR096TIn6KO1kAa5e5rgYASj0Iz/0BADIt7K4vZc+L6UVotR0U23ctfs7qy1NN2tDxXveFB
	T07oLygTINg==
X-Gm-Gg: AYBFou03OCWWN2PxjbPFcAy2tkmbspFyBKX65vrNMAWwO8jKjxgUqhzEUgG96qDc6hm
	LHZJcAmJOvdEFJ92e3S8x1hFitKHmvVmSZKcsAMJ3ZaNyaHWnKL1D+O1k1d9dqVTLBBtimy48AZ
	unuDlQFXIiuwkj9f6B5EKYYUz7E1NaWn/AnpPD2BOO7Fzuz8TgsoxGpQ/cFC51UM3VjVjlC2tpD
	NlTD5lk/ITrF9VME3dECV8v5XxmJtDny2Kk3W/2i7cmyZSkkQVXr8GQ7YfLne11uXOeRPs78p4j
	GG9ZPmaD+nIrX1GjO/oxZFTh+UNq1WORjz67RNleogn6tDQ9t9KbPhPpcO9KbIxv5G1m5uuzXjD
	i8dFvng4TaKcg4MM8GpLUTfMXJwqKJ549wfZZ98OJfpoBASEMtqiIIeud9jhcBleIPcWKTm/Bbs
	oP0/67wePibRdXlIyxMogJlYzlUxWdcnb9FBzAiDXJtIIcZtQHdpMzCiw/u7KDJruSq0PhgUQDo
	3G9M/cwomLMhfWSg6TrQTpBF6YXKKi/DnSJLd+xR7UOhtW1uBOWT2gDoUut+cqqDAlfbcU=
X-Received: by 2002:a05:701b:4305:b0:149:d501:b990 with SMTP id a92af1059eb24-16a5f3f191dmr18227572c88.25.1792006522736;
        Wed, 14 Oct 2026 12:35:22 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becefdsm49403665c88.7.2026.10.14.12.35.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:35:21 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: apparmor@lists.ubuntu.com,
	georgia.garcia@canonical.com,
	jannh@google.com,
	jmorris@namei.org,
	john.johansen@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com
Subject: [PATCH 6.6.y] apparmor: fix cred UAF caused by begin_current_label_crit_section()
Date: Wed, 14 Oct 2026 15:35:17 -0400
Message-ID: <20261014193517.24940-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit 3f4ae5fab613dca01d6a2a8210dd832e009fcf47 ]

AppArmor's begin_current_label_crit_section() is a scary function called
from lots of LSM hooks (in particular VFS/socket-related ones) that checks
if the label referenced by the current creds is marked FLAG_STALE, and if
so, attempts to use aa_replace_current_label() to replace the creds with an
updated version that uses a new label.

The first problem with this is that it would directly lead to UAF of
`struct cred` if anything in the kernel takes a pointer to the current
creds and accesses these past a security hook invocation that replaces
creds, like so:
```
const struct cred *cred = current_cred();
alloc_file_pseudo(...);
uid_t uid = cred->euid;
```
I don't know if anything in the kernel actually does this, but I think it
is very surprising that this pattern could lead to UAF.

The second problem is that things go wrong when aa_replace_current_label()
runs with overridden credentials. aa_replace_current_label() bails out if
`current_cred() != current_real_cred()` (mirroring the check in
proc_pid_attr_write()), but this check can't actually reliably detect
overridden credentials because the overridden creds can be the same as the
objective creds.

So in approximately the following scenario, things go wrong:

1. task begins with <creds A> (as both objective and subjective creds),
   with refcount=2
2. task grabs an extra reference on <creds A> for overriding
3. task calls override_creds(<creds A>), which returns a pointer to the old
   subjective creds (<creds A>)
4. task enters AppArmor LSM hook
5. AppArmor checks that objective/subjective creds are equal
6. AppArmor replaces both cred pointers with <creds B> and drops 2 refs on
   <creds A>
7. task leaves AppArmor LSM hook
8. task calls revert_creds(<creds A>)
9. now task->cred is <creds A> while task->real_cred is <creds B>, but the
   task_struct logically holds two references to <creds B>
10. another task drops the extra reference on <creds A> that was used for
    overriding, refcount drops to 0
11. now task->real_cred points to freed creds

At this point, any access to current_cred() will be UAF.

I have a test case where I run aa-disable on a profile while a process
using that profile is blocked on splice() from a FUSE passthrough file into
a full pipe; after the profile update, the pipe becomes empty, splice()
resumes, the credentials go out of sync, and a subsequent getuid() syscall
results in a KASAN UAF splat.

To fix this, instead of directly replacing creds, do it via task_work that
will run at the end of the current syscall. (The point in time at which the
cred replacement happens should have no correctness impact; it is just a
performance optimization to avoid unnecessarily touching the refcount of
the new label.)

Note that AppArmor still performs direct cred replacements in the
sb_pivotroot LSM hook after this change, and that direct cred replacements
can still happen in VFS ->write() callbacks via proc_pid_attr_write().

There are two options for what to do with aa_dup_task_ctx(): Either
explicitly reset new->label_replacement_pending after the entire
aa_task_ctx has been copied, or switch to manually copying members over.
I am switching to manually copying members over because that should make
bugs more obvious.

Cc: stable@vger.kernel.org
Fixes: c75afcd153f6 ("AppArmor: contexts used in attaching policy to system objects")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-89762 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 security/apparmor/include/cred.h |    6 +-----
 security/apparmor/include/task.h |   15 +++++++++++----
 security/apparmor/task.c         |   27 +++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index 58fdc72af66455b78f4fd6df5a3c9a5ffcd1e4d8..3fea4da22d08c8c8d5b8e205d7703bc644ea0c10 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -148,13 +148,9 @@ static inline struct aa_label *begin_current_label_crit_section(void)
 {
 	struct aa_label *label = aa_current_raw_label();
 
-	might_sleep();
-
 	if (label_is_stale(label)) {
 		label = aa_get_newest_label(label);
-		if (aa_replace_current_label(label) == 0)
-			/* task cred will keep the reference */
-			aa_put_label(label);
+		aa_schedule_stale_label_replacement();
 	}
 
 	return label;
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index 29ba55107b7d6ec894d52e6a83e92df32081bccd..9bf4aaa0aa13de279b39e19d027090bb90d11697 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -21,15 +21,22 @@ static inline struct aa_task_ctx *task_ctx(struct task_struct *task)
  * @onexec: profile to transition to on next exec  (MAY BE NULL)
  * @previous: profile the task may return to     (MAY BE NULL)
  * @token: magic value the task must know for returning to @previous_profile
+ * @label_replacement_tw: for aa_schedule_stale_label_replacement()
+ * @label_replacement_pending: is @label_replacement_tw pending?
+ *
+ * When changing this, check if aa_dup_task_ctx() needs to be updated.
  */
 struct aa_task_ctx {
 	struct aa_label *nnp;
 	struct aa_label *onexec;
 	struct aa_label *previous;
 	u64 token;
+	struct callback_head label_replacement_tw;
+	bool label_replacement_pending;
 };
 
 int aa_replace_current_label(struct aa_label *label);
+void aa_schedule_stale_label_replacement(void);
 int aa_set_current_onexec(struct aa_label *label, bool stack);
 int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
@@ -56,10 +63,10 @@ static inline void aa_free_task_ctx(struct aa_task_ctx *ctx)
 static inline void aa_dup_task_ctx(struct aa_task_ctx *new,
 				   const struct aa_task_ctx *old)
 {
-	*new = *old;
-	aa_get_label(new->nnp);
-	aa_get_label(new->previous);
-	aa_get_label(new->onexec);
+	new->nnp = aa_get_label(old->nnp);
+	new->onexec = aa_get_label(old->onexec);
+	new->previous = aa_get_label(old->previous);
+	new->token = old->token;
 }
 
 /**
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index 0d7af707cccdd3fbfd46f12a1eec0189131278c1..3dd62624e88f8f6e9c5cf44c2aa6d3bf40d5cee0 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -14,6 +14,7 @@
 
 #include <linux/gfp.h>
 #include <linux/ptrace.h>
+#include <linux/task_work.h>
 
 #include "include/audit.h"
 #include "include/cred.h"
@@ -88,6 +89,32 @@ int aa_replace_current_label(struct aa_label *label)
 	return 0;
 }
 
+static void aa_replace_stale_label_tw_func(struct callback_head *tw)
+{
+	struct aa_task_ctx *ctx = task_ctx(current);
+	struct aa_label *label;
+
+	ctx->label_replacement_pending = false;
+	label = aa_current_raw_label();
+	if (!label_is_stale(label))
+		return;
+	label = aa_get_newest_label(label);
+	aa_replace_current_label(label);
+	aa_put_label(label);
+}
+
+/* replace the current task's stale label on syscall return */
+void aa_schedule_stale_label_replacement(void)
+{
+	struct aa_task_ctx *ctx = task_ctx(current);
+
+	if (ctx->label_replacement_pending)
+		return;
+	init_task_work(&ctx->label_replacement_tw, aa_replace_stale_label_tw_func);
+	if (task_work_add(current, &ctx->label_replacement_tw, TWA_RESUME) == 0)
+		ctx->label_replacement_pending = true;
+}
+
 
 /**
  * aa_set_current_onexec - set the tasks change_profile to happen onexec
