Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18693A544C
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495449; cv=none; b=AswyDOFpaP5L7WcLhavIqkWl398+7lkXvbXyTogTb/e4tRlxmjwOFbH3YquVwEvdD7kVZ1kPPv5uduXygRtBi34UP/7qB0ZdAzcrspQvLMePH9oojpVwwOYwzIsx2CYw9OIMiOLtU1o3aphKKanIM1NM19nzto2axRvn5V4DedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495449; c=relaxed/simple;
	bh=h8QTaqefpSOrkYAWZLLDXn6yyypD4+TG3kE/TT1Jvhg=;
	h=Date:Message-Id:References:In-Reply-To:Content-Type:To:From:
	 Subject:Mime-Version:Cc; b=m6N8lVRVP3YTOSX7kD/cam1Kkw3lMtrEuiILUz0GcVLrk0NgsvhFkStI2vLnN+zA1na7V+0DyUHBLCDWjQQJ6PzkuZ5wns0EfZ7UvFQ28osX+eB9h6eCSN+GoFDOTCTeaIShOE59h39Ej6akVE+L0mWujJw/+CN+s3eLprA9Uoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=QHLwHv5R; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="QHLwHv5R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1783495432;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=LthgASm8+ltQBc7DJDrsqONP7c+qnel+m0m01QIqoO4=;
 b=QHLwHv5RWkbfYOeOLqwH4f5kyvMJnQgUzrBNk5+uxXTgT7+pNJ2NjnF6dEGwoIkRmB7IuU
 d9MJ2+6r4NcWdkhQbRoHen7D6pk21EJBZY+QWeG3Vke33O7ULrr2j/tcM6CegDTKufJBH2
 iZs9VLBrR8FRmvUzP4uRmBOaMcr/fvwZcLubJEvNbEzuIKPQeVjqKLyvlUEWS193EoaGdN
 OfcJhYwaw2scBCNb3vLu/qkheqdaeo9j8i2z3WfU3XxFQzVVAmOPEGQ+W0Jj0X9G2V54y0
 ZtjsNMB0qjz8CPPwvbUAGTWMPMKU+Du3TE0PwkWLqztpcUGVoxhJ2HtpK6be/w==
Date: Wed,  8 Jul 2026 15:23:06 +0800
Message-Id: <20260708072306.3921604-1-wangzhaolong@fnnas.com>
References: <20260708031115.3757150-1-wangzhaolong@fnnas.com>
X-Original-From: Wang Zhaolong <wangzhaolong@fnnas.com>
In-Reply-To: <20260708031115.3757150-1-wangzhaolong@fnnas.com>
Content-Type: text/plain; charset=UTF-8
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
From: "Wang Zhaolong" <wangzhaolong@fnnas.com>
Subject: [PATCH v3] serial: 8250: fix shared IRQ startup race causing IRQ warning
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from MiniServer ([14.21.188.215]) by smtp.feishu.cn with ESMTPS; Wed, 08 Jul 2026 15:23:49 +0800
X-Mailer: git-send-email 2.54.0
X-Lms-Return-Path: <lba+26a4dfb06+307278+vger.kernel.org+wangzhaolong@fnnas.com>
Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>, 
	<albanhuang@tencent.com>, <tombinfan@tencent.com>, 
	<jackzxcui1989@163.com>, <kees@kernel.org>, <osama.abdelkader@gmail.com>, 
	<realwujing@gmail.com>, "Wang Zhaolong" <wangzhaolong@fnnas.com>
Content-Transfer-Encoding: 7bit

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

This is reproducible in QEMU with four legacy 8250/16550 ports.  In that
setup, ttyS1 and ttyS3 share IRQ 3.  A small userspace reproducer
synchronizes two threads before open(), waits for both open attempts, and
then closes both file descriptors.  It can trigger the warning almost
immediately.

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
race with the IRQ core startup path for the first 8250 port on the same
IRQ.  One possible interleaving is:

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

Hold irq_chain_mutex in serial_link_irq_chain() until the first request_irq()
has completed.  This prevents another 8250 port sharing the IRQ from joining
the chain and running the THRE test while the IRQ core is still starting the
interrupt.  The request_irq() failure cleanup also remains covered by
irq_chain_mutex, so the just-published irq_info cannot be observed by another
link attempt before it is unlinked again.

The lock used to only protect irq_lists hash walks, but it now also serializes
IRQ chain publication and the first request_irq() completion.  Rename it to
irq_chain_mutex and document the locking requirement for
serial_get_or_create_irq_info() with __must_hold() and lockdep_assert_held().

Fixes: 64c79dfbc458 ("serial: 8250_pnp: Support configurable reg shift property")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Wang Zhaolong <wangzhaolong@fnnas.com>
---
Changes in v3:
  - Rename hash_mutex to irq_chain_mutex now that it also serializes IRQ chain
    publication and first request_irq() completion.
  - Add __must_hold() and lockdep_assert_held() to document the locking
    requirement for serial_get_or_create_irq_info().
  - Verify again with the QEMU ttyS1/ttyS3 shared IRQ reproducer.

Changes in v2:
  - Retitle the patch to describe the unbalanced IRQ enable warning.
  - Move the code comment to the mutex acquisition site to document why the
    lock must cover the first request_irq() completion.
  - Drop the Assisted-by tag.

v2: https://lore.kernel.org/all/20260708031115.3757150-1-wangzhaolong@fnnas.com/
v1: https://lore.kernel.org/all/20260527092052.2086342-1-wangzhaolong@fnnas.com/

 drivers/tty/serial/8250/8250_core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f49862d90eeb..41d87cdc69d7 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -48,11 +48,11 @@ struct irq_info {
 	struct list_head	*head;
 };
 
 #define IRQ_HASH_BITS		5	/* Can be adjusted later */
 static DEFINE_HASHTABLE(irq_lists, IRQ_HASH_BITS);
-static DEFINE_MUTEX(hash_mutex);	/* Used to walk the hash */
+static DEFINE_MUTEX(irq_chain_mutex);
 
 static bool skip_txen_test;
 module_param(skip_txen_test, bool, 0644);
 MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
 
@@ -129,14 +129,15 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
  * Either:
  * - find the corresponding info in the hashtable and return it, or
  * - allocate a new one, add it to the hashtable and return it.
  */
 static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
+	__must_hold(&irq_chain_mutex)
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
+	lockdep_assert_held(&irq_chain_mutex);
 
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			return i;
 
@@ -154,10 +155,18 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 static int serial_link_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
 	int ret;
 
+	/*
+	 * Keep the IRQ chain lock held until the first request_irq() completes.
+	 * The first port publishes i->head before request_irq() starts the IRQ;
+	 * a second port sharing the IRQ must not join the chain and run the
+	 * THRE test while the IRQ core is still bringing the line up.
+	 */
+	guard(mutex)(&irq_chain_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);
 
 	scoped_guard(spinlock_irq, &i->lock) {
@@ -180,11 +189,11 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
+	guard(mutex)(&irq_chain_mutex);
 
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq) {
 			if (WARN_ON(i->head == NULL))
 				return;
-- 
2.54.0
