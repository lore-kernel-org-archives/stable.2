Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D333BD659;
	Mon, 21 Sep 2026 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977051; cv=none; b=jC34SFwyhOP77Yk9N2V+BGjC7K8+0w6F86oHWMCJtnjoU9qXDL56IU24u3QbRNqljb2W3t9n/8EOgQFTPQp3kOdmpjjG5Hz1JCOZmNjaFGN+XYQxBb/+0S7sNvYLKsh538sCg1pnuSOj2rtS9v6F+m3zQrVMcjJHbNyrqXJER8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977051; c=relaxed/simple;
	bh=Y6kMXdClUc7ZWMjsxAXSNswiVSuHviDLcRAVkJPOItE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jGT15/bLkoZsFIoawzp0gTrDPphVM2VBSovKMg3GrUDqlUDZ7om9ftKAaolvsr/zEYKoIwqJCMkIjQHBTXGtEPfyYxGYU9RkLJN7TfhoH69qaynv7Jvz+NaMs2Mkq4K1lALEUitI0eAb0DoBl/yH5GeG1zdMe24R55eB7RjnOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=TUMpwzEl; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="TUMpwzEl"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8a87ecf;
	Mon, 21 Sep 2026 15:50:40 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: William Hubbs <w.d.hubbs@gmail.com>,
	Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] speakup: handle serial IRQ request failure
Date: Mon, 21 Sep 2026 15:50:35 +0800
Message-Id: <20260921075035.9393-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c2f216bd03a1kunm56737cc93b327
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEpLVkwaTUJNGExPT0JDT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=TUMpwzEl15pHGF/Zz8nFPKy1IgVTKVDoIJ4wHoKNJFJEI9myG6yrP7mB22QKyT6DiN9jihnGuXOiehci/JwInAC1iqIel7Q2A9ueZL2WrWXA3JiSzvwxS3f7zsrQjZiM5gg9rfejvx3r0znF2OI2ltLiU21nvVWCBk0zQOKJVSQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=41t5TtyVu4+QfwAZNULlrsOwlHFLImY5LkU2J2B9cqk=;
	h=date:mime-version:subject:message-id:from;

start_serial_interrupt() currently logs a failed request_irq() but
continues enabling UART interrupts and reports a successful serial
synthesizer probe. A later release then calls free_irq() without a
matching registration.

Return the request error to spk_serial_init() and unwind the I/O region
and serial state when registration fails. This keeps the UART disabled
and prevents teardown from freeing an IRQ that was never requested.

A QEMU x86_64 test used a non-shared handler to occupy COM1 IRQ4 before
the Speakup serial path requested the same IRQ with IRQF_SHARED. On the
unfixed kernel, the probe continued successfully and release emitted
"Trying to free already-free IRQ 4". On the fixed kernel, probe failed
and no unmatched free_irq() warning was emitted. The IRQ conflict was
deliberately injected to exercise the error path and is not expected
during normal operation.

Fixes: c6e3fd22cd53 ("Staging: add speakup to the staging directory")
Cc: stable@vger.kernel.org
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/accessibility/speakup/serialio.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/accessibility/speakup/serialio.c b/drivers/accessibility/speakup/serialio.c
index 3418ea31d..56efc76a7 100644
--- a/drivers/accessibility/speakup/serialio.c
+++ b/drivers/accessibility/speakup/serialio.c
@@ -17,7 +17,7 @@
 #define SERIAL_PORT_DFNS
 #endif
 
-static void start_serial_interrupt(int irq);
+static int start_serial_interrupt(int irq);
 
 static const struct old_serial_port rs_table[] = {
 	SERIAL_PORT_DFNS
@@ -106,7 +106,13 @@ const struct old_serial_port *spk_serial_init(int index)
 	speakup_info.port_tts = ser->port;
 	serstate = ser;
 
-	start_serial_interrupt(ser->irq);
+	err = start_serial_interrupt(ser->irq);
+	if (err) {
+		synth_release_region(ser->port, 8);
+		speakup_info.port_tts = 0;
+		serstate = NULL;
+		return NULL;
+	}
 
 	return ser;
 }
@@ -125,18 +131,20 @@ static irqreturn_t synth_readbuf_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void start_serial_interrupt(int irq)
+static int start_serial_interrupt(int irq)
 {
 	int rv;
 
 	if (!synth->read_buff_add)
-		return;
+		return 0;
 
 	rv = request_irq(irq, synth_readbuf_handler, IRQF_SHARED,
 			 "serial", (void *)synth_readbuf_handler);
 
-	if (rv)
+	if (rv) {
 		pr_err("Unable to request Speakup serial I R Q\n");
+		return rv;
+	}
 	/* Set MCR */
 	outb(UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2,
 	     speakup_info.port_tts + UART_MCR);
@@ -148,6 +156,7 @@ static void start_serial_interrupt(int irq)
 	inb(speakup_info.port_tts + UART_IIR);
 	inb(speakup_info.port_tts + UART_MSR);
 	outb(1, speakup_info.port_tts + UART_FCR);	/* Turn FIFO On */
+	return 0;
 }
 
 static void spk_serial_send_xchar(struct spk_synth *synth, char ch)
-- 
2.34.1

