Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410017;
	b=0F90fUmfTS+OdCU6kBMXJBeKwwQCUBH+R6s8SQu6TUc1KfSX+K3RqvgxJN1DnSiqLYcZ
	 ZYkGRN3NuRqXSOdM3jdhXv1m09ryA3ZKdfsqu8ixCf+eCRgmLMwmLeZv0N4ZBbapEDyik
	 GM+uRjw/Tt5VmZT8zRZAmTLVykhd7/tRE3dCPYfqP+wdMlLLzNwdz7BujGeZNVdV43bAY
	 +B2d2KJREoJt4xXGxCJKzSlJ2T0RacQ0GCzvXhr1882N5ZAhzKrZ6WpW4S/C3oWGbBLa9
	 Xohc1m2zAw3S6Qa/3yySO2TaE6bDGV4qDDo3kJr4WLrE98pgHlNvUpkdSNk18Po2m/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zYb0WkidDHC6eGU4L5F2cYPxa08q0h6+Ue0aC3KkESI=;
	b=IjqBLHKbxOgtgy5ZWCJUAkZYe+ta3/Wh4Dl25tH5fS0T9hH+bt0kD2g/wAMKR2ZOjpfx
	 cTCaUsM61hHKNUeD/qgB7j+zpfzzOybQUjNrWG8toQqqETXEjBZYp2exvDO1VnRhT0II+
	 7mv9Go/HKgYjKgjWEeLEhLtHqvMB1JaQvqTJ3krJ0Cxhvvce9MXdRUPE8wCCY+TL1p5OO
	 bQaWeXebmLhXogusL1kcq8X1hqKDbmKUkYrpyeBUXLm++Kp0DFuN3ame21LFhBUpGu/cW
	 wb0wX9y1zZWYuj+jgYkI0fOy0NXApJ0MacDUH6oFwMduYlbDePaIoBH+ixiWvuhAlhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0dePu8e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D7606A882
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0dePu8e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F0C1F00A05;
	Wed, 11 Nov 2026 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410016;
	bh=zYb0WkidDHC6eGU4L5F2cYPxa08q0h6+Ue0aC3KkESI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0dePu8eVssPtfMIi4kiDqu2lxKd3Q8xfyiO2VCYw+mq2V9bWAoGreqm0+D2QY9mr
	 OE8zXaG/BKyY6Kuo7CnyZtFQ2uPbzjNYDJ0DRbnqTnuFUySIw/632QY7d2pmhC5Ywo
	 ztHY/YTa6tPnZs41rcmm5JEXwbgIyNHOQzusDqrvgp2+4l6gDgJIBB9R7WzNGbt8qm
	 SjC+N3GxpIQUUH2q266LUC9mcRbfG6ub0TDx9DLUfvy/w5dMbv0ZHfvMYe8VJS0aG6
	 cL6Brr39F0vqOASR+nn3DNzPzKaLOhVxmzCiCvHp7IqL7184ej+7l0dIQHvRkQfUCY
	 Ajp7C9N1NG4Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] serial: amba-pl011: remove redundant code in rs485_config
Date: Wed, 11 Nov 2026 10:13:33 -0500
Message-ID: <20261111151313.2472393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060610-failed-5.15-97f85204275a@kernel.org>
References: <20261107060610-failed-5.15-97f85204275a@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lino Sanfilippo <LinoSanfilippo@gmx.de>

[ Upstream commit a9efa452486ed59b38f15c2287d3e7e129f6e7fc ]

In uart_set_rs485_config() the serial core already

- ensures that only one of both options RTS on send or RTS after send is
  set

- nullifies the padding field of the passed serial_rs485 struct

- clamps the RTS delays

- assigns the passed serial_rs485 struct to the uart port

So remove these tasks from the code of the drivers rs485_config() function
to avoid redundancy.

Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Link: https://lore.kernel.org/r/20220410104642.32195-3-LinoSanfilippo@gmx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 97f85204275a ("serial: amba-pl011: keep transmitter enabled when disabling RS485")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/amba-pl011.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index a5340c5e11b10..7b21907cd14dd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2241,25 +2241,11 @@ static int pl011_rs485_config(struct uart_port *port,
 	struct uart_amba_port *uap =
 		container_of(port, struct uart_amba_port, port);
 
-	/* pick sane settings if the user hasn't */
-	if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
-	    !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
-		rs485->flags |= SER_RS485_RTS_ON_SEND;
-		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
-	}
-	/* clamp the delays to [0, 100ms] */
-	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
-	rs485->delay_rts_after_send = min(rs485->delay_rts_after_send, 100U);
-	memset(rs485->padding, 0, sizeof(rs485->padding));
-
 	if (port->rs485.flags & SER_RS485_ENABLED)
 		pl011_rs485_tx_stop(uap);
 
-	/* Set new configuration */
-	port->rs485 = *rs485;
-
 	/* Make sure auto RTS is disabled */
-	if (port->rs485.flags & SER_RS485_ENABLED) {
+	if (rs485->flags & SER_RS485_ENABLED) {
 		u32 cr = pl011_read(uap, REG_CR);
 
 		cr &= ~UART011_CR_RTSEN;
-- 
2.53.0

