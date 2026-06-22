Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD83A545E;
	Mon, 22 Jun 2026 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123955; cv=none; b=T4jpwEsJl6yAMRkuLeufPO6bAlyPD3uWduNpyIWE+hbmkLZqs7EHZveqLWga8vwd5Q/a/xofAxEkit2QBSkLe7uN88i8SBiYRNqiyjBBl+wYttQo3iZXOLWwP2WQfSs57ZQO+DAkzqMiYPE0qxWYrplCFZ0Emsutf/Tji9oZsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123955; c=relaxed/simple;
	bh=iN2N/e3dZW+kPQjRl36cn7UsVIeGGeCWu7/JO1xDn3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ef0R4cAsUSdhTpxPfHOFRJ5dh+oUaR/QTuGFjjN6r9jjB5u1+S6baKMC73XUGx3VZ4GQ3r17Kn6Lb23hBBMVq6oH2ixoQDENqTV244siMhy2iMsfih8HdL7YqVwiIFlszT6on0HgJRBqNlaHzBun/yEcIEGfBgJsiX10wJTwuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [123.118.218.239])
	by APP-05 (Coremail) with SMTP id zQCowAA3nN+JDTlqtLaqFA--.57426S2;
	Mon, 22 Jun 2026 18:25:14 +0800 (CST)
Message-ID: <2f32370b-63c1-4e8a-bf71-d40874b6bebb@iscas.ac.cn>
Date: Mon, 22 Jun 2026 18:25:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
To: Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>
Cc: Kees Cook <kees@kernel.org>, arnd@arndb.de, palmer@rivosinc.com,
 tglx@linutronix.de, luto@kernel.org, conor.dooley@microchip.com,
 heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
 falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
 atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
 palmer@dabbelt.com, bjorn@rivosinc.com, daniel.thompson@linaro.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, stable@vger.kernel.org,
 Guo Ren <guoren@linux.alibaba.com>
References: <20230702025708.784106-1-guoren@kernel.org>
 <202606191652.38297DE51@keescook> <ajeKPpg2rwadVPY4@gmail.com>
 <20260622082841.GW49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260622082841.GW49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3nN+JDTlqtLaqFA--.57426S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4ktFy3KFW7Cw4fCrykZrb_yoW5CFWkpF
	W3Kay2kF4kJryxZwsrKw40vF9Yka4SqF4rCr45tryrJw4avr1SgFs7trW3KFWDZrW8Wr12
	vFy0q3srua4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUvaZXDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 6/22/26 16:28, Peter Zijlstra wrote:
> On Sun, Jun 21, 2026 at 02:52:46AM -0400, Guo Ren wrote:
>> On Fri, Jun 19, 2026 at 04:54:53PM -0700, Kees Cook wrote:
>>> *thread encromancy*
>>>
>>> On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>
>>>> The irqentry_nmi_enter/exit would force the current context into in_interrupt.
>>>> That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
>>>> debug the kernel.
>>>>
>>>> Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
>>>> of the kernel side.
>>>>
>>>> Before the fixup:
>>>> $echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
>>>>   lkdtm: Performing direct entry BUG
>>>>   ------------[ cut here ]------------
>>>>   kernel BUG at drivers/misc/lkdtm/bugs.c:78!
>>>> [...]
>>>>   Kernel panic - not syncing: Aiee, killing interrupt handler!
>>> This appears to still be unfixed. What's the blocker? The solutions in
>>> this thread seem to work...
>>>
>>> I'd like to be exercising an Oops path via KUnit (for KCFI), and riscv
>>> just instantly falls over instead of thread-killing on the exception.
>> Thanks for reviving this thread. At the time I didn’t fully understand
>> Peter’s point. We should only use the NMI path when the trap occurs with
>> interrupts disabled.
>> Here’s the updated fix:
>>
>>  do_trap_break(struct pt_regs *regs)
>> ... 
>>  		irqentry_exit_to_user_mode(regs);
>>  	} else {
>> -		irqentry_state_t state = irqentry_nmi_enter(regs);
>> +		if (regs->status & SR_IE) {
>> +			enum ctx_state prev_state = exception_enter();
>>  
>> -		handle_break(regs);
>> +			handle_break(regs);
>>  
>> -		irqentry_nmi_exit(regs, state);
>> +			exception_exit(prev_state);
>> +		} else {
>> +			irqentry_state_t state = irqentry_nmi_enter(regs);
>> +
>> +			handle_break(regs);
>> +
>> +			irqentry_nmi_exit(regs, state);
>> +		}
>>  	}
>>  }
>>
>> If you & Peter have no objection, I’ll post a v2.
> I still don't understand it. This cannot fix anything. Consider:
>
>  EBREAK
>  raw_spin_lock_irq(&your_lock)
>  EBREAK
>
> So now the first 'works', but the second will crash. Additionally,
> having the EBREAK context differ so dramatically between invocations
> seems like a very bad deal to me.

To spell it out, the problem that needs fixing is:

-> BUG()
   -> ebreak instruction
      -> Breakpoint exception
         -> do_trap_break()
            -> irqentry_nmi_enter()
            [ now in_nmi() / in_interrupt() ]
            -> report_bug() returns BUG_TRAP_TYPE_BUG
            -> die()
               -> make_task_dead()
                  -> panic() because we're in_interrupt()

As such, currently on riscv all BUG() simply completely panic() the
entire machine, rather than just killing the one task.

How do you think this should be fixed? Here are some ideas but I'm not
familiar with generic entry stuff:

  * Should we irqentry_nmi_exit() before calling die() for BUG()?
  * Should we move the GENERIC_BUG trap instruction to cause illegal
    instruction exception instead, for which we can write a simpler
    handler that doesn't need to care about the probe stuff?

Vivian "dramforever" Wang

