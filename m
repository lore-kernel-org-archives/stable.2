Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313083E95A4
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793723; cv=none; b=ZYjgNFA1B/B4nseMMxHUpPh38u0iJELcm3NM7Mt5FVXGXI0ogZj0oJRcl99HnZ3tyFzPdgjUI7VXVAmwx4/RU14+sA/cmfirNNI8lOa1D3xoaprTRVeXWIJFaEiOAijX0cgvQogGMoHmnJH9pZnwtcAauFAUP0/DRvp9RyWrU0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793723; c=relaxed/simple;
	bh=FvV2KSiP4aydCDWgpncY3EngVAUWRaSxMKfVCwZE6y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skuKlVxLEt2pKTllGtHmlz9Fr5lZ2Zj/aX23ntCfomL8vgaGFK8rpuIiS66jbYf1IN7ke7Ykqz/88J6GRBmqV9TKMXVHEV0dnBtvur377CRL1i1McBTuZYCtKXdML5ifyMj7MRohn1tO1h8SGK7nvzl8IvQ44C0Pt/VlwC4AXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=O4UYfJ1F; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="O4UYfJ1F"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47640541585so170241f8f.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784793720; x=1785398520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcVf5qvDyeNebb3WLMp3AnEJvvfycKVazF77NxY9kOU=;
        b=O4UYfJ1FqIjD6Ukq4bXQITT2IxxDJOwb4+g0gGPFrsff8jImiUHZVN2/gDmg0XeIIu
         0cQnb095EOtUrWhiTHbn3Jp7F25f3K3/EPmapxs1On+q6BGjkTGIgRN5EqfvAJYuF5Su
         k/X1IwINGbGi4NjBB9Qs4Eenq4wqvL3eWc56VYQQrnjNXvJvPX3GblJMbOg1yTpnI6Dq
         V1tHIYYJxNpDX/GPl6qtWVOUerS/qkWilDnePhgVWHoGJkb3H9msJxzSTaKX5Mcjqr3l
         iERt3cSpU/B84G3UoPPs5FdwqHOlv3M+DocWSM6pwnFJb1EC4t0QJVD03an+WrCmpNYi
         kyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784793720; x=1785398520;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcVf5qvDyeNebb3WLMp3AnEJvvfycKVazF77NxY9kOU=;
        b=chXHTwNC8VeGuj3H+xGdEgbpgELP9JtFGt8l6K/z1KazI4GjIa87bM34J2gfrPzgkR
         MS7EUBxmFk1erLX00HVmpWEY/Czx8t2DHZ8l4Za7CScMCaVx5GnJrJ6rCx3e6d3bYLEF
         fsKOq1AJmTQqZV877yqCIa1VbcZYWhp4hWrpI5/izEwhf4vevK93htF/pu7Fv6JshPnm
         dCJQc4gaZhL29+KEz9ICJ2IM5NFv1jMwKbs1JPNdi9aBuI5fcR7pWTul99G1eg6pIS+e
         Cs/GBGUD49eHp/vhEHUH4sRccmseaMc6K5RvRRtjecGzrXcg69ujh1z23MTm5s4YDD16
         aDww==
X-Forwarded-Encrypted: i=1; AHgh+RrZWTVqODBEral8XvkqRzU/D+wzdwnAHAr7Bu7AuAOXRmLJuGDOTF144dTxWPJO9ka32Rc8iyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrzjXVBB4Zz0x5VtczXGoPbBwq2yyZgXRg+RJP39Z1b+RipV5V
	0hauIprprAAtCT0ASoa2wkAlI9LhEmdTLEG3/MBdi9ism08coB0OBrU=
X-Gm-Gg: AR+sD10q/Pst/rvOyRcwPhi6qd1BefqBm6A0RMXehWPMFYrcXhT7Y6yBO1ew5Okescm
	ON/OHOxdogXGdmQ1nQCQTIwjdU98R5cQ2wNmZzz9Vdr6lbbvqIMTzl66846F0akN1Yx8F/OoPpQ
	3Jewd/M/KLNrYzD2tOpTkL7d8tDceUAa5lLTHgYBKSVLtjyjVyTR462sky2nQl33fNtUzHIvFQ2
	SoP+2GSpU7wql6bOHoM93KIA7SFdtKWv0dbey9e7oHGAKRaDetL9x27U1BcYZET94F0ePYESRLR
	PeQ5n3JPTddeSnaAUvOAiAwlIbz7vc1/Lm1PNT5MHm5NDU52+3NEukW39VzWvP8HqzJ1NIKzfOv
	5eM4rMrMs+dGR8ulqe57gY9GN6Uik7jdn1bg6UQ0BOD/yOTxS1/rEeBZlnO9P7iDojljiMoP8tS
	P2Ha/R21V5M+UYw2ET0HPHlHKPuLZnINhjnyiTa5hL5Ko4UK7PJDKzY1I=
X-Received: by 2002:a05:6000:4717:b0:47f:9254:d45c with SMTP id ffacd0b85a97d-47f9254d53dmr669618f8f.31.1784793719489;
        Thu, 23 Jul 2026 01:01:59 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acb97.dip0.t-ipconnect.de. [91.42.203.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f864305f5sm12596933f8f.17.2026.07.23.01.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 01:01:59 -0700 (PDT)
Message-ID: <afde8c0f-a03e-4be1-b31d-f507c493e76c@googlemail.com>
Date: Thu, 23 Jul 2026 10:01:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 0000/1202] 6.12.97-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260722142834.868902312@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260722142834.868902312@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.2026 um 16:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.97 release.
> There are 1202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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
