Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE02226E718
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748327; cv=none; b=EiJ+NlqQtTsiB57HtVxuHFgNC0RFJZ5iHYVRwhVjx3eR6EqESqTcfW9JMmzIKwT5nG44aEZzfOMT2ReOAr1C9Wyi32x7kZG7unk20LT/4Pc2JE2SXXF9hiNUwQ1PPuiTZlzFBKC17Touw10EoRjfpht5FVm/vf9+ADOhmVMWBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748327; c=relaxed/simple;
	bh=K4mwliKLOm5ukUOiB6ipF66po6GdIDxmuqHWr2rz/6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZKLrBvHNQTpYyAAgKGN2M3qAud1JRHfdtaoYAwwaiYTj2otC1fAoTdtzwO+WICce5kAWC9vEJd+FT8o6QukZz0KFwk+9rGlSSrlNAtzW1OP3LLnqM0s5m4xvHFv7JQiKSWqjfyDhDHPOk8HfByIHmU+bxWgygYqi4WGPjfLwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtUTPDzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtUTPDzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD22D1F00899;
	Sat,  6 Jun 2026 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748326;
	bh=R2T1cl3EsQd9DzsKXYyi7gh4FDgBJKqi9eF3rX/gjvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RtUTPDzZchygWwJuugqdFJDTqEg3zOi09XKNQaA3u+DTOieuVnl9grpuBfpqzYUCy
	 T1Ioib6wrQNeDUAWVQ4kenFoYXFcDKlidkPPgYhJrKkKjoR0jRRbl2jMC+hd1A5fzD
	 RpxSTcdG9CjyLWArEJoGidHMLB0BjHl0Nd9Qy5X/JbYO/8ZHyoqMkRt+dvDHxYKyH0
	 b5SN99tbK6AcUOkUKQy2MAF+Tn7uxV1ViZpwpylfEwE96lZ2N+OFs91+sXsjpS/PaA
	 Q0PfcJfyAQEuW1bvgrLQ4rZ12Zs5yu4MoUDCRzJSj/KWebZj0Kq21FCDcdi56WScjn
	 Iu4fBiiKb1ltw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] serial: altera_jtaguart: handle uart_add_one_port() failures
Date: Sat,  6 Jun 2026 08:18:43 -0400
Message-ID: <20260606121843.2850594-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606121843.2850594-1-sashal@kernel.org>
References: <2026060422-eskimo-docile-6e8f@gregkh>
 <20260606121843.2850594-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit ea66be25f0e934f49d24cd0c5845d13cdba3520b ]

altera_jtaguart_probe() maps the register window before registering the
UART port, but it ignores failures from uart_add_one_port(). If port
registration fails, probe still returns success and the mapping remains
live until a later remove path that is not part of probe failure cleanup.

Return the uart_add_one_port() error and unmap the register window on
that failure path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 5bcd601049c6 ("serial: Add driver for the Altera JTAG UART")
Cc: stable <stable@kernel.org>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260512065837.79528-1-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/altera_jtaguart.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 37bffe406b18ea..8d2364787a4f76 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -421,6 +421,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	struct resource *res_mem;
 	int i = pdev->id;
 	int irq;
+	int ret;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -460,7 +461,11 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = &pdev->dev;
 
-	uart_add_one_port(&altera_jtaguart_driver, port);
+	ret = uart_add_one_port(&altera_jtaguart_driver, port);
+	if (ret) {
+		iounmap(port->membase);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.53.0

