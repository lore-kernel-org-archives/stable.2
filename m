Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827F48124C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031758; cv=none; b=gYljt2QppwonrAZ6f6X2kJzTWmiKXyG6yrBzeFM+qlaQBWA1bsEMcNhkToPf5NYzanVEPIVo57PpHyZrDWXMLI2aDtounO/WBNuMQGDDROf43x698KHj7nG04r9sYLbVvwGPS1I7PjhbQuIfuDe7j2t0PQ3p2v/DTV6W91rCviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031758; c=relaxed/simple;
	bh=ZDuUGkz7RnbWw31QUKbnyXoDpCqI35NY7cyDpWBx69E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bUJsPK7qqiDGiB9v7ug4lnuKYA/BezcdbSUe3Yuqy48W4Yo0HVnhke8/P3MXsiRqTCj1E7yLsENqRmIlfJQbpbQ+XsC7zmMV+/hYi0vNaJ8eueEflDaDDxQL+m583Sgc4xiqiJNr7Pol7PIffe+QaIkww+he4P8RfBgUGPpaQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GryqQXhG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GryqQXhG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4994d67d260so53635e9.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786031750; x=1786636550; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lDlgtW2trdnh09mcfFbn0UwWMngZd56Xe1DYBp5hQ+E=;
        b=GryqQXhGnY/QBxFeKxk00ftZLUlbI0t7kyoFctwP+vZfrQanL8s7U9REX5Tmgabtbf
         tATLqZ7hxEiWyuoQTFZThS0OcB26ah6UnmUQR/MMcuVbrAr0vi1uXhYgLgfn08spOjYq
         mPxz0/lProQJwql6G90EayxasrtyTwlEzwdtesdbPo9a52T3U3ptooB47xu18A3DxI9f
         JVG4N2OJ/SdOxs4m1Bb+Cn93If/JCaeuRYfzy2GTsORxj237+TU0C72bbSsVb/O88x+H
         RYpujTYaKB0U8F8I6+N5HAo4116e6KTAVxOImhdHjw8Tn8KZ9DUDiMBF8EUWtLrrqm5a
         ygNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786031750; x=1786636550;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lDlgtW2trdnh09mcfFbn0UwWMngZd56Xe1DYBp5hQ+E=;
        b=MsbkxAG99au6GndWE362KRGku6dD2VRLbqR/k5bw1hKDFEYZTLu98SoPfDvBxx+yy7
         hAfmC3KdfW09vyHTmZ9stn0gj5+fkG3Q62fAd6vjm2SlT+O7bgwEzkEB2ZXDbaEUBIPL
         ympp2x6ARlEt140GJ3AnvD1p9m+uWPDchzJWvtil3nHUdOHMeZiI/Hg54flJIv3Oh9BH
         KgtQmz45fT6ntTRnEEWoHElof6kiazxKe7Nmh8pgINO2GI0TsGkWqbLdELDmyJVOrQMo
         UtjwdF+3md5vYLwRMk8HahFIc7dGajRYdjciIapjvOZ/6SS8+0B20Mx/5HPadQO889dT
         3Nhg==
X-Forwarded-Encrypted: i=1; AHgh+RpPhVQAZTPOlKiDMoUBM0wyQ1nfl5L5M5daKdKyKVLlCvIYsljfR6YXEp60hMfuxfmy0XHWBgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLV1z4rYcXzeodO7cm9hZqGXPfV7kjVY4j6qpWYClCC6wsZxGT
	+IrjI/Joz/k4Ih0QFTxMhhji0urSfMlo671tODwwJurlsfER9jynnWlVOt0okv0pYA==
