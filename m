Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710970;
	b=OBEy4d4xkN7I0wPufr+yD1sBiOXHxfVvzxksbW54YZc958cllo/1L74dnxW+0AOqvuNr
	 pveZVnGRwEFE5G1qJLOMHuYkaxuTNqKf+j4XmBEtW2yK6tRR8eFk9FLudLII0H3wSqbPE
	 qFIjNp+RJpK+TBp3ehJS14m3qEr3fDRcehKT11aGH+BLjKmQsQ7PbxXD4g6Auu1gvFOu4
	 KFJ92fCKaxoNnuE4TDuH3gDvRal1olJd7OqGwc8qH5y3BW0DNRuZ4yLEYISTKVB6VGxWQ
	 y9IcPfym84Xlud6eb58GCHajdW+swpG85ugMkOsLGOBl++PwRwC7OARqVzJN0WJj+ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/V/q6vN01qyM55wT6FtlhrNcKv+AqGvLCJ3sSHicCRM=;
	b=5SC51cwA4Bgft6CiyrFnNjVGayFvrlsra5Rmz5/9K0CmW6At9mVL/1pBG6+Ru5fQ75l/
	 mfnyLaqjEAUuVvRYVuKk/lhM+3nG4qkR3R9Eam5T8h5Jjt9XZ8Sfan/Mh6yWDfXCF6+gt
	 liHSWWE1f42vfLf7XfjQjqmI9zxuQzgNENEl0oxED8jVdX+Q6eMxaMJO5/8M4Rwtt5f2p
	 4DQzhFbcuaVk4ZCgoXzecsn9xmuGQWYrdNa5+LMTuCy3uaZL9EwUqjh060yc2q63B2O9k
	 GpK+Ed/oCHs7JyJ9RUrOCqwjFN+YZzKo+XFQ2jd7t3Q+Gz1l7yw/YKTVXPuNmyxku/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=jTqSgiI5;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB5606A688
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92CB5606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=jTqSgiI5
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so72676645e9.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795710969; x=1796315769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/V/q6vN01qyM55wT6FtlhrNcKv+AqGvLCJ3sSHicCRM=;
        b=jTqSgiI5rL1PLDfYRGEUYiTiZCRCnpYLJfz5etGQl5yGV1yeukXttQocy/Y8iDopJD
         fnmG6PtwwHfkUC/yYi7r36XV4E2835Ezpm1K28MBGCjY0ckav4wfPHOagynYcaMizArD
         jk4EOvN+ni6me6j8ENHTPC1NiPgg9LDYCEBEmlDtQXUq0QPm/FpmoXiJ23TPirhnMxPA
         woiDK59qSLg3cmCYziQgrEgMzbvYhakiA1w7SRWTFVqrdsvExfPfKOFkSopd/NBsuTm9
         1FhNgVOhPm56JD/yjhUPuBz6cAMLjRo/R8eL17Ga7OQ9tuKgyEwVas0vYv5PKaBCUbra
         vM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710969; x=1796315769;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/V/q6vN01qyM55wT6FtlhrNcKv+AqGvLCJ3sSHicCRM=;
        b=u8ZpTlxkvzttbg3dK0Mq4A11bqu39+Iu96EfzOS3PoNIZE18bjj27ynA3ZToPgVQpn
         aDYDDejzQUAzJqIGIAGt1s92a0h3c615bcpxb4dZAlpdxksT9yhUdcOHFoudTLsN6/p4
         UjwdHYlIGuO2aHnv3Ka20NoWw3MD5a/1HZPgtsD3UuN3BxMC7nVMkVmOZzu4ZUX9nOVt
         +nBVrxeTRq+fc+cwwGxomascGRN7kK0tEGD4RGGpzqK1l8AK+uSoRpVJ4HRD3Rzzjza+
         9PEtoJ9xF23ULbqGwDne+8BC6kdD/DpHdnJcw4HmTHqq5yG0s3OV4NFKAeyJ7IKwPP6b
         Irug==
X-Forwarded-Encrypted: i=1; AL+hErFPn5hYHqxRRwUpsA48onokXMW/Q6tPUaHdF5Pi286GjwaNrGi8+y8KiOA0lT8D4pn1f1J0+9s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Accze23upIaltSi7GxrnAd8UG4u76jokVFN83GNcHHOMZEMWN
	J+dQzYf9X6UcA0DMGhf3gUYDcqxNJ3Bbm7F01FNKIVpsHhmH/uyhzFQ=
X-Gm-Gg: AZFdTZe2fUp+QLtox63z75NeWbsbNx/UkIkVv6oG9P0pHOEa+RxjIOB5kQBPPRBB+Wz
	tyzu8lA7RBV7CEziR926wpVcQeKGMJ9VdN+xw5NtGAsnWjl+goHhDx2jVreATIGduUlAP7cuVCz
	xxtBAraGEsREyBwDF5sxZ/4ocXS+VcrHSWT5Gs+r8TCrkBzfkNMpdjwI/RWT0L7uT4Mf9GEhwnH
	Y2HeZoZc8uBPLxpiXZtQFPbY8/fCKPA5TIaLWzL6/Z9bnPJNL91udCcIN/WRtBmKpAZJOUykrWT
	wUjQUBYi7+uF51WAdT+HeQ/kZW12juGodP3ED037HJfG08NxG43t/lc9gpsOMC96oxBssy/rQxV
	ZWAJjGAW0OEbSC2Ts75mDnyKCC9uaLPYfG8J+QVdht5mSSxReTzWd8wuUexN0KVhSlyjWIwS55w
	XNkPw0pvBBDrTJqA3B9vXUhZMm40JKkXY3DrNGmE3upo30U5F7eNN//CtBcyZnxCg08RMqbE0SF
	GIBK5vBXv4Ezc07kTZJSQyfJHjnYwBqk64ZHwJ2zGnr86qytxIGPTc/zIpO8a2GwQ7HZdlS2ZTo
	7GW838CcrNVBBljbxopbW5tzLQxXGm8xgCek6ROvmv8KAPX8f0YHNWlPoo5PEab96Wolt+QrpYx
	cz1tM
X-Received: by 2002:a05:600c:64c7:b0:4bb:68b9:f610 with SMTP id 5b1f17b1804b1-4bb887ffee2mr416755365e9.9.1795710968740;
        Thu, 26 Nov 2026 08:36:08 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac210.dip0.t-ipconnect.de. [91.42.194.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm606032885e9.15.2026.11.26.08.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:36:08 -0800 (PST)
Message-ID: <2b097c77-6ffb-4463-b154-661f3731c412@googlemail.com>
Date: Thu, 26 Nov 2026 17:36:07 +0100
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
Subject: Re: [PATCH 6.12 000/815] 6.12.120-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261126105709.009001842@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261126105709.009001842@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.11.2026 um 11:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.120 release.
> There are 815 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or 
regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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
