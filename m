Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793246490;
	b=02G3SmMg6By4zjpASniRPbA7q0imcwon90mVQMzIKJC2ioEGxCotY7W6qLNmdUm+KR4g
	 5LJJnImH1xtWC5XxFrYnZ1h4VMHxyWlbIuSgdeRvvdrn4/hV5l70ZksA3n1nNJi8aa6bl
	 5gFowmiZ8F+CGs4Qdr5eeP6rt8UhoE5czPuTbnco+deq3A7nrYsoc51zBFJ05ChJXLuYe
	 MbYkvSISFJsN+8NrB0bl96cAiz4AB1mkaxo5paDmwFeB/rCSwTelTYiIImI0UFj4qQZBI
	 k7CrjBRqLH+izxAnhrWF32dbPxM224h1BAd1kfd2gb8Y68uzSf07tJIsCRnIQzrW+rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=iT3nE6ApyimTzCCmjq7oZisX15Tvs+j3ci2D6D926xs=;
	b=4Dwinpve8iq3gCY2UL2LsvjyU90Emcco6u0yo+yoKxCqavphC66pa5O1+SfFrC2fuSc3
	 HAIA7C3U4RgImMu1szhIz3wrlkQkaokntdayoqQEAhFJyn5wZcamo8l6YCqb2FQKGhiLO
	 +59BS+jEyFtzqGiuinlKmXMOIQ0+0i85I/1SxhTqi0xcV0nPWxvQn/P/MPZMEMEbKp9RL
	 cPqi+6gJAgR9mlOunPkDG4e9NI46tP+tgWX5F2HJcxvXaeVoa4fOeJTMGVw+A8+3CU4lm
	 H+rzff1mjFkmSnzHWzy1xRGR6stYPvh0XWBoBKs2KdQeSq/L8ij6PsIohRJmOzdmRng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=futuring-girl.com;
	spf=pass smtp.mailfrom=futuring-girl.com;
	dkim=pass header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=iHHA2tXL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE0606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DAE0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=iHHA2tXL
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b488586facso2190086a12.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793246487; cv=none;
        d=google.com; s=arc-20260327;
        b=Szrn3vhMOMq0XqFSqzRYOex+vgxC6sYg0IBD7WONm1VjlRImeU7+mTumzs9EeNf15b
         CJ06otPIdbaoIRx3yTWZv4TW476d/a0KU/3Qvdf+S4cUx/w28n3e19xn+69PEEVUdNGq
         9TYBnDBahlVv8HjhbY1qyS2YcRioDzoRmjXwHVY91yar38fcwkIkIpxQfp7hjz1Zz2PO
         m5alNuMYNvtMCKIP4Ra4H8xA6SIgxpmZUgLW9tiMdmfN+JRNDqLHh9tw4tZhG4IWsWqX
         2+XRJiPY6o/LdrnUrlH6eBDgeas0XgXOpfcYdD5/vvJEvD96MOznb+UVY+Y7hQhtIjKL
         VaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iT3nE6ApyimTzCCmjq7oZisX15Tvs+j3ci2D6D926xs=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Pzf9cUghjKA63tT2iSJpizJFxJ6IBmvAiwgrw2T/fsfuGxYr4XUehpcSfcKevF+dUh
         sweKkp5ru46oLOTdcPFFSQjUHZDnFlt1VUclCUi/ACJe/SjdNrGE9QJ/4g7Uz7HdnXmX
         Byrne3C+/HBXuRVidWiazriz/ZAhUDNPj+eU3mjXbX7HedWV++dE+6k0WSXbL7mqEsYC
         Vm/UAVi2lYmwNhaU2UUVzIv1opOo9RBV+FAghEplNEvBZF7lPbwVBO6PjtF0Lr6djzLm
         l+QY1dlNodzJGSzA6X5ngf8ISEyqhwZiodSxZ2QPSfCy6hZtY3mHj5YowX8q5isjJ0PY
         KUWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1793246487; x=1793851287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iT3nE6ApyimTzCCmjq7oZisX15Tvs+j3ci2D6D926xs=;
        b=iHHA2tXLlvWeAKSORhaQZ/IzEdimnL3jlQbT1jVvqVpmTNrnJlNQs6yKlKhiMgpEmO
         +DYyAOUElykK32bOUvpuAKhvWYTvGU4HpwztS801LwzIu1YnR3WIdqOqxepy7Vf8gmzq
         9pYwzNM/b2JzKLWXs19ihe8yyJTdRe8qBhugiUMrGJ1IAAL8Yk7B0BedRe31tqM5SIxr
         GpD1DJ7CvwqOaCsDPABslTpz9cn16TEpkyV8sE7USMnHxWe+MluBJ6jUL+Z5BAEp7/Gb
         7HLPuH7BV017UennJ62i+j390PFRS+Sv6NJ6YhKkP6G6PuW8nCJ802sioAV9T6p20Skw
         e2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793246487; x=1793851287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iT3nE6ApyimTzCCmjq7oZisX15Tvs+j3ci2D6D926xs=;
        b=MhO7c+riWGuyoeylXE1G9+mv96i5V7WIef7ZMpfZz4GoQRN/2KEOVS+YRU9P2yeoRN
         dBQgKGch+o8aXy3gzprH4zXg9FIE3jxLbs//oR9jP5d/29W/1phVSt9tMAo3JXqm2KjY
         zpkFDqeyFGLhGezAEAF3ZdaCAvg8UVGA/ybDXE/ZKzOvDnW9M636e12ayR7VjZWE3DgL
         dmZzNZYG0l6PX6GBXIGUuoZzTGWSprVMg1y7ZWLPeyEmEfVbLx3+ac4Npw/GS05pEpwP
         4JV1LSz2DPWJaVgS4Fv+hmP+Rfgi/113r8sXZ7BOqsE7qHar++rW2Z/fitIfLC7CbrUj
         Sy8Q==
