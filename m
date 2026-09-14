Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A849B5BB
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408902; cv=none; b=SgC5snnupsY+/Ml85pdGf6lQn40eDBkY2vBYdjDbpFbAholeS6g0mc5bUcoYVWXcqFlfkGNjubkN+LNXlWFAmE9SIZhm8isJKQD4wt9bhpUYo8UHpC0fxKIwM2I109EBpQp0eQKXp0oVv3y615/O9/yhplx6n9vK2UxNLrzrXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408902; c=relaxed/simple;
	bh=9ZswKmHYV3hQPdJPCFwuJCVbZNz9gP0vODDqdoni8oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OP4Kl4oyFYVd7wxwoG4W8WJ+iRmOSA1F7+zP1/5s+3+rrgs1SE8n6V/os17EHEhHLbiPF9TWlE5kzwU/453iOkOK32TYAZFehPMoU+JntUc0lE4drd0RDU5sx64mJ8wEDSPQ9wrrh4LCHcP0qtYVPs8As4KF53DLM9BxHdIpaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px56acUZ; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px56acUZ"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6714af30a2cso1411567d50.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789408899; x=1790013699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMesPQp0VJUensHvMGRs3/WPWJMCG93L+QYn2rj5VFk=;
        b=Px56acUZCbPA6UDQkcUrKzZxSq6bxbmfwSSxGxhck2yO+iAkzFqwKBQbPzERKVKhRG
         zs3U8JJpP1AkyIUBBwQUc7faxf3L/g55sKsz3708EQNvBPlNOKrguCf5IZWJ7WQjZ74Y
         OKnNlggXzu8lsDHBll9IbWT4AQvS/Re/zi67TYPj1s9d93kpxd6P1LcyplCtEuheBHP5
         LyItl8IadZT9MPUHAcarfztJ995H/wCvO7iyCFnNq+aNpfCmO0Pl4NoovlG247jz9bTr
         qdaOgPwdEHKlPAqIfRA7cv8IiJr5G40IXr4DZ+oT8TsF78Dpft+qkPIwFcx9a4go3gME
         5dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789408899; x=1790013699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMesPQp0VJUensHvMGRs3/WPWJMCG93L+QYn2rj5VFk=;
        b=dSTMjlUzNlVuTn04XLl4QW4Lg0I9ixaEINbD6xibMIjWsOPoFRtAaInurpN2ACc6NN
         q/MlyaxL7+ythZpLvjfPytKEiMNkZ5jbNoUi1E0ROoXCfBcEQJOaI6yvHgqi3YPGfTOE
         8zxGSbpQRQ8S9fM+DUhW2pDibDfw8VDiqZo+JezhB0r396WfQHIJZ9xu7geDkDX/LJJz
         KLv/qhKSD0VwVkfpPcLNjLatQTy12eVHjNJXAnmHl6TudXEUAcIYRqCAVxg7plWxhCP8
         52eue1QAQl872WPbhmO+oKZ7jmEMCGRwdmq5nUegemSVExSZVo90SiJJMxSd82VEDNbh
         Nzrg==
X-Forwarded-Encrypted: i=1; AKwUvBzDz3Syr3zp8N/Os2CbKdWkE3sIA83ysZKsxLwlDBM8JPGmWQf8gVAWG6tTBKD9u9rLA9QHZS8=@vger.kernel.org
X-Gm-Message-State: AFuF++mWyNmzdqGlEePxet+Ir5FxmQQwMo5fzT3q9WoSqtrzeODT9/aA
	u9CivKLXC2TYCDiDdsDg8svD7hdBw0iprnJdakpiVoZfWVjwC5o1He2n6oeF+Q==
X-Gm-Gg: AYBFou0JGwCAMX9q5JUM4oUeTQC1FpQKrjqDIEFGDzu7hGBjnTBbZAwR6nPLLk46kF+
	DYaDzwXSmXELmNAJRyq37D778kAvAQCwt0mIAsGfvgSiG7esaxircnTPPomfQ9xbjn/BcLPVsho
	a0kl30cAArnVcKDAciSUQApONW3oiFe7Zm4FFe6XbOiybIddzvLiD63OaYi1KHLbHofE6q08YnK
	dCH2FvXUtE62CpI1Zemx7wayXs/QFbGBC3CP3EoWE8Z67uomDHWr2ov1FqMm5WNCQkhgxBenfPD
	W/zs0BOtwdazfxxR3At54owA6NUqt8g99zwpCOWGZ6ekdLWJLRYCARzCxhjQGokc5WMOuHhFD1k
	muqDl6SYRwY0afI43JNadTWWMIo8VUg7krs53L9XYrscD9UYR3i+h7J+D/ns+GBfWpyOsXA5mQP
	EmLomqUNfk7g0xO8Q6stHd+2Tt6XtcKY33JQbLvFG6xATEDeHO7PmwGV+p/ckRwuSNFat/Gy8GN
	xyz5A7P2TrHLPthYLQPao9UMw==
X-Received: by 2002:a05:6214:4993:b0:912:122d:174 with SMTP id 6a1803df08f44-9122e691c88mr56601806d6.34.1789408874114;
        Mon, 14 Sep 2026 11:01:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47a6ebsm100587596d6.22.2026.09.14.11.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 11:01:13 -0700 (PDT)
Message-ID: <c293d5c7-ee3b-4fe4-af58-f232c8b9efbc@gmail.com>
Date: Mon, 14 Sep 2026 11:01:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0000/1376] 6.12.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260912065607.535295758@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260912065607.535295758@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 23:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.110 release.
> There are 1376 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 14 Sep 2026 06:54:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.110-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build on arm/arm64/mips:

   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/symbol.o
In file included from ../include/linux/build_bug.h:5,
                  from ../include/linux/bits.h:22,
                  from ../include/linux/bitops.h:14,
                  from util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c:12:
util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c: In function 
'hisi_ptt_4dw_print_dw0':
util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h:28:41: warning: implicit 
declaration of function 'GENMASK_U32'; did you mean 'GENMASK_ULL'? 
[-Wimplicit-function-declaration]
    28 | #define HISI_PTT_HEAD0_4DW_FORMAT       GENMASK_U32(31, 30)
       |                                         ^~~~~~~~~~~
../include/linux/compiler.h:17:23: note: in definition of macro 
'__compiletime_assert'
    17 |                 if (!(condition)) 
         \
       |                       ^~~~~~~~~
../include/linux/compiler.h:37:9: note: in expansion of macro 
'_compiletime_assert'
    37 |         _compiletime_assert(condition, msg, 
__compiletime_assert_, __COUNTER__)
       |         ^~~~~~~~~~~~~~~~~~~

-- 
Florian
