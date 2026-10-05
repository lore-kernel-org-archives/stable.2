Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829E37F322
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189738; cv=none; b=FTipLuzEtHYPG/wEa1Hbc4iVwJBnERnTBQWpN05i9UtdySyvznolUYu3m5VAdCFeXoP32BxZdB8O5xTWn5ceQlPhhL9nCOpREJm0eE53BlfSdLPmHTO9eRMSwqZFcTha/uBCdxBh0fioTpO9ywEpOJx37SlX0wrl+8VWCDtQwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189738; c=relaxed/simple;
	bh=4IIjXwyx6s5CM9QpDYi+2d7U9S2Qsn4At+4Mr9Lzzp0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZI+wY5Am1lZz9AyEgMabpOLeFJ73EsMR/11fP2cIMRFSkGyhHtzcsBTApfdu854wL3TfddZ7+oMLy+uUnZSrvsSoFaLVwmqul6PA5XqBp+gsYFvyTXbIBZLS9A3iXKNN5DffDNj/kjDMVpdX33uwtpOHxNmmZaPHOQBLGOSzB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zli0AwWJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zli0AwWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DDF1F000FF;
	Mon,  5 Oct 2026 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791189737;
	bh=Su3Ax1zWvvUk+GuTyWlwtq+fU9BX0an2M7JcdYPJW2I=;
	h=Subject:To:Cc:From:Date;
	b=Zli0AwWJqf1O6bxvU5LgfnOFwzcYgZBZcoeN1Px7YxYEtEVVyzOr3Q82ukiNgd4b8
	 oYBxJ/BrHd+Isg4QEUh574nO3tFGN06TM2t9p6Kgo3EES/s9YHsV2dEwM6AeOfcG40
	 sY+Bwj7rXhiqabC09/WwiF3iebaFqGlq8BDv/+yM=
Subject: FAILED: patch "[PATCH] usb: ohci-spear: disable controller wakeup on removal" failed to apply to 5.15-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:42:02 +0200
Message-ID: <2026100502-nanometer-helpless-c302@gregkh>
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
git cherry-pick -x b1b0f8bdbbc891a4ee7f3b1a878c633e02b7bbeb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100502-nanometer-helpless-c302@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1b0f8bdbbc891a4ee7f3b1a878c633e02b7bbeb Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 21:20:10 -0400
Subject: [PATCH] usb: ohci-spear: disable controller wakeup on removal

Probe enables controller wakeup after the OHCI core marks controllers with
RemoteWakeupConnected as wakeup-capable. Removal does not undo this, so the
wakeup source can remain attached after driver unbind.

Disable controller wakeup after removing the HCD.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: a6eeeb9f45b5 ("USB: Update USB default wakeup settings")
Cc: stable <stable@kernel.org>
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260915012011.61874-4-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 6843d7cb3f9f..5aeabb051265 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -103,6 +103,7 @@ static void spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);

