Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478136;
	b=IM46D/8RIgkguqJR9iAnFIpnG18O0Vb9fhETh/lq2dzAHWYhkN5xYuRapMOBngd+7txi
	 5QSmK0tgxv5Z4VF7Ggr+Cj6bNCB0nYcpXcumvoZQwb6hm8hY1m2JV5EkhK6gL3sg3729j
	 0gia1HWS2EKZn2yD34e70q7lYB2MJZKKbm8yaAje6+DAvcfbtiigsLvqzmb8qsB/ZeVf0
	 XGtuaDTsx4ahhBwqtOUSoDZZHQ0ggAtde/1zz4hEBpkV2ziC55RwOmPdxbDyoOzfXrgPY
	 JNuTNT+cLfmjTldcMIMUXYTMvpVsMrGDjvI/wxiRTf/qYWDQ/iIiFqVWpHaFKVkFdSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=IahaQWnW2L3d2rI5uNi4is2Ap/AkkkuOCkd2M+75oU0=;
	b=ttvD6Ld9PXIh+OGbWN3vYuprw6Xb+6fbK08VwX4BSrsp4wKvYlVodWmUyB2Mka7g8dtw
	 uyb9qLy8Ks+wkKr33k5+uZgWGRE2gh4wyJ3pfTt/zqH7T3/8reIyK5XiESqLP62lr/Ev6
	 Xcyx+vnvlJ8UUqx7++ccwvWR3YpMZNHPOEt62/NVgmi5Q6ULWsVrpy3QTJf2d+19D54+X
	 peLamCF5KHciXFnOu9XQzvkekprQnHyHVddEJJGcYl7ROho6MuGkCeb7yecjSSgQMDwvK
	 MsDqmH63BA5QNVLsXvOkGUPJgzJpJ3RYVC1or/KLynQGdmwAnMsefy6oAHPq7O0Kxbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P7BNzbql;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD3606A334
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BCD3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P7BNzbql
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so48017005e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478135; x=1795082935; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IahaQWnW2L3d2rI5uNi4is2Ap/AkkkuOCkd2M+75oU0=;
        b=P7BNzbqlel+Im07I4ouOc191Y1OxCsDaPnWxNXwbbWO3MeDCBhfLunRmAP88K560Y7
         D8k3kxGbhBmmDloc5oYxXIGTC7V+BIdkWyBVXBiDhQpF6gLaEGjoer0OhfNVKM6md0Yl
         rtc6B4f+NZC/FoDYXvKu0B6aT1ipwWOWta3cZcupb2KRg6TtCyy2Kp6Lca/j89UXo53C
         gpIdTSZju9hBrIRs8d6T73+35AMRGUxAf4iX9QRma5KlC2TQSLFGYobjHHkQCDZNkn3u
         wXQyIaaRHrmPJZzS25QvnId8BtHhJe34WQMBGQKn+pWmoohLEq1Qc0o6aqwM8x2h/Zj7
         KZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478135; x=1795082935;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IahaQWnW2L3d2rI5uNi4is2Ap/AkkkuOCkd2M+75oU0=;
        b=S5ODQSG8hTrReayEIz4EMjwYY1aPgUBZwW6Zk4CpJHOfimliZb2a2JhcdKITL8078O
         3isRHx8ySpEWDIbFv/4/pfEUcxVIzdQsojmN0k02CnPNPKHzfCZwIFesFB2Ix+sdsLho
         V9quFFVmvt6xD0/qoolFvUz53eVRVzDI25IvD7Lv49bv4GAj8XoJ4uS1cIiwN2cMTyob
         bMaZJKUJOxdjYuA2gWkrdvwgxEPpzqSC06MGYwYEPcv+lgf8j8tFj1E4oXSIfUbOLoIB
         3Rx1YiAKexHXey73zDcy8oYNWx4D3r78Fwh8xhHwf0RTCLMa2jZXQooZBtzATnEUP8WP
         zljA==
