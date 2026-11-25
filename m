Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608422;
	b=saQyDpbaaWQM8kz9vFY1jFlsjCzo6WPFmOPMee/f3OseDmijHItrHb9TmTcAnbMtsDyc
	 ZG+YK2oI10RePmbW1MovuuAP3V5u7SfhOk5orI3tqOgYooU9p7oWIzl5fz3rX/3kI7Iep
	 NqPD+2LROUexfDTA/PdfYrJzx938+MY7xissliDvvdIdkkbZbt43fRTbpASmwziAhCfig
	 AASyGvt9iaV2Ucpf+JNiwsraBaOzF7b9bHIV1hp/gSM9ZDMxEI9qaZElEiZjlfUaT5Yb5
	 UNoTS9wGWcMXPJaJvu3JYUgpzHOi8UXHgTuwwNGtVU5Spd3zFYwffFSUWKpke9Mu1Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608422;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hrIQGqcgh/3Dg/OrYxfyqk/BHXucyG9YWfp0RmbXfPQ=;
	b=To7ibQoFsxQlbHHtZvLZvkkmhk2UGeT2tgtt7hvuSWfbUgLfmnUVPNrkcimqLRMm6XLg
	 kZ7aaCO3fvLimwfLKLNhKhlrd+NibeLpwgCGay8FsgUTbdA/4OeMgcrQzytD3alo6815h
	 mgfFb1EMcCgok0NOOi0d8g2o56X9ZgSAw6fpg390piiAK01t2miJyNJdOOipVYDO/HG21
	 zZKSAYzMII08YFk1yV5m7bYdvs/u2L9dxrhTLs7oFD4LacQ+kvBzH06LqTrOr+yzOeBAC
	 az7+teRk8y36zovQp2MtyCHG2ea+LNWEpio82AiitYxapJ7DUzv21E0jZz8ibnU6lrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mD8HZpXv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782D606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mD8HZpXv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8631F000C0;
	Wed, 25 Nov 2026 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608422;
	bh=hrIQGqcgh/3Dg/OrYxfyqk/BHXucyG9YWfp0RmbXfPQ=;
	h=Subject:To:Cc:From:Date;
	b=mD8HZpXvAK6X4MWgEW82iosA7rvWGqxhTDvAho/lzjXyzNdaWJKqpoLOHuNR2k2TF
	 IEuK80/ZRsZs1ADG3hJkyWLIEgepfzASp68dTfh3zLYtuxVkc9epTQQhInn3qATaHG
	 cOnTZ7x2zVvSs61p7PdszaTGmsP/lefmoImH1HoE=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Reject requests to a disabled endpoint" failed to apply to 5.15-stable tree
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:41:00 +0100
Message-ID: <2026112500-lying-blot-de47@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 5eb11b1647b0534b3a61a21473d77ebf4ffbed7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112500-lying-blot-de47@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5eb11b1647b0534b3a61a21473d77ebf4ffbed7c Mon Sep 17 00:00:00 2001
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Wed, 21 Oct 2026 00:37:51 +0000
Subject: [PATCH] usb: dwc3: gadget: Reject requests to a disabled endpoint

__dwc3_gadget_ep_disable() releases the lock while giving back requests,
and DWC3_EP_ENABLED is only cleared afterward. A function driver can
queue a new request in this window, and the driver would start a
transfer on an endpoint that is already disabled in hardware.

Clear DWC3_EP_ENABLED before giving back the requests, and reject
requests queued to an endpoint that is not enabled.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/4ceab6aa5d6af0e4780f9d3a964fd5d8168a0a02.1792542945.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ee837235630a..eb6666b7bb98 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1084,6 +1084,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	reg &= ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc, DWC3_DALEPENA, reg);
 
+	dep->flags &= ~DWC3_EP_ENABLED;
+
 	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
 
 	dep->stream_capable = false;
@@ -1990,7 +1992,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
 
-	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
+	if (!(dep->flags & DWC3_EP_ENABLED) || !dep->endpoint.desc ||
+	    !dwc->pullups_connected || !dwc->connected) {
 		dev_dbg(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		return -ESHUTDOWN;

