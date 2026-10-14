Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851751C049
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989646; cv=none; b=BBoij5f/bErxB9YZmCb2D8zUPi6mWhnBbJcHWepdZ2iT5BvpD5QlKKDSMME3TGNCsiT8ueM+7ZiOfw1yKoI5oxXIyuP3Liapz2bmo7h0mDkwL3S/3JdU/vlKYNl7AhgaKcvFgmg+xPBiaOvw8Avz+/ZSe9UQKDwXjoA30wqBADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989646; c=relaxed/simple;
	bh=jXQ1ok6/4ySngbdOAAmTV4VGfVoNwaS9vIa9Gwf57h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuOFKU1CJWHbIX2eRPO/qeXE9LAGkMxAqLe8uki2vOQ1vZa3RbKi1cNzVHJzt2Rkn4onhBbM1JAagFD5I2vjZQYqbGv5jLMGVf0g0KLAR5ytcCdajY6UBQuo5/jKtV2+QGFsB5y1zPbyTcn4iaRN6d4yoXGp7JE8YhWJx20E5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyqKc3Iv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyqKc3Iv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df160bb9cso21648f8f.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791989639; x=1792594439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysEXf6P+RoEe/ZMsN84LXJemZvSuyVskDydvilx9tig=;
        b=gyqKc3Iv6tne83uTYZEG812otEaNlC+tFXGwibVc7MCNVXzE61BZvaPzeqUmzrpEIy
         cNmvXNCWETV2dFWZmqQQT9MUkFfslMAsDo36un1qOR9Qe2YI7fo0bVt7nbU/7jtxJgK3
         uoaRdIn/JNt3t+PHM1TZUChJ4jdxENKFmp+CtuA2Zi3WBzUlqFX2rbZnDjYH/Ergm1dg
         fQ6d6++xxb6l2PrRYyG8u+O+hvDoqUvQkR2V82UvwXi48sm80Bfoo8/v1X2HsOFosHvC
         gyxTtAbrPppYC9vSbDAQaFs7xMekcQJsSUOdvXom865kvbqKI4sA6fmC+a7Znk7cMZOm
         /6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791989639; x=1792594439;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ysEXf6P+RoEe/ZMsN84LXJemZvSuyVskDydvilx9tig=;
        b=I2lLz4TxTpj8w8Ifo5nxF+JZPx/3Dx1ThZtNye4VWvrQzkICTKvDRU1WLUhI10jVwm
         6aA6uTBcM7nXwN868PLSYb/SLOSNd5OD38120YCfxPZAWDjdxhDcTi9plQfFTouvBN/f
         DkFakDo3ZWSDJUT1SEyIn6ZT9wbsjKJUnuArWLCrI721Wy53eQRbvFNCwR5Udv0tQv3i
         ovIyzwI3lsPVKCSCQ1uS5GiUporPpM14yAsgoCITCaMpxb6I7OAnMJS9PmLbNnoiMRkB
         F73cQX/PQB3tnCx160TULBQIGx6ydIsmtZXA9SLPnHPij+BdUdIv1F7C8Y+H0+oZ199q
         1eeA==
X-Forwarded-Encrypted: i=1; AKwUvBwP538bYniidsMarrpkHMiL+uwu+ytnpXA5jyCLgLOAfuCNBGv2VmPAIuA03mXXiAqYLsPaTR8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1TWW3eQ3uK9uMcRWk4y/+8Yry51rkIPh7EXXvjniFgevnuiO4
	3n7smNlu9jZORfK1QkO7eOpd5S7S2UNiDbdvjcBrZAsNtO7z3P+ie13Z
