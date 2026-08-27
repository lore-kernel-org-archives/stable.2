Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9C3AB47E;
	Thu, 27 Aug 2026 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871978; cv=none; b=euV8/JuG95lnMN8Kf8bm2fq3Rvd18P8d0unzsphlC/cdZM8UevLHMCOlXRTU2PxIcqOCKZctqvZXnxilWeYgrNobAuQtPxVpEero9Wky2hkH3PshyPUSsqoBI/RFfxNG+l3Gv6PjefvZsrkFCMEM/qIF+eGK6K7ZGZ0AQQEChBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871978; c=relaxed/simple;
	bh=dI01VYKuJjb7WfDc87a0VX6LE8jfiXAYKcZAn8exXBY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IlZ4ZHNLocIFkpnt9RBEKhS51B6N5TTrf165Lgu3lDv3MEGKBZEjV8LoK8KfZ/M1FJ9IhcX6cJXoKxzLvz1mXQaUS81jVVBN3pKHeY154ktCQSCDTFP+i4YZNLDT/JdSxhbgQjO6XcZkAbx5/TSxma0v2qY95eQtxSX3C6bKP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XtUelGMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XtUelGMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428921F000E9;
	Thu, 27 Aug 2026 23:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787871976;
	bh=ZSE0r5fcWcVnccO8tC0lUxSalohcvFdS+D3O0HpKIOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XtUelGMWzzFe8hbv4RH+ZNfXR53MbKr31um0sRRbg8lmjP07fUDhwSahs8k1prsX0
	 DDmd4nt4KUYV8onXyw/7phc8//9RsXyKt/c1hl15KcHSptuG5LvejYlgxfNZVc+l/4
	 eiolhlPUOAi/i8l5YX9jAnW1kui9qIwiqFfCeM6k=
Date: Thu, 27 Aug 2026 16:06:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, xin@zytor.com,
 luto@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, rdunlap@infradead.org, elver@google.com,
 andreyknvl@gmail.com, glider@google.com, gor@linux.ibm.com,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] stacktrace: Provide arch_in_irqentry_text() hook
Message-Id: <20260827160615.c5cd19af1e4d9287d7870fb3@linux-foundation.org>
In-Reply-To: <20260827150022.1618235-2-xiangzao@linux.alibaba.com>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com>
	<20260827150022.1618235-2-xiangzao@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 23:00:21 +0800 Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:

> in_irqentry_text() decides whether a stack address belongs to interrupt
> entry code by checking the .irqentry.text and .softirqentry.text section
> ranges.  filter_irq_stacks() uses it to truncate interrupt stacks at the
> entry point, which stack depot depends on to deduplicate them: traces
> that continue past the interrupt entry lead to unbounded depot growth,
> see commit e94006608949 ("lib/stackdepot: always do filter_irq_stacks()
> in stack_depot_save()").
> 
> An architecture may deliver interrupts through entry code that cannot be
> placed in .irqentry.text.  in_irqentry_text() then never recognizes the
> entry point and the truncation silently stops happening.  The markers are
> meant to cover all interrupt entry functions; when they do not, the depot
> ends up holding essentially random stacks:
> 
>   https://lore.kernel.org/all/CACT4Y+aReMGLYua2rCLHgFpS9io5cZC04Q8GLs-uNmrn1ezxYQ@mail.gmail.com/
> 
> Add an optional arch_in_irqentry_text() hook, consulted in addition to
> the section range checks, gated on a new ARCH_HAS_IN_IRQENTRY_TEXT
> symbol.  Gating keeps the default a static inline returning false, which
> folds away entirely on every architecture that does not opt in, instead
> of a __weak stub that every architecture would have to call.  This
> mirrors the existing ARCH_HAS_* hooks in lib/Kconfig such as
> ARCH_HAS_COPY_MC.
> 
> No functional change on its own.
> 
> The first user is the FRED fix in the follow-up patch, which carries a
> Fixes: tag and is Cc'ed to stable; tag this prerequisite for stable too,
> so the two are picked up as a pair.

Good call.  I suggest that the same Fixes: be attached to this patch
also, to help ensure that everything lands in the correct place.

I'll assume that both patches will be handled by the x86 maintainers.
