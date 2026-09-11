Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F046AA60;
	Fri, 11 Sep 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117442; cv=none; b=F9twQhDAelazDVAoAvxVBV5aEWDi8aHJtryrHOIFnjyRGZFWxehgD9yL34SbpbK8Y15d3pqPVhv9Ch38cdEroxYtjIh2Dr42b/rmhHDDpiLQdaM9Lxorp5FKfJc/rclV3q0HYdy5OXTCHn457Hb784wzFTpqE0XQdMPnfua/O44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117442; c=relaxed/simple;
	bh=lNjmOHs8pzsPJf0VdoL+TcjSADRpsjZMOcD2mAojPpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KThIermS1mv1A8/3/xPK7tTLGdoRdspyu66uvFh/ZL+iawgevIOxhGm1AEf6ihXyDxmIvvfSr1UsdPQUpXKQNwQegP8pVd7B7bgAL3CmDtv1czjtreOi24oRe+/YnTLo2tEe7TrQcv/4ApRRNtfeWZvIOf1z/pw5eFHEp+9pDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brsAsKIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brsAsKIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065181F0089B;
	Fri, 11 Sep 2026 09:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117441;
	bh=klF/PE1ko1aKMbg1BBuWxUKkszmi+wLpekR9vFZbxWs=;
	h=From:To:Cc:Subject:Date;
	b=brsAsKIpkDyv1rqHapDmi4WnTHo/NZMmf0sW0oprS2YxlKrnBn/q+9eSBlxGWQXLj
	 6sBukAr8u2yUQcGFAA2hTV9Or5bK5CLbE3kOJx2v1DYq+MivRouV6YevbfbfWj3Ktg
	 ZpzZ3lRNO0Ti3Y0g2VY0u1QUbp3I6XOHWRumgdZsJN8aDQwJWqgnwzjkdz5hWqWo65
	 B/75xHRdXdQACovjAs7/z93Fm9rH26eJ/Gn31jT299Jy30hbCj7iRTbizrp0GJYYYC
	 xD4NkCvN1qA6FBT5CK2ko8y6/UL+a/8qDWhM5K9d0W4EvXbRjLQjLIzR9F8SOWcHDH
	 ZhCgPnt5b9rRA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4xAs-000000032Gg-1oSn;
	Fri, 11 Sep 2026 11:03:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] tty: amiserial: fix broken TIOCMIWAIT
Date: Fri, 11 Sep 2026 11:01:32 +0200
Message-ID: <20260911090132.723531-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A change replacing interruptible_sleep_on() inadvertently broke the
TIOCMIWAIT implementation which now immediately returns -EIO (unless
there is a racing modem status update).

Replace the old hangup (and signal) detection with a check for the
TTY_IO_ERROR flag which is set on hangup.

Fixes: 591cee0a3563 ("tty/amiserial: avoid interruptible_sleep_on")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/20260910132029.D80801F00898@smtp.kernel.org
Cc: stable@vger.kernel.org	# 3.14
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/amiserial.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 28af0fd98181..60f6060b893d 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1138,11 +1138,6 @@ static int rs_ioctl(struct tty_struct *tty,
 				local_irq_save(flags);
 				cnow = info->icount; /* atomic copy */
 				local_irq_restore(flags);
-				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr && 
-				    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
-					ret = -EIO; /* no change => error */
-					break;
-				}
 				if ( ((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
 				     ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
 				     ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
@@ -1150,6 +1145,10 @@ static int rs_ioctl(struct tty_struct *tty,
 					ret = 0;
 					break;
 				}
+				if (tty_io_error(tty)) {
+					ret = -EIO;
+					break;
+				}
 				schedule();
 				/* see if a signal did it */
 				if (signal_pending(current)) {
-- 
2.55.0

