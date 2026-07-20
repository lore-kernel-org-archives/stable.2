Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC7043553D
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560308; cv=none; b=GLl9b9upgEkkXjZbPMEoULtAZZQRMIGlT9lfzQcjiItPASJ8NUCZtWhfULYNUBumS6j3bwNDW7GMK5YHv/sm7FA5T4/4+ZuidpYhfX49RGHAF+HTYSbD4aZPYoaES4WehE44yEim1+s1IJbuduOJV0ZQX+MRgcOiP9bvBVPWEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560308; c=relaxed/simple;
	bh=bnJrL5JDeRPbaWPD9m1HDKnVRzPhA4AsS7LbWBmI2Qs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gEpuig8kpqv75W0vIIXv5thNjJVTLMoPfTWefR00LnHZqJTFGWdPfEGe0MknAZ9vSxGQLDXG2UDHToNUTunhJYOvii4gvIlFn05UNEa1pwFMcEEPFHY8kmxVBG7fbaGuZpF+AH0zfVcnCK5OngpLEjfZH0n/YjEfmKTtgNdFg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwbH0ys/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwbH0ys/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8211F000E9;
	Mon, 20 Jul 2026 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560306;
	bh=GeSq8hL8EDeSaKVakAPeAnrRooaCXR3RujqKg28IPZo=;
	h=Subject:To:Cc:From:Date;
	b=EwbH0ys/x1FWHA9WtwiEwOw/K1ZejY9/YFHMNRTaZM3AdOCsLyxdgOfWUrGQoENQS
	 D7S0XyWuRDyXty0QetoVasRtjwsUlockPZuNiQaxGAj59EG6sItM9mLLZgqKkpn2sN
	 XcSTxCbQnICg5F8FJI7p18zWilDghXL5Neys5/pI=
Subject: FAILED: patch "[PATCH] can: esd_usb: kill anchored URBs before freeing netdevs" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:11:29 +0200
Message-ID: <2026072029-familiar-passage-6884@gregkh>
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
git cherry-pick -x c43122fef328a70045fe7621c06de6b2b8e19264
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072029-familiar-passage-6884@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

