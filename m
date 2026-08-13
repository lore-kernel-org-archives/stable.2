Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48684225791
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582406; cv=none; b=HwsgnFd6RAqI2zlc5/QpzTB4QtsLN9BiuwfzRK8Wzf15TEvWSA5F0NllNuuAIEu1IRBYRgT75fJ9Pl0dyZGAAu5+WLcJ4PHFjxfcePClqIOOZfGmfNWNwU4b42eD1wZ0GUDTtSwB5Za33tMFvUqfxitlIRSzP20Oo4CPPzfQ9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582406; c=relaxed/simple;
	bh=IOyxsIpfUsYYWdB+yrszpZYTdZwtT52YPuKdPjTX+Z0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qp7opqPSOU2I0/1v3g1z7tXOaVlFSsgDPRAV06CZCjwLs/VE6vMsvnbxjyBAW+5xMqajB9UMWzLE8blQu6kYP3hxOxJ1VMjYSKML1E3OYGSmEIgcmIyf6ui4m9eB3vcpf6IyfWMLgua/XplCH4iWJbGevGS/RLEYEVabzPstQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tm32ggw2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tm32ggw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA751F000E9;
	Thu, 13 Aug 2026 00:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786582404;
	bh=JNJbtahommPxSMuYX4s7oucQrNJOiA2MK2lpVXTfKU8=;
	h=Subject:To:Cc:From:Date;
	b=tm32ggw2u73kOKq/pNhMJiKzL/3ZlqFOweuDRW10FRz6k+gu8D5bkR7VWSVOnzpnb
	 MdySk/KHTkBBulKIXBiZUcdbJ5Z4FjE6Dcw8GIVSPd7gLSw5+b7lUO6aKkcGRN/c01
	 YI5o+YqUVAKdKxpI2+uRVDUVcGeCxMQXzsEQvc1I=
Subject: FAILED: patch "[PATCH] usbnet: cap max_mtu for drivers without bind callback" failed to apply to 6.18-stable tree
To: lvivier@redhat.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Aug 2026 09:51:51 +0900
Message-ID: <2026081351-mothball-parachute-6166@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1505b2cb6ae1c7e8ac0c6e4590a204ffc3ab2b24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081351-mothball-parachute-6166@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

