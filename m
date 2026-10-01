Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E884BD363;
	Thu,  1 Oct 2026 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847091; cv=none; b=iuR4X8kb1N7c/84hf5AQBx/IniyvrbeGtkw9cYVlLXeEZIGwb8QiYDu1jzrbXW0+AOsJsP6CrakrHRZTaw6IzxzNhdewkgSjnaVuDh2toAhmupwxQGYk4oMoTYRt17WtmZTjWMvw2GkFlTEfQgEds3dZjJjQ8sm8f+pVjik7nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847091; c=relaxed/simple;
	bh=zHqYXqTAGEvjpq656oPeRY4taZJSWnBifUI5HAvNQFE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=syVnQU+BE/9EhEzESewAuTTsbxGmUxzrjTrkEHz/f8ihSn1uB/d2aP8OrnH0+P5JaikX0X3tWGb4Z8o7v8jqZJ26opxnOqBwr6eMub5qLbSM7D/KkfYtsw48hHj/uujeuqHvHpaIP6U2H3zGUIte0Ab6dcW/aNNJLobs5EEJquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=N+02FWWr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWcY9uVn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="N+02FWWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWcY9uVn"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD92714000F4;
	Thu,  1 Oct 2026 05:31:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 01 Oct 2026 05:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790847087;
	 x=1790933487; bh=7Ft3DwYwJpOyW93aZ6tjFpPFgZ8+sr5ztAZ0Otx54O4=; b=
	N+02FWWrA5axkniQZsk5hrjBbFoyrd2LX9pLzpg9am60gOvy2BRQalzRZc9M4JPQ
	U6Vg/R4hwA+FK6UrfLRx9njYNip6b/tXZ07YCl1QNCO3DxGjmQ1g2hFFUDa2VmYv
	q+JYIjd4p5VihgKndna1YvW6sxHtgHNAApfvVk0CJB9JlmGgv8JsW6odw+tjKJVk
	BoKDlN50Rmm5L8+js2a++6lWSQyfxF0R3mfGHyMrk22/w9AzZzzBOHMjnsVfr6tw
	zjYGDIFQYuho2g+CjvlXeowmudtC+gvzGcQ8GYyXX4rKdnSys8OKxaPNO/erzhnr
	xbd3wT56EpOUjo4WV5LRvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790847087; x=
	1790933487; bh=7Ft3DwYwJpOyW93aZ6tjFpPFgZ8+sr5ztAZ0Otx54O4=; b=C
	WcY9uVnYFyZLSeSVG4BNLYLo6VsetGei9qG9eSYLoyf7t41osYIJRvoFykL9pcVe
	C9L2VhyGttUWLJoKM5ub2ZhciDs4K6Gqj/DfllOfdpbzZe0keikx2wxlyhGhNdj/
	ylbAd+TTGD9JsPWFOQ1M23BA+R80GoLPTXy+BxjAFeM3TCpMRa3Pv7ko3P8HCOGc
	tx+KAsjgipgGoEnK/2MlBbemd/EajplUO19ATvbcROXVRUaDkMcfV8uIhC7zkXgX
	VVJ2/3CGvdp4sIiawJCgkz3p/Anjo6WtaeHN8SsQVnycUKf6os8o6pNDTlmOLsGf
	QLXDY8yqaW6RDlqSyUweg==
X-ME-Sender: <xms:byi-ahW_FE-eFUwkY9Joq6OhYCyPqnYrle-X8YtpRejpQZ6b13zwvA>
    <xme:byi-avB_uP9iH-Xx9hc5nvni2Os8q2_ZnTIr3mdX2m24CC6Nhr778jTI-xPyNZJHs
    ELMwPW2vAyJS7JGp9opTNrIXXUmGKvREjnSMAtKfsWvatme6Yk8-M2o>
X-ME-Received: <xmr:byi-atXUENRohXc-8SuJeOCZF1Xz8SFuePVXxosohBihHcfsnsBcWpHwEzsshqyhypJo_NmrDVX7zwT2I3cm9X0d>
X-ME-Proxy-Cause: dmFkZTFxoReK+/uNjFqPIlc6gfopzRKpVZlTjybiu0n9YiqERWLBIvI+Ts1gpwiQv8KwyG
    5t+SnMkVHhEfjSZUaoQx2x8BYK2ITYxPvqHnCI61YxgNiisilxAD7YzyerRbSuTEN+r1OV
    zjnGRu20rDXeCIrM6ZGOOAt7T6/YCKZQ+yDfGSovt7JWVodhrSWDGLcSI7UhI5VWT7n4ar
    ZLgRQz08/Z5B5lUPLORMRkF/rWOyieNNUA7RRjDzkKa2YyfjBd8a0htSxDn47xMj4yiJE0
    Po9xSfNLEA9Db9VIxQzgrFE4GDO7V5+DdFDVa+5CKifD4X+n7n8d/566yugBe4DViLZCgb
    fA4yIJps8wEguEJNmppBzkB1naqnMvKwl5c08dlku2e7uIaQwjlvoxJH+XE/Mylo6eTBwK
    8W3KDNK5alFICW3QwXr8ePXy97Z2aN5HlA8pBjNyvLrMd4khJ92dAlegByo7bnIsMj3oE2
    W/PCaYyFYILQp3YA//TB9HJoEJlVw1J+eeUlSuuuf9Yb5l5FB673TT/CKQnFGgFW/0bB2b
    nczvULLOUPAy2FoQTor4LjI/nsQ8dr4Rvzbk0Qb8DGD37+++jUr9LTgbxPjNZ6IZbMwckX
    UubCxFIr+VjtbKide6BTud0ecGya7J6PRKK9tJurgqHpzXcQxkR1+aJSjkcw
