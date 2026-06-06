Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159981B4F09
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749128; cv=none; b=licTy7zhZbYA1l60jlsch1XWebZoYcARvVDM+DyMR6B937TMo7OVvZ6TxGiWLi4CNd32PjJkdfOwN56tgmrye5WoY+VlbhgkmiQjadVYl6O+8zZDkJPCDQ/9zkqMBa78p3Jv7e/DjSYBKy1OpqGovoR54e+gReecYSId5eILEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749128; c=relaxed/simple;
	bh=fdiEbtT9cZdPHACY0NrWJX6E0P/HJzF6nj3VlJ840EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3P9Rl1byKKI7tttSYgdsXvm4ZXLehmq8FXYlg+GsQ01L5jpf4MINI7l9KQ1w2h90O5X5A/h6n4142nkFTE5pEP1QneopdqmQZfzUpQPKJhgcYVx030ilSKYEA+GUZBsp8WOLtFXPR0rLdQ2DGzDucsMpojblCPsZvIzGM3JwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW1US92c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW1US92c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4332E1F00898;
	Sat,  6 Jun 2026 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749127;
	bh=mlpgq+C3UowHFncT0qRzWkzCyLimL6wGEtbL2YOJxKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VW1US92cW84GeIV88Os4KnPthDyoM+/NmQNoBbAJ82F6tMeh1SQRfPo36VD459f+a
	 3sQGOlVls32YOE320oR5OSnVpCT4JUscPPVPMBNV3CCzxWljiOC2fbEBMJManNe8gW
	 4gIri3qUgIZsRGAJaqU3hQeopTgfl1n2CvQhiP1fSBhBdovAaSyVDnymPxhtc4EiKf
	 7xeddAPhZ1QZ3wCzF91e42eG/8wIHGXZvab43lJhKcSR0EQSrggPoKL7MSV9t84cMA
	 JKDHo9a+EsNOwuWn2VpJP4YvKbH1IgRpfLGeBKQajbDFuGuVQ+NiYCD7WYU6w7WAmd
	 a3ZeUjYcOIIzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] serial: altera_jtaguart: handle uart_add_one_port() failures
Date: Sat,  6 Jun 2026 08:32:04 -0400
Message-ID: <20260606123204.2861133-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606123204.2861133-1-sashal@kernel.org>
References: <2026060423-confiding-sandpit-f19a@gregkh>
 <20260606123204.2861133-1-sashal@kernel.org>
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
index 749f4eadff3435..97209abc288a77 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -423,6 +423,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	struct resource *res_mem;
 	int i = pdev->id;
 	int irq;
+	int ret;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -462,7 +463,11 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
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

