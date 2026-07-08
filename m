Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB67315D40
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480461; cv=none; b=ui6SA/6bMfl/xgrGrDxHNXe8BVZHEIUFumPUFULl73iLkWNXtdySc2B5dPCgosmDGPgxSSy8VRNFGlrBJF7NVZ5y1YtvjEBc1A1JAaDxc/lL0NbED9hfxqDj/P6TBFxvjK2Gm41WrpVjRqmd+1GgwMOb172kTY3v7VhBgML1Te0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480461; c=relaxed/simple;
	bh=4l2+byjnLrS3HSN9NzXdSmgIgF+PWBE0pX4OLlNfyQA=;
	h=Subject:References:Content-Type:Cc:Mime-Version:In-Reply-To:To:
	 Message-Id:From:Date; b=Wuq6YAmEUx0ghS9BX5Oe4SHqAHcTWdXzqa9YxM7HPxUarhAzt0MqkzKtPnhaozDVxHxpwHezlQzVA65dMFK8zgr96BIX3oGzhXVnZnP/VKDomdZDyH40CuOI4WsrabRzJu5ratgitRwXEFSge3UYcwkoUMNAyB2kLpEuXsGyQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=qObJkiV5; arc=none smtp.client-ip=209.127.231.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="qObJkiV5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1783480329;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=yue4skZaKFuTAjJE0A8qYWVzHdt7vUztId56TGPY1HA=;
 b=qObJkiV53khoogeg6yczJi9tovbsc1AvfuldYrd5PI5y9SFWAxkhiWFBJqP6gLDwW1mnFb
 2yEeSsxwbttz8c9zp/O0onL5vTuNm9ewWJg+a5wDaqinDr2IwdsiO08HCkepbzup1YeDOb
 PpKsqDYbSAmVuPdoobwVX9l2342DnMgG1LeWjUq91woZ1T61jMBOR7+7usXCPEueEqo1pl
 2jdtyFLeGN5aJ2KO1vODx7oTRr2jh82/i/XBv8p3CL5iLKkxi7+oR5MBB3ZbhhPeUWjrxz
 54o3V7HMSdjEJ7tHZQ6kjydAGakulHMzBhZz3dWghW11q+wj0ogVOZ0Nr5y6ew==
Subject: [PATCH v2] serial: 8250: fix shared IRQ startup race causing IRQ warning
References: <20260527092052.2086342-1-wangzhaolong@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>, 
	<albanhuang@tencent.com>, <tombinfan@tencent.com>, 
	<jackzxcui1989@163.com>, <kees@kernel.org>, <osama.abdelkader@gmail.com>, 
	<realwujing@gmail.com>, "Wang Zhaolong" <wangzhaolong@fnnas.com>
X-Lms-Return-Path: <lba+26a4dc007+04c453+vger.kernel.org+wangzhaolong@fnnas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0
X-Original-From: Wang Zhaolong <wangzhaolong@fnnas.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260527092052.2086342-1-wangzhaolong@fnnas.com>
Received: from MiniServer ([183.34.163.178]) by smtp.feishu.cn with ESMTPS; Wed, 08 Jul 2026 11:12:06 +0800
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Message-Id: <20260708031115.3757150-1-wangzhaolong@fnnas.com>
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
Date: Wed,  8 Jul 2026 11:11:14 +0800

Concurrent startup of two 8250 ports sharing the same IRQ can trigger an
IRQ core warning:

  Unbalanced enable for IRQ 3
  WARNING: CPU: 0 PID: 580 at kernel/irq/manage.c:774 __enable_irq+0x3b/0x60
  Call Trace:
   enable_irq+0x8d/0x120
   serial8250_do_startup+0x80d/0xa80
   uart_port_startup+0x13d/0x440
   uart_port_activate+0x5b/0xb0
   tty_port_open+0xa1/0x120
   uart_open+0x1e/0x30
   tty_open+0x140/0x7a0

This is reproducible in QEMU with four legacy 8250/16550 ports where ttyS1
and ttyS3 share IRQ 3.  A small userspace reproducer that synchronizes two
threads before open(), waits for both open attempts, and then closes both file
descriptors can trigger the warning almost immediately.

The regression was bisected to commit 64c79dfbc458 ("serial: 8250_pnp:
Support configurable reg shift property").  That change made QEMU's legacy
PNP serial ports take the shared-IRQ THRE test path in
serial8250_do_startup():

  if (port->irqflags & IRQF_SHARED)
    disable_irq_nosync(port->irq)
  ...
  if (port->irqflags & IRQF_SHARED)
    enable_irq(port->irq)

The disable_irq_nosync()/enable_irq() pair is locally balanced, but it can
race with the IRQ core startup path for the first 8250 port on the same IRQ.
One possible interleaving is:

  CPU0, ttyS1                         CPU1, ttyS3

  serial_link_irq_chain()
    hash_add(i)
    i->head = &ttyS1
    request_irq()
                                        serial_link_irq_chain()
                                          find i in irq_lists
                                          list_add(&ttyS3, i->head)
                                        serial8250_do_startup()
                                          disable_irq_nosync(irq)
    irq_startup()
      desc->depth = 0
                                          enable_irq(irq)
                                            WARN: Unbalanced enable for IRQ 3

Hold hash_mutex in serial_link_irq_chain() until the first request_irq() has
completed.  This prevents another 8250 port sharing the IRQ from joining the
chain and running the THRE test while the IRQ core is still starting the
interrupt.  The request_irq() failure cleanup also remains covered by
hash_mutex, so the just-published irq_info cannot be observed by another link
attempt before it is unlinked again.

Fixes: 64c79dfbc458 ("serial: 8250_pnp: Support configurable reg shift property")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Wang Zhaolong <wangzhaolong@fnnas.com>
---

Changes in v2:
  - Retitle the patch to describe the unbalanced IRQ enable warning.
  - Move the code comment to the hash_mutex acquisition site to document why the
    lock must cover the first request_irq() completion.
  - Drop the Assisted-by tag.

 drivers/tty/serial/8250/8250_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb..dd202032cc7c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -132,12 +132,10 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
  */
 static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
-
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			return i;
 
 	i = kzalloc_obj(*i);
@@ -154,10 +152,18 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 static int serial_link_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
 	int ret;
 
+	/*
+	 * Keep the hash lock held until the first request_irq() completes.
+	 * The first port publishes i->head before request_irq() starts the IRQ;
+	 * a second port sharing the IRQ must not join the chain and run the
+	 * THRE test while the IRQ core is still bringing the line up.
+	 */
+	guard(mutex)(&hash_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);
 
 	scoped_guard(spinlock_irq, &i->lock) {
-- 
2.54.0
