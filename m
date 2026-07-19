Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFC3ACA7A
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477319; cv=none; b=YBWh12rZkLZOyHFPSNsxVyi/d4oy8NCw433ddaw65BbD0SivHdLSgQGrelVqVM1x9P+jDNucFWrg2VmwPsLOQr0ijMSIjVg6HRpDmU7mrq9v+U/23v2XMJtvd/i/ahFntNTrr+BkkUnJeTyul7AnILvmv+s0zckClMC38JBMa1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477319; c=relaxed/simple;
	bh=8sdnQwIMdO7CwPShC74pX/gtmmBu9zvdCtaHEui32XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVIcZECa3yvEZ31GbIZ9V7rT3j2u4wC3S1YOdWIj7GvWI5hHwx3TYNLN9mLHIobU3Z+nhV8IDnekRdRPP2p4lJFWnwXmaVXbbLi4DmsFhX4Xm4BZepZgoTB5coW6pb8aerGa/XMYb4Vl+qSinyyhRkNSxKBX8KaLflcMSVnBtII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW/jTCV2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW/jTCV2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49553515a8bso10585635e9.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477316; x=1785082116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SUAt/6zWUy8VxjfuD7LmHF2gwOSZYdtNqcx/e+ByoY=;
        b=DW/jTCV2S3HFHpdNmnAIJkQh4qaLZdmdU7SPXoSzy60dW+KfNOWheL9rwc3lDTc0L5
         P57PNBce04KyoJbgkW3kjcLplQzQjFE8DeeCcsVHOZkdPns002m6eXUd/Rd2tTavOUeU
         mIvzvcqnfx+AtJqWdSINxguTSHdSkDzOPmVFYa9VPHiOcI6z3o2ee2Jyqb6ZoA5/vgPl
         GgKFAEQgRulpwAzR7ndpymy3x9G26foYf2l810mq8vGKll24roFyrqm0BVBtKiKsd0I0
         T7QC/Z025fvlRKC1tm8Rm96SritzUqkxV6SynBuIdgcfA9gYVC5qeriPt1NWwNMROyfC
         xN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477316; x=1785082116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SUAt/6zWUy8VxjfuD7LmHF2gwOSZYdtNqcx/e+ByoY=;
        b=LZOC7/HnwB+A7o2zExB40m7NewW136+mLCUMgQg7b35QsNe6yg8vtmQYy7goztJbVz
         m/yU+ERe9+OydfbRyGyraehqA1G8UOwVe9AkyNNc3jt4gI6C5/Pe3sxEf83Azo0HHaIY
         knrvF1GPP1CqDlby4JHHyDLkTOohCm4zBWzMNLBjxd9cqZBnZh+uWrFAE/nzynf7Vf0u
         4ufyJtQbh41xfl1fQlL3vLhGeDVJ1zBQnWeCkRWgfnWO2OREW3JJCQEkzQdKl9VLX0YK
         adVChrFdC3ILeFVY8isj2lukXAQ94vVbhBOADm23hq1FHhHf6wENuxoV8F3L68X5fP14
         n41A==
X-Forwarded-Encrypted: i=1; AHgh+Rr1K++F4G2TkomkPTKxBelLgXx71vnZ1vjFIxc9qDd7HU8zP/jb+TgZUygInFWJ8O0FkRIVPBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOxkOoBvG8iVvd9NyBC68f+ZVhNb/RJRajnDjnicl0H0meiAa
	764dNqObnn8Fhjsg3MAe+4Hdu3LWWwhfsCSfIyJars97JXCnA38nkCJU
