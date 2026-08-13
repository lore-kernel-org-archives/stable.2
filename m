Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56E225791
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582426; cv=none; b=TuPAX/F5lO3/+xPDhJqjaw4opYU73bH/nb6BIvEPzbx21KWsfbYsILdm/6mDqGoP9OBogiy9ggRAZD9cXKpUBZIxr3TWhHDfPaOwbHVUhDTnEshIhvgr7zWikQrxVzVlESphgZe7dEPplX8U3t4K2UKwWgugLGAago6ZifKHfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582426; c=relaxed/simple;
	bh=M2fN/AOY0gfyViNVbnoWNq0wJw2NUfTlAxpDm6whj68=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I6TukCvKpuAjeLIZpN5x8ZV5e1MQRVYMMGrNCwb25xGg5RHfzye6QMj8y7+aH5bOrGX2FFylO5FF7LVL8ZLo/sIahzFEYhw0pdBTGgKL+wkqs7nxpAR1CLaA68fDOE+xlywetqJDYKNsOkShuuJqNgeG82k12puWWRtzpr6+rMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bhOlK0ua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bhOlK0ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DE41F000E9;
	Thu, 13 Aug 2026 00:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786582425;
	bh=jh6yAM7Hk82mC9FK3BAKdYltFMEleVk3WbifQYQIP2w=;
	h=Subject:To:Cc:From:Date;
	b=bhOlK0ua7GgtOAxqY5vURVh5x6zH/gOVoXeDR4EwS5Dyg/z0e5UB00BXJ+SQaiH7L
	 i61AyperK7bcb/W8us3S8GTyVNQhV0I/7k/u0BjiIIZVdBV+agSzkZauf0KZTucbHc
	 lg0nlkY1kaTXgZHLKYd/uGWdEyeD/u3DpeCGAuxg=
Subject: FAILED: patch "[PATCH] usbnet: cap max_mtu for drivers without bind callback" failed to apply to 5.10-stable tree
To: lvivier@redhat.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Aug 2026 09:51:55 +0900
Message-ID: <2026081355-oversized-handled-8ce1@gregkh>
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
git cherry-pick -x 1505b2cb6ae1c7e8ac0c6e4590a204ffc3ab2b24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081355-oversized-handled-8ce1@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1505b2cb6ae1c7e8ac0c6e4590a204ffc3ab2b24 Mon Sep 17 00:00:00 2001
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 31 Jul 2026 11:27:11 +0200
Subject: [PATCH] usbnet: cap max_mtu for drivers without bind callback

usbnet_probe() initializes max_mtu to ETH_MAX_MTU and only caps it
inside the if (info->bind) block. Drivers without a bind callback
never enter this block, so max_mtu stays at ETH_MAX_MTU.

QEMU's usb-net device (0x0525/0xa4a2) is claimed by the cdc_subset
driver which has no bind callback. The guest accepts any MTU from DHCP
(e.g. 65520 from passt), leading to TCP segments that exceed the
device's 2048-byte receive buffer and are silently dropped.

Initialize max_mtu to net->mtu at probe time and update it inside
the bind block.

Fixes: f77f0aee4da4 ("net: use core MTU range checking in USB NIC drivers")
Cc: jarod@redhat.com
Cc: stable@vger.kernel.org
Link: https://gitlab.com/qemu-project/qemu/-/issues/3268
Link: https://bugs.passt.top/show_bug.cgi?id=189
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Link: https://patch.msgid.link/20260731092711.857684-1-lvivier@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 25518635b7b7..a19ecf718f36 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1794,7 +1794,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	 */
 	dev->hard_mtu = net->mtu + net->hard_header_len;
 	net->min_mtu = 0;
-	net->max_mtu = ETH_MAX_MTU;
+	net->max_mtu = net->mtu;
 
 	net->netdev_ops = &usbnet_netdev_ops;
 	net->watchdog_timeo = TX_TIMEOUT_JIFFIES;
@@ -1804,6 +1804,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	// allow device-specific bind/init procedures
 	// NOTE net->name still not usable ...
 	if (info->bind) {
+		net->max_mtu = ETH_MAX_MTU;
 		status = info->bind(dev, udev);
 		if (status < 0)
 			goto out1;

