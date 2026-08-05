Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34915453A43
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931223; cv=none; b=oaykcQSxR26d1y4kHoE9pwO0gKK3iVqZkeu+mCGO3QM2KRF5FVuhl0s7Mi3z9pSdCF+z9Myz0ITTInZ22aS/UIlYHbqiLK06gDZzxzzI/NXkJ5cqhv0eAmwsF2OZXIju8e4FJaml2ThfS5C/U0gZ/Ny8XAzOZafZd09vXRn6mO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931223; c=relaxed/simple;
	bh=rc76EBsAV9IOKU2A1zaa6M1kh6doHENR4n48bLMiwEE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pVJkxvYt6U/JZb5paJGucZ0W0qGUd930ny3eB1jNzjw1gOZ5pqUVr25qfCo/MqQRWKXs/vwIYE9V5IcqKvrr2VsjUUBn5o94FF//eh+t/TxdcJpN0QwoKyNALP65XcN1yRtJ4awhN5Eu2aC0R9OZsBfx/VZlWWZ3JgiHYQsKMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6LtPhEm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6LtPhEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6601F00A3D;
	Wed,  5 Aug 2026 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931222;
	bh=4y6qnmNyivjzNlyMmyZicka3Y0OIDvrJfc+ivp03CaA=;
	h=Subject:To:Cc:From:Date;
	b=Y6LtPhEmx8KZgAA3zP70Dpwev0ToyOgj0bgANNpe8ygF6DObE8rpsByCO/rCKX+hU
	 SWOwXVG9I4EKoGxYB9m+2gRr+iydpZCo19UU7weSHGp93/8ahTiqpkme/ENFIjQtG2
	 fxYkgG9FMZGJ0iwLw1eI+AQajy9CWnUE++4Oso3s=
Subject: FAILED: patch "[PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on" failed to apply to 6.1-stable tree
To: mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:53:58 +0200
Message-ID: <2026080558-reassign-construct-c82a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 68c5724ecd159992f76edb7b57dc508a44c8b7da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080558-reassign-construct-c82a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

