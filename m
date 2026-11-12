Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456353;
	b=KEg299HaxqcRLZ5vtJ+Dmf/Oru3JNMkwSnZnTtb0zq6eBqPCUX7L5yQk1nhapROQ9QWx
	 ljXw+TA9c9y/7nFIj0abrUnQPLwm3PQMvzVxhwyKLywboflNrhRebEXLitJlc2XWvv1U2
	 QmK91V2XUCrfNLWlcwmjWPNz62rO0A7VxS1Y2roNKt9CVK9hoT+clZuO0MxbeD351ie/K
	 kmgLLX9gpZkKIkq9jRTbegIGLGXylogLkIFanDZhGEMJe6AnE7byy36CU4kOPf6yMPfL2
	 I7+dfOneACe2RWl0lkht22DO77BBR90PJWn3iGJwIdSkhUj35iWX7pMDLwWeWm317RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456353;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uHDjrPJ3QaM+51xu7+hhtlA/XmuGRqtsfwcxeGle1UY=;
	b=jexL3Hb3atrOgjYsiu+PRLTiLV4ozpYVNb1R3dy7iXUjwACRZaNYfzpGR6yW6aroQI2/
	 EZa4rdjII1QiL1XwdEp2e08Hr0BoWFA4fQdUI/bgf4U4N600FYOOIys6HscKcvaZ849kw
	 50Xu4BR71qpcn0CHGItKD+0SMz8dFpGAd3Qb7F6KwleO/2x0PwlNeh1NzgEEx6z2vroSd
	 WtJohFEZxJQ3v02MrnuY4EQX4OfSWKoZ4aRfQLLz6Svats/+gtp65JNTvmvMLchx/R7dY
	 MYMpxKQ2TB4J9E41WXSi2MN33800vKG/SpaqVsFi2cQuLAIE4b7o56a7agCnLn9xOYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/bnTJJC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B4606A890
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/bnTJJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0683B1F00A07;
	Thu, 12 Nov 2026 04:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456353;
	bh=uHDjrPJ3QaM+51xu7+hhtlA/XmuGRqtsfwcxeGle1UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/bnTJJC/b+b7o/8u8blQJ6wAo6nWj9w42SoBfdsZczy6LNGlCev0dRWFjoKDFcWO
	 nI0RGMR+SwuN1j0+npA9z1L0mp/WECapnDRUlu+SJNJw/msISCY2cE6AEXTbsnJzk5
	 h3SlUnZVZ/MPDqpDGT7kjmSe5ITBAFniYrKQYiIVSXciTLhWAcwWW458t9YW6Nj/0l
	 JvCyrxJeDBpKePiXdDX6L8MJvvqv/3BiB5PTOk2W1JBvyDycfr9jMe0Fzxc+KuClEW
	 YBkwlhDbdP6MuYvdeHuXXG4kOZRE6QiQXs7UjIqpE9DNCkrN0BXN2/kGqyKX6sOjJ/
	 jaQUHsdFaRgkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Georgia Garcia <georgia.garcia@canonical.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] apparmor: fix profile leak when a policy load fails
Date: Wed, 11 Nov 2026 23:05:49 -0500
Message-ID: <20261112040513.1836781-4-sashal@kernel.org>
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

From: Georgia Garcia <georgia.garcia@canonical.com>

[ Upstream commit ce94927fa4173fcc1eca27bdc65a140064c8f1e6 ]

The error paths of aa_replace_profiles() and aa_unpack() do not break
the refcount cycle between label and proxy. They just aa_put_profile()
the new profiles, which drops the label refcount from 2 to 1, and the
proxy keeps the profile alive. Every failed atomic policy load
(e.g. "profile can not be replaced", or a later profile in the blob
failing to unpack) leaks every new profile in the set, along with its
proxy, rules and its loaddata reference.

The leak is usually not visible from userspace, because the raw_data
directory for a failed load is not created, but it becomes visible
when the blob is deduplicated onto an existing loaddata, which then
keeps its policy/raw_data/<rev> directory forever.

Add aa_put_unpublished_profile(), which drops the profile's own proxy
before putting the profile, and use it on those error paths. The
proxy of an unpacked profile is always freshly allocated and not
referenced by anything else before the profile is published, so
putting it is safe.

Fixes: 637f688dc3dc ("apparmor: switch from profiles to using labels on contexts")
Cc: stable@vger.kernel.org
Signed-off-by: Georgia Garcia <georgia.garcia@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/include/policy.h | 20 ++++++++++++++++++++
 security/apparmor/policy.c         |  3 +++
 security/apparmor/policy_unpack.c  |  4 +++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 69e6c93d2ff04..50dcf0147ae2b 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -408,6 +408,26 @@ static inline void aa_put_profile(struct aa_profile *p)
 		kref_put(&p->label.count.count, aa_label_kref);
 }
 
+/**
+ * aa_put_unpublished_profile - put a profile that was never made visible
+ * @p: profile  (MAYBE NULL)
+ *
+ * A newly allocated profile and its proxy reference each other
+ * (proxy->label holds a label refcount). That cycle is normally broken
+ * when the profile is replaced or removed, which redirects the proxy.
+ * A profile that is discarded before being added to the policy tree
+ * never goes through either path, so break the cycle here, otherwise
+ * the profile, its proxy and its rawdata are leaked.
+ */
+static inline void aa_put_unpublished_profile(struct aa_profile *p)
+{
+	if (p && p->label.proxy) {
+		aa_put_proxy(p->label.proxy);
+		p->label.proxy = NULL;
+	}
+	aa_put_profile(p);
+}
+
 static inline int AUDIT_MODE(const struct aa_profile *profile)
 {
 	if (aa_g_audit != AUDIT_NORMAL)
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 230d8428b4d31..e582df9327037 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1434,6 +1434,9 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 	}
 	list_for_each_entry_safe(ent, tmp, &lh, list) {
 		list_del_init(&ent->list);
+		/* new was never added to the policy tree */
+		aa_put_unpublished_profile(ent->new);
+		ent->new = NULL;
 		aa_load_ent_free(ent);
 	}
 
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 8dc2adedc7ae1..3e16612d2284e 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1556,11 +1556,13 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 
 fail_profile:
 	kfree(ns_name);
-	aa_put_profile(profile);
+	aa_put_unpublished_profile(profile);
 
 fail:
 	list_for_each_entry_safe(ent, tmp, lh, list) {
 		list_del_init(&ent->list);
+		aa_put_unpublished_profile(ent->new);
+		ent->new = NULL;
 		aa_load_ent_free(ent);
 	}
 
-- 
2.53.0

