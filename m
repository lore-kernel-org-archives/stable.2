Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6CB2652B2
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969512; cv=none; b=pt/LVo8NNsWOnkM7OteviH1w6todOqBBm/GPrfRAoJL8SrA6KvF3k/t8FDpyjfunUQ4jrKwuPeqb2/1FeTI3/iOKQjvbivQj1Yt9UAGkusQrASCi/XVg6Wf7tEfqrC10O/eLl0s3ibnXvu/RHAjg9P2Fc753nnZ1zz0K2k+jUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969512; c=relaxed/simple;
	bh=TW6HqYTrb6D7HL2892HG4XetPNBod2Ez08YEVsaJ61E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WnbsfZO/uqU0lBKsji6xdCLgNCwGpnb90zEuT6Tag+P9xklRksnybcrd9gb2H7SKxXwyWw5YDuUPfFb1RkeULZ33A/m9YaFWZgtcjXqlmoTblrxzt++EI03WXrQ8EGD2BojcELGO+TGs4BG6gSSGWzSVmk19H+h0aZeJmFhNwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yUe5NJ02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yUe5NJ02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEF11F000E9;
	Mon, 17 Aug 2026 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786969511;
	bh=zJgciypaIekWvrJWhT0NR4N3XLesif/aajFuco+h8Bs=;
	h=Subject:To:Cc:From:Date;
	b=yUe5NJ02JyLb95uoVWDGk1iFDIw2EF3mdCfnH6s0KUw+XZIrKg4vO36OwnfhMBYwN
	 3CapKb5Guu7XFwnvA50k/Z75u0gYClRTo0FIY+E8BaBjxcOill2CnBX58f9MK3oWoY
	 4ZXAlwNqVwNsgYclZwDUVb/PhFERYL/xPBiBc0nI=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: enable THRI before filling TX FIFO" failed to apply to 6.1-stable tree
To: luca.fresi@bithiatec.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:24:55 +0200
Message-ID: <2026081755-unbaked-recycled-24ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 246ac114f485c2affb454240f3ea4fabfce22456
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081755-unbaked-recycled-24ab@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

