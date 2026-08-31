Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8E39A815
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213858; cv=none; b=MVKB5dvgJRqUZgxOIyDxzgW0WGd93WFqYabZn5X9csrLvTffp09BL2hy4B5I3x+Mt30Hw0cHIubTTKJKHcZfZ2IW9ZaTirliMGO1jt2DmvmXhHUZCrgA04fvpYuTUt6Zu4wuHq1keUSrOQ7xBEOSMta0dv+fievyCuXGrl6IXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213858; c=relaxed/simple;
	bh=q3/IZd+/JxIUPjQPoy9G/4IfyxeAweQqyqRpHrTqC6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBoAqgfmaWv4CrJBRp0VjGzbu+O6E3xVKr2aw11t3SghI6TVXSV48jdeWfif7DIbTLQ5rt5dnjtZ9giz0VzBEvu3iAQlk/dwxJTcdM7BLxFY+jaSGOGdUDPAKfABdQfNIfIDuulGpKs1DveW5jhH4KjeptJVdLDQSJNFNebN4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XZ0+iI9N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XZ0+iI9N"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso57262715e9.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1788213855; x=1788818655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mooxD0aCQesBxEXQA4gtk4sJ8/K9RVjHZXiEh/ZaNBs=;
        b=XZ0+iI9NAWN32orderSIy99yITVWDYuFfyOfa5LOl6fAlyjia9MhoLMZf5wsA8+iAh
         CgPM8HusxHbzAE5ZWxu6zijw4VZFiSLm5TDGPsR0ZxZ1QKj2s750uLlpSs/8KH1FRZfA
         XZHEvSb7ODEGTayrDuh0FvGUl60dw75DSzIfxqpl31EQFSvIXSc6WJOj/heFPNSCr1Hj
         vnX+P51PMvmAtf/9BaEGzHDm5f/lVgWAgq5gxLxV47JE+3x11icrRB6V9lxekfMVt2bS
         YT1mkUC07LQ+TwGvlOqk9vwM8S2SkHw+GCyG9IUl5LlXcrRsPBQH5pY/0Gc0dNKXz5oT
         FsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788213855; x=1788818655;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mooxD0aCQesBxEXQA4gtk4sJ8/K9RVjHZXiEh/ZaNBs=;
        b=O+d3pSHcwoW+d8tGi8PDv5ORLNLpyYglhGtOmSNq8ONJX6Cpo/SXsexLUfzSNYap1V
         UYUIVX1M65FtRw3fKLYVGJ5BCtBIkYBOV155oG+tu109ppezMJEQigyMBxKTtAx+ptOm
         XCwYN3v3KXb5EMaf7DHhIIXk6uLjPkJm3kK2GJQYeqtBHbTXA0P0i56UGLDi3VzjTsBA
         tmbUbzmqF5g1qfeVjdhuCWWgP7Xmidvz6VrT7Y8OPs2hJ9PhTjHQrmhuneNEwudMts73
         cQnIqgur7/Tib+4kxNnQPO5xDcRNNuJdI8HJeD3mKHDhMdIGLdyyEOhZ+Cu6deNhTGdS
         s1XQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrl8pw7Hgi7+tnh15MZlB0e4fPtW26N5nb1DgsaGmnK8bD6UrDmS2OjfQKnlsVhnIDjhkUAYRk=@vger.kernel.org
X-Gm-Message-State: AFuF++mk40p4ETKVRKiPDywt5TF5S5HBqNeX+kr8DpLevRO+t8Jc/2od
	6XWnBsU4iy1LTs6V8azVCy8mLMz8WhwChFi/EM2uwL3UdLDs+ASPO+w=
X-Gm-Gg: AR+sD10B2LsvhTw9emXuwbng64tKQ4Z4waWUUyNF9T4LyatIFwdi1R1sCDa2QDMnRwy
	wAT0+bM+4FCnhp7Gr2nP1a5ntEndPtGxSzrDO309u66xPDJc9TvuZp5byxK7j9VvU2SDKw3ADUC
	UOklW5LMFW9DcMMTLERHl2ubPJifuU5nk0JcOqx9tTZDYgNyQ+BBbCHUWkhzGuOc8KcKQQBjqoQ
	ODnFUCo/LQSuKvSUkExjExB3Ej2PdKsP+WQvb1PCwXKHkvk2z5zn9874ysBLOJRHJBEobrFmjis
	3oDZM49ijXPsaJXkgrJyiAb56gJkA9VMFc9YPgpPyaRlDGtg3gsKjPb5Z+8Swku5MEKSqmV4NcC
	dQGnSL1oEgxgfZYpCBOuU4cXEVK/qw1yIiKW0Vay2mvPeGlsuLm+bbv6In20vxJqHTLzMDy9Xv6
	Ss/qWUVpcuhDNcgfncfDeeI5slzEmwYzL+pd3byWvd2s/T5Wlr61F7o1Sfux3nHvYzTqXWM8jvR
	jOC1AYnVA2GszxHd9pYf52a7qcRGowxtZthNxq63FVKIpy+Cw==
X-Received: by 2002:a05:600c:6207:b0:49c:d28f:2cd6 with SMTP id 5b1f17b1804b1-49cd28f2e19mr272370085e9.12.1788213854790;
        Mon, 31 Aug 2026 15:04:14 -0700 (PDT)
Received: from [192.168.1.3] (p5b057bfe.dip0.t-ipconnect.de. [91.5.123.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce08862sm21966125e9.1.2026.08.31.15.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 15:04:14 -0700 (PDT)
Message-ID: <8bbc48ab-d0bc-4deb-9018-d8c22abfcb85@googlemail.com>
Date: Tue, 1 Sep 2026 00:04:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/99] 6.12.108-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260831133359.740409777@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260831133359.740409777@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.08.2026 um 15:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.108 release.
> There are 99 patches in this series, all will be posted as a response
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
