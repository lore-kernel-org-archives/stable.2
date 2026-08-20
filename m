Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA73C13F5
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260855; cv=none; b=kG4MUmiX8lRRBUk1SyAIDo84nQbLzAgnYjhvYDzeCKUqfvRrKIYDr//s1ERp/+AWOJ65J+38iDO33HmtQiovi1/lWuNEAaflnSgrTaJUJzrQHrnS7D1YttbpFJKeaRQzRKvJ+qY0KWFX5sBQ5febmK3ybfwAFotHLh2Kk96DbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260855; c=relaxed/simple;
	bh=J+o9dH3EtFMjqpoc6CIIwziyQDea7+QKvQj34ZKbAWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZfJX+54aA2BwIWN7ajdWliFQkJS/98o0cu+SKtisxijvy04OT5gScbhDSNmNgI5NTjMJepFJ7AkxnRg0i5LbOl2PlROAfF88bUgpb+nZUEQ4WAibb3OEHmDvKeoH0S8dAIaTEfFnzDs+kXbNp2KaCyP0Rke0It9epOYb5wz1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrchR6th; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrchR6th"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccf2360620so3071855ad.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787260854; x=1787865654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SwYkwkNmLdvsbCWU4wBK88wpaHOEd82aK+RJCNSoNg=;
        b=mrchR6th/yvoPsCzzOWFwi3YrCmaAekFNKGxnc4u4o5Qxcx3rDF3Swi5JirTfFo6UV
         5ZLme4Lc1nnLLHz+0ipDIjDd0xa6ZedUgtgVaEqTns5UdVszt6mAoR5IcRhjdmROkH9E
         P9uw7CieJMQXY7qjZAgkBGBKta/nFpJBUYxiUZ0bVwO+whuza/1oAaAR7bMXO3wtC7Vk
         2AwQIAoccpoD9WkyO3j6InniZ/GjizRdXK0CpPCqRAnnrS3jbs9AUGl9pKHhR+5pDpRE
         +QcAXcqTDDWO+X75qIuZE/4beTRQzLIYa2JVkzmkLWZEZqV4pYOFOYfYu1vNZA3AFZD/
         KWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787260854; x=1787865654;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4SwYkwkNmLdvsbCWU4wBK88wpaHOEd82aK+RJCNSoNg=;
        b=OXZYi/YGc4mhgAZSMXyjZAcH+cKoZvqH1P4Qk/B4AImkawWwU0DlpF7GRLyX+KD5Tc
         bP9T1/7kzfZSrgFvfTmoNyWIegeLJFLTrHrHheOFTiTSiwmjffWzfDFykkxFEeXfLh6/
         /vU8/y9saq2tAmXsK9tg2fXbrkZmBl+SLWYxWTuWIrJaWkB4+lk3SADyZ5KVlQiA2/E/
         lFekQRgXfQzOh+qWiUSWhtNsQ/ESFYkMTbIZ+pND9xtSStZbwo7D0hfcF327TOqeq3jC
         7FHKq92PjUqNX51a9T40w9wehGMWZ6CfKHV0p3BxIHzXCyfQohUqOGibpH/I3WE2kGSg
         c0Iw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7HqMAtP+4jK+jLxlc4nDyhmJ670mo7Jcsd//ZPJ5C5zXOkvUpD2uVgQcShOs8GO7jr6aIBT8=@vger.kernel.org
X-Gm-Message-State: AFuF++ndG+we6JB/kydb1cXtQK3mj0vbiqzfydZG7D9OUHs6W5md8svP
	fmI698aaanVm7mECFOVk/cUBd4WJW10rn3xDdDQI8ubR0lm4/zzdy3DY
X-Gm-Gg: AR+sD12WxTFKrL89tvlWQjQug7DB++0z4vuQNxxZH/CayaVBHtGUR6GsGdFb04EjjD3
	+OZpYiEg52N98RcQF4vbpkDMNSzKFqDBjZ/TUF4Tat/8FVjRVFQLAMP9SRtHW7UrrAkCj5udkDs
	Fk7MZbhemltNQHxRTXd4SvHtdN2DkmdyDbWPJaazczxE/GmmhvFwA1p6VNptPE2hINgwKtUk9fy
	fHfNfYYZhqVNP2XDVwGnSGJzEQw9UtOqxdynsGgvMajCpop9j+06RRGhcDa0fOtXqLROq4F2beq
	UzMYzQ1xPuuPRCmsAhfHJcFUAgBDcZFo/tbqLDgH2XTvu2sN9rKqlWOhtF+uxfPTR0DCuIahx+v
	6UFXrcDxj5sSX2tOMThMdu6iLbL3wRdSx87/UnuA2TdO3dnCYdS9D4ljdLXH2x0DZbHd1PiyO4L
	2NTbUAR5TMRQuPL4xUXLgOGr8fFDJC51v4mgda2EoWZ9ZhKQ0ICmR90BHMyjfDTFYgkhzjr/FTE
	tzCo3AlWpb21GE=
X-Received: by 2002:a17:90b:1a85:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-395c3aa9e26mr1971749a91.16.1787260853762;
        Thu, 20 Aug 2026 14:20:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327cbb46ff8sm14493836eec.23.2026.08.20.14.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 14:20:52 -0700 (PDT)
Message-ID: <de2d1251-83c4-43f1-918f-9dd27891e446@gmail.com>
Date: Thu, 20 Aug 2026 14:20:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/217] 6.18.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260820145237.531699751@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260820145237.531699751@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 07:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.46 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
