Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674762;
	b=sbyayomBdwk6kO/d4lqdecbijKCg3MNy6S4LvHXjzln1hnzsPLq+r8ZUDiVN4/MVQki9
	 ugz8GvSAOaCc7IBMVP8OWYXEA8MGf27tWX6EUnJrK9zsUEQ38y7gtTt1VqyNV/ohmNHv3
	 6Hkb7dIFoQSQyb2r4P/cR+8InhFzGPDGnm9jO/chgnpW6MmM+o4YGx+cDVRNqwtPbHzea
	 AxqsMCfFKDz1YKsaCAS8cs1DmOvqbbkhG5l7TgpEuSZsHvYzkP/BBKfvigZLx9rWYm891
	 uW6on5yvEXlhF5uBch6l+t23RAZyiHwpZxw/8vVTHDXoYsEAx32/zSp8tMRwymqmD2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RByEtiTC/lcrF+PYQ/coAaO5YWg4gnthMLJRYovYsjs=;
	b=2wVWHnt5iOZxBjhipLnO81p7dr7L1tAAvQBAU2Kkg99ytYfAp8D+URQflXJ7U6cQdVX+
	 WzXiiTbcj4Z4uwikMEVVt9ArAYF3wwavjQeFe/63Fon4mUxkT9P9rr4DYQmeHJKLtKySN
	 G5flmNul6oFYrshUhlhln5MdO3glm3oOuu6UmY2jkC6ve/PrKLerC50PxlPI1rcwo5Iyr
	 ymB/VZS+pkbdyyd9q/k+yRnuUNf6JHrTqnNnsRMvBDT3b+DQ4MvweN1xHqszp2fRaIK/z
	 YQ+RmUcjWWdOorC7xaUjI1OqSc5XAfSkOVe1RN0XS63Y/gk23zDfRFpHXMI3PujhcAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Cbxcdnqy;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A23606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34A23606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Cbxcdnqy
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso11978275e9.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794674760; x=1795279560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RByEtiTC/lcrF+PYQ/coAaO5YWg4gnthMLJRYovYsjs=;
        b=Cbxcdnqycu3CSSKd3j9AJ5uG63AY8wYfqmnRP+qdHPUguRQ+2TSevx+U0qieiWUUHE
         DlqEHqG8HOR4PHQVsrasg9AWi+Iy8BGpsfUe0JWkilN3KL7DFNp4OjmQ36B5pVbtegvg
         fDlX2gEMq77gz1N2TgQOxfgTKiVisTDAf+fDYuJD/bNlq6xrCCdCeEW3zGwX6uTHiJxL
         4rsc8jklNG/lcBBqF8rWfP4FLgBe0lHaKvKimdwAsNN5XAswkDW2jbin/kJuNyNePM+H
         Hgo4tzFCs92EVGXq3fDOKWjMMX/cSJSa4f7AyOewXhtYD03TnFoLLK0BzQxvz+YE1qsJ
         x/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674760; x=1795279560;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RByEtiTC/lcrF+PYQ/coAaO5YWg4gnthMLJRYovYsjs=;
        b=a5PkqjNJLL6o0/V1uc7954R7Y2EH0PMsuk7ZmivY/WQ4umGRpBRTy/eSsHGum1pyjs
         C29pyiZj4dIMfVzKcRkZLyx66O2s/NvIjA9GQYrqYUohmilnp3L3NV4eidJZwJVkpyjl
         abUsUkyZMoGz9ULTw+PfR/e3FbiL7cOVbLJECr3Lk5BSaNUy3+IwUbY9eDDa9NH35DXH
         XpCCcrcHiXVPfDx1mp2jBS2cxzmygaKbMWEHW4HP0Wg2y0BclBXB4OH2lPP22X3EwVd6
         I25zWykogBf+TWQvP1iwkcseh62BpnenX4uCfWQYe7dpykWz/TUXIXYgQ1vgiyIEH0L0
         fKiA==
X-Forwarded-Encrypted: i=1; AL+hErERnZmHEEFt+MqUGtxgCYhoeI+XsBDg7Bj03EqfYmf8WknWYCcQSJASyr7kcbjgRKE4Q1pmBx0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DEZ3mXivSt9Z8umdqnZ6V8r4AI1gl7yzRyDZQcLvZobUk7etO
	twURjwpde0ZS8rzdjlDcksEkblISi04z6wfRlwB+5gtH0K+ecUAS8Aw=
X-Gm-Gg: AYBFou0OIyyHTQM3mVp9Dnx76RZACy5iNByBSc6mpVVU8hod/pyDDjNPQancrbRzo2J
	tLOKYcVE98NjYV6TMNB2cNztJPnAevHiVaKP4h1l6Aa7aXRKOq6mJHmILhfwM2CHWib4d9TpPXc
	R19gfCguxFNyFyYArY77tXYIxZM2hW4EahaMfn/USew/Cxk8ovSHUJOpZY1NdZICb05ObYFZRR3
	+byu5aQc44k0NB0PV3sHrBX7GDED3XIdbtu0qtho52xAyqUE+FrgoLyfL/deoRBy6tqZK4phczJ
	mh4TLn3b9MgDrYogSXQr4NHt98WQyyKvyDbAud6nNdQuZyveeeC+IZjiX7l64bEiOEP4voEglGK
	0pUi0wDSoon0G1uyBENE+tA8d/Iurbl5sHzoQvN6eeQiCLtYGWDzZsJPQ1A7JOwglI3pNdl2/I6
	7geSrUrLit6hGgCPHmRMvS221hFr2ZJy87+dz/o9t+FazTrpsmVWmIJFz6A8kG3uyYK4x0XBGHU
	g6NqZfCL9G0NppaV69Q0VlIzBv8vnRrsXaIWEsel5SSGj1q2aV0bIenwYY9SmitsqN3WYZ2pM/z
	LU89MHrERDLm6kyL3RbUdJY6NViMep34QwYMmLv4ELaisVFZpJdTkmGIuRNdfMn5wHcpR/+0tZd
	yU+1bxPL+PAsxCxjvaSYv+6QJXLY=
X-Received: by 2002:a05:600c:628c:b0:4ba:6d8:dfad with SMTP id 5b1f17b1804b1-4bb55a6b67fmr136565715e9.14.1794674760452;
        Sat, 14 Nov 2026 08:46:00 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac4c4.dip0.t-ipconnect.de. [91.42.196.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb52bab8bbsm171491635e9.13.2026.11.14.08.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 08:46:00 -0800 (PST)
Message-ID: <848521d2-239f-402f-ba0b-3e0bab7dc18f@googlemail.com>
Date: Sat, 14 Nov 2026 17:45:58 +0100
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
Subject: Re: [PATCH 6.12 000/670] 6.12.118-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261113153811.177190860@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261113153811.177190860@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.11.2026 um 16:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.118 release.
> There are 670 patches in this series, all will be posted as a response
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
