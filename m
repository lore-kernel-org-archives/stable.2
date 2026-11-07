Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050023;
	b=QtR+LQavp8yCBIXOG1jDrQFecgfEqM89V8c5NeKkWx9sF1PbabVg3UY/1OjyAH1zvzzh
	 o2ZdMZP0yF9P7bWVuS8dqahf23XB5HWE8I/9TqL/1VjKsOfrLIit2aFqZ2hgXJEAUL1tt
	 DQfEzSfzMR82rHUbAfI3047F06dQBueE5ZYAkEe+CviJwZRaJNnuAsYwn7j2dq+mv5k2H
	 Sp7ilufc7VaPogccHjRrP8FF6gBoFMyUuzxG0EkYq4cmsarzSj9e+s4y4OviCwwzdlTNc
	 bkMShQwu7U2QkXTb27sDmT7edjRblSqRaBQrvNz95el2zTmSuAZe4OyyIISqGkgbzfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050023;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XMiiQLgoselXcyqSQm5v4wPgpCfP7t1pMxjJNP8xDaM=;
	b=eHJFfgFkncPGHz+x/3ReUS/Vsj2Prnl20dg/jt66GehV86VHTOmcmvJyjQg3FrIbvgav
	 ya+dRXxRmfRn3K/chKZXfXS8ZExbmKgPjOlbZ2LIm/7QDG7zUx6JjIf1NUUR5GTNOlxm1
	 qRe6+wdRsWBy7L38pUlIrvITT6x912y6NRO7YECo+d1r1HFHu56xx2AQQ5yLWNa+TBqQN
	 qtwpBn6dLvZDYUnWR2hfoPt52z9ViuRpU/TTTu8826bTPMgVFTdfZ5Sn2RtipJ1bLfANe
	 0ugKK8kEOJCpT1LANIS3rXQ7mZgtk72nv+/JD+n9vpkkkbmBn8Di7nn1xWunerTcrdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzQEBAVg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzQEBAVg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705D51F0089F;
	Sat,  7 Nov 2026 11:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050022;
	bh=XMiiQLgoselXcyqSQm5v4wPgpCfP7t1pMxjJNP8xDaM=;
	h=From:To:Cc:Subject:Date;
	b=NzQEBAVgJlcp5uNm9F7n5zYFrA6lY5rfZnsHKsGT8EkjMpFpfPoqXKX+mPKhkmCX6
	 WuKk3yo8+hX5Og9z1U5XFoiNxDMniita5KgbvHaxLfxNpTbneyvpQ8ZzKFPPCDwwkr
	 Gkoi+Isgb2KqQAy5H1sj5UJ20vXtciuGtM93+uebxuj8VCEJ0WfVPWPBF/n8uE6O6P
	 U/xorZRHaXKP+r7O5zTSCoaGjq5xDVr3/kLZV4EYnNtDahXGZYiFpkkg6prfTH5V+2
	 3Al4sov4ZOOpOYLXD7RmDue9ocE5uhYyMEhhb3MspIEHEr+cvN5TuxTkszcWVj2kac
	 y844fKFyFVroQ==
From: Sasha Levin <sashal@kernel.org>
To: georgia.garcia@canonical.com,
	john.johansen@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: remove fs entries created by a failed policy load" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:41 -0500
Message-ID: <20261107061341-failed-5.15-6ec46f8f1977@kernel.org>
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
git cherry-pick -x 6ec46f8f1977d218bf2494ce276152b2d01424af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061341-failed-5.15-6ec46f8f1977@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




