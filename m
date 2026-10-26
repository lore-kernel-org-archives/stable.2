Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980160;
	b=RoyKaUbLLF4uxPGlUEfazfVauhcTiSG1bevcZY3/DTlaEfseLXpljtS5fGIprHL0/bsX
	 YJSwBoNAZYMSpfF4BLUxwtwvSUzfwcZyB14WSIi2Q6n9cahQERoQ4YxdKQO50/jEY8Ii4
	 2Du7QXGeJUSk+5wdjih65TKJE4CZIrtGx7qILM7HU4BRG+GD9RmZIhWklOnB6+SVDIbAS
	 AjoqLAe6/7/QS+msZ38X4jDAQZGyfJf8O2dtRoOTSkKyXvPMVkatCJlfzyMZblt8fC2aY
	 FIjiwG7NjUn3bV4jS/hJcqfF0GEjoHeAGojSoscwaFxfELFmY6siRB8LgBNBO3YJwgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CWTowxTtC6NKjiOQzv6EFS12o6onMf9gLtVaBHmOg1A=;
	b=fuC0+VcdVZxcRqmz+ih9qJ6DNl2qyR+9TdY71hJx15CaTldId4/mRbiOou5/lviaIEXn
	 uWCY2Kn2BSmqorfomb03UO1gkJ2er6ZXfpG2jtUdKxkYKeOKRNao3zTZrj9dgvO+dJ/Dq
	 Nrkc77wJPNbz39nl58rjywdPCkNCXJN10bj8hf8DNFJniZvxREDzUiHlFDeO2EX5lA6XO
	 ZmT9Ncj/x+36wXTPzjttvHom1/uLUCzgXAD46xze09KRDhVBUwUzBL/67a4xDphHATaN/
	 hb3Lc+q4bV1h8YyzvdG9PWA5T5D+rAjDvrVUuu69OkUoAFfGIMahVlOwthaWByva8DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=qW3GY0WC;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE36606A32F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE36606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=qW3GY0WC
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso25487325e9.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 19:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792980158; x=1793584958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWTowxTtC6NKjiOQzv6EFS12o6onMf9gLtVaBHmOg1A=;
        b=qW3GY0WCY2FcVL0TUolPGpiVn3xNun+Z3XBdwKoLcDr/eYqvOU6luSk5JDP+oowxiT
         CIYWA3AJHUH3GCymUtwDb4vHOkqj5HGAf0ZBBPibyjdV2WE5y0TnVyZvAX2kk30nHbwQ
         Vs8WrKd6aSCYli3qd459SFLxea7X0zFf6LRr0VkmEtgBsklo97+X8cePyuc53L75IY+L
         2K51YPrwyL0YWhZcj8PMMt3VWN7meBzGMHS0eVw+1MlkRELv3jlKO2pDKwbHZRYduwEI
         2i1NhQX9j4Agyt1q9H2Ogp+TG0uJopSkIAkryX7eU2nOPy0iV5fI/FCMryIYVcDSyQF+
         N5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792980158; x=1793584958;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWTowxTtC6NKjiOQzv6EFS12o6onMf9gLtVaBHmOg1A=;
        b=hZP3/hOvRAgaWxDGf9wn6yzecBncccpJCyrGKhUkk7X+ZqFLgxbFuVqoFxY3vvEmCW
         /+rZoPQecXLyI3wa52je9Gq20ZyY+e/sOGhj6CmfoEw1ZGwgHp21iyefJV9WhUWPWx37
         rB9gZiygFUSU8lZu3AExMH1EPUJNnyTppxoSr9WaAPrNB6lO/SGXOGn3rdlGoQxMYSL7
         0E0334grwnTcIIV6AU5gs1wZIqPZUZjzzdeaj07Ak+aKNOOcvegF2BtNI/gG5Ek8aqEr
         VrfrQmnbS5JFz7UmYfC5K8Be16XJhUNoKVHfhzT21OMDLn5vjkyKFxl9YoMLZ3e2bAJp
         HRVw==
X-Forwarded-Encrypted: i=1; AKwUvByXxnBhmj4gYhlsIw2s6EI4f30GuJFrFo0yya4qxK4fsLbHjKEOGeHifXVZ/uJ8/1U0IvB2Ppk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUkn4BjyWMPtei5p59K8gn2i7qIz3vOl1loF0jQ1hK9oA4/seh
	77U+NmbyD/m4/gt6ev3oLN6ug9kPrf9XBskfE65eXlY7lbY6sKEGwe0=
X-Gm-Gg: AYBFou3n40qAxml/xnv1q6m+2wjQiATbe+m98muSYDJy7RobT5i+SZ18kZBhnW0L3s/
	vPY4fNcpYNejaEqNmOgUqBMiOV8gF8PkwSue+0HMWRT+4eT/dcN9aafsnySS7YuEeXVFQ3bLPVO
	S2e9ydxGCbkiz9GFOIOULXfzjnl+qwS/Q+ibV0DfDAF8WAubfRs87JCnZrdnlATkqwA5ch6rEJ9
	Wu5e3CzuO/5ZsiAkoBoSbPsvzdZAqhEkZonBdPEroDc9C97CbErpEZjTw1NnnsLzYHuua9W9sAX
	guO5MCp8fg56W1Gm4FfKjoHaJacPuEU1PQN2o8r9LmQ1C575za7RTUMLNApwdaDbXGAvIKXYLQm
	7JDzRy/rj8FOI9aL39UGuPW0BYBpZCGc2LZbgzld80jg0+rirNI6qCbkEY1kkLGJvAAk1Y/iiKe
	ZYm5/9+oOBdzRcZnoFMe5hTqKt1nSFqcPBPhxwTQPnb+YZAqGe3y7Z9kgC8//dj3lzov480GAHm
	Nm/rElX64DF0B+kVwuAsMQydflU7ASznpfJeE6Ic3pD99oQeoOYRLOUpBpqKvsUV9xpe8DeQ5S5
	ShVTXGR1lBH4/PTN6fwQm7fr790sb+A=
X-Received: by 2002:a05:600c:83c7:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4a35aca5824mr91169215e9.21.1792980157627;
        Sun, 25 Oct 2026 19:02:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4af3.dip0.t-ipconnect.de. [91.43.74.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm424543705e9.1.2026.10.25.19.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 19:02:37 -0700 (PDT)
Message-ID: <fa9cc4e2-c9d3-4981-9701-302a8d0f4d8e@googlemail.com>
Date: Mon, 26 Oct 2026 03:02:35 +0100
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
Subject: Re: [PATCH 7.2 000/231] 7.2.13-rc3 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261025125805.309934791@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261025125805.309934791@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.10.2026 um 13:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.13 release.
> There are 231 patches in this series, all will be posted as a response
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
