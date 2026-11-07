Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051065;
	b=Bhb9/UkHR+c8k6vB+vTDGe4NcFEQBu1tgH9mHH85YLZgMR+5mRoX+fzZNaxQwOGJDPjY
	 Dm16IUl5O/U1ko/WJ0NGN2eS6qXX8aJUa/CHDLKho0kJvDtuSNKDUi6QI1ad/6idaac2k
	 Ow62L2O1KxU2hcx1P1pCbVStjx/sBEgQfaytFvkHziG0X4b0Wgt6tVusaSgdvQexnVohr
	 vosLc0+tlBu1dBaTODLAWs1AL9GgVPXO7jRAEiQ66P9jvdgxykIsAfTFD1UxyvzX7FdX/
	 xer0Drfgox9460LiYPJzlEebOjs3t/KebqZLM2EvE1/fcyKlij2vTHeqpm7R6FVoRYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jkZ1fJ/9utsx8dM5Oz4ryt9dWbUwfXNcZhe5LJHg8iM=;
	b=Brf+xgw7uRjkXy2iPRErgApGGhWpRG2S2h3QZ89rJulHjyfDqQaOLmqZ2PL10c6iiAYZ
	 Op60fEnNcN+s/y+jQ0lTPDv3E40je+71ZzqW9gePPVl9aGWHK83OVwpfNZ6jsJEC2TIWC
	 gdmbq/RCTnga0FLlgs8u0ayoPhYbRP82dY3RP4tsGIKglzmmIhsGL8swbJ1f17a2dM+7M
	 K3xgxZLV59OwXOkbMZ8eW522GlZmORAaI64gr+OKP7uivo4qd8vAq0PHwC/nxz/Z/U6qV
	 HLGmNp0Q3nLFozVAGrN6htyv4CY/X2E4NDXM7BTVGzYL7ngqy39U6dba/jgQOQylZXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccmKA0Qu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC732606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccmKA0Qu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648231F0089F;
	Sat,  7 Nov 2026 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051064;
	bh=jkZ1fJ/9utsx8dM5Oz4ryt9dWbUwfXNcZhe5LJHg8iM=;
	h=From:To:Cc:Subject:Date;
	b=ccmKA0Qur0hetBwJahfhukvwVGp4t5ctLQbsAAtXbvRnkrQf8SzUnoyPEusnMbfCx
	 z9AHQLee9FGgq+G34SCU6DrGt8HV1d3BTIIDvL+kCY+V5hW1/oTQTRQywCD+WGDAWi
	 kMlK2K9AFOS5QPVLEZuTJAZV4RpkKS+xgtGrodpwEkXKdcI/iUwv7vi1ORz2EMnIFa
	 X82YORr+X+DGJa4cr4O+wXUF4KwHc0oy74qre0YMc7qH9Mb8g6HIQ+hSBQqAiJwVvD
	 NFV4TyWT+NWo6jmq853bzq+PSXYDWw9olWaVxGXhIjzstjxJUu/DMMg4dJdahnS+Ot
	 y3h7hC9D7pM/w==
From: Sasha Levin <sashal@kernel.org>
To: georgia.garcia@canonical.com,
	john.johansen@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: remove fs entries created by a failed policy load" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:31:03 -0500
Message-ID: <20261107063102-failed-5.10-6ec46f8f1977@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6ec46f8f1977d218bf2494ce276152b2d01424af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063102-failed-5.10-6ec46f8f1977@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6ec46f8f1977d218bf2494ce276152b2d01424af Mon Sep 17 00:00:00 2001
From: Georgia Garcia <georgia.garcia@canonical.com>
Date: Wed, 14 Oct 2026 19:08:20 -0300
Subject: [PATCH] apparmor: remove fs entries created by a failed policy load

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
---
 security/apparmor/policy.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 397f9ff78aeb1..f6f7cdcb62126 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1191,6 +1191,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 	struct aa_loaddata *rawdata_ent;
 	const char *op;
 	ssize_t count, error;
+	bool rawdata_created = false;
 	LIST_HEAD(lh);
 
 	op = mask & AA_MAY_REPLACE_POLICY ? OP_PROF_REPL : OP_PROF_LOAD;
@@ -1330,6 +1331,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 			ent = NULL;
 			goto fail_lock;
 		}
+		rawdata_created = true;
 	}
 	list_for_each_entry(ent, &lh, list) {
 		if (!ent->old) {
@@ -1425,6 +1427,18 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
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




