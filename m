Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832827281D
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661050; cv=none; b=qQla0rDBXXxhHTBwQco/ouy+72XJEfZY+FDf/04vCRWCsEHAgOafx5kC2zPbOX7fBixifD7g0mmnVCYiTBg3nKpLL/Jb1lMav+aDiMYQ7z8iajknxp6ydJ+Ey9ij6I+0ph9mVIM5EZsZyxf0LLXSZXXXkaqu+gZxiVfAWxTM/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661050; c=relaxed/simple;
	bh=36eol+W5QDKiTjDwYRi2AEoywncUv7wm7t08F7b2omU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUg+ox6eI3M+ZpLeqOAE3CdHMLzj29bkwAYBT3iqAZsSNqq2XI3T3779NhCOuwXi0A33VTdqyTJSt3lmgQQPXxsX/CkoFZtNNzJ0Hr0ceg6LA6duRnJksrB/P5SilDfGtJt4HJz2US3UkI1nuBop2/AoHARQSKtevosfvSGNqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QgofHW83; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QgofHW83"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bf0170c80f7so886127466b.3
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781661048; x=1782265848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnWmqmwNUX+53776sKPk5CT0xeyvh75Crh6p+5PYjcA=;
        b=QgofHW83Kuzcnj5WTJkPJWBIWYk6qn45heQ8cUcPPW0gEcQVM61Qgsi5NUPCwzxlED
         RW0iCI0zcIqYKfX4bCWcl67XmlZni/Of3tIK7Z+MvcxXYYjqKzsq4LWnj5CXxOSqiUM6
         b/v560NEzZxU4uX5TuRFv9BXpJGEFJu4E14XFpmB2skruJXF6Z+LK8fBIkmQXDEERAnr
         aD6oMlH3QKSuSw3p4W6/TJWN24mPfcvXlUcxj36oDw6ze4fpVmxT0WfDwJNK1Xa5XeyU
         PYu2by1CGqyFpxGE7VnRTR+Tnug2UiLOZ3dgYjSAuAKfQrwXCLI7K61HeTfQye8HUAis
         GtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781661048; x=1782265848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnWmqmwNUX+53776sKPk5CT0xeyvh75Crh6p+5PYjcA=;
        b=FA+LKNknAxfTv2LxmcymjY0/tFkoYFnKOMthfZibd6Z/VPwSlEL7UhKFOClFYP/5GH
         6ULwStPq1Gs3X8An7ydURxWEvDn4+EjqEpyzdjMeHCbcCn2Y32c+G7DFBOa1i4F7H4Li
         l2pBnH4L0IUrEewdfN9eEU2RZSsVAM0YczQrrBUEza21qyIYCmOiDI9cDZVkWkaZGH+z
         CTt7bK26cpqOd3gKEJSs+tBUwYMujmlgymcjVlhTSeNvlrlMrYeXc15H94P33AqVGuQL
         iogpH/NTI236tFd3UK7KZYZQpTUSkhSIcv4WhMAShYZwWtn9266oYbORudwa4MP1/VGI
         yREA==
X-Gm-Message-State: AOJu0Yz5kwJ4ztnwrOwo6vHN2kQ9COG+QA0wHshkBAFrX6AlVq5xpfJ8
	jUxdNUso/rxY+1EMg++b0jwU1I0kFdsJlQ0uA3ABEcoMTjHnDEhJtA9wQojV1sypIMM=
X-Gm-Gg: Acq92OEP0wXsfTghb+KHTu3neReHvWy2dzosyVwREu7F1bNafb0jIa3wS4SKfOp5Uuh
	Xnv9AIx7ILjs10Z2Zz9pPvm4ly9yX3eKJaTL0KhyxNtcQcZLjtUbfRR3NibebTmAuvEphnPm45p
	Ck6/clYeWboV9su8Ka8qNMvDIPjxkq6XoXCAObWMLdy3nPG4LPynGWFBm69EZOw17AOngs1B73x
	AYMb61G6NxiwQCac7o98jN5moZOWyKAlis+p5BKpPHE2CLUQlcr9mahlTE2vSeNu5/Tzm/Z52Mj
	oZDOFnk7KCuY3xrRyo6YRaiiyTl9UkxsAd2T6e74g/lr4zdn/TWaX1nURMYGPhq7ZgiLUsvLA3L
	XZAYNP0XZxMzkvASiEgqPi0Om6IIb0+xTR/G04NH2BN2wrGhNaGbgD4r3Q4FIIXvd6CaPYsFamB
	UBBnO3JwCDL1sJ4kM/V89/znyMd9FknaFJ5xwaFw==
X-Received: by 2002:a17:907:270f:b0:bdc:9d31:3f91 with SMTP id a640c23a62f3a-c05a4e0e729mr86294466b.15.1781661047776;
        Tue, 16 Jun 2026 18:50:47 -0700 (PDT)
Received: from u94a (27-240-202-183.adsl.fetnet.net. [27.240.202.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d156sm13111103a12.13.2026.06.16.18.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 18:50:46 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:50:38 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/325] 6.18.36-rc1 review
Message-ID: <ajH9WauCvr0u_xg1@u94a>
References: <20260616145057.827196531@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>

On Tue, Jun 16, 2026 at 08:26:36PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.36 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/27647340765/job/81762433328

[...]
