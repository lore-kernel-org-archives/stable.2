Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CA3D8115;
	Tue, 23 Jun 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227482; cv=none; b=ahMXRD6Mq9zw34+Vu2wg+R9hKAUex9YsyYHZVwhT0GuBTyRY+6pJww/tpDKD/cf7KLhhaviXrfCNwNya197C0VRT+dO3FCn5rL7R1braDV872rVwJQpKAi7rGSPchFgChXvm6ZANQtIy3/uoR838f9glmUbmu1oIhVF4PmeolNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227482; c=relaxed/simple;
	bh=uwk1PymkjxyUBw3V19NQW1dEKUnOAIgDGoHbHtGcO5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ype/OmPJ3tFC/yccESREr/0S2B6czkIQg3hvtA2nhzEa1X+zAiH7qBxgBz317WphNoFUfoDJJoWzylx0q72kXAUGK0gWgTv45dntRAvWNnWcZ9Rl2TIfvgl2tGAF75sDz/Oebe6CFulcbIMUezPCP9nHWvwtzRP1E98TcLlaB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/eJhAl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/eJhAl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744831F000E9;
	Tue, 23 Jun 2026 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227481;
	bh=AemHZ9NEJJAtBbe4ElE//7AIo3UG/zkX8kzlaVFE7JM=;
	h=From:To:Cc:Subject:Date;
	b=G/eJhAl98WlIvz/iIqismZe5fIoNQycg+E3c9NxM1D+tTNYtwyBkMlOKEK//NzO9G
	 aYIEvWJJs3/JsJ9+4MPh6M/isbefb3+I0my+dosvc7S1IFyCvhCPWsXwsgfif62q0x
	 qyutWuPAGP7wzwcDhHaWb8CoKno8Sq+Gf4wADSEde9Xuy5hmXfIsY3Lsc1MhuoWMji
	 DIp4N4bkWrWfrVUURQYt+hbhdOh5mNPS4Y3rCfgdHGnYyBhvEdmpiKJwFC4Kb2mxiw
	 VXt8fuGt1wzsMvyN7RRSUV461MJQ6gowZdRsnF1TVsh7+0+qR4mYbIB63tQEPulBWT
	 F9ax4k/ZWyWig==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wc2mV-00000001Jyy-14VJ;
	Tue, 23 Jun 2026 17:11:19 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: digi_acceleport: fix hard lockup on disconnect
Date: Tue, 23 Jun 2026 17:11:10 +0200
Message-ID: <20260623151110.315126-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If submitting the OOB write urb fails persistently (e.g if the device is
being disconnected) the driver would loop indefinitely with interrupts
disabled.

Check for urb submission errors when sending OOB commands to avoid
hanging if, for example, open(), set_termios() or close() races with a
physical disconnect.

This is issue was flagged by Sashiko when reviewing an unrelated change
to the driver.

Link: https://sashiko.dev/#/patchset/20260610132232.356139-1-johan%40kernel.org?part=1
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 6899aebfd6ae..88c61030982a 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -392,12 +392,14 @@ static int digi_write_oob_command(struct usb_serial_port *port,
 			len &= ~3;
 		memcpy(oob_port->write_urb->transfer_buffer, buf, len);
 		oob_port->write_urb->transfer_buffer_length = len;
+
 		ret = usb_submit_urb(oob_port->write_urb, GFP_ATOMIC);
-		if (ret == 0) {
-			oob_priv->dp_write_urb_in_use = 1;
-			count -= len;
-			buf += len;
-		}
+		if (ret)
+			break;
+
+		oob_priv->dp_write_urb_in_use = 1;
+		count -= len;
+		buf += len;
 	}
 	spin_unlock_irqrestore(&oob_priv->dp_port_lock, flags);
 	if (ret)
-- 
2.53.0