X-Gm-Gg: AR+sD10F+7/1YQKHLDp8HbFeei0u1QZnWkSauWMVbSTIUc6cRrmj97pKJZ9LOdCd+lb
	xmY0Kq90H6kYsw5f9jSlT54QcQEc0NVndCso9t18KP+p4QpMp5UVJ/z/g//cc4AZm1bqBFYvbjp
	Ypb/tbrpAW66fJDLsHbgMOGh56m/yiT0hRoalh06QAA2Tc6jMyzgsUld8upo1NAbjgiwatjzabj
	3bgXDMdWtnxAEmf1pJmM2rZo8heRlrfkQaIZBAT7GgxogHuC43a+QxHwOgGIGRX5BTyfrYAHgTT
	4DH0mCUWrvbDruEv8ZT0UQ35l9AAkzh7Ya03NxDiEcNOkBpm8/iPMIIPA5DspZ21hBQNIQMUcLj
	XL1hmbUbO5fCvq8z6vXdWjCkXlG2P6ZDiq4BCyj5VnFIDqFckXlIvT7MigCuTy0P+B+mnF3HKrT
	5rvYW4kqf8N/448ag8OsvvsP5toRaXe6SDabePk5J5L3HeyOZkKHVwI76+LkEKuzaxx43SDZn+P
	W9cdr/gIQ1CzkYLYwAwMZ4SkweAo9rF9ahDX4/EJO4irW27
X-Received: by 2002:a05:600c:c4aa:b0:495:4069:b0de with SMTP id 5b1f17b1804b1-49954bfcd70mr1333695e9.9.1786031749721;
        Thu, 06 Aug 2026 08:55:49 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:8b80:1ac5:3668:4014])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954206d7fsm89037205e9.3.2026.08.06.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:55:48 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 06 Aug 2026 17:55:02 +0200
Subject: [PATCH v2] apparmor: fix cred UAF caused by
 begin_current_label_crit_section()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-fix-apparmor-cred-uaf-v2-1-c3bbb9f87a9e@google.com>
X-B4-Tracking: v=1; b=H4sIAFWudGoC/4WNQQ6CMBBFr0Jm7Zi2EKmuvIdh0Q4D1AglLRAN4
 e4WPIDLl7z//gqRg+MIt2yFwIuLzg8J1CkD6szQMro6MSihLqKUBTbujWYcTeh9QApc42waJMo
 1k7K5tiWk7Rg4iUf3Uf04zvbJNO2x3ehcnHz4HMeL3L1/H4tEiZYLwZp0bq/i3nrfvvhMvodq2
 7Yv0FXojs0AAAA=
X-Change-ID: 20260714-fix-apparmor-cred-uaf-cc38ec2b38b7
To: John Johansen <john.johansen@canonical.com>, 
 John Johansen <john@apparmor.net>, 
 Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com, 
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Morris <jmorris@namei.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 linux-security-module <linux-security-module@vger.kernel.org>, 
 kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786031705; l=7754;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=ZDuUGkz7RnbWw31QUKbnyXoDpCqI35NY7cyDpWBx69E=;
 b=NWxgU7wkZZNfh6E9QE7gSBKig8cz5uehGR/tOHgkCM9P73dtdU+IK4KeGiYeFf32gi4aVoYcS
 l6mfqyv5m1DDkyvEooBKrIeeBSoOgNEpyug67lBsy3FE3zgYlnJnCWn
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

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
---
Changes in v2:
- store task work in task security blob to simplify things
- remove cc to peterz, I'm no longer changing task_work implementation
- Link to v1: https://patch.msgid.link/20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com
---
 security/apparmor/include/cred.h |  6 +-----
 security/apparmor/include/task.h | 15 +++++++++++----
 security/apparmor/task.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index 2b6098149b15..0e8b67159f56 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -222,13 +222,9 @@ static inline struct aa_label *begin_current_label_crit_section(void)
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
index b1aaaf60fa8b..6f26758ca10f 100644
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
index b9fb3738124e..e16ff4130bc2 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -14,6 +14,7 @@
 
 #include <linux/gfp.h>
 #include <linux/ptrace.h>
+#include <linux/task_work.h>
 
 #include "include/path.h"
 #include "include/audit.h"
@@ -89,6 +90,32 @@ int aa_replace_current_label(struct aa_label *label)
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

---
base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
change-id: 20260714-fix-apparmor-cred-uaf-cc38ec2b38b7

Best regards,
--  
Jann Horn <jannh@google.com>

