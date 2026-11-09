Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227165;
	b=NMfv7n1P9Hz0VBAmMwRcuF6k0p4zNP+0416mXVjDP/qqTttyxS4Kj32vy0MR3B3JcT7m
	 R62Y84gYNIY5vCIgy4rlmLpZHMhURjxdljFHQVY9Jsnj0nLYP8Ld068bZU0iX/EHtWnD8
	 dy/p9+iBOC464C8u0d5zQr4jddG2qHNhnbquZcMU5BSXKy2qNiU+aHkSbVR0qPTbQQCn5
	 IhZOEwvX/KPIxaBwW+bt/2E6sEVbnpzeVX0r2U9OcGDrv8hJ7g6G1sapE2R+uDCMKuA16
	 zHJC9I2jakAgQ64qK/ZO3yoCD5ghwCL4oHffFCXSiByX+9IUE92aB8izk57HRgb8T6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227165;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=fAh25Gi0bhky1WETD+phdGZSq8teLncsWtkG4TgRdH4=;
	b=EIjnd8IOiEWS1udtO7o0nRmT1xtwSo0xqm3uB9XO43S9Tjddnm+e5DcuKAq8ScdkdMOp
	 L/ufLwzEYHFcnHUy2dbT+DqeBUQhs8NonOspYEpGoBLMRfnWY9SzmgIp6ehpHb3MCcuOQ
	 K4F+qOYSXnAMC0fpUhLH+xSFd0GxZPG19jOVdy9rBQAuJl+K5YaHSwoHxqvUhfN11nmpk
	 COh/XpJC2htIncWG4SQ+1VEbnZ4qVS4/9pXAVMyd34AZ0SQww7WwyWvigdxoAliNS4dQr
	 jULxh6GmCND+dMKDodPBhSM0S2CHfe6/bVtQaesaxc+EA/V1/9g/qKsXJk8DG/pqaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=ahmZ4kqY;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8889D606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8889D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=ahmZ4kqY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1794227162;
	bh=fAh25Gi0bhky1WETD+phdGZSq8teLncsWtkG4TgRdH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahmZ4kqYBHDBMKIWBvLM1A4Q/zdpPCbP1e6yrkUfIlWr76XvhjBzL3t2hMTgrFI3V
	 ujaxSmlOQAW6er0Ty1s/mb9jEzWBGH6E1JOmA5an4N+yTXxF1IDybRr9Ce1j5kLCQP
	 rf6AdY8Mv9qsUziW+tOZ0v6uEdSEv67e15UBHo9PBn/AsXHFOBD/wXdGwd/1ogjTaD
	 9Kf2yUaIi7FZHWaO+E45ag6SOucK/zjs4VSzUhJBdIlQ2Sz/9PInxT99dsPJFhqtoE
	 QHCYArSgnmJNghz1n/a6MFJFjus71tv6wzpoGXrRSYiNdpcxzxkejGgqwmWzAVtln6
	 gqI6ZmNJCBh8g==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 628FD60058;
	Mon,  9 Nov 2026 13:26:02 +0100 (CET)
Date: Mon, 9 Nov 2026 13:25:59 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] Revert "netfilter: nft_byteorder: remove
 multi-register support"
Message-ID: <avG71wG3PHvRQT0B@chamomile>
References: <179422702104.5131.8115555421206983838@gmail.com>
 <179422702651.5131.4174988605567778384@gmail.com>
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
In-Reply-To: <179422702651.5131.4174988605567778384@gmail.com>

On Mon, Nov 09, 2026 at 03:23:46PM +0300, Abdifatah Suruur wrote:
> This reverts commit dc29c0478b8564feb9371e715b5a0016eb8903fd.
> 
> The upstream change removes multi-register byteorder support and is
> tagged stable+noautosel because nftables versions before 1.1.0 can
> generate length/size combinations that the removal rejects.  Backporting
> it to stable can make existing rulesets fail to load.

Same thing here, if this can break stuff, this cannot be taken as is.
