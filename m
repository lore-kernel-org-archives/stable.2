Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B624AF667
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442793; cv=none; b=Ji/IaFq1famdwhW/3zHBzkOZjYxaAIdXGK0BUusuh8mjjGhUNQL9Ty/0blPX4YlrQH4z+UcvlycO+7+3jGlZ2oOTmPYMFlk8cCJ3FWggqmYbyMone85XyoDRbrRpfJvTvLN4rE2XeNfSmBx8IsicQcg9Oi6KG0w0Zl4nyVBo5ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442793; c=relaxed/simple;
	bh=tdJVUp9njlvUXygWblnCVsOEXyfC8cmVmQ0rBsOn0bs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SYeWYM4P3wFoV0d+R3WN+drvWycWGq0s6jno9XVJ++IZK0/ZHc1MYMzbX19ALrZuMUM5F60hQpYdQ1f1ult/t09H9lrWrigamJNaUb/QNyteYmLG4v3nGs2bOj+y5UP1nOwIxkeaRjxTN10eejf0k3Ii7er4M1jSN0K9k+1ZcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eu+vJvkF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eu+vJvkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C950B1F000E9;
	Thu,  3 Sep 2026 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442788;
	bh=FlQD7jpY0yqp3L5M/X4XIEPC3/D0cEsUOviNYlhSVCQ=;
	h=Subject:To:Cc:From:Date;
	b=eu+vJvkFgvDPVooiWo34kjQRLh8kRR9uD8k0JS8Q9TO39r6jstuibTCCQD8mb7Lne
	 mwNGhdNGjO/IEGyJ8Qjl0nDMLLu+scrinKFHTE7zibkjzcXe4Ap619pB55JwlVOcSk
	 yAraH8qnltnslVCEdbqGo9cD701jRYR1GoBvWXBw=
Subject: FAILED: patch "[PATCH] nfsd: fix clock domain mismatch in clients_still_reclaiming()" failed to apply to 6.1-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:13:15 +0200
Message-ID: <2026090315-napping-explicit-71f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 09ea3eb9a518565f5bca386e81b993ed8825f5e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090315-napping-explicit-71f2@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

