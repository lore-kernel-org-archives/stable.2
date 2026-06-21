Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17122D4D3;
	Sun, 21 Jun 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782024783; cv=none; b=LY1zOaZn0zkhibBlWJ6/Zbg0SDpu1PAobb6JYfMXzvyebTAx8OUzn9VUjXdi3Jfyd+D143WAgtNyk+307+Yze+fn+j/zqkN98KoGsj6ulM37fJSStCxZ6Ow+PrXL0cv9kZtDLnAA1q4sD9V9nQSENXuNTM8SIR4SLugkHQPri2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782024783; c=relaxed/simple;
	bh=mcgY91mtlCV7mO4t17/Nb5Fj4D+C77woGH/eBwcvrHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVp+Vj/+BKxV3x3P275tXbY99XZFdFZLFpb7BRHwZpat/retXL+74zj8+YPx3k9sK3YSEr2x5ztPch+U4if/NhcC+UBLvlOE/oa+rBbEDRgztTHf6eRQuTYkxNChxjlmBnQSojXOpA3C6xd3UrL2sxluezb1ZVrhGhkN+20g5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3KSZhin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3KSZhin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8281F000E9;
	Sun, 21 Jun 2026 06:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782024781;
	bh=JhZlBu9SdfAZGdDjAMHbR85c9tDS0ug0vz9c84b8zSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T3KSZhini09jmdcT1J2c7Gan8C+du4ROFAnbeyot1K8YN7d0Aqw7e4RpHDdZlSWz5
	 VZjXtW5/W0RI/7Zhl+GAaIxKBlOdLaKQ2u7ZVE2Ux2uJAkO6ELu7Vhz35vosaWPpJL
	 0xNrhvihUXiaLKUKAJKcPn/Cf+yzkGKMoGCAZ2gJ9wfFCqnlZlLDHFD1WInwJhouvy
	 7LREb4B5oS7DwPNFcGgM0diT6l5o2A6syHwALTxgxI6GGLXFXn0h6COUN05WIe2UvM
	 IzQ4rCXui2c2bGEtpegfM3113rSZWsVA8/Vuh+IfR0d/MeNZ7yuLQcYxLYHUbuOkVK
	 6SIz2LikfVxfA==
Date: Sun, 21 Jun 2026 02:52:46 -0400
From: Guo Ren <guoren@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
	peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
	heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
	falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
	atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
	palmer@dabbelt.com, bjorn@rivosinc.com, daniel.thompson@linaro.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Message-ID: <ajeKPpg2rwadVPY4@gmail.com>
References: <20230702025708.784106-1-guoren@kernel.org>
 <202606191652.38297DE51@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202606191652.38297DE51@keescook>

On Fri, Jun 19, 2026 at 04:54:53PM -0700, Kees Cook wrote:
> *thread encromancy*
> 
> On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > The irqentry_nmi_enter/exit would force the current context into in_interrupt.
> > That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
> > debug the kernel.
> > 
> > Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
> > of the kernel side.
> > 
> > Before the fixup:
> > $echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
> >   lkdtm: Performing direct entry BUG
> >   ------------[ cut here ]------------
> >   kernel BUG at drivers/misc/lkdtm/bugs.c:78!
> > [...]
> >   Kernel panic - not syncing: Aiee, killing interrupt handler!
> 
> This appears to still be unfixed. What's the blocker? The solutions in
> this thread seem to work...
> 
> I'd like to be exercising an Oops path via KUnit (for KCFI), and riscv
> just instantly falls over instead of thread-killing on the exception.
Thanks for reviving this thread. At the time I didn’t fully understand
Peter’s point. We should only use the NMI path when the trap occurs with
interrupts disabled.
Here’s the updated fix:

 do_trap_break(struct pt_regs *regs)
... 
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
+		if (regs->status & SR_IE) {
+			enum ctx_state prev_state = exception_enter();
 
-		handle_break(regs);
+			handle_break(regs);
 
-		irqentry_nmi_exit(regs, state);
+			exception_exit(prev_state);
+		} else {
+			irqentry_state_t state = irqentry_nmi_enter(regs);
+
+			handle_break(regs);
+
+			irqentry_nmi_exit(regs, state);
+		}
 	}
 }

If you & Peter have no objection, I’ll post a v2.

Best Regards
  GUO Ren
