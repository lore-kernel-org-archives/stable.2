Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985475;
	b=1Dbxh84NZKypaY/mW8rBSvLIDeZC5bLv+Dwq1Cl5WrkaD1m1ZSukv1QXvWcDPBX8gepv
	 q3UYs2eOatbgYkW8PoqCGVKL2QsaA2z3ArQp0mwUkg0OqRzLlqDYhuSLrDnh5kYJRlc6K
	 e2Sm98wy8ZAayOTQ8M3/Q4GesmVEqSJhU4gsfFOCCd1W72jMA3oRgZ4P/i+dpPejuyjDU
	 GJGgnhsTOUIzKWcq54WmzlpZXR8Qtm8254cl9YIj8WrFAw1frnKCQtiwyEXMx760avLtF
	 jzPCtWJ6kUamyvA8ZxmB7Yi2Be4UZLpAFn/yHczQ59bQ+VCtbofIBUfe4MC+AdYMYeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985475;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IBidLxKze/cF8OVvvB427zi7hZyK+UPFvN3ze2Fv1zA=;
	b=gavCApqqTzQkbItrUb8tuzdaFeOiE2azEzc1SBf0egiMrqR9OUxeOzeIoxJ9qVjYMpeQ
	 F1GPlvzPkgIxVAUJEyR86vKyU3OjJhm6T7QnDLSpztWv/jtvlRCmfhxpNtXI4wqzpJ1ny
	 TzEZLcHH3O+S45izzAYhUjgsAPbY3eJaup7DMhy0C0KgddWHLFv6gLUuobmMAgM6quoKo
	 6HQoVJqM6vAntIpo2PznZJw5sJUyb+nDtvvFlF7rmxiqtMw8y8JNfp/yEXYtvpjz0oT/o
	 ne1ZjdPtJvos1nm4DSAkN/t0epL/927nop71lCVvwCEE9SoY3eQDJp4HotAdbN4Co3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nVANFmqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F1606A325;
	Wed, 18 Nov 2026 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nVANFmqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5C21F000C4;
	Wed, 18 Nov 2026 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794985475;
	bh=IBidLxKze/cF8OVvvB427zi7hZyK+UPFvN3ze2Fv1zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nVANFmqjCHuT6xyOCPyWXpqxR/wQzG+X8JBZqZuBFeGJuXpIWqRFi7hHbKYRi9adD
	 UKP8Jg6RH61vQH1wBol8DZZh3Z0lSeBgYKywCIkt4BSXILjqGcUBZBZIyF3EgbOfCH
	 a4UarIhNGM3yvNnhXd2PpEsTOncxFsEog9/b7ego=
Date: Wed, 18 Nov 2026 08:04:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ziheng Wei <zihengw03@163.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] parport: do not re-enable interrupts in parport_claim()
Message-ID: <2026111838-snowshoe-latch-1c25@gregkh>
References: <20261116130930.1629208-1-zihengw03@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116130930.1629208-1-zihengw03@163.com>

On Mon, Nov 16, 2026 at 09:09:30PM +0800, Ziheng Wei wrote:
> parport_claim() takes port->cad_lock with write_lock_irqsave() and holds
> it until the end of the function.  When the device that gets the port
> was queued on the wait list (sleeping in parport_claim_or_block(), or
> having a wakeup callback), parport_claim() takes it off the list under
> port->waitlist_lock using spin_lock_irq() and spin_unlock_irq().  This
> usually runs in the context of the previous owner, when
> parport_release() hands the port over.  spin_unlock_irq() enables local
> interrupts unconditionally, so the rest of the cad_lock section (setting
> port->cad, daisy chain selection and ->restore_state()) runs with
> interrupts enabled while cad_lock is held for writing.
> 
> parport_irq_handler() takes read_lock(&port->cad_lock) for every
> interrupt on the port's line, including shared PCI INTx lines, since
> parport_pc and parport_serial request the IRQ with IRQF_SHARED.  If
> such an interrupt arrives on the same CPU inside that window, the
> handler spins on the lock held by the code it interrupted and the CPU
> locks up.  The early unlock also turns interrupts back on behind the
> back of callers that hold their own spinlock with interrupts disabled,
> such as imm_wakeup()/imm_pb_claim() and ppa_wakeup()/ppa_pb_claim(),
> which call parport_claim() under spin_lock_irqsave(&arbitration_lock).
> 
> Reproduced on v7.3.1 (share.c is unchanged in mainline) in QEMU with the
> emulated ISA parallel port (parport_pc, IRQ 7 from ACPI PnP), as a user
> in the lp group with two ppdev openers: one holds the port, the other
> blocks in PPCLAIM, and the holder closes its fd.  Lockdep reports:
> 
>   WARNING: inconsistent lock state
>   inconsistent {IN-HARDIRQ-R} -> {HARDIRQ-ON-W} usage.
>   ...
>    _raw_spin_unlock_irq+0x28/0x80
>    parport_claim+0x692/0xc80 [parport]
>    parport_release+0x5c0/0x7c0 [parport]
>    pp_release+0x37c/0x980 [ppdev]
> 
> and CONFIG_DEBUG_IRQFLAGS adds "raw_local_irq_restore() called with IRQs
> enabled" for the final write_unlock_irqrestore().  When the closing task
> runs on the CPU that handles IRQ 7, that CPU spins forever in
> parport_irq_handler() -> _raw_read_lock(), on top of
> parport_pc_restore_state() running with interrupts enabled.  QEMU
> raises the port interrupt on the control register write in
> ->restore_state(), so there the hang happens every time.  On real
> hardware the interrupt has to arrive inside a window of a few
> microseconds; I have not tested real hardware.  With this patch the
> same test runs clean and the port interrupt is still delivered.

This is a wall of LLM-generated text.  Please make this sane and
concise.

> Interrupts are already disabled at this point, so use spin_lock() and
> spin_unlock(), as the "blocked" path in the same function already does.
> waitlist_lock is never taken from hardirq context.
> 
> Found by LLM-assisted static analysis.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: kernel test robot <lkp@intel.com>

this tool found this bug?

And testing on real hardware would be best.

thanks,

greg k-h
