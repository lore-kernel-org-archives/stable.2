Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441932;
	b=kHgiXlY9AWEGf9GTHV55yxDnQFY5GX/9FwzOdr1G0MvQYB0+H5KRS9lebPbCOQxf89/P
	 YPt+PzD6yBdTh3kcdzKYC4xLN9hIk2ueo/26juYLtF+NUPZD6X3/i7jb6i7P/ygca/A98
	 w+0I1CxhhMI/hYqhC5k80vSkmV7d7XS203ktdyTu/iPV0yJ7pVRwxMVlBtuc8L2j8nGwn
	 zmz0IpsyAcfNheYP77k2zmMSoqfuA0pjqNGkoevMPPsUCogh/RBtw93uvTqXXWrreIxnS
	 QIUnd9jm69pTGVeTO2U1N+tfhuEV4rtKtTYFhwNnAcMuxnWNaJ3YY72QKnfrUMhIgdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oof5GyuBDmv010ouXiTTCY9eig+vBXwDQWGLktoTn48=;
	b=2G9p02qreGH3I5uKgeIioSe+2DOjFlJYKZ4qZqFuhowTDRF1AbVgf2QPt6RjvDDK5kPl
	 PLeVVYNFyuEac2HQ7egv5cuSNJQjQPxMDkw3/68Y36z+NcIS1Ckgn88vdgQbDzYEaFioR
	 6JYxCIFAsChj/J7+WbQvQPwmiRZuSrTokHf1pdzKb1UFNCZiOMvomm+wsK95sLEOfX80u
	 lWdJ1pFwZrTdTTh7OznYu8TFkOYjXc6P8ZkQysgExLyviLNu6gJ5k56NpAzobJ1FrLHd6
	 eOk/3XL9aWoAdHJsOizX25I9dAc9yvKPWAJJ2uE5TUIpd3j61famW2IYsRpEY9jcr5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YUGb/ntC";
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A7606A6B0
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F7A7606A6B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YUGb/ntC
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cddc250d815so1243304a12.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795441932; x=1796046732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oof5GyuBDmv010ouXiTTCY9eig+vBXwDQWGLktoTn48=;
        b=YUGb/ntC9+GMQEiaT2XdU9Z0SaeEFUkuUv7wtKOVp+KfOA/IwT0DSZIJDQsSrFwq7O
         Abd1KK0YPgp4qXIQn1YD9Z1jz34yYkl2S/fKxyI6AnyUR65uC4fByalD7JXupeGV7gkS
         TvlnN1VfKj/12MD9IxSiYBlYrtY4/Kmon7m9/gt+tDoDcv6qDPzqAcsCYQ1K5KuP4CIV
         j9f9JkY6Us7HW7ZQnF4aOo4do+ogsoWAjK1Le3aCx6jzFdVQi/yp5ziECWACVxDxnM4J
         K/bcudYyrI+dWoRjKe8vLOaUxNMf/2yVOZLsWKGLkBpSg2Tk9OpHWkUDUT1d88xEdzux
         O28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441932; x=1796046732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oof5GyuBDmv010ouXiTTCY9eig+vBXwDQWGLktoTn48=;
        b=ew/PiX6mE5UnrOGlD0L5N3f6DIIduQ9tPCE7VD3STiSMOEjBB4CdhPWq9pfDkDlkZy
         yxjeRJc5rZVgeS0VwRlEksmNHkXU2ZqIspZah//LcKSlHvl0MU8fG/aFpZ/62kHcITiE
         SjimcTL8vZIG0rKFHv1O1nqthoeSebIwdl9ZuferBlBzmfpS4F6Rjek/vnKnKAiUo/Oy
         0Mz4m4Z/Azn4C+OQNT/YrF43AmoIEgpfH7KZBXw6pG1HmdY7p6USDcDy4t1qEJ4lxa9e
         REGw84KRSME803U62NdTy2A7c+1PNttcgloOVa40xQkvL4WzzHVSOXA0kIcqNEs9p3D5
         MllQ==
X-Forwarded-Encrypted: i=1; AL+hErECpuXNRfOtEeNrcwzc0fWNWozqCG3ZXMZdp09MCrJdjs+0zVqXSFC15hmvPeisuEJp33uyKDg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Zy8jHYsgXEfy/dm0ffQ1zoLRO5uk7x0UkgsqrFlIgafIOuh0u
	bes7ty/GTeIYnbnf+NT1I9HNpNsLkPRFHlK+1SkQzLyS1yb1TjAYhVFj
X-Gm-Gg: AZFdTZea2e+ltKaeJjgEQ84dB3ZSW1rIpft/oapVhh67exovbgVG6wlIjqlc8/XN6jW
	RaxcFw7LGAJjbrYQmg4eLi7uagdB8FQMV0zWd+6AGKi7bkoYWOxo8ZFr4hweDgHZ0erk+ULEC3h
	Bgec1nD/mnmPCokcz5PBlBYANcf6qP9sa3dnsMxxZyequ2lOsrJKDyN/1yt9w8f8Da+D58zkkfU
	Qc2IGmP+niBzjPApmXCmBQqg8Q+uCvj4E0OlbZvW8bfwYvTpb3DdPfqGV17SVSte3nsNd5WxzGS
	ypuFl2x3raboV34+A7pYlEjPXwt3AQBWTXPuo1fnJ3QsrTAtHQbksipVIeRxdDlGucYlD0MNPLQ
	Xtz3zQlcPwBHWs3xF0Cuq5W0SgcF3DcZ2hxwIiAJfZHD8qrWb4jKrnQ//RoGf3pekBsvr7HjwwG
	hG+9a/9ioaUV2gGPFHw07/dJrmBFeAXoVJa5A/3qsMeDprQPOuS/ENAXydBwTd6IUkrJhHZpEtq
	ebiH5CifYgc5lpmES3GcFoC2ee8RQP7qRl2sBMCBGwvk8SyKzCtj4ZaASGx32mEyap5V8jumgjD
	gOIgAHsmG9AeMNXmi8kd40+KimKFZAwOrjA=
X-Received: by 2002:a17:90b:4a47:b0:3b3:fc1f:a5c4 with SMTP id 98e67ed59e1d1-3b41c8dc821mr10570164a91.20.1795441931768;
        Mon, 23 Nov 2026 05:52:11 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm20842512a91.14.2026.11.23.05.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:11 -0800 (PST)
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
	stable@vger.kernel.org
Subject: [PATCHv3 1/4] powerpc/64: Leave lockdep hardirq context around replayed interrupts
Date: Mon, 23 Nov 2026 19:21:50 +0530
Message-Id: <57a5455331a768ffe7d66409ea228d31e9ec1edd.1795441238.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795441238.git.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
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

