Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7831E84E;
	Tue, 23 Jun 2026 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227558; cv=none; b=j5+kFBjzRQYHPSH0CzUW0vXwDCGpsNOP0g+uEx57BHDkAl+5+IeMZAbFnaW7kSUspKGhPzZJnJZrYcOlTKd6Mllv1Pflsv9gkUi7Ovs6z/Qm70AOHa6k5i+4zhzoM4eP8UjABQ9sL9C5cBk9vCtDJNusoPOEkCyuvHQvf696CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227558; c=relaxed/simple;
	bh=8sgXOSJ6vtlHxBsg4CBR5epczhNhfjmOHInIuwXp4dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIblTxYpxAXY6KwvEVguSFV+obYK2PG/oZ3sYwu8CekItnCx4q5lN5gbEhRPXUt4IiWyWhnVkuKrxZKWmpFnFZ1lBQXZXebVE/EOAT4jSkmI/8er7q1NFMqLzC/FColbs7UCXyzDjH/cM0HVzuQhHlx4Ypq5MsL+z57joQyTMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1mS2DWc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1mS2DWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AC61F000E9;
	Tue, 23 Jun 2026 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227557;
	bh=cVrqoqYHVIb6mlngxPsx3Rqg5kwScXHXn92OSLejVv4=;
	h=From:To:Cc:Subject:Date;
	b=A1mS2DWcxMkXjgibw1twDRKEJY9UBuoD64BIcKdS4xbrdKbSMKxzrDnNYr2bVJLlG
	 PFQ46OrynwMWCoEzGKC18gEYvKY49H7qieX/zCT4mjA53oU1BlCDSdEUOE1Zzgu8nX
	 Wyu512IOVrnadZ+sgT77P1Hy9xtydgAFp2mZhzrZ/KKPL6CK4QQXWSWuP+Q5MNDr3Q
	 xv64AmU8CxN5a/ZvKv6RyNoaP9+SbWoD5MrvpG7N+7Xj4+j66ahi/0xaQ4rmmXKAy2
	 El9xgViLOjO+N2K3pM/NE081PZ1jsVdwpgp1DlwvfH7bMb3QZJE4ZTwrDQLf64bPQe
	 9RnMYULa0MKgA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wc2ni-00000001K0X-46QE;
	Tue, 23 Jun 2026 17:12:34 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: digi_acceleport: fix write buffer corruption
Date: Tue, 23 Jun 2026 17:12:29 +0200
Message-ID: <20260623151229.315224-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The digi_write_inb_command() is supposed to wait for the write urb to
become available or return an error, but instead it updates the transfer
buffer and tries to resubmit the urb on timeout.

To make things worse, for commands like break control where no timeout
is used, the driver would corrupt the urb immediately due to a broken
jiffies comparison (on 32-bit machines this takes five minutes of uptime
to trigger due to INITIAL_JIFFIES).

Fix this by adding the missing return on timeout and waiting
indefinitely when no timeout has been specified as intended.

This issue was (sort of) flagged by Sashiko when reviewing an unrelated
change to the driver.

Link: https://sashiko.dev/#/patchset/20260610132232.356139-1-johan%40kernel.org?part=11
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 88c61030982a..fa5c3539f806 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -429,20 +429,22 @@ static int digi_write_inb_command(struct usb_serial_port *port,
 	int len;
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	unsigned char *data = port->write_urb->transfer_buffer;
+	unsigned long expire;
 	unsigned long flags;
 
 	dev_dbg(&port->dev, "digi_write_inb_command: TOP: port=%d, count=%d\n",
 		priv->dp_port_num, count);
 
 	if (timeout)
-		timeout += jiffies;
-	else
-		timeout = ULONG_MAX;
+		expire = jiffies + timeout;
 
 	spin_lock_irqsave(&priv->dp_port_lock, flags);
 	while (count > 0 && ret == 0) {
-		while (priv->dp_write_urb_in_use &&
-		       time_before(jiffies, timeout)) {
+		while (priv->dp_write_urb_in_use) {
+			if (timeout && time_after(jiffies, expire)) {
+				ret = -ETIMEDOUT;
+				break;
+			}
 			cond_wait_interruptible_timeout_irqrestore(
 				&priv->write_wait, DIGI_RETRY_TIMEOUT,
 				&priv->dp_port_lock, flags);
@@ -451,6 +453,9 @@ static int digi_write_inb_command(struct usb_serial_port *port,
 			spin_lock_irqsave(&priv->dp_port_lock, flags);
 		}
 
+		if (ret)
+			break;
+
 		/* len must be a multiple of 4 and small enough to */
 		/* guarantee the write will send buffered data first, */
 		/* so commands are in order with data and not split */
-- 
2.53.0

