Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD230E0E4;
	Thu,  6 Aug 2026 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024392; cv=none; b=iWcKGoZp+jOjFimSHV2v4QHJcMwbzC+cJ9QJe1hZBFYSNZ/+tUE0LlBhkSwpiGDOgFhdIHb0rTpS+Wel6FQGVNJI209M65g4Uf1e8e+GTBKB+hq3d4IVkQM5W/xDfxs2oMIKjEBVSIqMrxYDA8PpZEXxZxG5um/jjJJJRby+YaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024392; c=relaxed/simple;
	bh=HOJtbj0EPQwztnb2HFMOs3a85Q/a9QLwQhke73uDg8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cr/Xuh5LokXllZ920/UmYsFED3fu3tEw3FudCJhVB/7ZF8x1Xlx5n69nmD8BZIq3Oom8Mquf76YvsR3ps5bPSL/PoDZs5josatjjWq6slGM7k9FWSv2+frQPHh0SyzEEIV3RzAx82pjennDmd6Inii5rivKYdX8X8dFTsOD/nLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm4asvt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm4asvt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBF01F00AC4;
	Thu,  6 Aug 2026 13:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024391;
	bh=TrmNoq7dbxYoWdCONtFEyW+1bRqsCvc6ZNdJGLCVvx8=;
	h=From:To:Cc:Subject:Date;
	b=Bm4asvt0Xti90TjOE5MGjiBvPy56BMZOLVhVAYo35WvaVxTfB5kkFqSj3xjEyXKTE
	 jldc+qPaDke1lZRN24S7Bk1Q2k3JukPRXSxDvFdz/lOpy1ZZfMqruSdNHg8uxs0wiy
	 atjBYLf8vC8h4Ptf/JeZL4BBzG2vCyZCayX5YKBDIdz+KgyqBQRyRxKtNPrlb2kM/u
	 R9C7+gPgEDsb46freEIsYJYAiVNWDw0naicXYjy9V360TxPHl3r1OmPv1+6Tc5hQ6J
	 +HiuNR+PLMbOliEYf4SBRDyu90QDcT+Tz/h0woW9TN+47EAgV2AEiXqdrbhq/FFVui
	 oKztkifnGQIrg==
Received: from johan by theta with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1wryWx-00000000Xh4-46G2;
	Thu, 06 Aug 2026 15:53:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+3b514b87202742f22c44@syzkaller.appspotmail.com
Subject: [PATCH] USB: serial: spcp8x5: drop broken carrier detect support
Date: Thu,  6 Aug 2026 15:52:48 +0200
Message-ID: <20260806135248.129482-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver does not support modem status notifications and instead used
to fetch the modem status once at open() and subsequently operate on and
report stale state.

As part of fixing this, a call to fetch the status was added to
carrier_raised(), which does not work as that callback must not sleep
(e.g. unlike tiocmget()).

Drop the broken carrier detect support.

Fixes: e1ed212d8593 ("USB: spcp8x5: add proper modem-status support")
Cc: stable@vger.kernel.org	# 3.10
Reported-by: syzbot+3b514b87202742f22c44@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a73cea2.01d0871a.3a0d52.000d.GAE@google.com
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/spcp8x5.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index c11d64bf08fb..f610aef6bf59 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -235,18 +235,6 @@ static void spcp8x5_set_work_mode(struct usb_serial_port *port, u16 value,
 		dev_err(&port->dev, "failed to set work mode: %d\n", ret);
 }
 
-static int spcp8x5_carrier_raised(struct usb_serial_port *port)
-{
-	u8 msr;
-	int ret;
-
-	ret = spcp8x5_get_msr(port, &msr);
-	if (ret || msr & MSR_STATUS_LINE_DCD)
-		return 1;
-
-	return 0;
-}
-
 static void spcp8x5_dtr_rts(struct usb_serial_port *port, int on)
 {
 	struct spcp8x5_private *priv = usb_get_serial_port_data(port);
@@ -458,7 +446,6 @@ static struct usb_serial_driver spcp8x5_device = {
 	.num_bulk_out		= 1,
 	.open			= spcp8x5_open,
 	.dtr_rts		= spcp8x5_dtr_rts,
-	.carrier_raised		= spcp8x5_carrier_raised,
 	.set_termios		= spcp8x5_set_termios,
 	.init_termios		= spcp8x5_init_termios,
 	.tiocmget		= spcp8x5_tiocmget,
-- 
2.55.0

