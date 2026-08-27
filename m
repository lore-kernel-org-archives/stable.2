Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52A361978
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820133; cv=none; b=qAzgCQrANu/DKBGqpmSjig3sox2AkPNqcQ5IiRBs3FdIV4OxX/FXqnc6XN4nuq6BVSH1Mqdp7p+yFkY+jRDsWNJTRnfAQqKU9G2p/g0Y3tyTwlH6uJPIOnDATNHV/Oh8Y6ZkMSTaweTlzUbOP40gg7G5B/bnMMG0H32BsnRbq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820133; c=relaxed/simple;
	bh=9kIvFghEcFfXTkbF1WNY/VJMZUTJ0xIkLY62JxBFXHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxoJLMPpm8AUdWOJzFk7Px6fsRvY9matHnzcJL1tzMl/5mdWxaEdO+OvZaMQufQLxO6x5+w90CXgwk8atDSkjav0VKsAVZ4eE6gNG2jpTezsOrAXfTzY7aIczQyNFI3FsFYqVNDuw0viWjb9jZuYyXYTjp0t4c+j59OJG5iaf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SO9mfmUv; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SO9mfmUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787820097;
	bh=eVDBEU9oSJsjPFTxry7jteJuPXySjoLrYjwG8ovYT/E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SO9mfmUvlj9z/r0bKW5s88gBiOZCgddy0poXVEgBvtD/aRGX036T/+3bYNJKdAymT
	 OwPJL/Z6idOKx9nJSQ0VRzn7GiqH19Af39VhYD10gnOZtqThLt0Zid5c4v3dMgID2y
	 vmLikpN6bK0swamd3RwNoA1P50TQlj4B/tXYLT3w=
X-QQ-mid: zesmtpsz5t1787820091ta420f104
X-QQ-Originating-IP: ArLNdwm1kOd9bwy4g04FLwF6Jot93JgVV9oMRPbTXOY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:41:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5467264916750332078
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: [PATCH 6.18.y 10/10] selinux: require a class's permission values to cover its permission count
Date: Thu, 27 Aug 2026 16:38:14 +0800
Message-Id: <20260827083802.4044165-10-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827050834.10002.stable-daily@kernel.org>
References: <20260827050834.10002.stable-daily@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NNVvTAKYYe7GT+f/K2Qcld6MV0Ai2GCROWFnxZfbEpqsG68Mh5nnM8q/
	m46UaomMX3zzmITVf+beWapu9Rr7WXLE8sKawJ13Woq0PG4rlIz6Dqxob2rW0s5YIt6IgIe
	25e4Wos72S+MG4n2xJJB/jWxr+lKfdMe8tJ6pJ7Lj7O0Tb6nnN0MUXmqeEfG3tM/GJyqtM1
	J4vyVyAhb987npFpksjZVPfKhubi1mjvtAtUxV6hMV+ctpEB0BbRUue7nbk/ruylI3Ch4pV
	IPvzofYVV92Dwx4sjwtaKN6gAnG93vLbVJPeDs3AVeFfZeEtBGVEZ2KPeuaVxa80wkwfKNo
	/CkpPSYjFXjmM7nPMCB/q7aHrX4qE54vP9ZiHB+I8FV7QOa9EwJ5L5hDHHc2XwYRnC2pojH
	gOTllXiIr27jUKwnLfA1Ad0TcajQGH7oPZ6z8p2+PkBrKr0Z7TdLq9OrLaSn2jGaXhGOvsj
	Pjv3bSpRirpht3KvZ0gBET1IcVbc5w/3hqKEfoCbT+Pp5HfR+AAz8DeHv08Bsp+yetUOzog
	3j5aCKxDJlFkGUcMijk0YuUW0KtBd7RAeboMU/kk4FySFNRem0tJ+Vz55f9Ax8e02+1J7vQ
	PSfXQ6ygOTb2s6VwuND/jPoH0vYKDOMzuDMfVwd5WMBPEUDgzCKnDLMURNZbEvpm2YqQNbT
	vrpkT/vReE4NmtW5vnUIHY/koDDQNpJSdxbMhE36wDh0irrgeYJEZOMDO+KTUlSWbwhaRgQ
	2AtM5EGPkzK4YB3vvlxXulZz34lHqJ+gn9ZHBOv2LtwBYVDPc/aQXTSHCntOeKoPop+oYoF
	B+6O3+ap8CI1Z39vsPj9W6GNxQGn5apBXcJcWecqX30cOVe7mwyAdMA0o2+84MwyJa+9Ogj
	OGtaoXQlW4ojkPsYxgwM0+/0eG5DBB8dDUUOWYtJd9q3DgDgASu5V2ZJ+cGxg9BzTQYEPJe
	5XaI5ukM6bKC4/aoG3Suycw68TStB+9BdQ8BBG6jRPPZONjGu9GgG57DrMyYIIzxISqlSzg
	kr2ccQL671JYRWtYxJmIPGtrewqAGAzEZnDnevQOUGAvGT6SyOot6Yl0avjarPLuXcfy5pK
	s1O61dz57Yyuu4SskILaAgQEMkM7pkhmpvmTTLsTB6agyDJ3Av23QYICOIoqfnED46DI9Si
	gPJOJ/riFWYQtpX5UibxMBf1R8FyeCGFfRQ9
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Bryam Vargas <hexlabsecurity@proton.me>

