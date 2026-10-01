Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146A4908CB;
	Thu,  1 Oct 2026 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842220; cv=none; b=om0Innucau8YDUGnNDW26Y0iTSlxfFxGeFf35ugVJrsfnsgQCBwmr9buh6hONIiXNydIQHpVtpRkHEtOgkmzli/t+tFhnpAca5FZQQCxrDPaOIoKzSEJpTndU5xdbYK2ffQAM0xCOZfAsdD0fP2s/SiTRbS4m96sPD/PLQLg9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842220; c=relaxed/simple;
	bh=WPhj6jJY0g440njRLc6ZMWlO4sToBHCCrCNoDPc0cbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2VYriBLTDQMbiaYGAhJNny213zJ3V2LzMXFOc9tYv1xMnShfjqMM3TaG0CcRB4tH6Mx8YoV5z2PyRaTfcJ7e2tfDZz6Fu47FDCsUGzjjXIGny8eAVWz80LBDF1QlyEgUwkF9J4I4QtuJB2bcn2hDZYcXwiB70RXn4tAqRdLvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGRlzFnm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGRlzFnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B48B1F00898;
	Thu,  1 Oct 2026 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790842216;
	bh=I4Hu2iAGZwmjhZw7Ia+V2g3163PIm7uMnIZf3CFw7CQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XGRlzFnmfhjBXYvD+N5ntc4MkRXQ+/cZ8hW1m35KD9+s6+himZlw85ro4uXTISGsW
	 A0YerE8NdEa0XsO4bXNlcPe/lIFd2/FuAuLSb/wZdltPKJCs9JqlaPXU1aHW5/+epW
	 X5TZi9bqU5WNIFe47iY5il09YB8K3RKgFMdnEQmiPDXWqeG2C985Ja+yEDYl/B3s9K
	 GPTirMlGI8igkiM7LYxC5ZdWLO60mze5+Z1bptu4FyRneoHSvOmMXZyDrd76k0ofoH
	 xTpQhDKeD0XzwynllxBH3fZF3hy/nGzsJ9itLzsE9tNkART+iRC4fxM2ELhaXmcmOg
	 FCxp+CKq650XQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: chenhan <chenhan0017.work@gmail.com>, rust-for-linux@vger.kernel.org
Cc: boqun@kernel.org, fujita.tomonori@gmail.com, frederic@kernel.org,
 lyude@redhat.com, tglx@kernel.org, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 miguel.ojeda.sandonis@gmail.com, tomo@flapping.org,
 georgeandrout13@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] rust: time: make Delta division and remainder fail
 consistently
In-Reply-To: <20261001042942.109012-1-chenhan0017.work@gmail.com>
References: <6z5gg2l6ctq6aQIEoJ5hBjZr03ffUqGeECNSGQcVv5eyiZz35kWClxv9o5N7Y-PPk2R2dgpdDxEDLfG7GpkGog==@protonmail.internalid>
 <20261001042942.109012-1-chenhan0017.work@gmail.com>
Date: Thu, 01 Oct 2026 10:10:02 +0200
Message-ID: <87wls1alk5.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"chenhan" <chenhan0017.work@gmail.com> writes:

> Delta's division and rem_nanos() use Rust operators on 64-bit and C
> helpers on 32-bit. The report shows that rem_nanos(0) can return 10 for
> a 10 ns dividend on ARMv7, while the same call panics on x86-64. The
> i64::MIN / -1 case also differs, and neither API documents these inputs.
>
> Use Rust's signed division and remainder semantics on both architectures,
> as discussed in the report. Div should behave like i64 division, and
> rem_nanos() supplies the corresponding remainder operation with a 32-bit
> divisor. Both reject zero divisors and i64::MIN with -1, even when Rust
> overflow checks are disabled.
>
> Check these inputs before entering the architecture-specific code and
> document the panic conditions. This preserves the API signatures and
> valid-input results, but intentionally makes invalid inputs panic on
> 32-bit too. No in-tree callers of either API were found at the base
> commit. Correct the rem_nanos() parameter name to divisor as well.
>
> Tested on x86-64 and ARMv7 QEMU with a built-in Rust module that passes
> runtime operands to both APIs. Separate boots verify each panic case;
> valid-input tests cover mixed signs, signed extrema and full-width
> division operands.
>
> Fixes: 4521438fb076 ("rust: time: Implement basic arithmetic operations for Delta")
> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1254
> Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-5869573842
> Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-5869925737
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: chenhan <chenhan0017.work@gmail.com>
> ---
> Changes in v2:
> - Put the checks directly in div() and rem_nanos(), following Tomonori's
>   suggestion. Each proposed helper had only one caller, and no other
>   concrete users were found to justify a math module.

Even so, I think we should get the math module started and move the
division helpers there. This discussion is not the first on this
problem. Having the helpers available will help everyone, and create
precedence for further helpers down the line.

Best regards,
Andreas Hindborg


