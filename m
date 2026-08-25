Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E323B4EA4
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687247; cv=none; b=HKIbLQJk8yD6rCZUsJg3L0THzQn0t5dSd5BxKU3owQQH6gJW1v0g0hpBpHWUjs7SvTm85lsqVd+kAPWwg0e2Yty2cOBt/g64HgPkXc8+3Ag0dK9zXsxya9kcwh5Cqw5HwTofy3rxv8pr5/zE9yWSatnpASWVG3hFDjjkHuJAAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687247; c=relaxed/simple;
	bh=HvzOsjJnsEnjZNxp29FE3sm4pYAiDT380yqdFQdn2I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OldaubnLId0HJYQJe5jnPZXTGUaByN9TkShCkxb5zoPiQ1vCu9LaK//2QwoX0zOequg/v6gET2lxBJKSWjbNLZv28X+UmKwUB4aAIblGUV6SDC/CqQPHBuBo4DbXOYXANYijeun7jitzkqyiK9VXout5k+h7/GfjImoRL7S/c94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bps1N5l6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bps1N5l6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475651F00A3A;
	Tue, 25 Aug 2026 19:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687245;
	bh=1i9rTTmyH4mn0vdW9DF4p+8VexyFdGPDCWdpzFBtTSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bps1N5l6TJFxoK9ajEgUaVSTlovi/J7WA0xVmJVmcILrCJQN7XopwQ8d1IErx6AB0
	 cMEPl9yFcSIYgEJgHJjw1PeMSAbWJjDomrQkUCIDPdMMVcBLs/9oDrhSnRZPVtOhPO
	 KfjTA1DzEQTH7JXZvkCoiEWS5+nXVXAX/quPRd8SY7IBtsogkfsZX2WuWbC1wq69g4
	 RHq7O6b7NH9PdHG/3OkvSEeACbwMoYsElDJ/huCEr0UicIePFkYogNnEAiwy1VE+UW
	 DqEJRZdshNDGHRIAmiMYOmXsChYaLdohml9osNprRU6y9yBNT39UkDCOc4d+l0QDIt
	 ubKrADhTIE+KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] selinux: reject an unclaimed class value in security_get_classes()
Date: Tue, 25 Aug 2026 15:47:22 -0400
Message-ID: <20260825194722.374513-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825194722.374513-1-sashal@kernel.org>
References: <2026082040-litmus-embargo-428a@gregkh>
 <20260825194722.374513-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 22b05fec62c0fe9864cfceb52f7d0f3a34d9b1dd ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/services.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d2c2835e5c8d4..e6ab061784d62 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3411,6 +3411,7 @@ int security_get_classes(struct selinux_policy *policy,
 			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
+	u32 i;
 	int rc;
 
 	policydb = &policy->policydb;
@@ -3423,16 +3424,29 @@ int security_get_classes(struct selinux_policy *policy,
 
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
-- 
2.53.0

