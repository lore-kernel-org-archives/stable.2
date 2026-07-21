Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5B326D44
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655575; cv=none; b=HmlqQpw0hJIsvqWwYSnzT3iLjoGKpnOXjTHhF9rRFyq1cYOYHMr7uUhRYn1m7jr8MxTjPF8WHxSFUC4c+2p6IzRvbzdDbBdURg+HNAlJ9fUxkc+OQeXdiGPfJAaRJuHSHY0nV8Zr86g5AGdSsHQyxuRHlW0YmMJDHF8AVQpHJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655575; c=relaxed/simple;
	bh=567FUSF9RxKPwJn3OMgp3UXkfaatoI2Ifw9prZyPpg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpIZClmrWxU8OGqLQcsN2DHiWNxDSTZ6ofBXX4Vrg+Neg/Deo6HVPAVn1Tzh7sIFBab2/8wi4WlSCtK+kPn2fWXBYqN/eOPgxtmq324GHp02MSOEAdqZSwgd/xmWuLDKCxGb5hCWBu0pGkaxueIgngzEuueVLCeE803NFIJ+riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPeqxe+T; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPeqxe+T"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e6f0b4610so119236167b3.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784655573; x=1785260373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kgI0wIx/qxQMjezAbCjjgaXBjZwYeNpqJNQzjszKLEM=;
        b=XPeqxe+Tnx+K8QWCh+g6JbUs6Ror6WC4MyInPAiObwY7sszjUmN9SNgt7oqelcU3kK
         c2N5O3tGKiJA4tRmE5Y5JKX/zd7IwytNJxSeN+Fm3Wcgjh1NZGyRyf9ACYzU5b5Pokub
         cPdBRGDJ/chRFHUqQI0SGGsY76fkiistQ/vw8JamiwEJG+tcsVJlTBaI4TMxrs5txbxZ
         tvWtQP3krngYtX234IBxUcCz2b1uoh3HNqG0RDkzTDRI2oSYLYoidNAKKhmsAKHW2CBs
         lKTyBJ3Doz//kAK6MDQPEO0H53NnBYGlhmXT0P+o0dAys/InleQCQyDfPE4Chiq8eNDr
         0s3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655573; x=1785260373;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kgI0wIx/qxQMjezAbCjjgaXBjZwYeNpqJNQzjszKLEM=;
        b=Z/FlxaERTxlBoYpXQCrQSRByj31/WF7C4Y8ZLwYWeQov6FyJJLKGyOn+nzUBhsA2Uu
         u8cHTLQ9xgiZNO0LpXvs0hqsZYJSrzpwUu3uveyiWOgWYan+E2hctN5/hQWKHi/rjSOx
         3s8GEolNW/WfbWXDo7GiSRwTBTCaSDJX5Cyhu4nMRp9V4XdgV0YtKPo/+KC6c4WZemTL
         4XzPaVbkXKaC43Vh3Xf5LZwNmke8lM0BJc7VjL58sImUY3FgCEMsRxYyVUYXUFt1G8kd
         3ZySNWcY+n95LITaxNZB8a7mj648UtKU1rokLMXMlKzDMk6XlEemPRW1GWwN0XH720rj
         E/Kg==
X-Forwarded-Encrypted: i=1; AHgh+RrJy/V/x/2jHVPOeTJfnttX+jgu2AAlLkEHRWxbPTNoSyPVoTQW09/qFWcKOwXSevZwyq7ACrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ZftJJkvHZQ4gr95HhRmPFdNWrt8w2NtAcKsN4xpEt9G5Q/jU
	bHFae0ePsSIgkT4JjUpfn1aSPXQkzPcUl11o3n1k7RmrvVc7YEJyNfHg
X-Gm-Gg: AR+sD12T/EJj/PRLqRfROrW7n8y8kLMW7Q+XJ4Hfsr/CRF4nrcMxy3NA+ouLzDG52id
	LJhStEBUJjw4E7C1iZPgYWFjCAlp/1TViyc8Nd7aMEuxWTozdW+fzZX8Iify+pzGiR5beKrwCUn
	LFrIIRCct8CV9WcO7J0zwT2jSP55YSqmf4r73I9XR7QQWpZmZoRMagqywPiJqudH0/wO3wK4qbk
	A3LUE8trse7iqCrTKV8cI05blNyBGLxVZtKK9SPlobxN7bMGto6PKJWL1JRCk8DpzcfBJ7DkFXQ
	vQ4l0Ng+dIZxN6GzSlh7MLFvL82f+YXQ50YtfbFxiTnglczbdKGfN+n1H/hyZswxo8a8NXXoN1N
	hbQiR3Uyd80VYnymiB7+Mdn+pNK2fciao1VFmUE63Af0quxRx6/nq+SN872QX3sZaQ/MIlIlOP1
	sXa4YgSqqVqhEfLsEtGiQlJsnfLvjw
X-Received: by 2002:a05:690c:c1c:b0:81e:6bd6:39a5 with SMTP id 00721157ae682-81ef25a4655mr59727667b3.1.1784655573234;
        Tue, 21 Jul 2026 10:39:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33ef0a40sm1429877b3.39.2026.07.21.10.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 10:39:32 -0700 (PDT)
Message-ID: <94ebc599-4310-46f1-8167-b356dfa2e555@gmail.com>
Date: Tue, 21 Jul 2026 10:39:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0000/1276] 6.12.97-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260721152446.065700225@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260721152446.065700225@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 08:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.97 release.
> There are 1276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.97-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with the following build error:

In file included from tests/vmlinux-kallsyms.c:8:
util/dso.h:664:6: warning: no previous prototype for 'dso__put' 
[-Wmissing-prototypes]
  void dso__put(struct dso *dso) LOCKS_EXCLUDED(_dso__data_open_lock);
       ^~~~~~~~
util/dso.h: In function 'dso__put':
util/dso.h:664:32: error: expected declaration specifiers before 
'LOCKS_EXCLUDED'
  void dso__put(struct dso *dso) LOCKS_EXCLUDED(_dso__data_open_lock);
                                 ^~~~~~~~~~~~~~

this is caused by commit 3e2cea6464884252284765fb48b00e56449ed63d ("perf 
dso: Use lock annotations to fix asan deadlock") we also need to 
backport c5ebf3a26601c833a3ea8c6035d4318445a7e3a5 ("perf mutex: Add 
annotations for LOCKS_EXCLUDED and LOCKS_RETURNED") here.
-- 
Florian
