Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7F2EEE60;
	Wed, 24 Jun 2026 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294916; cv=none; b=LgAKI/MqLBiGV7XkySTmp+nK3+4NtDWo2KzN8aDhLnhkRQr22nL0Ya47jY1/puzSGxHUc4zktr0BiSQtwOWtYSNKbROU5FY7KwPucWqbEc8Nsrb7jzlArSSPHx3ZLKlDLx8aLpm13cPnpgMMaVlaHApH7meMi1txUyckZPuKirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294916; c=relaxed/simple;
	bh=veoHHobWOSqCfbPZ6yU/KvwdbWjpFw1LgXCo+C1Gu8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrjbavA/CJA9W07VvktYW1igvoQQiuH+aUuJlPujlyMdIIPQGOawEZlgWznMM+VnfwWH61DKWZt6pHDFob4xueV5nV1AS+3bu7AHkLsbRd9LPE3sEKLvORBZHnx7ml8FVeSHMiDLTYgUbdhQkda54KCW5CFPU0A7DQB9e8ABl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYtjoPXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYtjoPXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3541F000E9;
	Wed, 24 Jun 2026 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782294915;
	bh=iEive92/b764zbh1F4eouWRY1Zxw6EldLaKnejGO/As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SYtjoPXPOZuEHT58F7mJAtt3b9PniEDRwez/qyVATGEX+YC0Ob3S20OYvSZSPu3RD
	 PZiFEMRa3swWyKVYi4dkbbz/8eX+vD89iKMb7bqrMubFFpCqBKHx58+h0P/snz4fWU
	 AbgSrmyTZX7PClDsV27LKmBnHa1zd3VOrnyjUVhvveMpOr0HYp0mY1Edxd6NPBzdQW
	 x4QPvBrclrqX4R/z85AnEUOVOj0XhSxDZ71cS8s39GeiAxe2+l1J8gpDE7aCbaY9LY
	 s2nkgpBfVz3j1g4d8vmG6Y8gH1aFrh9k3t5cGWHdRO+zWQwb7WcxaiLJnKHDYOcCz7
	 9xJVli1yZmX7g==
Date: Wed, 24 Jun 2026 11:55:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: Disable jump tables for clang
Message-ID: <ajupfkcZTTxGP2dG@gmail.com>
References: <20260623-x86-boot-compressed-disable-jt-clang-v1-1-575fccd58107@kernel.org>
 <ajulLtY29HtgWokg@gmail.com>
 <20260624093848.GA48970@noisy.programming.kicks-ass.net>
 <ajuoqIk4tSV7CmFC@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajuoqIk4tSV7CmFC@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:


> > I'm sitting on a patch to unconditionally disable jump-tables for
> > x86_64:
> > 
> >   https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/syscall
> 
> In particular:
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/syscall&id=76612388fe7aa41a8eb88f890d451bc17255eda0

Side note: since arch/x86/boot/compressed/Makefile constructs
its own KBUILD_CFLAGS, so a change to that Makefile will still
be required to universally apply -fno-jump-tables and work
around this Clang optimization in the decompression code.

Thanks,

	Ingo
