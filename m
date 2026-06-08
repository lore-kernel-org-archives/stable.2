Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940883BA241
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913297; cv=pass; b=C8kBTPzq4ZGv7TE8vXJ+nrYesn4yMb/CbM+q/Kg2OaIKWBOKDEmFWz2y8zgfH9UzkqKQmrK3IpHdEdyd2Hah13PHQCdTrg2CUtaA2z0FLOKTVbDdsug8XVgOeyBU45q1Cu3rN2/gvkREQo4QBf6OM6FPX+HEvJRDsyaMeWve8tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913297; c=relaxed/simple;
	bh=6LrKMFBGjj8ct9TTofDjqiF5sLmpqspGhITcv9oyCgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdyqDaNDxj+iP7LgFoV2mgLRNgOuabBtJlSlDgCooQ9hN9YPNSnsJQd6UI29hL1pZgWZ8ij97Pu4zf/RgscDbJD6HtOpQVkBlIvVW7g8L5jc22w/0ZKFa+mobkIMRXI5eIIIDOf5x5nv5jttfxipxt1qodaTxMxIHPXbLnIHdpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3sZ0rqq; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3sZ0rqq"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3042a99f0ceso441801eec.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 03:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780913296; cv=none;
        d=google.com; s=arc-20240605;
        b=il6bt2Cn0CINrdn2uDQPM2g7w6HrkW7i2pKbNnaHuOYhmhFIUJyqaev5PBSeBdlhyn
         LZ2GaVmV2FRsgx00bnPxCflSDPMRXMIti3QNJEL5JR4wDoTDXzHqoCN8iuI/j7AZDOBH
         kWvV4V4QIjZ63RBJx07alGrHpX5/WslIqcZLcMrrKGSzCd010GzY9+pMchR+t8V6WsD+
         FJl/rZt9G+uBdLasua/+vhHZWRF5OFGU9ppgCT2MpvA7HZZENm3xj+dChANWWu4toaXU
         Cu2JmvjZuyTskb8x/kYoOGhtTPdmsLOQxdjMtjScwUEevkMTaPIYIMzfgDkYrGaefY/+
         UkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xs9GW8UG0vcJ1ziYEME099eUBntAL0P9yXVtIBd74k=;
        fh=uFAoAVyyGKojpb2cNaACsAh3lhd+xKOBS3gTNAHb1zE=;
        b=WxrYVI0TG9vdt555egAQovr0L2UC6o681LJzyzUe1m+u2iTCFw442V6yAOHn4xANPY
         JnQS3yH594mzW1vbS3t1NGlFgBN7OW5kb7gxZLBCmDQA9rbLz9i+/MBNXfQuy9Uvr0+P
         ta49Km7Q6v0ltoVGtvnzLMIIG1gyWY8/aQkLZi9vKrChyLyl54VOi5zJeqnR2mCWY0Xk
         LK1PLdfR6l4VLiGNw7t94xTMw8qiYc90IHztSU+XZQuxiyuUvU03Kxsa252X/P3hSC6n
         Nzdc32R47q3QxmmSeEVdn/I5OfDMjVCvs1vkFljDdmQfp1Sg7nftowP9r+gG3YFZrtL0
         VHAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913296; x=1781518096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xs9GW8UG0vcJ1ziYEME099eUBntAL0P9yXVtIBd74k=;
        b=Z3sZ0rqqotGaOvNoy+q60CliGQlxSA7tyer492ZBOkSqL/EJWis4/CFCihA8c/L8wZ
         X4+UKuZMNmswUGkQ/QTGRA9CmC5vj5MOJ8ZNCCH0OvF5A89LNloEVpzsn3/RLtbXtDTv
         +tqCB8KrI6x6uVhE3MHDx02idfaou19XVt8KwIq6ClC2OIOtJHIKN4yMj43DOD2OVmyU
         KZpFiDo7V/d++8iUXiyRnboQa7npSKMydgywC3R+BtlPcNsNKCn190lNofWH+xMU+Jqv
         rlzsGbQ4jQ10rqSWx2WeYqPCcL0f6DavgCB5NboQYaz3hckfvKAEh89gBt4EG1T5TXlu
         N0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913296; x=1781518096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xs9GW8UG0vcJ1ziYEME099eUBntAL0P9yXVtIBd74k=;
        b=pPh2HUUOmyMGd53qpCJI8MFhv/G1+D+ApeRYpgd/7i0pJ+351mLhbx+/PSkfig+yNw
         nVieshOB5bneZ9EI8ENP8/ly02k/n1xJsLYOGNs1kmYLSxwvnL5OMPy5XDmxLXUVBmvw
         MjOuESM+5IakrQw9F1xXk+1LROuy1V/cRjQkrQF5+DkYUHe9rfvqoFodz7xb94vg1Ljc
         WDFYRSSLp81dd0Hh5UknHXkR4YNkKH0GRujfQVtkK+35LAVfAWZmd+RiJZCqa0q+o4Q+
         2l6IZWj1LlZaYuV3ZP0lsTeFVUnQ29Ru8MfEIg5ixL2zyU4o4rezWeKm58leZxTowHYL
         C/1A==
