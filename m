Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED856510F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001312; cv=none; b=uVpzCDZiIHP0/D2/MC6NKsXLULFB/CC2leB4KMyhVLp+qEwil/GM6c+PofWMz1k9jZZT5YaAUlmHFJavXueVRmcIQwDfElFxri9/wZxWidQCCHFpnXiGWQ7ICeC2gb41jVuXhlNPemHBlV+fq/1oGCwllCeidjd96vvn02MKpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001312; c=relaxed/simple;
	bh=Gcu7FaYDYZMs45yhEm9GtD4DhGMsdtRnsP9YlV49BzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhaySFuNp2Q9+LKOIn3k8tz2nbuiVEZ6qC2E/H07EiUUVMjFf7mBYVV/aKdnC+MVSGMGqs5V9dGauHv0lfI0NLKrhVP/k8WFmW+DS7W70LF4cdWaGw945ka2Wq/tMFiSEL0201LGHennZUtug+CW9Xba+liIJUsyYRKh0CxLzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RPE0pO/A; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RPE0pO/A"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c14a06c95so3515815f8f.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792001308; x=1792606108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRWk/DlPq9AfJCvR0utFh2sqtNC4ckjvM5ysikrAaPE=;
        b=RPE0pO/AsrH1a1y2bFGzmA816/qKq9g1Jb6Uh9nZElPhyTy195nrAK/WJy/ifdiugr
         HC0lB3Kmae5QGj+t2oXeqQ3h0kGaq8opRmf6cn3MFxYErx1WJAoL2/HAur9z0vUF3xKd
         0y1lY49vOQ59BjtCjm1ixunUnxwRVNgQdAZoHOo+xZ5dflzucSHZRdH7rmUgDxKO4KAI
         8bThCSeJFZxcecWbqX7RmBbhCAZzg647dWMH9wL9NfzjWJ7cRVPPmVPTgtaNgG0C7pUw
         egMDmRDeuiiN8bhF/fkBRCu5GvqEB1PoyzgWWKLhu71OPMCFoBWlPnT4dK6uVaDDpt3N
         hP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001308; x=1792606108;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRWk/DlPq9AfJCvR0utFh2sqtNC4ckjvM5ysikrAaPE=;
        b=C9qE/IFY9PfO0AwEiCEN55UnDW2vXGH3A4gvWalgxUNBw89fUj/V4Bs45Ivreu40dU
         sGEOCXSSC309ZRmFyk8rztJOH13/SrnfO+l9Hm2m8D5jir5w+lR8bUyuTqLrFwahgVaM
         2lUFaglwUDGpm45VqLrABQu+D/uFjUlKTdNPE70fUATAYTHIDxbleZFsWnpiACOCk8eC
         wOXsfBGEnAVmNxL8X6sA0lgoysVV0CQHRU7i3CPq9wljOUDy9hdYhyf1DcFiB4tJnTCi
         FdbBl1GHzICCg+wdlf0RAIVm2cTmEQvLtNY/UFTGe38QdNZGjaKujBQ0L3VIWECIiOAF
         t9IQ==
X-Forwarded-Encrypted: i=1; AKwUvBztTVdhfuQdzVguozmHRQNqIQc2om2ca1rJyk9UQ4Xu2168Fx5sF6Z5MztcUV7WKj7gH0JUhdA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSoLskWHU7sceGChKZy8wjzHx2iCLLEAbbM6JsuZQDeQyvBHBj
	le7QiLPEjV9pIs7D+iDbi/31KZeTGsJWB+yeZyp05DPe/nbX4Uz+3vA=
X-Gm-Gg: AYBFou3sjAGyccQ7f6wr+ZzPZwPrbjLyoGMmp99/pYLZ++sJnG74qDuCsP3dktQ1eU+
	JeAN6ndDoae0pugHpaSFU+eezS6fF5DE8IcDoVu/1Nq/bejOdv8p4sRZBuu8lCGz4XENDBdvywQ
	zmneLv2sEVXa7YqY9BHO2Z9xQQ1pF+DKJekOv3gcjsliAPCJcwLGzmI6Bw1rDtt7G9I18Z2fzXt
	BZuSQ3U7SAO/fwxrdVLa7TcSTbhirddA4uKcBGnlTcdL5HFzfABGgRIgjk1ztHehQt5KhEWdnRr
	SiPpsH2RRJW4KtVcNznrD0YpRl6wU4jrgBzm1cRz2ZyI0fXVJnrLm/wxZzAFcZBxXpKJpaHTLQ6
	lVEK+m0PWwqVFmfiJU7Zs7k59iW9IwrhPkk6hfD3LfQDV+A/rek/7rWdmvY3YCj6o+ZHuQ4FBc5
	n21zlcZTfdZQQuth2y9Empi/XA6ODh++QmIlbOX5Hzxp/Zd/DNe7K0B9Kg8uR8BQIZ4S1dEDUtD
	LUxMRzs
X-Received: by 2002:a05:6000:4208:b0:48a:eeef:b4a7 with SMTP id ffacd0b85a97d-48dbace643emr31763461f8f.48.1792001306120;
        Wed, 14 Oct 2026 11:08:26 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acf7e.dip0.t-ipconnect.de. [91.42.207.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc506asm13879718f8f.47.2026.10.14.11.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 11:08:25 -0700 (PDT)
Message-ID: <819c955f-5ebc-4c9e-a7a3-5da698721493@googlemail.com>
Date: Wed, 14 Oct 2026 20:08:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/505] 6.12.113-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261014123803.944920639@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261014123803.944920639@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.10.2026 um 14:50 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.113 release.
> There are 505 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

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
