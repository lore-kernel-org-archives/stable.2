Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F0415B66
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261658; cv=none; b=YJXoqR6bW2jlt4ABxjlA3/RkIWJ5SJ1QHf9hxMjI4gKtMEYw2Jg7nHuX6fEYcuihhZn/FGbPC9EgWaDalkragPpHKde85+JzSo+Kbtoh514stdC6/7Q8KJc6YTBrRsXAR1/c2JePQozOa4GYTWEJTXzCd9abkbrYJZ0reizLYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261658; c=relaxed/simple;
	bh=qIkB8dKBo/wt3b4yl3vtKdq/2WMENY7BkaeDoAJE/Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNw9fDLd3hzz8bLygFjdzn9V1oX9uNabZOhcg31QmktcfLMy9s/AG0q+4cOjfP2tawq6mS3FiE2UbkrVPMXCgfPa7L2KtIWxuTu5GZEVqHfBtsj6PvbSUgEnPLTPIhwB1VH1rMR6DZ86Ak6AvnuLvhYDJpcgRHEYlZCPJQfBf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTUC0n5F; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTUC0n5F"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc147d86bebso215370a12.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787261657; x=1787866457; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VYXoftc6soVX3yMyRggyhy2ugeoCiVfhvw3PG+iGTkU=;
        b=NTUC0n5F9GEJXsQoV3BW4/nr3KSgFfXXw6ysp+jQJDdvUiYM1I+vxQCCRH9QEbmLTX
         leBkOTrRIZiaF1m7g3jEJ+GkLN2YMZXbaoXHnAMoTWbCajxGZsJkPOxsuS1jdMUFU4sd
         RVAFzNbxIdz6dD+mQSTmFTrR6UNp2g0XJ0v7rTQ+Ig+WlisG8RcD15qpbV977yhQw4Uo
         2zFIdJN5O8ZgE/RxmK37J1JVLlrXX6K8yOeTq+hClxC4kE3ADQyHUVnG+MNwZbduWQTj
         GM0O0fK6hF9T3IvyM3FDJ5wTa15fPJafhGGoMEA/W5zHePBi5SIVgsGhp32rmXsQM6mY
         S2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787261657; x=1787866457;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VYXoftc6soVX3yMyRggyhy2ugeoCiVfhvw3PG+iGTkU=;
        b=Ivv3h3dLQ5F5htY3KLTaEpR1ouMLNGEahr13pvXPYpw6/iLfPZOCvoA7tMvYFUmu0A
         o1tii5Kr+BxEvKE/MS8+OFQsv1wQ8QGz3eO51Zel/RSrdsTHzqn9Mmhkax5JiLealT+X
         gKha3D7zUxYqbTwCg3jyiP6DTjJURv0HVOfqLU+oqsSFV4akRBtf0DjyUsDzC+dYE/7g
         3/vXEv8HRyER2H0obAiSMNo9SeNBSO+D3+JcAMTjHdVUEBOVf/hr9hIERUhrP1p6BK4B
         LxxnIGNdTgtVeAbjjb3PyrLZgO9A/+LDm/LChI0/sf+aZZ6iHvb1xcSJ8N/oVB5yZxzZ
         07Bg==
X-Forwarded-Encrypted: i=1; AHgh+RqgYfoE2rKTFfMSXVLVIqE9liImB/bx4Kvt45Y6wvgjVx5F42r3tHTgYJp9qQmWTkC1hMjRw9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznre8+UhqPb6JfAzygAsGHFik1wZFCHWljCwdQqE+29OwHjZ0a
	qcVa2ahdCgL3wvibpIzg0ppzbOLo0FkE8+yiTwOwuOiRiEUI/0zVwJFL
X-Gm-Gg: AR+sD100uGnkc+W/p1far25cHGR90Zd+Ag9qR3Rs1NBIAHuq6LRO6PSWoY+I+9OfWvw
	Gee/aDmV6r3NENIejHUcQ1LeGqgde7cllMbOeJ95Igo50EYnkkS3fJh3OzDKyQ+Bx0W3BcnX/Oq
	cOEYb6Zkc5Xt0syG0LpUVxAJ9b7WI/dP8VMnLlH1oSEV3n/PzB4+0dGsJykl0V+jZgSHt6xWDC9
	VLOjqH4M2EkkNMhcQvOZLvsJ26fOXImaQQWAkph/ST71NMfqITRLUhjtjqd/ZOnY6DfPZlCtUCH
	Ky4pfYLcJxSnmd+YLhaPg6ZiY2jf8Ip73XWSWOzA7NechxTtogPEXq8CJfyKTjJNDdk4ub0tVPp
	Vv71q2hQCZDOTPp9UPV5e0ObRrZj/1ymADm6PVBQcBnTuB4GkqdAw0SEz9cJpXSSiNMWuyfIVFS
	z4uEc8z01r5i1+p8c09jWIan5Nm2NuH449naoC1cmNXJqq/qwOUhqXfd3791JdvqdUPYM4XaarF
	VExjhmhmgmIQaM=
X-Received: by 2002:a05:6372:a749:b0:3b4:6af4:bdd5 with SMTP id adf61e73a8af0-3cd14fb6375mr10162877637.15.1787261656657;
        Thu, 20 Aug 2026 14:34:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf175399sm34681017eec.26.2026.08.20.14.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 14:34:15 -0700 (PDT)
Message-ID: <708ec0b8-a829-46ce-9c53-e0edb32cbd35@gmail.com>
Date: Thu, 20 Aug 2026 14:34:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/166] 6.6.153-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260820145211.194104353@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260820145211.194104353@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 07:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.153 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.153-rc1.gz
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
