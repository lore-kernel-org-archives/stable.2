Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457137;
	b=QvyHX2xssoCHusMQh4VJqhFVfV2YJ1Kx6aqPoS0pm1Yp7OyUv+FG/Z5OaDDbgJUyy85M
	 EL1GMdkhXaWSBXUbDUgLoTSCH9FOlBu9IBCjXZfwrRfKOFdrEA0X8E0kknlNeGs4VCxf5
	 uC6ktM8IXusCTxXnWYVp4Fg2+IPX0mgQupC3n8ZEJxrPqPc7T8SlBaQ7efo4iCXNmCxaf
	 jXzVKzVegua/XigStrJ8X52S26aCiZzFXjejT7x5Am3g3dQi7ihyG9UfnBgsn2saooCmf
	 kLo9KnNy0KPtemvRfgLhnJ/ZIQyiuIl/lLYuGnaRS5iozW48X+fCEwiLtaxVxeIfF0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457137;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I9JzCy8na1WnVaZ9QnplFC4i6ZeT5HWw/Sckc/KR640=;
	b=cVnnGPwjQozED4zFYLW0HL4GFEJQBXsFgzvKTN0flndONzICFKjTN7Yq5ogxl6/R8UpC
	 Rq+tgrlXgqVVwj+cayZ30xtGG2z4EPU58lg3aov7WOxvZI7EpX18HtTLeihReFil6dy/P
	 4Ae36sSDdRxBh7WL1HM5OhQLY2ElLdgn3nxPeCK/e4V2eWaEbXUrCna+Oro1aeMhfArIf
	 yz/hOu0fe6mu1uLPwznz6JszFSu4p61Fj2lt2X36ExwpCQjbTS9kZ1s/sNXUW778bL64t
	 z6iB3v7e5jHPQZSu49sDr99/amR+b2xVi4RX98jH1RVLBpZrMTyZbtR3/px6cKe9AMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3y4C6zt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22C606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3y4C6zt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6761F00A06;
	Thu, 12 Nov 2026 04:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457137;
	bh=I9JzCy8na1WnVaZ9QnplFC4i6ZeT5HWw/Sckc/KR640=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z3y4C6ztGTvfrXj6ESXatAfesWWDND57hysAQ3YRHZMc0glOOFjeJaefMNoQCwALU
	 JiCBAxssIIb1azBCd9kpqHgv5/o4Y5Z7916UqzyAmrUMxTrLtDmkNP900RWRDumF7t
	 jWu/lsfGg2g0HTaxyTsnFFtMbuSB/KPNB5U0IuY/xZWEP1Rof3mQwTArCVRqTLGKBW
	 3Y6Rakz5jiLaFgq/KAXhh7JVxbIPrOot5FwJ6ujjEiJ8gBNPHj46/JPJdN8bYNrSXP
	 83rb50IaSFCxbIwEwBSfztGGOMtaepug5g1KYa1Tb5MtDWN8WnWVwloVAvhxsDLinu
	 UF9GE00SE4PKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Georgia Garcia <georgia.garcia@canonical.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] apparmor: fix profile leak when a policy load fails
Date: Wed, 11 Nov 2026 23:18:55 -0500
Message-ID: <20261112041829.1966481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052803-failed-6.12-ce94927fa417@kernel.org>
References: <20261107052803-failed-6.12-ce94927fa417@kernel.org>
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
[ sashal: Adjusted helper insertion context to retain the existing non-const AUDIT_MODE() parameter. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/include/policy.h | 20 ++++++++++++++++++++
 security/apparmor/policy.c         |  3 +++
 security/apparmor/policy_unpack.c  |  4 +++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index e85824c90f430..47199bead884b 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -382,6 +382,26 @@ static inline void aa_put_profile(struct aa_profile *p)
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
 static inline int AUDIT_MODE(struct aa_profile *profile)
 {
 	if (aa_g_audit != AUDIT_NORMAL)
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index c9ffb1eec7a7c..62345fad007c3 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1403,6 +1403,9 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 	}
 	list_for_each_entry_safe(ent, tmp, &lh, list) {
 		list_del_init(&ent->list);
+		/* new was never added to the policy tree */
+		aa_put_unpublished_profile(ent->new);
+		ent->new = NULL;
 		aa_load_ent_free(ent);
 	}
 
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 46420587bcd52..f55ab21f0465c 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1501,11 +1501,13 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 
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

