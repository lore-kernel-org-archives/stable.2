Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709AA34A799
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447367; cv=none; b=BrufsJwiotkvKZ9Uiibol6iXT39Pu9yQKSBQJvZtQCelFjFVOcIcm44SMd+O/a9w4dtb9jYo4mFmcit/7VCbb26/xOsPen2Oku93ZF7IvZnNkYWp/1FOdMGuCmiP5mUZxyYnc1/U1MToyvfJBVd0S3kPocuu05lf8CdwJA/8slo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447367; c=relaxed/simple;
	bh=t96RDEcl6CXhzibWckAmming0/q+sT2PEsl5Qk0Iqsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ12UdhXYcihrbrcGp/EUP06hDtx58kHsG2DPQwQtxKidWxE15qoCEqFWu3Ny3Q01ZC0xn8oY0U7DPvlmKaVWIWXKTonoJr11d94uEk++pQ4reZlhCYQRP22ubYkO/5VuyyR5TuyXqCXxsdj8RTvFlIQYha+qUf31W2QThquKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=CxEol0q1; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="CxEol0q1"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-930fad20240so17413885a.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1785447364; x=1786052164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P4b5HVjknF32GrMD5EBEIPgReTPIc+hiy18z2+IkE/0=;
        b=CxEol0q1v2cjqUNXD0XojleacffAGM64Cmw5c8qQLKZi+ioIDUoJ/26QYg7bcErG4A
         6dCrz3YmX9ydXt0TIHh4dPPBcbpIuc6C6NmDlO2tJNMCGXDSN7qUtAEVkggqZ4HcQHQ7
         YLcob6I9s+dTMbdAO5ZTnePe+hhOsXWfCbLRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447364; x=1786052164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4b5HVjknF32GrMD5EBEIPgReTPIc+hiy18z2+IkE/0=;
        b=LEqJkfQVmrv5Wz9TLTYiQTf+GKmJWrpDi/mWG/To42BICX4L7G62Ll3dzC0CkLZa1F
         TEc763jRCfByohcphcwBkCPsnNMkhSRrTuFEy3L3KnuIkijoxti5QR9qEECUW3+kmEbx
         2SUOlVP86QIPg24mwFXoRYA5ChSsidX7+0KLp+UPylwnv/XqLDYUHdnXJSzcWkWFU2YB
         Gzj15i1MxjObxPiQ9WEGrOGT0tG2ecUvFso7nTVUNFV0FqYMYJJ1dqUEfvlMrsnUY0AC
         WD1SJDOyyxTSv6JLNDnAu3rgMJXl7tLRbxHClsclOEwmAd0ieToQWhs1RC8WXiLzR7py
         5S7g==
X-Gm-Message-State: AOJu0Yy+e88giq/AVzOpfeF3x4yb4bQc7K2d93pDf1x5Rqjv9sbmCDix
	nppeWvzn+WAbzxdj4hGeQEEjZId9kVTg+BTvK8iYOJLmh9ZM0JKSZ1ltjSCD8k0org==
X-Gm-Gg: AR+sD12jbeBkxXpGeth17VptDyzr8gyJYRGOOEz31zmJtR7jBd/336d4Xu3ME3FdUgL
	OnFrdJC5JNEN4YFUPnyI27ZmClqctKsf2jzOqA3JEr6qAD/0Rq3vEAVbyltWntKPiiVbg6wIAZ5
	xPfuFp/VaRqBpdxaqOFKk3I72WBUXnj05V261u8z1OQhZNrz//c3FDTpRai8HEVTTxKr6Y1f16N
	4XBdqlEXdUzJpzYbvkIRMxRtW11LAH20zCgkpF2pJotlNhwS1CJg0RSeE59TGtLomsFDmHWZKIc
	Xg/6uUmci8LCgLdCzFrWrDKYMtUp66RsWhQcTLLoTm2u1euTVx4DUeDpLt//SKm7cVUUCOqpEKB
	6jKN32Wsmzp/GN3F8Q0u4IWToFiJQP0ehZzfjdsXzDlBSiWUFpkhLD7O1Am9mn23KxGvwHPao0j
	eP/adv/E9L/t6F25VX/tU490Au6f5TvIEvlMV8edt6qox7lEOdqBlhcXHini7vu9BUt/r79wlri
	nE=
X-Received: by 2002:a05:620a:2913:b0:915:9e84:85d1 with SMTP id af79cd13be357-93485fabb95mr460292785a.23.1785447364224;
        Thu, 30 Jul 2026 14:36:04 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.1.58])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e7318323sm499000985a.23.2026.07.30.14.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:36:03 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 30 Jul 2026 15:36:00 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.1 000/744] 7.1.6-rc1 review
Message-ID: <amvDwI_I71ltT9CQ@fedora64.linuxtx.org>
References: <20260730141444.267951807@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730141444.267951807@linuxfoundation.org>

On Thu, Jul 30, 2026 at 04:04:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.6 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Aug 2026 14:13:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
