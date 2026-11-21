Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795228575;
	b=pJPm3zb+RBdWRqv4iwU+fvleqs3cd9c0oc21F6hMOUavZEIOQ+a4whIumLUislnfRpdn
	 Dks+xsYf/0c3SEe89U538oaOJNY5MfkwUfBg30Y+QhMJC+uSq3vrBttU8yNtl1iPGQqSW
	 P6CoFDBLrqTTM1HLvhlzcW6HRc4YzOvyr77MnbeZM0KM0YxUNm/iwptawK7GoPFhCB0m7
	 Ut8eY5QWoWgUXX/ldqQHLp8TPumqtuIL+nA47wkPHGvINeXQLmia1sirIKAXIsdoQC3RM
	 vIsjEzppfRhwNMfsmtcurAdfJLvruBt2a/g9QAQXNVOMW7QJzT93Ke4KyRlt4yCsJdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795228575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ytKdWC4PKOBa2qHZovVgrsdqwkaFMvswDEZlScEeocU=;
	b=JI1dsVtk15RZiD2aAxixUfBtuWyQ7u/+bS2va2cFfs6lGimnL9pJShDRBmJiSDKAIQ9e
	 TPiQ9ecyFYShwwZJSCQzpKnIXP8FK/kenyYNwyqWDeuxXqSNhWkn6IBBuduwALxfCy8jC
	 E2m5QKQO0ERNnf7tmUjQe3n7E34uk2VKlgK4Nb4LTJqboYQyCxFyD7xK7SKvuuuR2izvf
	 p74bGZBLGIgvNxfcEHZvorCpgZqurXzpa99Gk7ToePsXZFHHTu3SUma0hihuGN0ahTpK0
	 S4/Z9ORGTg0BAz0nGNQxaoROcTPJZSiwKBWMgdG8jktPVPIF6Ph+S9uaz72HHBqw2cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=BpyINFST;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94A606A6B1
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 02:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD94A606A6B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=BpyINFST
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so15455785e9.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795228573; x=1795833373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ytKdWC4PKOBa2qHZovVgrsdqwkaFMvswDEZlScEeocU=;
        b=BpyINFSTO7cEoxrmXDJd1l0wc8dtcZtXl0P9rUOO27H+8VbcgqunK+1rV6k4EkHgAw
         6ELwCFFSyR+8f8UIwpozBHV9ZkIOPgKdk90e8r6dq7N5ZZHuDigHOpdM6ew1ZIrfNeqx
         C/9kWV//0/Irb/xIG5QYuOfOSSFOv19wA4K4BKRnIK67Hr5tI+zXDPt5YtS+jyLU1Rpi
         mEWKj+8cN6BOrqEgc3KUeVnJmvnPyASKFlR0QH5FWubfK0SKdBt5Mf/gIRGkiIDE+XIs
         /oDDjQpF3wmqh5+9KP81fDHdXLiHCeo3w3ji9j+S8gZd3ZLuD73kSRL7T7gl/2tjlvbZ
         tDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795228573; x=1795833373;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ytKdWC4PKOBa2qHZovVgrsdqwkaFMvswDEZlScEeocU=;
        b=Jxe6dOwNgOtHlqbXj27Uu/pR0MSLCrBEhenOO0+P2rJ3J1SSK+OkflT4lCB31Vk2xG
         Bh50VbSBoEKA0HVFPFd/gjoUdo3ScAJ0qQHfK1vH7d6DeKwebPtWofGlune7tR4Xt6I8
         zl2KEh0JpytlzQf2FAjv0NR1n03yO4l9i+z36JzVDYS1tnPjV9lHjqOYAZFX3VGXedT7
         vFvtahLxClKVmX9XQP4nKVFeCjvIy+hd+8Yr5iRCPjr6fTWbP8FR11ucxn/BwdaTf0j/
         42a7JxFepUQZ4Lv2fy/WxY0pBXf/Ar9Ushn+wvIEQZZ6kBrpLGnqbA93LxvdUCfI4uwW
         SR7A==
X-Forwarded-Encrypted: i=1; AL+hErE2qetqNA+9SgUs9/mMrdEcmgxyv1sruaa1EYyABz3LzXWweJqL/f9b0Y68uE0OuoPkeRsT13c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JPodEOBz5eaSwOkSDNLsgAyaBaEty9IigOP09uyOIXUV4mxRH
	1f8ItvgCi1VCtYx1Bi46EqmHy8Z5WVnfl7SfPvWEaP1iAn0z5C7spT0=
X-Gm-Gg: AYBFou0+nKDmpY0jMmPgJ+OHAGz5WOY2tJRkElLnNltb8DwJtULz2bfqah+GFQMaMnQ
	0j/QsHF50lnvDjVE9suIJr2VexdakkCFwEjj/qmc5EDgHtglY+QK/kgmHIrCazYo6ZIMFTbkpGP
	WEjwh+QSuLqs0OoQ9WEjgHNLbxuGZGQF0oLzRbKNWCoeeXikUKs6o3RUJjqWzq2qwGru7lVkkPt
	2aq4HIiW8XsCmtkZNZgIff5WU5cTGsmyo9VCs9e14mEGqb0zjtM/w143pXKGx5nC0BhSdyKZbHC
	lBm4acQmanWhWcTYgd77kk7V/IG5wxyO3qVXnHmNGpmkSF1159f1BHvPpNnOMSzCEU696xLV3cw
	cP04w7ZrejTzzts4BCjRBMncosnh6TJ+4r7OaX8T2IYH6AgNv530M9zFFXkrmD8qQlGrY5w8+wo
	Bn4UkwXktfNAWGsFUvmeQkBtqVVOqTnPfjamH7w5Si0XVfg0Ltu0amyHWvXuwf6rHs/C/Vw6WoW
	TD2beJfYKhAdqZq4iEuX/1kw/lAQEEnXhuZENNyBfrY1meqKbd0GnjvpmX/ut24w98geFuCmwht
	wjDrUKfODRIBWhCg2QxHZ3L1Xp9Hl84VEocC/aVFoQmmD0Rg0x58qRthoGnYeoED8JX/Ptq/2A4
	0qkKfmnn6qHY0tUsyP3KMM41wwA==
X-Received: by 2002:a05:600c:4515:b0:4bb:659c:b8db with SMTP id 5b1f17b1804b1-4bb88813b27mr117200775e9.12.1795228572531;
        Fri, 20 Nov 2026 18:36:12 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac65d.dip0.t-ipconnect.de. [91.42.198.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm106722515e9.0.2026.11.20.18.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 18:36:12 -0800 (PST)
Message-ID: <ff148281-de3c-4ce1-8d8a-86a9299f73cf@googlemail.com>
Date: Sat, 21 Nov 2026 03:36:11 +0100
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
Subject: Re: [PATCH 6.6 0000/3308] 6.6.163-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120055324.975889935@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261120055324.975889935@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.11.2026 um 06:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.163 release.
> There are 3308 patches in this series, all will be posted as a response
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
