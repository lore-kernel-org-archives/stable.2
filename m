Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046959;
	b=nnOmnAqYcdVIeg1TVNhB9w9NJm/A7wg0Vm89wTpPCSuwu8qSPdq13fUasPUWKh4r+Sz+
	 MeeXNcIff54WEAt6ryq4GDEWuR2wjrSzcYblkK+2/kknhfzQpyTp3F9m/yFc2JRaUP/Ux
	 Kkp0hjgMJnoPcrXEIDTKH3F3vM/vetWsrfxngO+HEIyRsEjaCyAfYoLvdxLCShGYDvK1f
	 PXMpJXq/IIG3vuCuPspEDonDftHILLRjH1b05Ud4kNcQVasBZofdMy6Fvl1glNYrlXGD5
	 QkWQN6Q6u7kJ9drPlbkpbbd2WXe8cF3T4tYdw3EyuEf+jwKaUaOjwkhjLqWl4bf8hxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046959;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wy29YiR7et4dadusrMMGpQqWLBRbjK0nxbisrQYykMI=;
	b=r6zK09i1zjFkVDiN6cCU5UnjqDkXOQx5vG92i0HFo25sk5FNa1bY2196p/JHa+0LGug5
	 ldO9zqYsDD7TZgUFn/drsMpU30BJEFUrcJh18dqzNSvl0EudZPtuohQSW2vZCY1KMN3Lc
	 VVjsLOH68hCOG61YcAkSDK/6Npb0hlliPZ/Jqq1UafoDq/iY1jJbbwYf+PsQYaNNmmgrb
	 DbM7hCI6PWiwrsBBZluVJuaVhWUeaTOJFZ0QF8jNfAhkO8ImtRHTahls8GrHp8A9zjid5
	 8Z9rjt7eD7JTTqxFo4nNvrgV/7UBPQyL3Wuzt48wLtBO8OkJb8YMRkFKlk9iRzMhYtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nfn9Xwtq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19635606A8D4
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nfn9Xwtq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1B61F0089F;
	Sat,  7 Nov 2026 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046959;
	bh=wy29YiR7et4dadusrMMGpQqWLBRbjK0nxbisrQYykMI=;
	h=From:To:Cc:Subject:Date;
	b=Nfn9XwtqN2VifQ5hbq1x8/anc5OndbnnaQ1Hghxowq+xBTqMyccc9KQo9VbRVQ9Zf
	 GYEPyItEE0ac54YiJkpshasQlJtTLYuhHBU9MbYo6KhPXMogNyL9j4AZyxes69L2tr
	 k0ZiBWKWyRgqqnP0cAfVIfMMb7MgwPa9r+glHaiLLyhONsjmjLJ/mwM29xs1/DPX3D
	 K4x1WX5d9Eu73rdtrdLMqW/mefogFyqG1yod7ivTLaTGf/eD1FUkHw++mjvW72hqfB
	 nE3vBikw71Veki4TjWyztPfYiVMh6tLF5N1JAqKYerKjmrTTgCKyQOITijyH7bgUo6
	 L/6yFZP4DfdRA==
From: Sasha Levin <sashal@kernel.org>
To: nb@tipi-net.de,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: amba-pl011: keep transmitter enabled when disabling RS485" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:37 -0500
Message-ID: <20261107052237-failed-6.12-97f85204275a@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 97f85204275ae4d7fb530e451f3acc65c1ec1155
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052237-failed-6.12-97f85204275a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 97f85204275ae4d7fb530e451f3acc65c1ec1155 Mon Sep 17 00:00:00 2001
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 12 Oct 2026 16:23:50 +0200
Subject: [PATCH] serial: amba-pl011: keep transmitter enabled when disabling
 RS485

Disabling RS485 on an open port calls pl011_rs485_tx_stop(), which
turns off the transmitter. Only the RS485 TX path turns it back on, so
any later output stays queued and tcdrain() hangs until the port is
closed.

pl011_rs485_tx_stop() also checks only the hardware FIFO. If a DMA
transfer has started but has not filled the FIFO yet, the transmitter
is turned off under the transfer and the DMA channel never recovers.

When leaving RS485 mode, cancel pending deferred starts and stops, leave
the transmitter enabled and start any TX that was still waiting for
delay_rts_before_send.

Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
Cc: stable@kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Link: https://patch.msgid.link/20261012-fix-pl011-rs485-txe-v2-1-e9bf7d218389@tipi-net.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/amba-pl011.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cd8cbc9672815..3edd83ec73de1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2398,8 +2398,31 @@ static int pl011_rs485_config(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
-	if (port->rs485.flags & SER_RS485_ENABLED)
+	if ((port->rs485.flags & SER_RS485_ENABLED) &&
+	    !(rs485->flags & SER_RS485_ENABLED)) {
+		bool tx_pending = uap->rs485_tx_state == WAIT_AFTER_RTS;
+		u32 cr = pl011_read(uap, REG_CR);
+
+		/*
+		 * Leaving RS485 mode, which only enables the transmitter while
+		 * sending. Don't stop it, as that stalls a DMA transfer still
+		 * in flight. Drop pending deferred starts and stops and keep
+		 * it enabled.
+		 */
+		hrtimer_try_to_cancel(&uap->trigger_start_tx);
+		hrtimer_try_to_cancel(&uap->trigger_stop_tx);
+		uap->rs485_tx_state = OFF;
+
+		cr |= UART011_CR_TXE | UART011_CR_RXE;
+		pl011_write(cr, uap, REG_CR);
+
+		/* Start TX that was still waiting for delay_rts_before_send */
+		if (tx_pending && !uart_tx_stopped(port) &&
+		    !pl011_dma_tx_start(uap))
+			pl011_start_tx_pio(uap);
+	} else if (port->rs485.flags & SER_RS485_ENABLED) {
 		pl011_rs485_tx_stop(uap);
+	}
 
 	/* Make sure auto RTS is disabled */
 	if (rs485->flags & SER_RS485_ENABLED) {
-- 
2.53.0




