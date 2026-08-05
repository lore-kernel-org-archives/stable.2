Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA5456E0E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931229; cv=none; b=NIWHcCHMpvOgKP9b3ra9XtvRgLFDBUhZbq/0xIO8nRrHAoxdJ9WHQNtikfpVUYi2AvRWz4E9EkfN6yqmuPbJ0A4sj2eTrWkGGT8i29tO0PG6nfQHNv1j/W/GOXbydRM6mTxMSfdakwfeOF5ZXDkP7OUchZ4v725/QQ/gQNS+6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931229; c=relaxed/simple;
	bh=YVb4Vy2cSTeAusptuHzyAgvUEy8SUhEucJ82AKaARKo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lx8OG2F5pckJXn0RDgGiCutlPBvSM+SMR2O7ZBQIfEpGygMz1MSA1lpAKCkzqz8KfrYJ8AjqzWUZwVNGH0BhcDEpHs8rPa6KKcfHJ6KYqIOod2VJcg6g3Vx0041IWHcPdBhfJg1HeKGMGheEZHXrtQCoLxL9cszdUOSFu3XEXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XO2rUjuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XO2rUjuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8FA1F00A3A;
	Wed,  5 Aug 2026 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931227;
	bh=kYsnEN4fsYMqe8GJtyCop7gKWTEhh2E0T/YgbQeL2Ks=;
	h=Subject:To:Cc:From:Date;
	b=XO2rUjuypD8niFgBCIsdR0kfEX8DTJe17cSGucGLVgAFp98GOkTLG+6boGbheaM4G
	 8fKNq/qf7C6+Yk7svm78aP+8o/zNp2XREthDDLZZhGpM5OSHBpKX2waMy62qaDU1ia
	 w7CVdS1SCuNffTIIbWKtA8vyMEnK3DOz710HH4U4=
Subject: FAILED: patch "[PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on" failed to apply to 5.15-stable tree
To: mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:53:59 +0200
Message-ID: <2026080559-surround-premium-b764@gregkh>
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
git cherry-pick -x 68c5724ecd159992f76edb7b57dc508a44c8b7da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080559-surround-premium-b764@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68c5724ecd159992f76edb7b57dc508a44c8b7da Mon Sep 17 00:00:00 2001
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 9 Jul 2026 09:54:26 +0200
Subject: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on
 skb allocation failure

If the allocation of the SKB in gs_usb_receive_bulk_callback() fails, the
driver returns from the callback without resubmitting the URB in order to
receive further USB in URBs.

This results in a silent performance degradation which, if it occurs
repeatedly, results in starvation of USB in traffic.

Instead of returning immediately, try to resend the URB. If this also
fails, this is logged as an info message.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Fixes: 26949ac935e3 ("can: gs_usb: add CAN-FD support")
Link: https://patch.msgid.link/20260709-gs_usb-resubmit-urb-v1-1-4dd40030cc84@pengutronix.de
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ec9a7cbbbc69..82508a865095 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -674,7 +674,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
 			if (!skb)
-				return;
+				goto resubmit_urb;
 
 			cfd->can_id = le32_to_cpu(hf->can_id);
 			cfd->len = data_length;
@@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		} else {
 			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
-				return;
+				goto resubmit_urb;
 
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);

