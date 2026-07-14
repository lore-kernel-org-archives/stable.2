Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EC25B0B2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047646; cv=none; b=JqT3E7dmJJAl1PVh24HZvRNlSBeYseKdd9muvLn/W9TNL8rt+0U37khLH3MBcLG4VrwuJlfTVq9LrNKe5UnKPu1CnmGDTrgVRbVifLds/OpKUv+yg+7u9gXpgkaIdyaEfgfnbXmKoO3NcYASgOV2sGZcfaw701VKhpQwzG10ckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047646; c=relaxed/simple;
	bh=LTbRCKE/2H9p+MgWoauwwJ1WR6ljz9PqN9CGDiGgzZw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BkKlqcvsyQISj+8pRVCaPPCHQXFKwdndgkt89sDNs7eTwX1KjpevZW5cpC/bNMA01r1GQMNEQO2BkmQ0DRLc+ELjX/P8nhsfmoVrz8l7lVrXcVoXJa6XOrwUSZaXHDtbabcQGL8MP7vljD3JyNxs6Jh0F39iPGzycl4K4spl+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rg3sF0vM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rg3sF0vM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB2D1F000E9;
	Tue, 14 Jul 2026 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784047644;
	bh=KJ0zHNEVEaV7NF2I7KDp04hfVZS0JbQxk1fryiQuANo=;
	h=Subject:To:Cc:From:Date;
	b=rg3sF0vMV/gsEu8h3r1f7onanpJTyDYMxmAVChs5vVqmrefvaku2gmH+NTB/IKrKz
	 uC29qJFLN+zPCm66q19B9CS6msbg3MeCFutnepbRZqv42ga9jycVAMGz/b5iolC+Q9
	 TifcHHZvTeyAyU/86TAcwOJobUVApkI6dIsQ//Sk=
Subject: FAILED: patch "[PATCH] USB: serial: digi_acceleport: fix write buffer corruption" failed to apply to 5.10-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:47:18 +0200
Message-ID: <2026071418-aground-flatly-63ff@gregkh>
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
git cherry-pick -x 24ca1fea8f2753bf33e1d458ec1ae5d9b7796a65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071418-aground-flatly-63ff@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24ca1fea8f2753bf33e1d458ec1ae5d9b7796a65 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 23 Jun 2026 17:12:29 +0200
Subject: [PATCH] USB: serial: digi_acceleport: fix write buffer corruption

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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 6899aebfd6ae..5f3a95682179 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -427,20 +427,22 @@ static int digi_write_inb_command(struct usb_serial_port *port,
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
@@ -449,6 +451,9 @@ static int digi_write_inb_command(struct usb_serial_port *port,
 			spin_lock_irqsave(&priv->dp_port_lock, flags);
 		}
 
+		if (ret)
+			break;
+
 		/* len must be a multiple of 4 and small enough to */
 		/* guarantee the write will send buffered data first, */
 		/* so commands are in order with data and not split */

