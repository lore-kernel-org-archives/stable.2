Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031373;
	b=h/GAiOdOF0PJcLYk1eeX6tT+HlUiCPHLyjxya13myabsWgQSiAfvO1F9ElvzXQWviDa3
	 Rfs9kwnIsfH8SoVeT/9G87gLGpu1VVPc/Vfm6/zSDYSQZdyieLHS/aRpq9SLqkyVmS/ur
	 yVTFLy4Eogi1MNADPvCt0Nczht3r3PdMXmGTSPa3ei3E/+GURq30pnrhhufDgkMs+ZLLp
	 FAhallmvCmhFDBXIV6mZcZz95EeO48OuzUnERSeiOxEnFrxhCCSmMFWpEQ4OZM5/lCtBP
	 D107Idp/HfJl/Nhbq+fQg2iqPE9geClXht8gSCT66BZF1u2Cw1zbOV4JqJe6RD1klqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5z9WeWVp8pZ7m8YhqVv0OCEHCS96QI2xcezf4P1GqsI=;
	b=rbZX+4Xxf9N5sKMhekfirX+RQp72VrUKP/WkbhUS6YE77AFW1UKt+qdYnn/6wbHWVWFE
	 rI1SUh2Zuux5ZDvNmFOPvYJwjJuZolwYSkknvFwtOka6c2B1r48NqGcn2RfZ4XAzBU44C
	 lzISv6NDl8d9qjEhMtpilAB6dBt0ecpmqj4gW0Jd3VIegWur8IzWxcd9NOicG34QMklLq
	 hthoQl6PkfkvT5IVIhFNq7MDfHg91PH/vAN1LoJsZ4A3Ig0R7h4tFJU3kEQJ0Ff7b8Ju4
	 vr3IKVTSdhbFSRN+b7DhH9D6p52ANhBymbCLO4rHHDy2kbFzH4hr+M5fe1Qw7EfmzJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="gr/DORDf";
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045D606A338
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D045D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gr/DORDf
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-94965745d92so153917985a.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031372; x=1795636172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5z9WeWVp8pZ7m8YhqVv0OCEHCS96QI2xcezf4P1GqsI=;
        b=gr/DORDfy0XS8kEJrTf+/wCUcScq1jhMGVH1YAJj1dTNSzy0TIo1YZm0SMksJBwIrY
         wdScUS1DxnTUCWbuIat7otDfODUsNSne0VajYQIBSlfh0ehkTtF3dHqWgqifR48yMesc
         E6A00xwwOVooEQTbx6KuHkO/Mriw6Axb4gFu4p8jFMEd2QjEW9jV430z7Tcz4SMnmKrq
         72txddK3D9XEH5cZIJHYhvOI9iJ9qbKIf9oMhKdj5LfLcKVSsX0ltHTTkylrJpzaGcZ6
         ahgzaaVsgjRnRLvfI2bRKSF62ZsfFlimUCUoD+sJ6VMrqfw+uewaOJNQUjBqSGTq1JyQ
         8nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031372; x=1795636172;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5z9WeWVp8pZ7m8YhqVv0OCEHCS96QI2xcezf4P1GqsI=;
        b=Y3bqJDs1Tx0DeoesmvH2u5iFIOvfCcO/Lm6A78+Wk2L17s63KdDVpwtM0vZRtjyIBr
         wL92fdzxbnPK1ikQ1UwxlP+plSc3DepwhRUyy47tQlBqFCRLbiqsYGPNtZs9PcLdshwH
         +51pWCofZv9OTI5aI8uRgGqE2UmiHw/NBZZXZBLho3V+h8zTXr9jEUHeMBT5VshOK7iC
         hhJl4CR00Iv/qTlsdav+yKV/mSFnxe9fMKq/Xh8WakRG1EX2ZE5p4mOKvdx5sxM0EAeG
         NJz3/o6HBz37But1KSgkmXYp0LD4bdOOAmXL2inShPBMSK8v2926sDN/La/t+J/Y+HF2
         T1ww==
X-Forwarded-Encrypted: i=1; AL+hErGV3tZLzjtkix+E3tCGXK7BVDPi48EJbBJZS4qslTDigbiq27+YH8GXrz7T76BbA2LA8JD2NAU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Wrfxq0S6cMUXKY3v/ghpruB2regFEWrmMLJvhWuOXQNmd0fZv
	/lSBhI/8gDIMeDNnn9JrcfLftmJmppkY5MnD4OggN23Dv4Bv997AGfP+
