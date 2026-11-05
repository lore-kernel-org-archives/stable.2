Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893276;
	b=ccF84848M4oendVw+3LoIGG7nmItUK7F7Kt0bDYCkAgHmxF8gsyfx56WfACf+/P7M7Vm
	 LdhSxQOUjfzRttg1Aao6T6+PKovQoCJ1iuaOcSBvCPbVVIL/Ls/uI3tFym4YFBqg878e7
	 bA7GL9R91Czq3MY10UD3GHdOkGp+9Q4C9ki360Jz4nWQN6v0r+FeqnEGiUXeo6i00YUZj
	 wJ36mTtG7LAjObbz+BKrKFD9v6wyquYaBPUJd4f4cIWgHQaluemdRAADXKoWf7hwkaJhx
	 oItKg9OZQCeAx+4rCBLW09OKOdb5oSxQQ1viVIYips7F+1c9ttPxJrST1WnIoNmYUGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893276;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=r3AP3t6GqHgFMQ1XdVu4Hhyjy6C+AgYC+TMVyHZ5Uy4=;
	b=5HBjsSbxPyc04y9vzWeNawIwpAcf4Rjdn0DA1CieomW8JH6fhzi1bFHC3KAofTM0vItD
	 2ZNPjaHfR+62Mq6rbHlhMzbyvVmHNAODhTtrjnWOO7xviH/1x8dldahE20ZJKEHYsfccL
	 1DYvj7pOzVPfroyEsoztEa979hGGo2bM6kcszFNCGc9WLqq6CQLWXpyLKX/u3Uj8EwMMT
	 qjLA38Pgv3kbe9hS4U0RweSJjy5OQEtnbyj3iEre+Wrysh+cs7fYwMkwjB6z02gIbYxiI
	 RRWF1ZK4uYXaI5SZpNBwumhNWgkzd2z4CVQyVzuBd+UfKqVQyaY8TGa7O4mUfCo4I+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB411606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB411606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67be9601f31so1630716d50.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893275; x=1794498075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3AP3t6GqHgFMQ1XdVu4Hhyjy6C+AgYC+TMVyHZ5Uy4=;
        b=yAFU6GD0/T6HN7ps7j2rxNTkZsFA9o2tjslzFYAmAp7b4sMHemkkceGl9DLrfdJoTO
         gwGvLdGH1Zm+Rt6r7e4WQRr2AIsTkg18Fd1C5JlG4/aOZoxdTm7vJQGQwZiznx5/+VjS
         GlbEf/UT7E5kE+U/tyXVJG0wNsCfUZ1M72zKOAZ5TlKYYxT5SqIKXKidKaNMDES1+HnK
         STauiLpLHydMwTOPAwrr9mj7C5dQ26P5Rbkbe0LexizWt+nTy7fr6GLzEYCjrjacLNdy
         VYVP6D6xuhFS2qEQVtl5tsPKOHd/R7BeQ0aK4B6pWgmzyoYJ5Hljf2FE0jBcUIjRLThK
         iVpg==
X-Forwarded-Encrypted: i=1; AKwUvBy8QcSeLocQTPDe88H0eH2A1mrpMQIYOjXK5u82G8+Un+F/eLNqN1ovRNjcMHB5TVuKQotSf98=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j1FN4bpa/zZMbvrZVHrgT3zcCntYCwPbaW64F8NDemJqsoNS6
	Toa31ooJezUnsTCowJpnleO46Mb4ol+rYciGz/ik100HDrxF+k/NnvOs
X-Gm-Gg: AYBFou26/Ko02QOiNunZPTmHTsQKFS2JGHRwdxYx17cdZ7A5PR4iT3KUPcAQAXdVzdA
	NPGirJR7DYwPPBO7zlZ+bU9FH/928wEEWpqabR9HmdMD3yzuA3OgXl8yfvrVslBqEMW8fyi53rM
	MkK6NnTGwrSN3Y/PerX/IV8fvBxiVdT/95CryfSQ5ueu75PY91C8d2fWw1QtImTNZhhCHXBctXg
	mzMOlaR1KKCzGTtqt5i/9zwyNiLYSWOJrpZcpDWPQU9dUWdt7o4EY0ArI1srNVTo9R1WEy0PWX+
	r75vO17qA5yMZJ9SplHBK65DennAY8zOKwHgmbvdnYB6c1EAXi1bQk/pmavHNQGrCvvppltA6aI
	21qs+4Bjl4tjU4MpN+vsZ8/yDRlZDztNOsu6HWbF7XC/lsk0yQC9ohXiEGC/uvcV2c+7BPGogxg
	tPVemngEd7NmUkzhAz9gp8Cw3NwVAucj3ua1d2ACSlrVR336p8YKfeaQaKMwgtMO1FNneuSqE9J
	9MjADvvb0OGpupn4kKPCmnU0Hg3R+XDN/9DsTvCwxeMOaNseNfOnS1qt7fFpQbUYwsXr1m7wWR5
	ielwVnUUcIZF9g02VLc=
