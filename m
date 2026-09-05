Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78C391822
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788618626; cv=none; b=WW1PC/aGjwv5/iLFMBalBmLL1HXBeFHkdxQQ/1sgPwSUcIUxg51bbU87Fj6AeiEgEy80qsMjtCVtkK76+7OAN2qCsRuc2mSferF7icGxnQt1ZBjOOsj3irolqTnCVnaa7uARpeoDmnGBlcyIBjaaQA9yQkHLr2XRijxjxIUOv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788618626; c=relaxed/simple;
	bh=eBGSGHU/Tzymz0iaumjMrEK6F+OoYPSv9cbMveqOZtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyTymwzSVyEiTfu+Uqv5jIR1eQH+3AiWOoO9lKat9yGHL+O+CwqAYxTXI9TgbDlG8arIHxtpzuUvTn5/a654OVlRY6PqW86P2lciiLUZqgAFigZYOEYW8BzmKxSYrXQov6/Ev9AY3nEiegRjnu6Oyeyv8HADQSKNRy6+k0bYNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvG1cRNR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvG1cRNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9951F00A3D;
	Sat,  5 Sep 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788618622;
	bh=zJt3lXWuoU8vstoiL42YbGwkRweidbzEvv4q9cAXqO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KvG1cRNRh479CzYJaXjJdw+HH6JE3GScTmCBy6CUbxFkqKorZx2mXK7zDOAuN7rl5
	 ExL31Mp89JLqCcq5Ps/21T29/9I5Ft7nB2wX5pyuHRYCsnso+g+zm2ZZyDBU3V8a5R
	 DXOE/ss6Sb4BQs+oFjKT3SiLfDbPpaFU0fcLxeThCnnSn26JAj/PgNBk76Dd20k4X0
	 9axsjJRQE0UBDEEYkxzOd+AQfWMVfHaAzcMkDm4NqknFD00+WH3MjLMCribpSnpBJD
	 nZolAM3Km38G8uJmLGoOQTXzJCyDujQUADIRbUMgRZ9nHSETiJ2OAmZNZ7X5U8Q6Vg
	 UDUiAS5lNMG3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nfsd: fix clock domain mismatch in clients_still_reclaiming()
Date: Sat,  5 Sep 2026 10:30:19 -0400
Message-ID: <20260905143019.226151-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090316-elixir-stoke-86b2@gregkh>
References: <2026090316-elixir-stoke-86b2@gregkh>
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
index c61e1a4ab620c..e04e8c6429731 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5945,7 +5945,7 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	time64_t double_grace_period_end = nn->boot_time +
+	time64_t double_grace_period_end = nn->boot_time_bt +
 					   2 * nn->nfsd4_lease;
 
 	if (READ_ONCE(nn->grace_end_forced))
@@ -8185,6 +8185,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
+	nn->boot_time_bt = ktime_get_boottime_seconds();
 	nn->grace_ended = false;
 	nn->grace_end_forced = false;
 	nn->client_tracking_active = false;
-- 
2.53.0

