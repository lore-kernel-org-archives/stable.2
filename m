Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387F41A565
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529625; cv=none; b=F0a3wh22aFX8Gp1OilT256mzaOfTs48/YGUcAaN3kUAKBFNXeldfBN2Jbe2oB9D0vtkPDgafU+aF+8ynTzfSVncem9BAh1nU4KupgMBo5KdLrjMM49+Mg+KsR+DUOb4vW1Smz5ICw7i3fO0Vd66QbS3vHOC/xPS3GLUi4HOqjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529625; c=relaxed/simple;
	bh=aCr80JPV4BVi4qBJLvuc498LrC8G2gmCVR+7VJqKSxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3zTrA1S3fSoOQ2hKAT79MRaTNC1LirxnzWbBoeQLBpC3h18AemLz016LBY4XPgrwIDAcN0Ni6X5I/6kFbZj88Q+mP+mpyffEVT27NK/xHVZ3Sjxxd50kH3nyA+73sHfcJSU3Q/l7EV8+GP/omNXor1ejRgwRjwsG4vXy7DjLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A49TvI3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A49TvI3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800BE1F000E9;
	Wed, 12 Aug 2026 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786529624;
	bh=0F01RafzxDvEYuOs2tDXqRx2IwKQIEB8tMd8LgvO8Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A49TvI3lu/PbG1wwpHIsDL7DdNw17wsgmheauf9fxOZUQrSJqlbdnuK/eicO4wEQ0
	 AfdAkdN/A8j6G2iTqLxYEDT2idmFEEuSRuVV/9EOmy9Mgb7XkQY9WSxGRwn0dz8UVQ
	 hapzZas23XHA6jchA0cB3m23aZnh2KmJeui06+NUPwKMOcsdR51bGHmkr07YZlkL43
	 ePr4Q4olF4zh1FL+0STerRG8horlnmBt4tAMFIXSoacTlhZrc6oSTyguOHFRAv+pX1
	 HKq3DR8FdKRt4h2l8Zb+D0Vn78JQf7kMtUaM9NJ00ulwXbijhN1F1FATeYa23yGNfb
	 bBakFyumdIAEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure
Date: Wed, 12 Aug 2026 06:13:41 -0400
Message-ID: <20260812101341.1638381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080558-reassign-construct-c82a@gregkh>
References: <2026080558-reassign-construct-c82a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 68c5724ecd159992f76edb7b57dc508a44c8b7da ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 220496b76cd94..3ce8cf4ecb2e5 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -574,7 +574,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(dev->netdev, &cfd);
 			if (!skb)
-				return;
+				goto resubmit_urb;
 
 			cfd->can_id = le32_to_cpu(hf->can_id);
 			cfd->len = can_fd_dlc2len(hf->can_dlc);
@@ -587,7 +587,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		} else {
 			skb = alloc_can_skb(dev->netdev, &cf);
 			if (!skb)
-				return;
+				goto resubmit_urb;
 
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
-- 
2.53.0

