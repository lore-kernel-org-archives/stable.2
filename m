Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605981;
	b=IVV/IhaagnXTuPXq3RUw4mDyyAvAKjOwWw7w1dRaqb+rDYMuusM6QEWPEs3eqpaXF7Xv
	 EagtBJQiPIwg3/rOtmJPXayZUw1HtdyQDvtu3zzZsL5k/3Zp2JgANd/gomrxwiUJ/pELU
	 p4HfuCy7KTn5yoLbGGQIjsEDVk3nMtSdufEzHvHaTIeflQgvO9puoCXKu8x1LvxXHn0Mm
	 7XxMLhf7W70YDZlhfI+of8h7kHiBSe2nEBaYZ2KWr05L7VuzBV+zOTGqsRNexhuSI3xEH
	 WwAREB0CJVplVrqqbE3qGQFwttywzPm5uA9BGxknKd8/mizDISpfvQ2Ct0A/3wGWlKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rDl21FEwKc8w1wUvpoWP8YurzYoH5QDYcY6p8dT/kgw=;
	b=g0GkeDrUEk1QHHY1tMEYyzV5h9qXL080EP/vrgNzJuJQzd7vPQqpW0McclmrEuyuRiaL
	 3L8lIBjpJ3YJfScRduMBKb3+2GzFekQuxALadP9W1Ase8HIDHvvE81eAN8yQ3ypi8PojT
	 0qpWVQQAZstWD7RYa/7kD7ZtJwA2MdyEnFDXklV72x6w/eTUlMWAOrQABp0y5olo8wipb
	 p6kh8lUZ1J9UuH3r2JWjmQ48w7dHLUg2kkyevjQU4qhB1Vt059eR/uElt02rEkfjqNJMm
	 4h3uCpSzMFBOi0nb6F8YaYEYa0OvPXog3ehY0NbshggCOLKKgDnIKr5a9wmrrX+azMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cj7xzYJ3;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E07606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74E07606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cj7xzYJ3
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38644aedba1so8591570eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605980; x=1796210780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rDl21FEwKc8w1wUvpoWP8YurzYoH5QDYcY6p8dT/kgw=;
        b=Cj7xzYJ3gSDH4Ay+OSuf4iWtR5EpdJhYyvSBnTTMDfcAz9wRgjAfbxobJ/yykFaD2a
         76e/gEJ4btLlcI9nudSZIFK1V5uKGEQHVE1mEjoo4o1xKDJ+BN2JCvobKHFHj3wvK1CT
         VBzpMQmBueBO4n34fkRE5vEEQJaS0lJCvyR95BVzTzdZBh0n5dHmrAS3p/bFUFewkEoC
         pHtLfsVULmuz18EmYG2lA5SZQlDHlouVUlKW1hjHzzPa+bYtKAv4SLYRLeyglGi7or0I
         U6Lq1b6tDicMgT7tbVAOZndRD5GdyOs246jvdDhgTFNSMUaV7tsQMDX1+C2i0E4uy5vq
         Pf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605980; x=1796210780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rDl21FEwKc8w1wUvpoWP8YurzYoH5QDYcY6p8dT/kgw=;
        b=w4EM/o+CkESHAhG49yApilNc/obkpM09LM+8Vf5IROA9SJkgMWWvOFe23S2lObm9e7
         zJDdBkyIau9T83pDO8AphSOUeuPY1p47UjgW1dFxOhcMA9WmG3qqeB2H6tKfYkkaNesF
         n85cJIXBcPGJ/nvQk8sLt6IGae0aWiF6RwjKemqmJsRROArbwOg6j8FiBZH+OEwOwArs
         1NAlgHgbKv7lyiUCqyqP6M2AF9DiHt4DlnQgbl5OnFvDI2jhGIGpUXKisA4kfqA+7mEr
         zm0ls7SniJpKZuvXO3JvePDCubxSem4nsVHjT9nIBGzWjyFcJZW0GNHa0RMGxy+yAx3z
         q3HQ==
X-Forwarded-Encrypted: i=1; AL+hErF+JjlVCUgte2Ie9op4YFHq+UioFi+iWnt/7Nhi2KUqJAthrSm932DUCmkDEUFfVSRj53DJL1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mNScyfEw87Q9TqxdxJc0n0V4Wtv1pjNL0YuOGDcr9UZLGs+t8
	HiOlF3iKXeZ+ocuzOXDWGbmjx8Ncn13di1HwhrJuoGN9H/FRXKPkr0x9
X-Gm-Gg: AZFdTZfXOXoYJAmoeEKTVCzPr1bO40DMLVRbUKrkqo8KhTBgoRzEeMMK7DeT5MVQji3
	R9xmwacO8uabicYmZopzq1z1bZDaMX1urWHSFzXyUYUCgZQl+jjRyxGL8H4kT0EUP+cQQ/jPgxM
	UD+8qNRhcQAJNfP54Q/wU6/LVkT3uz+kfCtc3pOKcHFb3f0qCBZwyefzn4PVcuUNVF+Tt371IM3
	dpPv+5HCCHdrQZ9uIFzUP4DeIlkGJtLcKy+rDHwSQRGaOIae71FBC1eR3+WCPvsl1vG7RvkZ23l
	jv8/6yzfl63vxgZt7CJKhTt3LYPV9KKcGiV4d3F+40oli/gkyVEDeJcs/SvCwgm1ZrkUbBQ9pIq
	v79APo9Sq8IxtbVYG8noWA3vckBBlux503awBCoecVS9M9xJ8n8QKn7Zikh9EXdQDczKU8ZF7lT
	PaC0F+5+nPG8R5rFBYMDJNWSZuAj4SATJIQYStIF1qH/uafY0MfudXAkRvBNe+uGBebaTJy5UoJ
	MsY/2Wt0XR0gG1ztRySrdq1eHspD62ANqXxuwtO9lwYYl/YSbXYD/oimLSU/RCbu3Fw2cbne9Ne
	NRKH4hI92f7RjmQzQ2h0BmhMMCj6jVd8umeG9iumyp+utGVpXTc5W+x2
