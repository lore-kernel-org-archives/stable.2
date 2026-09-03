Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312484E80C3
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449937; cv=none; b=uXn+HgQtMb7jpM4kNprTiyWegNdQB2AS6E5PPAQG+iPd2shbSfRFYeSzQUIc3m3HGJEb3T73IS2H+fVqysoF+pNaIIUSR8vUrPRibHeIgVMtoBQvb4bzgA0/RZN8sbvUEY41UC1WfxQ8D0MhWgIzi0GGhA0o7tje2mYbWjr6/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449937; c=relaxed/simple;
	bh=n3ZlbsH7Hk496HKAugrOYH+9P1hXcmGoFBgV7pnKl8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GEe1dvAp8vLdJu3VLE6GV5SUDRnZlvwr5Drp2zB+PyVZV4+Kw5DFpmm72FWxCLToaioRf+GUvvV0dJW0DEZr5m9ED97RPYRJhkUb04PKuKgiQ3jX41A/fEovjghnzjuq9mxBW2dYGyNBSetQc3YIIHJuqYt8CmWpJOl39I0EzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KSoyQK/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KSoyQK/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C111F000E9;
	Thu,  3 Sep 2026 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449936;
	bh=WhCjVAtBVrQzD7ww2pw+eOVUIFaL0Iie9pVHsQEkb14=;
	h=Subject:To:Cc:From:Date;
	b=KSoyQK/qK0uPEdU3kDkeNBoczZofBM5tDaPraHqYv48QzJaoDY2I0ll4T5ZMPh5wl
	 Vje0EXq/bcFYNdqES4kJHyGklAfrWGNCI7llzngBrP8y46LJrFFvlzmj+nsjgxPRSj
	 3esWO8XTDFthSB7P9Tv1Q3OJzHmO5kaWrpdGq9YU=
Subject: FAILED: patch "[PATCH] net/smc: stop killed, freed and out_of_sync sharing a byte" failed to apply to 5.10-stable tree
To: hidayath@linux.ibm.com,horms@kernel.org,kuba@kernel.org,mjambigi@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:10:14 +0200
Message-ID: <2026090314-stumble-payback-2ef5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x db51a8658c11a82432b64999519a269c3aabb447
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090314-stumble-payback-2ef5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db51a8658c11a82432b64999519a269c3aabb447 Mon Sep 17 00:00:00 2001
From: Hidayath Khan <hidayath@linux.ibm.com>
Date: Thu, 20 Aug 2026 09:46:41 +0200
Subject: [PATCH] net/smc: stop killed, freed and out_of_sync sharing a byte

The three connection state flags are single-bit bitfields, so they occupy
one byte of struct smc_connection and every store to one is a
read-modify-write of the other two:

    u8  killed : 1;
    u8  freed : 1;
    u8  out_of_sync : 1;

They are not written under a common lock. smc_cdc_msg_validate() sets
out_of_sync from the receive tasklet, while smc_conn_kill() sets killed
from process context under lock_sock(), and the receive path does not defer
to the backlog when the socket is owned -- smc_cdc_msg_recv() takes only
bh_lock_sock().

Give each flag its own byte so a store no longer touches its neighbours.
All readers test them as booleans and are unchanged. struct smc_connection
grows by two bytes.

Fixes: b286a0651e44 ("net/smc: handle incoming CDC validation message")
Cc: stable@vger.kernel.org
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260820074642.966856-2-hidayath@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 52145df83f6e..427b6d63b993 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -277,9 +277,9 @@ struct smc_connection {
 						 * 0 for SMC-R, 32 for SMC-D
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
-	u8			killed : 1;	/* abnormal termination */
-	u8			freed : 1;	/* normal termination */
-	u8			out_of_sync : 1; /* out of sync with peer */
+	u8			killed;		/* abnormal termination */
+	u8			freed;		/* normal termination */
+	u8			out_of_sync;	/* out of sync with peer */
 };
 
 struct smc_sock {				/* smc sock container */

