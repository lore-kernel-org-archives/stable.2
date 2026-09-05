Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA639657A
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788606738; cv=none; b=qu5frMb2QD6jBUg6YFJsNhc7uxv79bEgEzz+p+1vcv8LMLJOqcJYJ7uukRLw/nQ9TGqJHKT5jm267QDhPz6SplzZ7AQL90oWHz15Ti0xmdVMUXzs+iKPfoY2xdXKe11AHEJTg5Uyj/hqDhvI7fRQN1kRxgafYmbTILGlH1UdF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788606738; c=relaxed/simple;
	bh=mA3DrnFusAaSSByxlODukNJhxrfVAGefp0lXjFlOmSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/7WjsFaOoGvLggGsjxD40lR8f2TLL6ZoSpjezD149QmWTz10pwIYTXIv3BhslvabZYAqvfiwSwpTvA1Vgg6JmKwxQLie+qi5aVWolYkli4uvAxriG07/BMg60SX4bqnIt2yXWkftfOlD8JwzN4uAL/f79xHFTCnyw28qUBWgaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THv4K8/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THv4K8/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A761F00A3D;
	Sat,  5 Sep 2026 11:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788606736;
	bh=RnDi7tyZ3sFLn60w+bnWLDTgN44sEl97AvimON1tH7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=THv4K8/Dcaf8YeO8/pQzBU3WCYjyiOY9WKGDXN8u/pV4KsNlW1ObqCeIZnsgteDWn
	 57uliaqv/UAFMGt9W7dLE204HJJhDZuuXFT0ajoCxI3yVxdrCvEiKkiuxsoFNwS/60
	 FVUM+4SNWEvq2WsJgpPz1CfKek9IoEppt4K/zXwTlVHKc0KrnECOAPzbKZeWeNsjJJ
	 m5cD9lgOC6IyR+nfDmA01KnY4Fd7H4v/BxHQAyf6lz3kubM4HeLv5YQulb6pr9aJ7y
	 FjgGYrkUfikMGeVmp6XfZIZ7UC6lP4OeRTqvcD1ds/al1FJ+jzarIrc6XhsZPuZFFx
	 JnAJm5yZGg8oQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nfsd: fix clock domain mismatch in clients_still_reclaiming()
Date: Sat,  5 Sep 2026 07:12:14 -0400
Message-ID: <20260905111214.3748490-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090314-portal-hardy-c77c@gregkh>
References: <2026090314-portal-hardy-c77c@gregkh>
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
index 09a06e46dab98..9cd7567d4f28a 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -69,6 +69,7 @@ struct nfsd_net {
 	bool grace_end_forced;
 	bool client_tracking_active;
 	time64_t boot_time;
+	time64_t boot_time_bt;	/* same instant in CLOCK_BOOTTIME */
 
 	struct dentry *nfsd_client_dir;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 342de8d2c4aa8..94c5829be6966 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6380,7 +6380,7 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	time64_t double_grace_period_end = nn->boot_time +
+	time64_t double_grace_period_end = nn->boot_time_bt +
 					   2 * nn->nfsd4_lease;
 
 	if (READ_ONCE(nn->grace_end_forced))
@@ -8719,6 +8719,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
+	nn->boot_time_bt = ktime_get_boottime_seconds();
 	nn->grace_ended = false;
 	nn->grace_end_forced = false;
 	nn->client_tracking_active = false;
-- 
2.53.0