X-Forwarded-Encrypted: i=1; AL+hErEURdeeVbdFvQlNomFGLFc4I7S1DK/1dacNM+kcCifVIbPY8CCgYiYKYKVE4hxGRA8Me/cv4M4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8z0uMQiMsV5YoxlAIUgLdwdAAWzgJZJnVPOlkHhMcgHGVWnbQD
	jMvkDJr3GrUz3GPgTZvuaTYmF0uSBqYMn8I0xg988B0WCQ23s3sH94+4
X-Gm-Gg: AYBFou1SijTO083fyHdAAAADJOuL68Dqt5ucuEV3nUj/qVEdxg2xBxvIAj+puENmwVB
	WeCoFuiTMY+KaZt/a5DRcWKHcSJWKRF6bJ6/NLynpOu8szB+MboVPXbLmqnxEJz9L6lRafQfDrc
	gs2sE5q+1jL4kq/PzX8bR/dHMLLpM8r9GOy4agwAroTN/kX5Ssy75CdioRHcvVPSlS2aSZrQLP3
	6HWWsQPCvKn/2fnh8IXPgPuzztaE5+FFYS77OEMT7X3LKq3LRiI71WnNjWzAIx7L8fxuVrsgcoj
	bar31pWZDO+TK0IVENOUjnfrvvHw+5UVfIzD31uZzFQUERuPMQg4A+KR+hOE/AshJ7MiIHUSYzK
	0RKUfQp+hHFrBdZ85PNgW01QoDybsGow08Vf3xcTyrrSeXD5YUAqvGeK/AdOS7+aWk5g0Uuvlel
	DG0LzrKhuvOm+wStsyHySCXMqbJZz0EPmsgjqQEyupHS4Fh5h94ATM0dh/fenxmNDMf7PLahxC3
	udIAJCy5cEPpcb28n/2nNHeiy5kKRdTY3m/4P6yh2rZ++3KL23IPdRhqMblyyfEVW909N4kfK7n
	l/qyJpSVRBqDMYwh1x5dZH4OsQV8kVEUymkWBt2JNkBFRzxN0MI=
X-Received: by 2002:a05:600c:8b22:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4ba0938a590mr91246165e9.27.1794478134548;
        Thu, 12 Nov 2026 02:08:54 -0800 (PST)
Received: from smtpclient.apple ([217.111.110.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0953d26asm70701795e9.4.2026.11.12.02.08.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:08:54 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH ipsec 4/7] xfrm: prevent AES-GCM nonce reuse after early
 GSO
From: Usman Malik <usmalik90@gmail.com>
In-Reply-To: <20260930144523.435271-6-Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 12 Nov 2026 11:08:43 +0100
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Sabrina Dubroca <sd@queasysnail.net>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>,
 netdev@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F06270EF-7648-4E76-811F-C607A8390835@gmail.com>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-6-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Wed, 30 Sep 2026 14:45:21 +0000, Jeremy Jean wrote:
> In the software ESP offload path, xfrm_output_gso() leaves its segments
> sharing a secpath extension. Each segment gets its own ESP sequence
> number, but stores it in the same xo->seq field for IV generation.

Tested this patch as posted (patchwork 14858684) on v7.3 against the
same build without it. Both kernels carry patch 1/7 of this series
and no other patch of it, plus my "xfrm: use software GSO for inner
tunnels without crypto offload" v1, which does not change the
tunnel-mode path and moves the transport-mode case onto it. The test
ran in a VM with two network namespaces on a veth, TCP through an
ip6tnl tunnel over an rfc4106(gcm(aes)) SA, esp6_offload loaded, a
tbf qdisc on the egress veth that queues the segments, 3 MB per run
and 3 runs per case. The sender capture was decrypted with the SA
keys.

Without this patch every queued run reused IV values, 92, 51 and 51
per run over a tunnel-mode SA and 50, 51 and 50 over a transport-mode
SA, each shared by up to 7 segments of one GSO packet, with ct1 XOR
ct2 equal to pt1 XOR pt2 for one pair under each value. With this
patch, 0 in all 6 runs. A kernel with 1/7 alone gave 50, 50 and 51
over the tunnel-mode SA. Without the qdisc every run was 0 on every
kernel.

Tested-by: Usman Malik <usmanmalik@engineer.com>