X-Gm-Gg: AfdE7ckJVv+KGOT5CrUme228Zk4SCZcrZY09cHciXHTAlwLDfHxZc/VuLdHeOI4ZIsv
	yMqQ/oPNb7VZiFr5UUcbtwb25XI4g7QkePByPmGC1H/LF8c0MalnoM1aUBk8QSsYTiXY0kpc+TM
	Orcs8dzaEfo46HUlXG7O9bGzaYviQ9vdvm9lhQtQuIvqh+QBkFyX/OUf1iAMg+JDpKFyI+MXgiY
	qvjFguAhaclzNwKI2Fa+u1L8GupJGevbGomD3XEn37Pjv9nZMYf9rY0OSTW2RR/MzpTW8fOOYrB
	xFpe7OdPcgjrqFh0Ofo/A6OHhSwxyVX3xzactPG//VpdniKoOT016dXyIpiaQxjua/NOv+f0A8L
	eJQNvORC+tt5Cz9wE0mgTKR2eOIjSKja38XJm8ZeUGPJabSjakaYtxr2SHqbd8cYsPc5bYMSw9W
	LfsD+JzmQ1aQD9nJ++yPtOTpCJQZebPsW/Rha7fC5/YoXXGYmzUGpnIZOwp99YHkfCXe36p/Y3X
	LpO9JLByf453qH9T0WcxbXsqCII2KgHXnRhuCDfE/wmG/B1ZgE6IVKYFFJyDp96Euc2bnrtvMPN
	UN4BrQKrjQ==
X-Received: by 2002:a05:600c:4504:b0:493:eb71:5cc6 with SMTP id 5b1f17b1804b1-4954a40bbc8mr113521195e9.27.1784477315903;
        Sun, 19 Jul 2026 09:08:35 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm223826745e9.12.2026.07.19.09.08.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 09:08:35 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4] serial: imx: clear imx_uart_ports[] entry on probe failure and removal
Date: Sun, 19 Jul 2026 18:08:12 +0200
Message-Id: <20260719160812.35407-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719160812.35407-1-kmehltretter@gmail.com>
References: <20260719160812.35407-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_uart_probe() stores the port in imx_uart_ports[] before calling
uart_add_one_port() because console setup during that call uses the
table. The entry remains set if uart_add_one_port() fails.
imx_uart_remove() also leaves it set after uart_remove_one_port().

sport is devm-allocated, so a failed probe or unbind frees it while
imx_uart_ports[] still points to it. A later sibling probe can register
the shared console with the old preferred index and dereference the
stale entry in imx_uart_console_setup().

Reproduced on qemu's mcimx6ul-evk by unbinding a sibling UART, unbinding
the console UART and rebinding the sibling:

  BUG: KASAN: slab-use-after-free in imx_uart_console_setup+0xd0/0x3d8
  Read of size 4 at addr c49ad9d4 by task init/1
  Call trace:
   ...
   imx_uart_console_setup from try_enable_preferred_console+0x158/0x1f8
   try_enable_preferred_console from register_console+0x1cc/0x80c
   register_console from serial_core_register_port+0xe58/0xeb0
   ...
  Freed by task 1:
   ...
   devres_release_all+0x100/0x18c
   device_unbind_cleanup+0x38/0xdc
   device_release_driver_internal+0x230/0x288
   unbind_store+0x64/0xa8
   ...

The entry must remain visible while uart_add_one_port() and
uart_remove_one_port() run. Clear it when adding the port fails and
after removing the port. Save the line index before removal because the
uart_port is no longer valid afterward.

The probe-failure cleanup relies on the preceding serial-core change
"serial: core: do fallible allocations before the console can be
registered", which ensures that uart_add_one_port() cannot fail after
registering the console. For complete coverage, both changes should be
backported together.

Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 251a50c8aa38..617c35772056 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2637,6 +2637,8 @@ static int imx_uart_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sport);
 
 	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	if (ret)
+		imx_uart_ports[sport->port.line] = NULL;
 
 err_clk:
 	clk_disable_unprepare(sport->clk_ipg);
@@ -2647,8 +2649,10 @@ static int imx_uart_probe(struct platform_device *pdev)
 static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	unsigned int line = sport->port.line;
 
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[line] = NULL;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.53.0
