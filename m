Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DE4772B2
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196339; cv=none; b=ecbSS23fwT6o+QI5EX6Q0eL/+/n9k95sTAv/Q8EOIQ5jzSyKHjdHXtAs3C9lJ3KVhABUUNy0hyPXB/MqBcF7eSbxE1zcFFCMsiw6d+oLNV+9g7R0sCWp5a1GDvxIJUCEzXelUikAIl6MlO4cdKlc750jZki4LP2IY3z3LQApRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196339; c=relaxed/simple;
	bh=gBh4xrWv/2503PqCnFnf0c5FQWoFXA3aU1cF0uO1LPs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aLVvDUVLiZT9HU1drM9MKYV3VJFT8Q/NtKtMs9mF7ytlARJTCdimBmdgVi4OuTjcJG5oJWYMSI3So0yl1lCHSXtVJusmgBqCBt7xInW/O1NX+nOO7VXpTQ5+RpjxPOJV1WqKAvnG7PjpHuH9H349SKhMVr0kRT8xL9EaJ9nQbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VrO1rniy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VrO1rniy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065701F000FF;
	Mon,  5 Oct 2026 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791196337;
	bh=X+zcPErUWeRUO2pBf0yESRftK258y0T80Und0JmSHfQ=;
	h=Subject:To:Cc:From:Date;
	b=VrO1rniy/luXw6hd8BMb2bYUlgtggBDOFJgATT7i4lKQGhVkauoMb+En+pf8q7Uqw
	 GwFemUlf7dx4p1NER4SSbv5mAQiV9xkgn+UuOhTelXMsL/pV5lHhvEbN+hyv6eUMCk
	 wgS1CpvB2U4qn/yHKuzI2usuyv8YKzPVrdvjw/u4=
Subject: FAILED: patch "[PATCH] serial: abort TIOCMIWAIT on hangup" failed to apply to 6.12-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:31:57 +0200
Message-ID: <2026100556-aqueduct-uncut-b4f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x eb35b73e133686e5b999eb7130c4e3d22fe03089
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100556-aqueduct-uncut-b4f5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eb35b73e133686e5b999eb7130c4e3d22fe03089 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 10 Sep 2026 15:08:16 +0200
Subject: [PATCH] serial: abort TIOCMIWAIT on hangup

Add the missing hangup check to the TIOCMIWAIT wait loop to avoid going
back to sleep (indefinitely) after being woken on hangup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.org
Cc: stable@kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260910130816.642699-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f7b30f77b231..33c8f3b6ac81 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1244,6 +1244,11 @@ static int uart_wait_modem_status(struct tty_struct *tty, struct uart_state *sta
 			break;
 		}
 
+		if (tty_io_error(tty)) {
+			ret = -EIO;
+			break;
+		}
+
 		schedule();
 
 		/* see if a signal did it */

