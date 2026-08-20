Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEDE40B6E0
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222459; cv=none; b=EvsHX76Pcr0i7ALwxtqnWZiufydj3tcmHGGTFB0kVwrxoZZ9TOZqHnJsfz8tWUAeDg3jktdsXHt1LYvR6cgcX8fylroci4cllpv7g+lSTjz+sGULGPHzFRBQWnYO2Jn0MSzpoUPFRH4S9d4ov4w5WoFr3q5CFkAeyXqdvR9cd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222459; c=relaxed/simple;
	bh=acQSKCovUS0hXFSyM70OL1oDygcYH7x3Zofbc5ot0KE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sRsK2PgjXLE7uZcLuRYeVmDPXZF1dN3ZGqNUBupcyOQnoRrpwGPLpWxF6gbgiI0aseQyOxaXdFsWnE+3sB4zkbGm1dLGIEXq5F2lB2VmiPGgILBJlXAJc3j+qtml05DXXv+//AGauhQHmSvjTwARnie+DkNVt7QA37abEUqGOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MCHmw0FZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MCHmw0FZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C521F000E9;
	Thu, 20 Aug 2026 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787222457;
	bh=UWZBjKJ41mS+ZyDqkrQW4CwPPsPJ7maHp6zqUX60q/o=;
	h=Subject:To:Cc:From:Date;
	b=MCHmw0FZqe2x0HriTyMxBSjvmU2UH1RntA3c8LudXW8gSMa0Bj/dtzSYetZYYbSCy
	 +Ew/Qs0vyeKwJLgBevo02U5vxA2WMlBBEDy2w3OSd7KaoaKXREDEtq2hoYTE2E9PuE
	 4aQh9XGU8jTkoAEffDMx07O+7bA7wDOdgEXw6snA=
Subject: FAILED: patch "[PATCH] selinux: reject an unclaimed class value in" failed to apply to 5.15-stable tree
To: hexlabsecurity@proton.me,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 12:40:40 +0200
Message-ID: <2026082040-litmus-embargo-428a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 22b05fec62c0fe9864cfceb52f7d0f3a34d9b1dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082040-litmus-embargo-428a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 22b05fec62c0fe9864cfceb52f7d0f3a34d9b1dd Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Fri, 31 Jul 2026 12:44:11 -0500
Subject: [PATCH] selinux: reject an unclaimed class value in
 security_get_classes()

security_get_classes() sizes an array by p_classes.nprim and fills it at
value - 1, so a class value the policy never defines leaves a NULL.
sel_make_classes() passes every entry to sel_make_dir(), reaching the same
d_alloc_name() dereference as the permission array. The class symbol table
is allowed to be sparse (policydb_class_isvalid() exists to absorb that),
but this getter builds its own array straight from the hash table and has
no such predicate.

Fail the lookup when a value went unclaimed instead of handing out the
NULL. Conforming policies define every class they declare and are
unaffected.

Cc: stable@vger.kernel.org
Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 90e81186cb2e..7afce975436e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3304,6 +3304,7 @@ int security_get_classes(struct selinux_policy *policy,
 			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
+	u32 i;
 	int rc;
 
 	policydb = &policy->policydb;
@@ -3316,16 +3317,29 @@ int security_get_classes(struct selinux_policy *policy,
 
 	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
 			 *classes);
-	if (rc) {
-		u32 i;
+	if (rc)
+		goto err;
 
-		for (i = 0; i < *nclasses; i++)
-			kfree((*classes)[i]);
-		kfree(*classes);
+	/*
+	 * The class symtab may be sparse, which policydb_class_isvalid() exists
+	 * to absorb; the callback fills this array by value, so an unclaimed
+	 * one leaves a NULL that sel_make_classes() hands to sel_make_dir().
+	 */
+	for (i = 0; i < *nclasses; i++) {
+		if (!(*classes)[i]) {
+			rc = -EINVAL;
+			goto err;
+		}
 	}
 
 out:
 	return rc;
+
+err:
+	for (i = 0; i < *nclasses; i++)
+		kfree((*classes)[i]);
+	kfree(*classes);
+	return rc;
 }
 
 static int get_permissions_callback(void *k, void *d, void *args)

