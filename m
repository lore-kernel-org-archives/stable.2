Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229796;
	b=HaFhvcAInXKj7RJr8UBkmIRYLZTBciw6x2bD93gPj29VOs4ZSi1VatuZPQw3KMNugADJ
	 V6weKhAbmWOdPBCtJ+PEGM69dAGazXUoehTybN7jHJ9iIKOY7YfVvfK1Q8M2C3GXRWysX
	 y7VGe5/vzXkq7OsGyBYA5GSKL2rmkWGMDTPRraDwum/eOQf1jC5YMYipzE801s0lcct3j
	 /wGnYJ3rRROo+Qiz1voIxRo89IsaHOGdicwzcoM7cKUJpHsxr5rRTyukvdw8bGj2JwajQ
	 C/Yzq3zLNpxCF3GJMxholvEk3FSjexwkJdyD65iMdSfCwCxRXvI2AsMMiFtDVJOn0oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229796;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=f+8E0s5Zue5uHtaK5KTCTkEmSgDAkRA+JcPbsxori10=;
	b=2LRTziv6hkRFErjlqaVpg+YTtPUjmrsPG+mBpk4fAxOiJ3sSwoQMWjOxMXWi8vtbqiPn
	 SMcUh4VSfDDDl/vz214sSEmybvbj+rJb4Fr+pl147f5V6wrOHrQS4CyewVdsD+9t9lHQf
	 cQatvI7QET7IfSeR9uWH82ZKDwiAdJ25Hv10j1tVaiPhtZeMsO2/5GcR0sLyo5CUFP8vd
	 ZU/H1JO+wLX1Y7zz0S0l0OjN7/sUlfByWb/ykU7Clf+5juqj+kZPfcklnYNugWMVwf6Ey
	 8OYy4Uugn5t5loa0N+5t1oYSbMUiXz/iDxgWjLmBwJQNIO/jYnE6QceALCFun8+vO5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=N6KnvR8W;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C5606A33B;
	Mon,  9 Nov 2026 13:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A5C5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=N6KnvR8W
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54050f33f;
	Mon, 9 Nov 2026 21:09:44 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] serial: sccnxp: Fix potential stale ports after IRQ request failure
Date: Mon,  9 Nov 2026 21:09:43 +0800
Message-ID: <20261109-21df1234b2-serial-sccnxp@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa1c06dd09103a1kunmf9615dd512147e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0JMVhlDSBhLH0sYSk1NT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=N6KnvR8Wd9zieM82mRNyS0/wFuf4dZPUy7MvpF1sjobIDmh15WZuMPFqUd3UchKURok0pF1gvN69pohNyfrLOrYJx+UVfef6Vh3V1fdkkGOgGWIPpbkocKFL8Xm7DTZBHhlLFNaGrxSvrNZqyeqxWNrI1XBR+nGkpXhbvw5vUc4=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=f+8E0s5Zue5uHtaK5KTCTkEmSgDAkRA+JcPbsxori10=;
	h=date:mime-version:subject:message-id:from;

The ports are registered before the interrupt is requested. If that
request fails, unregistering the UART driver frees its state array
while the registered ports still refer to it.

Check each port registration and remove the ports already registered
before unwinding the UART driver on either failure path.

This issue was found by our static analysis tool under development.

Fixes: 1d65c0b12656 ("serial: New serial driver SCCNXP")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/tty/serial/sccnxp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index cb31e3aceb62..502f8ebe265b 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -989,7 +989,9 @@ static int sccnxp_probe(struct platform_device *pdev)
 		s->port[i].uartclk	= uartclk;
 		s->port[i].ops		= &sccnxp_ops;
 		s->port[i].has_sysrq = IS_ENABLED(CONFIG_SERIAL_SCCNXP_CONSOLE);
-		uart_add_one_port(&s->uart, &s->port[i]);
+		ret = uart_add_one_port(&s->uart, &s->port[i]);
+		if (ret)
+			goto err_remove_ports;
 		/* Set direction to input */
 		if (s->chip->flags & SCCNXP_HAVE_IO)
 			sccnxp_set_bit(&s->port[i], DIR_OP, 0);
@@ -1016,6 +1018,10 @@ static int sccnxp_probe(struct platform_device *pdev)
 		return 0;
 	}
 
+err_remove_ports:
+	while (i--)
+		uart_remove_one_port(&s->uart, &s->port[i]);
+
 	uart_unregister_driver(&s->uart);
 err_out:
 	if (!IS_ERR(s->regulator))
-- 
2.43.0

