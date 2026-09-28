Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08A6547042;
	Mon, 28 Sep 2026 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558577; cv=none; b=rgsX8Vi7yQnA5B+tzrGKMeSqPBUvBEJycRz2vQ8mnUSUd1iEiCu07FxIhkzIxKljynfrabfNLm9tyw+S8SSBRnmAOIuLfcUEyWaW2MT2NUguGVxGuPnyb+zvT+vUziJs8OZPnvPh0Cb2Pnu0kXMHPACWTi7SDzOb7BPT6n4rdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558577; c=relaxed/simple;
	bh=MIkKVhn7E9BemvrlXVukR0zmhJ3p4BggWlG2NXzaC48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9rf+bMLWOjNDMWpGnu9HUPtSesmo7nuV2+8ssOcE+hPeb4SDJ2Lx+lYJm+FbUTb6UOXn6qSeOCaUZGoSbwSx/eRG/56sRgNGcKAeRkbVOzX93cQoe0iIAu5XnFK5m0sWlHKrQftc6i9aC4sW1HWVFtolg/xASjbSCHpTmA3KNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXKGRYwblqf7g_AQ--.622S3;
	Mon, 28 Sep 2026 09:22:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgDHiaVYwblqccgaAA--.21770S2;
	Mon, 28 Sep 2026 09:22:32 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: imx: cancel RS485 trigger hrtimers in shutdown and remove
Date: Mon, 28 Sep 2026 01:21:37 +0000
Message-Id: <20260928012137.612469-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026092715-deftly-strainer-c8a3@gregkh>
References: <20260819021916.442827-1-fanwu01@zju.edu.cn> <2026092332-limes-washhouse-44a5@gregkh> <20260927143550.608878-1-fanwu01@zju.edu.cn> <2026092715-deftly-strainer-c8a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgDHiaVYwblqccgaAA--.21770S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?VpIAvQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnbfYAegEspJ+qccDMUwRuturi5AT5DoK0eYNJyhaOWy/zrM0g3c3MjVnG8yRi+Mvb/sN
	c6t5hI+iBeOhBNyMgpmp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxGFWUXr4fury8Cw1UWFyrXwc_yoWrGF4UpF
	WDtrZIkrWvqr4avF47AFn7WFyftws3Jry7Gr1rK3Wjv3y3CrWxtF42vFsYvFWqgw1FqFWY
	kr48JwnxuFyUAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

On Sun, Sep 27, 2026 at 06:28:42PM +0200, Greg Kroah-Hartman wrote:
> Sorry, I have no context here as you top-posted and did not include any
> context.  Please don't do that.  Remember, some of us get 1000+ emails a
> day...

You are right, sorry about that.  Answering your Sep 23 question with
context this time:

On Wed, Sep 23, 2026 at 12:17:41PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 19, 2026 at 02:19:16AM +0000, Fan Wu wrote:
> > The rs485 delay hrtimers trigger_start_tx and trigger_stop_tx are
> > embedded in the devm allocated struct imx_port, and their callbacks
> > reach the port through container_of() and touch registers under the
> > port lock.  Nothing cancels them synchronously: the tx paths only call
> > hrtimer_try_to_cancel(), which does not wait for a running callback,
> > and the bounded wait in imx_uart_shutdown() can give up, force tx_state
> > to OFF, and leave a timer armed.  After imx_uart_remove() returns, devm
> > frees the port and a late callback dereferences freed memory.
> >
> > Cancel both timers at the end of imx_uart_shutdown(), after the port
> > lock is dropped and before the clocks are disabled, and again in
> > imx_uart_remove() before the devm free: serial core does not call the
> > driver shutdown on every path that reaches remove().
> >
> > This issue was found by an in-house static analysis tool.
> >
> > Fixes: bd78ecd6056d ("serial: imx: use hrtimers for rs485 delays")
> >
> > Assisted-by: Codex:gpt-5.6
> > Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> How was this tested?

When I sent the patch, it was compile-tested only (CONFIG_SERIAL_IMX=m,
drivers/tty/serial/imx.o rebuilt with no warnings).  I should have said
so.  There was no runtime test behind it.

After your mail I built a QEMU/KASAN reproduction (i.MX6UL EVK machine,
armhf, kernel = this patch's base a13c140cc289 + CONFIG_KASAN).  The
remove-side race is deterministic on the unpatched base:

  - ttymxc0 is a registered console; configure RS485 via TIOCSRS485 with
    delay_rts_after_send set (driver clamps it to 100 ms), write() - TX
    completes and imx_uart_stop_tx() arms trigger_stop_tx
  - with the port still open, unbind: for console ports
    tty_port_shutdown() returns early, and serial_core_remove_one_port()
    never calls the driver .shutdown, so nothing sync-cancels the timer
  - imx_uart_remove() returns, devres frees struct imx_port, the queued
    hrtimer expires and the hrtimer core walks the freed object:

BUG: KASAN: slab-use-after-free in rb_erase_linked+0x54/0xa8
Write of size 4 at addr c4046a8c by task swapper/0
Call trace:
 rb_erase_linked from __remove_hrtimer+0x50/0x124
 __remove_hrtimer from __hrtimer_run_queues+0x198/0x25c
 __hrtimer_run_queues from hrtimer_interrupt+0x26c/0x624
 hrtimer_interrupt from arch_timer_handler_phys+0x38/0x40
 ...
Allocated by task 1:
 devm_kmalloc+0x34/0x144
 imx_uart_probe+0x90/0xacc
 ...
Freed by task 1:
 kfree+0xc8/0x2d8
 devres_release_all+0x100/0x18c
 device_unbind_cleanup+0x3c/0xe4
 device_release_driver_internal+0x23c/0x294
 unbind_store+0x64/0xa4
 ...
The buggy address is located 652 bytes inside of
 freed 1024-byte region [c4046800, c4046c00)

i.e. the expired timer is still enqueued inside the freed struct imx_port.
A second report fires from task context via hrtimer_try_to_cancel ->
rb_erase, same alloc/free stacks.

With the patch applied the same sequence (fd-open unbind, and the
last-close-then-unbind variant) completes cleanly; repeated RS485
write/close/unbind cycles on a non-console port stay clean too, with no
new warnings or hangs.  This is QEMU only - no i.MX hardware test yet,
so I have not added a Tested-by.  I can send the reproducer initramfs and
the QEMU command line if that is useful.

Thanks,
Fan

