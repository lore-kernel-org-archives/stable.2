Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91043264E2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444522; cv=none; b=g9Szr+Bvw9eLEm8BxDesOWlxvoQ/e1uqggBV4XIMqGrLtSfmwSWOVhteVhVwDg4dkDQkoFVgcrRs9E19SZDk2f+PsuNX+qiSG+AWUJiQIkXb4gjuAxUmkMemWOM7NoEwPHvbLBMmIgRpzqZ9uNPnHOsF/FyZVLfFT76S8NmZ7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444522; c=relaxed/simple;
	bh=VBJSNeOhOMmpznPSLOLjUqe7QMWxFWfIF45hC+ehqvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE9B3HQdyyhiNDZsyPy0AOWTA3jRGp0LjHiZm3GwYXL3i8x2i4TsL5ERHdRmZ4SGhVU7d83eExiVtGh8UJtnzzCijWszTE5Ew7Lugz2QGJev+7SGgb0+6sSke/KTe4egRequrBQ6SBa+zxAJeNc4npp2Lw4CVs1gphR5wdIyTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqkYcwiO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqkYcwiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800CF1F00AC4;
	Thu,  3 Sep 2026 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444511;
	bh=vINa9HWTurR3A2gnsmLxPZnhRBdiRccmwkofGuhWAdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RqkYcwiObDDugVAqxGCl5DottOkj6j58V0tbQQT+oNmNfACp0KYVcb49nflFQCJIq
	 9f9LUohFE6VN3MhjrWOUE+cQ4KW3njKwZaXMtXkMIyxwDaFkI81os9tUWDOT/y8De0
	 s0pQe8AXHi4rrXFpUPWKkIAC9MLH7u5FDVs6a9130mZqteJ/yt8iWaxNmN8ExjtsZy
	 dff6D7UMQZWJLbcSRoygKzeD7KhQctq//JOIjwgqM3HgRE/QyNxhj4G6+nCeQmXx/T
	 NT8P5bNFHcbukk3a3rXIn1/Te9OzT+7701Z43FoIM1N9hkNWwcr6YVMXOT360PBsao
	 Bki7MuZeP15fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Quanfa Fu <quanfafu@gmail.com>,
	"Tyler Hicks (Microsoft)" <code@tyhicks.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] apparmor: make aa_set_current_onexec return void
Date: Thu,  3 Sep 2026 10:08:28 -0400
Message-ID: <20260903140829.792947-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-postnasal-expediter-69a3@gregkh>
References: <2026090358-postnasal-expediter-69a3@gregkh>
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
index f14f8a4e85946..2d91c76568b36 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1498,7 +1498,7 @@ int aa_change_profile(const char *fqname, int flags)
 		}
 
 		/* full transition will be built in exec path */
-		error = aa_set_current_onexec(target, stack);
+		aa_set_current_onexec(target, stack);
 	}
 
 	goto audit;
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index 29ba55107b7d6..13945e2495f0b 100644
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
index 0d7af707cccdd..1a7c9d02e31db 100644
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

