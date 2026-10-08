Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CABE39CD0C;
	Thu,  8 Oct 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478166; cv=none; b=i6rfIrWb5Mi9upiWosQmVBKw2x5wNoZWuEBO66CV0V0823WWOdJIqrSl+asIUJ5TyyGwelWHo7OSv9RLLXGKB6SRQXwxr8bjwtG8MfH1jMA4zYVV+FvdWynHTxTm8cOGgvybxs2E+1DmlZB40HUsAndVs2V99fkyx0Vfeq7l0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478166; c=relaxed/simple;
	bh=b9Fky14f1LUU/huO2vwJ+DRQzKFNjFCeruk2GiJ3sg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SYg3Rm4JOzBwCYUM+VaydQqyKjJ+ZB90wojJ9P+4P6rcmh9TTs8fU9D5mCifCxJI8s0WFh48MF2PQA2BzHCngakk7MPa9sRgRe2af7ioSyMQWKiLUEN6Vu+1hnHQj8S1ypqq02MGLYAUiYqFf6VXqKddCslFltrlXyqgNv+V1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bohKO76j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bohKO76j"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE60AC2BCC7;
	Thu,  8 Oct 2026 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791478165;
	bh=b9Fky14f1LUU/huO2vwJ+DRQzKFNjFCeruk2GiJ3sg0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=bohKO76jc5j78+6crUTFr99o+nJU5l+94kI2Du/3TcIKFYeSClQO6QbAuAN75KGer
	 EIsq74hy3RGIhsWcNFyL57WB9ed+yX1jWLUk22o1U8ETHTOAimOgWGdPcJmPOYrrzE
	 a6iB7A1PXahsf9yT7hWKayfrMTDdqRc8bcP5U9b83Ff68NGzVaBeTSYoRaarRrno/6
	 TifV5TiqlS1pDZ+M0HL4JgPmokOM6YMxJu2YCSxYwzGF2+D0UZhySB5LBxUuDTx1ZZ
	 9PB7IETvY4hSGdM8pc1ufks4UMrXNMg88eJcguS3rOWl8KCwbRpIzSDCNT/y40s0eE
	 y0oy9X5PLwOLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF79CA6011;
	Thu,  8 Oct 2026 16:49:25 +0000 (UTC)
From: Phil Rosenthal via B4 Relay <devnull+phil.phil.gs@kernel.org>
Date: Thu, 08 Oct 2026 12:49:18 -0400
Subject: [PATCH] serial: core: Shut down a running console port before
 removing it
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-serial-console-remove-v1-1-288b9c315af7@phil.gs>
X-B4-Tracking: v=1; b=H4sIAI3Jx2oC/x2MUQqAIBAFrxL73YJFhHWV6EP0VQumoRBBdPesz
 4GZuSkjCTKN1U0Jp2SJoUBTV2Q3E1awuMLUqrZvlNL8+cazjSFHD07Y4wl2A5bOGd1DWSrtkbD
 I9X+n+Xle7AOU/GcAAAA=
X-Change-ID: 20261008-serial-console-remove-d9ef4da86e0c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Phil Rosenthal <phil@phil.gs>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791478165; l=6057;
 i=phil@phil.gs; s=20260718; h=from:subject:message-id;
 bh=Q7XAF+419MTFMSgpiGVUWbeGwnkDqT3ay7oPEni5yyk=;
 b=VMm2ZLK6//JcFvT3yNXlruRDFVO+hFxzd3SFYblsu/3Uq7GDIufVz0C6bC5JoNNyCXEGtTfRG
 WMmDbw6tOqbActMGhReaDD03Rowlw+1u3X64XCH5pPKWXdwBi/vHvko
X-Developer-Key: i=phil@phil.gs; a=ed25519;
 pk=08BMg1YPtTS5NnKn5I1Mq1ra3MdAg49Awe6OjrC59fs=
X-Endpoint-Received: by B4 Relay for phil@phil.gs/20260718 with auth_id=881
X-Original-From: Phil Rosenthal <phil@phil.gs>
Reply-To: phil@phil.gs

From: Phil Rosenthal <phil@phil.gs>

A console port is not shut down when its last user closes it:
tty_port_shutdown() returns early when tty_port::console is set, so the
port stays initialized.  For an 8250 port this leaves its interrupt
requested or, for a port without an interrupt, its poll timer armed.

serial_core_remove_one_port() relies on tty_port_tty_vhangup() to shut
the port down before releasing its resources, but the hangup reaches
uart_hangup() -> uart_shutdown() only when a tty is attached.  For a
console that was opened and closed, for example a serial console whose
getty has been stopped, nothing shuts the port down.  The console is
unregistered, ->release_port() releases the registers and the core frees
uport->name while the port is still running.  On tty-next with 8250
ports:

 - A card bound to 8250_pci with an INTx interrupt and unbound through
   sysfs keeps its interrupt requested after the driver is gone.  The
   irqaction name points to the freed uport->name, so reading
   /proc/interrupts is a slab-use-after-free in irq_seq_show().

 - A polled (irq = 0) MMIO port with UPF_IOREMAP keeps running
   serial8250_timeout() after serial8250_release_port() has cleared
   membase, which dereferences NULL in timer softirq context about
   10 ms after "console [ttyS5] disabled".