security_get_permissions() sizes an array by the class's permissions.nprim
and fills it at value - 1, from the inherited common's permission table and
then the class's own. A value no permission defines leaves a NULL that
sel_make_perm_files() passes to d_alloc_name(), an oops inside
sel_write_load() that strands selinux_state.policy_mutex and leaves every
later load in uninterruptible sleep; two permissions sharing a value
overwrite the first kstrdup(). Bounding each value by nprim catches
neither, and neither would a count: the symbol table is keyed on the
permission name, so duplicates pass.

Track the values each permission table claims and require them to cover
exactly what its count declares, rejecting a count no value can reach.
Conforming policies are unaffected.

Cc: stable@vger.kernel.org
Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit b98a8ac50775540f3804397ed08f61ef9910bcab)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 security/selinux/ss/policydb.c | 51 ++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 926dae3731a0d..483d7d54642a3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1139,7 +1139,18 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 	return 0;
 }
 
-static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
+/*
+ * Bitmap of the permission values a symtab has claimed.  Values are 1-based
+ * and bounded by SEL_VEC_MAX, the width of an access vector, so the whole set
+ * fits in a u32 and the callers reject an nprim past that width.
+ */
+static u32 perm_claimed_mask(u32 nprim)
+{
+	return nprim ? U32_MAX >> (SEL_VEC_MAX - nprim) : 0;
+}
+
+static int perm_read(struct policydb *p, struct symtab *s,
+		     struct policy_file *fp, u32 *claimed)
 {
 	char *key = NULL;
 	struct perm_datum *perdatum;
@@ -1163,6 +1174,10 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	/* indexes an nprim-sized array in security_get_permissions() */
 	if (perdatum->value > s->nprim)
 		goto bad;
+	/* two permissions cannot share one slot of that array */
+	if (*claimed & (1U << (perdatum->value - 1)))
+		goto bad;
+	*claimed |= 1U << (perdatum->value - 1);
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1183,7 +1198,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 i, len, nel;
+	u32 i, len, nel, claimed = 0;
 	int rc;
 
 	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
@@ -1205,17 +1220,28 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	if (rc)
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
+	/* no permission value can reach a slot past SEL_VEC_MAX */
+	rc = -EINVAL;
+	if (comdatum->permissions.nprim > SEL_VEC_MAX)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &comdatum->permissions, fp);
+		rc = perm_read(p, &comdatum->permissions, fp, &claimed);
 		if (rc)
 			goto bad;
 	}
 
+	rc = -EINVAL;
+	if (claimed != perm_claimed_mask(comdatum->permissions.nprim)) {
+		pr_err("SELinux:  common %s does not define every permission it declares\n",
+		       key);
+		goto bad;
+	}
+
 	hash_eval(&comdatum->permissions.table, "common_permissions", key);
 
 	rc = symtab_insert(s, key, comdatum);
@@ -1351,7 +1377,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel, val;
+	u32 i, len, len2, ncons, nel, val, claimed = 0, inherited = 0;
 	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -1379,6 +1405,10 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	if (rc)
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
+	/* no permission value can reach a slot past SEL_VEC_MAX */
+	rc = -EINVAL;
+	if (cladatum->permissions.nprim > SEL_VEC_MAX)
+		goto bad;
 
 	ncons = le32_to_cpu(buf[5]);
 
@@ -1413,11 +1443,22 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		}
 	}
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &cladatum->permissions, fp);
+		rc = perm_read(p, &cladatum->permissions, fp, &claimed);
 		if (rc)
 			goto bad;
 	}
 
+	/* the class's own permissions must claim the slots the common leaves */
+	if (cladatum->comdatum)
+		inherited = cladatum->comdatum->permissions.nprim;
+	rc = -EINVAL;
+	if (claimed != (perm_claimed_mask(cladatum->permissions.nprim) &
+			~perm_claimed_mask(inherited))) {
+		pr_err("SELinux:  class %s does not define every permission it declares\n",
+		       key);
+		goto bad;
+	}
+
 	hash_eval(&cladatum->permissions.table, "class_permissions", key);
 
 	rc = read_cons_helper(p, &cladatum->constraints, ncons, 0, fp);
-- 
2.30.2

