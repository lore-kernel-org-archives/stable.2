Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D104D09F8;
	Fri,  9 Oct 2026 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549192; cv=none; b=bCOt0H0QBYNed7l5mI+FXCuGsUqQYJUzam2EEh3CzK53ytV1Yp/qlvoXAdguBwuxm1are4rbkfV1K3lQ6Mva6ZZBvlQGOsJ3IsXXG1t5v/Cb526bSMvdODTOCVtdYXFKfYPF749Q+Lzy3IGJdaRoaHlpfUQo7S26ZTkX9evLS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549192; c=relaxed/simple;
	bh=eUHw00mNg1vuhrGZgWT2dB9KTrTEwhUKei0FAzduiX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/AbP6GVVKGYv4lszwGPanwajaxnO+xS8EpNummJanG2BH1jL8hZq104xu/t7hK5Zt08Xk9djxNTtQGmoVpY6thTcD19DKrCZD3hgnDEe3LoiR4dBrM/tKzdJ9jdx+ifKsB95SkA7X5WMhxXYqD7s/kdbQghQb329spImTycO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlfswG64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlfswG64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B151F000FF;
	Fri,  9 Oct 2026 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791549187;
	bh=XhZADau1cmc/7yeBiR43RyHsfexGH+EF/sRONx8Fy4Y=;
	h=From:To:Cc:Subject:Date;
	b=QlfswG64oWr2lai2H09Rgtf6fFLniYIRSlyQ88KDr/7FgMpYBHFfuwtGXlNXwU1o0
	 rUOgEgRasR1eX9EIuqN3Gd1bJy62ChA3ix0N5h1rjJcFzpT5V3cki8TUcWxcq6Onk9
	 GgPdnPPlKJTshpeJQmv4X/BLNxSDKNoMHMWc9qXVFGdhkPotfkmFoH5MkonHBAqJH2
	 B/xzSucIbuSJific1Exj+K5Ul7UwqVL9b+yhYXjD1opAy4FV9mjmkAlla8XNnBD5Cw
	 OVCzjmnLTQ+fK2jaNMg6j/LhQ+zA9YkvcyFly7sJ20evRHyEcir/TuFRaTDcht84sp
	 H9AAz+/5DxHcQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xF9mb-00000001wxx-3lX2;
	Fri, 09 Oct 2026 14:33:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org,
	Oliver Neukum <oliver@neukum.org>
Subject: [PATCH] USB: serial: usb_wwan: fix urb leak on disconnect
Date: Fri,  9 Oct 2026 14:32:42 +0200
Message-ID: <20261009123242.464956-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken by usb_anchor_urb() when removing
URBs from the delayed URB anchor to prevent them from leaking when the
device is later disconnected.

Fixes: 383cedc3bb43 ("USB: serial: full autosuspend support for the option driver")
Reported-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://lore.kernel.org/20260916165608.2085613-1-vulab@iscas.ac.cn
Cc: stable@vger.kernel.org	# 2.6.32
Cc: Oliver Neukum <oliver@neukum.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb_wwan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index a183cc4515ed..6beb4062bda3 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -401,6 +401,7 @@ void usb_wwan_close(struct usb_serial_port *port)
 		urb = usb_get_from_anchor(&portdata->delayed);
 		if (!urb)
 			break;
+		usb_put_urb(urb);
 		unbusy_queued_urb(urb, portdata);
 		usb_autopm_put_interface_async(serial->interface);
 	}
@@ -578,6 +579,8 @@ static int usb_wwan_submit_delayed_urbs(struct usb_serial_port *port)
 		if (!urb)
 			break;
 
+		usb_put_urb(urb);
+
 		err = usb_submit_urb(urb, GFP_ATOMIC);
 		if (err) {
 			dev_err(&port->dev, "%s: submit urb failed: %d\n",
-- 
2.55.0

