Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233548;
	b=DUig8uY5BU7+R33/1YC90nqZGeymqUBK8diV+zrs6Q+/y8I1IIFsXkCtQyVMs9hTLr6F
	 /lmDDz8f7iuNDRq28hysATL3z8lJ4+vsmq6lH65G3nLBSKJ4aPGkXEmJBZt7XgUdUjDcI
	 hYHTtJ7sqHvudOI4AYxMJwhMTmCY7Oi4XAA2MNsfz9yAsv6mv0OgO0jZ9Cwx14YYrK7y3
	 X1FM48rLk7pF3gjg7ja7Ds+i6p2BFpWChmqF3KvJ0uLyUeWDYUgzeAmabtaJ2Gdy6Zn+w
	 HUOxZe7DinFi0ILSvP13XSVHoPn8Y5zZi8FBU30XyQsNXfMjwXLvK/1XXCqbYQt3OmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/jZ0or5mPuMmlK3Yd/rWF09QUTFe+FBPEVbKQ0lAhZk=;
	b=BuFgrNfgFHZQqu+HMHcTD3LjJB1H9PYS/rns9bMtJgZtlh+fgHpqeERH4nVYu80x/bzV
	 r7DoCT1guPZSU/DoSj4YaEJoug3/yhw06efFbPIqCgrttQssO0kDDwadKBpS9RvmEbUFI
	 vxC4Jhst9zNntSrdDeg3anYov8zc5LaUVMHz5n3YKZOW8vJNeO1uGKS/zHckK07hhximz
	 1Grl1MfPGs28543eP0wX1WPIolhQPxQfOzMrIy3T3ehlK00ekpq4gR27T8NG6La73vq+4
	 YL9Koe3PXGoDfCG6+DCkteqXp42zfDeiD4OrUMeJKHPnLc4XjD3LDdVjcYVCuEn/o0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=O3DjAwXv;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79462606A325
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79462606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=O3DjAwXv
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so12755625e9.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793233547; x=1793838347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/jZ0or5mPuMmlK3Yd/rWF09QUTFe+FBPEVbKQ0lAhZk=;
        b=O3DjAwXvcmfr5kDYFnc/K/mxGrf8eceZg7mSTbfJyZidNOSerC1PBaqSrnEOjMtuJm
         +8+Og/+ZSKxUpclDaY1QPS3enX/prf+R2uSdPWdZRBXfjVLjOfinhjmdpWiAsGk4YrSp
         z1viV4MXRkXqoxWbd9n/3s52flD0t+kvLgMrUZr0GpV768drO+GT5GtXKLF/dvZ2Opb6
         +5BfqtWJvmmRN0oV9YVrn489nxzecTs/tgFRjt2fCRSIYy7OwIYcnPwJ2HN2+eS4jQeq
         BjfqmNaoAEVUAc2TTmYHO3gfhNh89/abpHWzK6avJyNQpZmW19jUgoaRI+8o0WeSfrTj
         DbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233547; x=1793838347;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jZ0or5mPuMmlK3Yd/rWF09QUTFe+FBPEVbKQ0lAhZk=;
        b=QTFsIcsmR0hHesG9rN5XWFErHqWmkHJfgT3mHTWFpmf40nMnXMpL33vyx8XD+kyEsN
         +DeglkBDQ7Hvd1ff4Y+xoHAaGNSNOUuXGjxJPSTzKYTiiU3QA0L30ObBT2CoIdFAG7bk
         WjC3qbx73kJkN1TQZjz0V8ZOgmMlGZwNxeaKjVueCTwr0tGtz3n5CbAgq6EiN7uSlksh
         mlq/zRAatrWOVJShG5kBHI9qIx7kX0g1excE8H3cklY7LF7XEl62A51qoicPT2t7cb4r
         py3fSNPtz/ByUk9L/hF1y1BR/QE4P6tWHL6ekCmW+BcsdGwGacGo+l20MwBtGHp/o4YS
         SMLg==
X-Gm-Message-State: AFq9FYIcPfYzMarfno0aFoo3gL2bQ6xb8XKowvLMP2+8SoiMHMlLDmMj
	meIejU2aWUeT+grXKz6/1LbK/nYipmTkfgZpIHsix+fHLd1HBEcSK9g=
