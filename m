Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608458;
	b=DHQttutjQBqDavFpzFDQpEEj87zsEN0uMoRwUd26QXdKa8Fh5BMwov8NOQJdRiEaFu7p
	 XDF9gvEBrWAXnKWguNhyfZp9oFOMQ9DSWS5p86oPd4z2nq/ls8BkVA/zJtzukZtym+ZNt
	 FJX5f+kuPp8iyFeHBTfHAZtB8rUvf3QUONQ197uVsjpInRNHBnNObra5jchzXfwWxQ+KO
	 dsBgANtusSDRqbnkFMzYasQGDiUoO8CmH+JLcOE7DzfDMYkWzE+aaJubI4gB+SywZuvSs
	 xOorAtgiXFFAImGt6z+pnH40a993LQO3LHLl5w+TdumrUGU/5Zob6QfFuU11oidAdOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608458;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qLKVcOtbPSh+A40wffIFWE0G/e9BgzEHGOGvY5rGvss=;
	b=BUYxLNOcoZBHORAOaPx4hBhrXqiRTKaUCpjFM133b0bV5yMVMpYHgIenAau1HBuiuOJB
	 +POu9WTurusPX0umBoywZ8dQ0m7vnYeFwPgimDKCKg+fGfxpefXc4unWvg0WzijnY8yNF
	 jmnE43mNwJFKwFaaGCh2kbYfopAKCXIH4kVKHmT4E0H96LPonyEd7tGTleAeQzLVi98ta
	 b4N4TM73OSLLo1ELdw0Ujki27dUSUfKkLZZO2oNMVNeboamALy17lShQUDjOoXBsPEPMf
	 DvbdbIDI4mZ60V5PLRHsQg7imx6LYfHv2cScLBTFmukioO0A/DE+Bjujo3e0Nctuzog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WgRtaiDp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584C606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WgRtaiDp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322B21F000C6;
	Wed, 25 Nov 2026 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608458;
	bh=qLKVcOtbPSh+A40wffIFWE0G/e9BgzEHGOGvY5rGvss=;
	h=Subject:To:Cc:From:Date;
	b=WgRtaiDpuYt8kn9jNznh8Zd7J7/Kni+KT+i7a6UROZEuiUCo4D0dFWUQWGdtS3yhW
	 KDXfrVdewCGU7vA5E5ULAPaw0Q9bC21gwp6A8wmxEfAXr783OE0lpJjfLLj1zVIX4C
	 oeckpuC+K2uM757VtgFYXxJJcSaP7dtYp/RhM32s=
Subject: FAILED: patch "[PATCH] xhci: keep port link_inactive and connected flags in sync" failed to apply to 7.3-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:42:46 +0100
Message-ID: <2026112546-prize-perceive-c817@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x bb261776d1a29768b8fd84eb4f42d99dafa29c93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112546-prize-perceive-c817@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb261776d1a29768b8fd84eb4f42d99dafa29c93 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Thu, 5 Nov 2026 19:51:02 +0200
Subject: [PATCH] xhci: keep port link_inactive and connected flags in sync
 when polled

Update port 'link_inactive' and 'connected' flags even if xHC isn't
generating port change events.

xHC only generates port change events on port changes after old port
change bits are cleared. Hub driver is often kept up to date
by polling the port status.

Sashiko reported a possible case where all port changes after a port
reset take place before hub driver clears the reset change bit.
This way the port can end up connected and fully running with link
in u0 without a port event clearing the 'link_inactive' or setting
the 'connected' flags.

A protocol STALL in this state would set EP_DROP_PENDING, and
prevent all future URBs for the endpoint.

Fix this by also updating the flags during get_port_status(), when
hub driver is polling the port state.

Fixes: 6895dbdc19d9 ("xhci: give back TDs and clean up ep0 after disconnect")
Link: https://lore.kernel.org/linux-usb/sashiko-outbox-190046@kernel.org/
Cc: stable <stable@kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20261105175106.241182-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 470bafe1802b..55430b673f1e 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1166,6 +1166,12 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd, struct xhci_bus_state *bus_
 	if (portsc & PORT_RESET)
 		status |= USB_PORT_STAT_RESET;
 
+	/* track connect and link error status when hub is polling */
+	if (!(portsc & PORT_RESET)) {
+		port->link_inactive = (portsc & PORT_PLS_MASK) == XDEV_INACTIVE;
+		port->connected = !!(portsc & PORT_CONNECT);
+	}
+
 	/* USB2 and USB3 specific bits, including Port Link State */
 	if (hcd->speed >= HCD_USB3)
 		xhci_get_usb3_port_status(port, &status, portsc);

