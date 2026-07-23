Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47878411F88
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802372; cv=pass; b=EhOB3uPdnaSCHct/mxLMJesZsmTwyVNNobR9KuWqt55RltrV+zRr42zWb8AI51Ae2ILdZyCspLNPMn79V1YNR3IBSX9CGf507Z0kqp9vJhU1xgOY2ni8QnwoDayhhn40qxoFzQ9x95irpTakQRK9XWubdumnPOUXmexMUWYknKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802372; c=relaxed/simple;
	bh=5x06QjkKCMWyqn14GmrGgv/C9qLWa5XhHu055fE6FZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wlrmvt7KzvsEAmgx9P92F5S7XFOGNvVSCFlnGGkjNHA9icvPQusZs0RCuLrxQRLOael2vH6hJutZWSCHTllh41rlxaM8mLRHI29wp2Pps0so/Kht/ytDRLpYRNhRBTevOdrr7lDsu58IvbOXv4Fju0EdE+VzGY/xrIQMBESjCak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=bOJL27gq; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="bOJL27gq"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so335945a91.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 03:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784802370; cv=none;
        d=google.com; s=arc-20260327;
        b=r1zWqcoi78bCr27xpjSqhC+SprlBImhk3X03r7nnfRuuXQ9fTc3kiXwbmeJxTQDHPN
         TNiRKVMU1tGCWEBMbRg5vXxhkQJiLoopb0V5vVDXw0UGU0iRlCo687z6W2dYwy0hbd2r
         yD1R8RcOgQ0VjwIS0W2Z8KKEd7ue/H+aCIDF6+xeFSq2Wo+24Qq73HqzGb7APAehWuFB
         qBIN/QSZ/NTgvMfNI3bdh1rziXQmlrQ5dy5MNhiqd4tS8J0dV7Jfr/R8L5F+x+vKjTl1
         TVJPJeiep+bGxEdWO49eYqHgNL/dMRnRbdU3/gAV10lseao3ZOzYRMH3URS9V6+F0Iqj
         +pCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9u1UX/uIA4BS7bXZAkDJRBnwoEvuvzO/4om9dF/YP4Y=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=KO6lhN0NbKVVYG/dD4zPskY5Uh2BGs1VcmGng1BzN4Wa894bAaIxfafjdzgBPbDuWr
         4uql4Qe+iDvT/s9YKGco9U7ZNJi1AF0Kbw9QdM1WlLKq/eoVjlS1T6f+5lR5/t4bs3C2
         A5SZCsM5it/bdvKmCkEu/TrIJSDPvqQOs8tEWsslcUVpLLzP3ePWOsyKogQgsQ7EL42W
         ph9trwJKGYC/gxx2UloarLEkQQT5K35Wl8Mi5nWEy6MnAAdtws2+ehZHXzDUtDFNUZ7a
         el1xoBd900pMc+7OmVpVmjzqcyV1DxBkzo6izxwCCyPKvvO4/GR1EMFoUdNa8N4/rG5M
         O38A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1784802370; x=1785407170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9u1UX/uIA4BS7bXZAkDJRBnwoEvuvzO/4om9dF/YP4Y=;
        b=bOJL27gqHH3NPwtsrKM0pie0RKXyKeWgjJEj6uwGgWjS81c7uqlKc0xkHE9k7/j8/4
         P+npl9d1CuVaft8vGsiD9oWIJQy/UNI0m7dvV450y2YRD1sZtVDooEtESkmXWX/d4TN6
         u6VEG7YJOP5Wk0vEcjOdaLGiffLHvrwyVJgb5nWAijwyrnyy4zX56N//XT7AeLuTWyA3
         8VaUmVUV5iwdYpbO7ohbEN9UvKMumeZ4wJGcGy4xmAkIIwAb21zZ5tQdZaLYnx2WRsyp
         VuNVv2OTNnKZX1LOasaxbkaAWZ+RRmMkTbZDQSm4SP45+lwp5VdiUxCopKSTEQyFbixk
         m7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784802370; x=1785407170;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9u1UX/uIA4BS7bXZAkDJRBnwoEvuvzO/4om9dF/YP4Y=;
        b=onwy2khO4Y2EmzQHMOUzb52M33PytpFfdUSM6wBBITGw5QVSEZmYwAeZI04qiXv7IO
         6KlfV03IRMDTAkP02eA/8lBHIaESbC6NUFj1L92jqI1Qoi9ikFbg81kOSEaKG9LTxnGZ
         FBDrz/TAcTTSSI0ibRcU8sg5wd+CRt8zaIWKpLIFsdaH6JJR+0hNotgoGdUZWN0TVfE2
         cfNF2rvp6K6yc2zffs4ZZT1nf3q+oOAYIdh8JOhO08oE16aA/WfQz2a7D/iEFbIXj6Pg
         3vc2Ng+bBKWU/QLyYKcDz5+7GPbgWVgM6bwO8dnApQnZTlkJxnT0ZW50kVe70sB4r5ut
         jaDQ==
X-Gm-Message-State: AOJu0YzWjISgOYuiKnlkKwWTVmjEbMuH3BCCwWqwV181XlihV81KJV4c
	n/jFaxR4nGMPexzdpr4mz7SjBPE4qPJxEsHdyMTEqYGixlB1cMsuW84EMVCWSvc2MUXnD2xtniG
	CkvOefAeQ8CdrT9rBIcWYqnqV2cY269Zl+8c5HTh+CiHNEcV6l0HgZs0=
X-Gm-Gg: AR+sD11AXXnTOSdrSA0Kp1i08/28Smdd2ACn3UYnQtG1B47dUIBvvsiAGnTRAdoX25f
	i2qFUsH0HElb+S4lub7Hmfyhv2c/Pekir7rgqRZTknoxKckyJG9IDJL+ZiHsuELayHyXOwig+rC
	LJVkY80yTFd47MfuOZ8NkjjOSrSEPMEfxPCWkhAFh6ke0A2d/+uL4mTgv52rzdw6VXHEwWlChbE
	Fl//2491YThvXJ6y90ARW4vYxgrAesNkVWAEWdc1P/fVKOc1NM+SBZFskFh3og=
X-Received: by 2002:a17:90b:388e:b0:38e:bfe:81e3 with SMTP id
 98e67ed59e1d1-38ec6495a20mr2393539a91.8.1784802370460; Thu, 23 Jul 2026
 03:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722142947.085426486@linuxfoundation.org>
In-Reply-To: <20260722142947.085426486@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 23 Jul 2026 19:25:54 +0900
X-Gm-Features: AUfX_mw8I0K_aqqKAJQwrewfO2rICwEhVFJVh1-cM4VOtjfc5UtvvOgf3K66Wvs
Message-ID: <CAKL4bV4iTOXyeUddEpsgBgE40Ma__oCFXp8H4LxPiDdathdevA@mail.gmail.com>
Subject: Re: [PATCH 7.1 0000/2079] 7.1.5-rc2 review
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

On Wed, Jul 22, 2026 at 11:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2079 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jul 2026 14:26:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.1.5-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.5-rc2rv-gad98fbfe8a23
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260625, GNU ld (GNU
Binutils) 2.46.1) #1 SMP PREEMPT_DYNAMIC Thu Jul 23 18:26:54 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
