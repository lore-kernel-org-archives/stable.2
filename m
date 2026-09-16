Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4804B8276
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577011; cv=none; b=S3myAnxwVxCRRIwBxUTdB7zWp5dXiel4n09Qi0yUErWIqsguz7oVGncrpuV/L4g+NQWeUC1cVqjj4QIi3NBbuhMWJclpSsSPEx9xp9YJt5rNCFnGEc/kRCWaHgmqs5K+G9h3fxbnbeyNaAxs2WoLDzbJIVcwx+BRFtIAMOWgNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577011; c=relaxed/simple;
	bh=ampMnSqZ8WPNM6QA6JZizsDVCrxWuXYJbd9yNgXh5pw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VAFGr6XFsxwwHGHUrM07qYF0RwsPlDK8m2zEgmPMQxwjf5wZnqUDB4AZqS1htcF4Ybl8QEFDljSjuCu+rlkkZp4nlTH7cU0RRUiPPOIgPYjFyAZt0zB8itbUjYXCRlMxhcylv4qOM/PJ+Yapf1jKUSfDOgchEn+GyQDcrCjHgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TkOr6Bfv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TkOr6Bfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3691F00898;
	Wed, 16 Sep 2026 16:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576975;
	bh=ZT8G9my0f0HIw8q54/2eYzK5utvoxhgZMQRnJeNcKSg=;
	h=Subject:To:Cc:From:Date;
	b=TkOr6BfvgOv4t6ddhzj1bofpE6zZADe06N93pqzUzv5UYtwlEpnLd1ZB2hqNYCjDe
	 lNDthyUoKa4RBgWS/3W2xJnkt8Y3igNNjIeHBtdSXdoUwxH2xGD0VO0fdn01pq5fHv
	 gnJ+9TAcLMJb6Y7sRrSsRSSs9g29oJK+z2Vvnt2A=
Subject: FAILED: patch "[PATCH] bnxt_en: Handle buffer allocation failure in" failed to apply to 6.18-stable tree
To: joe@dama.to,pabeni@redhat.com,sashiko-bot+sashiko@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:37:48 +0100
Message-ID: <2026091648-flakily-icing-f492@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 961e2a17c5e3559b3f8654d2daabdd25a42e770a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091648-flakily-icing-f492@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 961e2a17c5e3559b3f8654d2daabdd25a42e770a Mon Sep 17 00:00:00 2001
From: Joe Damato <joe@dama.to>
Date: Tue, 1 Sep 2026 18:56:47 -0700
Subject: [PATCH] bnxt_en: Handle buffer allocation failure in
 bnxt_rx_ring_reset()

bnxt_rx_ring_reset() frees the ring buffers and then reallocates them,
ignoring the result.

bnxt_alloc_one_rx_ring() can fail in bnxt_alloc_one_tpa_info_data(), which
returns -ENOMEM on the first failed allocation and leaves the remaining
rxr->rx_tpa[] entries zeroed.

The error isn't propagated up, so the loop in bnxt_rx_ring_reset
continues and at the end the code re-enables TPA with partially
unallocated rx_tpa array.

This means that when the agg_id from hardware is mapped to a SW index in
rxr->rx_tpa[], an uninitialized slot can be chosen which would hand a
zero DMA address to the device.

Fix this by falling back to a global reset, which is what the existing
code already does when other functions fail, but unlike the other
failure cases this particular failure has to return because TPA can't
be re-enabled since the allocation failed.

Fixes: 8fbf58e17dce ("bnxt_en: Implement RX ring reset in response to buffer errors.")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260902015652.2421609-5-joe@dama.to
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ae7150c7de1f..a2283fd9cdfc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14628,7 +14628,14 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 		rxr->rx_sw_agg_prod = 0;
 		rxr->rx_next_cons = 0;
 		rxr->bnapi->in_reset = false;
-		bnxt_alloc_one_rx_ring(bp, i);
+		rc = bnxt_alloc_one_rx_ring(bp, i);
+		if (rc) {
+			netdev_warn(bp->dev, "RX ring reset failed to allocate buffers, rc = %d, falling back to global reset\n",
+				    rc);
+			bnxt_reset_task(bp, true);
+			bnxt_rtnl_unlock_sp(bp);
+			return;
+		}
 		cpr = &rxr->bnapi->cp_ring;
 		cpr->sw_stats->rx.rx_resets++;
 		if (bp->flags & BNXT_FLAG_AGG_RINGS)

