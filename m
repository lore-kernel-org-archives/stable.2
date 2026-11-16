Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834597;
	b=qM9+1qw1gA2L1hVwB9vywK/9j5QPogVMZuI4xYZ/sN85/PmfM1Sa7ujWPNZyi/vESr5x
	 J2cxbcDRVp/hHUnu8eqROScfNXuMxDWwo8X5rpm3oABWngySpnZiPQzNAU7UKHdeS7qRx
	 AJIlxsKAuMQmwfMavfT6cBuiN+pXNdmE5wssCJio5iTtOO/+JOJAYCzP1SyLC2oDgiS+Z
	 uhwUGN/lHzI1rVZEzD5EJxiuUwIaKFtGpvAVysOxFvvMUrDrpg7N38HqCDkHF5Fb+s4gM
	 xhAResj7+HfuQpw+XKC94c62AO40yiijVS7m9LQETJf5BnIWrcaMdM5JlGzZJFq3Mrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834597;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=wukc0fhPEwtFGc9I09i5YG1FWfRn2SmGsfOzkZNlNXQ=;
	b=Hwxttxs/IfqJJJDF76TWtisCPzSd6AgU4BGq2mSEq8z6oZHUvmczydC6JSdPIYk+e1KM
	 jyNPCuk3m2thGiAR2OkSNTDeOllmq/WkVi+KVIfiQHK0OBD2ySoQhD9AKcN/IN4ZkbYbq
	 vQrhG3ywNIzUj9Xpu6kNu0oBMdZRDD4hqDDTac8E2RpLeW6i4HfNHIcMS0ypZyxcXn+KJ
	 z3J9tckXSLhYXzqxyIiS0RgYE59FUDpgKlAmd64iBDACNEdOrEiBBx+41l9M32tNAlRU0
	 ePSmfrdICBpBnJ5FxvqO0PjH0rl819I8d2cET2YSe6siVIwd0bOb11lHADg6EcsrP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=l+iKxJ1M;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC8606A31C;
	Mon, 16 Nov 2026 13:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81EC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=l+iKxJ1M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=wu
	kc0fhPEwtFGc9I09i5YG1FWfRn2SmGsfOzkZNlNXQ=; b=l+iKxJ1M9vBZrthH1a
	BtwSX0AKYtnuI/yzTpaqajrlv0EimpZg7NABwC0NsbNcjJAGtKIoVdQgJfym2pS1
	V03eQjLUvPiLO+fJslBveiSYbvyt43Xh63iUYiKGznjkR4v5OYpK519xLAhElcEJ
	RU4g8zIuH0ss+c5Zqsw7JFQnI=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X2KMAPtqmzyJHQ--.35872S2;
	Mon, 16 Nov 2026 21:09:33 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] parport: do not re-enable interrupts in parport_claim()
Date: Mon, 16 Nov 2026 21:09:30 +0800
Message-ID: <20261116130930.1629208-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X2KMAPtqmzyJHQ--.35872S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykXw4rKFWrAw1fCFW5Awb_yoWrWFy5pF
	WvgF90q3yv9Fyxuw47X3Wj9a4Y9ws5Aw43CFykG343Aa1DJr4fWr1xKF909F1Y9r1xJFZ5
	XF1rWrZ7Cw45Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtPEhUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7g28DWr7AI0FFQAA3e

parport_claim() takes port->cad_lock with write_lock_irqsave() and holds
it until the end of the function.  When the device that gets the port
was queued on the wait list (sleeping in parport_claim_or_block(), or
having a wakeup callback), parport_claim() takes it off the list under
port->waitlist_lock using spin_lock_irq() and spin_unlock_irq().  This
usually runs in the context of the previous owner, when
parport_release() hands the port over.  spin_unlock_irq() enables local
interrupts unconditionally, so the rest of the cad_lock section (setting
port->cad, daisy chain selection and ->restore_state()) runs with
interrupts enabled while cad_lock is held for writing.

parport_irq_handler() takes read_lock(&port->cad_lock) for every
interrupt on the port's line, including shared PCI INTx lines, since
parport_pc and parport_serial request the IRQ with IRQF_SHARED.  If
such an interrupt arrives on the same CPU inside that window, the
handler spins on the lock held by the code it interrupted and the CPU
locks up.  The early unlock also turns interrupts back on behind the
back of callers that hold their own spinlock with interrupts disabled,
such as imm_wakeup()/imm_pb_claim() and ppa_wakeup()/ppa_pb_claim(),
which call parport_claim() under spin_lock_irqsave(&arbitration_lock).

Reproduced on v7.3.1 (share.c is unchanged in mainline) in QEMU with the
emulated ISA parallel port (parport_pc, IRQ 7 from ACPI PnP), as a user
in the lp group with two ppdev openers: one holds the port, the other
blocks in PPCLAIM, and the holder closes its fd.  Lockdep reports:

  WARNING: inconsistent lock state
  inconsistent {IN-HARDIRQ-R} -> {HARDIRQ-ON-W} usage.
  ...
   _raw_spin_unlock_irq+0x28/0x80
   parport_claim+0x692/0xc80 [parport]
   parport_release+0x5c0/0x7c0 [parport]
   pp_release+0x37c/0x980 [ppdev]

and CONFIG_DEBUG_IRQFLAGS adds "raw_local_irq_restore() called with IRQs
enabled" for the final write_unlock_irqrestore().  When the closing task
runs on the CPU that handles IRQ 7, that CPU spins forever in
parport_irq_handler() -> _raw_read_lock(), on top of
parport_pc_restore_state() running with interrupts enabled.  QEMU
raises the port interrupt on the control register write in
->restore_state(), so there the hang happens every time.  On real
hardware the interrupt has to arrive inside a window of a few
microseconds; I have not tested real hardware.  With this patch the
same test runs clean and the port interrupt is still delivered.

Interrupts are already disabled at this point, so use spin_lock() and
spin_unlock(), as the "blocked" path in the same function already does.
waitlist_lock is never taken from hardirq context.

Found by LLM-assisted static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202608091622.jlJn0jOj-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/parport/share.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index eb0977ca1..d1b9f17d1 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -999,7 +999,7 @@ int parport_claim(struct pardevice *dev)
 		dev->waiting = 0;
 
 		/* Take ourselves out of the wait list again.  */
-		spin_lock_irq(&port->waitlist_lock);
+		spin_lock(&port->waitlist_lock);
 		if (dev->waitprev)
 			dev->waitprev->waitnext = dev->waitnext;
 		else
@@ -1008,7 +1008,7 @@ int parport_claim(struct pardevice *dev)
 			dev->waitnext->waitprev = dev->waitprev;
 		else
 			port->waittail = dev->waitprev;
-		spin_unlock_irq(&port->waitlist_lock);
+		spin_unlock(&port->waitlist_lock);
 		dev->waitprev = dev->waitnext = NULL;
 	}
 

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

