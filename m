Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259137BE9F
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664420; cv=none; b=HbqXrKAbPP185rKVHkUll25VbS4tvlj9TKrEbqx6KYdPtNo8AsxBFWe294zTbPAjKIQxe62x4hHlgn1o0W5vakYsOiaYqRNe65A+qG46uvgWGu81YDIDQC4eB6XPxO1pe5H3AIjZlN5m3w2C18mXLuLKhWHhOrvVrKSbboYUXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664420; c=relaxed/simple;
	bh=gClQzmOlIF8HxBydIcrEaYR0DseQWLwFcMUHJvsNj7I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pr2WYsHna5x3FgIM4ILBQezA9doOOO0a0ZaSQ0+may57TLYVEGUf2289J2KUe6nCo3B60PUn96liU+kuJPchedBNOgElOOqGmV2UrVDjSkj+FnFZcD0zzblOKcmYTY5grh9I7zybvl25pcNWIgVTaZE3tAkh1g8KJfOAFg7CML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXEDCJoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXEDCJoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDD81F00893;
	Tue, 29 Sep 2026 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664418;
	bh=Gr3dvmClMD5xkk7VDF2t3OclsX16+uD98t67UWLVEbM=;
	h=Subject:To:Cc:From:Date;
	b=dXEDCJoOw48n8Aq3EZ8qV3sWw/PvJzKHzC+84GlBMgRCuGcz0qa9a0zNY985GMM1R
	 hmIBqr1nq6qLZOi2+W3Dsov5p7A1ms9XZzb+AX/X2QAM4MCPShQAtRUN76o99kzIjJ
	 OgYbfjudN7VG5Gi6Kg39hv6HnFPgh9VPEl6EmdFM=
Subject: FAILED: patch "[PATCH] ipe: fix use-after-free when auditing a newly loaded policy" failed to apply to 6.12-stable tree
To: wufan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:46:55 +0200
Message-ID: <2026092955-retrace-denial-b8a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9814077275eca36ebf8d510d2f076d235ff9f51a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092955-retrace-denial-b8a2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9814077275eca36ebf8d510d2f076d235ff9f51a Mon Sep 17 00:00:00 2001
From: Fan Wu <wufan@kernel.org>
Date: Tue, 22 Sep 2026 20:13:48 -0700
Subject: [PATCH] ipe: fix use-after-free when auditing a newly loaded policy

new_policy() audits the policy after ipe_new_policyfs_node() publishes it
and drops the new directory's inode lock. A concurrent delete can free
the policy while ipe_audit_policy_load() is still using it.

Audit the successful load under that lock.

Fixes: f44554b5067b ("audit,ipe: add IPE auditing support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
[FW: remove model name according to latest guideline]
Signed-off-by: Fan Wu <wufan@kernel.org>

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 076c111c85c8..847a76afb93d 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -159,18 +159,16 @@ static ssize_t new_policy(struct file *f, const char __user *data,
 	}
 
 	rc = ipe_new_policyfs_node(p);
-	if (rc)
-		goto out;
 
 out:
 	kfree(copy);
 	if (rc < 0) {
 		ipe_free_policy(p);
 		ipe_audit_policy_load(ERR_PTR(rc));
-	} else {
-		ipe_audit_policy_load(p);
+		return rc;
 	}
-	return (rc < 0) ? rc : len;
+
+	return len;
 }
 
 static const struct file_operations np_fops = {
diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
index 9d92d8a14b13..a7aeb57483c6 100644
--- a/security/ipe/policy_fs.c
+++ b/security/ipe/policy_fs.c
@@ -481,6 +481,9 @@ int ipe_new_policyfs_node(struct ipe_policy *p)
 	inode_lock(root);
 	p->policyfs = policyfs;
 	root->i_private = p;
+	/* Only audit signed policies from userspace */
+	if (p->pkcs7)
+		ipe_audit_policy_load(p);
 	inode_unlock(root);
 
 	return 0;

