Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507F39F17F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089914; cv=none; b=j++T4xWVQORAkUQfs7w9bpkTpbxRxdOlroQCkoI9f6s1lVSH9+CkOkaPsX8ErIBuBKrmm8wgzkKmr2JOVdNvh8mEQH9UAVDK+Z9M9HC4sV897w6xlSlihoGTtIBtXNw749VTT6sir/YynQAd5q+OlZ+PvfHU4AHV+RqnUci5K2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089914; c=relaxed/simple;
	bh=UmjALKq6Aajvgu9ajF1tgu9AczKEOGpRGcMJYGelQbw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R77XkVhBfPBXnlPSCNIgR1thjLa/wURQwm6s+lGaLMZHwPY0X7TMtF2vtivC7DMqd15ughjW0saZOOn5osGYp44WbBKFp6GPKiSNZbS8YBUH283nRPfvCX9IVeUNr/F27XqiVw66rLKRlFWQpnGpLzN1bYx6hIkMJNrs9z+RIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1w0OAlMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1w0OAlMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE221F000FF;
	Tue, 22 Sep 2026 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089912;
	bh=5RCv7BMhV2byPr+q4W1yF5j9U134LIKSRXH91GzaeIs=;
	h=Subject:To:Cc:From:Date;
	b=1w0OAlMuavCRINGDAvgO8vJvCZwRBVnLujIx/1RYgDinlHXidnvmCKMauzav0mag3
	 MbEGFnD/78QoJnR224psFoXc3QkYuMSGonyo9asI4bV5UaScdw3cAEVmfKJJiv8C6M
	 kcBPSxA7dI6qhP4gzQj0/GuzdMk45zll8ewEJ4Mo=
Subject: FAILED: patch "[PATCH] wifi: wcn36xx: Fix potential use-after-free in TX ack timer" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,jeff.johnson@oss.qualcomm.com,loic.poulain@oss.qualcomm.com,songl@zju.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:59:00 +0200
Message-ID: <2026092200-humiliate-detract-e1be@gregkh>
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
git cherry-pick -x d9be5e75530772fc31637070d51e5717d6aeaa2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092200-humiliate-detract-e1be@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d9be5e75530772fc31637070d51e5717d6aeaa2a Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Thu, 10 Sep 2026 02:09:07 +0000
Subject: [PATCH] wifi: wcn36xx: Fix potential use-after-free in TX ack timer
 teardown

wcn36xx_dxe_deinit() tears down the TX ack timer with timer_delete(),
which only dequeues the timer and does not wait for a callback that is
already executing; the preceding free_irq() calls synchronize the
interrupt handlers only. The callback, wcn36xx_dxe_tx_timer(), can
therefore be running past the teardown and use the wcn freed along
with the ieee80211_hw in wcn36xx_remove(): it takes wcn->dxe_lock,
reads wcn->tx_ack_skb and passes wcn->hw to
ieee80211_tx_status_irqsafe().

Fix this by using timer_shutdown_sync(), which waits for a running
callback and also prevents the timer from being rearmed again. The
timer is set up again by wcn36xx_dxe_init() on the next start, so the
start/stop cycle is unaffected.

This issue was found by an in-house static analysis tool.

Fixes: fdf21cc37149 ("wcn36xx: Add TX ack support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Link: https://patch.msgid.link/20260910020907.3353-1-fanwu01@zju.edu.cn
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 44020ec265fb..801f1218ef89 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1055,7 +1055,7 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 
 	free_irq(wcn->tx_irq, wcn);
 	free_irq(wcn->rx_irq, wcn);
-	timer_delete(&wcn->tx_ack_timer);
+	timer_shutdown_sync(&wcn->tx_ack_timer);
 
 	if (wcn->tx_ack_skb) {
 		ieee80211_tx_status_irqsafe(wcn->hw, wcn->tx_ack_skb);

