Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6D3F1678
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158954; cv=none; b=Yo6uAABPV9Iflr82q6ZAOQcRWxFKThKdT4hebKbNo9AQGe4nmz7c6l+XjoKqNEgnP8AoxbWvEK+EzD3Jf1d6ZWGp9V41RpEaXXvod5LHR0ecyi05oG8bN1+se2co5q1TCjKNYbk4kD1wvnaM+Ltmaaskk//INIMI8caan2p5MyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158954; c=relaxed/simple;
	bh=02HgGruZsGhPnTc4gkXENcYoc/HJtbmzbpFHT9nRaPE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QPRP5nQFggm6+GFjvL1tE2okF5qJ6O+/DBkVGsJ2KwNoKRRU86y7tqE1/atiql8bx2QeonoSerdnNvJoB0VoeXlRmhE16cAwlQWrExhT5Pz2RfbdrhUcRxTBgQMmwL0rzC9SUqafLPzCKPYWiYqe8+GPeYdgljIlDkdIOUEX23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CoM6Qn8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CoM6Qn8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01D71F000E9;
	Mon, 27 Jul 2026 13:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785158953;
	bh=5LjWnN8ts5qLnMQ2ReycDf3PpnimfrDzvGr0VCe2Eno=;
	h=Subject:To:Cc:From:Date;
	b=CoM6Qn8R6tgfGlI7NhTokbuf225sUwFxWUifsWW/CYatBmVUVR+TeU/3Bpu2Yy6jU
	 z7zCjXMMCFQalAGg8l/HVeEe74q3ILvwYKGGqYJmNjg0X2h7k8GYk2FBTeonD5Mx1e
	 Ga/pumY+b+y2rZmDnWO8m45gUu3jQS79kJSSIjHc=
Subject: FAILED: patch "[PATCH] usb: musb: omap2430: Do not put borrowed of_node in probe" failed to apply to 6.1-stable tree
To: lgs201920130244@gmail.com,gregkh@linuxfoundation.org,johan@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Jul 2026 15:28:53 +0200
Message-ID: <2026072753-efficient-culpable-80d7@gregkh>
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
git cherry-pick -x c947360ae63eee1c9eacc030dd6f5a53f717addf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072753-efficient-culpable-80d7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c947360ae63eee1c9eacc030dd6f5a53f717addf Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Jul 2026 19:47:11 +0800
Subject: [PATCH] usb: musb: omap2430: Do not put borrowed of_node in probe

omap2430_probe() stores pdev->dev.of_node in a local np variable. This is
a borrowed pointer and the probe function does not take a reference to
it.

The success and error paths nevertheless call of_node_put(np). This drops
a reference that is owned by the platform device, and can leave
pdev->dev.of_node with an unbalanced reference count.

Do not put the borrowed platform device node from omap2430_probe().
References taken for the child MUSB device are handled by the device core,
and the ctrl-module phandle reference is still released separately.

Fixes: ffbe2feac59b ("usb: musb: omap2430: Fix probe regression for missing resources")
Cc: stable <stable@kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260713114711.955253-1-lgs201920130244@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 333ab79f0ca9..6e749faac33c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -454,7 +454,6 @@ static int omap2430_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err_disable_rpm;
 	}
-	of_node_put(np);
 
 	return 0;
 
@@ -464,7 +463,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 err_put_musb:
-	of_node_put(np);
 	platform_device_put(musb);
 
 	return ret;

