Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795012918;
	b=H6pTCnQ8PwmDVBUoMmI+o0ZZG4xxO6e3lUglCusx/RqUS3g12CaHAb8xK53fZOCJgG9R
	 hthSoSd63slNnKXM9y5vAm3YPH/BDD5WEmpZ1lK290r7V3QhN+xVKMh758AWA4bbRpDUv
	 NTt06uBCjnUMV93q8XFNce3U6Abl+0bgONshnZU8jL93reE4/472tkC8NMBa87t2keyBF
	 3LilFN+CUQzt242rQYFbnFNWv0wrR9ebBwm1e3kEDNhPZhIek4NPOTZLyrUlam+ofvOKP
	 gKvB6a7nTol3lbk6iFoVAUNh5b3QpLfPM5+avwuMJXGWxAWhtgYO0SUgGPfjwBdO7KA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=WRSAwcPpVvVL9pia2YQzeThyWzOEL1AWKpkFwsSYKqY=;
	b=SlimnCjOqP+TZNbnfBXBGu8nM8d6Z5yXwlGA0+ryNXuNBxAD4UtDjUakEgyMgVk1IaX8
	 nFitopPK2fqXvW9d8wsY2wHmcaSPupbCz9hoZMdQmPxu1cLPaE3O3rV09YTZwOy4LCXOq
	 vBAnwuSuUk6hC29QlLcksRIYgzNLRrtygGGIVO2XxbmBsUU+Glz2SqE7GRpIVFdU9DHFG
	 keFq1qVl+gbqz7kT7Zey5gG4hX3vMFOtJt8sf+1KSl19z6pm6TTONwz3IxjySG8qPpCXe
	 ISgf3UvASei2YjWBmu/BtOXjQxnxZFM00BjybImnsxhKT8jGcPQLer5ce3bB8hlNI6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7+eyrcC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.67
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F8606A339
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A0F8606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7+eyrcC
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5c158c4c15fso922915e87.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:41:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795012916; cv=none;
        d=google.com; s=arc-20260327;
        b=VQpbAnB305ld1ozMmWMWf/k3Yt3sxMmpXeg+2dor7zDZEukJBJlEGj86qnpSjPw/H1
         +JQw81v2V/ZQ/Vyt2xl6Ka3xFJ1toIctbY44IoIJ10dwDtGlOCRmGhrBWRBAgM2zKPix
         K3Qj3n6x7gffhiryv5PzThwzcLiLFg11zOBdvA930h/TEQ9F4Vly0pLGVAWjodkMNMg0
         2Eh9saM3YNZVe3YpARiNYf/aQ9Dh7BJtn0KF0FhIwRG5YYL7FpVBaQq2Ti70dX5ZH2dp
         FlILbobGUSKQLlC6XxH4u/OedzrIoAPQg+Nstul+VEsqEFhDefthxQmquKV6NstRIz98
         RGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WRSAwcPpVvVL9pia2YQzeThyWzOEL1AWKpkFwsSYKqY=;
        fh=WqH7zu+0XaEK2bXsdENKJpnkn8TZqT7p2Dl+BwHWAdw=;
        b=HDs1zppGjn8GgyMqd3onNI9lyLNgAxPBAHDl6aJ+McY52/5ioY6SUl7iZBcD2pUkCX
         27JhvI1ENUd5IuFaUjdxDj755Vh/0JWq2tn7DK+hUC8KD3+QYw0G2oVT7Q/IitmV/kT1
         rHvveHiSczqhq/Fg8CREe/fCMP0NGHZyuNVve0VjVBAg3AwAV1FDGMrzjD5dm2a7PrD2
         9Cpy7kKpDJzj9k/HwBRFaUQ0xlbH+kpdNTWp39/2Qjb/uxToFP+94AYWm9utv3OYrhyU
         B7Hwzqa0kxr5hPT9wQZci0+xgyz8itATT8cULv4FjtrRvXUC8U3iu3jU9mm2DmM4MJ7N
         GEWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012916; x=1795617716; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRSAwcPpVvVL9pia2YQzeThyWzOEL1AWKpkFwsSYKqY=;
        b=c7+eyrcCPVtSUQWEPiyBFza2kV+CTuG0CYzia9HuYEnrbJRjBecC0oApUOiMMJ0de/
         j1dJIEnJZAugQKEkMsU7yWgAlmSeQD2c10BBNSqGW3fbUN6UTLMXTMwzm/HOKc2NLXLW
         GXQ2yY4B2N/6r/wgaadoxPCl7J7+W7X53tkGx3LKH4ocNo4gPcQHPKkiDYAUOF6EYB+L
         RWavboIDzIw7hLEBczoWznRRf0OOBDJHCYkXup3S+s+oj7i3tP8niyqqtaAGSMFfVdTn
         F5bG0c5yNVvrMV3Y7RKnHjwSvJI4tSXlmleAfN4EeDrGbXmiYylBFOU9VXoUQDk8/SxW
         wIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012916; x=1795617716;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WRSAwcPpVvVL9pia2YQzeThyWzOEL1AWKpkFwsSYKqY=;
        b=lAjcpDq9cBcjzddf1P0ff1VB2BFLiG7+ncZkGZXm9hQQ7+jspZuo+SzYKjaj32wq2a
         vrUcENVNafUWNDLOhS5ylLy5fu2MjSkboSxEiQ/ESfKXJ5DzEkj0tDWIjSJt/euZeda3
         Bz0S6eOssv4cZ88dD8kQpSQgzBGgfONJk3oDPtpOCnzukPpDjQlLr7sn60h8kiWktCnC
         YZEgt4tZYWxIwt+NOiC852bMOhPBp5KH+TExiohxNUN5e2+3W1DhgohCnhQpjGl40uix
         2ZLgkK324yew0VQ+RcraeF24VSoSBS81K/D28TNiw0YRJQj/pnkcMvU9cO4aN3qFhPi0
         KDpA==
