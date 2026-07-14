Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250152E88A4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043547; cv=none; b=bYbvX5cKGh563X5s+afdJfUWwIq2Byk9KHKc7Zv0f3UbFOKmbCp48SNUIopjuZIjU5ko1/+PDjpPIZ82tUy0JcY8vkrWUytxMGYV/01Jz7I/6xSaatA19I75g/w5Nfmk1WhxuyvuJm8kWkLUyAiZzIpEaYyTmSOsEBLTvqc/MSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043547; c=relaxed/simple;
	bh=Hn3a99V0GshSYRRajT1LdTigZCY403M9C6bDrN6U6Xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aJDH7dCB3A6ACMN8Um/d9+zdDQXo7G3S+jM5Sh4yjlecyrJgvyJV+fd9KywqAijG4JhNqztgBqvySL1lPUIwf3qHfa8xMpszd4ZnuyEktW7jpiqjwzd+yPfLfi8rgZMQ31/ch/XGBM7OXWHowiUn7fprnI6OGbpCvr1G30X0HSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/Iz6iR1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/Iz6iR1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso68215e9.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784043543; x=1784648343; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J01qK8ph2yz3FUSd+RgsaIaOKQH5OUzQg7HSEfuNJTU=;
        b=b/Iz6iR1FHq27+s0VO9vfu34mL4Xl4LosQVVLFouzfZEtSEi8LB1JKtIguBdLsLaAT
         kKixynXNbtaFE02UxitLYDmp7o9mmU3tfVcesZnGNpR01c2En6S/jgi4TFbITb5zuSio
         mUtlN3g08LZSZm0TeR3R/3YuaCWT+U7B/IHTtWbMwHOQGiRNICSb172eg8hYNZ7QIS1T
         N8d+pcg5vQev+d37yp3bFiOhD1fa7tNqvmrFWo+ixSWEik448k9eJtazTQ5oOhmeIU0A
         G2iqYXFQyYTsjUONO57oxDDs8ZKjiPSlydad/u1705SZvsOoJLGErE1dzWf8x2k1lokV
         r/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784043543; x=1784648343;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=J01qK8ph2yz3FUSd+RgsaIaOKQH5OUzQg7HSEfuNJTU=;
        b=eqIJAn+2zLpf1s4r0ooZFkJZcYznZBGnqiaoJB90nfUyPc6dP+ryITuyvaLiIEXAjo
         rko4kv/qYqp9yY5dc/qtBG6hTadogfOZyypP5/v8HoZ3ZwbJcuWSPcC97I3sEKw+OT30
         +6D3rAXjM6iLRGG3tzk73d157SxoHu/ROzjJWjHvGPHRupsdHW7NE5Ad1xjaD9l+sFrF
         Cgv8R50tVFHEz8aTGnp5a8uh8GonisPCG4I841hwngZxBYgESosQEVx5odmyscGXFcsh
         RiZHNsNTsea9qEz9tAjK4UlX4SIRMiR3LN5JD+jpZcPn7WM0raiKSErjbdaDS/ERAkSB
         VsxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrX+uvLiqXf943eLgsCr54W3Hqs+FjgyNGIlNU5J5GuA5dOnmN7H1HkCTMw91N0qK7Gs+rqqac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVG74dZ1LpmpGk+rs6lXJOWEjGrDkTlCv4lYIiTa2RsA9ckgx
	Z+3SGC7plPxFjEUnX7rmpyN004hVkBw4Zu5VIxE9VBT7hSk4Hxiv8U5Iyb1+hzN66A==
X-Gm-Gg: AfdE7ck5hXO/EYBvAbKLfqSD5c+LnwfNEWmEi4ZuZMBwhPmq3vsxCIiBd/9lZmRvIJY
	5swlK2uus7NbOyAxQJ5OSBTUvxmBEUGdh5RDAHev95T0mETSKMOQ2GHogm9nIc6b8jImncu/mHt
	TIkrlDA4XMTD4MLqYPHLvB8TjozqM6Muwl1DPY/OAvXbweJDuyKAb+4nnc95nzFl01ciyT6HYzV
	F09Nrh5B92z20knuYLG/4SYgjIDharPwJPq89xkv+5DvFJ9n/YwOWAV/bfsd4bBlU6jkJL71RSF
	RroO9T6+8vzFs/tTU3IeXCuTaZ6jJzPxTdEANInq55bRBA1aIntS/8xWyW4RcG5Mibq0wQARPW0
	hkvIUyjq8PBQTK0ZrbrPRQSYMSASk9/6kwW0pQO1QdSBCVbmqjuDscdp2NCfA4U6g9+yOdOcTT4
	ofR1JNfBwI4iPeNFzkzDwN/H5e2+A7h5eg1nW2ieLTBeGczWLck92J/B3rQT0iuUUM859MlZUL