X-Gm-Gg: AYBFou1lAZ1AK34uu5XayFRqB6dO9PUHK7pxKDKf8pftEbiJsUZGw2icCHe6iVwGAuu
	OS75i/OCm8BkvQ6XhgX5C/32+TByYWICLl5XyEZBwv0n3EW6RD8CHfq1ydoRpk784+iFPNTL0xU
	I9STnM/719R9GcC5ZzQ275U4ryMEvvIGbPSERY/vvJnn2ZDkCJdhviq/dy4V0xIc5FXLnLSY5Qo
	0/auThl4tgkKDOFvVEy3Nek149t9QRDYNOtmIAoCI0V3J4/TqYUHsCzLqH7rTeRXoI6uWQHJBvb
	sgXQ9nCLUghZCcXOua+a3CMvoE3+rLmh1jO0dGaWIiE5ukO0JS4cXuv8YYy1YSA10/sCFVeqs8p
	W9oIWCeHLAMv3atPSuPvCwcirzOHKJxYMToXmtvxyu/qrH02YaU4ugnQa77p/Xdff4Z+phx3NSN
	Ei0Eo7aE+UhGkkuhCaWQXAGaDKWD6zzqnZSWKIHJfL+evA16B67PrAQq6ZJ7+brycy1iQWGwfr4
	Xu8h5d/QT6sSEnJc2CF/7+T1lpn4d9RG0OvAoxRhQWN986JBAjxcCNkYNY2ZMA6sdbLuMxW6+WI
	QJ9z/LjbfAVThpQCwnVBj2pZDFTjmF0A+s1hV0QFxxzhN+/cMD2cEPLR5gQqzU8ODL1y6zc4SJx
	zNzX8xcqkXC1KDFrfkCfN
X-Received: by 2002:a05:600c:6285:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4a18e4760demr324921595e9.1.1791989638272;
        Wed, 14 Oct 2026 07:53:58 -0700 (PDT)
Received: from ?IPV6:2a02:3100:5ad1:60fc:7c7a:4c9b:4d41:afaf? (dynamic-2a02-3100-5ad1-60fc-7c7a-4c9b-4d41-afaf.310.pool.telefonica.de. [2a02:3100:5ad1:60fc:7c7a:4c9b:4d41:afaf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b482b3e4sm52818595e9.4.2026.10.14.07.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:53:57 -0700 (PDT)
Message-ID: <e69879b3-5374-4b85-ac97-f21f995b8544@gmail.com>
Date: Wed, 14 Oct 2026 16:53:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 3/4] net: hsr: segment GSO before per-frame
 forwarding
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, liuhangbin@gmail.com,
 stable@vger.kernel.org, sdf.kernel@gmail.com
References: <20261009201324.17-1-xiexinet@gmail.com>
 <20261009201324.17-4-xiexinet@gmail.com>
 <20261014140047.Z8nhXzxa@linutronix.de>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20261014140047.Z8nhXzxa@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> I've been re-reading the old mails. The whole thing is needed for GSO
> when it can not be disabled, right? And VETH interface has been named as
> an example.

Not only. GRO can be disabled, and patch 1 does that. Patch 3 is for
GSO skbs that arrive without any GRO. The case is the one from the
cover letter: a software PRP RedBox on a Linux host, with containers
or VMs on the SAN side and two NICs for the PRP LANs.

  container/netns                  host PRP RedBox
  prp0-peer ---- veth ---- prp0-int (interlink RX)
                                  |
                           split GSO into frames
                                  |
                           sequence number + RCT
                              /          \
                           LAN A        LAN B

When the container sends a large TCP or UDP skb, veth hands it to
prp0-int as one GSO skb. Nothing on that path segments it, and GRO on
prp0-int plays no role. The same happens with virtio or tap. PRP must
give every wire frame its own sequence number and RCT, so patch 3
splits the skb before that. A NIC with GRO_HW that cannot be switched
off is the second case. Local traffic from the HSR master is handled by
removing the GSO features, so the core segments it before
ndo_start_xmit().

> There was also a bridge device. With HSR you form a ring. With a bridge
> you attach other (physical) devices within the ring. This does not sound
> like real life use-case. Do I miss something?

The bridge only came up in the v6 discussion as a comparison: when a
bridge forwards a GSO skb to a physical port, the TX path segments it,
but it cannot add a PRP RCT and sequence number to each segment. We do
not use a bridge inside the ring.

-- 
Xin
