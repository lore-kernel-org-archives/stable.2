Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2F4756B9
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664470; cv=none; b=FVOEE8htdDa2vS9p8I68R0kMf79CN65IsX3o2GGnK+/6z1l1eq5USh5PQGb+cc4qTBrpPS9Z+Fby4jV/RsnBeZDQIz9K8HHHfPvuKd4XQy33erUq6zcz5q1S9Z7ZtTT6/uqeV8lGWMj9YX1xNyFlB6zzX0GKZ7FYh8S3rdlECRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664470; c=relaxed/simple;
	bh=V4ft8tfM9qa7bJsVbzxuqNR7jWyRZKbMgpsLnQ6sjL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTFjrBjzqCZEUNWvmVCy/P5MP69HBqIJKQT8n+RfqCtg6IP4Ndv8WnCGI2kaeDk97xqOB3QvfYvaCErNpIwjThLygz2yLQv8s7B4a1Gz6zQ0chLrgrCMsyBMsqVfu/E008rnweOYX+zd2YP0GrByauGacZpoKGh6/39qtuT9bfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiY5FWAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiY5FWAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783021F00A3A;
	Tue, 25 Aug 2026 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787664466;
	bh=aJ3qp8iSnJJayZXGa9fZyGoYtPnQZ2uCtWbqFMW6F8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OiY5FWAQ/fxn3OMKDZ+mQH1Nn6prQkwh9MbM7MOMcay2sefjZ4GJY+AHy+2LHoCbB
	 5bgq5m2KoBnhgghkWZm/XFPCHv5S9IEbMooQSpMh4W7MZJA67g25i4W2uzIazUEksV
	 ueEpBCxe2l9KkK7+MQ+JtSjJcdrumh7DVIm4WZijTL/kkLP6aGjcVrfouZV+ZINiIL
	 3/SPSmI0V/Tm+yLNffQcgoT8KKK8uoiz6r4yEAMLy7l4L8cJu1gxQ931BH28nIUEaL
	 G26eBx56HEuvPkhNjO/6YAduJHSxRMLVfGIJmefWaALhskYR07TpxjaTtFLM/CH5Rt
	 DXTJtfgxSWuvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] selinux: reject an unclaimed class value in security_get_classes()
Date: Tue, 25 Aug 2026 09:27:42 -0400
Message-ID: <20260825132742.3865669-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825132742.3865669-1-sashal@kernel.org>
References: <2026082039-waffle-overlabor-d7cc@gregkh>
 <20260825132742.3865669-1-sashal@kernel.org>
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
index 077a7af5794e6..657c8942ac810 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3414,6 +3414,7 @@ int security_get_classes(struct selinux_policy *policy,
 			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
+	u32 i;
 	int rc;
 
 	policydb = &policy->policydb;
@@ -3426,16 +3427,29 @@ int security_get_classes(struct selinux_policy *policy,
 
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

