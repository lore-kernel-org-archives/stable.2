Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D537F74C
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687289; cv=none; b=V7kQRYRQu2p+hsKrDIpJwNSlqRthxrknCSXyvLrcqyB2pXlhIyjJR7lobaqRTT2Qa7lMZSneTiFQBJ/tj+drs+dBh2S0inpxmxPiv96SdzXrP3aVnnclnKdskQuIY59cpYoPSRPThnZ/j/ceEmLgyHS8Nx6yqvCJ0w/+M2jT3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687289; c=relaxed/simple;
	bh=3bVDObZ74eQoB4tcfIwyQEL1v6ERjOuFvF0uK4tmBLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeZ2GOAUE7CdmqSKtO7/i3UD3zHNb5Sgk0Uds25FDcFdpeSbYU0d9mKV8E4tcH2Oyttj61FMzHRRw1BOTBZP3DkDNL/Va/YQmqj4z3bxTNI7ahAwgv5lpDOBpgOaG5hjpNdp5jmfRF83ywKs9XobvIpwecbQDWgDQ/gcAubIitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYfrswQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYfrswQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA3D1F00A3A;
	Tue, 25 Aug 2026 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687287;
	bh=JAWSd8UjQYiUBPftsXXCEryyRKfAaMk3dGZChVlWJTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WYfrswQNo7goV/gseQ7psfCS3jc7bXsmPFNfu0e6NMNDGkbDfVk+p+WZQ3415m6r/
	 la4pmiHZBjdOhH4yRxx2yyfG7KqMgWCS4F8s2/OIedz32EDyFZUV+F2uI+3/fFa84l
	 H057fO+eyx6wreXqpMOyS0cPmVHJmwWmIlR9aQP0SpuOHgkXdSO7H4cRtehnsdFZoP
	 beP69L1QpbmM44lEva6MrDax4wt3oLqDz/ZotzW/rvs9D/sQi09VlbHcFPB4/Co9cN
	 S7pCJHTYF1I8aAAlQwL8Jadw2AME4Nn7aN2OS+pl/Xj5R/wMu3n/EIXyzM9ExmeUu3
	 flzxIVdvkPqIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] selinux: more strict policy parsing
Date: Tue, 25 Aug 2026 15:48:02 -0400
Message-ID: <20260825194804.376152-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825194804.376152-1-sashal@kernel.org>
References: <2026082023-agreeing-overbook-66d4@gregkh>
 <20260825194804.376152-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit 18fa21f10d008a0fc22565109c7d38f304295912 ]

Be more strict during parsing of policies and reject invalid values.

Add some error messages in the case of policy parse failures, to
enhance debugging, either on a malformed policy or a too strict check.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: fixed checkpatch.pl warnings, style problems]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: b98a8ac50775 ("selinux: require a class's permission values to cover its permission count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/include/security.h |  1 +
 security/selinux/ss/policydb.c      | 26 +++++++++++++++++++++-----
 security/selinux/ss/services.c      |  6 ++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index c0d966020ebdd..b0af661e581b6 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -248,6 +248,7 @@ int security_read_state_kernel(struct selinux_state *state,
 int security_policycap_supported(struct selinux_state *state,
 				 unsigned int req_cap);
 
+/* Maximum supported number of permissions per class */
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index fcacc56424697..952a9656ead9c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1132,6 +1132,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
+	rc = -EINVAL;
+	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1152,8 +1155,8 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 len, nel;
-	int i, rc;
+	u32 i, len, nel;
+	int rc;
 
 	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
 	if (!comdatum)
@@ -1166,6 +1169,9 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	len = le32_to_cpu(buf[0]);
 	comdatum->value = le32_to_cpu(buf[1]);
 	nel = le32_to_cpu(buf[3]);
+	rc = -EINVAL;
+	if (nel > SEL_VEC_MAX)
+		goto bad;
 
 	rc = symtab_init(&comdatum->permissions, nel);
 	if (rc)
@@ -1317,8 +1323,8 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 len, len2, ncons, nel;
-	int i, rc;
+	u32 i, len, len2, ncons, nel, val;
+	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
 	if (!cladatum)
@@ -1330,8 +1336,16 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 
 	len = le32_to_cpu(buf[0]);
 	len2 = le32_to_cpu(buf[1]);
-	cladatum->value = le32_to_cpu(buf[2]);
 	nel = le32_to_cpu(buf[4]);
+	rc = -EINVAL;
+	if (nel > SEL_VEC_MAX)
+		goto bad;
+
+	val = le32_to_cpu(buf[2]);
+	rc = -EINVAL;
+	if (val > U16_MAX)
+		goto bad;
+	cladatum->value = val;
 
 	rc = symtab_init(&cladatum->permissions, nel);
 	if (rc)
@@ -1416,6 +1430,8 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	return 0;
 bad:
 	cls_destroy(key, cladatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid class\n");
 	return rc;
 }
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2b3e0e305ba99..5292cdd3bf582 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -451,8 +451,6 @@ static int dump_masked_av_helper(void *k, void *d, void *args)
 	struct perm_datum *pdatum = d;
 	char **permission_names = args;
 
-	BUG_ON(pdatum->value < 1 || pdatum->value > 32);
-
 	permission_names[pdatum->value - 1] = (char *)k;
 
 	return 0;
@@ -471,7 +469,7 @@ static void security_dump_masked_av(struct policydb *policydb,
 	char *tclass_name;
 	char *scontext_name = NULL;
 	char *tcontext_name = NULL;
-	char *permission_names[32];
+	char *permission_names[SEL_VEC_MAX];
 	int index;
 	u32 length;
 	bool need_comma = false;
@@ -512,7 +510,7 @@ static void security_dump_masked_av(struct policydb *policydb,
 			 "scontext=%s tcontext=%s tclass=%s perms=",
 			 reason, scontext_name, tcontext_name, tclass_name);
 
-	for (index = 0; index < 32; index++) {
+	for (index = 0; index < SEL_VEC_MAX; index++) {
 		u32 mask = (1 << index);
 
 		if ((mask & permissions) == 0)
-- 
2.53.0