X-ME-Proxy: <xmx:byi-al-VAr_5STWESl1iLS1oekfisqVHZrvMGehfR2LU3h5iJtQLrQ>
    <xmx:byi-arlLpeYgZXrb3iyeZ37UhTQLLShDEtKZf1aPJyeaAFOFbqBlJA>
    <xmx:byi-aoKlU-T9wc6czHY4Xv74mGp2y5daAoyeE4fQeBFveorZtPJmjA>
    <xmx:byi-apqt-ferG2OmuI3dcGYyMeJOY5l7UByXJY3zEplIBZcVmcqfgA>
    <xmx:byi-aok_1ZiLVT-FosESP2tJe70Vh1nh9HwgUf3tV_CPuqYC6d-kod0D>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 05:31:22 -0400 (EDT)
Date: Thu, 01 Oct 2026 18:31:20 +0900 (JST)
Message-Id: <20261001.183120.1111705981110043336.tomo@flapping.org>
To: a.hindborg@kernel.org
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
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <87wls1alk5.fsf@t14s.mail-host-address-is-not-set>
References: <6z5gg2l6ctq6aQIEoJ5hBjZr03ffUqGeECNSGQcVv5eyiZz35kWClxv9o5N7Y-PPk2R2dgpdDxEDLfG7GpkGog==@protonmail.internalid>
	<20261001042942.109012-1-chenhan0017.work@gmail.com>
	<87wls1alk5.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 01 Oct 2026 10:10:02 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> "chenhan" <chenhan0017.work@gmail.com> writes:
> 
>> Delta's division and rem_nanos() use Rust operators on 64-bit and C
>> helpers on 32-bit. The report shows that rem_nanos(0) can return 10 for
>> a 10 ns dividend on ARMv7, while the same call panics on x86-64. The
>> i64::MIN / -1 case also differs, and neither API documents these inputs.
>>
>> Use Rust's signed division and remainder semantics on both architectures,
>> as discussed in the report. Div should behave like i64 division, and
>> rem_nanos() supplies the corresponding remainder operation with a 32-bit
>> divisor. Both reject zero divisors and i64::MIN with -1, even when Rust
>> overflow checks are disabled.
>>
>> Check these inputs before entering the architecture-specific code and
>> document the panic conditions. This preserves the API signatures and
>> valid-input results, but intentionally makes invalid inputs panic on
>> 32-bit too. No in-tree callers of either API were found at the base
>> commit. Correct the rem_nanos() parameter name to divisor as well.
>>
>> Tested on x86-64 and ARMv7 QEMU with a built-in Rust module that passes
>> runtime operands to both APIs. Separate boots verify each panic case;
>> valid-input tests cover mixed signs, signed extrema and full-width
>> division operands.
>>
>> Fixes: 4521438fb076 ("rust: time: Implement basic arithmetic operations for Delta")
>> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
>> Closes: https://github.com/Rust-for-Linux/linux/issues/1254
>> Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-5869573842
>> Link: https://github.com/Rust-for-Linux/linux/issues/1254#issuecomment-5869925737
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: chenhan <chenhan0017.work@gmail.com>
>> ---
>> Changes in v2:
>> - Put the checks directly in div() and rem_nanos(), following Tomonori's
>>   suggestion. Each proposed helper had only one caller, and no other
>>   concrete users were found to justify a math module.
> 
> Even so, I think we should get the math module started and move the
> division helpers there. This discussion is not the first on this
> problem. Having the helpers available will help everyone, and create
> precedence for further helpers down the line.

I'm not against starting the math module. Uwe asked for div helpers in
pwm_th1520 [1], and I plan to add the math module for them.

However, if this patch is backported to stable, I think it should be
as small as possible. Also, v2 does not add any new div helpers. It
only adds checks to the existing code.

How about merging this fix as is, and adding the math module in a
separate patch?

[1] https://lore.kernel.org/all/20261001.070215.521963012921142699.tomo@flapping.org/