X-Gm-Gg: AYBFou3iIJYuFWCGI1tYXIjZYoeTaKrVsVc4+rsQvScJridvTJXk5ZmPoCMskCSD5ti
	obkqXIv0SCUd1PJ5nHRkk+bJxlCiDetAM+I6Mn9ficmyUFHpnmEmXUkvUY4ydQnGsL1X92GFJaq
	tOg55hGi+hWXP082NTQZGn2L0WXHRxYWGHLYsSHWuNtpfyWZW4tkjOX/YJw3oE/4KXd8K0bm0c2
	2Es5R9cIR8I2HvGfC4s7J+tzE7TXBmJTanWcFiPKSOEod8cRMPyp9/Zlb4aGH0+oYMEvMIh4Nwu
	MfyCL4qc76MfTtZENtVhGDij1YYNGfgJOsLp8bgsi5l83gFNonLi0O075tuQ0ZRp+4qpQQ3pOBJ
	lf4qb/ceo50ytx4hkp6c8/tILs3bWHbU9c6ORztJtbP8GCKUOYKhzGhReSJhQFtVxyzoowShi75
	cOdVgwcACDBDEj3h73ZS+vE09X8Lf/ENM7+KlwwCg/F9YJRFbO1caR2CPOHdOS7FyEGVeBmVkdF
	IuyXozumAhyW2lXSQNrTVQzMIyK8VX+75/JRg8RGeriTiVqUZhqSlKFS5mcAfNN7k5BNuNmIyIk
	NsNM/p7nRf5JgKpu+xxaMxBsHWWLBKCOBuJK2iy6YdG7cNoTMe5YQBFOFe+luE7cIA5sH2XIcc3
	6pw==
X-Received: by 2002:a05:620a:272a:b0:949:7bb1:ac5d with SMTP id af79cd13be357-949995a8346mr658000885a.38.1795031371742;
        Wed, 18 Nov 2026 11:49:31 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b743a8bsm257359285a.17.2026.11.18.11.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 11:49:31 -0800 (PST)
Message-ID: <30d88b7b-7a34-4fad-9ffe-84f2d8a927e5@gmail.com>
Date: Wed, 18 Nov 2026 11:49:28 -0800
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
Subject: Re: [PATCH 6.12 0000/1756] 6.12.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261118150007.957976754@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261118150007.957976754@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 06:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.119 release.
> There are 1756 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

util/annotate-data.c: In function 'global_var__collect':
util/annotate-data.c:731:30: warning: implicit declaration of function 
'die_get_type_die'; did you mean 'die_get_typename'? 
[-Wimplicit-function-declaration]
   731 |                         if (!die_get_type_die(dwarf, 
pos->die_off, pos->die_tag,
       |                              ^~~~~~~~~~~~~~~~
       |                              die_get_typename
util/annotate-data.c:731:71: error: 'struct die_var_type' has no member 
named 'die_tag'
   731 |                         if (!die_get_type_die(dwarf, 
pos->die_off, pos->die_tag,
       | 
       ^~
util/annotate-data.c:732:50: error: 'struct die_var_type' has no member 
named 'from_alt'
   732 |                                               pos->from_alt, 
&type_die))
       |                                                  ^~
util/annotate-data.c:743:44: error: 'struct die_var_type' has no member 
named 'from_alt'
   743 |                                         pos->from_alt);
       |                                            ^~
util/annotate-data.c: In function 'get_global_var_type':
util/annotate-data.c:801:26: warning: implicit declaration of function 
'die_same_file' [-Wimplicit-function-declaration]
   801 |                         !die_same_file(cu_die, type_die));
       |                          ^~~~~~~~~~~~~
util/annotate-data.c: In function 'update_var_state':
util/annotate-data.c:839:42: error: 'struct die_var_type' has no member 
named 'die_tag'
   839 |                                       var->die_tag, 
var->from_alt, &mem_die))
       |                                          ^~
util/annotate-data.c:839:56: error: 'struct die_var_type' has no member 
named 'from_alt'
   839 |                                       var->die_tag, 
var->from_alt, &mem_die))
       |                                                        ^~
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:105: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/annotate-data.o] 
Error 1
make[6]: *** Waiting for unfinished jobs....
-- 
Florian
