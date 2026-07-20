Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A2435508
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560304; cv=none; b=YgNRD1TS9K8HQccMXSKgcbiCUyrl2CK3h91x2gvwfC/HzikqyHl1bDzEADJ7+uuNPXqiF6Th9svPWkZaKwMoWFDIqt3Qgfahm5Jk5yGupsU8KWbUnXrhPgyz2LAzaFTf4XqK9bapdBkMNhtWxToQNJQF1Ez7zK3ffqCbRX2tEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560304; c=relaxed/simple;
	bh=ikFcyJqc+lQih4tzngYGsBQ3ltYRkJvoNs/NpXT48us=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ipQDg27F+nGIeKakyDySoyxjIJgoSP35q2MeSTTEoa3fBixG1VnIzI0wbiZPXSLj2Kr9Hni1ADYy0fOjlQBH9Gd6Tq7ghIxyd35wu6/GR9rONUZFzZ2Fjw7EScAtAdg7l59ViN173R+Kayfs5XRQ9TpYrNEinhOB7GCRViS+km4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewsAlx6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewsAlx6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00F91F00A3A;
	Mon, 20 Jul 2026 15:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560298;
	bh=EICmvQ3ZC4LfQpnI2KVQjb1TJVjn6amCoNRkhCnxk9g=;
	h=Subject:To:Cc:From:Date;
	b=ewsAlx6aTRf4uME9uoNbbqa0K2OSqVjCk1Bg6LCjzvkyT59BSbY4Vr0QGL4hB5/Sd
	 jUUi4/Bh6O4VPxLDb8S6qCJaYa/2j7yUDdiwqeADWK3iqjlvqwMEnPQnP8TNohCFcx
	 nVfO5iGXvzgIeHwXjXuOaQXwFDf1UEVGKznVQZgU=
Subject: FAILED: patch "[PATCH] can: esd_usb: kill anchored URBs before freeing netdevs" failed to apply to 5.15-stable tree
To: fanwu01@zju.edu.cn,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:11:29 +0200
Message-ID: <2026072029-exit-twerp-6461@gregkh>
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
git cherry-pick -x c43122fef328a70045fe7621c06de6b2b8e19264
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072029-exit-twerp-6461@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c43122fef328a70045fe7621c06de6b2b8e19264 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Thu, 9 Jul 2026 16:41:59 +0000
Subject: [PATCH] can: esd_usb: kill anchored URBs before freeing netdevs

esd_usb_disconnect() frees each CAN netdev with free_candev() inside
its per-netdev loop and only calls unlink_all_urbs(dev) afterwards.
The per-netdev private data (struct esd_usb_net_priv) is embedded in
the net_device allocation returned by alloc_candev(), so once
free_candev() has run, dev->nets[i] points to freed memory.
unlink_all_urbs() then dereferences the freed dev->nets[i] to kill the
per-netdev TX anchor (usb_kill_anchored_urbs(&priv->tx_submitted)),
clear active_tx_jobs, and reset priv->tx_contexts[].

Reorder the teardown so the anchored URBs are killed before the netdevs
are freed, matching other CAN/USB drivers in the same directory such as
ems_usb, usb_8dev and mcba_usb, which unregister, then unlink, then
free: unregister the netdevs first (which stops their TX queues), call
unlink_all_urbs(dev) once, then free the netdevs.

This issue was found by an in-house static analysis tool.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260709164159.497640-1-fanwu01@zju.edu.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index d257440fa01f..f41d4a0d140f 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1390,10 +1390,13 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 				netdev = dev->nets[i]->netdev;
 				netdev_info(netdev, "unregister\n");
 				unregister_netdev(netdev);
-				free_candev(netdev);
 			}
 		}
 		unlink_all_urbs(dev);
+		for (i = 0; i < dev->net_count; i++) {
+			if (dev->nets[i])
+				free_candev(dev->nets[i]->netdev);
+		}
 		kfree(dev);
 	}
 }

