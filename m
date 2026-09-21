Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942B4A6881;
	Mon, 21 Sep 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001736; cv=none; b=kDZEQqlLeF86e0gxbKVLa96u8sHQOwW14XA8p1wXnXG/63oVloja+pLGOXdIqxPHxcdB4zxXxdvC8ZF3V33UWtPnu9AyHlA9KTKCKU03OYOMjcIIbQSO8FtFOD+ntRBEkhcNfgknZP6d1JKu4FRKLk6wj2YWa7Y16MbLqaHUOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001736; c=relaxed/simple;
	bh=sGruuTORCOH7Md2a1q1vZDJ3XOsnCuOVCxA101Q3I20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oilkgfomNO4o/u4/oU3f+GpnsDpHUFXPg77bzfvUcViIK2r+mozyxzCbuwamzLvZb3NdFMIQ1T4w8jyk7JzAHwQQpeTXq5ffWB2o4v8yi7Mw4Wo/CHrhMoQIIUM4p/G38Gf0xAm0TPBwGntUZNjk/umyWu5rb3lC7rdO8Ddh87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=N2RN0ZfN; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="N2RN0ZfN"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e975bd86;
	Mon, 21 Sep 2026 22:42:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>,
	Kirk Reiser <kirk@reisers.ca>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] speakup: handle serial IRQ request failure
Date: Mon, 21 Sep 2026 22:42:01 +0800
Message-Id: <20260921144201.302823-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c46ac5dc03a1kunma0f451da52895
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTB1NVklPTEIeGE9MHU4dGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=N2RN0ZfNQYf3rnlweQGuBtfuTiOfYuErv1fFwFfxxw8zUh44GOhRsmc+kdy1Q6ghfet+JAgmUAn9HtMrsQUx4UL/ybsbdBo3muJYZZ816flAmzFZZD1n8Wo2ILK8K+7mJASFgnGLGHsAxqDTbnz9NRlC3jlvejQc5YiyrKo7K/o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=u2wIf+IGyx/+O0OgWCp4shQ0MgaWvz2EtUhSKy/AUig=;
	h=date:mime-version:subject:message-id:from;

start_serial_interrupt() currently logs a failed request_irq() but
continues enabling UART interrupts and reports a successful serial
synthesizer probe. A later release then calls free_irq() without a
matching registration.

Return the request error to spk_serial_init() and unwind the I/O region
and serial state when registration fails. This keeps the UART disabled
and prevents teardown from freeing an IRQ that was never requested.

Reproducer:

  Build an x86_64 kernel with CONFIG_ACCESSIBILITY=y,
  CONFIG_SPEAKUP=m, and CONFIG_SERIAL_8250=m. Disable ACPI, PNP, and
  SERIAL_8250_CONSOLE so that QEMU's COM1 remains available at 0x3f8 on
  IRQ4. Build an out-of-tree module that first claims IRQ4 with a
  non-shared handler and then registers a Speakup serial synthesizer for
  ttyS0. Boot the kernel in QEMU with its default COM1, for example:

    qemu-system-x86_64 -machine pc -m 1024 -smp 2 -no-acpi \
      -display none -monitor none -serial file:/dev/null \
      -kernel arch/x86/boot/bzImage -initrd test.cpio.gz \
      -append 'console=hvc0 rdinit=/init loglevel=7'

  In the guest, load the modules in this order:

    insmod speakup.ko
    insmod speakup_irq_failure_poc.ko

  The second module keeps the non-shared IRQ4 owner installed, so the
  Speakup request_irq(..., IRQF_SHARED, ...) fails with -EBUSY. On the
  unfixed kernel, the probe still returns success and the harness removes
  the published synthesizer, producing "Trying to free already-free IRQ
  4". On the fixed kernel, the probe returns an error and no unmatched
  free_irq() warning is emitted. The IRQ conflict is deliberately
  injected to exercise the error path and is not expected during normal
  operation.

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
