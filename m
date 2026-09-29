Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669754E3227
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674743; cv=none; b=scpScrHrYmvTXvbFc43mA6mMZZHTkCOclZ3mbCaYW2pbdnmH6uow26K+2rXP7y7Qq9K89ynigEIx8/aZDGd4AVzXPghWgf5kRSWOL1ee8dPKZt5ppP3Uj9LjSH9dNU+izCfLzdS/CsKr1XnePiythhuMDfAjQcWasX5z36BNUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674743; c=relaxed/simple;
	bh=+1VRioKkfXmhNru45Yokjncjf7yCRNsK+1jrYMyjn+Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tn9TRe2GmSaJaKBJWbTSePfYOS3d/D2unRXUOtOR+LgiCN1tGRatuaFt6xjBTUEd3sy1Hx5Q6mVW9nnprWkY/EepxJuaam6BChAQ8MQkMxMsgcG5ui8vb1+r+D4G5z3xAPtmlZybjQCiZweLiZWK1UCJOPOSKoPsabWZe8AKkVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1tDsTcD+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1tDsTcD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C081F000FF;
	Tue, 29 Sep 2026 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674742;
	bh=0vuZygG2T7x7usGcTa71DuhMZP5VdZmiX8i7citZbns=;
	h=Subject:To:Cc:From:Date;
	b=1tDsTcD+/M3M63xTJkkrcUD6ckH96Q5MGxmP3Li+9218hZHCMt1eQyBlwPVPEllGv
	 rQZsQOqHtX5t473FEHhopzDWFrgLJJOZ2eKdoUzmPwWN+fbs1gpcIT3iSJaO82MIb+
	 Wpp9kd9Km2RyhuJCyxa3eP/koj/QbxwdwLzXaqws=
Subject: FAILED: patch "[PATCH] net: usb: lan78xx: Fix URB reference leak in" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:38:56 +0200
Message-ID: <2026092956-thong-fritter-acd0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 17741334d00bf5ebd37f8c1c36bc9c146a351deb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092956-thong-fritter-acd0@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17741334d00bf5ebd37f8c1c36bc9c146a351deb Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 11:58:11 +0000
Subject: [PATCH] net: usb: lan78xx: Fix URB reference leak in
 lan78xx_submit_deferred_urbs()

usb_get_from_anchor() hands over a reference to the URB, which the caller
must release. lan78xx_submit_deferred_urbs() never does, so every deferred
Tx URB keeps an extra reference: the counter grows on each suspend/resume
cycle and the URBs are never freed when the buffers are released. Drop
the reference after submitting, and on the path that drops the packet
instead of submitting it.

Fixes: 5f4cc6e25148 ("lan78xx: Fix race conditions in suspend/resume handling")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917115811.2150119-1-vulab@iscas.ac.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index cb782d81d84f..5655941f1478 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -5239,10 +5239,12 @@ static bool lan78xx_submit_deferred_urbs(struct lan78xx_net *dev)
 		    !netif_carrier_ok(dev->net) ||
 		    pipe_halted) {
 			lan78xx_release_tx_buf(dev, skb);
+			usb_put_urb(urb);
 			continue;
 		}
 
 		ret = usb_submit_urb(urb, GFP_ATOMIC);
+		usb_put_urb(urb);
 
 		if (ret == 0) {
 			netif_trans_update(dev->net);

