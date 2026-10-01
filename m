Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26534E13E0;
	Thu,  1 Oct 2026 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849475; cv=none; b=gQqycb4qHzdhfUO0/jyg7+nPV7/g2BjLvypcttimWrCYMgA8SvJEwphEGyWFiQBLBQw8yPbMATRXjM3trvmTirsuHoCwpUPvhhDU0ujVGtXZWmycd19rIy9a+4HrM6ypx7CUlipBk4vqB7CKstlWsHtEdZvVK7aa7NdThS1I4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849475; c=relaxed/simple;
	bh=HmmSMWq2rCjwo05n7HQB4k8lsgm+ZEbjZF351Q8CZHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nzlI4rBb9vT053YN5knNAlRREbzr5O/JLMw7DZX+8PamzvQzZ8RmccHRkOXed6gW4Onepav9nD7DgSDBM2TNLdltyraVZGqwaztpQ2EXDgCsAug9z6+yAMYmmOVe9YHQuqXurMtRq2tE85BOgJTiSKn6Nhmk/AIplqoq83LSE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd3YtjkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd3YtjkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20471F00898;
	Thu,  1 Oct 2026 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849462;
	bh=mLZRTSg0T1/OZPn8CyCkwzpUfqzpp0DZEYvr2NUeX/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Wd3YtjkK5yoJLGS0TCoiSUyMA5uTPCgROv0hTBhuPGpl7Zy+tJLoNFvjg1RtRVCp1
	 /Q2+knwi9a9n/3fMe5WOUdbLXdkGgZnQD8LcXx03lvzXao4ng77nVWwOpY7GFaZz/B
	 XihZOqckAxtzyCzDeI9aiVj2PrENlXn/IGqH/bULIDAzsTH5Kjtj+h1+b8d8L3l5oi
	 v24Uqnm4Qj/T6ik2QWFZobZiz15PAYjxxMaYkFgXj0A/J4JyhjsHtZEaiFD2eTRC+0
	 BosTEcMYEEF4TX0yX3sON5ZGorpDUWZkSnHo3L2ZndhbWTuk66Sp9j8WzZgW3R6jGK
	 IxNQR6QX6Vgxw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: chenhan0017.work@gmail.com, rust-for-linux@vger.kernel.org,
 boqun@kernel.org, fujita.tomonori@gmail.com, frederic@kernel.org,
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
In-Reply-To: <20261001.183120.1111705981110043336.tomo@flapping.org>
References: <6z5gg2l6ctq6aQIEoJ5hBjZr03ffUqGeECNSGQcVv5eyiZz35kWClxv9o5N7Y-PPk2R2dgpdDxEDLfG7GpkGog==@protonmail.internalid>
 <20261001042942.109012-1-chenhan0017.work@gmail.com>
 <87wls1alk5.fsf@t14s.mail-host-address-is-not-set>
 <wURmlSiujLNG9rpTlhXlgbGsxDFPFGRmZBsH1vX_HLcTsVnQFFSDbkQEVQ8Q2auAdvdukDKwRtCfdaL_VsFzaQ==@protonmail.internalid>
 <20261001.183120.1111705981110043336.tomo@flapping.org>
Date: Thu, 01 Oct 2026 12:10:51 +0200
Message-ID: <87tsn5afys.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <tomo@flapping.org> writes:

> On Thu, 01 Oct 2026 10:10:02 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> "chenhan" <chenhan0017.work@gmail.com> writes:
>>
>>> Delta's division and rem_nanos() use Rust operators on 64-bit and C
>>> helpers on 32-bit. The report shows that rem_nanos(0) can return 10 for
>>> a 10 ns dividend on ARMv7, while the same call panics on x86-64. The
>>> i64::MIN / -1 case also differs, and neither API documents these inputs.
>>>
>>> Use Rust's signed division and remainder semantics on both architectures,
>>> as discussed in the report. Div should behave like i64 division, and
>>> rem_nanos() supplies the corresponding remainder operation with a 32-bit
>>> divisor. Both reject zero divisors and i64::MIN with -1, even when Rust
>>> overflow checks are disabled.
>>>
>>> Check these inputs before entering the architecture-specific code and
>>> document the panic conditions. This preserves the API signatures and
>>> valid-input results, but intentionally makes invalid inputs panic on
>>> 32-bit too. No in-tree callers of either API were found at the base
>>> commit. Correct the rem_nanos() parameter name to divisor as well.
>>>
>>> Tested on x86-64 and ARMv7 QEMU with a built-in Rust module that passes
>>> runtime operands to both APIs. Separate boots verify each panic case;
>>> valid-input tests cover mixed signs, signed extrema and full-width
>>> division operands.
>>>
>>> Fixes: 4521438fb076 ("rust: time: Implement basic arithmetic operations for Delta")
>>> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
>>> Closes: https://github.com/Rust-for-Linux/linux/issues/1254
>>> Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-5869573842
>>> Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-5869925737
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: LLM
>>> Signed-off-by: chenhan <chenhan0017.work@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Put the checks directly in div() and rem_nanos(), following Tomonori's
>>>   suggestion. Each proposed helper had only one caller, and no other
>>>   concrete users were found to justify a math module.
>>
>> Even so, I think we should get the math module started and move the
>> division helpers there. This discussion is not the first on this
>> problem. Having the helpers available will help everyone, and create
>> precedence for further helpers down the line.
>
> I'm not against starting the math module. Uwe asked for div helpers in
> pwm_th1520 [1], and I plan to add the math module for them.
>
> However, if this patch is backported to stable, I think it should be
> as small as possible. Also, v2 does not add any new div helpers. It
> only adds checks to the existing code.
>
> How about merging this fix as is, and adding the math module in a
> separate patch?

I'm not a stable expert, but I think adding the math module on stable
should be fine?

If you really want to, I guess we could have this patch be a 2-patch
series with this as the first patch with the stable Cc and then the 2nd
patch moving the code to the helpers from v1, but placed in the math
module.

Then we can pick patch 1 for fixes and have plenty time to discuss patch
2?

Best regards,
Andreas Hindborg

