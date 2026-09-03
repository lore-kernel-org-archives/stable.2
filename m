Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB324AF694
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442804; cv=none; b=UDfgm9wt0kKaxe3h6b8ze3Ig7fXjxiOaO5ZnOA2EMA3A6fW8IAM/hvkUVu9ty9Ywt+m6m/VXCC/9nSb75YbEWdVjiGZA2MoRu81Wy3osKZKufUTUVPl7aK89UJeemer3yY9mOf0SLujMXj5BCJMPfK6ptkRtQtNB5cqRhYH5wII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442804; c=relaxed/simple;
	bh=aX9zJlV2OmrkI1G4dRyfy1kYyWGA0l+67lLwgxmRmAU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IZlcebjywAv+aMEz10H1WLUjLQV4Km4BHfzB4vg8DS0Rah1m7UL+olljuqmcQ3kFlYo8zPRKLhFfm/Y2VbAStHtG4/2SiII91IG6CvpUnspqhu2bBMP3qpv/Adn2Nhjh3/aqmYJm39QNboPhTcuZRA74ENsDbcudRlqgIbNoCXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gAnZwus2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gAnZwus2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6731F000E9;
	Thu,  3 Sep 2026 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442796;
	bh=cU4D/losuMtEXikY3/qKn3kAueMjBf3jDPLKzd4CrN4=;
	h=Subject:To:Cc:From:Date;
	b=gAnZwus2krMJUh8DJMv1tBa4duY7AUvMASGfWDVc7wSOqCYJvW2Hp91/JQZ36sUJN
	 UZSsYidawUfI42gd1GqG2khHOtS9WEyXk+UE/GvuCibsNpMqgn5TogicvGGl5lbIv4
	 x+JdakL4fEEL4AviSoOri306ZX93VStFY8MGCiWg=
Subject: FAILED: patch "[PATCH] nfsd: fix clock domain mismatch in clients_still_reclaiming()" failed to apply to 5.15-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:13:16 +0200
Message-ID: <2026090316-venue-unreeling-bf4a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 09ea3eb9a518565f5bca386e81b993ed8825f5e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090316-venue-unreeling-bf4a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 09ea3eb9a518565f5bca386e81b993ed8825f5e8 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:55 -0400
Subject: [PATCH] nfsd: fix clock domain mismatch in clients_still_reclaiming()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 5c33c96da28e..03724bef10a7 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -78,6 +78,7 @@ struct nfsd_net {
 	struct lock_manager nfsd4_manager;
 	unsigned long flags;
 	time64_t boot_time;
+	time64_t boot_time_bt;	/* same instant in CLOCK_BOOTTIME */
 
 	struct dentry *nfsd_client_dir;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3dc0c0f6eb5d..17cb3b0ad956 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6870,7 +6870,7 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	time64_t double_grace_period_end = nn->boot_time +
+	time64_t double_grace_period_end = nn->boot_time_bt +
 					   2 * nn->nfsd4_lease;
 
 	if (test_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags))
@@ -9245,6 +9245,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
+	nn->boot_time_bt = ktime_get_boottime_seconds();
 	clear_bit(NFSD_NET_GRACE_ENDED, &nn->flags);
 	clear_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags);
 	nn->nfsd4_manager.block_opens = true;

