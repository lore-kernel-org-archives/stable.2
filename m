Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0531C567
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268458; cv=pass; b=QHJxcirNGRpRAolqaSzvd64na8u1w8ugY3mrKZM/bxRbwIQiaHzFnLM/4ifeVdJz7aB0LH7RfZR4f2FspLr41WrqDYDX6VDxqtRvgvcjFNBnYrVwO7vZ+mzPSjMX1yV1uk+CG1lyOcJeMY8MhklQZgDWQgz2g72d7v5Hbig/mYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268458; c=relaxed/simple;
	bh=2pR1VkxS/gjIq/SnugPqlvDTfD4YGBwZDpqDNXMin6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucGv+8oaoWJ/pv1r8ZiVZUvEJA0LgHNlX3p+5cd7Y6SWRnBhcc9G6XhlaEcc0VadIrIqu+Zav2UT6w0eW66mvOc+KGCKCupoOxnEYt9bxAAxYnuFth2CwquUHDDfBQuBpBMb6ooFkL8S+EzZtL5LDosDpER3RfJvX+AsifI/DAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=SAv8J9AI; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="SAv8J9AI"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c25b3c641fbso164648566b.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 06:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788268454; cv=none;
        d=google.com; s=arc-20260327;
        b=a4V27sgtrlp819aRiH55UxFygeVqWBbNtkdlbNeNuQ31ikhJcaLUonde24yU5F7tUH
         1KCF24SPg5kbYtES4dLU4W0HFxOujwWvtfUGeNhzx3INVr9tnduMOdbBAeu48wiu1dMJ
         NjRvJEO5UAF3EKMzyXcmfeco4gmckZwfS8FIuldiwadl9+PsQpLGPen6VMHXnbGb+abJ
         LiTIyPPADQB7T6xX8FnZzMCFb65T7l2ATdVvYNLXyYf18tljRwBw9KCMDuLSqn9tO0CG
         h4AkBq4LjRXAUGErxGuQSDtovR2Khxky/FoIWPu0CuePE2hsymu8wlwnDP4kfr23Imn6
         a0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LCiwbEfdLnNOg8Pb0k1gzGYTQSSgjciG29caWlJK8d0=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Dq8Lry5RiMPoKeV/3oz8MHHTuX9vpEP3SD9Mkapi4ygRVHgZDKW+5eU7SMNcrQJbjs
         6E3JXjpEYZNY/4oQzq2cb35ZEZiXnVYcZ0Y5Gs14I885EX1mVwgKHyV0NXteCQAkTA96
         HVBvaCw5KKHVcDbW1ivP4qhPMrHYUDPOtbNH2A6upFax20ToClwtsAA7lsO/9EfnKp0u
         2yysGZtVNlcDiw3goX9NX1zyXJc8BMM3A9otA60avkVjhvU0dWq2il9n+4QkApYZiWs7
         kpUpvmFIq+K91jbtZm4jxpercU+1A4Em8bbKJoM+LabqgejOn0DU0N7yH5cIGommN8dk
         +ysw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1788268454; x=1788873254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LCiwbEfdLnNOg8Pb0k1gzGYTQSSgjciG29caWlJK8d0=;
        b=SAv8J9AI1obQLGknoDRqULqqEKkqvYLtJaf2AKqQMbcsuQriNtWj8Qzp/XkEAwogtf
         wyNsGuejfwqHZoCCqweEk6E255DCABAIT+hh3YBhLNpagYeM6WlMdC+bnkGdxuTINmdb
         1VT1pXyfB6GK/rKjw3ARrHinIZThHTlgzm+vHeqJCJZGVjMipjEPUGc7C35lVU6PykB4
         3if4RRwclE/XqbiUSyqcHxCEWaOR0Or8fa9juw/4B2WhGYDtsa6xhOPfqOvhntUSKKKq
         0jqDL/1zDwoJUNXfJMrl/9nJ96mknCxAMCEExvBH+3X8qSWMjgnfq/3qnO9hCN2DUjBC
         Nlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788268454; x=1788873254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCiwbEfdLnNOg8Pb0k1gzGYTQSSgjciG29caWlJK8d0=;
        b=MdbGLedp0D3aY6UpWFonKYSbaQ+yRIhkKg116staxSDkKkpws6l9x/N8TdM7LOOBNN
         BLR4WrOIH/NmMNJNPjrX4iikbQ9emRideEtx/xigBa2KXgp65bgzLwQ8p3ymFVfIijrN
         LrlF/SUtqh72ietxgvr620or0uStl99+1J98SkpXxFknlTsvodihD2bSLfPqPV9+UsNo
         ap/umnJQf36fsPYdqVkndWYfniKSS0bkWJbFGXgu/yE8+8cZhX4L1WRgrM/zH5x8JqmB
         es48j4fw5mgslVElfo4Pzr5DAMyllIuFuv5lRjKMI7Y82XUg5inCoRLSdWZEWwzh+Nw8
         hx+w==
X-Gm-Message-State: AFuF++l1GR/FvdVJsgBIKxKd+be5FqCoIzp4sFTf8uF21Qvc6QSRxWdh
	N9B8unUeMU7o0kK6PlZa5MVAs67/+WbSCpEmQC95vfDNGbXEMYDU4JYbKpHOR119x8zDuN3xjLE
	h6TdjXI0s0H4QDBg0c6O7+SqJWDobiBnLtmn+yDcqpg==
X-Gm-Gg: AR+sD10hRQwNH5cF2RChcEWV6KHHQw0ktYTO68zp+hVPxcxLQSKI1rojfkt4RZG6Or6
	XfSX5vt3/tXlGmzodx4DE33D682TqpXnq84bl33ww4vB9shrN+qqYansI0IYuf4AbTqExs9tROV
	urEYHKTUh7zgJz31EUufqYFUAN6UVlhcAF3vfaWPu4dC6MUtEDaAhxVOREHB5WQ1dNkt1Rvlfpl
	ADke6B6D8LW/AM7xNBygt+GY5FkCZZ40wIrTAqg4FT363qja5kFbtDPoW0dPimz+Dv1h5xI8LzR
	rM7JvOcSp+kgeL277zzWfW5fTH5xDtuuzVYBL+ZTb98sjQ==
X-Received: by 2002:a17:906:2b0f:b0:c25:2e93:289e with SMTP id
 a640c23a62f3a-c25b3cfe381mr399035766b.16.1788268454386; Tue, 01 Sep 2026
 06:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831133359.055927882@linuxfoundation.org>
In-Reply-To: <20260831133359.055927882@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 1 Sep 2026 22:13:57 +0900
X-Gm-Features: AcwNN1X02qBeBEsTRRDLyB_dlk0yVey98jPZ4G08FqdXCZNm1CnWmiScI8Li-c8
Message-ID: <CAKL4bV45SrCWVaZcbxQtqn-eWKx02v3yiaPXHxPp7sYiekmxiA@mail.gmail.com>
Subject: Re: [PATCH 7.2 00/71] 7.2.3-rc1 review
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

On Mon, Aug 31, 2026 at 11:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.3 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.2.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.3-rc1rv-g6f58b86f6270
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Tue Sep  1 21:07:05 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
