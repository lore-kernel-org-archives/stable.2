Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680775;
	b=hNwg7D/duFhFiNzSkhk5y5dQSqXmK9knQ/gUdpi67kpn+QD+mbQoOWx5dwnDlg1vnCqQ
	 38Wk5NETit/YnaX+45NuXRhAI2lrVHo0irvAC81rVdEjgKV1C+n9IoIIAgtDPIPvrROff
	 IuoKRvn7X/mYVhY5sxQV3JJUchr1UEjs8jYmu24cG71jQX7oy0Iq6yUccK5jLYerxLaXx
	 oYp4Xop63aEyLwKEOdQGhH33pzHGNSn9SHnAc0TTzKaipoAXOWc7FyFZP8kv54n6AORX7
	 gDHLMZbAEwSm2lQ9nVd+PFmdyQyEABuCy5kKpWDhRiewXQGvVgI9UU6PKs3TIbuZLKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HF1NIA9YcotgBX4Xrtg69ziwH7IW313XtsQmHrwnOgM=;
	b=v0yZH1Dj9eaJayKgeaUIxRpcJLh/e7LM23ZrdqGDL45o2a/l/g7hFcd6S5KptEvUOnkW
	 LuRC4EGxjWPqxwJzWODKhwGkToDODjXNGGUQJL9Ohgl0RyKcQcAxybvfJ0onAlVAR+zYi
	 ei6mB2i4oeZcVkeoO5aL/F8HkPzmNQcBsZcov1gZxkoRrZ24OU2yqBppnMf4icHPa8ebr
	 M0YoJKM5HGd9R/aR0XSwxqEbYsMvXBx1FxSU0PRPaDSnG2zc8HhhuRsWmCcGqhoGLRuCM
	 pB8vPqMRKiGW1enmzdtI6m1UbsR6vrJJC1lDW9Uhb/DLv8cUm7D4KEkP4BUZRjX9tkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=aZ1IqDN0;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532E606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5532E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=aZ1IqDN0
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so3913165f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 00:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795680774; x=1796285574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HF1NIA9YcotgBX4Xrtg69ziwH7IW313XtsQmHrwnOgM=;
        b=aZ1IqDN0uIoiNuSSBMl0X5B84fRbreqaiDS9uA4+WP+o0Xcd3JThKU1wp836YnIoJR
         01rv3lMRMX6EHqkPhVfOzzPBXDZ2YS2Rrr8ORRGAHYNmWnhwS85mvyNr7uufeWswoEVz
         AKxIcSni0Y9XVcqixFP8C1vwcJXmqspKGWzCrzI8uJsYLNl2ppYy/MNrbD903GepnKrm
         cph6sclytv9c3mh0/NZzD98MviAQbuRFVcqgPQmqQWVhMoKwrKErrhXK17rk39Ajwlgp
         0Sf2iS4IpC5LB+/GcjoiMc+Pn+Mq0RHAAaeO69u4t3oJVuFd6VtkKOUPCD+Mf+pHxzJG
         LzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680774; x=1796285574;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HF1NIA9YcotgBX4Xrtg69ziwH7IW313XtsQmHrwnOgM=;
        b=H5M5EXXEd1b7FD5fZTcyAH99J9uy6QUTBOhBGDCjjCVZI1IxCj1QpywIyugyJUVxre
         Fk2HOlGvW1kkM0tSy+q8ZemXAX3gV24Z3t1kzvFWFIt3IRyjyK+Rf3yUe8iEcjX4zswJ
         D9fasH9i+/WuzDLl0ciKltIE1Qih1HZS9vWfHaXEYeB25+Ar8UvQ3mJVUKPMGrIcACYW
         tPB8L7lxipNcrQZ2e7pij+Z6CM6MIbfd3TS4NzWKPNMB+neoI7MTIa2pGHwQBVKCw4zT
         OWyUiwPD71MT69jXPExhu+Cd/00Z1D1P1MIyA94dhnqloBNmwCNBiaSVCWmZHb9M5ckC
         f7AQ==
X-Forwarded-Encrypted: i=1; AL+hErFfnHYGIYz/KBap3l3MKZXIMOgrxECefjxeTD9C5Np6AyZCfkpw9jJR/P/J4Ey2K+cNWtBfgX4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xIKW+E7erA+BbV9lx8sg+br1JTOQQO5j+9imRq2Q9q/BY+4cx
	utXBoA9tfbjYBPYSnZn2UKXhXOBvWg6VfdU/OlLr3lpdZlRXyS9eerNxt1b8
X-Gm-Gg: AZFdTZfZLMk8DEiqryQmUYpSRRyJ9/92+xizT/tcmKKUYvYRiv8YX2VIsHbMxvwMa5i
	HTeBBmpaDn/jik2KIwXWmgfBvG+vvMmDYGSaytQAh3H71wdjBDZSC6qTFCem64/+YrcmungGeW5
	MV1/WLSbTnu9XK/W6W7ZNKFxshYpJDV4LjLbE4uNb+sGip9MnDYU7Z814G5zIKQuhKBSLYDuZPe
	I4jyqfCGeT/hABnyTFL7OqyJc/zByI4mT2ker7xcWT16DQhuM5l2eHfpLPWDtVaGdZi8Dvpy9CA
	DM3yRZ0SRZpuEgVMuuPHO+LB08WTO8wwChakP0zzIRXV3dxFxplaEHshNoBL+tMnjmMl8tVXAk4
	qyvIsDoTvFoxC1FeAkYIQ+ADR4OtwM0loLxW0yW8mCeSLDr31AsBWsvDLZhuKf940qztsosrqkV
	jsqnQWfge2Y06/BlF2HmvjQuVktc6bAuaxUVJRfMRe/exJFFRPzm6sQdQ2zCtUrS0ssfxlmHy+r
	ZJJr1tqP425XVjFb+dmQTeyyIHee/c94mm/graStC0nolX9O+WKchen33CNaQOSF5/ltdnuN/D4
	Sibu7on2khQoDHW55odIu9GTx5KdcddocVEBXQcFCxDRhK9B4bpochi71CCzOCyhXFWMR7isvHy
	BDEG0
X-Received: by 2002:a05:6000:420b:b0:4a7:518f:bec2 with SMTP id ffacd0b85a97d-4abb2ce47d7mr40551231f8f.28.1795680773406;
        Thu, 26 Nov 2026 00:12:53 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac210.dip0.t-ipconnect.de. [91.42.194.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm36790497f8f.22.2026.11.26.00.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 00:12:53 -0800 (PST)
Message-ID: <db3d4f41-d0c3-44f7-b601-770031fcda5c@googlemail.com>
Date: Thu, 26 Nov 2026 09:12:52 +0100
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
Subject: Re: [PATCH 6.12 000/816] 6.12.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261125143849.205329330@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261125143849.205329330@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.11.2026 um 15:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.120 release.
> There are 816 patches in this series, all will be posted as a response
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
