Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866821;
	b=mDtD140LId+fZs7YLbCZEigXuBt5n957QNUJj46JBD3jOkZxqfy1wzbxin6RBSyiN7ze
	 Q5uj/jgmQ5xynOzQvrAHrocAl3ilUTDmImCL/yNIPc78A7bOxZ7R994JMdOU/LM8FhH51
	 k/uY8YUPkeeDsy5RtZMfsBU8RS3BPF6gPhDnYhj4cPSXdp2CoHj7Tpyms3q73Y7DWp4+n
	 IF0b7FjhkQBw8WNUUlfS3MCy3N0S8JteH6jTiahJ7ATUc+2g/uETDUZG1w6me2jz7V5+g
	 Uzzbfqm0Et/2wb6DfkXoYcP4fE7dI5VSASjTTQevL2WddauXjy4QH45dXdIC0IKHwrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866821;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vsc7QdWwKgQ0PfQnJbRw/cR4lUlNXyZF39QitBUyknA=;
	b=YCvBSrJbcadTIppkcRdSDCy3crDRACCm9b3BtAmI1H/7b7Ey8t+dSHGihagmNbIiyn4Q
	 gP8iZ92Ph3P72T3fC3vkLQ1JCgYsGRR6VW+Wngrw2ovPB3gkEdo14FbtGWEnP/FkQNgTk
	 pALlCInG4uPMmLq2RyObRq8QZRXIg6/nThXLsyOBfxtqc2eDohYP8Czcg+ZFwmhU2Pbvc
	 rlq5+uGJYqk/UNh4aNB5XZD031qGKpS7Bs1SUde60W/UNIWh1TGLrF8ZICJWBjMq07Xyu
	 Zw6YUSeBXzYk3OC5M2YAxZDxeC/QBCJNF1mA3RemOXloQH4yeMmY3C9wnGSPVsOdQsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Of763eXj;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hV8+IW5E;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9B606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD9B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Of763eXj;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hV8+IW5E
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2C717A015F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:06:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 17:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794866812;
	 x=1794953212; bh=vsc7QdWwKgQ0PfQnJbRw/cR4lUlNXyZF39QitBUyknA=; b=
	Of763eXjGwumyQnteF7BPt3bSNwJYxBYa3Ev1ubdkMJgbxaDdyDoru+KwDpp6Kjn
	3J15TwralibmvGbLxoB3jUprbfD7dOWhF8Wqd8kcvonwj1zXOkqANlBgWWBl6H+Q
	x4vdUKkz4Gvqjw3Tbuh95SnOOKujzgd6j2HkoINlXyJra1g81L1/zLzJKZXPElsY
	0HATUZQYE5DkKZ+zFpiEpR4XmLfeOqqX22p1lGqL8GG5S3+3/fAgtxKDyTdftSoW
	gPO0yG1IyurAh6KLuhD4Zfx+0NpgPBgtiFvpnS5hKQN1teBhbVnrWInR/cU4BPbC
	cYyWQ+R3W4J6cAqM29uVFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794866812; x=
	1794953212; bh=vsc7QdWwKgQ0PfQnJbRw/cR4lUlNXyZF39QitBUyknA=; b=h
	V8+IW5EzZMBpWZZTLRayaQ8zWdy176E6AWKIuX5tgYoiYi1MNvSkv/iCUXnlZHEP
	idK5efB5kS1shjR6b7B81P8t/yto4ZAaO0RV8OEFXPB44Xeq6TjhqdhOU2yn6ulS
	Z4h51SETI2MAflXkLbVjqUn0J0tkyCdGCBZ4ci/C7nsGmBVzuPmdrkkI9QYKqCL+
	J26AGHPzCwTUAoUC3eEjZSkr0YzGUPHUQBKPgCsl3FtHWzWE8b8Z78m6g3Ms9O+L
	vynSMUU+Py7/6iH94n0b7mQXSs+9OxovbcugYKyDtpGnWVj/8bsw4xM/qaNAxpag
	TALzoPDk3HK4x3ewFDA0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794866812; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bA+9MZCsqOgM0MXLKyX21oZSFFVUCj5RaL0gM/6/7xmiMD+
	4MTCN/cpDMp9q1C89OY95/FicuZnx/fCiXc8sHrVrhgZuhyO48yWM8a0vnU69Mwh
	bJqDDO0W6Nv70SA10+iPABLdOg6tm16hCMV0i8ofdjsEa+eG71KFlrpnZX2H+vo6
	rUu5xdrvKLnDtxhV/FNAi0Qk9F3v8kY4euzVb5r6eCueerQp9c9D9NRKLDqLc1oy
	iNdy9FPvwgQbz4HtIvAkxSPHJRtmOkaHu1G3tAz1EoV3mqtwX2j0aBpyhEs+XRxV
	0lWR/sA+Y4/f3mjKV4VwSFO9qnPdP/HdKtdxxUg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UyL/Iv80/j5QV7yVFqfIl7cbPB/ppw8/4Va7FOuu8EU=:4j/DMfnc0hdTWO0CRI7hD4D97WMBwHIteEaLnc8xQz0=;