X-Forwarded-Encrypted: i=1; AL+hErGz18SAuDL3N6yBUX/4f+6mRC6YBBYKtTYaKO1dhE6P5wWCc1ivK4xE1GYwDs+rxAhk+Kp1zBc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UOy7RHI+qZ0rbjobAdmtwQjLRNSWWIzCOuZe3Ux413Mgk3tmG
	/VcqvkxbmFvKac+4x5BVMVH1kdp2znAwYW2usxQQ08SLLowllBMoXl0VDwZusKo0DpwTwxtjfZZ
	Vro+Dg/7dwq0N1swz+aCo7RDilfpZvbw=
X-Gm-Gg: AYBFou2E0RvmGfDR8GaXgQKE9X1m+1V9c19P5xDLFznMIwx0kzA50cOV6e1+uWzAeW6
	lmfvcf6npTDw0Wgp3/R1SzMloYLdkKycgO4dKJObcTuIzeIlM9sbbIJ/TrlcAmxr5EU27cqxEoP
	86qmVeP5gqQ5WXlBpWTCL/PCswPDcqUcaNmQ/SaGFbL28MULKY1ZYZdDi0BDaw7ezDEXJxwmnBT
	XClS6Y1C3HSDJmswsfDFM6HAC/kXnrA3L0xwYKZMe1c8LgecCFgPmQGMCCrdV5OKyLJsbMIDSpe
	f1O/LtqafzsiTnX6R572iHCCHhXmOP7zUtglUTUY/yh7IOl7JXULsbKjSPr7rQQSKiYgNP2OdZ0
	cb7TACZppS6BRUrLXjlq0MFfRc3vtRS+VvyC0ow==
X-Received: by 2002:a05:6512:3f28:b0:5bf:a34f:14ce with SMTP id
 2adb3069b0e04-5c1a0ef79e6mr1989965e87.11.1795012915416; Wed, 18 Nov 2026
 06:41:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112134942.288831-1-shlomojune6@gmail.com> <DMTHXFS504S9.2BU4PDLEWG3PX@gmail.com>
In-Reply-To: <DMTHXFS504S9.2BU4PDLEWG3PX@gmail.com>
From: J4f J4f <shlomojune6@gmail.com>
Date: Wed, 18 Nov 2026 22:41:43 +0800
X-Gm-Features: AclHuK9QDHo1yz09H2q8rKyDe22fgjuz0dzQ2yBYPTf4oQjXMD1IbeM927twSjI
Message-ID: <CAE_LbwmtogEFvk5jDUcYhjSaX7_5bsHy-OWxCKPxmiBVDcjj_w@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix cgroup link update after a failed effective
 array rebuild
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tadeusz Struk <tadeusz.struk@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 03:57, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Nov 12, 2026 at 1:49 PM UTC, Shihuang Liu wrote:
> > replace_effective_prog() uses the position of a cgroup program list
> > entry as a physical index into the effective program array.  When an
> > OOM detach falls back to purge_effective_progs(), the detached entry is
> > replaced by a dummy but the other entries keep their position, so the
> > list position no longer matches the array index.  A later link update
> > then writes the new program into the wrong slot, leaving the old
> > program pointer in the array.  The array does not hold a reference, so
> > the old program can be freed while it is still published.
>
> I doubt you managed to reproduce such scenario.
> So wont-fix until there is one.
>
> pw-bot: cr

I reproduced it on f66469d9905b39 (7.4.0-rc1).

[    4.307527] BUG: KASAN: vmalloc-out-of-bounds in
cgroup_bpf_prog_query+0xdf1/0x10a0
[    4.307589] Read of size 8 at addr ffffc90000073050 by task exp/74
[    4.307593]
[    4.307597] CPU: 0 UID: 0 PID: 74 Comm: exp Not tainted
7.4.0-rc1-00536-gf66469d9905b #3 PREEMPT(lazy)
[    4.307602] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    4.307605] Call Trace:
[    4.307610]  <TASK>
[    4.307613]  dump_stack_lvl+0x53/0x70
[    4.307622]  print_report+0xd0/0x630
[    4.307628]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    4.307633]  ? cgroup_bpf_prog_query+0xdf1/0x10a0
[    4.307637]  kasan_report+0xce/0x100
[    4.307641]  ? cgroup_bpf_prog_query+0xdf1/0x10a0
[    4.307645]  cgroup_bpf_prog_query+0xdf1/0x10a0
