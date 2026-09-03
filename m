Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B738E5DF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473331; cv=none; b=Pmrbxt0L/eUG7k36+auQhscisI5QtYRE5fSPQOZy4hGu9SqcJMHOgNhnFXBCVLZFEwdPtxZWCk3hLPmdHM/emN47HDzCMsWxIfFjpi9hRZTL/97Bje2N3EwA4z0om4LoZhCg+aEzMyvrH9tHWDLbOWpGtfhuikCezSIet4T+DMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473331; c=relaxed/simple;
	bh=w85i1U77RlMLmT8UloFRqnOX/JtK+B6wpoucYKebRew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mgfjd5GYheZL3xBn1X53JWImnuWu2EV8RuR6bGGlJOCC3xsYS3FvgJQdrj9wDPPnyQekgwfN1hRf5qk5w9RQuVqyj6fRNHMpdPKQSBPZLcSYXF3sbdxSnq8iGNQl2cvZK04JLCE8qxEcRG0ccKrAdWHEf1BsjLEQdeA3Cp0fUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFLbnlkC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mVqFqH6G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFLbnlkC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mVqFqH6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788473328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSmQPXj8inEoKBdqECUOM+0RiHNGnxlFvDmP/jJyOY4=;
	b=JFLbnlkCzH/3CFZcXuVcDXnqKYcuu/lrP30rv6mf3FTjJACAPPaq1mu9vGTDJ96kfoW0Vi
	MtP+Pib5E7sd4EYXPWIFpzONxtYoRRHQdGnmY5q4V4Fn0bQ9/a13oiv0fzJ5xsmy28T8vP
	JOHkLiJBqbeTwB9n0jyRZqvxtOl85n0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-sXsk1hzWP92XB-WW93gDMg-1; Thu, 03 Sep 2026 18:08:46 -0400
X-MC-Unique: sXsk1hzWP92XB-WW93gDMg-1
X-Mimecast-MFC-AGG-ID: sXsk1hzWP92XB-WW93gDMg_1788473325
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482a5e9400eso349894f8f.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788473325; x=1789078125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSmQPXj8inEoKBdqECUOM+0RiHNGnxlFvDmP/jJyOY4=;
        b=mVqFqH6GpwMzTwHbO2g4XZJsBeJK++6BWfopNeT5c3Lx/bd6yHnlRw/j4/yjSLs+Lc
         rmce3ZQ+7kXuynsCvt/MiGcUKA/BRSaGKJ0binOvLOmHJ1LsiaEv605/bveJGh4ZiLvh
         bsk3uOR8sFmz8+ZxLHkqixmqw+b/XDR6Cn51p1D/vf71MZ3UawqCp/AW7tnHAaFTpfIk
         GcwGzDPRtYLupMMFht8PEkqi6F6TpCEi0CO2XD2AbD1ZwFfjdJUGN4hiKr/l2qHEI5mN
         mM/PcAJE3BZVE/NT6HVsrm/s0Pm0HUjxChqLcr3U8bcUfF7B5bnc0lhCRBgHS1ObDL10
         ZcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788473325; x=1789078125;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSmQPXj8inEoKBdqECUOM+0RiHNGnxlFvDmP/jJyOY4=;
        b=NyTfDXilf5Wi22VlOnfhrufpchMV6JiYFYNLVIskMiDjzD3lXkqqFoyIVe+6dirwyB
         Sh8/PG7HkHMRHlQCui1Fv2iUaB71OVS5d88Jk/U4QH3iXWJOGlroRmY82HEohEgiAB4n
         52r07vsQaLgJ5N5aQZUwn8OUytMkIW1ko1XvVUN/yKbo2j+Nh3EAZJS1wILsHIAXtw85
         K5E9SbalbNZdEJaOcvmE1SvAX8bCQaDxq62rlccShhdWNI7y/rcUH6RQlBrhABLAijFC
         poSG3luEnpNDwmePiM2EXqp8SJA1GCA6m0FNgnxsAtLyNAXbylEOmBS36FmRfEpcl+MW
         dqvA==
X-Forwarded-Encrypted: i=1; AKwUvBzIcgw2YxGCvg6dvL53OjbX70wn0pp6NzRXY8QGBSPdAdqloLOEcBhlEzIH0HWRbX7/VXWDJYc=@vger.kernel.org
X-Gm-Message-State: AFuF++nyTSLClnBx5qwPs+q9Gv0GIXDERdglm+m72ZfjMn4dcYFlTX0V
	xSTSz+X8rnOx6tJ6a6n+OKWV6qmMWKV4lvpTlLafswA1NHcUNImKSc1EBR6Qd4upglxgBfyWge1
	oYG6Q25N+ZQZsYLs/tPap/NGrSHG1jul0aWjGRM2me3cq8mmIapzovHkGWA==
