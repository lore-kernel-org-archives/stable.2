Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456352;
	b=uJSeQlXwQMEJBfg2zzfc1GWVWbZFNCvMQWm0hiJ7Svd9HQWipedKgr1PhSBdP+Wr6BaD
	 hXvQ2YnOszW7sEZ9PKXG+Yr7LTnQm8Wv4WBF32OoQ9AwhnV6aC7nhxLcGEa04YudF0vsK
	 JxKo5rQ4JQRrylgQzK/KwYfXi/t2hHJ/+Dpt3+w8hI9q31xWNiSCMmjoTI/YH/MDHV+bO
	 wF4rmO53bost07nM/8vdEfDXK4jQa8ojbA3PBFyEm7zMqehZozOG1+GAvPXI2Lpuuf/IR
	 6DNiugmMeJf+wIZE+jt1dOdbH/0prIuZT7C2OpaLG//bKL0lW8WK5k1ucpV8DqkIVzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CkV9w1xJohU4DvlXuCn8MkW1ZDYKHZ10hVef/zcOUUA=;
	b=3kfzO5WFA73I7tlkaOGak+HjcgTNbp75xWfeaNuY0ojZsYj7BuSrJMcAcIRy0febs+Fl
	 1o/YnXH2N9+gteqiSI1N13AgXbRKid3weScrITfaaai0RsSmt+dURuh0F3vX3ke9DGGgS
	 ZqMWrYZ/sJiSQj3mGyD6k/aDjFV/Y4rv0JYB6KGWQW4CGJ34LKwu2pXjJ3k+wY/yHjjwM
	 g+LZOS3X+PXl0fFfQFRQFy9O7O96tywULpx47IgCWU/qyPo4VBz9k238gwXsFuOCzL233
	 j+vla38F2oIkmTppaCnWh/W6dyr1lrrokoI2C1mUp2TDQ69w35QsMJUODn7/w2rUX6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7S9OLaV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD8606A331
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7S9OLaV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0101F00A07;
	Thu, 12 Nov 2026 04:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456352;
	bh=CkV9w1xJohU4DvlXuCn8MkW1ZDYKHZ10hVef/zcOUUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q7S9OLaVumXkMWOsUv6H0/AownrOCjnvJXGhkcj+rSBdZuoMjjxS92JcNw72GsFCm
	 yz5VNunslExb4/gDMiRz7KcPtsXhk1LSWI7T4Gk2zjmKcS0MKnCyQsV53VEWx285hi
	 w3FYcjplbMYsXcMLKu7lVfeVyZN9I4o1g9SOTIhf4KM/k6BtKSsk8LRH15VvkYdQvw
	 fu68m/BBAsqXYygzq522uXdyPLX36hePGF8VzWPatLjwd0bqriODftSy42O1E8dp4d
	 p51VNeVU1J4GMEkWNkG1skKzRpI0v21EIMSJSYlfK+wJM3Nh2QofMAfzrWTB4XmZpB
	 +/R46rdbpvPRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] apparmor: constify aa_perms parameters that are read-only
Date: Wed, 11 Nov 2026 23:05:47 -0500
Message-ID: <20261112040513.1836781-2-sashal@kernel.org>
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

[ Upstream commit e3bc982007fe5e704c6a7f5a189502ece056f68d ]

Several functions take a struct aa_perms * argument that is only ever
read from and never modified through the pointer. Mark those parameters
const struct aa_perms * to document intent and let the compiler enforce
that the permission set is not mutated.

The converted functions are:
  - aa_check_perms()
  - aa_do_perms()
  - do_perms() (af_inet)
  - match_label() (af_unix)
  - verify_perm()
  - aa_perms_accum() / aa_perms_accum_raw() (@addend only)

No functional change.

