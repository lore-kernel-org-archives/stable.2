Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BA21ADC7
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788606171; cv=none; b=mMeR++0+3hlFa/6aaVCzMgV6748oDpeaTr89syWOa4GG63AzvVAx0D8dFZ/gP+E+HToXuGLfnLfqkzgfQVy92m+4BerQKw0BWrI7IiQhLRI9fCyQxcx2K0lBMDykHa3kp1LptLVQXRrsXzMTmxmqsFTnz/6EJa0FrEvlcV/EBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788606171; c=relaxed/simple;
	bh=Mr065B7/uPLPg1v+/pr7jCdffENTAzWagQN4dv5jq3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGLdubpS9kx1ZtoMCUjjcxs6m1G3zkfs/yGSQa09Ax1Hvkpmzty1WjS7ooZfftZ9IpFrONB6t49MXgYTKTdDm1kZRs9rvdHpkq8Ir2viiT6xWXhXwNwpxJtiJpGX26oHMBst22uTnxx9rt85jdr4OmNUhMJSMd/4dsvjPJODWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQMysAQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQMysAQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC48E1F00A3D;
	Sat,  5 Sep 2026 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788606167;
	bh=n4jBZaRhKqcOc67NiCuSyrhLsiNjR+Wil3PR0hNLZjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NQMysAQWBJMzSFKK9+g7eiEiuVBKHLbpbDcoql14h7nvGfc0lObvxr39dQKVciKdK
	 4vek5Hn4prmDURGRvsgT7QRIyEo5NIZcxtLnZGxrJBENiOJZR+5i6/1sW5kYoYHdan
	 KOuF5My8FQRQw5CvLyZ3dR/U2zj/yEF8sg6i0xam0hwwPpjv0xHazmZuDZw9OAapZo
	 j7MkWMYRdBDXTfJwFZ4HJBCxaNHPJ9ck1cb8yw8D16BvQwcwTP4P0w59TxFibBd6wS
	 lAxOtES3uEd/f/INI+J3i3B7sjz9Fy6D6IDou7UsD7kxyjwMrryL35RAC9w8CKw/Ad
	 0XSc6CqMFmB1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] nfsd: fix clock domain mismatch in clients_still_reclaiming()
Date: Sat,  5 Sep 2026 07:02:45 -0400
Message-ID: <20260905110245.3661974-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090314-hardcopy-exception-291b@gregkh>
References: <2026090314-hardcopy-exception-291b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 09ea3eb9a518565f5bca386e81b993ed8825f5e8 ]

clients_still_reclaiming() computes a deadline from nn->boot_time
(CLOCK_REALTIME, ~1.7 billion) but compares it against
ktime_get_boottime_seconds() (CLOCK_BOOTTIME, seconds since boot).
The comparison is always false — it would take ~54 years of uptime
for BOOTTIME to exceed the REALTIME-derived deadline.

This means any client can hold the server in grace indefinitely by
sending CLAIM_PREVIOUS OPEN requests, blocking all non-reclaim
operations for all other clients.

Add boot_time_bt (CLOCK_BOOTTIME) alongside the existing boot_time
and use it for the deadline computation. boot_time (CLOCK_REALTIME)
is preserved for its cl_boot clientid-nonce role.

Fixes: 20b7d86f29d3 ("nfsd: use boottime for lease expiry calculation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260611-nfsd-testing-v2-12-5b90e276f2d9@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[ preserved the branch’s boolean fields instead of the upstream flags bitmap ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h     | 1 +
 fs/nfsd/nfs4state.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index fe8338735e7cc..ca25cfa4c36e2 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -69,6 +69,7 @@ struct nfsd_net {
 	bool grace_end_forced;
 	bool client_tracking_active;
 	time64_t boot_time;
+	time64_t boot_time_bt;	/* same instant in CLOCK_BOOTTIME */
 
 	struct dentry *nfsd_client_dir;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9d9a7d46e7b2..9ab5135c052d9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6670,7 +6670,7 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	time64_t double_grace_period_end = nn->boot_time +
+	time64_t double_grace_period_end = nn->boot_time_bt +
 					   2 * nn->nfsd4_lease;
 
 	if (READ_ONCE(nn->grace_end_forced))
@@ -8993,6 +8993,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
+	nn->boot_time_bt = ktime_get_boottime_seconds();
 	nn->grace_ended = false;
 	nn->grace_end_forced = false;
 	nn->client_tracking_active = false;
-- 
2.53.0

