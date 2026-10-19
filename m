Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C54EF14F;
	Mon, 19 Oct 2026 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413545; cv=none; b=QQyNaINeQhacuVkao3tecfW4yK2nugM3UNc2Bn8Zgu+r8J6xMxukCrHIdPcu32e3J93sKzgBtAtGh0eOxucWWJsJ6wd4fWMbxBGWNJYU8u1fQgL4539U15DkAtTTeJ1L4vy22ytlut2bKbqZ2ZAHfzFJ8RpDLOtCh/kzGS7Ebe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413545; c=relaxed/simple;
	bh=BDdFtg3ZGv7rmQwN0MseL8YVqHdUCU+/nGoJZkoUIlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4d1g3dtb3/KbZ5Z2lvipC2tB9udWc+8R6m6DsmiSaAoxLO8WuSzXWjsD56HXBio9NexP8w/VMVOX130t6o9YyvS1y/NgsMCi7mQX4XdfhK8N0DO1HT1Z3mpMgb2u8vZhD4BDBE57TxJM19tyZJmybs01DziBymv7vE29OK0t30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuRaoIRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuRaoIRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212DC1F000C4;
	Mon, 19 Oct 2026 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792413534;
	bh=aJDtnsOU3g0kJlIqq5MrL0HWf70JKwLAZv0djCT8OFY=;
	h=From:To:Cc:Subject:Date;
	b=BuRaoIRhWVs3KyXmD0wwe1Cw4dfzu8P0cG0RrSF/ZSoLQxvK2mvw40oRIJd1YfmYJ
	 mNqUcaIZesuNzki4+HeVpim1+DoVEjZsolxiy1bgnHV5U4C9aX9MOvtpK1U/qBJd61
	 uzF9quCsRPMU/UP6+iUaYzgOBMLeBU45LA1jJEbv9678IbkAT5IQaR+Ml9Pm/ypc2v
	 Ifp/I+LkuDwdh/vViuRgSttJ4h7uAmR8a0QPLCSQTCgQEIu8j8OG8bkrjDvDuKAX+v
	 wWC7TQFl5i4BxcjeM4Ce4vPcrlwcz1tO9t2M34QowBVi2SzPpRNsXOw9TPhk7SVUvM
	 LYqox9Tz0MBHw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xImdg-00000008QuY-0B6D;
	Mon, 19 Oct 2026 14:38:52 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Dan Drown <dan-netdev@drown.org>
Subject: [PATCH] USB: cdc-acm: fix NULL-deref on hangup
Date: Mon, 19 Oct 2026 14:37:55 +0200
Message-ID: <20261019123755.2008384-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to take a reference to the port tty when processing carrier
detect changes to avoid dereferencing a NULL pointer when the port is
being hung up.

Fixes: 3b563b901eef ("usb: cdc-acm: add PPS support")
Cc: stable@vger.kernel.org	# 6.6
Cc: Dan Drown <dan-netdev@drown.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index e7cefb671bd2..a6595dcd981e 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -294,6 +294,7 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 	unsigned long flags;
 	struct usb_cdc_notification *dr = (struct usb_cdc_notification *)buf;
 	unsigned char *data = buf + sizeof(struct usb_cdc_notification);
+	struct tty_struct *tty;
 
 	switch (dr->bNotificationType) {
 	case USB_CDC_NOTIFY_NETWORK_CONNECTION:
@@ -320,12 +321,17 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 
 		difference = acm->ctrlin ^ newctrl;
 
-		if ((difference & USB_CDC_SERIAL_STATE_DCD) && acm->port.tty) {
-			struct tty_ldisc *ld = tty_ldisc_ref(acm->port.tty);
-			if (ld) {
-				if (ld->ops->dcd_change)
-					ld->ops->dcd_change(acm->port.tty, newctrl & USB_CDC_SERIAL_STATE_DCD);
-				tty_ldisc_deref(ld);
+		if (difference & USB_CDC_SERIAL_STATE_DCD) {
+			tty = tty_port_tty_get(&acm->port);
+			if (tty) {
+				struct tty_ldisc *ld = tty_ldisc_ref(tty);
+
+				if (ld) {
+					if (ld->ops->dcd_change)
+						ld->ops->dcd_change(tty, newctrl & USB_CDC_SERIAL_STATE_DCD);
+					tty_ldisc_deref(ld);
+				}
+				tty_kref_put(tty);
 			}
 		}
 
-- 
2.55.0

