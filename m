Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABFC348866
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374786; cv=none; b=XhVWzRQDFO4SfWgkCuXYX6EscF8MtC2Cng/4/nJAPr16LbsKRh95NRuJgtZCSkfimM30cYjDcLTKLLLsw5M7a85FCB6qnBPGC1Cu1fohVSi3doOXhoJkRCzBUxE3obVRuPkfS8pFk7togRr6kYszyhvOKNe17vrfl3ezBgnQZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374786; c=relaxed/simple;
	bh=QXjQH/buTcExDsjHMgakhzt8g8gkCM9esJ+xjiUHEYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2Ly11XTp7YUo2eSlCjtaR5h/CXJPerczNxRgDWdzJscV6Ok+E3aAItiVrYk/ovOnd4CQRQHYaNY84L0Lx00KuS19btJd402ofJ4BaON7R5L0p3Ti04yVWCykqkPBFzZbwPhUIzu5QTfUxeJR9oPLoqvveHQocDV2U9tM04JmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0Vezr4p; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0Vezr4p"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c08acccf4a4so311074066b.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782374783; x=1782979583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDnOaXCiWv96jSUBbBWKHEoVhfgL164bVFcPRzDH7PQ=;
        b=O0Vezr4pXWbuQWE5r0n4398Jv8LkAuiQiB2Hvxrjpr95Bdk25ndVlU6mEfozNA5d6O
         QFRp2KCC6cAkKJ4IecTtQKrrs9d6cOyOuz573NxtBt8mvpsIUgA+HnQ+Ao03eYSAaT80
         OkWLfB9iPKgEp92lgAqxMCvWGetcGyjJ1YlGV3sU8M7eulgKefTbQhXXmzqsgB+8CrmH
         ItC1Tuqo1BrpQxrRmToYY1pEmsPDBumLK6NGEsFsaGTcKue30Kv31pPJRUqFqVru2wlm
         HsB3y1TdoUKuhqaQ7TujBCsmJa7qAsnxQB7qALKcjvWN1aGkrJBSRciKlghT78weUXK6
         3cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782374783; x=1782979583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDnOaXCiWv96jSUBbBWKHEoVhfgL164bVFcPRzDH7PQ=;
        b=lmeUF9uQL8M5PmsYe5kPq3fPWkb1lOTxjG/Cf38vb2FbJyLHHwswRWXqltTAF/lWfX
         rQIvfAdHHDmozp2Sxbf+fcSqWRSrJLE9oFAwXUpfuNpYoSWxk8lCwpqFgWS60N2S4onD
         A0t1QsrXqu4++uOYtM8vp1qIrofPz0QMf8/xh77cc3QIeJfAdiJEtBv6nvMtC9fBkx0l
         pOvXYA14sH9U/J1ZWgxsHibk1A6rGNu9765B6FQ/ZmHHwB02xgzUJTYsS3qdpBuegHCI
         jPbkRGCKw/Gq5WNiCptxlHDxllKF/W/Rfxx1YjoMXiugVp+3gSFz96+5hLXaZOStpGr9
         FHNA==
X-Forwarded-Encrypted: i=1; AHgh+RpZiBlppICWPSJfRuTk4CwNkf6YiEw796aykuy4rVMfzyTQiQI27wuzjxBzS0ZbO88Wb27fDK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQAmvZzzDluKXhiJs8/S6THrQDhmcaJEwbXEa51fGgS2bMOgD
	flLRMG6pqr3DSLrj1TTgPRMwOHIxlKGwodxjkxK4I8yw0rBvpGrsOgfM
X-Gm-Gg: AfdE7ckI8fzcHdCszJg8AzZY16tx2FgJHJkXMeqqrE+BklcKaWrOhmETdnER5WT5fC7
	QDBb455+3EtEb1UrxOyWt8Cz7dJnVHCFKAe/yiy7ho8pkGOworg9qZzhDOsUFayM0P84VtLZ/Ta
	F0cvM4QcsjX+aJyXDBlJtOBgiVTji9H/cJEFN+NTYMrE71xt6+/Sq/oyB5EinqDaJ+UOyv4ZID5
	ANgxudWxz4oEiMtPCiIO5tBKrplyVcZ9tC3HvrTIVjb4LfJjP1LXUwwk9RVQM5ObBGcf5K/T9fO
	zxF7Le6fwFhL3Df67tRI+OrxhKfSXAoxl8TPMv1ycZ7ZkOhjj+3Cr0AIIg21exO7N9RLdueai4K
	D+/usDJmtxX+nnjLN8XLg8axmwF7GZOtlkY6Qwf3dTIwMCbGicNAakO0u/JBAIB7CsqkCyMcE8B
	O2bkkY1qgXrO2ySE/paOcED46tYA7L+no9ON8HPnNGH6o7NW5mtw==
X-Received: by 2002:a17:907:9810:b0:bc3:7b0f:91ea with SMTP id a640c23a62f3a-c1205d9862cmr77761466b.19.1782374782801;
        Thu, 25 Jun 2026 01:06:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93cdsm16538250f8f.18.2026.06.25.01.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:06:19 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:06:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Disable jump tables for clang
Message-ID: <20260625090617.4f3f68bf@pumpkin>
In-Reply-To: <20260624221739.GA7516@ax162>
References: <20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org>
	<ajulLtY29HtgWokg@gmail.com>
	<20260624093848.GA48970@noisy.programming.kicks-ass.net>
	<ajuoqIk4tSV7CmFC@gmail.com>
	<ajupfkcZTTxGP2dG@gmail.com>
	<20260624221739.GA7516@ax162>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 15:17:39 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Wed, Jun 24, 2026 at 11:55:10AM +0200, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> >   
> > > > I'm sitting on a patch to unconditionally disable jump-tables for
> > > > x86_64:
> > > > 
> > > >   https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/syscall  
> > > 
> > > In particular:
> > > 
> > >   https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/syscall&id=76612388fe7aa41a8eb88f890d451bc17255eda0  
> > 
> > Side note: since arch/x86/boot/compressed/Makefile constructs
> > its own KBUILD_CFLAGS, so a change to that Makefile will still
> > be required to universally apply -fno-jump-tables and work
> > around this Clang optimization in the decompression code.  
> 
> Right. I had intentionally kept my change scoped to clang to be less
> controversial but in the face of Peter's series, it makes sense to do it
> for all compilers like Ingo suggested. I have no preference for how we
> proceed here. I don't mind sending a v2 with something like

Isn't this solving a different problem?
Jump tables are disabled for the kernel build to avoid speculation of
mispredicted indirect jumps.
Here they are needed to stop the compiler output containing 'things' the
restricted environment can't support.

Someone building a kernel for a local machine may want to disable all of
the mitigations to avoid their associated costs and also enable jump
tables to avoid the cost of all the mispredicted branches in the comparison
tree.

	David
