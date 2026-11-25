Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608428;
	b=jD2tON3bHFGMwc+F7Na12ZEW6ZKb1OUyT1z6MPbWay5Z+d3YLwgwDT8BPJTPDE0fPq0p
	 MDS1zOiIkETwCCuZYVatLbssBqpb6G0er8InNIS+e409N6CC7BHFNG9TBjXcoeoZBQ9FE
	 lH1F0UVBigDlmywOlwW7bqTWsQSxz/vn1DTR5J18X3S6e0jiHZjkX+UZuutzqmMpBm4zC
	 03IxlY0sHuAT3UmdJWuB70C2xT53ElIjl4Z22qoRAm5TC1Md1wQuIT35Q+hEsPGGOEriC
	 7UAaIqiMpX9LUyC6xE6lhaD/QyhdSWxYnuiDps5B9NzrCMbRpMaezqIn3+qfdBNMVmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608428;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5TQyryhc80ZsmrNBe4vmqj+1AlmXV/srrsjIUot8MFg=;
	b=euCoZbUMqw6WiIJP1OvZ5nDrLwEmzjVMif8sMC5yswbezvVYxR1QomymkTl4PWCoqLCY
	 u1d1yTQxwAn3g4vsRxGrogaFOwGXa7onMKOHTPeJnA1xmS+OwR86Wf3JSuUSCS0Zh+953
	 Xd81IEMbn5tCm1ewN/IH5bp2jtLFbnIdiWVDx0nW9NFr5L+2WxTS3CAqqcrqn9N8NVNEx
	 EcVosTHg139keSycrcJJNpFZ70vFj16DsndqWX1mhyeI5GRTslgtzaz+JQ7Mi2JR4L6qU
	 ejPFr3Uh9T4jiMZFN2DQyKZZkeWfUddLVvA1Tv37asGJyR5teg+n6Og+SLTcm3qOPQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WMz6Olf4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF88606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WMz6Olf4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE6F1F000C4;
	Wed, 25 Nov 2026 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608428;
	bh=5TQyryhc80ZsmrNBe4vmqj+1AlmXV/srrsjIUot8MFg=;
	h=Subject:To:Cc:From:Date;
	b=WMz6Olf48Ot1IMQkHFalA3wzRyLS11Btvqh14mEvCsydd2//0HOGRFZ6TdI5aMGB6
	 baXCCC4kiYAazeeX7BkHExjVvinr/0Gaz3Ic0+iX/5mAmpMY3xFe9ilvNYxQtPZFUv
	 j23F6a4DozBfMM7fOAeLx3GpxnRRQXKsym5ypjYQ=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Track a timed out End Transfer" failed to apply to 5.15-stable tree
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,selvarasu.g@samsung.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:41:21 +0100
Message-ID: <2026112521-swinging-willed-f488@gregkh>
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
git cherry-pick -x af91c6322e633504aa45de278f5d520f39d127be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112521-swinging-willed-f488@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af91c6322e633504aa45de278f5d520f39d127be Mon Sep 17 00:00:00 2001
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Wed, 21 Oct 2026 00:37:56 +0000
Subject: [PATCH] usb: dwc3: gadget: Track a timed out End Transfer

If an End Transfer command with CMDIOC times out, the driver clears the
resource index but keeps DWC3_EP_TRANSFER_STARTED without setting
DWC3_EP_END_TRANSFER_PENDING. The command is still outstanding, but a
later stop issues another End Transfer with resource index 0, and the
next Start Transfer fails with "No Resource".

Mark the timed out End Transfer as pending so that no other command is
issued to the endpoint until it completes. For any other failure, there
is no outstanding command, so clear DWC3_EP_TRANSFER_STARTED.

Fixes: e192cc7b5239 ("usb: dwc3: gadget: move cmd_endtransfer to extra function")
Cc: stable <stable@kernel.org>
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/5815c41a7e7923edb114741f29697cf0161f523c.1792542945.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index eb6666b7bb98..df5407e75788 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1798,9 +1798,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 
 	dep->resource_index = 0;
 
-	if (!interrupt)
+	if (!interrupt || (ret && ret != -ETIMEDOUT))
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else if (!ret)
+	else
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;

