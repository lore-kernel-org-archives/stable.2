Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94EA31327A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232354; cv=none; b=WWCog842Zz+IG9iN3eSClQlwF7d0QPBxJ1+uTWnuB3d/J0gz9slJipWc1W8Y7IeBPrMpYEZUPSLemnbiGUQL9sZS3nqn9YQybYOk5TXHOm6QZRmoVkqbwjWkwabW1TM29779fDyFvyaccCOpz/SaKJusvmDM5oicuaIdeL+bthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232354; c=relaxed/simple;
	bh=bS9vgBmB3tygjnM6Lk0RmXc5gL4e61i98UaQtJFsyUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVqJkz32Ho3l1uiraXJKQECfUp1lIir9uvN9FvDSq70KhdKXaDCwS+5F9TBU+UxS22m/JdU8incxQ5sf+uxiIdxBpJSQ2CFJ6gYZ9mv9FIL4a5jlxJC22a7oKFPtMQ+go+kNuiuJoiC4FGHSH4vEvkPjPdzUgkyIqX83PSpkk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=CV8eIrsN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="CV8eIrsN"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38deea72eebso4894349a91.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1784232352; x=1784837152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FPLskKBTAYLzNg31/NHqPBNxF5CkLTQz2CVmxWqlogI=;
        b=CV8eIrsNFv4s5SO+sPK0P1x5P2TT7sJhXu8UQPpKlwBfoRTETevfUpFqrY/Zx8hD11
         aICF4s5oqHJpTqBeTFZoR1BJWjZBdUrrwREtMYoktfG+8Gl7rSczLP/UnbwS2i0kW8Y6
         R2otaP0INi0BSUbr285XOuKyAModo6ch7i9JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784232352; x=1784837152;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPLskKBTAYLzNg31/NHqPBNxF5CkLTQz2CVmxWqlogI=;
        b=MECxOxrla8DUQ7RKzQ8l5+0hSJfbfCE5qbZ7N0IC5lGSZc55Rx7LOmut82cMMW2adu
         pLq5c8rnZdGK3lFJucowTEJLX/mvELNTG1Sjbx9VDlAY3S4RwS2Ge+UaqyxI/T7Hu1KF
         J8JrHmt791OnZlFeXeueCXy2GH+fljQb6Py7GgQedYkJIsDLJUpHLeCGRX8hKf2jxPTY
         2eypc36+qzh4pU9sUAyuV29TxytAPlmLxoO1ClceiO++JMI4N7xBIs0xHy6PgK5AtS5p
         WUiawTAflZf+OLgUUyKxYvxYOg4ETbmshLgZIYb+xCEOMptzuQjTIwbkkGzyOfbhzX4J
         1vkA==
X-Gm-Message-State: AOJu0YzUJT/oxLh6tXd37AQmf6At5Eu2hfoWEVcQL4qkHlCXY+pqWrGq
	zcZmpkDpDiTHv4RnspreR4TrPTWwMV9iV0iRpSJDFjmHGfVDrnzewvQbAh3WVkHWhg==
X-Gm-Gg: AfdE7clQhFmSO85VKkD37n7U5x3iwEPXcw361z5Pd8JOSbPfyQ2uLAEgwdTRvbDFgoF
	I27hG6lDjGFRHTBbOlzBz/GyDNZRcs21cjpDglnNFe7jIDgUFLgFAC6VokeWNHyhEc58J+a6b62
	fIdalKgX3sXb6z+BvorQtOpdmfQzrvfl7F+qcnwegR59tgJBYLHUQMX6pwfQJZZkpuL9bWXMRnG
	T9Bj5oEdXyLRnNDOaAd5+U3tz5lzAH0GyN516y47oTO+FodjvCyLcj9uaVlDLZrTaqjeuFdJ91a
	Vhfl1c41PWbayFWnLGIfV3u3dSaE5uUd5VkWUhxrRJlZey7sKAaADlj42RtsBDURlE/C/6fvyUs
	Pj38qAoIrxd6MHbsC+gJp+mpuhEKJrA9LLO0ARItRT0qI3csc1OhrqVUfvPLowsLGPCJYAoiDQu
	vPUHM4Q1XXKApsHHQxsTNHNHWo+7C1Zg==
X-Received: by 2002:a17:90b:4e90:b0:37f:d265:18c5 with SMTP id 98e67ed59e1d1-38e29ff7302mr7496601a91.18.1784232352105;
        Thu, 16 Jul 2026 13:05:52 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.105.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31413c78531sm12492180eec.27.2026.07.16.13.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 13:05:51 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 16 Jul 2026 14:05:48 -0600
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
Subject: Re: [PATCH 7.1 000/518] 7.1.4-rc1 review
Message-ID: <alk5nOGCzt5oAb7X@fedora64.linuxtx.org>
References: <20260716133047.772246337@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716133047.772246337@linuxfoundation.org>

On Thu, Jul 16, 2026 at 03:24:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.4 release.
> There are 518 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Jul 2026 13:30:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.4-rc1.gz
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
