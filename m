Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437762;
	b=CPkWTsLDu5Ja0K43nHTW4PbYdT8E7MnNHsU22n/Uq1gft6SjuhO/xZRTmHEzeAycj+Gm
	 +C+UJQxP/BZnWjpNhc2gklt7oOJK2SJjOj9QvwzhgXfvzrLf7X3mF9ZcQM+IoCzEXVCLL
	 awxQT2hCPNAoUnbxUF01oob8XskbpVzGkYWwgEzdpWae+lXWrZEhI76hX/J+QDfOUzhbJ
	 LplyrqHi/2l4VuhdLTgdirUDveGefLhd5rpSiez3BDTTluas4h9EMQXP1denxyiTldtFT
	 lq+3GcxMa+uW6EZLLulJ87lRRl8OcJwXISKDYPurLnpTLpVZZw6A+Hd4C5KgN6LcItg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437762;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6tdn3maK/d3oaxNfJio4R1UMJBBh1kUOfnJqTUOSOKM=;
	b=oT4kie3h8ihOKwGnt0+70v3sRo7AAQ9Jo2VriAmjuMKSC8bh+oNvIuG/RZ2F2NgdgNFN
	 TTeUmkWlk1TNwFbxpi26DOIvToBxm6NxtsrqndbsEV/VYliy29cJCTHs/jqZpNw9NCNt4
	 000fDiTFBFvIiCGMQF7Ke6IsnjR7xs90B1qyHNEONdGNmt5Wsu+EoQNpKi7HPASJXTDoG
	 cwVgEHOEVBQP9FJLAuXi+eY2Ea8SULvcGYPjm0GN/oPPIE5KSyX5WN3ogf/T4HVxcPCl/
	 MYPZaHoNLlTVnj0pmIx1BKuUxGImJKrE2Z6mPajzFyBpWqgipdc+UIU8T9XbCWNxlZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J8/BrU67";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF32606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8/BrU67
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300E41F00A08;
	Wed, 11 Nov 2026 22:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437761;
	bh=6tdn3maK/d3oaxNfJio4R1UMJBBh1kUOfnJqTUOSOKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J8/BrU67qxmiDO0iDnmKBqqdTGHC1I2L82uZlfqIi8ltzekzmpMTxPeYdc2lRrnRC
	 nbHovxxCZOmIBLAmqhrwF9RNPsm6VKho48aUg2Whv9WP0+EAAwGEfOA3wlzEw5pqD6
	 vMs5z7uXi0HtOJflBEgTb3ndesf9Nx62SujOSU04cPCUxQhbmpkI/rhdHSmXn4GqKC
	 KsPBH19u61xlCf9elFI8x3f3c+NMbK8imeSWKwyQwCA4n7+PweCB4uflDJiRrm9cnI
	 O7nQDpR3qRaNaLtzjxnAy/NZBXnv7FzOOhQjGcp/jhjiWiYkB0UVJINHNdBVCMwNny
	 FfPmDx+URqjIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Georgia Garcia <georgia.garcia@canonical.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] apparmor: remove fs entries created by a failed policy load
Date: Wed, 11 Nov 2026 17:55:59 -0500
Message-ID: <20261111225527.191760-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061341-failed-5.15-6ec46f8f1977@kernel.org>
References: <20261107061341-failed-5.15-6ec46f8f1977@kernel.org>
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
[ sashal: adjusted declaration context to add rawdata_created beside the existing udata_sz declaration at function entry ]
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

