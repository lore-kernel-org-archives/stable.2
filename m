Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FE2288D5;
	Mon, 20 Jul 2026 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784525891; cv=none; b=LypGS9IaEjdEXiBqngKgW4EyJp9nj/0+09Xay6doBDR7fgPgXXgcSI9eKdSgqyc6bX4tByZ8LrIzr9GVLucT+WLtBJollRjB0jUHpm/eqGIdsN8kmx2WOgpd4hl1eIfcfl1W4dod3EoBLpwRzeERoGZgmK/G3ZvpSWwPTl48iUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784525891; c=relaxed/simple;
	bh=4jojnu+E0QsY05hwAlGpnBAHyFPgNjp0ExCZFxwsob4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kajDXHOtjB+cWIo1VTBG4yd57rgha0bJBH4LrM06GFaGt2toFSJ5vx1Wz/4/4ZCdPJKSHP5Q2HkfppH4cy0JwJCAddFHKfCFKSytE6olDpmpw6P0bhgtuvLUWxk4cHwx6A3aoe7i1GgbzQOElYv3QfAim9Q8REDVVY2qIUYW4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=MOIKw1Uv reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="MOIKw1Uv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Ho4KU/mzaX
	gJwtfAjQaopacALlq1GUREJBjOHiPg8rM=; b=MOIKw1UvfNuKZQqmDdKTAKGg+f
	RMWPKRzJ9sOV0+qOD0Qp6mRoKDNJJNerxafWShGd9TThilLlLj4KHf2r7IasSMbF
	50wse2pj6+ws3y/zatouPhSq1eE58jMO6cFjR6NO20yaEo5oF9vl6XkEZwySpE5h
	O3WiIWPwh3BrYcuCA=
Received: from wmy.localdomain (unknown [115.53.182.60])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkDG7BIftF1q_U44AQ--.12607S2;
	Mon, 20 Jul 2026 13:37:38 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	john.ogness@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] serial: 8250: validate iomem_base in serial8250_verify_port()
Date: Mon, 20 Jul 2026 13:37:33 +0800
Message-Id: <20260720053733.102186-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkDG7BIftF1q_U44AQ--.12607S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1xZr1kJryrJFyrWrykXwb_yoW5Wr47pa
	9rtrsYyryDJ3Zrta1xZF1jkr48ZanYka47CF9xu3s0vryrXF4jyr17t3s0kr4DKF9Fq347
	AF1UZw4UC34DtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUAEWpc6mtTNQAAsE

syzkaller reports a slab-use-after-free in mutex_spin_on_owner().
This occurs because a previous thread crashed during tty_open() while
holding the tty_lock, leaving the owner pointer dangling.

The initial crash is an unhandled Page Fault in mem_serial_in():

  BUG: unable to handle page fault for address: ffffc90001206014
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP KASAN PTI
  RIP: 0010:mem_serial_in+0x67/0x90
  Call Trace:
   serial8250_clear_interrupts+0x40/0xf0
   serial8250_do_startup+0x3f5/0x3220
   serial8250_startup+0x6c/0x90
   uart_startup+0x4ff/0x12c0
   uart_port_activate+0xf3/0x1a0
   tty_port_open+0x15c/0x200
   uart_open+0x47/0x60
   tty_open+0x39b/0x1310

This sequence is triggered because the TIOCSSERIAL ioctl allows a user
with CAP_SYS_ADMIN to change the io_type of a serial port to UPIO_MEM
(or other memory-mapped types) and inject an arbitrary physical address
via iomem_base.

When uart_change_port() applies these changes, it attempts to remap the
port's I/O memory based on the injected iomem_base. This can result in an
invalid or inaccessible virtual mapping for port->membase. The subsequent
call to mem_serial_in() then dereferences this bogus pointer, triggering
a fatal Page Fault.

Fix this by tightening the validation in serial8250_verify_port().
Reject any TIOCSSERIAL requests that attempt to modify the io_type
to/from memory-mapped types, or change the iomem_base of an existing
memory-mapped port. Userspace can still legitimately modify IRQs or
baud rates of MMIO ports as long as the io_type and mapbase remain
unchanged.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/tty/serial/8250/8250_port.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e94a0802cbdd..79563afe9db9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3146,6 +3146,16 @@ serial8250_verify_port(struct uart_port *port, struct serial_struct *ser)
 	    ser->type >= ARRAY_SIZE(uart_config) || ser->type == PORT_CIRRUS ||
 	    ser->type == PORT_STARTECH)
 		return -EINVAL;
+
+	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32 ||
+	    port->iotype == UPIO_MEM32BE || port->iotype == UPIO_MEM16 ||
+	    ser->io_type == UPIO_MEM || ser->io_type == UPIO_MEM32 ||
+	    ser->io_type == UPIO_MEM32BE || ser->io_type == UPIO_MEM16) {
+		if (ser->io_type != port->iotype ||
+		    (unsigned long)ser->iomem_base != port->mapbase)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1