X-Gm-Gg: AYBFou1NRi+jJmkML1X/65yXjvMtA0NtTasJa2TqHwSbCKZzeX1AduvN4yPByGvwtIQ
	wukkcrqRSxB99tJM4XMkI/lsk+cqKGPExQUiNp0REPEp2kZUU9TRsuy1F8qlTMnckkQZUNKhvsr
	lExhM9NnSe3JacHPr7GZYtWarePniw8kM3+V2+4IGJcwL4nL2C+giAGdc8VHPKk+UzwENIyn63A
	m9FIGOJraP2Qu+TOU69Le1sXSgYO3UGQBI3Atj1SQuY2aEisO63OnkGI9VdH66TyrJMpDeUzhvS
	aD8D2odWpN0nKj53BrB+3AOyCr2CxiAIiQbKkP0pNYDs3+fZcaYu5qzkDwD/Fhb/Qfbc9ZSy9F+
	QGEOiu4dtl1xQw++BHSu4JX3MheVedoLp/lDWJ5Mw9DMwN5yaGcEemhvk9f/nGdevp4TWIM3Tw+
	KUb22b6PQTMa7DiJa9YtTLs9744zBAkaHGh6wRN8PE29x0PeUsT7OJOUCb9Wdj9phl7Zqs2PesR
	BklvWWZM4jXDXuZBzOz+WPCXC3dpR0SZC0lqPb4HNcU9HR8cfJJrauaF83bcQEju1cxtj7ON43B
	O28v+wc4UjSCyoRfyl+pCubrhwVUzUaphDogAq3ss33ZZ05ZR9t/IWLwe7HiDau/lJHF3lWSvUS
	pqk4TDaY=
X-Received: by 2002:a05:600c:1987:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4a9656224e0mr93824485e9.4.1793233546791;
        Wed, 28 Oct 2026 17:25:46 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd9f.dip0.t-ipconnect.de. [91.42.205.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7c1302f6sm29180125e9.0.2026.10.28.17.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 17:25:46 -0700 (PDT)
Message-ID: <3965e950-1e5c-4b52-82f0-9fe92806654f@googlemail.com>
Date: Thu, 29 Oct 2026 01:25:45 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 0000/1887] 6.1.191-rc1 review
Content-Language: de-DE
To: Brett A C Sheffield <bacs@librecast.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261028170459.200466217@linuxfoundation.org>
 <auJTCcqMDEmAS7Q_@karahi.librecast.net>
 <auJem0IIOw9Ibiw-@karahi.librecast.net>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <auJem0IIOw9Ibiw-@karahi.librecast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.10.2026 um 21:44 schrieb Brett A C Sheffield:
> On 2026-10-28 20:54, Brett A C Sheffield wrote:
>> On 2026-10-28 17:34, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.1.191 release.
>>> There are 1887 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>
>> Build failure on amd64 with amdgpu:
>>
>>    CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn315.o
>>    CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn316.o
>>    CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn32.o
>>    LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
>>    AR      drivers/gpu/built-in.a
>>    AR      drivers/built-in.a
>> make: *** [Makefile:2040: .] Error 2
>>
>> No time to bisect just now but will try to have a look tomorrow.
> 
> Fortunately it was a build failure, so I just left that running:
> 
> git bisect start
> # status: waiting for both 'good' and 'bad' commits
> # bad: [adc8e434cf08c73b0f02dab2c15319315f07172f] Linux 6.12.115-rc1
> git bisect bad adc8e434cf08c73b0f02dab2c15319315f07172f
> # status: waiting for 'good' commit(s), 'bad' commit known
> # good: [85d82e0d7c2dfd3e75d34f35b7ebbf41f45c9c4e] Linux 6.12.114
> git bisect good 85d82e0d7c2dfd3e75d34f35b7ebbf41f45c9c4e
> # good: [0e1dbd1409918dbd331cd9c382ce64736dcf3272] ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMATION
> git bisect good 0e1dbd1409918dbd331cd9c382ce64736dcf3272
> # good: [617f27c3fa85742e9d468a2145e3676af6b2498d] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
> git bisect good 617f27c3fa85742e9d468a2145e3676af6b2498d
> # good: [1476a3a7d286ad7763025337f20bb841b24c72ea] io_uring: don't pass restart error codes to userspace
> git bisect good 1476a3a7d286ad7763025337f20bb841b24c72ea
> # good: [be00113e49ff42c2c007993dd05cf4bdd1c2bfeb] keys: Protect the type name while describing a key
> git bisect good be00113e49ff42c2c007993dd05cf4bdd1c2bfeb
> # good: [6270098a65994bdf26b736b2ad6614e5b9078ad6] coredump: hold RCU while releasing parked threads
> git bisect good 6270098a65994bdf26b736b2ad6614e5b9078ad6
> # good: [41af0a793777ede3f1839bcd8abae92a5c901fe4] fork: release the files of a failed fork after sched_cancel_fork()
> git bisect good 41af0a793777ede3f1839bcd8abae92a5c901fe4
> # good: [6da107042aaa43b05f4c16bee65afc2e9b5f7561] signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
> git bisect good 6da107042aaa43b05f4c16bee65afc2e9b5f7561
> # good: [da1419eb5d34caf39c1f3abad5b95a601a35114f] fanotify: Fix crash in fanotify_init(2)
> git bisect good da1419eb5d34caf39c1f3abad5b95a601a35114f
> # first 'bad' commit: [adc8e434cf08c73b0f02dab2c15319315f07172f] Linux 6.12.115-rc1


Brett, you are reporting against 6.1.191-rc1. Are you on the wrong branch?

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
