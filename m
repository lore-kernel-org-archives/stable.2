Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708309;
	b=R1LWNau6KUNo7Iu5ZPg4NRaJxMKhnFwx9afOxgcd3vr4kLGC+BqqtzLoBBgXsE9Ge/fb
	 TkxviVq3LlDrOxDfbipll2350u+d5QVKNFV4VRiisDO1oRWhfXa6CAEF8yV1vz8kiNr9C
	 /8XtqkZWTslmy0Bstb/agSX/jspAxc+8LWRkFqKR7XwrxQneDCQMk+YQopkasQruTQO/t
	 TjXQn+GOhET8TK72duM6OXnqLzb5tdFN1Pnb927pBWItz/RICNYmqa4aL/AWD6umaknp3
	 SubkfKssNaqNFL04jb/nsxPrQJ5gERw729elCa3JVxCSUhHjlKRRh+VtA0nwf1e2t1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708309;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BRUqir4+XC4RCLw0cgSXRJ/4jat7SaP4F3cbFYh0QNY=;
	b=Q1iSvpQKAJ1iAERM8CmlBiyyA6qMLVvHfqhje9lKHpxTPIMhXMtkNkfuFeuknK3IfWOy
	 w1imbym6Lue92/RUxx1JTlK2tgCUe9IdE6tjUqffJI65IExG7MZVSX5/ZQsYj7sHDgAwR
	 Tkj/abAbo4EHAvkxC+RASeL2GWQ/KNPZ4bu9Pj2Nc1rFK4hdf4KEDnyEZytiqfSUh1NBx
	 SGYRTLIPBusMgBusrE1wTaXyPZVwcJUcx/KOaGtxatEK7d8X88e733tDEB59bI6fq0MTe
	 L0jgavJCZE8sYEBNzdXG7grhSgSDM1qiQKz+w/u51jegC2a9bGAa0HnH+XuLsq7Ylow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiiLQTIH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC70606A323;
	Sun, 15 Nov 2026 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiiLQTIH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765CA1F000C4;
	Sun, 15 Nov 2026 02:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794708309;
	bh=BRUqir4+XC4RCLw0cgSXRJ/4jat7SaP4F3cbFYh0QNY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jiiLQTIH1zRdVTiXG6m9kIpxsdt/6RLomExIF2A8cMe+kEBt2lv5y8OysV51d0iK9
	 +qKf3cRANqTnABEffkGQPrMqIaV/dtLKHwP6eKZ78SlekNKVlt0UZSSkQ6+sGR/5+V
	 Kks4JPVtC9CGb51pjuvYzrDnFx/yhco2G2LNnzWQhk/df/CwzOyAyvtoRj2sc9O1dJ
	 n0h3kYi7B/0mV9swiLO9g4o7FLQwiWJ45yuZgvi0yD0poSWv+m47+zsfh3sHc7sBTX
	 bsavxbcDi/zPZ45/P3AJY+YDPVnD1GBxZ5T4YYTFKouitUItL5hyToqxbHFLf5sYsj
	 b3yw97vyiyRnw==
Message-ID: <db43c948-68d0-402b-841b-2dd649a80c5a@kernel.org>
Date: Sun, 15 Nov 2026 11:05:04 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] ata: fix platform driver probe, removal and
 locking issues
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 03:03, shao.mingyin@zte.com.cn wrote:
> The ATA platform drivers in this series have independent defects in
> their probe, removal or locking paths.  They share the same shape:
> state established in probe is not checked, torn down or serialized
> consistently.
> 
> Patch 1 fixes recursive locking in the IXP4xx CF PIO callback, which
> can hang the first data transfer, including IDENTIFY during probe.  Patch 2
> returns the host activation error from the Buddha probe path instead of
> reporting a successful bind.  Patch 3 makes the QorIQ and Seattle
> drivers inherit ahci_platform_ops so that host teardown runs host_stop.
> Patch 4 stops only the Gemini SATA bridges that started successfully.
> Patch 5 serializes the controller-wide SGPIO update in the Seattle LED
> callback.
> 
> Each patch touches one driver, except patch 3, which covers the QorIQ
> and Seattle AHCI platform drivers.  The patches are independent and any
> subset can be applied; the order lists the more severe failures first.
> 
> All five patches carry QEMU A/B test descriptions after the --- line.

For the series:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
