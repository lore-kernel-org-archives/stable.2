Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456351;
	b=syQy6fZ6/fzsQwv+nLsV7MIJvyRkm6yVv5G5xD523x31tfOx9Hm6PyrBNIFKRl1dk36T
	 AV4XzQrR2mTbfqONFUJ2lTz3rxHG4ijjJljHyLnIwIZd6dnVoM4ry8AMhftoWvehrrNt0
	 9fGAS6C92VKGX1EAkPeZ1GVyMz16VGRxjtpN0TXDW/niRmo3MJ1ipI3b8wBBs6Cs01GxG
	 hs7Tpe4bqs1QO6ljl5tkno4PUTFnrq/YJDoCjoIlHjkY11d3xrvK1Q2SZgNa9WA2sEMMu
	 sXo4XJ1VhefIPlznnUv73X/FC01MXLmERTexxO1lf8xxNL/qKtDQN23+sMDfUTQvOiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456351;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hAADal3PzZKyvt82jRbWdjQbgeSQsTLsdgB/iIhXbso=;
	b=YOeypGtIKqDbjnieBcePme3/qBAi3Lv20Cej8tbPM3LyTpsYW5eOuXIoSLs6aqMwf4ZH
	 jmiCebbHldSCQvnbO9LqPMNo+r4xQK9juCPA+VqADMRXzhGhN2ml15LKEhAyXxy57wOVT
	 NV+9NXeccUHHjDfIWQ4DUfXjTEFLu7x5L+aQFf8zoiz4vs0eJSUFldF0A6jPvlY/Ekab1
	 hbg5uY7SiRzsInaZE9BnhEunjKL2U2C1J+1DDUqxbo5oX8sj35yTylg8vy8O11WebAEHQ
	 uA+GcLCr465mJO5H+4fuYYWrqOfy4AMRbdIM459/iu8kirVwkrSaEm1Otf7fXcxRySg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4Hi7jd3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92FA606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4Hi7jd3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F421F00A05;
	Thu, 12 Nov 2026 04:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456351;
	bh=hAADal3PzZKyvt82jRbWdjQbgeSQsTLsdgB/iIhXbso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g4Hi7jd3M9OnSNZdTRkit4YedcpSNjpDsfj8hUyr+ywxYDHOXEaUtBMgCahjxL8ps
	 Ek2FTWkAmB82k1sQem8nsxmSzDzPIOPFMLlUAPG9wVmuAN/HK7rKunlBcBqrVEbnna
	 4tgGasidOGrgREl8RKh+r23yokUWGQ/dtKTO7Q9nGs3vTn8NfURSnD8qDR6/hI8Ots
	 PS5SmEahPhSGPc8VbiOkaU2BcOAfaz+d0pYhfliiaxoMRvO0WDwIcepfvgO2cy/IuA
	 hR4Hvdx2KUpihWARGR695ZpLJYPVNbcsQRx79OvR9kyEYTh/TZjmmfpmwwXSqiD+t7
	 T7jYFfOqHkGwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] apparmor: refactor xattr attachment, to take the file path
Date: Wed, 11 Nov 2026 23:05:46 -0500
Message-ID: <20261112040513.1836781-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051557-failed-6.18-ce94927fa417@kernel.org>
References: <20261107051557-failed-6.18-ce94927fa417@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit 812aa0aa67d50c251d9788f1d225438e747507f0 ]

