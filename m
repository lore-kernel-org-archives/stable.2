Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456353;
	b=UeL8eee0p+XtWJADwxnal7o77WF2r9/ysTNyI7H4AHDH1p2fEejmlflEjKsVeq8dqP9L
	 gspQ7IQSlDN6fjn2vYNhHyAPrrO9+W/6+A1yKrAmwgT5JtnulWKZMipPHEBJOCDcdcxlX
	 ERD9QkF2jygNgMTNO1LyARaaBPD9/Mmr8u+sO1SCyjqv6N7G/3jQBQhTPOMXtQaFQn/uE
	 rtVm/yQRPOegAB7QBZQ6jEDq/bWNsVSKT4nAwVmr4olLX6yY+1v03gV8VRTIN0EkimCIc
	 zLxj6IbbIPnk2q5Az3lkJDZHVHR05uHxbsZvNL9b3ZJTeS8u7n397IdqtWRRLzbMvHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456353;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w9OgCEr7JL9E4O0fyVE0knby0ySyWx/YUf+uFsXl0MQ=;
	b=UmzlJpT/2UGttnWJzRI2QXSDSnCbG/AO+Cbi6xzMdskkuEgOiK56Cut2J6jAQrV/FoAN
	 eImmEujKerJMO7YLhUdtQvOYtABSSHJdsykNGyyVlmu/Kmqe+j0va/HvAdtAwFBK+howP
	 pPzZrs5cHHASByM36HhKLfAwBTsn3gtAIrujY8in3zP4bbcyf6QNLTotScZII9nyy1UMp
	 262eMBlAGgcb5f20W9wRm1NZFpvf6z9TO4qHqlyGlp0r4qB4JoxPVfu5ykD3mpZ8pE+Ky
	 8NVP42rSlMSHLyKdR2s4u3Yc4oK8u51hAJZ8pmNRD/NnolG/f+biVAn90SzQa1OMUnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cu4xqI3N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2C606A331
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cu4xqI3N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6313C1F00A05;
	Thu, 12 Nov 2026 04:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456352;
	bh=w9OgCEr7JL9E4O0fyVE0knby0ySyWx/YUf+uFsXl0MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cu4xqI3NlvcZwxBPdyK4KfgbUFPk626qpMoTMOd9n/mn4NeG++lQuZ1flcFxFbAUZ
	 mwgtlc+gfLsRk1llJJ8V/iQIS0UlGIyKHeoemqUtjbP4JN5CYHyWLHoWNf3BxXjvr5
	 IPYKnKL/m1KfET1bXeOHukltZzhgYISQKJcWUH9QWRdDlz+6QHQushzG0lpC3sFadi
	 6A/O82stReavUnCavDTW8dXV9kWEED0agAy5nXSOMf3TON4wGc5L7kCORi/zl5prta
	 69yGUYLoTdHY6qSXEHfC7p8XNKRiZ+WvWAmYUwrxJtbO/iVrEmboW48Qc5O+iqI1Xt
	 bQjV1HcPTc9bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] apparmor: constify aa_profile parameters on read-only compute paths
Date: Wed, 11 Nov 2026 23:05:48 -0500
Message-ID: <20261112040513.1836781-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112040513.1836781-1-sashal@kernel.org>
References: <20261107051557-failed-6.18-ce94927fa417@kernel.org>
 <20261112040513.1836781-1-sashal@kernel.org>
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

[ Upstream commit 08066bcdeed037a99c47f7c8456cf30ee3055048 ]

A number of functions take a struct aa_profile * argument that is only
ever read from: they compute DFA matches or apply the profile's mode
flags without modifying the profile, taking a reference on it, or
touching its embedded label. Mark those parameters const struct
aa_profile * to document intent and let the compiler enforce it.

