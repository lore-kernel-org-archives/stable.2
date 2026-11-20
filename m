Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215272;
	b=pARaABE/Qmh1dFIJxjER8kGCGkNMtfi2m9xwHmBpJ+8ExRyQ5c0qLdZG5RrnT8uSzWuw
	 thdTXaG8Ws0KnA3VM/J4gVvNiFVPINCXRBqP2K38DWGmtk54WdlMUAsThrzuY5Fx7iSCB
	 rA6mEDTyofqoVGSPZLNSwdEHhNK2pmOq2snY512jfjD0/iqliw4EToTw3pT0sdlYK+yCj
	 zjbdbQypElT9kfGqF+7cqdT2/WNECb+0wLxKKoAXHUJ6pEjnMXOU24Pyy0FIkH4uw7LcS
	 JSTW5/w1da78VRKoeIy1XSEAPtD7+txEHo/CymSnTmSqdushLNfqiuhhvsg8+IerPQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7skHt+YrMSf45fvtAQB9ncjgz8a/0hFVmjlyc9Hg1bM=;
	b=AHKP4ivznHcVKFuQGklOTG50YRA/JeyxUDncbvGh4VwQOLSjYX0apvqqBNgkmsRlc+yK
	 hbyF9nD/gmQ3r3VcE85FuSfUdI5M4CaDE3arI3gXS6xeG/Rnb0Wpxb9rC6W4PkGq3hFV7
	 kuypRXWUK+fAJBm6W3zkqrEWOuiMf6Xk6fwHURUPieeBUl5/yE6CPG03Hqc9LfdsdiEXP
	 OlEn8kokZvUhcemtHOZfwihnRl+weKncYYIR2vTGE/kuqgtvg/DItVY7Ojq2/VNYw7zes
	 OoOBJTrnjNNYhN4RG5PkdYrdOv01AehwLnEKCUIDwCsv1RxzKyg+HbgbmtDsdnylx5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQfEQYAV;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD77606A33E
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD77606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQfEQYAV
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-920fed989b2so13953396d6.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795215271; x=1795820071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7skHt+YrMSf45fvtAQB9ncjgz8a/0hFVmjlyc9Hg1bM=;
        b=pQfEQYAVizHq3JvKb9DB8VWw9uSH/fANEH1KW/m3A3LIoyu1onBDLSOD4wztMhuuRe
         etFjwA1hdWIvOBG17qD2E6fjBPhesxkNHr3h579SF0fTk3wLhZFZiIEGqcj8U9YIA5/h
         JzKz2/Lv3BthjXYCU9riurHLx92UvP9glA1/PzKtNCdigW+FEynj40YnAmMYidlitaD6
         BYVgLb7I+YwS3BxUWrPZl/5ruHRtjOu/pjy+0U2H4O30ri3tfAvx9Mf5QQYhVf9Ie3mM
         jNKlZw0VamZL8+syi83esvG9eqPa9J06z8BoIU8F3az5Z0WrxvzlS5kXwnAmGkYX2ovU
         kPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795215271; x=1795820071;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7skHt+YrMSf45fvtAQB9ncjgz8a/0hFVmjlyc9Hg1bM=;
        b=FI8/RscbtsaEo9NAelPsf2+YUk+7HB4AXFJy2el9PYh1I8OxuRtFFElPaJJKbLpwiD
         usywuLzUhD7kwPCvRJ0y9U4B+USP2tF8pLSsJX+/TRqBVcacxhsAG5v2R/6heuVgIL5V
         6LvGOsdJPzPoA2qUst/5XZWoWA9hotFL6xQTFJbF9EvnIarjG0hfwdidIDsJD6m9A/Zn
         uHv/o5l/kp5bRHCPh8/KR8t31zkEQseEcQqEX62WJl9m30Ia1txC2UmKMZ2x++CEQxi+
         lFmPg2UT4x7++M1o/9/GTvOS+jF2SFQE6LxabiwMOdS3m0l8GOO3bPxOCRJJ3D9UcpMV
         zi4A==
X-Forwarded-Encrypted: i=1; AL+hErGU9flBqvSbrsI+A5TJyX3N1jr5WY1CTtIoKizfK/PcaJ6YIXksbD9FBXeVI14ByeclloiMGzM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0Qj31HJHX4cuWxaVIgmxTFaA/yvGwvrlPi76oEgo3PGG+niad
	BY9iQElaKgCDkNjB2nDarNkk3HevWu+e5eW092ilCchqS92ZqWMPsUtI
X-Gm-Gg: AYBFou0DUNRzxJl5VtGTs+SNwbne1nRJpBYC+2eGFRGFKG6TeCzDaflnBQ6WJsL1Iaj
	nU6aK1lw2wQwOtKEQ+50wYji9GBTOt2KtSfulGlW2OrOkwgKDkSAgKztFTknQmJVImtYeWunLs2
	J3NwEHoUEN3qSEw26srninRuEVEB8I8KrcEaMS6WonPUHpHjQ0LbwTsyodc1zM1QIxsEfnjHEcA
	n74cINOaqwljdzwOaGQsiT7OsvxYTMceNe/BM4LEUkWGCQ5in2K/vEjBUHwoKq3DAXOevGxBl/a
	eBLpcWJCx/bDvH4EJ2s+KKsCHXJ7eA7ezWGSxukwHPbuTAxqXj5VQM5UBFCyUZFEKs3BGU0qEAP
	VKpXOmOzd0aP0uctcbGW9k38NHRCUmTFFNpF9Wl50DbRRd7bjrnG4dw4vtZzEPqCuSyIk5ZUF9N
	tEXvRY5/90YzWlqyPAXnriHh5qglud+X+7K4MUqUlHFOaPe6W2pVw0EuDjwiO2o5p+Lwws4Cddr
	b148nsAC+mdtUjyEpgg0MH2asYDqxAELx5gVNxiVNRLJUqrDMCVknPbrrmb+fLT3rCEtG3p1SiJ
	diYR9CXA77yTy+HwVfpyNJqApnWWdpkYlKGWBejWyqOSor+BWXnxKXAb
X-Received: by 2002:a05:620a:4627:b0:93e:90e0:d2e3 with SMTP id af79cd13be357-949bab0aba7mr751067285a.39.1795215270952;
        Fri, 20 Nov 2026 14:54:30 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f1ee7sm295566385a.28.2026.11.20.14.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 14:54:30 -0800 (PST)
Message-ID: <f47e9c53-c479-44c9-b5c1-b118873f8399@gmail.com>
Date: Fri, 20 Nov 2026 14:54:27 -0800
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
Subject: Re: [PATCH 6.18 0000/2144] 6.18.65-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261120055114.182757740@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261120055114.182757740@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 21:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.65-rc2.gz
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
