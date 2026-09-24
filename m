Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540404B5156
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269714; cv=none; b=Xvp+6fTSm2KxyBYV2+zPDeSgVL/mTGdLoZYqsNrHm+kZdnuMVdjBwWBpYNRUfRWo5YW9VpjUnQAmkYTYkncyI9plVTfxKiUlswAlFQSzzxDh/mc6rcLSxdE/U7aUIkdfuy5pzTij+Kl2y9NZSfJuAlBgecNEWRbTO5ouuOOE8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269714; c=relaxed/simple;
	bh=Zumv4Leb5WdBFx26uMvOk1o3BDLM1XnvsCTFYNNDQrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6r+RBjt4x/LEEswId/eQ8X/rMd0Al7Py9UzNpDsayGBWbjRuRtjWkj8OiX8R6sgScVlyJsMY8j34yFPxmgbGXTPzZlz6TzJSVYtRrYPShB797nqQgZ1s4IJtRdAtdGRYSYDdPdk/ENN2Bo7A7es/Y7GLcIvWI6wmYcXFsahs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Aj+unuvX; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Aj+unuvX"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93910ad2273so2610585a.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1790269710; x=1790874510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h/hfVHJxL5+LrP04774kzPI4k7pmHvdsjzWtlUjUHhI=;
        b=Aj+unuvXfqotlTSyKfesoZfSPLSaP37qAv+XfIxx5tEXzvq+YCiTEIqHOxjNa6gGZk
         1gHBNTDXgA5OFjo+TOYcV8z2gDmGEMv8dLh45b+nxO9FRl3BwhTUTqdco5+H6j4S1tpA
         NkqLo4rmlvlHasAcHxOwaTbpiTO3c8YtMUTu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269710; x=1790874510;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h/hfVHJxL5+LrP04774kzPI4k7pmHvdsjzWtlUjUHhI=;
        b=UjudPMyEsFMhQF68rf5nGppzNcc0j2J+k/eFs9XDR4yplUz6Mp3HmSnvWH04fcVhl+
         Hus8cabltPhvxpEMNMwTEJ9jMPj1L8D1ClElb3+thnvvFyMG/Iw4JqtH8PZIw2SW04B4
         H9ewOVpjauOwfOnwKQg/pN5Cmtz4EX/A3spjBo5pLUyKgj9Ha09Av86nj/Yq7tcTazRw
         aJUsbN3EwpdFfxo9o7uh6dzcqybzv2GzvEVdgMdTWO0rUDCsspHw3JqTSW9FCYiDMkrn
         5m3vULlMybhjD14kViVKLR2bKXHR153y3TLsRbXyssknU7C1OpMdNZDb+Q5ZqXiPEAy1
         VDsw==
X-Gm-Message-State: AFuF++m8pr/3P9/NLaYy3OkXvOD/kH6jYxm11tFp06WdtzrCcmhv1+n1
	9LyKxPukc/7PqLgXxbffdRZueUbZdcfWJD37JykBEfRPXfmu/xIlfqZFwp1HAb/bQQ==
X-Gm-Gg: AYBFou1N/eiF5X/jnSyMdrXYp0KNILmEvb+IDZnP53v7lsE7yH1dKaJrGaQcUCMGhW0
	6lCSBZZWydGWCH3oUfqQga3QBOnDPt2aX2ztnnqoz2Nwyn6kLSR+vtt6QK5c20FqnYUj/rE6GYa
	68xr1keNaARRI7lKwpiL9nRADWTCnyef15vdr/IaAthEFQKlDNeHLFfsywy0sROPKm/smJR/q4C
	6Y7WULeNlJLkEC6YXI8ZeHmdkuO15BxP+/dCsDAclvlUXKvZwooo3mjjs3Dev8FZlr0syZHSc0P
	Itc7/sqZoneScDYM7FC4CIo+vIiada4fHX1ip34wAN/lZNoLNLVPRp26fMaD/xIu5Ltupbo5SUu
	DTQ+sEj3uWtpw8bayH3K0lPDc0AD5Keq7kOqozn/sOJmXTCqpxTp5p++dPyFsxOzKQ5i8dtRFn2
	C74rcvE5zgU+kD9wNmrXMIt/V4yCY34UXqCIsKAN4NYbkadVKln6upTUJkRv900Zz8pdN+6S619
	FxvP35L93S7ounb
X-Received: by 2002:a05:620a:2a0a:b0:932:ddff:1241 with SMTP id af79cd13be357-93c362bf196mr376026485a.26.1790269710150;
        Thu, 24 Sep 2026 10:08:30 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.105.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c3376863asm243434585a.15.2026.09.24.10.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:08:29 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 24 Sep 2026 11:08:26 -0600
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
Subject: Re: [PATCH 7.2 000/438] 7.2.8-rc1 review
Message-ID: <arVZCmjZxn9Paksd@fedora64.linuxtx.org>
References: <20260923140644.756254324@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923140644.756254324@linuxfoundation.org>

On Wed, Sep 23, 2026 at 04:00:21PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.8 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Sep 2026 14:05:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
