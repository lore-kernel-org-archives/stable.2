Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2A415B87
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222486; cv=none; b=hOEIll5ZbJCVAvuHp9nB5XCRQPjtZaenQ4bNq4Enra7ibyiMQ8y+wFkeF3gHF/oC6BNgb0l7gwYuZgI9d85LbJ78FXFXRVhQGZwyBugdF7ue4mz1KJp4sx1y6xYQSSfhj4zZgNC/CnaYuJl9MIwj1sXWiYXYZndMVO0losWCSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222486; c=relaxed/simple;
	bh=yGiJAIEuv8MxRFYU3oIZuTRDKTqFI/8useWvB6wzps8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iXzMnsFAPhv/38nVEpbAvYpBa3fgikS3/2v0I+F+5AxRDOoYgtwFbumtI4SmA8D5RRq38S4uk2SYe6VKhqXC9XkNUPbo8AtYbjDak809FpDWps2XE+aifjbyNhVLpCw1bKM1ksEKSuPEld97sgFxmIOSdL4mHV8SdrPvO2qYnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vLgfTDPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vLgfTDPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EA71F000E9;
	Thu, 20 Aug 2026 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787222484;
	bh=Q1+minw6QrLsgBnQgVBXSuFip5sdI6AgeDedJz2rono=;
	h=Subject:To:Cc:From:Date;
	b=vLgfTDPjA1VNd2L1mhFqCpTaibZwMp8smUUJQti0nPNq2SZnD9yuJIsE61U3lSBo1
	 NK5lhXc8OubUjmtycdIVSETtzBLXduda2pQroyTOrsdYkZPhQ0Yfo4IrghNZ4NwXkt
	 dS5Zw8Pgc7o8MZjyOVhZHWVpzRtj12D1r1+mwU+k=
Subject: FAILED: patch "[PATCH] selinux: require a class's permission values to cover its" failed to apply to 7.1-stable tree
To: hexlabsecurity@proton.me,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 12:41:20 +0200
Message-ID: <2026082020-unnatural-animosity-f5e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x b98a8ac50775540f3804397ed08f61ef9910bcab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082020-unnatural-animosity-f5e9@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b98a8ac50775540f3804397ed08f61ef9910bcab Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Fri, 31 Jul 2026 12:44:10 -0500
Subject: [PATCH] selinux: require a class's permission values to cover its
 permission count

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

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 69777e885ae7..d358200817bd 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1154,7 +1154,18 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
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
@@ -1178,6 +1189,10 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	/* indexes an nprim-sized array in security_get_permissions() */
 	if (perdatum->value > s->nprim)
 		goto bad;
+	/* two permissions cannot share one slot of that array */
+	if (*claimed & (1U << (perdatum->value - 1)))
+		goto bad;
+	*claimed |= 1U << (perdatum->value - 1);
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1198,7 +1213,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 i, len, nel;
+	u32 i, len, nel, claimed = 0;
 	int rc;
 
 	comdatum = kzalloc_obj(*comdatum);
@@ -1225,17 +1240,28 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
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
@@ -1369,7 +1395,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel, val;
+	u32 i, len, len2, ncons, nel, val, claimed = 0, inherited = 0;
 	int rc;
 
 	cladatum = kzalloc_obj(*cladatum);
@@ -1402,6 +1428,10 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	if (rc)
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
+	/* no permission value can reach a slot past SEL_VEC_MAX */
+	rc = -EINVAL;
+	if (cladatum->permissions.nprim > SEL_VEC_MAX)
+		goto bad;
 
 	ncons = le32_to_cpu(buf[5]);
 
@@ -1436,11 +1466,22 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
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

