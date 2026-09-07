Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC941A909;
	Mon,  7 Sep 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763973; cv=none; b=YeAaMMp5rsmLZvlBkwuh0mWDipi6plY4msbXbPvQCWhDjPmWsnxrFMyYH99nSe04A8BuHnFs0JiP3oSlOzPKRNbB4Ho/VWBfiEI17IvMt4O3gVQJL2ROUZko+mnqMxWRXNU1nnRzG6CQ1/ORQhxx5bNckciOK0eULeuW+WlJf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763973; c=relaxed/simple;
	bh=0lBdv2+luebBNSp6vspKPBMwE0i/9ESDBR/xiCjDxhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuHkJ0IG1NmAbDGyjbUdkrQ6YFV+kU29d0Xd2Foec9AQA874fDwa5WKHRBpuZWIcVmkyeMBhl1H/6+l3x3B9hpDuDTjm/fzgTyUex6v1wJDF4cFREvCcw9FiglBmX2EwB0JeqNgI6JTGrd6JUZ/xoUa9boahUk6zjduOVJ8gbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj7lbqV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj7lbqV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3911F00A3A;
	Mon,  7 Sep 2026 06:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763971;
	bh=VxBiuUgqkS0SQe1yE8BmZbODGbM8ARODThXC3vmkcs4=;
	h=From:To:Cc:Subject:Date;
	b=Wj7lbqV2f5m5vcdGp1o/ZIbYhNwphoLDejYnSSjdGk/mJoxmjotZ65LhTddlzLTJ+
	 8MbQDJctsCYpgeMaB5wpqCUFGwT02CfmVoOi7Eh9HMfhmgNGCF0jJDaOQnmrBHGZCb
	 UPxm/ESWblBgpPwGTJ9R6jDehikMZn6By4sUVGo+g/RtkoGY8myZ1G0BAYK9o8veFF
	 dxkuqHmoRD+5KXl5kcILeLayRnfT4tlPY1zoxRgCDbHRL8kXGEF+fA6APe4AeNNWdR
	 4rAzb4xFT7uRlOvxm2ag//u71AMQdHuZSQXzhY4lfgzQKU3VJQ7N/Doa7hb0JygElR
	 1GM+yxVvFTu0g==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3TDl-00000000QEy-0zwA;
	Mon, 07 Sep 2026 08:52:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net] net: hso: fix TIOCMIWAIT race
Date: Mon,  7 Sep 2026 08:52:35 +0200
Message-ID: <20260907065235.100848-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The task state must be updated before checking the wakeup condition to
avoid missing a racing modem status update.

Fixes: 542f54823614 ("tty: Modem functions for the HSO driver")
Cc: stable@vger.kernel.org	# 2.6.29
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/usb/hso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index c1aec67688ae..71caa3764b23 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1547,10 +1547,10 @@ hso_wait_modem_status(struct hso_serial *serial, unsigned long arg)
 	spin_unlock_irq(&serial->serial_lock);
 	add_wait_queue(&tiocmget->waitq, &wait);
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock_irq(&serial->serial_lock);
 		memcpy(&cnow, &tiocmget->icount, sizeof(struct uart_icount));
 		spin_unlock_irq(&serial->serial_lock);
-		set_current_state(TASK_INTERRUPTIBLE);
 		if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
 		    ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
 		    ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd))) {
-- 
2.55.0

