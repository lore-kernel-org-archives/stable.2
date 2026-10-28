Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203069;
	b=GmyR8TN/XimvXhoNGDRrHdLVK23cgdzVtpVMt5GrnWdmqhfDoG8mZjrekiPShVYv4LVh
	 N49jm6447na/cnrFY1eNDMxAr1lsRUxPahDS1Zwk9pVwj/TKRwViqXBRnCD2bK3BRtnsu
	 fTvZHxU+9vqnkvzrYDgwgKUzAkjVfau0cnz70sxecszavLDDvkHaL631ZXXyg3GbuwrKI
	 qBW5qTok78W0pvNchJY0YhiavZi9N8ZKRH9BtHcJld0TDMJghoJOyYUVJJ5VG2nKcrrRe
	 LUvRzd/yuUTOIp4FcSE4KC0f9RAV9TVD0V2PCcYcggsUAbyLAmwqY1mJPxxXxJht9bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bIUJn5v0noI0Ozp78hAN6qBHnECEjw+ZHdq5PwPXe6o=;
	b=VACncQLWIRjRZkohyh1CJS0MmANk2wHeC7RpMexX02W3EUTyL/oMjtroXTM6vAvmXc8s
	 A7f3arDNmKYVL86wzMXGE8KxEJyMb0b4RZlmVswFUZsU/+xTNUsNEZdpUXzu1+212e2i2
	 uP35k7MEuAv2ykPFYlemK8Lyl/XMVtjNjG9/h3tQ8JOA9Lf4vDMJT/TiVNxOwmftx43gY
	 KqpBAFndy2/itZqEfytwkn/HXFpD+UIzQl0TTkP2E7+GMvRx5e0KF+z7gLhQIiLSA1ll+
	 yRiKHo5rb6hdNjLptCZQWMuwvPwk2PeSfu+mmvN9/WgE++gNVzwhn/vaKY51sU5aaFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljK0kzZc;
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA589606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA589606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljK0kzZc
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cd65a511e43so613725a12.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793203068; x=1793807868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bIUJn5v0noI0Ozp78hAN6qBHnECEjw+ZHdq5PwPXe6o=;
        b=ljK0kzZc7OIyosJ7wtQFMgv9t4jBsM6ffPauulC3pXY1M7Uo3sQTlPAIuHZE7gbyFf
         bun0E+OttUZck8IKPE01oLJeHGP3SE8CLliMRa6yeodozKQT7iCBpdvryQnmRj02EJg3
         fd3PT3KSgpTCNaQLcTHP0p1S5CaUrDkmepEOB0R5PgcoebLDwOibI/e+A4t3fgi+7BBX
         I67SoJI+UC4wqpLQUVgGqiTHXvwUbDA8yckRpISy54uZHbl//QLdfgtU4HDqnK8Po73b
         ylXpIfIj5ezA1aObz8m3IFxxn7n5AJ6pJd8UgGKsizsN7jApUGTCiGNqk18t0eUD8GkP
         LnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203068; x=1793807868;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIUJn5v0noI0Ozp78hAN6qBHnECEjw+ZHdq5PwPXe6o=;
        b=rowO8pdnXCosqFoe94TNq2m7kBhAzm5Bp/K6fpWEEirKuz6qYVHbBVKfuKqpMrD01t
         4OcBx8R6aILacrwcwtpyqC6sXKFQ+8R8NOBEV8r95QWhCj6nxxMwedjac683FLWHEr9b
         d4A1SeoY4nD1plvBJmSCcILENCVLlihInFdrmfEcpgFiNSKs2RmLxX0U/jjWAN5Keubr
         RjMlgmIek/izsaHLPpS8n+4fly+xjIWyi9hNFpSPw0NAJz5oYX9lR6DSj9qptVHlkzOq
         ab1LiBW8sY1x9WYp1l1AL46vjQD5XEjO67qYlQIo6TJeVXbxsj/Ao+cAZrxpJ8m25u+3
         jFNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkyxS/Fuz32bo/+SzICZczeItODinVWKpGaI5h+jedSuj1qT8r09Sd8sfWuUWsjtjX6Q9jCw8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8pTy4Jc54NdA1TG0LUQRZcjtirp/Liwd0dtsltuZUSDlpltDL
	wprZXWiBJ3c+yYcB+5bXea4xio6FxmDJ0njyk6/OfdK+OS0IhzNoIjpo
X-Gm-Gg: AYBFou3SIBZa9qt8BbMmc4YTyvAmii8oDym1MOVdGAyEbyTv73EBF1OSz38VzU0pHmP
	Qb0btsdDFP7AVjgfxJpP+WgjNBGCGBDQeFJyn+kVbD3ejohxiCSta71+VSMTCsveSn7g7l0Sq9r
	kCrwp81LtqU9BmNlBQbhg1Lz1mpxSA7bz/I2wsevxz44f41xItv4vUpJiwSn4hry0kwmb21EH+Y
	FEb8Ejya525Gj4HFECjnXf5zTcWvKTy2AH+7A22glaofWYEUHU6m6FEtls88zzRFdQpocBL7lbj
	WWgNkN0hvHaeK2Dh9NsomsrfUCGKG3ohV8hWmFCgkw1a6nmx8Wvy40gx+CHf0K0JLrAYgv+cSMc
	irMZUUWszpIix4AovK3H4CJ90uAuE4jzOXaRm11V8XasD9ZPjn4kod8GKtgFYaXhmzIO5SaLyUA
	vXHbCQv81Ase/x3iZSKbLZGKuo342/9dPwlv3YNOENxgU6TMcCDh6pvqlcKc8YVjCcNIV7Btcff
	KYcs9ObWJ/R13f/gXCwkPk0n2vkK7L4XetyJJKkqDwqkoSzKODABxj1LECuDaAEhPXdErHRu+zN
	YSR3HPn0U0cFDXQvcVotyZM=
X-Received: by 2002:a05:6a00:181e:b0:89d:e6e2:b2a6 with SMTP id d2e1a72fcca58-8a6e7bc7a49mr2518493b3a.45.1793203068030;
        Wed, 28 Oct 2026 08:57:48 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:69::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a5f66bcesm1390538b3a.15.2026.10.28.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:57:47 -0700 (PDT)
Date: Wed, 28 Oct 2026 08:57:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] xsk: defer software checksum until the skb is
 complete
Message-ID: <auIbb0qeWoJ_eKw0@devvm16445.scu0.facebook.com>
References: <20261028025026.11401-1-testwrzwrz@gmail.com>
 <20261028025026.11401-2-testwrzwrz@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028025026.11401-2-testwrzwrz@gmail.com>

On 10/28, Rongzheng Wang wrote:
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
> 
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
> 
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
> 
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