X-Received: by 2002:a05:7300:7316:b0:386:c5d3:7300 with SMTP id 5a478bee46e88-386c5d37603mr5633447eec.12.1795605980290;
        Wed, 25 Nov 2026 03:26:20 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm11778380eec.17.2026.11.25.03.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:19 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCHv4 1/4] powerpc/64: Leave lockdep hardirq context around replayed interrupts
Date: Wed, 25 Nov 2026 16:56:03 +0530
Message-Id: <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795603946.git.ritesh.list@gmail.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
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

With PROVE_LOCKING, boot warns once and lockdep turns itself off:
  DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
  WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/0
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00027-g074831f06e18-dirty #123 PREEMPT
  NIP:  c0000000002b2f2c LR: c0000000002b2f28 CTR: c000000002426f90
  REGS: c000000004f075c0 TRAP: 0700   Not tainted  (7.4.0-rc2-00027-g074831f06e18-dirty)
  MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48022221  XER: 20040000
  NIP [c0000000002b2f2c] lockdep_hardirqs_on_prepare+0x22c/0x2d4
  LR [c0000000002b2f28] lockdep_hardirqs_on_prepare+0x228/0x2d4
  Call Trace:
    lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
    trace_hardirqs_on+0x98/0x11c
    irqentry_exit+0x64c/0x1064
    timer_interrupt+0x274/0x6bc
    __replay_soft_interrupts+0x158/0x380
    arch_local_irq_restore+0x1cc/0x244
    console_flush_one_record+0x438/0x654
    console_unlock+0xb8/0x1e0
    vprintk_emit+0x300/0x56c
    vprintk+0x20/0x34
    _printk+0x40/0x54
    lockdep_init+0xdc/0x104

The warning is triggered because trace_hardirqs_on() gets called while
lockdep's hardirq_context still says we are handling an interrupt. To
fix that, we need to ensure lockdep's hardirq_context and
hardirqs_enabled state stays consistent with powerpc's soft-masked
interrupt replay code and the generic entry/exit code.

With the current change, this is how the new state machine looks like:
                                       hardirq_context  hardirqs_enabled
  arch_local_irq_restore()
    trace_hardirqs_off()                     0             1 -> 0
    irq_enter()                           0 -> 1           0          (softirqs held off)
    __replay_soft_interrupts()
      lockdep_hardirq_exit()              1 -> 0           0          patch: the loop is not a handler
      timer_interrupt(&regs)
        irq_enter_rcu()                   0 -> 1           0          handler starts
        irq_exit_rcu()                    1 -> 0           0          handler done
        irqentry_exit()
          trace_hardirqs_on()                0             0 -> 1     legal: context is 0
      next_interrupt()
        trace_hardirqs_off()                 0             1 -> 0     still replaying: back to off
      ...                                 same for each pending interrupt
      lockdep_hardirq_enter()             0 -> 1           0          patch: restore for the caller
    irq_exit()                            1 -> 0           0          softirqs may run now
    trace_hardirqs_on()                      0             0 -> 1     IRQs really enabled

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Cc: stable@vger.kernel.org
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/linuxppc-dev/b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com/
Closes: https://lore.kernel.org/linuxppc-dev/20260922150619.lwWqj1AO@linutronix.de/
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/irq_64.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index d5c48d1b0a31..e2f1e5b7a3a7 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -76,13 +76,11 @@ static inline void next_interrupt(struct pt_regs *regs)
 	}

 	/*
-	 * We are responding to the next interrupt, so interrupt-off
-	 * latencies should be reset here.
+	 * We are responding to the next interrupt. The irqentry_exit() of the
+	 * replayed handler has traced hardirqs on, which also reset the
+	 * interrupt-off latencies. Trace them off again.
 	 */
-	lockdep_hardirq_exit();
-	trace_hardirqs_on();
 	trace_hardirqs_off();
-	lockdep_hardirq_enter();
 }

 static inline bool irq_happened_test_and_clear(u8 irq)
@@ -116,6 +114,15 @@ static __no_kcsan void __replay_soft_interrupts(void)
 	 */
 	local_paca->irq_happened |= PACA_IRQ_REPLAYING;

+	/*
+	 * The irq_enter() of our callers is there to hold off softirqs. Each
+	 * replayed handler enters and leaves the hardirq context itself and
+	 * returns through irqentry_exit(), which again traces hardirqs on.
+	 * Since lockdep only allows that outside of hardirq context, so leave
+	 * it for the duration of the replay.
+	 */
+	lockdep_hardirq_exit();
+
 	ppc_save_regs(&regs);
 	regs.softe = IRQS_ENABLED;
 	regs.msr |= MSR_EE;
@@ -168,6 +175,8 @@ static __no_kcsan void __replay_soft_interrupts(void)
 		next_interrupt(&regs);
 	}

+	lockdep_hardirq_enter();
+
 	local_paca->irq_happened &= ~PACA_IRQ_REPLAYING;
 }

--
2.39.5

