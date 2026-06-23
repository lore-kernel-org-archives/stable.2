Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9603D7A0C;
	Tue, 23 Jun 2026 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227345; cv=none; b=gtIonn5lwD975smf/mIKxgA4Ddw98bAkRTFDMwHu9QJB1+a+XrcP4XlKIYc9U6TU0hQzPaz5B85GJEgoqaidWtiuW3GlZUujIOPCa+VXldyff2I/CMHDNgkiUKyF3GCGqjsdPhmhyzUtb+qACy7Sb1Z+Uv6JrKplFHqFfh/I5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227345; c=relaxed/simple;
	bh=bKNHryojDco4cA3qu+usvAj7qEya37LikZc0zelbZeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpjOfjVoUYtQrO393RfOQTF6lSRy5mfSeIr18JwYE/3vnEEcbMibJWBh8286aZbPJWHP+SCLAis8vIdmYF23rwHltBKdMQRTbEgxXpS8z2FxP+GM3g+EyT7Qsys9ZemscvTTKn34RLxcBzCJJyyX7oEfvI5gcNx5OzLXIpq4kVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbdkT89V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbdkT89V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F2B1F000E9;
	Tue, 23 Jun 2026 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227344;
	bh=VEQjs27Klt/xZIkT9Mh9ExUZ5YTjvmb2k0UQFDScFkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GbdkT89Vi/EGgp3FKOu2EPKXzPlpq7xo7QV6DgjQfjoyQfO8n8P/hWlYfo4Gi7o4v
	 2fO19bAfegF4eZ5jrz62z0gcWV8BYWw/9+vekYJKyiBv6VfdNsNwlKvDISD7TOEkj7
	 G/dQ90bJikl5PJXYo6widGC3XpAKZbL0UASlrlP5aM/7tVifHeGnJA3tbxXPNPf69Z
	 0OJo1WftWxS7bM8hVfxgzzx6Pp/DU9gFtYuy1bWHupfenLKCEHUi0cHve1QWT2txoz
	 U5SPhc11VcqK1udHKyQGC4pm30VUtoRvK3tz0tmQ9bSclWue97VbaOKw7uSVvTGjkg
	 hOKnd/3DYlYEQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wc2kI-00000001Ju9-1Jbv;
	Tue, 23 Jun 2026 17:09:02 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/12] USB: serial: digi_acceleport: fix broken rx after throttle
Date: Tue, 23 Jun 2026 17:08:15 +0200
Message-ID: <20260623150826.314727-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623150826.314727-1-johan@kernel.org>
References: <20260623150826.314727-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the port is closed while throttled, the read urb is never resubmitted
and the port will not receive any further data until the device is
reconnected (or the driver is rebound).

Clear the throttle flags and submit the urb if needed when opening the
port.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 6899aebfd6ae..097769525ca4 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1069,6 +1069,7 @@ static int digi_open(struct tty_struct *tty, struct usb_serial_port *port)
 	unsigned char buf[32];
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	struct ktermios not_termios;
+	int throttled;
 
 	/* be sure the device is started up */
 	if (digi_startup_device(port->serial) != 0)
@@ -1096,6 +1097,21 @@ static int digi_open(struct tty_struct *tty, struct usb_serial_port *port)
 		not_termios.c_iflag = ~tty->termios.c_iflag;
 		digi_set_termios(tty, port, &not_termios);
 	}
+
+	spin_lock_irq(&priv->dp_port_lock);
+	throttled = priv->dp_throttle_restart;
+	priv->dp_throttled = 0;
+	priv->dp_throttle_restart = 0;
+	spin_unlock_irq(&priv->dp_port_lock);
+
+	if (throttled) {
+		ret = usb_submit_urb(port->read_urb, GFP_KERNEL);
+		if (ret) {
+			dev_err(&port->dev, "failed to submit read urb: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.53.0

