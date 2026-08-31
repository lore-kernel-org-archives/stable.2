Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A203B14BC
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195694; cv=none; b=Ni71bd7VCXAdXkL5+lL56LT7zXTOjK/QCBwophzqd/E3v0wCuDz3rXjtGX9L4rk2CRlPpriSSPYqm5L1MVsfZ1t9WB4p5nNaiawFTXwqfU1cx9+ay1J6ALkdL8LLgvKz4777Yu6UpEMHj83uGkS4FakdbAYnpXoy7fk0nxnGqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195694; c=relaxed/simple;
	bh=yq3sAt1weRagllmnbj8GWuHou+5wuA4UeE2rWNk0/Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBXeHMZDSJLi1Q2APQyt3BYCzFjp481hj33jtOgpnimdzbZ9r57JkktfwtnkPFBbsJ7e+jsxfbLMpYJj9irHr/HHqQaEwM/M2uYl5U0o2aoDwBZqVMiXtjU3Hv7IXGjvExiEldKHtllKAya+CTEQarKBdPGDR2Q9OnogKDkHZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASrt7BFH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASrt7BFH"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso53835a12.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788195692; x=1788800492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=awVImKUzcLY0/XtG0S5LJamAqn3OfyX50g+7J1OI4Wo=;
        b=ASrt7BFHVe7ceSoYNaaNisfasAOlX+OfJjnhBW9M6o/hELrQctWdosYgA17XCPuVnN
         DEnkih+M63jruMl/33QYA5XymSA0cuUSOkncXvOBcrCDRyTt2iBPR0DeCx8d4upVAm7/
         z7uJlqfXWBCo8wMUzf23DAkRro+m/KPb+54nA/IicRXgxbXthDcBRoLMrEGvIKLtw8PD
         N5ih6uzSLOFn0+dl7Y3WVk6qeIW1qR6I7gBkEi/e45hXAw07kr3kMVrI1f46fSQSzozO
         x23ebu1ZiA1vj5HL0DsLMdkHMCvYCdvslxjQ3Ipr5AXA+/nE+gDgWdvti1xb3e5cPUl0
         vzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788195692; x=1788800492;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awVImKUzcLY0/XtG0S5LJamAqn3OfyX50g+7J1OI4Wo=;
        b=I+LlEQeX/jP9QYOH0IE44+yKPeO1ecemJ7MkbWnaUSol8AOj3O5dwvwrsTBySdOwvE
         fTzrcRh3kVtEMKXHl9/ljhq70CO1DYKJxhFkQ2pnvl+rOloeEs9xddYJQjuFGRcDoO+0
         nGubxRlAlwatnCDFsGP3bzyL8JXlxwKeH0QLC99Y9x/36fUItIIiIJ6/WBoFRxGgm6BV
         61LPJ3/mX+RKq8NI7Ab0Uy7EgGo4HBYUMGcFpVWVpK2xBpU0BF3MWrvTy9hbRd9uiCb8
         6z7Lh7moAcORNLIA7iaipcTF5n6pjvF95KvJ3kA86W04RGt/TzljZWlQE7a7AX1VURNc
         E3Tg==
X-Forwarded-Encrypted: i=1; AKwUvByokcJx0l9LFVa4C0WzYug3ZKmeEwm378SyOt1VOq2n61xP/PcgRmv6tJAgA0C2LXfHRuPDYgw=@vger.kernel.org
X-Gm-Message-State: AFuF++lQeE4jx1tAoMu8GKvRTMt57fkrE+pIpE11beRkICWvNWwLQMgS
	zwzPHAB92BxRq0uHvq/pNQtpamBo48t+jslvIls+QLxXhRoDtWlJMjlz
X-Gm-Gg: AYBFou2ksTCJzMFMna/YlAuES4xtcAVw2JCqDWqoM/AIBySL2Qka1hbYL4qdqFYgNrl
	YWqGtAqZ/7J3js8D8ZjyG0GMo+k2wTFJh7oQrXdz7Z6t26iHHOfrxB84d8p9MFUx5wprkR3BAGd
	D05B+brklqCuKFcPn8VA2pb0AXE1YpKUP+nxe/odTC4CmZzDOWaTQHEbip6OVxtILHqHmPFd6qe
	HPS9GdeuyweAuJYRLX+Eo0k3IcRaPQlJz364wcR37gcj3vya4Vo7WfqTD7H/xtmAqfzOSe0m2qn
	4jopiSKnqMNoPvmUUIHJsMvpv8gSTZPDGcvErkJ8H3stH1KVKo0DXZ9uXQ9/MIZ0BV+LoWKU9Er
	ghMIGQQF3bQE8mdgMUWHJbu81G48I7QAwuhLA+XqhcnAg1yukvS3t7R8oPTEi1SERITUQNx+cQW
	iIKH6dS6/w638XnaHFgjLPNy+QdyqdLW7h+zum7Ro2AUv7pLx/ndAGNGjyy5qY9DpNpm/FSXf9v
	NKZEh8uHm32g5F+77/MiQOvGQMFtA==
X-Received: by 2002:a17:90b:4fc7:b0:37f:e5b1:ec4b with SMTP id 98e67ed59e1d1-398da5e8fa5mr9325730a91.5.1788195691825;
        Mon, 31 Aug 2026 10:01:31 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm34437702eec.29.2026.08.31.10.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 10:01:30 -0700 (PDT)
Message-ID: <bbf4711c-f12c-42d8-95f7-0f21df214b71@gmail.com>
Date: Mon, 31 Aug 2026 10:01:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/43] 5.10.269-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260831133358.571886287@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260831133358.571886287@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/2026 6:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.269 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.269-rc1.gz
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

