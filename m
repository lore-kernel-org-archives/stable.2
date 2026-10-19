Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431141;
	b=jTY7sW63WdOEpZek/8JTPP58rKA2jhvwM5xMKbtx9GB35gxvQ98IGB3mU4cUSLAeQxuo
	 1pNqakeg/194xrhT9YyptzpeGualC+YnCuva+Ox7VWPn8O7ACXY/sTtR3UpuySejOuVcw
	 KJl4E028B78Wb9K9MZTBgWxzwLeh4HxGL38TPM95lBqPMYYddNboLh5678QOHrvHHByI4
	 YztwN3eXjzdGNFdid3ZDkW6B6jhs2oo5DwvHuTPHDKr35HJb8ptzuG83IKWl7A5hnmyzK
	 M0NsHgKWa6VfzRCJjJUnlE5UIUQgz+BA5fc5423ql+oSAWMOpSf85obQtTuXDhPnxaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fH71wL26lccrp6A48zhvdYj1x6+Gqq4exVWEJZ0+OwE=;
	b=3ruisFRXnJMlwUS9oCUM+RHvYYnBukyNjqMkM6Mc2BBMv55acw04cGQH+qVfZyAOYzFR
	 qwnKECaAUlVl7dpjyjOYMJrBuqm4iwlh646up60WlSGItWzyvswm6aKjRNQCSYMQk723n
	 ZU6rvoPoLWtacblQ+b5oVDcvZmFxNwOpkWNtt+PSGArfH7b+uJJ8RUghnlV64qHcYwijW
	 onjc0aeGEThCOVGqIcbtcRVZL6ZUowbmzZowED24xWkVJPjO45Zmwi3TdHLRfTgW6sBVS
	 kYgqIUB6CMfu0wqFoebAOYscrT8x2IIRcYMibIFiIecNzDHPenmXRt7B9JVgw8o/ahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GReyJMAu;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F8606A319
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 943F8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GReyJMAu
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535a54bed9so3291677eec.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792431140; x=1793035940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fH71wL26lccrp6A48zhvdYj1x6+Gqq4exVWEJZ0+OwE=;
        b=GReyJMAuaQIYpGxxKPfJ8T99/W2QeBXzsPHCCky+QMavnviPf5a4T4bfTSBcy3ksjJ
         18w9PFibPqr2fyuub4EjXq8Sl3ku/pXf4ZWUCk/mH9D3kVF1le+BwJeKNgw0wXDLpQ0j
         3/M2zScaHu0s1+WElpdiRjFtRA/+iCy7v5BmlXGRbxCmSzqUGSA460hDrls0cel9V3L/
         5gD0qw59HwlawKRpXy9k5OBMJJmTNMV3AnYeuFd/lxSqk3aFNpdxTjny9J5npGomPAmX
         qUccLIlFpWLykv2rcr9e2dnF3+AcXul1fzfbwhKs7RCn3CO4RaR46RRFCSYSnjZmDlk+
         KrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431140; x=1793035940;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fH71wL26lccrp6A48zhvdYj1x6+Gqq4exVWEJZ0+OwE=;
        b=Ce5XoR6hgJG35Sd3h23q5MVxCsWdhNNAtvHIVXVHEFSYF/KqR4dXjuVx+xwAhpDqnt
         xv8TjlIati0Wt+hZzAtmV/4Ql8UrCuLweq1gJkcO2leK7M0zPYMQ6I+vbSMhmAmRvIjR
         IS4NeRqxn6cOkCCNq3LbiJCZoYSUuIZmrl/757K2YpgwR2MRUmbUunoqLOG4w9mIBWQ3
         4ib5tig37GcFVuhONvQlr/SwSnA75lIu8b7khwz0CJW6dsGQ8tWZ/dRFTmDev+rAZ84M
         Sx0enL7VQNCIktC9nSVpuZ+62y3TO8/1pkOLkQPDTWdmhl0r5kJVakXwBJoShSPLnM3Q
         OAXg==
