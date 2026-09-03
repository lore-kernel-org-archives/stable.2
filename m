Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8884B148A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447638; cv=none; b=ipNzLeHhQGzlOxGZc+KoSVQwAzWfk4eI/fZgOX6JmGky7SsMa+T13XGjcdj7Y93FVshYM9hUBv420yOAaR6hbLgqMWM0S6axdQpEVfwPfeYqIQSYJ5sOqrHPdKDGhPZvaW6wbL8vDtSCR/fuHWUFkC4tXBXUGYtn8q5TLllVoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447638; c=relaxed/simple;
	bh=DgFjSgcHRLUcC2Cqj3+ZuiqKM855evxQKGMOTXiPyVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkxJpBDMlzoX1cP8lXYkuCujdhloBZcAc4OvnY0UqutRRA1oVaNKGSY4k6seWN1eJzqtwwxhA8a6Fo9DTsMM4xZEpwVZtj6fKI+XG1lFxKdwl0VRFhvh1EYir3VPGFxTUMWwFKejOqJjo7Aj7ThT33PCN+Zq2Nfv00aU1x9gjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3RUFuqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3RUFuqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681961F00A3A;
	Thu,  3 Sep 2026 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788447637;
	bh=fpanOap++vrSZfAUqx7AIPM5PGCNGEzp5DEDBL/4YnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a3RUFuqsrP/cemMRlPD+RVo10Sfal0VTpTmxPF1V9AEsyLBVjissJYPy7cyLvGNEI
	 k52T33WMwuOZjau2sB2bgd1P3sgvH+lprWjAipi272yjrcvk7QZg1wBpJFa1GbC2R8
	 nuXvH5VUDFI5i/y6snCgtWER1uNbZ+txNhcUbvDUuUDTFFclJ55bwHloEb+DxcE1vP
	 7rXbV9Z8WqhG27Puqg3jmfxm5u8ObDEu+4PPXgdZ+MGM1DZjbuV13YCJOXliwnGFNT
	 8UlLPnq4O2saOGqUmwiqtnRjmrUKM/6CIUr1pTsPNLkdSj/n6X+gXxTyuDXIXgJDrw
	 ML+Q2BufXjjiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Quanfa Fu <quanfafu@gmail.com>,
	"Tyler Hicks (Microsoft)" <code@tyhicks.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] apparmor: make aa_set_current_onexec return void
Date: Thu,  3 Sep 2026 11:00:33 -0400
Message-ID: <20260903150034.855351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-cork-overheat-9dda@gregkh>
References: <2026090359-cork-overheat-9dda@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quanfa Fu <quanfafu@gmail.com>

[ Upstream commit 0897fcb1c1e7316375166e0a665237bce2391a09 ]

Change the return type to void since it always return 0, and no need
to do the checking in aa_set_current_onexec.

Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
Reviewed-by: "Tyler Hicks (Microsoft)" <code@tyhicks.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Stable-dep-of: 3f4ae5fab613 ("apparmor: fix cred UAF caused by begin_current_label_crit_section()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/domain.c       | 2 +-
 security/apparmor/include/task.h | 2 +-
 security/apparmor/task.c         | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index a6308d103f764..52e16e75e63fa 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1463,7 +1463,7 @@ int aa_change_profile(const char *fqname, int flags)
 		}
 
 		/* full transition will be built in exec path */
-		error = aa_set_current_onexec(target, stack);
+		aa_set_current_onexec(target, stack);
 	}
 
 	goto audit;
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index 13437d62c70f4..01717fe432c3b 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -30,7 +30,7 @@ struct aa_task_ctx {
 };
 
 int aa_replace_current_label(struct aa_label *label);
-int aa_set_current_onexec(struct aa_label *label, bool stack);
+void aa_set_current_onexec(struct aa_label *label, bool stack);
 int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
 struct aa_label *aa_get_task_label(struct task_struct *task);
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index 503dc0877fb1a..cd9d43a277314 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -93,9 +93,8 @@ int aa_replace_current_label(struct aa_label *label)
  * aa_set_current_onexec - set the tasks change_profile to happen onexec
  * @label: system label to set at exec  (MAYBE NULL to clear value)
  * @stack: whether stacking should be done
- * Returns: 0 or error on failure
  */
-int aa_set_current_onexec(struct aa_label *label, bool stack)
+void aa_set_current_onexec(struct aa_label *label, bool stack)
 {
 	struct aa_task_ctx *ctx = task_ctx(current);
 
@@ -103,8 +102,6 @@ int aa_set_current_onexec(struct aa_label *label, bool stack)
 	aa_put_label(ctx->onexec);
 	ctx->onexec = label;
 	ctx->token = stack;
-
-	return 0;
 }
 
 /**
-- 
2.53.0

