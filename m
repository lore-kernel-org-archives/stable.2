Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAD2874E6
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616094; cv=none; b=MwcSmlpLRUQ3QBKRkFkNlmIw0te4j06WFZDnc4x/paffIX9YTKwe87nUslJjHg0AoYrn7FzTDcBdOPxoBzzPlZLdxraFBad/wMNU/Cyli9jPcPsojbyNdnQ4ziTkGnUd2A3UuQHGb90P1JFrJYPhWlms3iz4NbaaloTBuZ5Qc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616094; c=relaxed/simple;
	bh=tG+MLXNdnZhQ+gkON2RvU6u0nEZaIa3eDj4mb30Mpqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtpGyEvI7Np2UXzoyRRje0jJ7xNJeAWRu921rjMrjv8sc4BqDbggtW4vkDcEPoS9mAxBN3ppouxetOB3P+4mttIBJqgmag6TGIxD5Qq6MbfDF5yTtb2lQrtUNh0kIuUXDtyfA5nvfqGYfQk4i1ow27J37NWnuiMlG6MYAhg6OzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADaa570V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADaa570V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC841F00A3D;
	Sat,  5 Sep 2026 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788616092;
	bh=aZd5sN/k/1fOukcBOVkSVOdDe3jnw7pydLt460VnpXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ADaa570VASCbZgvrd81/ZpF8m8SIFhBrspA8xcDBoVK8vF1n6wQHc4ZHdMY4Fsbmv
	 mP63v8t4ogGUmNnkT4ee+yQwbDKBq7N5u+hV8ct8qoVB9Ln6G1hhbsQWgYa6QtFZ/f
	 2WElxmZ7InFcz8iQrpKcZlpjxxAPRdYFhN87kP2lYdqHCcp90vDqSTSq/XGqH3TNQr
	 4dW97vvGSY1V/QfqaomRlJNsvI4A+Cn3pJ7ph5wNNiU1U1LEsNwGllQUR4okCXBu8N
	 8iziNQTqLRRHhgIzjV5yp6oZ13QJVhE5QTt28/MHr8aLF88dcuyiwZmUyMGNvZyzDr
	 /V1Y5yGjsUesg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nfsd: fix clock domain mismatch in clients_still_reclaiming()
Date: Sat,  5 Sep 2026 09:48:10 -0400
Message-ID: <20260905134810.83042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090315-grew-sinner-ab84@gregkh>
References: <2026090315-grew-sinner-ab84@gregkh>
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
index 0ecc5527a8f1a..abcda928dc478 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -68,6 +68,7 @@ struct nfsd_net {
 	bool grace_end_forced;
 	bool client_tracking_active;
 	time64_t boot_time;
+	time64_t boot_time_bt;	/* same instant in CLOCK_BOOTTIME */
 
 	struct dentry *nfsd_client_dir;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f21878a7f3939..76026cd549f94 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5990,7 +5990,7 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	time64_t double_grace_period_end = nn->boot_time +
+	time64_t double_grace_period_end = nn->boot_time_bt +
 					   2 * nn->nfsd4_lease;
 
 	if (READ_ONCE(nn->grace_end_forced))
@@ -8241,6 +8241,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
+	nn->boot_time_bt = ktime_get_boottime_seconds();
 	nn->grace_ended = false;
 	nn->grace_end_forced = false;
 	nn->client_tracking_active = false;
-- 
2.53.0

