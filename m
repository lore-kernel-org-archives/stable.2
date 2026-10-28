Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222774;
	b=EMtc2UBuV7kZCVWEntaaF6N1pgdX2YTORH1fPfeGE2btbYiswLPzPZ37kNVZs4qbIC24
	 +Lf6UcikWTumKX9sHGY3zaqNZN23S1nfVrenfYXYsnDF22ru1h6az34oSFxVxSAcAu033
	 yvwE8O8fzAZQOaIMJvB0jNbJbsBsE1Zw23vQMJ4KLgqlCaqenDgz088Dafykp7nn1fw5j
	 ImLVrZRHJgBSTXC3sxFfv4D7f9oCPzNjjCEG4JvKghOVOdwhhXl3ohmIBIHf8bgq5fJaq
	 /qHq2fTIVx+U920W0xgFUn7x+Kspl2Sd5TeFNExvUvG1LEJrC9xM0D42BmGyQ00/Lpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6gvvAaf5oqzPrIz/4nEh4l4rMyZ25yG9p051XezDf08=;
	b=DZ/PHsvsTaynXjFRIiioWumt4dLtOgnOlVc0NLGPfc50Pli3MlN1JdfOb/yOgnqmmx9t
	 JlPaudgsKAW98/igLkKBzUJryTIodt5L/15wV6nhhS4DlN8v8zeitUUEUfTfdYrhT2wL/
	 V7K0O2ZtCfJK2l4zTEejvvUV2EvI172fiw8AgEM4/LtGXK9D0y+95TflXkQ/NIN97RDP4
	 Gf8DCO/ajYGBvPjz5x3pBDNTlASKxPA5QC+tm6CfcdMa9GJ7ocuJm7Y3sJx0S7sOZxP37
	 sk/oyGtqFC2r3PW0HjlnmMPlHsrVvofp/ZJr/MOAgEGbh7KHEHF70n0+tD+zsM4yIZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QD9yN87U;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDB606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FCDB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QD9yN87U
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-14394530ec6so1700659c88.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793222773; x=1793827573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6gvvAaf5oqzPrIz/4nEh4l4rMyZ25yG9p051XezDf08=;
        b=QD9yN87Uh1J0d6iiUIj1W6WctIebIfGNxt7h9QYUIeawwYdz7ichnWcdtO//xOQ1v6
         O+EUX13ENy5pr4wT16aHkRYAJ8eNwYbD1dbMhfegvAuJKb3lTHfMFeRr18Uw3k2eNyLW
         9eo2FmtbRlFH+4RUAsVFYtsl1VJzdqiww4rD+cnQhAs7lw8NYR7WO8zFIgn3mnJh1Z7Y
         d8Eamf2elVNEahnBgktHdT7BzWpx+YQ2PkhCQZ54ks9gi5sL14hyK7Y4dN+bbhS/+XW7
         bQWJAeetcd9ZCv9t8EujP7eCRhN83M0dUeJ+oRNF0P1+ZBG8/OIS67HRYQwDLzZZgbZy
         Eg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222773; x=1793827573;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gvvAaf5oqzPrIz/4nEh4l4rMyZ25yG9p051XezDf08=;
        b=AJCyRe6zDuvnubgPUPwMUmcwuoj2OJIlIVkh8Og+usr/LBYEAR3Cs5ZA1Gd1sP3IS0
         7TBVB5h2g2Yyn+1P6VeGnXGcr3ZGrWl4wlhU7mduMTTejdJl+ZvgoQyZz81XCYLHuurZ
         sHZwGOgxrZxNTWdGRSImajMdoK42bBRfMj8XwwRyXvJiYdkcm3jxCSvYvjXPvvATkFK7
         pEeBiflUOyVLyraQEALwrg5En8wUsD0H6I84z01sRib+F2b4jmBb2iw+e5Q9og69BcKv
         +PFHDziii7lUoLRpPHHxvBw+qMfAZGDZPSOurWGpx7v9BrgNXbHMuLeIgKZgQx8VaNYC
         rO3w==
X-Forwarded-Encrypted: i=1; AKwUvBxeYUp2UoFQbuCX4juaS5W8X6FmdeImnC13J6WwtmrfbEZ6cOl9YQDQ9pO10kW1VYsn4pp/qwo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJT2vSaYQ2E2pGlwyJlJ5NOKe0QhV80bYPioIQljXB/UHFM/Se3
	MRin0kbsJm85ZVanUBkk7X1/+sYe0582reNdPRo4sK85I/c90vxSKOod
X-Gm-Gg: AYBFou3/tT55xnmLVUn0vMODkfjdu4hokmepiZdXE5KRxEPDVUyQJkNWFq2oo78TX/O
	h11rhx7IeoKZxpySxwRcRKPykpM5uRdjSE0eyjl8SyUuPbhNBj3/2lXK9FXZ17rD8JQo1E5CUGT
	S0GdW++7maZix72fRqFpbrKrjrEG6XqyX/fCHG049WGqsSdMYe0pyFbclK9gdxqIruNwtbYfEki
	kJ/mKYvQEMTxKYqHDWzajbBa5tnhIMqkGQnqGxmdV2ta0V8omSIv0+e9o2hXpaziXvD59n9gHkw
	KGVozB53t3ziamNeODAYd7t4JJPFs2s91frCHPqgXNEIhTTvuQeZwFVZdqigviIgzE5hHxkBdWV
	Tf1AvtQWOpphC7BQ3Xr9NgTA6ibE/DWE7HHodICrpNCbS7sF4vnwZZfsYODgI8i/Me2jME1Yo98
	WAhSPj4DXkiySPB0tqvnxr/iWr03oT+PcegekRKfQWN2EmIyYadsUdcZUAkHUrZ45ZMgO1yyZHh
	TeoOoYM+XuSj33eqvRwWlC/iCG6+E4qkLMQnhg/V11bLNFPQm3WioOWDUyQyt0KKud4zMgK09A4
	LXa8wuqNpgSlBNmiGT00+Qiim+oHr52K4/7eZK1wpMxhx32n149ek+SN