X-Gm-Gg: AYBFou0yUtmmLkZVgcxd37bh8MXQCnApMWlNmqKaeEFNIzNgvKB7COXplAD8AjrpiqG
	mBJHad7e1x2ieRNPEpMJ8vzgKjJHqMAId/3esTUMJahR83/7nOGw6GsyyOgOrtajNQzNmgVIU3G
	HWLiItNV2X8x+X3T9p3RXtW58/tBr8wytOaSHAMGfVK19s6rwW0v4F/bwP6gNbmaLekUId0Zfue
	MYqCHAiElOBdZrdPF3fnqjkSPbaxhOmFNspbY+FB9t2/K+4sk6VRafifqwwzdNV9QAyHytV3i5f
	bEGOJMCblglKTN8NXr4bk5Rle0f06XL9L+wLmqxibtGZje/1knHpUmeiWcLwfgKhgDfwoz1x3xr
	AmI1lNz6LRX9/KO7KRmON06Dx7Iwmrlyam9e/+fswywTqwg==
X-Received: by 2002:a05:6000:2c10:b0:485:4275:f207 with SMTP id ffacd0b85a97d-48587099a2dmr2766261f8f.24.1788473324916;
        Thu, 03 Sep 2026 15:08:44 -0700 (PDT)
X-Received: by 2002:a05:6000:2c10:b0:485:4275:f207 with SMTP id ffacd0b85a97d-48587099a2dmr2766223f8f.24.1788473324542;
        Thu, 03 Sep 2026 15:08:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb? ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858791bddasm1786219f8f.0.2026.09.03.15.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 15:08:43 -0700 (PDT)
Message-ID: <101089d2-96ca-4a0a-bea0-6e936beebadb@redhat.com>
Date: Fri, 4 Sep 2026 00:08:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: clean new `clippy::needless_range_loop` lint
 for Rust 1.100.0
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 stable@vger.kernel.org
References: <20260826145642.43807-1-ojeda@kernel.org>
 <CANiq72=TjVOxDj631gCFMKAeXYbjycmZe74ChXL=rw4H53pQzA@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CANiq72=TjVOxDj631gCFMKAeXYbjycmZe74ChXL=rw4H53pQzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/08/2026 19:54, Miguel Ojeda wrote:
> On Wed, Aug 26, 2026 at 4:56 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>>
>> Starting with Rust 1.100.0 (expected 2026-11-12), Clippy warns:
>>
>>      warning: the loop variable `i` is only used to index `self.decimals`
>>         --> drivers/gpu/drm/drm_panic_qr.rs:410:18
>>          |
>>      410 |         for i in 0..len {
>>          |                  ^^^^^^
>>          |
>>      note: for this index operation
>>         --> drivers/gpu/drm/drm_panic_qr.rs:411:13
>>          |
>>      411 |             self.decimals[i] = (chunk % 10) as u8;
>>          |             ^^^^^^^^^^^^^^^^
>>          = help: for further information visit https://rust-lang.github.io/rust-clippy/main/index.html#needless_range_loop
>>          = note: `-W clippy::needless-range-loop` implied by `-W clippy::all`
>>          = help: to override `-W clippy::all` add `#[allow(clippy::needless_range_loop)]`
>>      help: consider using an iterator
>>          |
>>      410 -         for i in 0..len {
>>      410 +         for <item> in self.decimals.iter_mut().take(len) {
>>          |
>>
>> The lint did not trigger here before because it could not handle arrays
>> behind a field access such as `self.decimals` -- Clippy was improved to
>> catch those cases [1][2].
>>
>> Thus clean the warning by iterating over a slice rather than using
>> `take()` so that an out-of-range `len` still triggers the same bounds
>> check as the indexed loop.
>>
>> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.
>> Link: https://github.com/rust-lang/rust-clippy/issues/16631 [1]
>> Link: https://github.com/rust-lang/rust-clippy/pull/16634 [2]
>> Assisted-by: LLM
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>> ---
>> One may want to keep the loop in a shape similar to e.g. the one above,
>> though.
> 
> Jocelyn: I will likely send another rust-fixes PR during this cycle,
> so I can put this one there if you agree with it.

Sorry for replying late.
That looks good to me, and you can take this patch in the rust-fixes tree.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Thanks!
> 
> Cheers,
> Miguel
> 

