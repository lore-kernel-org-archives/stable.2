Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82053484258
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247988; cv=none; b=B0baA/NZVB1Sr9T+8Q87WLHQAfa/fJ2liPgGlj0vEVxQaDpZYOT0n2yv7bpkMP6wqGvzSJcvVqznZIDyYUsl5kiLJ61SY2Xm6G/HenwJNbCCSMZDotqsZ3xn2XTz8DvySKsxjOF+DbgeqMv/V/Yfhqhq/9Jf27AqWf5++ep89Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247988; c=relaxed/simple;
	bh=C3dn+iU4ngL3PUMHzRX+ag0ZBYM4ei3bU/3EcjL9fck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6IB9tAg99f4x84ewSyCocpM09xKDC7Qc1/lWah0D2VNyBIcWlg7nbcJgLFEysL+kgXy/0E6AfPejLHm47fA8LXVKKkXSu8xy5m9hKbye4cFwOiOhn18LrLrHs91hiNGuraJ53YO3fsEJo8S00vQLcWCC4zfkvb9Qh//Nt8qzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tihc9be/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tihc9be/"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca12086c06eso152688a12.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787247987; x=1787852787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jrqsvXw2c7nqIiVFrO4n9x57Nm6kA6WYNIkLs4SBxW8=;
        b=Tihc9be/ok2xon5bv98vORclam16nADqfOI7GVAFnOIUXGUhPhqUaIpITjhCiEOPIZ
         ikfHpjZkMg7S3EMOXo4cWj7VPeIBNvUhUvttyC9X9D2YsKkpAYxpkSiej+B9CcaY/g+u
         VMXzNAYsRkNMvssZXEUzVxwcf96zNunLgKQzD1nagI7Es2//vGBb2mjqbrkHrRTOUmXY
         ftaJqeWEj2C3+dIJTquBxM82Pv6s+9oWWHsoqQ3oL04kJBzhuZOhjKf0XxGCER/Hq7la
         7zgukWSdPICUZli4eYbRifTtthSv2jL1cl3i+bfE3EwJ0rPXOAH4GPg98TY4aNDa2Ykw
         6N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787247987; x=1787852787;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrqsvXw2c7nqIiVFrO4n9x57Nm6kA6WYNIkLs4SBxW8=;
        b=j/gYHB6KT7bJZngk7vYJhVU190uxmVGBdbJHkj722GN81Z7B2ENKvsTbIasrknnmRy
         RQl4gC6rRf8CiYjXByBo6rOQU9OgX/iXLGQeIFg87+zJdXIjCXjAIALosOzTMUNGpZTS
         QIPQKHfnPXFKCCL1HMphZS3wbArDmzGVpCdOVfbkLCyybgdIwrPrUhZhd1pu/nNBX+kg
         ZZtNSawIkiTH/X+hENxw79lMsu0P1OIyptgXf9q9/lg+LRe6EHRMERtVMNfHZdJG2eLN
         FtRvs4KVcpHR6zibP/VSnsWv23lzDI+kW8qstUTKceAo2nR3g1PiyCmUpZucIyFKOOTX
         GQ2w==
X-Forwarded-Encrypted: i=1; AHgh+RoBR45+vcg1kwAc48XTYJnXYQHGuRXrAbIp/n3DH0MNp1Q4DcZ4H4LP/LQoWCfzmD+S9zvbRsA=@vger.kernel.org
X-Gm-Message-State: AFuF++luN9N7vbOy3FT1kRJFP94S1u/b/4EYEy851WvguBfwFOJ7pLbc
	bj1d4tUGiOabgY4Iz8wD7B09eN4gIRBdhMeh3iKfEtoaOQPbqD69XSLS
X-Gm-Gg: AR+sD12XYnIxmzodPe0jdp2FvkfMrkGy+sGPuDFIrpOX/5nyg07ocCieqDAyQ9rTt+/
	oH4wkH0Vo3DCoM4Mj45afiuwToMlosVrvgivttB3/xOkm9d9MCE5jOUR+MD+X42HwKkZ5xYKWRQ
	5weJyz1G9myDT3apXqr5WsrDtOVWH2VFtJgMVFhXialCYJW3oxb+Pn8yJdM1Z9C+T08URn4mlTh
	x0wn8b3ZCIwtZfxxCbW86M3L2qSZIYlJYbLv0mtDjHy21WgwI9qbekqGzW/yo1KDxJeDlV03fkx
	zBmR8wuCYSpbyxfhwxPAp1Zg3AGg2bbjf+pIp62YrDNzoocoShubL00q+D9ZwPvauDcpnLGx43n
	NvDR1vbgyVgZLMne0v+kEDfwJ2Alzmz9aFeG2ZvWthz34NoDQF/HlhFfKPmxJoUHiAV96xQ/jDW
	eB7D3t08qqhm0IbI8PCzfV0lZKSmhYi4VWj8NdcoYHFb0lmyr+O0eHdnVJN0H+uGqlwU5bKHWql
	9lo53a8EHbFb8B5yejE+jZaCw==
X-Received: by 2002:a17:90b:4fc2:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-395c33e1194mr504386a91.2.1787247986770;
        Thu, 20 Aug 2026 10:46:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm29418162c88.13.2026.08.20.10.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:46:26 -0700 (PDT)
Message-ID: <b08c8f55-e802-430f-bc74-e6ef76939ad4@gmail.com>
Date: Thu, 20 Aug 2026 10:46:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/235] 5.10.266-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260820145216.426568665@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260820145216.426568665@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 07:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.266 release.
> There are 235 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.266-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
