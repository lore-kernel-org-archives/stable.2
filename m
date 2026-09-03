Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A14A092A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437632; cv=none; b=YhEPtNX0n1XcKgNPtTQ908l978XjAKataoi6NpwhmchaHQog2I/8IAGwyoFFItNA7J7wEFzTAFqPWKtjB9VndOV35vQGYRdyMfHe7o3nqsqe++4dU5qlHEhzwnvNOc1JiPzSmjOhgI/SOAZ1zPxB5gqG5HHz0tutnJD0oKKt+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437632; c=relaxed/simple;
	bh=u2BFG2Z5cG1xeYDegTmCmVgyYBL5mku0nB+ZYzycQTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2Ve/sxbvM9yVLaywjiD9jCIYdWlRr5jYUvi5NT949mQ54rpqtsQggyj9z21nNVosfaXugF2ZauI00trL+lmQ8Ez3NTdrh/tT01jilhL3oLlqM0HNWkVmfdTEoSq14/iGUsFiGC+qTHMMdTZ3FINtl/R6pDfBU5uwiPaivWa384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bb95T03T; arc=none smtp.client-ip=91.218.175.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bb95T03T"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u2BFG2Z5cG1xeYDegTmCmVgyYBL5mku0nB+ZYzycQTM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788437627; v=1; x=1789042427;
 b=bb95T03TaCpj6QFTt7fHzy7Ku4llpWMTcAFIxALsApWaj7U17ls1AFwvHnR2KQ0Gk+mCC3tT
 Rt1VC37rhaKEedUcdv8gJtc/xvAYjtUT7dPRO0FPrq5ANcbJqqGzB518kTmxJ8/C0tUV1+ZlgY+
 uvMjawhLiRf87FKGwOsAc51I=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 41e320479a75f80d;
	Thu, 03 Sep 2026 12:13:37 +0000
X-Mizu-Trace-ID: 41e320479a75f80d
X-Migadu-Flow: FLOW_OUT
Message-ID: <2c641835-006b-4511-b273-c2956d474801@linux.dev>
Date: Thu, 3 Sep 2026 20:13:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: microchip_t1: fix NULL pointer
 dereference in lan887x_phy_init()
To: huhai <15815827059@163.com>
Cc: netdev@vger.kernel.org, Henry Hu <huhai@kylinos.cn>,
 stable@vger.kernel.org, kuba@kernel.org, andrew@lunn.ch,
 divya.koppera@microchip.com
References: <20260903113046.163630-1-15815827059@163.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260903113046.163630-1-15815827059@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/9/3 19:30, huhai 写道:
> From: Henry Hu <huhai@kylinos.cn>
>
> The issue was discovered via smatch static analyzer:
>
>    make CHECK="smatch -p=kernel"  C=2  drivers/net/phy/microchip_t1.o
>      CHECK   scripts/mod/empty.c
>      DESCEND objtool
>      CHECK   drivers/net/phy/microchip_t1.c
>    drivers/net/phy/microchip_t1.c:1295 lan887x_phy_init() warn: 'priv->clock' can also be NULL
>
> mchp_rds_ptp_probe() returns NULL when CONFIG_MICROCHIP_PHY_RDS_PTP or
> CONFIG_PTP_1588_CLOCK is disabled. However, lan887x_phy_init() only checks
> for an error pointer before using the returned clock to configure the
> periodic output pin, which can result in a NULL pointer dereference.
>
> Handle the NULL return as PTP being unavailable and skip the event pin
> configuration in that case. Smatch no longer reports the NULL dereference
> warning after the change.
>
> Fixes: 8541fc12edcd ("net: phy: microchip_t1: Enable pin out specific to lan887x phy for PEROUT signal")
> Cc: stable@vger.kernel.org
> Reviewed-by: Divya Koppera <Divya.Koppera@microchip.com>
> Signed-off-by: Henry Hu <huhai@kylinos.cn>

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang

