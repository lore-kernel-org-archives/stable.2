Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E640D58B
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222454; cv=none; b=nSLrOntyUb4E8C6T5AS/2DLP7cUxG/evQQ58/eOz3E5z9kyYFrpJ6p+l/GRetg2zHJV2PC3clsmeDA6kzGb/ljQmeLNVO1Gmo9PmxVbsXTqkP23pdWujZZVnKD6njNUVU7o/kfFK1gX6FyhNkIFXRQqncP6Ms71g6/VT1jWocpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222454; c=relaxed/simple;
	bh=Qk3cCh3AJnT3dH0elQQTimT1cwocLTaJpQ/fNtxdt7w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TnfH9KkdY2R2/3AsHS2Kl0pmGYB3sxLAPAAK3rAKUuR/S5O83VEBDbAOyIJnsLZZrMQFLDACbUTBLdMZ5hhWNZN6PFaVHILvHD1nPDTuJIrxDOo1xEhbbUqqUrdgtqZPEog3/cyhdM5GPGyMYzCfzdw/Ih5NRF2J71xvmg5FSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DgumeFtg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DgumeFtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF77E1F000E9;
	Thu, 20 Aug 2026 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787222452;
	bh=gqNno/Eu4Oaot1ZMjkZ0ddCfPONxXZcUvmrIm41uJmw=;
	h=Subject:To:Cc:From:Date;
	b=DgumeFtgnb3dSAgPCDjoJsplIKBzTHV8qCDGrfpSA8fyj5eTE4x9Xqq9Gzo/8Rh+6
	 vMsp318+Ss3LmvnIsrlAFtSV2QhrWZvqd1DRAiG79Ig/Y9QmrVljmNffVpEVonnsmp
	 ffCjmicuiaID1xYAAkQ6qxQxRsEAnlb9qo6fTXUE=
Subject: FAILED: patch "[PATCH] selinux: reject an unclaimed class value in" failed to apply to 5.10-stable tree
To: hexlabsecurity@proton.me,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 12:40:40 +0200
Message-ID: <2026082040-morality-prudishly-7084@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 22b05fec62c0fe9864cfceb52f7d0f3a34d9b1dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082040-morality-prudishly-7084@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