The full bprm does not need to be passed into xattrs_match, so only
pass in the path, and propagate the change backup the call stack until
bprm is actually needed.

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Stable-dep-of: ce94927fa417 ("apparmor: fix profile leak when a policy load fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/domain.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 8e478ac99ff6d..57e886b8ef461 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -303,28 +303,31 @@ static int change_profile_perms(struct aa_profile *profile,
 
 /**
  * aa_xattrs_match - check whether a file matches the xattrs defined in profile
- * @bprm: binprm struct for the process to validate
+ * @path: path for file being matched (NOT NULL)
  * @profile: profile to match against (NOT NULL)
  * @state: state to start match in
  *
  * Returns: number of extended attributes that matched, or < 0 on error
  */
-static int aa_xattrs_match(const struct linux_binprm *bprm,
+static int aa_xattrs_match(const struct path *path,
 			   struct aa_profile *profile, aa_state_t state)
 {
+	AA_BUG(!path);
+	AA_BUG(!profile);
+
 	int i;
 	struct dentry *d;
 	char *value = NULL;
 	struct aa_attachment *attach = &profile->attach;
 	int size, value_size = 0, ret = attach->xattr_count;
 
-	if (!bprm || !attach->xattr_count)
+	if (!attach->xattr_count)
 		return 0;
 	might_sleep();
 
 	/* transition from exec match to xattr set */
 	state = aa_dfa_outofband_transition(attach->xmatch->dfa, state);
-	d = bprm->file->f_path.dentry;
+	d = path->dentry;
 
 	for (i = 0; i < attach->xattr_count; i++) {
 		size = vfs_getxattr_alloc(&nop_mnt_idmap, d, attach->xattrs[i],
@@ -372,7 +375,7 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 
 /**
  * find_attach - do attachment search for unconfined processes
- * @bprm: binprm structure of transitioning task
+ * @path: path of file in question (NOT NULL)
  * @ns: the current namespace  (NOT NULL)
  * @head: profile list to walk  (NOT NULL)
  * @name: to match against  (NOT NULL)
@@ -387,7 +390,7 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
  *
  * Returns: label or NULL if no match found
  */
-static struct aa_label *find_attach(const struct linux_binprm *bprm,
+static struct aa_label *find_attach(const struct path *path,
 				    struct aa_ns *ns, struct list_head *head,
 				    const char *name, const char **info)
 {
@@ -395,6 +398,7 @@ static struct aa_label *find_attach(const struct linux_binprm *bprm,
 	bool conflict = false;
 	struct aa_profile *profile, *candidate = NULL;
 
+	AA_BUG(!path);
 	AA_BUG(!name);
 	AA_BUG(!head);
 
@@ -434,13 +438,13 @@ static struct aa_label *find_attach(const struct linux_binprm *bprm,
 				if (count < candidate_len)
 					continue;
 
-				if (bprm && attach->xattr_count) {
+				if (attach->xattr_count) {
 					long rev = READ_ONCE(ns->revision);
 
 					if (!aa_get_profile_not0(profile))
 						goto restart;
 					rcu_read_unlock();
-					ret = aa_xattrs_match(bprm, profile,
+					ret = aa_xattrs_match(path, profile,
 							      state);
 					rcu_read_lock();
 					aa_put_profile(profile);
@@ -556,7 +560,7 @@ struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex,
 /**
  * x_to_label - get target label for a given xindex
  * @profile: current profile  (NOT NULL)
- * @bprm: binprm structure of transitioning task
+ * @path: path of file in question
  * @name: name to lookup (NOT NULL)
  * @xindex: index into x transition table
  * @lookupname: returns: name used in lookup if one was specified (NOT NULL)
@@ -567,7 +571,7 @@ struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex,
  * Returns: refcounted label or NULL if not found available
  */
 static struct aa_label *x_to_label(struct aa_profile *profile,
-				   const struct linux_binprm *bprm,
+				   const struct path *path,
 				   const char *name, u32 xindex,
 				   const char **lookupname,
 				   const char **info)
@@ -598,11 +602,11 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
 	case AA_X_NAME:
 		if (xindex & AA_X_CHILD)
 			/* released by caller */
-			new = find_attach(bprm, ns, &profile->base.profiles,
+			new = find_attach(path, ns, &profile->base.profiles,
 					  name, info);
 		else
 			/* released by caller */
-			new = find_attach(bprm, ns, &ns->base.profiles,
+			new = find_attach(path, ns, &ns->base.profiles,
 					  name, info);
 		*lookupname = name;
 		break;
@@ -690,7 +694,7 @@ static struct aa_label *profile_transition(const struct cred *subj_cred,
 	}
 
 	if (profile_unconfined(profile)) {
-		new = find_attach(bprm, profile->ns,
+		new = find_attach(&bprm->file->f_path, profile->ns,
 				  &profile->ns->base.profiles, name, &info);
 		/* info set -> something unusual that we should report
 		 * Currently this is only conflicting attachments, but other
@@ -720,8 +724,8 @@ static struct aa_label *profile_transition(const struct cred *subj_cred,
 	state = aa_str_perms(rules->file, state, name, cond, &perms);
 	if (perms.allow & MAY_EXEC) {
 		/* exec permission determine how to transition */
-		new = x_to_label(profile, bprm, name, perms.xindex, &target,
-				 &info);
+		new = x_to_label(profile, &bprm->file->f_path, name,
+				 perms.xindex, &target, &info);
 		if (new && new->proxy == profile->label.proxy && info) {
 			/* Force audit on conflicting attachment fallback
 			 * Because perms is never used again after this audit
-- 
2.53.0

