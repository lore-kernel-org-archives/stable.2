Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988709;
	b=dIZfquaPlwuzPQsnszi940wdA8ua0wmjs+men/RJLfw7rTIPqKqj1eBxs7xxbN8qmSwB
	 CQCiRvcn06CMzQAc1HdOnDTIV+giHmkBC3lrOrHb52lhj1G+jD5wp0x2lOoOHX/UPb1hu
	 zT94tyRLAG7UhAS+Rqsa7U1HyOPSHZ/OvC4JHDWFth6G/YRf5XPcZOl20GPxx3zviVekr
	 udK6LHts9ntBZrg2gDIASTeTC5qkQh99MGp5vpP0NJRuazZI4yPtQRMYDq4HBHu1Y18cy
	 hZBaT2KK6MSLE4kshQCDaajdYYIcc76RlX8Trz9rzyeN+EnRCRqFBbwW+rPl1YntbTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988709;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=6us6rjoIvGLVE20T/fcNhfH3xwzBqksxB+6Fe115Gvs=;
	b=EXwWHA1xtCumYp10+WtLrmNIek5PelGuEXDLcQnG3XchNuJ8x6IJl3u/A1FCA4fgbumP
	 1fAQQq/B45E0yAPOuU+SS19LFvGCeS9xn27y6WIzfGCI5S/N64iNPeHJySSi02/NiB9CU
	 nuFO3aNE1oJf8jeHZIGKfEoE24YP1IDnQDaN11Ltb1JimbdT9AHH3Gyo9UN14wbZXtKKR
	 wNbOf0t62kEtKTFJWsaNurX3HN+Z5dT8f3IAfTo8o3zamgjAADO2fTYiMVKpOV1A3Yu9y
	 ftYyOG+9O1+TkKBw5wbEXf7jDywq3FSfewxfNcL4OPRnnSXyN4/+sqDA5CV7FCr/Ayg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d6mF5wID;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD280606A31C;
	Wed, 18 Nov 2026 07:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD280606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d6mF5wID
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6u
	s6rjoIvGLVE20T/fcNhfH3xwzBqksxB+6Fe115Gvs=; b=d6mF5wIDk8qmkR3pbT
	KEF97ncD8LpnA4n4cKWdtVD9ke+iJYggaToDIG6JHylIJEtv0J8f3JWJtgxtzVpZ
	8XbG/LI28QIR+/tLqkJyaIGkf/Bn2AU5iy8RHzv8sgwVEb7Si8+cpCo8YnPgLGTM
	uY6KPG95cLV8+w6zTL33XUw30=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDn10OYWv1qJJPjGg--.59937S2;
	Wed, 18 Nov 2026 15:58:17 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] parport: do not re-enable interrupts in parport_claim()
Date: Wed, 18 Nov 2026 15:58:16 +0800
Message-ID: <20261118075816.2323688-1-zihengw03@163.com>
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
X-CM-TRANSID:PigvCgDn10OYWv1qJJPjGg--.59937S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF15ZrW7CrW3Cw4Uuw43trb_yoW5GrW8pa
	4vga9Iga40vFyxua17Xw1jkFWjva1ktay7CFy8GwsrAa1UJrW3Ww18KF9IvF1Y9r1xXFZ8
	XF15WrZ2yw45AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jMT5LUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7hrWJ2r9WprMJAAA36

When the claiming device was on the wait list, parport_claim() takes
it off the list with spin_lock_irq()/spin_unlock_irq() while it holds
cad_lock with interrupts disabled:

  parport_claim()
    |
    | write_lock_irqsave(&port->cad_lock)     <- IRQs off, cad_lock held
    | spin_lock_irq(&port->waitlist_lock)
    | spin_unlock_irq(&port->waitlist_lock)   <- IRQs on too early
    |
    +---- port interrupt on this CPU ----+
    |                                    |
    |                                    v
    |                        parport_irq_handler()
    |                          read_lock(&port->cad_lock)
    |                          spins forever: cad_lock is held
    |                          by the code it interrupted
    |
    | write_unlock_irqrestore(&port->cad_lock)  <- never reached

Interrupts are already disabled here, so use spin_lock()/spin_unlock(),
like the "blocked" path in the same function.

Found by LLM-assisted static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    v2: shorter changelog; drop the kernel test robot tags.
    
    The bug was found by the static analysis above.  The kernel test robot
    had sent a smatch warning for the same code to oe-kbuild only, which I
    found afterwards and credited in v1:
    https://lore.kernel.org/r/202608091622.jlJn0jOj-lkp@intel.com/
    
    Tested in QEMU (parport_pc) with two ppdev users, one waiting in
    PPCLAIM while the other releases the port: lockdep warns without this
    patch and is quiet with it.  I have no parallel port hardware.
    
    On real hardware this needs two users of the same port and a port
    interrupt within a few microseconds of the hand-over, so it is
    unlikely to be hit; lockdep reports it whenever the path runs.
    
    The changelog was drafted with an AI assistant and reviewed by me.

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

