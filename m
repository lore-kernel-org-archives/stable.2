Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794339367;
	b=M7DXgN83radhUPuYUTKc/SWVhyCrjp8mAZhkYS1ZIV7YHLExzbdGSrXOfJG1rN5NmeLj
	 yfGcXr3CmcpNxsN6gG1HzaducgGGFHWPiRLi4Zr0VEzgJQ0U/uqrt9wsP6kCr0LvxPQjV
	 +lGp/8PeRV5jCUJtCnhMzAvMv8yiszgtK0sbNKzpMQma1lmWltjA6z21xN9V/5ZF/Esol
	 TZBlamGGiB/2HsEwx3dTbr7+9JVAXrY2rLztLCpEa9mCt9tvmGF54JKBuF+wXYbKJyBiQ
	 dS1gpm48zQr1XyLufzzp30+N2yrJHllX9jrHW1cpaiXeFHMgwx5fVmS/BwagpikUBQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s0VB72eLXTyvzuPole/vzKEB9qpR7L66QrwnqKGfowI=;
	b=t39xmrI5aGhrseKinXB0erkP9x34AmGbSpEP+u7Zfk8n7fGwwPN+ESfHRowTg+8A1mSm
	 1UEI4+S0pWEWPFfswZJBxdx0U5DgxTMJpxh7PZwRlFUVmIqtiohWDVxr+IEbVZ7xyMBIi
	 pNr18jN7Bm8MQOYmNJ+9deYw0f/YNtGCsQYvlHmuf6UeHksKPOSF4g7dRTsdwrsSsc/iA
	 m0sxVL2LOwL2+0mHvJSG+HcApgo/Kwyl+7N5So5Yn3i0uNN8nmDJfJnpkwXNYbTJpUZBK
	 ZM/aoJVsTJCC4VHD754izD7zHwDbeFauJXY0ARmp639M0K3aU+BpX9mG9yZIAGI3HZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=FWAwVzKZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F403E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=FWAwVzKZ
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b2f59de176so1805363b3a.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:36:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794339366; cv=none;
        d=google.com; s=arc-20260327;
        b=XlljoU7v7jc7R4QTVtkWxIitmBMuWBM2UsPaJH6uz0f9ftFT9yilj3PYea4SZl82gr
         HGaRgE4E1GlP5ulIX+92ruWCJ8j7wD9w/Mxcrclgkph7Inx900GcOLgYLqBrZz00XBGe
         BBVTy+83zVFEoQBpE3AbVWmeVcwqq3Bywfb3KC/e32+jn7u4wEI69ac9TywpuTnulayE
         PKHm/kaxHjdmm/BIcS6C1p3rVcEctMcoHXI0TlI1fUqN2wk6m6bzNUvOJnrFqBx3Pf0Y
         +nnkGCf+meUYDqXjzXEug0qyn29KiSXp467xu22oILFQxTjHn/XKYnAL4SQ1or7RhD3N
         Oawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s0VB72eLXTyvzuPole/vzKEB9qpR7L66QrwnqKGfowI=;
        fh=kfwB4YibVJLA9niBivu2uVRSuOxOALnQaWsZMz1+ANE=;
        b=p5vgRgD8az26e8lqOjmADhGM2qJTfw0DlmgnKU8weoZotwElIdyvuE++boN4tUlQGG
         SM3zY8Dy26ez9xtY6EySSNbqOiP/C0d8m82nyuPRUI91YDSvR/iA6aZxMrif36ql4T74
         YWkPOtB4Hl5FHP2bctD5W8yPygSfYHWd6LwATCf0dxDPDRWg2JSbA7au28CkT5KBHM2Z
         oLOMkFQC3u45kWSyIDLXRi2uqfWYxtCc05GD3FhJjQ0afpolAMR8UhDPErHqSAnQbmiB
         HUfrhLWGO7MjMLJyaXxOZJ94ZRsfC+lv1l/Pa9NtSdDUQeBEg1U43tzlxxsi7fs2YhXz
         WwbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794339366; x=1794944166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s0VB72eLXTyvzuPole/vzKEB9qpR7L66QrwnqKGfowI=;
        b=FWAwVzKZccDp7rR7Dqn6k21AGZt6CMeyzuf6frtfr2tL2xrmbBI+mRJOq1iAVqKEIO
         /IufWCAXSEco+eNvr1X/LMMbdmFHvqfpiYByOMPTYb8uccJ7DGqJFTlXjr/GZWpqxuTc
         X9GbzJ1hNUuS3+efNTHEmEmoWhzKWUp2GGgH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794339366; x=1794944166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0VB72eLXTyvzuPole/vzKEB9qpR7L66QrwnqKGfowI=;
        b=0qBKqAtaVxLrvzrXgMVYZHrssn3//sBMBML/lPOG2S7CALBvKPuPDSMswARkmBWP00
         E2/49CVTJoLUEG0Mlb3ugz1E9G5K9HxtJkHSOLrgPWKNo3gBzwyaPrbHn5wKlmNVvJU0
         vKSWP5I+o1fXkgz6UZVW9FdEWbrLjmfuwJmLqDo/Bx2+fvPBmN8VNf74sT63dnM8diIO
         gGqjifaqM3FLAqX2OmNLkIt6Xo4GSxVJxPS6JKAaqGY4rX7fA8z9x4WqZ/LtGezGELLf
         3kADe14AvRchpgO4+z+MU82gegIMtLzDsGIIi5NytePlr2MNYAIsUJHJuYferbW0Btzy
         zIFg==
