Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BEB2E1EFC
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788221752; cv=none; b=Fw67M0Ib6FfUPiB2vinoW29584P4Hv1tolamoDgeCJ4Kt26U6HINnNlG6Pj1sZAXwDxU0HvMI0voq/IMoloVeAJpfQg9/9Rk/kK4ezZc+4mAX1KlUepgCc3CrYGbGukERiZPl9G7lJ4t1TO+6kMZs3DgIBVveNnNCJMm/Hab2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788221752; c=relaxed/simple;
	bh=yCGJm1jGkR5RuGr2i5gkhz3GBdsvJF4mNpsE9U0bBo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXGi0lLm9V/puKG0uNjH/vwbbRWftaYy2Yh+718askI4yrQeGkGDVbIVAmrUN+GBmt6gwKqUqtrlne4hVmh+idOttfnqJrEWO7AtWVnlICkacuaui6Ah5S4fraIYD3Pw3fNxFioBUuXcBAi0Ov1vVlzYQO7x8oXT+sPK+g2Xec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9WoiCtk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9WoiCtk"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so3778956a12.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788221749; x=1788826549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VfqEXN2Uyf15PT99s9ZwevHcWniSGZO3B8ZSbTXjUBU=;
        b=d9WoiCtkaMNFsYbeMa1iAraKNC+yOAWARLz05OqE0V/PsTPuqfFgdqtY1MHfecdBO1
         J44u6mT+eF76rWqpECjrrUVGOCnvywd60d4T2EOeRm5NARRuIif/YtKQ9QecOP1BF9Ud
         EvqYRQpqhb3K+H2DRVFKBs49apdLe0QNZ2yT+qmFaxVOVoJppWDuT8R4EEuAlcHit0pt
         fVv9ehb4NN5CzEdgz3YG1lP6Q8U5fS0/LwAXw+7eKolWNKDHki7uXSt+d5AVzE5tEjnS
         GfHmOxjLNK1oaQaq5394ZCg+WAFESRbnNuCELNqvnvqKV+rgKOLXzOOlMOzrBeYRGZo+
         jo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788221749; x=1788826549;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VfqEXN2Uyf15PT99s9ZwevHcWniSGZO3B8ZSbTXjUBU=;
        b=HPAKQOLsnDVc0Frt8llhbHkfpLEUDEf6umYqPNbPY6o72ceZu+Tt+XrJ2ZPpm2IkhI
         Eif+hd4B6NmP9GIMD/ErlaXw2QCyjFGb10F3UuPOjRARY/x5YIA1NMAlNKvXoEOkm1wM
         8OLfX/uVCrCNSVks2GEV7UiRFWYe3lxuI2aTf4KrketdfWAWOojxK9WU4R4urGRHXFym
         qXLDlCztvdsQqlXudjV0gPAyiE2E6GWJ6YbVBLreRWem2necnr6Nh5xZ1mTWqEf/gfkV
         eonkP5UmguXxyRQXEJ3/VrgS+AIJt8yLgRscTXxG065nwTqqIhCVz1SqKrSuCzEEG51K
         HbMQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5i6Vy9U56C/wQkbXQcRYXUzwVKbMyiL/jtMfPGKuZHH4Yp+AXZl8leFF1PiG3SZgJOKkyw8s=@vger.kernel.org
X-Gm-Message-State: AFuF++lNofomSDD1eieLI196k8oE2FQW1+l4Jm0yKOiGL42QHgnF1251
	izOEHvfwAbnuo8OE9oAMTNREd6h7PQQGGVjKV804lpytzFB0Em2MM+Ff
X-Gm-Gg: AYBFou2ode9i6cgEQwg3pcIfiInli421XbCdfJ3RQOkekx9fRphHrDbZ/xM39gT9x2i
	kQc76Je18j8mNXTAeg58bAlokf9XtvN3nXuuBst/mpg9uIwjEu0HPALciFe961cM0cJO2IfeHaB
	Nt9Moo4zWTMp6Z1XRfzVEIjllpsOhK4aav69tLdG3Mt6zD2KXDGc2NwuZbdjxTHorFWW9MG40d1
	5ovF73sxGqjNC1LIzZelI67wh2hUmVfawPtOMPVq73b2hEHmfbjN9LspERvJ71vTbhdfSzq91QO
	tHh673YsthifLJ/TrNCFFW3dSl5UQ1BLJxHqetzeyGdRo6pNSDXcGL34S/+wiRciOpRStYGvdZX
	h2ggT4fVzxIn5mEmilL1Xofblg10Ph5Kjtn2ceni2wGk8Ms9VTnvI47KDgaSvz5hrjpfa+2Gj4/
	UCzr/M3OQgsxcetHbSMB6FxWJH9gwMyYh4zMNrtHoikfYfel35wEnWZkVC/+EETf5A/8DMwV5HY
	IJEXz8GUwst+sKO/4Z2i4Rr0ROEIQ==
X-Received: by 2002:a17:90b:530c:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-396d0d4c43amr46596844a91.3.1788221749583;
        Mon, 31 Aug 2026 17:15:49 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d3fdf6sm32745466c88.6.2026.08.31.17.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 17:15:48 -0700 (PDT)
Message-ID: <478c7bc6-bdd7-45c1-ae8f-cc7e672912de@gmail.com>
Date: Mon, 31 Aug 2026 17:15:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/83] 6.18.49-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260831133359.207714926@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260831133359.207714926@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/2026 6:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.49 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.49-rc1.gz
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

