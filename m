Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939C370D4F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995969; cv=none; b=VqKN38ntMUq404rTBTpOCq/35628eU9ecG/tUHmZwz0RjmdHrESJ2//2O72r+bhTNrHKjl05AKUBFBnLFhgo65j3W40LdcaqSVQ+IyZpqEA8wAxc2Jmt8KuPbdsL+bPO6x8e2mQu+28EgKeeV7Po9wOivUHP+r4S/IfaLKv3txY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995969; c=relaxed/simple;
	bh=qjzcOuDGva/am/+FX9AvrloKZpU/QphmrMZnh3UGOWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBFRwBMEN4AEp3tB3zZTITT4Q1JwC7jANKEutu6OIk3AAUrZxonZRtUwO8b3R5Mz6y1IypI24sr6lnJ9l9KHUX2n2LpFvYKvq82KwQzL6ACR7+ZHf6+LBgLuCWhqQFKhLUYWzC3PWyTrbrTwvmFcycBi/eu7ujjW0Q0sycksEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Mpr8zZ9l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Mpr8zZ9l"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47de008b020so154562f8f.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1786995966; x=1787600766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMw/DsLwlR9gsQHD2JeUWofjFd5mKs46PIgIVFOV7FA=;
        b=Mpr8zZ9lXi3lEs0Bsq7HkSBpUXaREQVl3x7j4IirBQAxKefQsg++et/9ciAYfITyuD
         YVIBpN0OGWQG0YkywwkUvG5sZ+T0/iLsTuf5+o8wsjMLom4hhoZ6JLF0lBdtdIxGhvmy
         qoil6/0hppdCrhdWUArg7sfW2Q1h5N1S34oeh6uncIYr/HS7D8T5wwoQLbFYIRQAzGw9
         Fi9bHwJXYvZfbkm+Ee6hi2AdvCx/DRzxDNAE0RosNbLMZxgylnY3XfVhviCE4O/h8/VI
         gVfL0sxDzKBlvq4UvU+XqjyXjb+WWAmNE4ERcY100K5Ahryo2oQz3KD2Z8I36LwczUm8
         l66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786995966; x=1787600766;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMw/DsLwlR9gsQHD2JeUWofjFd5mKs46PIgIVFOV7FA=;
        b=eIhT0Fe0phOuPSzoHAUtlVB9tWP41lVGyisaNzhMQXzxqcHbNN61JCYApT+slF7ANI
         l6YxaM4qaF0xViXiX9w8+xwbgOq0yPt1ONvksXSvNnuEEhcEwaZBUtb7u2vknw7x8tTp
         YT4gnsm5NnhgsVoYrCwSM6jf4zsOocCpmcGmusqLZGusKeyiToTCpfJDNGjPiAS3aCMX
         KZJhsjZY9iB+Bf6ZrBcSd0Dvgiiqse48VSyL0/CRu0rKDB3pgzcGU8wflvyjUuwJ/P3b
         bd7Czx9CgiV4vDjIPANytbOF02A3wgrUlTy0HhmKGbKEzKWU+5j+RxTy85l9pAvDAGSM
         5ulQ==
X-Forwarded-Encrypted: i=1; AHgh+Ros+nWAYQ6QdIBk35IAwMVuxyJIt6i4UscZD2ijB517xIXnx7uYpcsK5+Wk3OhyFknQQZvp4Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpPzuIRzdIAp1Lt++YPFPsPP5iTMqZ3hCosugURbIK5fp5+nf
	SV8BJHQke2WIGJW6tEUeDHSvrHiesuxiyHP/Ra6K5Fvb2L9E5F/wxoU=
X-Gm-Gg: AR+sD12+UPI2whXu33LPHlI2qpxb5iSiGr6KbMz5BdyadxV8jqqeyZWeW/UC+YHvGlk
	eAb61xltjACafLXWnSQMviu2fMlzt2Zm4IuoxYiOtpgS/xiYtMWbjvj5xxeY7Qr3RxULw9BXoVA
	wkN+q+SzXlrncS29nOG1+H8ZAKjxU9r1JwsZmRryyhxZQnzhODWz6jLA47WPCieJYKMCTR49Eox
	w0+7VkdyVqq86t6RXW7Jfyno1ubdWg/VaE3xKw8FI7PE4osom3I3wB5vw2sTiwN9QyFtOwsuVto
	YSG5Z174GyRp2B2qNsTyC32Odj5Dl4QoOh2oNWydnXlt73CcdedaOETGi0EW5zPS6ALHf5ull4c
	2PVflejmW3T6/uz85tw5B/I1ANQP/tOGrL+JdjdHH+jvaLYsJtpl+YY80qYR1BfSll3C2N5BUDp
	EoE/fkjKMuYGQiX6uNin3EVeHcPNm1F+Q3Fzg677dKtxiOJxTE1IQXGUAUjY3zj4OFa8Rq7i7qO
	4Cjo7ooEnJhIc+HS7lATF9/5hv+R1CxMUfZlM5v
X-Received: by 2002:a05:6000:2087:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-482aac7e9a7mr369373f8f.14.1786995966109;
        Mon, 17 Aug 2026 12:46:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b466b.dip0.t-ipconnect.de. [91.43.70.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7bc7bsm5844067f8f.23.2026.08.17.12.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 12:46:05 -0700 (PDT)
Message-ID: <c4922cb1-3430-4d9b-be7a-06871c92c182@googlemail.com>
Date: Mon, 17 Aug 2026 21:46:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/250] 6.18.45-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260817132536.466235697@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260817132536.466235697@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.08.2026 um 15:29 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.45 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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
