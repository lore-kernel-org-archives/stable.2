Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426022;
	b=4lwgYhJBJ65rsI64F2B2nPxGEdXfSJk7aXKkTlBTvhDBi80o1skLIVsgt8hS+wVHLWIw
	 tygMvlqGJli/5kUQhi3/QY46sIIaJjaUx98jhdGoaWBD7Wke/qcm/zN7bn8tiH88V/eYe
	 5/LxpPJ0baHJXdNaqqRdWZq9bdnvDsaNpbA8lm0oMCZyBfEQmIx7ExAGZAT3pJInO9X7V
	 07jMjRXZXojWkmEkGQjQokkjuGwrN7yza1orOMgZJLc0iprnRvKVOkwdeI/utmByt/rqn
	 g8fNUHGcSahKllvtyuYRiKKdyugRLB2ItZMyVo373iOKWe9kaWPwur1chxeCl+AcDyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426022;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TXTFlk09t08FIZ6Qb+r4T9giISDD+eh2XK6qSqV1gqQ=;
	b=XW49iRP/yV6ZTHT/VEF/FqDhrbrUAGpdTQMGoyqqzVm5oueQVO74P+x0XNYQr+NbHmkv
	 aLxc5wpAyRUZSZMwXRqcZBleI3Bu5hsgxmwItW8JRIsqLfUWJxI0+4jsuy5YUa9z0ZOrJ
	 gsAMALCvnbkGWuS5VXLsBr6Uw9zyC2Q/fVrfHuio2I4LFrcNVSJqKfWztkD98WX5j9qrE
	 EWQhe7HHtXO+n8Rf/QYSj+v28zjkLKr9r3PR4YCRVrxL6I58/NgwpIZ7uCxDZSrceFZbn
	 FjlJboAG9Y5VU4gbguxJ04k27/d7bPxdOn3oXfavCC0s9CV/TwHS5zhyO2dVWgVrFbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsBd8Olp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA1606A8B0;
	Wed, 11 Nov 2026 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsBd8Olp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3731F00A05;
	Wed, 11 Nov 2026 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426022;
	bh=TXTFlk09t08FIZ6Qb+r4T9giISDD+eh2XK6qSqV1gqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XsBd8Olpb7CEe3lQXaWCjvfYqhu29nHxT+LAglG9uXBXNQVa24pWZkNqAy1QdT24c
	 wRC1Q6jQn9+kAI8dU6tAhKq42hZB12rv9nSigIlFQGIEwK1InzmZrKdp/o9jnVxflh
	 gUO0Q6e0/2UH/6JJ6orkCyYNzqKiM9Nr8IScDE5MaeuafjtH+0mF8O94WxPsv8/Vzf
	 hVy/BuIvwmrxFBVxRWmpdEF4kIyLQRZ15GQeaq869LoOMTMnf/6lzQnbu0HfvisZuH
	 rPHYvaWnLa+zQ8zWYwcbkUyHxsmS6umrK/RGXmyr4AVzcicwLuUUEBDXYzvL9B3FdR
	 DDHRZodOZtpzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20FAF38003BF;
	Wed, 11 Nov 2026 19:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/3] Bluetooth: btintel_pcie: Add yoyo support for
 config
 set TLV
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179442602067.1604530.7480773589648811340.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 19:40:20 +0000
References: <20261111165332.8478-1-ajay.k.v@intel.com>
In-Reply-To: <20261111165332.8478-1-ajay.k.v@intel.com>
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com,
 kiran.k@intel.com, linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, stable@vger.kernel.org,
 chethan.tumkur.narayan@intel.com, lakshmipathi.k@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 18:53:30 +0200 you wrote:
> From: Ajaykv <ajay.k.v@intel.com>
> 
> Add parsing of the YoYo CONFIG_SET TLV so that debug register
> configuration can be supplied through the external TLV file.
> Each CONFIG_SET TLV is validated, and its address/value pairs
> are stored in the config set list of the YoYo context.
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: btintel_pcie: Add yoyo support for config set TLV
    https://git.kernel.org/bluetooth/bluetooth-next/c/68e0925f16c0
  - [v3,2/3] Bluetooth: btintel_pcie: Add yoyo configuration for debug region
    https://git.kernel.org/bluetooth/bluetooth-next/c/89ab6c52494c
  - [v3,3/3] Bluetooth: btintel_pcie: Add yoyo configuration for Hci cmd Tlvs
    https://git.kernel.org/bluetooth/bluetooth-next/c/50932a1567d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