X-Received: by 2002:a05:690e:1698:b0:67b:9051:e334 with SMTP id 956f58d0204a3-67bb304d942mr9266532d50.99.1793893274539;
        Thu, 05 Nov 2026 07:41:14 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:54::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee27bfddsm3766424d50.15.2026.11.05.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:41:14 -0800 (PST)
Date: Thu, 5 Nov 2026 07:41:12 -0800
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	James Morse <james.morse@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, 
	Linus Walleij <linusw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Huth <thuth@redhat.com>, Dawei Li <dawei.li@linux.dev>, 
	mrigendrachaubey <mrigendra.chaubey@gmail.com>, kernel-team@meta.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: sdei: Preserve the interrupted context's
 exception registers
Message-ID: <auyjSmtuqkXCqMvl@gmail.com>
References: <20261105120835.3321912-1-kirill@shutemov.name>
 <20261105120835.3321912-3-kirill@shutemov.name>
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
In-Reply-To: <20261105120835.3321912-3-kirill@shutemov.name>

On Thu, Nov 05, 2026 at 12:08:34PM +0000, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> An SDEI event is dispatched by firmware regardless of PSTATE.DAIF, so it
> can interrupt the kernel where the exception registers are live:
> 
>  - exception entry, before kernel_entry has saved ELR_EL1/SPSR_EL1 and
>    before the C handler has read ESR_EL1/FAR_EL1;
>  - exception return, after kernel_exit has loaded ELR_EL1/SPSR_EL1 and
>    before the ERET.
> 
> An IRQ or pseudo-NMI cannot arrive there with PSTATE.I set. Firmware
> saves only x0-x17, PC and PSTATE around an SDEI event, so a synchronous
> exception taken by the handler overwrites the interrupted context's
> ELR, SPSR, ESR and FAR. do_sdei_event() only notices that ELR changed,
> and warns.
> 
> The interrupted context then carries on with the handler's state. A
> task interrupted on its way into the kernel can be sent SIGILL for the
> handler's kernel data abort. A task interrupted on its way back to user
> space ERETs to EL1, at the handler's fixup address, with user registers
> loaded.
> 
> With SDEI delivering NMI backtraces, this happens in normal operation.
> The handler runs show_regs(), which reads through possibly-NULL pointers
> with the _nofault() accessors. print_worker_info() faults this way for a
> kworker that is not running a work item, and a single sysrq-l warned
> once per such kworker.
> 
> Save ELR, SPSR, ESR and FAR in __sdei_handler() before
> irqentry_nmi_enter(), which can take an exception too, and restore them
> after irqentry_nmi_exit().
> 
> Once they are restored, a nested exception is harmless if its handler is
> safe in NMI context. That holds for EL1 data aborts on translation,
> permission and access-flag faults, which never take the mmap lock in NMI
> context, and for BRK. Warn once, with the syndrome, about any other
> exception class.
> 
> Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry code and CPU masking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Tested-by: Breno Leitao <leitao@debian.org>

Tested on NVIDIA Grace (firmware SDEI) with next-20261104, KASAN + lockdep,
ARM_SDEI_NMI=y: sysrq-l under stress-ng, with a kprobe on show_regs() and
eprobes on irq_disable/irq_enable that fault on purpose.

Without the series the box crashed (a task interrupted in el0t_64_sync
got the handler's BRK, then lockdep/KASAN fallout and a hard lockup)

With it, KPTI off and kpti=1, ~4000 kprobe hits and ~5500 faults in
irqentry_nmi_enter()/exit() produced no warnings or stalls.

