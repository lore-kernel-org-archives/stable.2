Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437935;
	b=c/vaXRy1BykLnAN2X00IoUyCU1mp7gAB/LiLyv2VHGj7SM8o9L30QBUvxXrCdWoE6kUI
	 xzaYsOmWvNv/2g0a7D2SQ+36QqDobRqp+PBAotMg/lpgQ9a/SU5RUoogo1NyROIhWlqLm
	 aO2ArAKjRxrTmPhBcjnMKm+py8bd4ZDygAjsfubw8XJznOGENPpqRTIGheCR9W140ndIX
	 EGTUfLQX2tdNvJ8hUtGYzzEF3dWQyB7QB8z5E4sInM9hnMLz1TDXgeAS37tIuKPcP24kF
	 Lgk0WD4zHnoq2bgT+KqDry5tPILJSdoqPwEo7KUHZZpRnG9ndCnzm99mORHUWdzaYOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437935;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TzJTPbR6SC9l5NI7nxCWU+amiTYjFZi6nsMXDnNAE1s=;
	b=eaxg6rbywm21CAq7rPSTZ9c2AOVfUkQ3E4ue0J4I7Q3psDOJmQI6Um+HQXLBbW201XbM
	 gkXSLuN8M3msCK/QDDKoG7+F5xe/ICcfwoqLUHfgXEbmNP1IkedCudp8BjFe8GzRnraYa
	 0SSF/y+4CZzuBtWHbY3M35WwlSO0Hkb7kU+edz58OCZsM1qqFVd7+KVtp7qz60ODWwLN6
	 pnBiwDCrRCdis9IYHDzVDg8/C5krur/IH1AMkctcfZ7evSOzDBkvXR+B5yo4Wb7/Kp3aH
	 G6bMyD7Ojy2/+ZLAWSFFkU04y6zgv8bUUKGRUWrwNOiXxBJRX3W2/704yfwxXVUId1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDdDiNy8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABA606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDdDiNy8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAED01F00A05;
	Wed, 11 Nov 2026 22:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437934;
	bh=TzJTPbR6SC9l5NI7nxCWU+amiTYjFZi6nsMXDnNAE1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jDdDiNy8CBR80hDlO+FmGwBOZUlZZiQjo/IqaSmXt1cCVKJfbW1mtv+fZBaDhMyqX
	 6XQGjpaj8qSLYBT3dj9YEkb/ZU5O7gEO582eeQMJeCdqc6GhfRuC63Q9CYFsShRmNf
	 hx27tROgq4kxjb0CeqvBYcPVs7f3jCezqSZfyaC1r9ISkk7g8lQgFbvicisYx5qo+V
	 dZShU3kuHKI/W3rH1vcO2AylONSweEilJR5i+tmeoho7r1TlGRg9mkK6zka1yOspUP
	 A+vycT82RxzWSUr0eYUZsjzG+aJa16PwepQsv5+SOlFfSxOh3VGCzc5PL0CwwC4XJu
	 Oj0oIxQnAD1pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Georgia Garcia <georgia.garcia@canonical.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] apparmor: remove fs entries created by a failed policy load
Date: Wed, 11 Nov 2026 17:58:52 -0500
Message-ID: <20261111225830.384997-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063102-failed-5.10-6ec46f8f1977@kernel.org>
References: <20261107063102-failed-5.10-6ec46f8f1977@kernel.org>
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

[ Upstream commit 6ec46f8f1977d218bf2494ce276152b2d01424af ]

aa_replace_profiles() creates the raw_data/<rev> directory for the
loaddata and the profile directories for new profiles before the last
checks that can fail. When one of those checks fails, the fail path
releases the ns lock without removing what this load created.

The raw_data directory is named after the current ns revision, and the
revision is only bumped by a successful load. The stale directory is
only removed once the loaddata's last profile reference is dropped, from
a workqueue. Until then, every load fails to create raw_data/<rev> with
-EEXIST. If the new profiles are never freed, which is the case when
their dents are left behind pinning the proxy, that never happens and no
policy can be loaded until reboot.

While still holding the ns lock in the fail path, remove the profile
directories of the new profiles and, if this load created it, the
raw_data directory.

Fixes: 5d5182cae401 ("apparmor: move to per loaddata files, instead of replicating in profiles")
Cc: stable@vger.kernel.org
Signed-off-by: Georgia Garcia <georgia.garcia@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
[ sashal: Adjusted context for different local variable declarations in aa_replace_profiles(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/policy.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index f3592af433553..dd8439e9cf55b 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -923,6 +923,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 	const char *op;
 	ssize_t count, error;
 	ssize_t udata_sz;
+	bool rawdata_created = false;
 	LIST_HEAD(lh);
 
 	op = mask & AA_MAY_REPLACE_POLICY ? OP_PROF_REPL : OP_PROF_LOAD;
@@ -1041,6 +1042,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 			ent = NULL;
 			goto fail_lock;
 		}
+		rawdata_created = true;
 	}
 	list_for_each_entry(ent, &lh, list) {
 		if (!ent->old) {
@@ -1119,6 +1121,18 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 	return udata_sz;
 
 fail_lock:
+	/*
+	 * Remove fs entries created by this load. Nothing else references
+	 * them yet, and leaving them behind would leak the new profiles
+	 * (their dents pin the proxy) and make the next load at the same,
+	 * unbumped ns revision fail with -EEXIST on its raw_data dir.
+	 */
+	list_for_each_entry(tmp, &lh, list) {
+		if (!tmp->old)
+			__aafs_profile_rmdir(tmp->new);
+	}
+	if (rawdata_created)
+		__aa_fs_remove_rawdata(udata);
 	mutex_unlock(&ns->lock);
 
 	/* audit cause of failure */
-- 
2.53.0

