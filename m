Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9E4E3EEF
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685987; cv=none; b=RwyBKiVaaqxn5eQpZfdrYLEgAK8dUKuLNpCCY9ucYa5UUj8WRcQI18RLFdhOcrJyn5raIQEceKvoz0Z2oQMXsHEAiMjqvBUFASgfAXDvW+xSsza6Bb/cTRKuvbXkGviyiMhRiAZDo6rgpqqonEx+CwZw0AZ/l6ojT/MB4FoznwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685987; c=relaxed/simple;
	bh=0VZ+FBeMfs4iylkgdlFGTT7xE6C3UaQHxDwz2FqO+Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeoNWys4NSPz8ZTEu6/LYzQbO9DGe6MwH/COZbbSaTtd/94n9dAiFisnrbbKkuCS6ulL9LGuHNDI+DCsfXMpwm3AtJFxD+uucqmZhOz+RMWsXdJYodwGpPARFPqUT4SfDMCUv738dC6eVxDRXKo6ovULkKzz6i4/EAbhSnG37oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7+co4oH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7+co4oH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB281F000FF;
	Tue, 29 Sep 2026 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685985;
	bh=lkDCAL4Zo5stLi4nEoH/BKt9Rc4Zh0ilc1laPYD44xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7+co4oH6DG1S68+5TJEDshpwGGc6/YfYDeWo8iH6DvGYL2waTVS9J5EWfHExPQKC
	 BElcXJ9LtR3RmRUM4HgNwB0vcfzpV1Qd7ldT/B8fXE1FNOpMJUM+6q5IHWJhBpQusk
	 3bO9X5FaQcd5pF2F35fbanlMMCbMB7wYApmXTRzgRuYJfOKaY3GBhD2NGaBK9P/oWv
	 Bqn4hwUezluXdUxOfMgxeq93r/WNZt8F7D7pybgpGrpa1OXHO8UEaW+DRcrFnGy5zd
	 Dlsw0/2OYYpzquqeR9hIroZvo3f6pAS9rAE8+ksedTSSU/ufzhXXEdxHefiC7dhqBu
	 SwXPVCS1AmOzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <wufan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ipe: fix use-after-free when auditing a newly loaded policy
Date: Tue, 29 Sep 2026 08:46:23 -0400
Message-ID: <20260929124623.3453618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092955-retrace-denial-b8a2@gregkh>
References: <2026092955-retrace-denial-b8a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <wufan@kernel.org>

[ Upstream commit 9814077275eca36ebf8d510d2f076d235ff9f51a ]

new_policy() audits the policy after ipe_new_policyfs_node() publishes it
and drops the new directory's inode lock. A concurrent delete can free
the policy while ipe_audit_policy_load() is still using it.

Audit the successful load under that lock.

Fixes: f44554b5067b ("audit,ipe: add IPE auditing support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
[FW: remove model name according to latest guideline]
Signed-off-by: Fan Wu <wufan@kernel.org>
[ adapted new_policy() changes to the older success-only auditing implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/ipe/fs.c        | 4 ----
 security/ipe/policy_fs.c | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 5b6d19fb844a0..d6f90235d6142 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -155,10 +155,6 @@ static ssize_t new_policy(struct file *f, const char __user *data,
 	}
 
 	rc = ipe_new_policyfs_node(p);
-	if (rc)
-		goto out;
-
-	ipe_audit_policy_load(p);
 
 out:
 	if (rc < 0)
diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
index 3bcd8cbd09dff..5eba2bb93276f 100644
--- a/security/ipe/policy_fs.c
+++ b/security/ipe/policy_fs.c
@@ -12,6 +12,7 @@
 #include "policy.h"
 #include "eval.h"
 #include "fs.h"
+#include "audit.h"
 
 #define MAX_VERSION_SIZE ARRAY_SIZE("65535.65535.65535")
 
@@ -463,6 +464,9 @@ int ipe_new_policyfs_node(struct ipe_policy *p)
 	inode_lock(root);
 	p->policyfs = policyfs;
 	root->i_private = p;
+	/* Only audit signed policies from userspace */
+	if (p->pkcs7)
+		ipe_audit_policy_load(p);
 	inode_unlock(root);
 
 	return 0;
-- 
2.53.0