X-Forwarded-Encrypted: i=1; AL+hErFRLNgmGlAT6tZTEI4S1RptA2Nd03LitTgbRqsBeTFGMaMSMyTUqyhQcI3yjvtTg5Jz0GIOfws=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zHXnjW0k2e1EMO7vnmcX3M3ViLbkAU+ZIIJ7n+woYL6nV79QS
	Pz8/5joUKrfL/h/jYXCtMsjKjR0lQ78+mt/i7DBuk/XUTNJamzvmCYZlNARDjh97S443JBc4+ut
	XCsTxVcsYw2p6JZqWlc5wfpQgFpHFV77VrKb3SAvx
X-Gm-Gg: AYBFou2+t7Cg+Q3wML5ovkf2S9WM9N4/rs5gawYS61d+PFQLxAglVBd7IOvPGVLM0xt
	SA74tidQ8NUIqUC8favpQjpfSWCTAcXVqoRA/O1+Cmwm0PsShSL6t91PXCSM+nfz8SnNXkvGZyf
	CWgxiFiALlo0Vjrj45SZnyPn/nJEp0ILKpWttdgdqBXwWc8eCO3HjG0ZaaowBW3WmYM/yKiJ/p4
	T9yAglr4+QtBZy5RXEVhlgdNaGmCwfLjbOjCbf/Jcv2Wh9CHmEy8yIIV8zNmFOimXtsrr+/UcRX
	FIX/4k0RZH6MMd9YJfnFVsTi192RyQD3DIL7EsaPB25e8coOlBmYblGwNEP4NOpkZXcHfcK/A0P
	V7auW+QfDQVgKtOjd8aqcZ+xTncdEJmUxUb3aeHmruGFqbXBIHHihq9NhVRZRgiZHh+XFM02X4A
	LOgHIXjzZXyoqmoR3o15ua6hqXgV8V57bzPSHG
X-Received: by 2002:a05:6a00:1482:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-8bc1deef93bmr85895b3a.52.1794339366268; Tue, 10 Nov 2026
 11:36:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com>
 <179406458348.994134.6942745655171316289@kernel.org> <CAM0EoMnprPstSvZEj+FKtK_kM6JB-jkrhYRwSd_mmN3WAMFQFQ@mail.gmail.com>
 <20261110101953.6f7b6dac@kernel.org>
In-Reply-To: <20261110101953.6f7b6dac@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 10 Nov 2026 14:35:54 -0500
X-Gm-Features: AclHuK-o8fCkX4IOORxCRrQKTAN4fjHo9n1O3UvNIUpEqwk1J7vVfGugUqKjSgY
Message-ID: <CAM0EoMm76uc8OXSzvMCSpodkm+8Q69q-g6UORiu5J7pFHd0Lnw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 9 Nov 2026 06:44:09 -0500 Jamal Hadi Salim wrote:
> > I think i missed responding to this one. Sashiko-nipa responses are
> > very erratic. For some threads (not mine) a review shows up 2-3 days
> > later. For mine the average time seems to be 7 days and sometimes a vN
> > review appears a few days later after a vN+1.
>
> Response time is based on contributor score, you are pretty deep in
> the red given that you basically stopped reviewing patches from other
> people, and keep mis-posting stuff.

Yes, i just saw my grade, it's not good ;->
Mis-posting was for debugging what was happening;-> but I admit to not
reviewing.
Note: I still review credible submissions (such as Alexandre's) or if
one of you guys asked me to look at those (and what Victor posts as
well).

I stopped reviewing the drive-by AI patches because the returns
were/are low. My cost analysis shows reviewing and chasing someone,
testing, etc., takes about 5=E2=80=936 times longer than knocking one of 10=
0+
issues i have on my plate. Pre-AI there were much lower submissions
and i would review to encourage more contribution etc. But now it
costs someone 30 sec to send a patch and the count is just too high.
Worse, a lot of these patch authors just disappear when it comes down
to sending revision after revision. But my main motivation is a
majority of them now get their sources from sashiko "pre-existing
issues" which we are already collecting, analyzing and sending fixes
for.

My suggestion for the algorithm:
dont give authors that just submitted a high mark just because they
are new. "New contributor" scope has totally changed in meaning, I
would grade perseverance as a high mark. I just sent a v9 on one of
the patch series - and back and forth for over a month, I  feel i
deserve a better grade than someone posting a patch and disapearing.


cheers,
jamal
