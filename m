Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794689172;
	b=Br24Dg/UjC9wf2IYqsctBjSciz3wNa6FllREABtCb2JuN4DGwYZJJXByAaui/zfB2y51
	 +m5cTKlSlVYPQ1PDcrIeHHOsn7WVXFgxecuf1h4N0Asff1FCZw7rhoe4gMvp1BvFugrXE
	 uPMWG+i1PzBEBmsMo9nI0U0DLdWULsIzFp+hdnptKhuOlUsomRbUSvel7Efl6qUgz84wl
	 MR8lbi4tzSyik8bdi5+yd8/rBFlppvEvhEtt9VmTRmkh1hq/53+zzkmKhJ6bDpPUDs6yz
	 FbzMsALV2JgVbGy90pufjXZZeUYEO8ulAG3X70GS5Md1B++nY89+TEI+xkepjcX4UUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689172;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TPRCWORSqF8ZjYcKMrEN1FixOiVWDLvhJDYEhpk+m5g=;
	b=I7PZlgkGmSmisVF79ZXczWbqijMQDYExPOryBoLtj6qNyw43zDtPGaasQ0TOjqyWEdWe
	 dgZ+4QqmKnRugFuUQL+e6Aqciyuc4Xtu0qKXhYynNxN1cZmG43FAFwpLlR/NSrbYc5td4
	 rbC0h5Q5rnRj2gx3eTUAe+8uBBv00b0ySsDsxjk8kRPyzRIXhVv3tr9nLesrTnB4hgBAi
	 0IFabmBz6MBdJftErGAjCR2nQB9NcRhILL8cZpTVhY9WRgb9ISIeTJ7LbwahkLy67s6AB
	 B7OjgvdBk5waGGU4Ff9Pf5Er+QbGDKIlmXNTr9Ch6eoetB+B7sQXMiQ60zdUj50XV8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlTmiNCQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8A606A331;
	Sat, 14 Nov 2026 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlTmiNCQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D0F1F000C4;
	Sat, 14 Nov 2026 20:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794689170;
	bh=TPRCWORSqF8ZjYcKMrEN1FixOiVWDLvhJDYEhpk+m5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VlTmiNCQR8Rx93B+APIqwf+sbbdYCT8jmE9sKo2Wc0iQ5NVywQDvtuqiDcZcs5faG
	 ZTyy9kJyXogpOOhBlp0StBtbLPtiJbjseeQFaqh1wQndyO3lCjVkjacnyhcv+5LUBG
	 eUok3bye0KWPOtrJN6S/CcB0UT9l97eI5MWK4bV9ayAZAo6e169DmILZqx3iQvsnYq
	 xLNq2+8ZgIV+kVzcoLqoDzgOsjFw+Gi9x1IZ1sIYUXxprAauPDcDSnP/rAhHvVLrmQ
	 ZwWbh0OFGvR80ibhJKV4DODsM/LLXFnfSveMA3IHyshDOVMHnHV0dOur7qfYVfNlUy
	 QF/SsRx941KqA==
Date: Sat, 14 Nov 2026 13:46:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] x86/build: Do not allow X86_NATIVE_CPU to be enabled on
 non-x86_64 hosts
Message-ID: <20261114204605.GA173332@ax162>
References: <20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org>
 <20261114202524.GBavjDtC9Z3j7PrV3Y@fat_crate.local>
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
In-Reply-To: <20261114202524.GBavjDtC9Z3j7PrV3Y@fat_crate.local>

On Sat, Nov 14, 2026 at 12:25:24PM -0800, Borislav Petkov wrote:
> This looks like a whack-a-mole-y fix to me. Especially if the other arches
> would have the same problem.

I made that comment more about the different architecture
implementations in the clang driver but I guess it could apply to the
kernel as well. However...

> So wouldn't a more generic fix checking
> 
> 	native arch == target arch
> 
> somewhere in the makefile be better?

No other architectures provide an option to turn on '-march=native' like
x86 does. It all lives within arch/x86, so I would just be adding a
check to arch/x86/Makefile instead of arch/x86/Kconfig.cpu. Making the
option unselectable seems like a better option. If other architectures
did want to add this option, I agree generically abstacting this check
would be reasonable.

-- 
Cheers,
Nathan
