Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ADC4E56F1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449923; cv=none; b=fKGxzDKoAr1YWD854xuHvEtXgVom8YhWjyMkk93Ny5QDLrVzHx9xghwPdAYBBPc8Yl2dRpDLadsbSfZX8geXQFsdwJgqytWllKHf1yWg9OiVdyU3SH/YcSxmyNP0L3UrcOpfyWlpoHZfXobqYpAdEB7wyzA6Jfv7ACs/sreTmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449923; c=relaxed/simple;
	bh=sIeGSBWfyVWiiGYPZaGXsbBafZqKWS8/h8tcUfsxM08=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DZWCOl7butIZhCj1ex/r9lquS1ymN6mS9WywHH2NkMGPk0Io1Qu1/9AHcNQkhyydvIjksPjoZPmSWUzZZojde01O2Fv+7rWpOlrKJu4erYMlGxeCWe9GzjQZG6tE/6IbACuOxE+L+wKfoBt+vJH0MXLFRhPTRfNR4KXPkQ5JQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LnZ3WBUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LnZ3WBUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2431F00A3A;
	Thu,  3 Sep 2026 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449921;
	bh=ROaqAiXndar9UyKq3GViLdYveFe5yG6WeCpokyy7Yco=;
	h=Subject:To:Cc:From:Date;
	b=LnZ3WBUTlp3dso5cEQDtwv/C2C+vqxEEiKdw51vtd244m23DpqUI3NYREejf0ItJS
	 jaD0FnKehJyxjyCYkoTHZU+rkBbmWEFMubnz/HyVmUFiikNKo7w7qU79J6OaaCxudV
	 qYKuHZsvJ4rcjRMIBRM9wig1m4YAZ7n77px7MFbI=
Subject: FAILED: patch "[PATCH] net/smc: fix socket refcount leak in smc_switch_conns()" failed to apply to 5.10-stable tree
To: hidayath@linux.ibm.com,kuba@kernel.org,leitao@debian.org,mjambigi@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:09:44 +0200
Message-ID: <2026090344-afraid-primarily-b3a0@gregkh>
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
git cherry-pick -x 719296c4aa8213d4ac8002e77d5956d436bc98d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090344-afraid-primarily-b3a0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 719296c4aa8213d4ac8002e77d5956d436bc98d0 Mon Sep 17 00:00:00 2001
From: Hidayath Khan <hidayath@linux.ibm.com>
Date: Thu, 20 Aug 2026 16:47:29 +0200
Subject: [PATCH] net/smc: fix socket refcount leak in smc_switch_conns()

smc_switch_conns() takes a reference on the SMC socket before dropping
lgr->conns_lock, so the connection stays alive while the CDC slot is
fetched:

        sock_hold(&smc->sk);
        read_unlock_bh(&lgr->conns_lock);
        /* pre-fetch buffer outside of send_lock, might sleep */
        rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
        if (rc)
                goto err_out;

The err_out label only drops the wr_tx link reference, so this early exit
returns without the matching sock_put(). The second error exit is not
affected, because sock_put() has already run by then.

A leaked sk_refcnt means the smc_sock is never destroyed. Its send and
receive buffers stay allocated, and for a user socket the reference held
on the network namespace is never released, so the netns can no longer be
torn down.

smc_cdc_get_free_slot() fails when the target link goes down or when the
connection has been killed while the switch is in progress. Both are
reachable during the link failover this function implements, so the leak
is triggered by the same hardware events that make smc_switch_conns() run
in the first place.

Restructure so there is a single sock_put() covering both outcomes,
instead of adding a second one to the error path.

Fixes: 95f7f3e7dc6b ("net/smc: improved fix wait on already cleared link")
Cc: stable@vger.kernel.org
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Link: https://patch.msgid.link/20260820144729.1019399-1-hidayath@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 181647982490..04aedd957543 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1148,13 +1148,13 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 		read_unlock_bh(&lgr->conns_lock);
 		/* pre-fetch buffer outside of send_lock, might sleep */
 		rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
-		if (rc)
-			goto err_out;
-		/* avoid race with smcr_tx_sndbuf_nonempty() */
-		spin_lock_bh(&conn->send_lock);
-		smc_switch_link_and_count(conn, to_lnk);
-		rc = smc_switch_cursor(smc, pend, wr_buf);
-		spin_unlock_bh(&conn->send_lock);
+		if (!rc) {
+			/* avoid race with smcr_tx_sndbuf_nonempty() */
+			spin_lock_bh(&conn->send_lock);
+			smc_switch_link_and_count(conn, to_lnk);
+			rc = smc_switch_cursor(smc, pend, wr_buf);
+			spin_unlock_bh(&conn->send_lock);
+		}
 		sock_put(&smc->sk);
 		if (rc)
 			goto err_out;