X-Received: by 2002:a05:600c:828c:b0:493:b279:6012 with SMTP id 5b1f17b1804b1-4945e2be9femr2073435e9.0.1784043542713;
        Tue, 14 Jul 2026 08:39:02 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:84a1:f866:349a:250b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464caeffsm8522501f8f.36.2026.07.14.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:39:02 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 14 Jul 2026 17:38:07 +0200
Subject: [PATCH] apparmor: fix cred UAF caused by
 begin_current_label_crit_section()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-fix-apparmor-cred-uaf-v1-1-be40e8c83b90@google.com>
X-B4-Tracking: v=1; b=H4sIAN5XVmoC/yXMQQqEMAyF4atI1ga0DipeRVy0MToZUEuqIoh3n
 6rLD977TwiswgGa5ATlXYIsc0SeJkBfO4+M0keDyUyZVfkHBznQem91WhRJucfNDkhU1EzGFbW
 rIH69chw+3bZ7HTb3Y1rvGFzXH+fPN6t5AAAA
X-Change-ID: 20260714-fix-apparmor-cred-uaf-cc38ec2b38b7
To: John Johansen <john.johansen@canonical.com>, 
 John Johansen <john@apparmor.net>, 
 Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com, 
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: James Morris <jmorris@namei.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 linux-security-module <linux-security-module@vger.kernel.org>, 
 kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784043499; l=7433;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Hn3a99V0GshSYRRajT1LdTigZCY403M9C6bDrN6U6Xg=;
 b=ek9GXlKutf3DdPTWJIyyWtUNapXj2tmf0u00pReeaJnFg6apXCXhtVQ1Le/ihIA9Lbny+trOM
 qUbSL85AurAADcVVB6QDQ3Q/RDJg48BA9OYerWkBkrLig0pjgV0UrGG
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

Cc: stable@vger.kernel.org
Fixes: c75afcd153f6 ("AppArmor: contexts used in attaching policy to system objects")
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/task_work.h        |  1 +
 kernel/task_work.c               | 14 ++++++++++++++
 security/apparmor/include/cred.h |  6 +-----
 security/apparmor/include/task.h |  1 +
 security/apparmor/task.c         | 29 +++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 0646804860ff..ce19fc14060c 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -33,6 +33,7 @@ struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
 struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
 bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
+bool task_work_has_func(struct task_struct *task, task_work_func_t func);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 0f7519f8e7c9..f83d1528e0bc 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -189,6 +189,20 @@ bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
 	return ret == cb;
 }
 
+bool task_work_has_func(struct task_struct *task, task_work_func_t func)
+{
+	struct callback_head *work;
+
+	if (!task_work_pending(task))
+		return false;
+	guard(raw_spinlock_irqsave)(&task->pi_lock);
+	for (work = READ_ONCE(task->task_works); work; work = READ_ONCE(work->next)) {
+		if (work->func == func)
+			return true;
+	}
+	return false;
+}
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *
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
index b1aaaf60fa8b..4e49a4142777 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -30,6 +30,7 @@ struct aa_task_ctx {
 };
 
 int aa_replace_current_label(struct aa_label *label);
+void aa_schedule_stale_label_replacement(void);
 void aa_set_current_onexec(struct aa_label *label, bool stack);
 int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index b9fb3738124e..8e368f6278f5 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -14,6 +14,7 @@
 
 #include <linux/gfp.h>
 #include <linux/ptrace.h>
+#include <linux/task_work.h>
 
 #include "include/path.h"
 #include "include/audit.h"
@@ -89,6 +90,34 @@ int aa_replace_current_label(struct aa_label *label)
 	return 0;
 }
 
+static void aa_replace_stale_label_tw_func(struct callback_head *tw)
+{
+	struct aa_label *label;
+
+	kfree(tw);
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
+	struct callback_head *tw;
+
+	if (task_work_has_func(current, aa_replace_stale_label_tw_func))
+		return;
+	tw = kmalloc_obj(struct callback_head);
+	if (!tw)
+		return;
+	init_task_work(tw, aa_replace_stale_label_tw_func);
+	if (task_work_add(current, tw, TWA_RESUME))
+		kfree(tw);
+}
+
 
 /**
  * aa_set_current_onexec - set the tasks change_profile to happen onexec

---
base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
change-id: 20260714-fix-apparmor-cred-uaf-cc38ec2b38b7

Best regards,
--  
Jann Horn <jannh@google.com>

