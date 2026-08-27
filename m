Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1C63E5A35
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853239; cv=none; b=i06WEr6X2Y0Dg0Kl+BT1wWt4KlVj3Uo0XkXzwFwi65gKBZhtnC/Qyy+eRnhmrD8IAasDDA2Qce5k7852ntrLphUhox6XGb0IiluFFD/BjXO/ob4bF5xaF2CEt7bPiPfV4wZNcxCCNHGnEZ51WM2Y4qw+tiyK+wLsS4EjQDQEEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853239; c=relaxed/simple;
	bh=DA4RagTv6MX27+jK1vowrL6H86tYfiH32B9w8eXG87o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prwEhXGKEP0jpQBDWHR6hLuP9e1zIdsky2U1ITBCMD6UrJZim4PRVyn+1B/jId3mat6tnF836pfMMJDFJD/bCBJXoo0VaZ1gm6JRuoFmEJCrTCBqlo9JOzoDnjsU8pcOKw9nqwHMxfqtiOqEe9fqybJm1g/2tUlUKIMwGmLeImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kVJXaGk/; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kVJXaGk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787853197;
	bh=I4CPqY+zSdb2UKp1tzbgXQu/T2rOPe1pBAbmtqpMTlA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=kVJXaGk/FoSXdrUwQUZKdy2FWp4e/8rU12YO2jn5Ctsa6nYgxKwRF0oI5xCzu3VWW
	 lnrnLppPNkY+KkubOPLd4U7AdtrRxk4O/h0YlZqS9Lwb7VM1NgkH4YkXJZAbkjJ/Oz
	 pop0oUmR/CZPEroDjo3VlUKNM3tPnDYeW7oLDAX8=
X-QQ-mid: esmtpgz15t1787853178t772909c6
X-QQ-Originating-IP: 4oDdHyyojT1NsC8pdERX1RCdNIqZoMLwoi5J27faLck=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Aug 2026 01:52:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16474762243193988894
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 7.1.y 5/5] selinux: require a class's permission values to cover its permission count
Date: Fri, 28 Aug 2026 01:51:49 +0800
Message-Id: <20260827175144.4174620-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260827175144.4174620-1-guanwentao@uniontech.com>
References: <20260827175144.4174620-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MBlb9jzPUvXQKE6pSqiHcqe7o2DXTVLD1cVXeLxPtXJbOfpLTnauuc5A
	a0tMv0x0VLCrBlEnpHVArGwuH8Frp/gRWutwlBmNfS7JW2kpQ7QpG2VS3LndMYpk9v3cktq
	AIyVshn3OPFyM03ECUq376FyAR77D5Dhjkz/mlKKX7TH6woKcM21xaDSQTkfBjms7BkLs1x
	AASLnZAAfU333v+zj8GDXNFYUNyadHfILLBDBpzQXhHY4AOsFogfNkNvaMmgK0c1IQNSgn7
	mYyQjIlRAkKe+gMXzHRE2YaBzZSiMDZBIvPmMqqAyQ6+jcW5toIyfyIHb0NK49fS0UEg0/X
	mS4+uIWM5fFOX4WgYw/j12PbehpJqEFnVGfl+NVA248XZuTIpN6SaZYuCp4TGWvPVLblV0Q
	Ar7rtTNgGF1H733avuKbujgxmQFzLWNi3BYCFhg95RAWfnI77Gr/ZWa6KW4pzermVHirkzV
	n3LCZQuqL2lqlfqqMdhBoTT4HYR19teRYw/02GE2X3vP9jxSww15HkhBX0PFD5xViAWgtu6
	xsJCAJLpVKyJLEEiAbJiT7S/tP3gE76jRHHxmp5ZgdECbhkNL8JEU/VzmYlM1oAw1RTIEcl
	d4Cybi3Ttn+ORUfaEywbOlXuRJkFiOxKt9UYfdiG5I1zFIRu49EcryP+cwiwMh0Miu1pn7p
	P53T9RBpx5xDLQzcNaMtwx1Wo1ALgxjbC1+1E8qqr0jL7T3xJEjCe8epIhqOVhtoi3ywCUI
	UR7Q8eYA8c1Z8ArrGmQ2e5evhuSdRx7jXKfO1dEmPmxAz14M/QomAggLRC+cFWXUJoEZqQi
	PQL8tDZ+afFbmMG/JuSTHWjrtfiz3E6gnSKPyTR4ifa42G4tNJzWLf5kIgOPXsSM24k/2x8
	birKmRJvNl6j8KCxWQ4JthnuveTqyTDNBSn6wjXkqoYuIIFLAFlwDvefTOowwqPyfaS4cgA
	gVq8Ni4Ro8atYoAIL61BaLKY1dPFTBn1VgTRlhmqOUtQiEqNkUj7Snqi9ymztr0kZ9tAHiy
	WY0vHYuoMw4E3bGEPgx359z7wv3EVoaA6jmBsGDnr85S+y6HgFAtHWnxhS4jTyIAbVftG0a
	n1TXqJLkRx+TNtBX4LxBPqqW9pWgO4ouw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
index 6f91f2bec80cc..c959fa90d90fe 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1138,7 +1138,18 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
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
@@ -1162,6 +1173,10 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	/* indexes an nprim-sized array in security_get_permissions() */
 	if (perdatum->value > s->nprim)
 		goto bad;
+	/* two permissions cannot share one slot of that array */
+	if (*claimed & (1U << (perdatum->value - 1)))
+		goto bad;
+	*claimed |= 1U << (perdatum->value - 1);
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1182,7 +1197,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 i, len, nel;
+	u32 i, len, nel, claimed = 0;
 	int rc;
 
 	comdatum = kzalloc_obj(*comdatum);
@@ -1204,17 +1219,28 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
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
@@ -1348,7 +1374,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel, val;
+	u32 i, len, len2, ncons, nel, val, claimed = 0, inherited = 0;
 	int rc;
 
 	cladatum = kzalloc_obj(*cladatum);
@@ -1376,6 +1402,10 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	if (rc)
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
+	/* no permission value can reach a slot past SEL_VEC_MAX */
+	rc = -EINVAL;
+	if (cladatum->permissions.nprim > SEL_VEC_MAX)
+		goto bad;
 
 	ncons = le32_to_cpu(buf[5]);
 
@@ -1410,11 +1440,22 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
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