X-Forwarded-Encrypted: i=1; AKwUvBwbLg8OlTrxZSzlh/D+aSZzJfSPJ84D9MvbSicTv1vqyaulTlCINUYcCybSc/AhXSoRERLArq0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnHzT4s41/sktAxknrziJ+bK30AXmkXLJGQ8SNrSkEEDsOPBEn
	awbWiyqkcgkhGHlK8d5mE1NfVXBi4x9yjHohpopR/Tiu24fmBwcRn0vd
X-Gm-Gg: AYBFou1h+pa1dM2j+Khje0XYLj0RSlR3Bb3HrBOuR7sYrC9dt2I5+sTjghCPCfQODRd
	MKV8PpI+CAAAfx0FSVSX0c48LjtnNdw3y6+DCuGagoM2H5MnC4lwn1vY0v8V6tJBKVjE8oKz7rb
	ecQBL73pk8w4muVm9CCOy67+iIw42mgsBzL45NyLFoHnueXmIq6agwvARbFPegQY53QTDPM9yFf
	il/fPtfDcdZqnEOKzMKUDUbA65y0jWMl5DYb3FhHrJi77MBiM0eYaJBDPXTq7h5w+zwqpUQB3dl
	TgcmDJisoxXlU+DVT2b7i/4pT0FV8AcPbdr7sWpCDsuDC8ePQd7q5xnvCButA3K15VBOdy/M+N/
	6XhY2FDXxfsCSThg+IeFFvFH7SVCdNlee3mUAh9oKBemgXLm1X3yEyZPViHDUJOvGnczvjM9emS
	LhDTfEfbo9c9o2pd/CD9MyVYyRKqAFjOneFMonBSD++8DAzT6qQXYKnQhIPXKADonMGjxzVGPOF
	noTaBDjfkERY4NZAMJq8+yUt3YaXw/myNzg9opvW2d1ELFsiZqzjiugxl+CjkZf4zo/XHphW4R7
	utgNcg==
X-Received: by 2002:a05:7300:e9c9:20b0:35e:a225:3ba6 with SMTP id 5a478bee46e88-361c9c78086mr12197480eec.13.1792431139584;
        Mon, 19 Oct 2026 10:32:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm56584669eec.28.2026.10.19.10.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 10:32:16 -0700 (PDT)
Message-ID: <c5bea60a-e2b2-4bdc-8b1c-9aa464c1c84f@gmail.com>
Date: Mon, 19 Oct 2026 10:32:12 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0000/1674] 6.6.160-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261017160431.119607952@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261017160431.119607952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 08:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.160 release.
> There are 1674 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 19 Oct 2026 16:02:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.160-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build on ARM and ARM64 with:

util/event.c: In function 'machine__resolve':
util/event.c:755:32: warning: implicit declaration of function 
'perf_env__get_cpu_topology'; did you mean 
'perf_env__read_cpu_topology_map'? [-Wimplicit-function-declaration]
   755 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
       |                                perf_env__read_cpu_topology_map
util/event.c:755:30: warning: assignment to 'struct cpu_topology_map *' 
from 'int' makes pointer from integer without a cast [-Wint-conversion]
   755 |                         topo = perf_env__get_cpu_topology(env, 
(struct perf_cpu){ al->cpu });
       |                              ^


/local/users/fainelli/buildroot/output/arm/host/bin/arm-linux-ld: 
warning: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/arch/perf-in.o: 
requires executable stack (because the .note.GNU-stack section is 
executable)
   LINK 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf
/local/stbopt_p/toolchains_303/stbgcc-12.4-2.0/bin/../lib/gcc/arm-unknown-linux-gnueabihf/12.4.0/../../../../arm-unknown-linux-gnueabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `machine__resolve':
(.text+0xdfeec): undefined reference to `perf_env__get_cpu_topology'
collect2: error: ld returned 1 exit status

And as reported, on BMIPS, we have this build error:

net/sunrpc/svc_xprt.c: In function 'svc_recv':
net/sunrpc/svc_xprt.c:873:1: error: label at end of compound statement
  out:
  ^~~
   AR      drivers/media/platform/renesas/rzg2l-cru/built-in.a
host-make[5]: *** [scripts/Makefile.build:243: net/sunrpc/svc_xprt.o] 
Error 1

-- 
Florian
