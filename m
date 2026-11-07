Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067129;
	b=F856G68CfO7E35yQ6KMXcYu8iHs/HsoXSfBoqhgD9zk5bd02Iap713WISOdxuRaMQoGk
	 MLQkd+ww5yJu4Lshr90lU+6GV5wKUxT9QZYjkznE9BJAZEMI577hMEX30K369RLGniTch
	 +M7xYvWqM3k3IS9gWBrM1CxkwjByUF/jPvU7LmhbEXCQ39rg42Wp+mjp4EPbUt0y3QUh+
	 MHTVzBGeAxE8gYBq7Jj7cqyR1GdqQkzYa5cyYXuliPd/IUeFqT4ziLX7LNYsq030fjyjR
	 02YI9b7Y89rwaJf9+9EmV9pl/KhQcGtUyuH+nd31jYZKedqMgbQxmdUSkz8MRXbZRlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8bVkydg8cUTlVFBihjSzL0/TYhvgRpZwbeYZE1sq6Y8=;
	b=Q2Zmp/f5BAE2yMh7mqkhK+aaq02G5p5Qb6oaeKvgptskVKjLLA5Rn1dCb+lmwEII6x0w
	 wMisuKlZ5nV8snhgprjWyeyleosS7tcAg+p/PdTSRXBNR2239z339bzvGQv6tH6zS6PmT
	 OHWyiWdHSliuY4IkpHePODub8v/JATHSUFQBkdVzGOP6WcWYtV6hAzWSQUicNn626TH2B
	 VYWksIIm/iaRo/LUcm9p1id8RrEBrjnx99Ry2EZGfpYAPU4iO7WQCXf1yl95jGLbkHYx8
	 qsRg6gvYbXCs8WHZCXG3RmQociJnSPx60YjO11lWpHCno/7Y2Y0IrMytXRDfoRO+RHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=lvVzSBc8;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155E606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B155E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=lvVzSBc8
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so14918965e9.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794067127; x=1794671927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8bVkydg8cUTlVFBihjSzL0/TYhvgRpZwbeYZE1sq6Y8=;
        b=lvVzSBc8ejzHofWNmcbJejSxVTcWzIas2Cnj8c7L4gy7jbbWzohP28cKV2FuowkgUe
         RRgZqwo/MYl7HUdBhly9eCbzAIMpdlNA3Q+Y7ddosHxQ4co3EYXbEIVTbpKAjHdy3YZA
         +MXf1YUJTDXvJGvNBh6VxYmZjER7fDIjPPpGPlBhmDZBvocKT0dgQbNk8us7Wn1tx0P5
         ZkG9pON7+RvIXG4JSR5498vSpN3FcSB0EguYAciu4vNE87rUoE+lGwVNDGQ7tt+sy8kW
         kz0gOBaLOr52pHzkTiK0BtWq7rXCmN2iU/u6tOnzWaZOWCYQ5bEspASuPktAKfO6hk/Y
         dPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067127; x=1794671927;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bVkydg8cUTlVFBihjSzL0/TYhvgRpZwbeYZE1sq6Y8=;
        b=qK6c4PS1Aa1WloP5dBraiblsWfM0IC1L07zcEodgjko7kAC7JkJiKjvqqKesqVrYrr
         zEnWwDzOnNFCSS7PogIDhvAMwZBgnee/an4Z3KKVygGnC7saE9tSJ1Q2MGWOrZfVeYEa
         ENhFlfBE97T2nDHseZzNtvg5oex3N7Mll+ZGXqG/i8FGLw1geDj78OzUKtugnn2B1BGA
         AyNsROmOnW4x7PSo7steu4v1ukaJMjBaX+lDMHym6IwLHpitVsTpZRm8ZylrJ5Z7rrQJ
         4O2V75veNtY5kDeL/RRJ8psGTzgW17wwxP3GxH8RmOOeA91dlfLMSbLkmumBx3Qf7gr1
         b0Iw==
X-Forwarded-Encrypted: i=1; AKwUvByEahMirtxBOqhAD9i6CqwZs0ZWdxh8gzvk1j5YE7ozm9oqrqGEOGMKdDa/oZAnxlhX+y7v5e0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DBf6x/N6kjXRe6f8gvBN18Cee/Xc5RV41+0RGFrTuKrILjABg
	maxcWBTdRc4xsHOor7TCgTP4riHoyWTCa3GYouYEYrsgee891NMDO8Q=
X-Gm-Gg: AYBFou1bdhceF4J7ToqpjUnLZSeFzwpMbGSOwvZgWAa8WUw9+MZt1Lv1p36pvku/+Vp
	gTwhMOZk02ZX6L1zRheCG+564AMbZ06NyzbnJSblMGXOa+VVLy6IXmsxx88A6AGHi+Fh3HPDxDl
	kCiZ+j7PevhLXU/GcRguWDS9A+2YqY1hBUboW9qNr004twUJWrNaedRr0KY5lhuJnoSY+YoK8ho
	WFi2jWoIsma+RUW4/4fEuredS7reAkJtc6aPhTJ1bqES3z3DWxexz6g8OlbbAyJYqRXDRxKg4N4
	OGiMjVe5O4aGb88+fv1YSdEzL27JSsvvMcz58IQZF3V69+2D19pzIX4ZxoWHur0IILqDF/MkTX2
	ATg30+bwo0b2kn6d7ePckzNjkGUW7uZkP4RvxRS9CDspsW1KSnjnTNQciS6JwaKFF1AjrRh6E+Y
	qlxwvy/P0HsXBVym66jF8PQ4hZWSnQ/HtteeZ1z+pboi5TIf5YaFHKVqFrkOsMyflCNphQwVe4Q
	kitrJ30nCuX6TtAPDh5nMyOljXwp9rPzYUmE9VRS3KMYl0UvRX4cAKvpnxiDQsv3msHH5+50qOT
	Alw4t1k/9IkNHSg0cWjMDw/mA/bzMUUll6rnKI+BxCqIrgcvLI5QrhxUry5K8e8Eoj9kXQRMyUJ
	lctw=
X-Received: by 2002:a05:600c:528f:b0:4a1:de8a:603a with SMTP id 5b1f17b1804b1-4b6de4a7684mr101920815e9.6.1794067126529;
        Sat, 07 Nov 2026 07:58:46 -0800 (PST)
Received: from [192.168.1.3] (p5b2acf48.dip0.t-ipconnect.de. [91.42.207.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3291531sm80634195e9.15.2026.11.07.07.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 07:58:46 -0800 (PST)
Message-ID: <bbf68dc0-8c55-4dcf-b5e9-70d3c31593f5@googlemail.com>
Date: Sat, 7 Nov 2026 16:58:45 +0100
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
Subject: Re: [PATCH 6.12 0000/1536] 6.12.117-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261107134957.653319350@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261107134957.653319350@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.11.2026 um 14:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.117 release.
> There are 1536 patches in this series, all will be posted as a response
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
