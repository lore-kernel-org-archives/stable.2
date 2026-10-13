Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195EB37A83D;
	Tue, 13 Oct 2026 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874142; cv=none; b=tKBPDmifBz7aHW7xGlaeft8cqaNUOZ0UG9cpJZrLIXvE1KAbU7mNDqwx4Ybx3x3RAsN181KMAP1VYW2MDPyqqaFRBwhDoat8y755TEiVO99dP0ORJEyPef54PsKKY95fzSUbxwm+tMpOgA2DwcCQ37WIdCGtY8YxvoPBxDH4u7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874142; c=relaxed/simple;
	bh=SNpBZias/FpBHenWn3OLgM+04jUdbrLbiuKUZJjA2LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dm0a2GwX4UDs+mepgntGUZK659f6Q0y8ngK4TmDsgraSu9PHjxrozoahFEetj77QIK1UynD2Rx40WyuOnK2LdzELAyiqGSj9kblEsS6t23sp1S0pHLGINpESrjdcj6A8DsHl/NoTsA+jrRsAUCa90s2cJHO6ltKcp3L0N5rNKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf1MTYTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf1MTYTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329121F000FF;
	Tue, 13 Oct 2026 06:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874140;
	bh=1FqInDU6Pq8o398bFv8Nlifm3tFL/GmrtmZnnUcvw5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mf1MTYTlKONPyJF6PMv9Z044JJBpize04UEBLBJtt8EtXwRgJtn+pz/8ypx8YMw8m
	 fFpUBuUa/X5ryenMF2F16t2JMnqMBMeGb467QsW/T5zqc58wsdP6NyAX3cYL7eeUis
	 PQ8HYRdpC8B5ZqzX/pVPMtnBjhKYnGucDx8U7JWGUyg17LQsrBMQIJVlaAumPD7GvX
	 k3+UH1yeCcLXRooWp4OZC50CFxwddUQAc1E16ly1bpQq4n8zNGjSx7PWm226PlCdfv
	 UAYq9/TdZZ8KrsmG6zfNs87xnfcigF/9Em7XGH8ID4T1hUjJXDbY4sacUeSGt1VL96
	 ThZ8NvRPak4KA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/6] serial: 8250_lpss: do not touch uninitialized line in ehl_serial_exit()
Date: Tue, 13 Oct 2026 08:48:49 +0200
Message-ID: <f389df34aaa538270313ebd4cea75c2baaf46b95.1791873876.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791873876.git.jirislaby@kernel.org>
References: <cover.1791873876.git.jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

lpss8250_probe() calls lpss->board->exit() on its error path. For the
EHL board, that is ehl_serial_exit() and it does:
serial8250_get_port(lpss->data.line)->dma = NULL;

But when lpss8250_dma_setup() or serial8250_register_8250_port() fails,
lpss->data.line was never assigned. As lpss is kzalloc()ed, line is 0
and ehl_serial_exit() clears the dma pointer of an unrelated port --
serial8250_ports[0], i.e. ttyS0, which is often the console.

Initialize lpss->data.line to -1 in probe and skip the clearing in
ehl_serial_exit() if no port was registered.

Fixes: 5318f70da7e8 ("serial: 8250_lpss: Balance reference count for PCI DMA device")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Assisted-by: LLM
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
-- pick
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org

[v2] no declaration in the middle of a function (Ilpo)
---
 drivers/tty/serial/8250/8250_lpss.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 776ec1ef29d6..325e587ae2c4 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -183,9 +183,8 @@ static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 
 static void ehl_serial_exit(struct lpss8250 *lpss)
 {
-	struct uart_8250_port *up = serial8250_get_port(lpss->data.line);
-
-	up->dma = NULL;
+	if (lpss->data.line >= 0)
+		serial8250_get_port(lpss->data.line)->dma = NULL;
 }
 
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -329,6 +328,8 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 
 	lpss->board = (struct lpss8250_board *)id->driver_data;
+	/* for tests in lpss->board->exit() */
+	lpss->data.line = -1;
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
-- 
2.56.0

