Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049523;
	b=bR4zpjl0p5IiUd6NEF6z/hmir2WRwbyfXv79Cy4EEaHIHImafN+dak2O3AX4e8yT1jXT
	 SiwKaesaiVsDatfcfjLeUekEGaFT7z03yf8H180h3zzI0V9Rio2r1EmkdyWubgY10yTOi
	 +7iF55Q7s51P/CqYMKauoE1m8aYMZkagQ/0yKTiRYQtABwmqTcsODKUK8bB/YlKHczZT/
	 ocjbwt+T4Q7CWlbCYRp+calaUEdWWZDQz89bfYW4VR1ieETG7r2Of3jyOf43th5d9Q0RX
	 P9dKy2SjQhdAF0v1BdxFgLarnHnhlgMc8n0QePTXp/U+IvXOwD//r6wDXo4CJkDpN8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049523;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5CG/qY0128dAEnCVftLslGFkc7ZrW7d34X/6mh0KwJE=;
	b=Y7cJ0uRzdi0NUPc+aVCq9Vrmr7fzxJpYGUICATw35Wh2Wp0nAQCz/KCZLlesXZyXV79z
	 GhoU8mMiQS7O5ORIwqbTsbXvtG67zglxrUAT3MGXSPooD7hmcIgwkQ1ZfzDZrQnHEydyo
	 zLB4rmgvhbKlzA/UyExdbF+oA6ubX7EMtwqcU/9DOrt1gIj8bJAcaZr4EWebziJWeGp1O
	 klB29m5+R1cY934aMiGjrKOhjMkNLVwhOV58RBsqJ4akwyci8qfeFMD+3OmfPOHoZYMZQ
	 dDn0o44gTeYfzZDqJtwgkIts6Nxn8pdqc8OJWXuL0a7O6ZUdGFRAshqldw/HeYKT+5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LufHzRs6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB32606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LufHzRs6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5DD1F0089F;
	Sat,  7 Nov 2026 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049523;
	bh=5CG/qY0128dAEnCVftLslGFkc7ZrW7d34X/6mh0KwJE=;
	h=From:To:Cc:Subject:Date;
	b=LufHzRs6Z9IRWPV0Ewk3ScmFbr997AM4pjZlPNmflhS9eQKDY201VOkoaf5BjMaZu
	 h7IrQAnEitBcFhBm7DrXKyglVLogohC4c3+anbeafo0rhoxYsU9LjAuqXO8+upiRKU
	 el2K7ADtXStA7zXeVJ4F0GUxm341Y0EHKgxa8Lo9llZaUGrMklKoJmbHj4AATcvDE3
	 OwRceCYttYVBAOWnL3Rp4K/Eh9Cu06VlmciiQxKmuT1PIH+Nfp11pFy5ppKlDe+ntD
	 B4rYiAloGtcPPDYL/eWdQnAZ4TRU4Soa8eL1a4akeBWDurG3bnTeoP1EuBN9A3QlH8
	 6PCwbqT/sEUSQ==
From: Sasha Levin <sashal@kernel.org>
To: martin.fuzzey@flowbird.group,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix data corruption due to unexpected xon/xoff" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:21 -0500
Message-ID: <20261107060521-failed-5.15-8bb50e95c0ab@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8bb50e95c0abd44607bc60a43032c1dbf7470d5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060521-failed-5.15-8bb50e95c0ab@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8bb50e95c0abd44607bc60a43032c1dbf7470d5a Mon Sep 17 00:00:00 2001
From: Martin Fuzzey <martin.fuzzey@flowbird.group>
Date: Thu, 1 Oct 2026 10:05:35 +0000
Subject: [PATCH] serial: sc16is7xx: fix data corruption due to unexpected
 xon/xoff

The hardware supports automatically sending XON/OFF based on the
FIFO status and that is already implemented by the driver.
However that capability was not announced with the UPF_SOFT_FLOW bit.

When the port is opened with the default of XON enabled the driver
configures that in the hardware.
If userspace does not want XON/OFF (which is normally the case) it will
use TCSETS to disactivate it. However the serial core optimises this
to only notify the driver if someting imporant has changed, and for
XON/XOFF thit is only if the  driver declares UPF_SOFT_FLOW.

So we end up with unwanted XON/XOFF in the data stream.

The problem only occurs if nothing else needed to be set by termios,
ie if the user space requested values are the same as the default values,
except for XON/XOFF.
Since the default speed is 9600 this means that the problem only occurs
when requesting 9600, otherwise the call to the driver will be made to
change the speed, and that will also clear the XON/XOFF.
As 9600 is quite rare these days that probably explains why this hasn't
already been seen.

It also only occurs on the first port open after boot since the subsequent
opens will use the "logical state" set by TCSETS but not communicated to
the driver the first time.

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@kernel.org
Link: https://patch.msgid.link/20261001100534.1225894-1-martin.fuzzey@flowbird.group
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 296079c16fdb9..7ddc8a38adab4 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1516,7 +1516,7 @@ static int sc16is7xx_setup_channel(struct sc16is7xx_one *one, int i,
 	/* Initialize port data */
 	port->type	= PORT_SC16IS7XX;
 	port->fifosize	= SC16IS7XX_FIFO_SIZE;
-	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY | UPF_SOFT_FLOW;
 	port->iotype	= UPIO_BUS;
 	port->rs485_config = sc16is7xx_config_rs485;
 	port->rs485_supported = sc16is7xx_rs485_supported;
-- 
2.53.0