X-Received: by 2002:a05:701b:42d1:10b0:1a2:6b9f:f7e1 with SMTP id a92af1059eb24-1a6ced8ff72mr4944038c88.14.1793222772917;
        Wed, 28 Oct 2026 14:26:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm8109314c88.10.2026.10.28.14.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:26:12 -0700 (PDT)
Message-ID: <d989cca6-f049-4c87-bacf-8a6a4832dfbd@gmail.com>
Date: Wed, 28 Oct 2026 14:26:10 -0700
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
Subject: Re: [PATCH 6.1 0000/1887] 6.1.191-rc1 review
From: Florian Fainelli <f.fainelli@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261028170459.200466217@linuxfoundation.org>
 <f09f94df-c5e7-45d5-86a6-50be145f6655@gmail.com>
Content-Language: en-US, fr-FR
In-Reply-To: <f09f94df-c5e7-45d5-86a6-50be145f6655@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/28/26 14:12, Florian Fainelli wrote:
> On 10/28/26 09:34, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.1.191 release.
>> There are 1887 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 30 Oct 2026 17:02:34 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/ 
>> patch-6.1.191-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable- 
>> rc.git linux-6.1.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> The ARM 32-bit kernel fails to build with:
> 
> In file included from arch/arm/probes/uprobes/core.c:9:
> ./include/linux/highmem.h: In function 'memcpy_from_folio':
> ./include/linux/highmem.h:427:21: error: implicit declaration of 
> function 'folio_test_highmem'; did you mean 'folio_test_hugetlb'? [- 
> Werror=implicit-function-declaration]
>    427 |                 if (folio_test_highmem(folio) &&
>        |                     ^~~~~~~~~~~~~~~~~~
>        |                     folio_test_hugetlb
> cc1: some warnings being treated as errors
> host-make[6]: *** [scripts/Makefile.build:250: arch/arm/probes/uprobes/ 
> core.o] Error 1
> host-make[5]: *** [scripts/Makefile.build:503: arch/arm/probes/uprobes] 
> Error 2
> host-make[5]: *** Waiting for unfinished jobs....
>    AS      arch/arm/lib/csumpartial.o
>    CC      lib/math/lcm.o
>    CC      drivers/video/console/dummycon.o
>    CC      sound/core/control.o
> host-make[4]: *** [scripts/Makefile.build:503: arch/arm/probes] Error 2
> host-make[4]: *** Waiting for unfinished jobs...
> 
> this is due to 341d4e6294d9 ("highmem: add memcpy_to_folio() and 
> memcpy_from_folio()"). We would need to also back port 00cdf76012ab 
> ("("mm: add memcpy_from_file_folio()")

And there is this other build failure caused by 997f9c35fcad 
("Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete")

net/bluetooth/mgmt.c: In function 'set_mesh_sync':
net/bluetooth/mgmt.c:2188:36: error: implicit declaration of function 
'__struct_size'; did you mean 'struct_size'? 
[-Werror=implicit-function-declaration]
  2188 |         memcpy(cp, cmd->param, min(__struct_size(cp), len));
       |                                    ^~~~~~~~~~~~~
./include/linux/minmax.h:92:27: note: in definition of macro 
'__careful_cmp_once'
    92 |         __auto_type ux = (x); __auto_type uy = (y);     \
       |                           ^
./include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
   105 | #define min(x, y)       __careful_cmp(min, x, y)
       |                         ^~~~~~~~~~~~~
net/bluetooth/mgmt.c:2188:32: note: in expansion of macro 'min'
  2188 |         memcpy(cp, cmd->param, min(__struct_size(cp), len));
       |                                ^~~
In file included from <command-line>:
././include/linux/compiler_types.h:387:45: error: call to 
'__compiletime_assert_741' declared with attribute error: 
min(__struct_size(cp), len) signedness error
   387 |         _compiletime_assert(condition, msg, 
__compiletime_assert_, __COUNTER__)
       |                                             ^
././include/linux/compiler_types.h:368:25: note: in definition of macro 
'__compiletime_assert'
   368 |                         prefix ## suffix(); 
         \
       |                         ^~~~~~
././include/linux/compiler_types.h:387:9: note: in expansion of macro 
'_compiletime_assert'
   387 |         _compiletime_assert(condition, msg, 
__compiletime_assert_, __COUNTER__)
       |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 
'compiletime_assert'
    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), 
msg)
       |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:93:9: note: in expansion of macro 
'BUILD_BUG_ON_MSG'
    93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
       |         ^~~~~~~~~~~~~~~~
./include/linux/minmax.h:98:9: note: in expansion of macro 
'__careful_cmp_once'
    98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), 
__UNIQUE_ID(y_))
       |         ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
   105 | #define min(x, y)       __careful_cmp(min, x, y)
       |                         ^~~~~~~~~~~~~
net/bluetooth/mgmt.c:2188:32: note: in expansion of macro 'min'
  2188 |         memcpy(cp, cmd->param, min(__struct_size(cp), len));
       |                                ^~~
cc1: some warnings being treated as errors


We would need to back port 26dd68d293fd but this does not apply cleanly.
-- 
Florian