The converted functions are the permission "compute" path plus a few
pure readers:
  - aa_apply_modes_to_perms(), aa_profile_match_label()
  - AUDIT_MODE()
  - aa_label_match() and its match_component()/label_compound_match()/
    label_components_match() helpers (label.c)
  - match_component()/label_compound_match()/label_components_match()/
    label_match()/change_profile_perms()/aa_xattrs_match() (domain.c)
  - match_iface()/match_addr_iface()/match_addr_iface_label()/
    skb_match_to_sk()/skb_match_to_cmd() (af_inet.c)
  - aa_profile_capget(), path_flags(), profile_query_cb()

The remaining aa_profile * parameters cannot be made const: the audit
path stores &profile->label into the owned, refcounted
apparmor_audit_data.subj_label/peer fields, and the domain/lifecycle
paths take references on the profile's embedded label
(aa_get_label()/aa_get_newest_label()/aa_get_profile()) or write
profile fields.

No functional change.

Signed-off-by: John Johansen <john.johansen@canonical.com>
Assisted-by: Claude:claude-opus-4.8
Stable-dep-of: ce94927fa417 ("apparmor: fix profile leak when a policy load fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/apparmorfs.c         |  3 ++-
 security/apparmor/capability.c         |  2 +-
 security/apparmor/domain.c             | 16 ++++++++--------
 security/apparmor/include/capability.h |  2 +-
 security/apparmor/include/label.h      |  2 +-
 security/apparmor/include/perms.h      |  4 ++--
 security/apparmor/include/policy.h     |  2 +-
 security/apparmor/label.c              | 10 +++++-----
 security/apparmor/lib.c                |  5 +++--
 security/apparmor/mount.c              |  2 +-
 10 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 4dfca0c6e938d..7db41581b7b21 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -690,7 +690,8 @@ static const struct file_operations aa_fs_ns_revision_fops = {
 	.release	= ns_revision_release,
 };
 
-static void profile_query_cb(struct aa_profile *profile, struct aa_perms *perms,
+static void profile_query_cb(const struct aa_profile *profile,
+			     struct aa_perms *perms,
 			     const char *match_str, size_t match_len)
 {
 	struct aa_ruleset *rules = profile->label.rules[0];
diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index b9ea6bc45c1a7..2f3c6c84358de 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -191,7 +191,7 @@ int aa_capable(const struct cred *subj_cred, struct aa_label *label,
 	return error;
 }
 
-kernel_cap_t aa_profile_capget(struct aa_profile *profile)
+kernel_cap_t aa_profile_capget(const struct aa_profile *profile)
 {
 	struct aa_ruleset *rules = profile->label.rules[0];
 	aa_state_t state;
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 57e886b8ef461..1bfd36d8dfde2 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -90,8 +90,8 @@ static int may_change_ptraced_domain(const struct cred *to_cred,
  * If a subns profile is not to be matched should be prescreened with
  * visibility test.
  */
-static inline aa_state_t match_component(struct aa_profile *profile,
-					 struct aa_profile *tp,
+static inline aa_state_t match_component(const struct aa_profile *profile,
+					 const struct aa_profile *tp,
 					 bool stack, aa_state_t state)
 {
 	struct aa_ruleset *rules = profile->label.rules[0];
@@ -126,7 +126,7 @@ static inline aa_state_t match_component(struct aa_profile *profile,
  * @perms should be preinitialized with allperms OR a previous permission
  *        check to be stacked.
  */
-static int label_compound_match(struct aa_profile *profile,
+static int label_compound_match(const struct aa_profile *profile,
 				struct aa_label *label, bool stack,
 				aa_state_t state, bool inview, u32 request,
 				struct aa_perms *perms)
@@ -188,7 +188,7 @@ static int label_compound_match(struct aa_profile *profile,
  * @perms should be preinitialized with allperms OR a previous permission
  *        check to be stacked.
  */
-static int label_components_match(struct aa_profile *profile,
+static int label_components_match(const struct aa_profile *profile,
 				  struct aa_label *label, bool stack,
 				  aa_state_t start, bool inview, u32 request,
 				  struct aa_perms *perms)
@@ -252,7 +252,7 @@ static int label_components_match(struct aa_profile *profile,
  *
  * Returns: the state the match finished in, may be the none matching state
  */
-static int label_match(struct aa_profile *profile, struct aa_label *label,
+static int label_match(const struct aa_profile *profile, struct aa_label *label,
 		       bool stack, aa_state_t state, bool inview, u32 request,
 		       struct aa_perms *perms)
 {
@@ -286,7 +286,7 @@ static int label_match(struct aa_profile *profile, struct aa_label *label,
  * currently only matches full label A//&B//&C or individual components A, B, C
  * not arbitrary combinations. Eg. A//&B, C
  */
-static int change_profile_perms(struct aa_profile *profile,
+static int change_profile_perms(const struct aa_profile *profile,
 				struct aa_label *target, bool stack,
 				u32 request, aa_state_t start,
 				struct aa_perms *perms)
@@ -310,7 +310,7 @@ static int change_profile_perms(struct aa_profile *profile,
  * Returns: number of extended attributes that matched, or < 0 on error
  */
 static int aa_xattrs_match(const struct path *path,
-			   struct aa_profile *profile, aa_state_t state)
+			   const struct aa_profile *profile, aa_state_t state)
 {
 	AA_BUG(!path);
 	AA_BUG(!profile);
@@ -318,7 +318,7 @@ static int aa_xattrs_match(const struct path *path,
 	int i;
 	struct dentry *d;
 	char *value = NULL;
-	struct aa_attachment *attach = &profile->attach;
+	const struct aa_attachment *attach = &profile->attach;
 	int size, value_size = 0, ret = attach->xattr_count;
 
 	if (!attach->xattr_count)
diff --git a/security/apparmor/include/capability.h b/security/apparmor/include/capability.h
index 1ddcec2d1160d..ec4bf70e3410b 100644
--- a/security/apparmor/include/capability.h
+++ b/security/apparmor/include/capability.h
@@ -36,7 +36,7 @@ struct aa_caps {
 
 extern struct aa_sfs_entry aa_sfs_entry_caps[];
 
-kernel_cap_t aa_profile_capget(struct aa_profile *profile);
+kernel_cap_t aa_profile_capget(const struct aa_profile *profile);
 int aa_capable(const struct cred *subj_cred, struct aa_label *label,
 	       int cap, unsigned int opts);
 
diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 75c49e713a749..42fcff72e1899 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -346,7 +346,7 @@ static inline const char *aa_label_str_split(const char *str)
 
 struct aa_perms;
 struct aa_ruleset;
-int aa_label_match(struct aa_profile *profile, struct aa_ruleset *rules,
+int aa_label_match(const struct aa_profile *profile, struct aa_ruleset *rules,
 		   struct aa_label *label, aa_state_t state, bool subns,
 		   u32 request, struct aa_perms *perms);
 
diff --git a/security/apparmor/include/perms.h b/security/apparmor/include/perms.h
index 695d9b0572d4f..5cc0b3c0225a9 100644
--- a/security/apparmor/include/perms.h
+++ b/security/apparmor/include/perms.h
@@ -206,11 +206,11 @@ void aa_audit_perm_names(struct audit_buffer *ab, const char * const *names,
 			 u32 mask);
 void aa_audit_perm_mask(struct audit_buffer *ab, u32 mask, const char *chrs,
 			u32 chrsmask, const char * const *names, u32 namesmask);
-void aa_apply_modes_to_perms(struct aa_profile *profile,
+void aa_apply_modes_to_perms(const struct aa_profile *profile,
 			     struct aa_perms *perms);
 void aa_perms_accum(struct aa_perms *accum, const struct aa_perms *addend);
 void aa_perms_accum_raw(struct aa_perms *accum, const struct aa_perms *addend);
-void aa_profile_match_label(struct aa_profile *profile,
+void aa_profile_match_label(const struct aa_profile *profile,
 			    struct aa_ruleset *rules, struct aa_label *label,
 			    int type, u32 request, struct aa_perms *perms);
 int aa_check_perms(struct aa_profile *profile, const struct aa_perms *perms,
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 2eaa1bee31bc0..69e6c93d2ff04 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -408,7 +408,7 @@ static inline void aa_put_profile(struct aa_profile *p)
 		kref_put(&p->label.count.count, aa_label_kref);
 }
 
-static inline int AUDIT_MODE(struct aa_profile *profile)
+static inline int AUDIT_MODE(const struct aa_profile *profile)
 {
 	if (aa_g_audit != AUDIT_NORMAL)
 		return aa_g_audit;
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 667f20363ebf1..d0610e9d7961a 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1253,9 +1253,9 @@ struct aa_label *aa_label_merge(struct aa_label *a, struct aa_label *b,
  * If a subns profile is not to be matched should be prescreened with
  * visibility test.
  */
-static inline aa_state_t match_component(struct aa_profile *profile,
+static inline aa_state_t match_component(const struct aa_profile *profile,
 					 struct aa_ruleset *rules,
-					 struct aa_profile *tp,
+					 const struct aa_profile *tp,
 					 aa_state_t state)
 {
 	const char *ns_name;
@@ -1287,7 +1287,7 @@ static inline aa_state_t match_component(struct aa_profile *profile,
  * @perms should be preinitialized with allperms OR a previous permission
  *        check to be stacked.
  */
-static int label_compound_match(struct aa_profile *profile,
+static int label_compound_match(const struct aa_profile *profile,
 				struct aa_ruleset *rules,
 				struct aa_label *label,
 				aa_state_t state, bool inview, u32 request,
@@ -1343,7 +1343,7 @@ static int label_compound_match(struct aa_profile *profile,
  * @perms should be preinitialized with allperms OR a previous permission
  *        check to be stacked.
  */
-static int label_components_match(struct aa_profile *profile,
+static int label_components_match(const struct aa_profile *profile,
 				  struct aa_ruleset *rules,
 				  struct aa_label *label, aa_state_t start,
 				  bool inview, u32 request,
@@ -1402,7 +1402,7 @@ static int label_components_match(struct aa_profile *profile,
  *
  * Returns: the state the match finished in, may be the none matching state
  */
-int aa_label_match(struct aa_profile *profile, struct aa_ruleset *rules,
+int aa_label_match(const struct aa_profile *profile, struct aa_ruleset *rules,
 		   struct aa_label *label, aa_state_t state, bool inview,
 		   u32 request, struct aa_perms *perms)
 {
diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index 3b982770c4ceb..3a65dc82fd8eb 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -358,7 +358,8 @@ void aa_audit_perm_mask(struct audit_buffer *ab, u32 mask, const char *chrs,
  *
  * TODO: split into profile and ns based flags for when accumulating perms
  */
-void aa_apply_modes_to_perms(struct aa_profile *profile, struct aa_perms *perms)
+void aa_apply_modes_to_perms(const struct aa_profile *profile,
+			     struct aa_perms *perms)
 {
 	switch (AUDIT_MODE(profile)) {
 	case AUDIT_ALL:
@@ -383,7 +384,7 @@ void aa_apply_modes_to_perms(struct aa_profile *profile, struct aa_perms *perms)
 		perms->prompt = ALL_PERMS_MASK;
 }
 
-void aa_profile_match_label(struct aa_profile *profile,
+void aa_profile_match_label(const struct aa_profile *profile,
 			    struct aa_ruleset *rules,
 			    struct aa_label *label,
 			    int type, u32 request, struct aa_perms *perms)
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 31f792817643c..f2cf3ec853e7d 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -278,7 +278,7 @@ static int do_match_mnt(struct aa_policydb *policy, aa_state_t start,
 }
 
 
-static int path_flags(struct aa_profile *profile, const struct path *path)
+static int path_flags(const struct aa_profile *profile, const struct path *path)
 {
 	AA_BUG(!profile);
 	AA_BUG(!path);
-- 
2.53.0