Signed-off-by: John Johansen <john.johansen@canonical.com>
Assisted-by: Claude:claude-opus-4.8
Stable-dep-of: ce94927fa417 ("apparmor: fix profile leak when a policy load fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/af_unix.c       |  2 +-
 security/apparmor/include/net.h   |  2 +-
 security/apparmor/include/perms.h | 11 ++++++-----
 security/apparmor/lib.c           |  2 +-
 security/apparmor/net.c           |  2 +-
 security/apparmor/policy_unpack.c |  2 +-
 6 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index aa2b31d5598cd..7ba775017586b 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -172,7 +172,7 @@ static aa_state_t match_to_peer(struct aa_policydb *policy, aa_state_t state,
 static aa_state_t match_label(struct aa_profile *profile,
 			      struct aa_ruleset *rule, aa_state_t state,
 			      u32 request, struct aa_profile *peer,
-			      struct aa_perms *p,
+			      const struct aa_perms *p,
 			      struct apparmor_audit_data *ad)
 {
 	AA_BUG(!profile);
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index 0d0b0ce427238..021a35b94bd7e 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -86,7 +86,7 @@ extern struct aa_sfs_entry aa_sfs_entry_network[];
 extern struct aa_sfs_entry aa_sfs_entry_networkv9[];
 
 int aa_do_perms(struct aa_profile *profile, struct aa_policydb *policy,
-		aa_state_t state, u32 request, struct aa_perms *p,
+		aa_state_t state, u32 request, const struct aa_perms *p,
 		struct apparmor_audit_data *ad);
 /* passing in state returned by XXX_mediates_AF() */
 aa_state_t aa_match_to_prot(struct aa_policydb *policy, aa_state_t state,
diff --git a/security/apparmor/include/perms.h b/security/apparmor/include/perms.h
index 37a3781b99a08..695d9b0572d4f 100644
--- a/security/apparmor/include/perms.h
+++ b/security/apparmor/include/perms.h
@@ -105,7 +105,7 @@ extern struct aa_perms allperms;
  * @addend: perms struct to add to @accum
  */
 static inline void aa_perms_accum_raw(struct aa_perms *accum,
-				      struct aa_perms *addend)
+				      const struct aa_perms *addend)
 {
 	accum->deny |= addend->deny;
 	accum->allow &= addend->allow & ~addend->deny;
@@ -132,7 +132,7 @@ static inline void aa_perms_accum_raw(struct aa_perms *accum,
  * @addend: perms struct to add to @accum
  */
 static inline void aa_perms_accum(struct aa_perms *accum,
-				  struct aa_perms *addend)
+				  const struct aa_perms *addend)
 {
 	accum->deny |= addend->deny;
 	accum->allow &= addend->allow & ~accum->deny;
@@ -208,12 +208,13 @@ void aa_audit_perm_mask(struct audit_buffer *ab, u32 mask, const char *chrs,
 			u32 chrsmask, const char * const *names, u32 namesmask);
 void aa_apply_modes_to_perms(struct aa_profile *profile,
 			     struct aa_perms *perms);
-void aa_perms_accum(struct aa_perms *accum, struct aa_perms *addend);
-void aa_perms_accum_raw(struct aa_perms *accum, struct aa_perms *addend);
+void aa_perms_accum(struct aa_perms *accum, const struct aa_perms *addend);
+void aa_perms_accum_raw(struct aa_perms *accum, const struct aa_perms *addend);
 void aa_profile_match_label(struct aa_profile *profile,
 			    struct aa_ruleset *rules, struct aa_label *label,
 			    int type, u32 request, struct aa_perms *perms);
-int aa_check_perms(struct aa_profile *profile, struct aa_perms *perms,
+int aa_check_perms(struct aa_profile *profile, const struct aa_perms *perms,
 		   u32 request, struct apparmor_audit_data *ad,
 		   void (*cb)(struct audit_buffer *, void *));
 #endif /* __AA_PERM_H */
+
diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index 5d53c15e46a9e..3b982770c4ceb 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -415,7 +415,7 @@ void aa_profile_match_label(struct aa_profile *profile,
  *       error code will indicate whether there was an explicit deny
  *	 with a positive value.
  */
-int aa_check_perms(struct aa_profile *profile, struct aa_perms *perms,
+int aa_check_perms(struct aa_profile *profile, const struct aa_perms *perms,
 		   u32 request, struct apparmor_audit_data *ad,
 		   void (*cb)(struct audit_buffer *, void *))
 {
diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index cf590dd08540c..73a272576d5d6 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -166,7 +166,7 @@ void audit_net_cb(struct audit_buffer *ab, void *va)
 /* standard permission lookup pattern - supports early bailout */
 int aa_do_perms(struct aa_profile *profile, struct aa_policydb *policy,
 		aa_state_t state, u32 request,
-		struct aa_perms *p, struct apparmor_audit_data *ad)
+		const struct aa_perms *p, struct apparmor_audit_data *ad)
 {
 	struct aa_perms perms;
 
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 391665c27ede1..8dc2adedc7ae1 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1257,7 +1257,7 @@ static bool verify_dfa_accept_index(struct aa_dfa *dfa, int table_size)
 	return true;
 }
 
-static bool verify_perm(struct aa_perms *perm)
+static bool verify_perm(const struct aa_perms *perm)
 {
 	/* TODO: allow option to just force the perms into a valid state */
 	if (perm->allow & perm->deny)
-- 
2.53.0

