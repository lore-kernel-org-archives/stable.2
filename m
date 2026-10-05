Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0743B6D3
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196336; cv=none; b=JdDC9iCsU0Y8MPhonnPgGVO9YAzNPywJyriVyyl4uHzwj73MXbFzS5TSxMM7rsAOz+nHXp4oiLE+wlk2ulg/S2VNNuloSrLb7vIGfcUR60lkP2gXGAQ1VvfewmfYE0PYXYfDosK6dHhT1uASWtwIdI2xprdKhKVT8YSMYN1yAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196336; c=relaxed/simple;
	bh=5xM9fPX+qRurNLLBi1Zg5qrwx5vqVuwvLQWZb4dtvlA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cGy43ERFZrINtvDW17QdUa4HJJNaADEY0T25WmbrSyd7JT3PlJwUeG5ql4ahRRU3EeaW7/sD/+zMBpydkTinNzZcS/8GS1Q6cNpNIzM+Bf4y1ykj+hLnKuUbSyhqS0N+334Dy1BGvGXiWHnZ9n8qhvbN4eX2eV1UZYnZXxJHuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2P1W7pra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2P1W7pra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5141F000FF;
	Mon,  5 Oct 2026 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791196334;
	bh=CeLep9SZCiaadYjZrb8XgEbZzJEi6O2gB5ffxJXGjA0=;
	h=Subject:To:Cc:From:Date;
	b=2P1W7pra+qYFwB/xrgfslXYkgwWOylXH7Pd6YRRmuzBKc3h/VZw2SuXC1l7jaSvsf
	 jirnfwO6va+tvQxaC+MqH51IOqmmupHh5AhpZizHEL1Gi4XmyikaOry7KVSajZiymD
	 T1VgL6nIoZHWeqEOz2AK2xymwUyChAUkgr988JAc=
Subject: FAILED: patch "[PATCH] serial: abort TIOCMIWAIT on hangup" failed to apply to 5.15-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:31:57 +0200
Message-ID: <2026100557-ungraded-hacker-20c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x eb35b73e133686e5b999eb7130c4e3d22fe03089
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100557-ungraded-hacker-20c4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

