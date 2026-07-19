Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BE3B38AD
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484098; cv=none; b=mQZM29BCzCEydSfVbukJxeOAkTYFvSHgW4h1ow3hE0IQ/a+1YI2hcZtU7PGk1Jb9+EIcIBVBsWZAtgnyrdi/H7VdDRH8CQJOe4DWEJsxa/PCIPplQzidUpCH/N9xxyRCjEewrI8u1cGgKbqyXOqUgCEdxSqmcgcgGttmE+/RTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484098; c=relaxed/simple;
	bh=gbYL2HaJNZvOJP3mpWv2esYadRnHF/0shFu+Z4e39Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCkoF3+gQ9ZZd1U1DRQEqDBiQwHGFGc0NEilWWR6GYkuABYj+PsQeKI2B+DPl6LdDSkkvIS96azITcgcHgM4TV7RSHljIVgfV+A5HieoIXGmXhDRHNUT5WLHlLce/JhQOBdPmSncQ3EVELkOhJPCCFAjgKoXwXVdLiZLEEeNXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXXlhsrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXXlhsrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5B91F00ADE;
	Sun, 19 Jul 2026 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784484090;
	bh=Nn+8zAjDOGAIbghwO5kj24XJApTDRwjUzLU3Ze7CjqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXXlhsrZO+/tEUooPG4ayR1HzpoTyNaamydRvcxtfu9pZBHYy7E9r8LX0BB3anVsB
	 XCflpubkH34l7xp72OI/YuwPAwNbjKnEFzaIzSGw/JXMGEEEMT/y0AD+txOumhd2dp
	 KZaXCzVpjbQSuaAsF16LjLlqmSRGRGBYxqULiH+lGLelhUNUFwqJM4T2EyGo7Zst4i
	 zRLVBasVV1BVIVyTPYJ8fqZQATpwR7llq3yrQ9GovwiJSov+tDc7C2av2Y92wKAUnx
	 eUoYDh5gWD9YTcy2MgMDldc7kZxdzwusFnIK45EJbLTwkbSLIyyK0MxJfPhQxSC/9H
	 KHhMRRCV5s3WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] USB: serial: digi_acceleport: fix write buffer corruption
Date: Sun, 19 Jul 2026 14:01:28 -0400
Message-ID: <20260719180128.1055268-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071418-aground-flatly-63ff@gregkh>
References: <2026071418-aground-flatly-63ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 24ca1fea8f2753bf33e1d458ec1ae5d9b7796a65 ]

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
[ adjusted context for 5.10's `&port->write_wait` (no `priv->write_wait`) and kept the existing `unsigned long flags = 0;` declaration alongside the new `expire` variable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index d03bba38d802d2..f785b9a79ba09c 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -429,20 +429,22 @@ static int digi_write_inb_command(struct usb_serial_port *port,
 	int len;
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	unsigned char *data = port->write_urb->transfer_buffer;
+	unsigned long expire;
 	unsigned long flags = 0;
 
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
 				&port->write_wait, DIGI_RETRY_TIMEOUT,
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

