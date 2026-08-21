Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032A436E47A;
	Fri, 21 Aug 2026 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327174; cv=none; b=PqSUMzvH8gXEYGBwuPRr4MgE5d1PwT0XG177j9v8SzTcibnb3akcgPETzr7dLl/5k12dtsbK4BHDcuc4IEJlxLY/IYcMX2nCk6lbfzmDduPT4Ixv93niuRzdM6LWLG6LD6+BtFh2MYMg/Qd/h5Tnd6EsYCFZmVZsAKSqSY9dlxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327174; c=relaxed/simple;
	bh=XcfBC699KxyVkWM+s5l4pEhTcj2TKtaaAFQw5w+nS/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQFmUGYiWmO8BcEgx4En/W02Gu/25Q8c/u6aVIZY7o1Vfv90JX6YdIy37pYabA961wS6BAWWFoLg1GLxWsKDB4Gcx3oJkNDxXni2vQoS/+IT6nNsmFYcAGSxF8c/6F2jAw1v2Xvf27YjZ5X+ROHsWDD61aKYHPwe676aC82HQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxheQm/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxheQm/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16BA1F00A3A;
	Fri, 21 Aug 2026 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787327172;
	bh=6vRlUhKx/isRt8LkBmgULalaVLm/JMvZWTxG3KUTR2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jxheQm/745XBeXUyD6IVCSKIEXlc4OtE/t/EOHTECOhy/ODKkgu11cWkd+lDWEcJ0
	 m0ivRYx0YFqWaemUf5F7LxGmCSHHdscYHePepA2nuI1C1sQqzLK3I0UZHxLnlEVPCm
	 bE9Saui8oYn2DEnCsAZVCheaOyN8hlTBPYA4J+ltvce5hIUMIAe9iP7bSr43qqkPix
	 qbs4kI6V6lfbVdhnRDHWMO/VoYeaO5hyLokAeEPW8umAlzomGzWfYXcIjlimU3CLcb
	 2Kc67Ex5L8ZU+wLrt9snManrVkpPnUFKXY2/P1gLgEkW+cis8gdqLUnVx13WwPl8Tl
	 t64dfk90Awp3Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wxRRa-00000000UvW-23op;
	Fri, 21 Aug 2026 17:46:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e5e28c3e953b2eebb16e@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] USB: serial: fix port tear down use-after-free
Date: Fri, 21 Aug 2026 17:45:43 +0200
Message-ID: <20260821154546.118809-2-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821154546.118809-1-johan@kernel.org>
References: <20260821154546.118809-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers for multiport devices access port driver data from
completion handlers of shared URBs submitted at attach() or first open()
and stopped at disconnect() or last close(), respectively.

A simple NULL check before accessing the driver data makes sure that a
port state container has at least been allocated, but a completion
handler can still race with port tear down.

Reorder the disconnect handling so that ports are not deregistered (and
their driver data freed) until after all ports have been hung up and the
driver disconnect() callback has run so that all I/O has been stopped.

Fixes: 2d93148ab698 ("USB: serial: fix lifetime and locking problems")
Reported-by: syzbot+e5e28c3e953b2eebb16e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a7e6fb9.ec5dc6cc.21cb3f.00c0.GAE@google.com/
Cc: stable@vger.kernel.org	# 2.6.30
Cc: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 17edc057a311..a4fbc849c0fa 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1191,12 +1191,17 @@ static void usb_serial_disconnect(struct usb_interface *interface)
 		usb_serial_port_poison_urbs(port);
 		wake_up_interruptible(&port->port.delta_msr_wait);
 		cancel_work_sync(&port->work);
-		if (device_is_registered(&port->dev))
-			device_del(&port->dev);
 	}
+
 	if (serial->type->disconnect)
 		serial->type->disconnect(serial);
 
+	for (i = 0; i < serial->num_ports; ++i) {
+		port = serial->port[i];
+		if (device_is_registered(&port->dev))
+			device_del(&port->dev);
+	}
+
 	release_sibling(serial, interface);
 
 	/* let the last holder of this object cause it to be cleaned up */
-- 
2.54.0