X-ME-Sender: <xms:fH77alNur4u4gJACJ3d_TMQmPcdiHMYoedMX3HflSe1a2NtCi8Sb4A>
    <xme:fH77aob-_vh4Rr8wAU_WoP_xrpMzSFwmm1saRTZ_XL3R91JmBhSNr3UOvUOl0ayia
    K4enhEgrJFY3CJmjkaWlgz9zCdBuvPzHREMNSd51u7msJTON_7zZRof>
X-ME-Received: <xmr:fH77akAzqlWoIEgg5PMO5UDMjqPJDq6_BT_lEjo4nHnJUap_X7LKvzx6wKuWB7S8eR3-W-xq2CzZ04ZVkmRtAWU1TUIR0hiP>
X-ME-Proxy-Cause: dmFkZTFtc41ee/Iidnc/YKyFRrlcbY0qjv7vqTZLN5qT1G/s1A6ODY0jpLG7OyEpYUVtYp
    rxrHQVSxWkmpyGRsz9lunc8LDSpBqe9tsIONdlQ3MpDcLVxPNBosQA61pMRunTuvOsWRK0
    XlAqabvwAjhMKyQyDzm/UFdyEHNWaCwCwWjvl882gkJh451mUafQaBB0yDkAGs/9YPYQL3
    i8GF1w5NLrcOdAemY4lV9Xqv5dH9DyE3gxX++6KPQ6gVwc508qBf7RvoV4KaDZBU2lGdzt
    VawjCYAbC2Usre/a6pEIEddTaKECceSLt9P6H40e0jaAAEzuItvughm0hzu6r4rd8RJ1QZ
    oM4+bIXmMb6cDj57o0CGr6UGHVlHQdBL9mALTfZc5kC48fbdUaH357WhcWWQ7CAqrKDByh
    wsCzY41+N+Auu28QIaqd6IuuLgK8Uu0+VdAnBNh3EUtmD1gPqlYqgeY6oWwsGhYMp+Gabt
    SoZ2SEVwMaT6KRBp8lEv4OYdZpP5e6KK4TTlaT8uDUFFpRmlkdmk4haJI0fKtQlTlsEz6p
    dXmLLIy5ZPD5zDt1GpwH6ywPe04dh8fW5w2QYI6X9KyRsb99oplKk6oIh2GFc0dsIE39LK
    90vn+8HI9Zehkdy1WNoCmZ3uIDeB53vY2RBOKm9ZSRq5S21pjy0Wv1FBnU/A
X-ME-Proxy: <xmx:fH77auEhFXkbc64TI9i3tVfon4gv-mH-eP6aOB-13zMl7bwebge5_w>
    <xmx:fH77anOdhv6zpDgUCj-lZBLkMKmoj0__a5uS7gasdEY2qNdhCtIH6Q>
    <xmx:fH77ani7feRs8uW4UmJVeNoy82Mq0tUG2hfzPrSGsVZAbUI8EsqC-w>
    <xmx:fH77av0p6DYMXP-WghMsthNo2C6TSJno4dSPXYvRcchbOGsU7nIDJg>
    <xmx:fH77auSSAO8p553AhlbtJ0V_FAzfA9yDLSSecJfHSRRMfdLsovFEBgzc>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 17:06:50 -0500 (EST)
Message-ID: <2ed04104-e061-47e4-914e-3a2b35b214dc@pobox.com>
Date: Mon, 16 Nov 2026 14:06:49 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 6.12.117] CPA detected W^X violation:
 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 -
 0xffffffffc0477fff PFN 109c1f and WARNING at arch/x86/mm/pat/set_memory.c:665
 __change_page_attr_set_clr+0xf62/0xfb0
To: Sasha Levin <sashal@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev,
 Salvatore Bonaccorso <carnil@debian.org>
References: <avdb9EPXBv2hRCzQ@eldamar.lan>
 <draft-agent5-0008-re-pat-wx-regression-612@kernel.org>
 <2e149d01-c932-42d3-9698-c1555e542cb1@pobox.com> <avpUlHHaimEE_Rib@laps>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <avpUlHHaimEE_Rib@laps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/26 4:55 PM, Sasha Levin wrote:
> On Sun, Nov 15, 2026 at 03:16:20PM -0800, Barry K. Nathan wrote:
>> On 11/14/26 9:42 AM, Sasha Levin wrote:
>>> On 2026-11-13, Salvatore Bonaccorso<carnil@debian.org> wrote:
>>>> One followup to this. Reverting
>>>>
>>>> Fixes: 091c44b2d3c3 ("x86/mm/pat: Use pr_warn() for early W^X warnings")
>>>> Fixes: 11d1ba991c07 ("x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()")
>>> Thanks for testing. Queued reverts of both for 6.12.
>>
>> I see that in the current stable-queue (commit
>> 3b8ff7f280433e6fb085dbc4f44ac6a138f352a0, "Fixes for all trees"),
>> these two reverts are queued in staging-6.12, not queue-6.12, so
>> queued up for 6.12.119 not 6.12.118 as far as I can tell.
>>
>> I don't know if this was some kind of oversight or if it's
>> intentional, so I just wanted to bring it to your attention.
> 
> It's intentional. I don't want to play with the queue right before the release,
> and we've already shipped this regression so there's no reason to rush.

OK. Thanks for explaining!
-- 
-Barry K. Nathan  <barryn@pobox.com>
