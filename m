Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283088;
	b=UFuHsKgbPMo8yk5GuDsqTl+8Gq6XXuNl61N+Fh46FS389qeksnnClersk6o+HMqlktih
	 zIIShDmclPAyCiwbmmPOPZt7aUrjtk/vdsTZmCNaCEqiD7ts2OPerQATBhx3UPw2PYqH4
	 etfOhwkEFmRFufqbwhLp+4s9mZ3pSyeX9SQx4xan7TZJOUoLkgfU9CFQiBCwLCIxhhIP2
	 A/3OgxBQBdaBYA8W57Z8eK6QHGK6zxr4rLJXyL534b4vdmNskqg3e96dZylbUIT1DBxOT
	 ZXgwdnVpsJdRixrYHV81s18ibddEFvxFTzPk5DO8M0UhH8gbhDZwGC3ewf7EIZMbN4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283088;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qPSKebwlnwHp9YZzEC+qePE1YAMKxlQoUmyGI+ksUr0=;
	b=sngTvWzbrkdrKpP+B3j+l42gF02NwPkzOgz+DjtlEsr/iA9Mmu+DEzjXSxJssSG6XjqA
	 6zj5H8xL+WzTVG6hPfHK92EoG1ys+y6wf7dqn9LCQCpdwXfTMLckhjl1OAWGzi4IsU43q
	 W+NO1R4e9uKVsMtOsLK5WHCvVlUmkMzkH+HLpF6a2EIBc3GUmNl0XhDNJ4HYUMDNmFHQU
	 IN/UazzLfz40r053kMAovhtCOYlc9Bv5c8kJM0zx+Mqr185gNTxoD2pPcq1lodegUsMQW
	 +OnEjdpDi5mOeI25Uh+eeY2YPWaY1RI2eCCT03awtogYjgY7RpBx2BCOftNXaAgpcmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhGUSXlB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BA9D260A2618;
	Tue, 10 Nov 2026 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhGUSXlB
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C5F4E1F008AB;
	Tue, 10 Nov 2026 03:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283087;
	bh=qPSKebwlnwHp9YZzEC+qePE1YAMKxlQoUmyGI+ksUr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PhGUSXlBs0uMZCSA9QuCvoJyOft54N29rNre2lSbydPYDM5I8bbSRaY9aYgOiAGpO
	 nF4GB8RDGho6GbTqo9U6eLCIwovNFmE6lMbdXKJgTQZWLw3w9p7SiMDYqvfYVf8r2j
	 gtz9jMQTDoH29agYlb414fKPS6yhnW4LzktC/+ZU0b1bAXVqJ0yyS7pqVgDFOTxC1Z
	 I1NadhhOz/douuqgHXe0tgBO9skQAsmUoqA46gx1K1nXe07NlMbU8Nxy4Whsdad/qB
	 TKP5BzWe5Ar43Fg56ja0PvyjBgfyVq44WpPhJ3tpbZ46KMqfmhLEQI6duJW7OsVvlr
	 D/e0Umcmy3fgw==
Date: Tue, 10 Nov 2026 05:58:03 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ard Biesheuvel <ardb@kernel.org>,
	Matthew Garrett <matthewgarrett@google.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: efi: reject a final events table with an oversized
 preboot log
Message-ID: <avKWS0n3AQIIC3p3@kernel.org>
References: <au3xN-7onNTtgceh@kernel.org>
 <179428010969.3920616.1180194759290419954@xiaopeng.com>
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
In-Reply-To: <179428010969.3920616.1180194759290419954@xiaopeng.com>

On Tue, Nov 10, 2026 at 11:08:29AM +0800, Guo Zihao wrote:
> Hi Jarkko,
> 
> No bus interposer is involved: the threat here is firmware shipping a
> self-contradictory final events table (preboot size larger than the
> table itself), not tampering on the wire. So the quantitative
> question - does this actually happen - does have data.
> 
> This area of efi.c has already needed fixes for real firmware tables
> four times:
> 
> - 05c8c1ff81ed ("efi/tpm: Don't traverse an event log with no
>   events"): some machines return an unpopulated template table whose
>   contents are just garbage.
> 
> - b4f1874c6216 ("tpm: check event log version before reading final
>   events"): several Dell models froze at boot because the firmware
>   event log and final events table did not match each other.
>   Fixes: includes 166a2809d65b.
> 
> - 80a6c216b16d ("tpm/eventlog: Don't abort tpm_read_log on faulty
>   ACPI address"): a Framework laptop with an INSYDE BIOS shipped an
>   un-mappable TPM2 ACPI table.
> 
> - 48cff270b037 ("tpm: efi: Use local variable for calculating final
>   log size"): this one is the closest. The same subtraction went
>   negative and hit __memcpy with a wrapped size, with a real oops in
>   the commit message. It carries Fixes: 166a2809d65b and went to
>   stable.
> 
> So the corrupted-table input and the negative-size memcpy path have
> both been observed in the wild, just not through this exact
> combination yet.
> 
> I'm fine either way on the tag. If you still consider this one
> hardening, I'll send a v3 without Fixes - the change itself is not
> affected by that.
> 
> Thanks.

OK, I think you are making a fair argument.

This is not just pure hardening given the various possibilities for
pure software (firmware) mishaps.

Maybe v3 with a reminder of why this crossed the border?

That said, I think I agree with you now.

Br, Jarkko
