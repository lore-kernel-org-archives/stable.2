Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70314C6F0D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447640; cv=none; b=KGeHAheMjQalJnLRG9sjCHtZRR5wNDoT3HelNrNqEsKQhLrzJ5mVrrrufFCK961uNdCXMiCeO6klJOIGbwP9sb7n4lI+nT0YLV3JzLxp6yNRW+CaEgikCI2DOEgfuuriSpWaPp/h8k8PYce15C3tBCZ7HuUeqJuiihZBgDAIYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447640; c=relaxed/simple;
	bh=+5HEokjXH8AxwHpz57XwwojJaI/Ll3MV14BfSNMmQuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESo+9O6v2mstYN8inLHvsvrU+7AP2xjiksHlhYdZP7OQ7eICRbRM8J8ealP2rYtVqskkFaPyCDIHwZUAXIa46sJufyGH1bNI6j0FF22vS9eIyURpGP2PaGWZZhN5oqnbrJw0lo0Vyl9QbK/Ew75qg0oOyADncEvcyAFipDsio5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2NYglXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2NYglXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458AF1F000E9;
	Thu,  3 Sep 2026 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788447637;
	bh=twcVQc5Sfn0JRYfmSH7NxhK0QhXUEXBu+2npgX1mJqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A2NYglXjvGeR/eCOJy/VmJz2X8oA4UeS/FU0rpD8JVZnYHIraqbbl65LHVIB/ix/n
	 dyCud7taKBZ9oG4xx4FY5THZLdxnrgQfE0Wc7Cd2eAvGZd8ta8AD436/kez5YuOltk
	 fhx3pUGtrVqcEFd1qyfw/++cjGinZwFPtc38hcGEiZURpJamqz8l2BLgoR43nOjI+R
	 nSWdQuanWWJJHYEfDJ8qoyJbpUhTOjdvoHNfrwcFfVceyz7dEmp8oCUJ2cVzJQ8cUH
	 ojN2WufrM8fG3TPQMVe/1EhTfUpR9uziDUWEm9P/dBVntvyblJXf8zQjXDNKyDPk70
	 8bJPYUeay4Kzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] apparmor: fix cred UAF caused by begin_current_label_crit_section()
Date: Thu,  3 Sep 2026 11:00:34 -0400
Message-ID: <20260903150034.855351-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903150034.855351-1-sashal@kernel.org>
References: <2026090359-cork-overheat-9dda@gregkh>
 <20260903150034.855351-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/include/cred.h |  6 +-----
 security/apparmor/include/task.h | 15 +++++++++++----
 security/apparmor/task.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index 0b9ae4804ef73..ea38198277536 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -161,13 +161,9 @@ static inline struct aa_label *begin_current_label_crit_section(void)
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
index 01717fe432c3b..3c203b622b435 100644
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
 void aa_set_current_onexec(struct aa_label *label, bool stack);
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
index cd9d43a277314..1d60b1521ed8f 100644
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
-- 
2.53.0

