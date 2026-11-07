Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050032;
	b=VbcAUyCXXeevw/SecDo5CV8up5bdANVWZDRkDV/egIi01ZQwS9LE/wTAA+M5R2P8HeCY
	 YBgvCaSzBtQwlxqKJgi5hLKj8roHd9BsTl++wj6p8g6/ShwzdDeThjHhHGFSRSIxLM7WB
	 pcS268U/3h3xJFZf3B3D5WEKvWCJfYrITBcSWhqeBdreF7zDiGmkbF/mkZLvgZx5OTUOa
	 DSlmmlAvbevLTTbazay4YeE3gsHcENEqYpw6O1ktwEgRr21Vx8B2qCJInMx3cMB0VQK56
	 T8lfNc6yK9HQgjTAVyp/F56PgsnYBu3qQMBnBvqOk8oUBNSTj5LbvKVvS4y9vV6t9PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050032;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=he4P77s4VwyawguLJQWqkn8lOCRHp4PbdoHUtwi8Zxk=;
	b=PzlTdZq6k+fnsLxqrUAaSYabJgVTEeSY0KZ1hIr7f2kgG93yIt7bqNVPiLWZ5b7vPH0L
	 ZU6D+fTsohrQERw/VUkz5xfnQ5VchhpmMLsPa0xT23E+IZXuGKIeUQfkAMm03MHk8l/Xe
	 ViSbychqh+ZBuAd99WL1feLaisyHDJfLtHMytKM4B/oM1J6rI1hxahmMk3gnAfBmpRw4r
	 ZojoPW+JeOqbKlJCR3V5XfN37inXVGGwH3sEbsPsILjN5b2Aisjxtqb2ed0HxNMUU9XEV
	 DS4oHm84jC7vDxmeZioVma11qyJmTvgxlIJJF0eNgJ21n0ZrL3u0pmER6u5vSsvMbzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtXB48T4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47146606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtXB48T4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47471F0089F;
	Sat,  7 Nov 2026 11:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050032;
	bh=he4P77s4VwyawguLJQWqkn8lOCRHp4PbdoHUtwi8Zxk=;
	h=From:To:Cc:Subject:Date;
	b=HtXB48T4N2j7muB2vDvJ51MIbK9I9p01M9teuzszI1HAQpb03pjvmogtTE80tzURe
	 Hp5NEJ1NW6lDG3TPya2SvZdsyNNL84iKvvwypZAiFtIS+fffNQNWgtO9R7gj7HEk0t
	 +e7V80AG7JX+TqWvCyzbiqW5OeI1VE+9tCy96B1xVZdW0m2kX4OIE8qDorWBC38Cdr
	 Wvtbs7uUCJEJB8b1AaR+CL4ljqvjiynJl57CZE2rwAkYn4n2v6P9a63f9HPk73bkYV
	 COl3XitHeXC934bH2KP73eaHa9IfLZocyZU7YNcSnBLPJ2aNZHYbXuaW/IbiUkD/kQ
	 WkIbi0Q705zPg==
From: Sasha Levin <sashal@kernel.org>
To: georgia.garcia@canonical.com,
	john.johansen@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: fix profile leak when a policy load fails" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:50 -0500
Message-ID: <20261107061350-failed-5.15-ce94927fa417@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ce94927fa4173fcc1eca27bdc65a140064c8f1e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061350-failed-5.15-ce94927fa417@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ce94927fa4173fcc1eca27bdc65a140064c8f1e6 Mon Sep 17 00:00:00 2001
From: Georgia Garcia <georgia.garcia@canonical.com>
Date: Wed, 14 Oct 2026 19:08:21 -0300
Subject: [PATCH] apparmor: fix profile leak when a policy load fails

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
---
 security/apparmor/include/policy.h | 20 ++++++++++++++++++++
 security/apparmor/policy.c         |  3 +++
 security/apparmor/policy_unpack.c  |  4 +++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 0dcbf8cf1029a..bb851654cb80f 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -436,6 +436,26 @@ static inline void aa_put_profile(struct aa_profile *p)
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
index bfe969b869577..63f7821b4dfff 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1462,6 +1462,9 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 	}
 	list_for_each_entry_safe(ent, tmp, &lh, list) {
 		list_del_init(&ent->list);
+		/* new was never added to the policy tree */
+		aa_put_unpublished_profile(ent->new);
+		ent->new = NULL;
 		aa_load_ent_free(ent);
 	}
 
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 7ebffb4ff74fa..35dfa3b451f39 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1822,13 +1822,15 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 
 fail_profile:
 	kfree(ns_name);
-	aa_put_profile(profile);
+	aa_put_unpublished_profile(profile);
 
 fail:
 	if (compressed_data)
 		kvfree(compressed_data);
 	list_for_each_entry_safe(ent, tmp, lh, list) {
 		list_del_init(&ent->list);
+		aa_put_unpublished_profile(ent->new);
+		ent->new = NULL;
 		aa_load_ent_free(ent);
 	}
 
-- 
2.53.0