After unregistering the console and before releasing the resources, shut
the port down if it is still initialized.  uart_shutdown() runs with
port->mutex held, as for its other callers, and with no tty, so it also
drops DTR and RTS.  A port that had a tty attached was already shut down
by the hangup and is skipped.

Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse
Signed-off-by: Phil Rosenthal <phil@phil.gs>
---
This bug was found and confirmed with AI assistance, so it is reported in
the open.  It is not a security issue under
Documentation/process/threat-model.rst ("Excess of initial privileges"):
triggering it needs the privileges to unbind or remove the device.

I hit it on real hardware.  My serial console is a polled ASPEED BMC VUART,
then driven by an out-of-tree module.  After I stopped its getty,
unloading the driver oopsed in mem32_serial_in() from serial8250_timeout().

History: before 761ed4a94582, uart_close() called uart_shutdown() for
every port, consoles included.  761ed4a94582 made console ports skip the
shutdown on close.  be2c92b8f164 reverted that part and 4dda864d7307
reinstated it, all within v4.9.  Keeping a console running after close is
intended, but the removal path was never updated for it.

Tested in a QEMU guest on tty-next 36844ea19656 with KASAN, using in-tree
8250_pci and a "serial8250" platform port.  Reproducers are available on
request.  Without this patch:

  8250_pci with INTx, reading /proc/interrupts after unbind:
    BUG: KASAN: slab-use-after-free in string+0x3b6/0x4c0
     irq_seq_show+0x34d/0x810
    Allocated by task 1244:
     kasprintf+0xac/0x100
     serial_core_register_port+0x55f/0x1720
    Freed by task 1276:
     kfree+0x1a0/0x4a0
     serial_core_unregister_port+0x44d/0xa80
     serial8250_unregister_port+0x10d/0x6c0
     pciserial_detach_ports+0x92/0x160

  Polled MMIO port (irq 0, UPF_IOREMAP) after removal:
    printk: console [ttyS5] disabled
    BUG: kernel NULL pointer dereference, address: 0000000000000008
    RIP: 0010:mem32_serial_in+0x74/0xa0
     serial8250_timeout+0x44/0x140
     call_timer_fn+0x32/0x260

With this patch both cases are clean: the IRQ is freed on unbind,
rebinding restores the console, and the polled port is shut down on
removal.  A port held open across removal and a console that was never
opened did not fail before and still work.

I used plain mutex_lock() rather than scoped_guard() so that the patch
also builds on stable trees before 6.5.  It applies from v5.4 to current
master, and serial_core.o builds on v6.1 and v6.6.  W=1, sparse and
checkpatch --strict are clean.

Also tested on real hardware: the ASPEED BMC VUART that hit the bug
(polled MMIO, irq 0) as the console, now bound to 8250_pci with my
pending ASPEED support patch [1], on a 7.0.14 distribution kernel with
both patches.  After stopping the getty, opening and closing the port,
and unbinding the PCI device, there is no oops.  Rebinding restores the
console, the getty and in-band IPMI.

Not tested: serial drivers other than 8250.

[1] https://lore.kernel.org/r/20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs

AI assistance: an LLM coding assistant (Claude, model claude-opus-5-5, in
Claude Code) analysed the crash, wrote the reproducers and the patch, and
built and ran the test kernels.  Two other LLMs reviewed the result
(GPT-5.6 Sol via Codex, and Claude Fable 5.1 via Claude Code).  I reviewed
it as well.
---
 drivers/tty/serial/serial_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 319a4b427f3a3727d12cb58252bd8959f9be4cd6..104a2b2eec641bbbc23e67522a7812309442de23 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3239,6 +3239,18 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	if (uart_console(uport))
 		unregister_console(uport->cons);
 
+	/*
+	 * A console port is not shut down on last close (see
+	 * tty_port_shutdown()), and the hangup above only shuts down a port
+	 * that has a tty attached. A console that was opened and closed is
+	 * therefore still running here; shut it down before its resources are
+	 * released.
+	 */
+	mutex_lock(&port->mutex);
+	if (tty_port_initialized(port))
+		uart_shutdown(NULL, state);
+	mutex_unlock(&port->mutex);
+
 	/*
 	 * Free the port IO and memory resources, if any.
 	 */

---
base-commit: 36844ea19656fb41278799ef3d5cd52120d89149
change-id: 20261008-serial-console-remove-d9ef4da86e0c

Best regards,
-- 
Phil Rosenthal <phil@phil.gs>


