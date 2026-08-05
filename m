Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED5456290
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931227; cv=none; b=sxapUS0uhQCHdnnaJdnN6aG//kedjeiQpWmNDwn45/yn8ZDtSsTPYNxbe7TDjIbBiuLPZG9a3DiTPD6WCc0OeL4fHcMY3OKJ1aKSxy7xT/44CGc5Pc6hM1uIMVuaDadVeAFTAP1KY2I/oyndNV0iCE6UQyKXspkTMovrJ8Qnhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931227; c=relaxed/simple;
	bh=6UKNCHU4tPMt75P2yQcqKT3HwJUhxYWd50Flf+SSzcU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oU1Q6io4BiWfM7sWZvjTmHFUwGyMq9Wy7UYzC35ktS7KD8tLd9LXY2k6KfgDswC0VngEPSeYLfhs10KaKI6IAiCKmHqm+FQEW9rz5AgcSZH9B64Ut+aDn4WOSjo4OG9J4im22dYC41rvuSo5YrOkxpCCQ7T4duPKUrfA6W24znE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UBufAOyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UBufAOyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639551F000E9;
	Wed,  5 Aug 2026 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931224;
	bh=0fq5QyhEJyuMNJv8AVNi1haq2PhdhR9IOYtWwUFupXE=;
	h=Subject:To:Cc:From:Date;
	b=UBufAOyZXdEkzjQMLoF5v5tKSso1UVHDzElQ5yygGuWYnNvvP/Bk+iMj1kmvKrDfC
	 ODiiKS2jJk9tM8oKkkILe10yMp2JpbUQPmPdZR22DmuJiHQNhfyEScYvU60zaW2NGO
	 vzVOJP1lDjXAEKH+H+6rb+5RQ2xrXF4h9K+PhxIo=
Subject: FAILED: patch "[PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on" failed to apply to 5.10-stable tree
To: mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:53:59 +0200
Message-ID: <2026080559-remold-hacking-bd71@gregkh>
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
git cherry-pick -x 68c5724ecd159992f76edb7b57dc508a44c8b7da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080559-remold-hacking-bd71@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

