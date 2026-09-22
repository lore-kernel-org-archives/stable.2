Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD912519DF0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089903; cv=none; b=rHNqJhULHYgpwLPyczKK+Szi39N26BP0SkD+XhUvLmCc/GE4/X44sRiCyY8ghvHWCHyJAxTRp6IhKivAHD/982aC2MP6i9vwox8xLjKdIEIYXjn7KYu7C5GVBUna5WFjh2MSi/mJqFWHNN40e5q1iLtI33QKadlWuNgJLU8J5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089903; c=relaxed/simple;
	bh=Dtr2Jt1CLg9Mjy4Ja64Ul3YqD5Xd6F58/tE5R++s4GA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dY31dq7wV9VbOedEmdhY35n4Eegg1FG2kwAl/Soh5fDK8xkWL3X1x33F5BCSYE11K1Iad5C6FxfqcdpAGwVgOr6lNXwC71/zbFf0CntSbYFcktOIZJ2RlkviMfxd7mvqY9AI58vTFaUlZSJeJ6ZYJV6p5joyJ5Te0SBUc99gcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwzBvXF0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwzBvXF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55D61F000FF;
	Tue, 22 Sep 2026 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089901;
	bh=W0vUI/Ykf0Ac4hLh2Gs1yEmZd5j8/vovRTgIS8WucNU=;
	h=Subject:To:Cc:From:Date;
	b=IwzBvXF0ddOL7+yNC4sJAsokHY47Gmlm5wz8aWQrANQiWyI/EL1MZD3VTvyB/GNF+
	 IostIOt20Hl5gmt5t+wNlv+cDwv3kvMCGmOM4GkGYRQIRPw9zn0jawI7br9d4mVFoD
	 /TBTHOkBjv/+drCBn0b8K3Tuj3sQ9GthPoRKQhNw=
Subject: FAILED: patch "[PATCH] wifi: wcn36xx: Fix potential use-after-free in TX ack timer" failed to apply to 6.6-stable tree
To: fanwu01@zju.edu.cn,jeff.johnson@oss.qualcomm.com,loic.poulain@oss.qualcomm.com,songl@zju.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:58:57 +0200
Message-ID: <2026092257-dyslexic-stinging-ab11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d9be5e75530772fc31637070d51e5717d6aeaa2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092257-dyslexic-stinging-ab11@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