X-Gm-Message-State: AFq9FYKb03HX0THeyMFKTKHVC9a2yb+Du8mvk3jjncaZKtPkkJuqUwPm
	T4cczrS8w+d1hlNShXUFe7xoPdV6tG8xgAsv1YwrdlAbv2keCxavTHtyjQCqEo/ftnxJkQg5ysA
	rp/gm7fldqwae0x5oLoJVLGqPMzetvgFkhrH3NOHoIw==
X-Gm-Gg: AYBFou3b9UoNXinZpFnrOLW8tBfns/byAwnMIx0Ew9bCKS6hgiUQvbGdVU9AiywR5Wc
	s4tgxdgVZ0Aoolq2vizf0j7r1P5HoONVc5DJwhE+a5rT/alyt5LYl/F6hUZWKOETtXDDs4I1lgk
	6CDBwzsAIypIdYw9ZZOQx92JNwRVoP3bMsxMqpfyRivi9bWhtGkYpuskKJhI0g8UB3mdOCNgfrs
	8loyh7DAGZ4yYUW1rNjODjjLiRwBAOjZGqWSPSoJUzq83aA8lvyywoeeG/NE2cVQU9JKEM9lHhE
	KMF3PheZUu8DFd0bzEzG/vJu0GukYXmyu13IpxWe/ReUj7T8cZwhPy3um0fvzaiilCmcb0XtWbo
	g5As394dekrJlD55oPZNYGRu+DLKMdqK+PMuOu80vJHwlLzAmX6IQ6Ys9GC+kh3SAcLjZ1if33g
	YqzaWqxT9UJUzUSvI=
X-Received: by 2002:a17:906:4fd5:b0:c40:d920:747c with SMTP id
 a640c23a62f3a-c49bddae15emr389406866b.7.1793246487395; Wed, 28 Oct 2026
 21:01:27 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028165940.394092994@linuxfoundation.org>
In-Reply-To: <20261028165940.394092994@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 29 Oct 2026 13:01:10 +0900
X-Gm-Features: AclHuK_TGkwUYP149PAu5-_zJUxgBCxS20qXFuFYQvsPLL8tgUO2MuyiuzkyUOM
Message-ID: <CAKL4bV6ci2U6YcAYniNgZq8FL7QUsSjM7GPJE4BqmK8F-Vmczw@mail.gmail.com>
Subject: Re: [PATCH 7.3 00/38] 7.3.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Oct 29, 2026 at 2:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.3.1 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.3.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.3.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.3.1-rc1rv-g57ad63e19488
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Thu Oct 29 11:59:18 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
