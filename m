Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872965;
	b=Vxmqz0wLWdoJ53PwAYEdpzfvwQ3BQ0bqEwuWt1fUK95IysgNIZ9DvOHgEqbW8UsSGg42
	 2uSD6ExLxAWaQJxZM6822L9fTi+Gi5Lpb3tBv1ZevIltaGVAPQ1TAkvn2Crx6bSYY6jiJ
	 fNVmp1rmU8+7TVPxOZcgUYCI03Umco2bI1jwaJOnUE5srB7t1p6I+yPB0j/GJRREWwTg0
	 R5ujbZGW0AZMDA7Q7ZxjMXw9Da7clfzMH0FP+x1axhdU57FLv1nBFxhKEUf2d5YFt9Yar
	 gdCdpq4DbeVOQa6SQ0rKRZnjsOx3goNGWiveVJv8C9DtwZRnYJc+tLI9GVl2MJGzxiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xOdSrRSD68sU03mdy3xyH/obHFukp7AFHKnxKyzExEA=;
	b=yetF6DlvRL300LsexVQnLCc9fDKBRmX3SzLGnT2zhzbhdSVhVvHFJgbYMMTNuCjfa1YB
	 XA75Xug3ITnX/65U9u0O0aJiILqiK3N4jafhExHRDOeHKAsOPVlhpCPnz7F8Pu1PqupJC
	 eg/A/zYIh4N0BgbQ5TFlyJUrpLcrItB2xFnZ8HrYhcANZz/YiBtCfzy27LedOtHwkZmPl
	 vgG9r4FjSoo8y2sof0yppflsKqsaguTgRhZY8ecxz9+JMrZa/qs87YSbdFUSV0MLp2d6t
	 05tknhwDHss+ZtJ/3Woqeks27z1VIatYpJjo/kvtd44YOyYcdyjk8J9jyYcvvD3Oy2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=WQBFRA2D;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270D606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0270D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=WQBFRA2D
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b060ec084so1161907f8f.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792872963; x=1793477763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xOdSrRSD68sU03mdy3xyH/obHFukp7AFHKnxKyzExEA=;
        b=WQBFRA2DHulKxtiRFCmc4qQ2bXOc9WyTsgvY6RyLoOOFM9P9l5dSt2Z8apXqZn4t5P
         SD+sowgsEzE9dYKs4zlv78FmttAFO1Wpl9vG4JEtOmncn39P+SVGcbf6a5B/NTLIMhHk
         OA/A10TXS2enTZtjLh260T3OJKOKotfSDvZ05Se4G26rS4WWANzf++/Xk9Htr4QdxAAI
         xISybnI/tagJspCGYI/f8f6jELof7uX4Oeyj2+RjxoO0YHuMPGLILhAGGic2SFzhtxvp
         HGhZ/blsHMCRN/E0sLem+lO/7b/f74YPq8FdJMaHNIeNTbLUFXkHBEATbzsYRUEJiuED
         6Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792872963; x=1793477763;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xOdSrRSD68sU03mdy3xyH/obHFukp7AFHKnxKyzExEA=;
        b=zHSY1VRL0aMAbZp5q7dehrWF8jh5IakpzAtCsFHMy4eOCrQv1COS56TYvp1Cisld5J
         VKfOrph4wLf23yFv37W/YqQZaRWihDS2bC3ne57TMuGoTARRnq4tnPxNuMKfXDPWDjnW
         0jvrNNwfW9KkK+hvA4uuT2Ze6LXHXcr97bFz2sL1gJq1Fd080BXTkItMgEkVtPlF3lve
         3KE5JLChaeZKrPZ7dgmCXXQAka3x6nxzRBzHSQpE05s3WNXA3sfRz9L1JD1J9gZn21aF
         2+gRELhlsjQe2TM36gs7a5DIhyq1j5lWDETz5xT63eH8qHJDyAboes5oojiKsRO4+3h2
         Ec1Q==
X-Forwarded-Encrypted: i=1; AKwUvBw0vfoAaILSihOkNesK5Q7Vimk1v+/0BZbAOztIjyrMiehVEnRxe5KXfP6FOLy6stYpd85qgGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAK8nRPeRWmvnt20uXfBhsS9Wf9Hk/unDuLpptQIFdAC/gDD62
	Q+9LNrXGIaX3VqojN4+UShL0MEUSszzzqBKEQBI3QDAr7cYimLjNwJI=
X-Gm-Gg: AYBFou2BAcf1sV4uE1ZmrZXzOqsHn9kKjxvt8yR4MICOXDYi6TGFiOguf0AHnfL5uNs
	9NvSSlKXshYbNmlwtL3ToCefO4ei+6exBWVioZwi2cdnRBMX40VQJkeBZ/vlT1AeQP19o/HAwu/
	GIAMSE5s9tgmIyZXETj+aK7xtO0wYDD+ETF6eYE/SQaLXJdiFj6jDHJLArea9pOH9Rpkzpij6qC
	TJtcMNay3V/8uMhPdSRBPPQG5pHj/kVMpjU819PlhM+9d0QtR7VSwfHiyZrxoZLEmW0QWAas+Ug
	Hqx5sVrWxgIA0PGa9pgarfhjVn3zfD6kkoQ3y6E9lCgleJ1RB4ooqq0vj7t7AHB9mPzlcwcQ3Ic
	T5nPyljfPfTEVXQnih1YrjPJ6w5Wq5XzIl8G0yEGpN+M4jwdrkbv2zfHVInlOPH8QRolvyiRH1I
	kjRCTNSFA2gyn+MONrdnvshOUHXZFkv6CHbo+eIO4IZAdiK/A3laPjc+SIXJe+YDfmrd9Xwz5/w
	AZSSAjYpwkyu2hctfG/QlK1zT7FklZp2X9iUMUxRPwubtL4DN68lHrPtuobhpcgkHKFyWRcLTjv
	Me/7NkzaNGG1wY8H1LsBC3U6VJubgg==
X-Received: by 2002:a05:6000:4549:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-48e3eba0c36mr2612894f8f.43.1792872963065;
        Sat, 24 Oct 2026 13:16:03 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4b2b.dip0.t-ipconnect.de. [91.43.75.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e4115f496sm5555426f8f.5.2026.10.24.13.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 13:16:02 -0700 (PDT)
Message-ID: <1cf833a2-1ca8-4fee-97f8-fb9b8e76b868@googlemail.com>
Date: Sat, 24 Oct 2026 22:16:02 +0200
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
Subject: Re: [PATCH 7.2 000/243] 7.2.13-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261024064731.125251200@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261024064731.125251200@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.10.2026 um 08:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.13 release.
> There are 243 patches in this series, all will be posted as a response
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
