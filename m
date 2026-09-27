Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C525EF87;
	Sun, 27 Sep 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790519825; cv=none; b=GfpKm5G8obwO3ZFKp3JTN23o725wqCrKX4aonD1iGp7c4g/gQowmoKZwBCSe3+tKUzCqqB8H8aThhtAyt1KdqjTM4HZZLvQhnC5pZkU/cdeFZ3LNbeIdrgQmG9gh34s99j2+am7bqTLcoNWFscN9YxT2TqcKHNgV0q/dTnOx9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790519825; c=relaxed/simple;
	bh=CtgvD/xONgm1ZqkmQmkJqlAPz5W6NpIiYSFp9lxW0Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=coi9oRwde9F580yU01WLwx08CP3IwFLR04vCYlBkeClMb7jLQt2SGTfG2BcpdcrCaUNPXuf+ILw6Hn8jNyIBLjLlMuaGwa7ATHeKwmSUWPmvg8a0O9NJdnaptTBbOzIk2KhbLR0Eo9n2kYmkTi6qdQWHrLMKU5QR/14Ne9inGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBnQT79Kblqt4s+AQ--.15488S3;
	Sun, 27 Sep 2026 22:36:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with UTF8SMTPA id yy_KCgAnOIX9Kblq_MYPAA--.17236S2;
	Sun, 27 Sep 2026 22:36:45 +0800 (CST)
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
Date: Sun, 27 Sep 2026 14:35:50 +0000
Message-Id: <20260927143550.608878-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026092332-limes-washhouse-44a5@gregkh>
References: <20260819021916.442827-1-fanwu01@zju.edu.cn> <2026092332-limes-washhouse-44a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAnOIX9Kblq_MYPAA--.17236S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?MqzmwQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnRrXgS1QiyEChzQk8Vd3wxXuzNSIt5oHScgQHGJ2/oAqvolBXwXZexsXeyIfgEeLu8p+
	3z5wFYKTjAW7lsu4O7XN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4xWr1xKr4xJFWDKF43CFX_yoW8tw4DpF
	Z8trZ8Ar4kAr4jqa12yFs7WFWfZa13GrW7Gr1rKw1j93WfGr4IgF4IvF1Yva1q9rn7uFWa
	krZ5C3y3uF1UtagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

Hi Greg,

Honestly: when I sent the patch it was compile-tested only
(CONFIG_SERIAL_IMX=m, drivers/tty/serial/imx.o rebuilt with no warnings).
I should have said so.  There was no runtime test behind it.

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

