Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64840BCA0
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969508; cv=none; b=jHi/e+IRmphdAVUSBnF89xhp1A3/pZ4s1FNgrSj7L+X7fh8Vbp/nwd4DlVoH8q3c2P/sA5ZTyeqd0SKc7RsMBNwrwmLb+BgFpei7llEdYaudBjA1koj/qA2PCig5dqbtbTb8MReX0VEOMQPgW2Jq7+yNjz7ct89p/qMCE8d9ArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969508; c=relaxed/simple;
	bh=dct46hP4jyYtEqdweiVv49hxGo+R3tFb5l2PSjKdqUA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AMsx6vUQQYVDn3VyFay9EFxTvCz49nlU6HYsL4FK5daclk/WmeyobGTU/YH9hSDuY1I+ZQ7MBoulp+W6Z/U3pAf8Qn8jNm8K/liFN/Mmszl9ss1NyduG6CDGGroyi8v5OCsHIv5uIYNl8oBob6tl/1xb6mJVSN2VZGr4nVlS5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a9u3f6Tr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a9u3f6Tr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8991F000E9;
	Mon, 17 Aug 2026 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969506;
	bh=ZElmY8kwiF4kk6shp50SPNNMyWd59WvUPgQwoQgZmLs=;
	h=Subject:To:Cc:From:Date;
	b=a9u3f6TrBXGeLvYO84jpSaJw/BDoUl/64aagNMTOTWM39Jr+7mh+2Uqc9oQEmRCkb
	 cyWkpK35X0NLECF+FspUVTNTfVU+tvGOCnqdMnLDFSAn7h4n08+CBu/LEPS6mlVPoO
	 jDZLLzlgvhyas+AKzH0QGYBFBNAxZs85mLE+z85Q=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: enable THRI before filling TX FIFO" failed to apply to 6.12-stable tree
To: luca.fresi@bithiatec.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:24:54 +0200
Message-ID: <2026081754-ogle-alkalize-4f27@gregkh>
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
git cherry-pick -x 246ac114f485c2affb454240f3ea4fabfce22456
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081754-ogle-alkalize-4f27@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 246ac114f485c2affb454240f3ea4fabfce22456 Mon Sep 17 00:00:00 2001
From: Luca Fresi <luca.fresi@bithiatec.com>
Date: Wed, 22 Jul 2026 00:24:04 +0200
Subject: [PATCH] serial: sc16is7xx: enable THRI before filling TX FIFO

sc16is7xx_handle_tx() currently requests the THRI enable only after it has
filled the TX FIFO. The request is asynchronous because the IER update is
performed later by reg_work.

The SC16IS7xx generates a THRI interrupt when the TX FIFO crosses its
trigger level. If the FIFO drains past that level before reg_work enables
THRI, the chip does not generate a new interrupt. Characters remain queued
indefinitely even though the hardware FIFO is empty.

This was observed on an SC16IS752 while both UART channels were active.
During the stall the software TX buffer remained non-empty while TXLVL
reported 64 bytes free, LSR reported THR and transmitter empty, IER had
THRI enabled, and IIR reported no interrupt pending.

Enable THRI synchronously before filling the FIFO so the threshold crossing
cannot be missed.

Fixes: cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
Cc: stable <stable@kernel.org>
Signed-off-by: Luca Fresi <luca.fresi@bithiatec.com>
Link: https://patch.msgid.link/20260721222404.204746-1-luca.fresi@bithiatec.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 6c97953d593b..9b152ead050f 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -827,6 +827,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 		msleep(port->rs485.delay_rts_before_send);
 
 	guard(mutex)(&one->lock);
+	sc16is7xx_port_update(port, SC16IS7XX_IER_REG,
+			      SC16IS7XX_IER_THRI_BIT,
+			      SC16IS7XX_IER_THRI_BIT);
 	sc16is7xx_handle_tx(port);
 }
 

