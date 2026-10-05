Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5241A575
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238383; cv=none; b=LgQQgbMU1BHezunOOOXeef2wkFAl0PNC6AdOpKJiTNEfWE6qhUcBsCDMj8KQ6pP8ERkonHgZSIWIZz+52a+IfGY6K9DCXqfFOYLLMbDyhhfdLyHOOrnA/tSte1UUP90BlvmVCPgKHbQnmaA1rQVTTZ7NNnLd5y/yAt73zPJSAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238383; c=relaxed/simple;
	bh=WT3Otilcc8TmFA7Lp+csOtJFEQLR2pZbs69v/hRnQbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjwZOTK0ERhPRsxnIsxYiJADMx2cep+HTVs2J/TZ56cCTosHXKDbPKy0ovD3FbeOJoJzSaOHZo7T3DccJPFx1qZ7WOLkXN8iY2b2w2EdGjY+9wEshXz7eXVUN9M2YG+dmm/JOQB6pgiqiVBkc+kGSj7UFxSYLqlEAHUEeQm+HWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz7ZPu6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz7ZPu6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7741F0089B;
	Mon,  5 Oct 2026 22:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238382;
	bh=6itm+XDq8c0jbVjM18ZQld3oNhHVxFi8j8RQKSWfNWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qz7ZPu6UCIF7auwCS5pFO89qY75sW+MghwqOA7+mH/H8XTQKFjjunVcdey3gqsLoR
	 YqvDiHL87U2nWl1k6jeXyUoMd2a3ll3/Djr5dXfvK0CTo2U9AE0NezpoI3ai1ahF+S
	 ZdtWO1z/tUzaE1adQFTBz3kJ5n6DA3d4vw8X6N7v6LXreO2FwQgTMhcn0tmB5yblDh
	 nTeWIIvrHjBd9aXWXWBOcbWvSiELJ5TD0T1dgNFHV0fCRbfyuqKTKTu84tPVJj6+LW
	 i6pZAdnM0cob9RMZhVEX5wyCw+0D4Ti4mLMdiXBKopmCNk4CJHyig3+v2YJBeWetJn
	 aPvvUtBlpINsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] serial: ma35d1: Fix clock reference leak in ma35d1serial_probe()
Date: Mon,  5 Oct 2026 18:12:56 -0400
Message-ID: <20261005221225.3435549-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005221225.3435549-1-sashal@kernel.org>
References: <2026100517-epic-chomp-5963@gregkh>
 <20261005221225.3435549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 98401cf912fe8a081ef8e500c421b6d957b55a99 ]

of_clk_get() returns a clock with a reference that has to be released
with clk_put(). ma35d1serial_probe() never does that, so the reference
is leaked on the probe error paths and also when the port is removed.

Release it on the error paths and in ma35d1serial_remove().

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Cc: stable@kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917155650.2161274-1-vulab@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/ma35d1_serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index f6f832ba7204d..225feb5868e85 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -725,7 +725,7 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(up->clk);
 	if (ret)
-		goto err_iounmap;
+		goto err_put_clk;
 
 	if (up->port.line != 0)
 		up->port.uartclk = clk_get_rate(up->clk);
@@ -752,6 +752,9 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 err_clk_disable:
 	clk_disable_unprepare(up->clk);
 
+err_put_clk:
+	clk_put(up->clk);
+
 err_iounmap:
 	iounmap(up->port.membase);
 	return ret;
@@ -767,6 +770,7 @@ static void ma35d1serial_remove(struct platform_device *dev)
 
 	uart_remove_one_port(&ma35d1serial_reg, port);
 	clk_disable_unprepare(up->clk);
+	clk_put(up->clk);
 }
 
 static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)
-- 
2.53.0

