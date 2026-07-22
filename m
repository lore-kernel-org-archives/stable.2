Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52AB349CFD
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745022; cv=none; b=Iis/URiMOgCF4A4pkmk69kUFln4zzG3QhONPBoEDCeZyaEuRoh35IpZAC2bvCowGAdGHzevRiGE+pk0melKJ4u8ulA/k7qTydEgl95RG0B0NIq62OcganBuwjVrL3YKdoVsBUqrBNYdjHwu/JIggY+ZM3ZUUVonnc/8Sw2Sa8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745022; c=relaxed/simple;
	bh=SNbj1L7zspeERKld3e2aumW9RaaJXnAzRlBpe9KgbyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vD5sAiaMg5KWjMxoDsm/YF02vobW/vle6WKAmgbwmPXKp+JujOVrF6wNvTG9lWkOkIxRtRSvhb/oye/O0UlSC/CNki4OJ1dhFRVGVdxYMhHB+h1QFFsWae1Y9EBKdLv589pMtwxj8RKQryW5cL3tooRbsyx9uXn1FQ9HoZ9qZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwdQZeO5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwdQZeO5"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb85186d43so1443702a12.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784745021; x=1785349821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRAeYjG5pyuBOUD0fjaGle6ROYAFcpaXD0DXyUg1s9w=;
        b=JwdQZeO5mVAMITMODOOAUdFbqSPsuAWpygNKMG+u3H/UiO84vg54ow71ZsD9zU/U0w
         B+12cY78VDLtQqZu4Jd8Tj049Ca16lzZVfrxW72X+H7440f9KUBD4Hxc31zUfEgV/vdf
         9I8/aCGqCaBMQB3/zmvPGDJJzimn5M65SOtFTuNMBfZQpjXSBFHeoDaWznXmz2nibua7
         NSMaWD9uER5W+nd6LFyLWwbiXCY+8I93W5r4zBkwG8A+p5JEYWZe7N0Iatbds86oz1Ox
         65VVj2Hd///+Nq/HqE+lkEnIEUWWxAJK9nW7z1U3MY3uHXNzJ13+F/UfdgDmF3o7XZf2
         eH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745021; x=1785349821;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRAeYjG5pyuBOUD0fjaGle6ROYAFcpaXD0DXyUg1s9w=;
        b=owfSA4mAE7q05fsbI0Io++AI+43AcIBLtJMvopxLe+hhnCHXmWz1bVsV7m6H/Fb81t
         0hpxpTTMHV+BUx+nFua1+4Lo+Nnaam+eypJY2+Z/wyL3rgkklygpZtLlZAaMQLfIrmQn
         W1Vw7LaCZODjcxRNr1u+7bOVA+RfXCrxZzWOHzsWZ8RSiq88e+02FmHFO8Vu5GO/wE/M
         42h1l5ioenjg0zYhH0dZX9gCt1jFLIiDS6rA5m3wQb0R1hPKcfAKFUTC8kFZfBnAmbLs
         76pCXeaPKPAUsrMjw1LUvjqYolehHYFkEeJhfFYAYImxALonCkpuO9RmXB92LCeycg3a
         /t5A==
X-Forwarded-Encrypted: i=1; AHgh+RqELs//c1ytDFuzY45/VcukrpB6y1rBFKO86BQqMjYwT0JXI4vG8ps75aNzle6lcLqm0Ez6lpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsxn6L6Xd0nptWbvsqIBA/jGqexYC4ieCMBfTZasixgLFssr9
	vPimghaiOZW6V+SeyII8rLs70T0/FQMcZZ4bu0uug8oa0BlXf8RKERlj
X-Gm-Gg: AR+sD12LmWqos/gDaRJoIQgFHHHEXmsAHIqoqiOplF6X8CcTBw2d1jscxo9tLdOVriD
	Rq7ivknjaGacmTVsnKz5tVcHax2S7HQf40lgOXx2/gDdMlQ802TQJ37rha8GArCh9IlE80wouwK
	TB7vFa8qLOhfi2WNN3boJzCBAR4J46irrd2gCieGk9CxFvj2SSynEe1NXu10HFILuiwnBv+fDQr
	W3Blpmx8B7pxgxWHARZWFEPvykkpgvWthmOQKW1kdIzQM3XcpZdIyCJ2ocPBgf0PpOe9A6etLpp
	ZFxEidnNomcEbEE3yaetQhnMMMqRCxUGlzYzsncPnXu/KGizQE0viRB5N9bnZo7lc6pcM1h7hkE
	++HtiRIkv/gnRZcEYovx7ue5CWCv9onOdhDokpaPZiiGZTCgaAepjZkd/sng7v4Nk4DoX7dCMEy
	yUkQiZU5Mr2TP/LY1VdX5cwK3IqglJ6i3BkleRi90=
X-Received: by 2002:a05:6300:228a:b0:3bf:6c07:b2f0 with SMTP id adf61e73a8af0-3c3ad9de8c2mr27016117637.51.1784745020892;
        Wed, 22 Jul 2026 11:30:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df06864sm11471328eec.15.2026.07.22.11.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 11:30:20 -0700 (PDT)
Message-ID: <f9b57af9-ddeb-4a6e-add9-314d08aaeea2@gmail.com>
Date: Wed, 22 Jul 2026 11:30:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0000/1226] 6.6.145-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260722143258.264584003@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260722143258.264584003@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.145 release.
> There are 1226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:31:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.145-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
