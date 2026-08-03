Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8744399358;
	Mon,  3 Aug 2026 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738134; cv=none; b=N6bRM0PYyCJOWZH60eQFVXUYWbIWTPntASMfgM54evors19Q/fmrMfaFT/b1j7JhHYKmm6mw/HjZQJf2uCl6q8dVzJ7xk6GPIfFBAbms4HpGeFPWEJ/O7AO93u8n3jEgWG0wVGFUmlFYkzQqyn7EsMWff1xDfJkeXgMTz4SodCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738134; c=relaxed/simple;
	bh=EwJ6aICvVhqawbdW+e4+zbWAT0473MQYDhBcopBltfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMA1YkkJDDGvzFzesLW072pN+7bBZ8J4uyzFt3iWDu1lMqQaAW68a30prypQuWt5e0YTZIJK8yqh/OJTUz9+dipVIQFqOKJjrQMN/oKbjg3qDZOvg4Asm+5qPOQu3FsxXcw4EHgw11/bJ2WN5YkDAxS5DBmjVvFiq5fU7POwKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KvucVTpQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KvucVTpQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lBBugwHFsZF3Vdxqj+U4Xg2kKWSwhiYQvZFlirl6zJM=; b=KvucVTpQcVQO84yuzuIvhrWw4/
	MfyFILd+Q2ntSmtDg/Gwym5hq3Skb7g+CUvI17ANepw/3lt8l0vXYy9p0kmN+69OzwXVgwNhvNJYH
	3KnzOPYKjj0zImYTkDlI0x3KN7zOghgyQBoLJZTD1levZ/m9sTEXXaqgzBN/tD+UbgH+G7VhsHzB8
	LEDd9v8QJQaN5EHiGjxsweCntmFTyht0ybAmSm4SWkS3T/BMUOFwFCGzH7hENQ6ogA0pqqeWKOKWz
	5PkBJoJlWqLNolsMAFMmLj6MGCHMBvX002u8RYmdvil5SHwW7lwClQnkzDUwsugRVIN+6sDJFjugD
	9XSJXk+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqm3l-00000006m2o-49Jn;
	Mon, 03 Aug 2026 06:22:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2CF2E30045A; Mon, 03 Aug 2026 08:22:01 +0200 (CEST)
Date: Mon, 3 Aug 2026 08:22:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yao Zi <me@ziyao.cc>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/locking: Use sfence for wmb() if SSE is available
Message-ID: <20260803062201.GT49951@noisy.programming.kicks-ass.net>
References: <20260801182953.15069-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801182953.15069-1-me@ziyao.cc>

On Sat, Aug 01, 2026 at 06:29:53PM +0000, Yao Zi wrote:
> When adding cc clobber to wmb()'s definition, the alternative()
> condition to use sfence was incorrectly raised from X86_FEATURE_XMM to
> X86_FEATURE_XMM2.
> 
> Restore the correct constraint for potential better performance on
> machines without SSE2.

So Google tells me that SSE was introduced with P-III, while SSE2 was
introduced with P4, so this affects only P-III.

Anything earlier won't care, and anything later will have DTRT.

I suppose we can do this, for those few people that still care about
P-III... *sigh*.

> Fixes: bd922477d935 ("locking/x86: Add cc clobber for ADDL")
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/include/asm/barrier.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index b0096b5645a9..e0e59da15748 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -17,7 +17,7 @@
>  #define rmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "lfence", \
>  				       X86_FEATURE_XMM2) ::: "memory", "cc")
>  #define wmb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "sfence", \
> -				       X86_FEATURE_XMM2) ::: "memory", "cc")
> +				       X86_FEATURE_XMM) ::: "memory", "cc")
>  #else
>  #define __mb()	asm volatile("mfence":::"memory")
>  #define __rmb()	asm volatile("lfence":::"memory")
> -- 
> 2.54.0
> 
