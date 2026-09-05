Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A221D3F5
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617814; cv=none; b=j8vzNcVhIszFapeHkjk2wvtu09TmuYv+QNpdMDl2tWHYitDU6qNgnR4tX76OyVYS3IF5ceLrup3oTANrio8RPrkwvIFjloiqVTIFDPMjFEkU0bdCXxWxoVa1cfUlX4GYfvp802dscra6ESX/UuvMTq38KaAAIxOvTboCSH1aTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617814; c=relaxed/simple;
	bh=jN8r6AXPAfYsUHclsMW+oZNZFPpKcuYZ8XfMZrFsoj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jA96xHsrU6uGmNxgAH/7rF482RNadCeAU6z7Zi3nCq5FHl8+4fYvaGTIiCDbSbHlIPomwjKtL/QhdbZWK6IfwyFs/T19O5WJ6ovCZUEE0dpuXqxI6eytZMf9F0p+y0/5ldlWArGGScqfrPW9TEFOcJrr2XX/kgi14sxsS25UTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cncbV82V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cncbV82V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA0D1F00A3D;
	Sat,  5 Sep 2026 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788617812;
	bh=GoXUf8RD1MDHyMyun3CG5vNH9T9x7GrO+6qfRXnboEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cncbV82V/9MdRTxD4p5o9aj1jkI9CRKAX6n78+9/J/e06an0lDvk323hb4txZiKaK
	 J31FVK8il5YXt0qx2q5TBf6AEdI0xQkwBDgUfyIcMsnvEyjV6IlJNSKELymXyjptNF
	 /4tdftNcDGjg1vkj7PA9+8OS5ErK5BLioj+JoA8j31up/WcrOrDy/ko7+s+Vo9gbWz
	 JngpzdrZtwIttt6svKawIX//WSniCV8eIhjLwT/9zUeKSiDBIuBiuVNj/MIgF444GR
	 UNntrQ3vmdSOjIXzffhPBDznREItTxNq++1xWes7aCcttmi3KyIPLDeanz/qaaxhcf
	 VgS+7iXe0lfXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nfsd: fix clock domain mismatch in clients_still_reclaiming()
Date: Sat,  5 Sep 2026 10:16:49 -0400
Message-ID: <20260905141649.190925-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090316-venue-unreeling-bf4a@gregkh>
References: <2026090316-venue-unreeling-bf4a@gregkh>
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
index be0c8f1ce4e3e..b95ad49800533 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -67,6 +67,7 @@ struct nfsd_net {
 	bool grace_end_forced;
 	bool client_tracking_active;
 	time64_t boot_time;
+	time64_t boot_time_bt;	/* same instant in CLOCK_BOOTTIME */
 
 	struct dentry *nfsd_client_dir;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e6c0b1520973e..14a92cb859270 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5949,7 +5949,7 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	time64_t double_grace_period_end = nn->boot_time +
+	time64_t double_grace_period_end = nn->boot_time_bt +
 					   2 * nn->nfsd4_lease;
 
 	if (READ_ONCE(nn->grace_end_forced))
@@ -8176,6 +8176,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
+	nn->boot_time_bt = ktime_get_boottime_seconds();
 	nn->grace_ended = false;
 	nn->grace_end_forced = false;
 	nn->client_tracking_active = false;
-- 
2.53.0