X-Forwarded-Encrypted: i=1; AFNElJ8Z1ns9qV1vAvP4TBd4Vsj5pGEIxKR6rjMvcPs6/8hnpQOCy/cJf8HUK068+QX+ZKZo5WX6K2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HnquSTglNWTcIuZ3vbQNRPR9dWkZobnhKyQ88Q1wGKLaiz45
	zl7f+7UU58+t7bOu8X7+99PFITDdKnHeuqt+JFBgJw2lJWmFa4X4xEeMb9uWy80oHXpKNhDuE8A
	+a+f/RYg3pdTKZhFGLpSmNSpOcJ3qdEo=
X-Gm-Gg: Acq92OH+X1CWrx0iEY4wXqE49XHks76gtruzXSFlnNCkHHRHlUqg0S28JK7ycgZ/2We
	9MebZlEeEco57wYl4CdZVnPJdngBNhgDx6KMaddo7qyKDN11bfO3CIo+RIUGHGzqZmwARNMBspt
	dGIwxyjt1uUaEQ5RpRVt+MGJTSeOesODJUgqyeW8EsPDmypdlCPmzOwWFtAAqBzlRZdssFlAcOm
	lLyig8sCodkymYoaQa1yv380bmMFI4jgx88NtSgvWx7xISWCpECCCD0sI3e9FY423Mp3r+rzvgI
	rghtCeuag04t3IOyXQnDWHm90MyvzYmlDihmUEvlX66PRpHzfDCbR1aLqTmuAiwA6K6IhpRy/Kv
	C1SF6Q2TwOVOBjePy+GVHr3tfFXFsQrfefmJVP4l0S6LM
X-Received: by 2002:a05:693c:3945:b0:2da:a813:a629 with SMTP id
 5a478bee46e88-3077b223afdmr3586110eec.2.1780913295620; Mon, 08 Jun 2026
 03:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
 <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
In-Reply-To: <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Jun 2026 12:08:02 +0200
X-Gm-Features: AVVi8CeZqXycb_mHPYx-p3hvMm2G0q4sVMGiMxTvH8pjrUyAWon96zgP6NZJLr8
Message-ID: <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, "Kito Xu (veritas501)" <hxzene@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 11:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Thanks for reporting this.

You're welcome!

> Unless i am looking at the wrong code version, in the current code i
> see m_eaction is always initialized before being used.
> m_eaction =3D READ_ONCE(m->tcfm_eaction);
> Probably a compiler false positive?

No, it is an actual bug -- you have:

    int i, m_eaction;
    ...
    is_redirect =3D tcf_mirred_is_act_redirect(m_eaction);
    ...
    m_eaction =3D READ_ONCE(m->tcfm_eaction);

i.e. the assignment goes later.

Maybe you are looking at mainline? Please note that this is a 6.12.y
-rc thread -- are you looking at the commit hash I mentioned?

Or maybe you are looking at `tcf_blockcast()` instead of `tcf_mirred_act()`=
?

I hope that helps.

Cheers,
Miguel
