Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA0391838
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608571; cv=none; b=rgcUcB7mB6yGySYbuYXXk0qGMvSemoeerQgF5xCzjQUAZjB5yGE0izlc18/70dDS6LFaWTwk0n/gdXLut5AY0y/ydcBQ3XtnjzFhd89VnxQv1LQIpjDvbH3mxgJnIW38+YuTy4BhYtfm0A4T+HS74S8cljVZM4HgPgPvJciOV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608571; c=relaxed/simple;
	bh=iReaFLG+3QnsWLuAWnCbfmVDJlV9al9i4zPMZ2V0EGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bENLQ3JD5FbrhG9zEHsWtKCcT0S3wMLmsCrhlUcYtTrkY/8Vq89kB1MJ4JK0znWAJYXn3d/hPgONdazfPfnV1ffKjvwqJNuWJ8t1ouFxEZS8j8/hEUEkFFcfOKW2TUWTl/ukG7ZfvW9ACoitGF+/Gdi4F1BUdUWK/uoYhO69tIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKNy3QWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKNy3QWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0F11F000E9;
	Mon, 24 Aug 2026 21:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608567;
	bh=8P4u/FFu6BAGXkxh2sMT3NYStplPS5fyeHFuHj7QV6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKNy3QWzNI4zk5+UD3WdsZhebVaoKIgHbuMF6L+cH5DJZXOYtLFhUF9d0sq0lh7rA
	 LsHf47+sW2FzXfDTa5Q7YfH3ODJ1zEmIEPvcKHGE99Hx7Cmxr6cv52zE4PT3weqQSg
	 QnrHwHv8xiFGTdIngUlgWrvhdwAgp7/JzVz5dAoWIMcEfFXyHVwJQgRmUbTO8CQBzi
	 /ZWVnrFqPouu0KDTzsqD00LKbmpj+JijVeK1LcOwUP1pAJc1AjPKRyq8bvIEGJDbH1
	 +Ub0+lSRhjZW5MzYBUCn9RCbQGRmwTQiXmUxcIn1jRNkJh5BaHAhu5mzQ8A/yIgO8w
	 Hhph8B0cvyDvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/3] selinux: use u16 for security classes
Date: Mon, 24 Aug 2026 17:56:03 -0400
Message-ID: <20260824215605.432476-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082020-unnatural-animosity-f5e9@gregkh>
References: <2026082020-unnatural-animosity-f5e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit fa79a596848fe38c55ccab8832ac35dac07fb00c ]

Security class identifiers are limited to 2^16, thus use the appropriate
type u16 consistently.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: b98a8ac50775 ("selinux: require a class's permission values to cover its permission count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/policydb.c |  5 +++--
 security/selinux/ss/policydb.h | 10 +++++-----
 security/selinux/ss/services.c |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e4fa4be4823f9..b8243b6c51a5a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -950,7 +950,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	return 0;
 }
 
-int policydb_class_isvalid(struct policydb *p, unsigned int class)
+int policydb_class_isvalid(struct policydb *p, u16 class)
 {
 	if (!class || class > p->p_classes.nprim)
 		return 0;
@@ -2039,7 +2039,8 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
 	char *name = NULL;
-	u32 len, ttype, tclass, ndatum, i;
+	u32 len, ttype, ndatum, i;
+	u16 tclass;
 	__le32 buf[3];
 	int rc;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 89a180b1742fb..a49275d1168d8 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -48,7 +48,7 @@ struct common_datum {
 
 /* Class attributes */
 struct class_datum {
-	u32 value; /* class value */
+	u16 value; /* class value */
 	char *comkey; /* common name */
 	struct common_datum *comdatum; /* common datum */
 	struct symtab permissions; /* class-specific permission symbol table */
@@ -82,7 +82,7 @@ struct role_datum {
 struct role_trans_key {
 	u32 role; /* current role */
 	u32 type; /* program executable type, or new object type */
-	u32 tclass; /* process class, or new object class */
+	u16 tclass; /* process class, or new object class */
 };
 
 struct role_trans_datum {
@@ -139,7 +139,7 @@ struct cat_datum {
 struct range_trans {
 	u32 source_type;
 	u32 target_type;
-	u32 target_class;
+	u16 target_class;
 };
 
 /* Boolean data type */
@@ -195,7 +195,7 @@ struct ocontext {
 		} ibendport;
 	} u;
 	union {
-		u32 sclass; /* security class for genfs */
+		u16 sclass; /* security class for genfs */
 		u32 behavior; /* labeling behavior for fs_use */
 	} v;
 	struct context context[2]; /* security context(s) */
@@ -322,7 +322,7 @@ struct policy_file {
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern int policydb_context_isvalid(struct policydb *p, struct context *c);
-extern int policydb_class_isvalid(struct policydb *p, unsigned int class);
+extern int policydb_class_isvalid(struct policydb *p, u16 class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a0ccf73a65ddc..e48e5204f8a1c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3290,7 +3290,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	u32 value = datum->value - 1;
+	u16 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
-- 
2.53.0

