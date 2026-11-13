Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593948;
	b=eJdSpmBwAwWGT60N4eLUSlSpDX24/W1dE1Zvp0wc2e2gTGhMqFsGAbsLlJXAflfWHkJU
	 p0pAVzZilGsGHd+hZg+m+1Eiy3Cl0G+GofgAPTs8T7ixQM/FVIiS6UcKbpj4Di+soo6Ke
	 Hu4z+sfajBukeQwBkG7M9PnOoUL3Z1NHv0V2d7Jt7aRX3DyxWlEHmP0IVbQVCtTbG3uaP
	 RK2hFfQmUGje1Hhr3IEFTXyj+Tk979ASo3pHekHR8yGORdxssqh/juGlMoBnGwbkOb99Z
	 0RbBwJ6Kla+wfevFNF+3d4Nld4/8jU6R0bChLIDK5P/Pd1K/0nExyFlzkOGCeLdf8Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593948;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tY3hrmAgaHjp3VWbBdwPfASlyBa0YGJnlba8Eg0Cs1k=;
	b=rAQi7fb2NycjxzrmhoM+CgKLgHY13uO93mIu36juFYWcuEcaxC21mI1Cs/jUmReq4ZAJ
	 kiEE0JD8Q+g3v17ocQWVFTMh0optSLVkJhhDCnWyDuYbDvFtk3Y34J812LqkCh2CHJ6E/
	 gILR+zOdeEDYVZWQkH4QhgaodxhsLfQ9iccIW4x5I8s3uC/FOaDrxXmFit/NJSULETTM7
	 zOj/p4KObaHJLZFmUgi1bDhAHeUPUBFoulBsQFQ9J50aGwuz8jusqZZ8GMsoIuOcnMvHQ
	 xmSCIBEnJCfKHKq57OC7NknxekKTvtuPozFEq4UtJB2uqYIFfXiYMeQOTXUfhmshVOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYRPkJPQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391A606A32E;
	Fri, 13 Nov 2026 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYRPkJPQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063D81F000C4;
	Fri, 13 Nov 2026 18:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794593948;
	bh=tY3hrmAgaHjp3VWbBdwPfASlyBa0YGJnlba8Eg0Cs1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eYRPkJPQkjFvhY8zmvJejgxxwbsSwaTH7o9dcrvqgqJ5oOVKOjdjgMShiszXa6s93
	 1wEntHNdNRS9yRE39+lEB9jRJkI7uMynlGYah6lg+aB+X2jHNeAxYPreCfG10wSewp
	 k1N/bM/MYYGQCeqTzYIjDca9zc61yP8C3XQfboCJ5DJA97mNygBAxugNOC2zKg+FLh
	 nrXMWTZG42Ce38C0gjxQkyZnkULKsgJxruipU4ortDxiXaGnnGBcDBGNUZTCt4qGmz
	 fcrncca+Hcx1S/5jbHhqXzSZOdfrZvdiIq5SrZ84Qlt7jmUbL02YMUvyxUq77jjvBJ
	 61IUU7aRZ2sVw==
Date: Fri, 13 Nov 2026 19:19:04 +0100
From: Niklas Cassel <cassel@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 0/5] ata: fix platform driver probe, removal and
 locking issues
Message-ID: <avdUmHKYnEyju1N1@ryzen>
References: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>

Hello Shao,

On Sat, Nov 14, 2026 at 02:03:05AM +0800, shao.mingyin@zte.com.cn wrote:
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
> 
> This is a resend of [1].  Patches 1/5 and 3/5 lost their final
> context line in transport, so git apply reported a corrupt patch;
> 5/5 had the same trailing line.  The diff content is unchanged; all
> five patches now end with the format-patch signature, which keeps the
> blank context line in place.  Sorry for the noise.
> 
> [1] https://lore.kernel.org/all/20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn/
> 
> Shao Mingyin (5):
>   ata: pata_ixp4xx_cf: avoid recursive locking in the PIO callback
>   ata: pata_buddha: propagate host activation errors
>   ata: ahci: release QorIQ and Seattle platform resources on removal
>   ata: pata_ftide010: stop only successfully started Gemini bridges
>   ata: ahci_seattle: serialize SGPIO register updates
> 
>  drivers/ata/ahci_qoriq.c     |  2 +-
>  drivers/ata/ahci_seattle.c   |  8 ++++----
>  drivers/ata/pata_buddha.c    |  6 ++----
>  drivers/ata/pata_ftide010.c  | 37 +++++++++++++++++++------------------
>  drivers/ata/pata_ixp4xx_cf.c |  5 +----
>  5 files changed, 27 insertions(+), 31 deletions(-)
> 
> ---
> base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

This series looks good to me.

Unless any review comment shows up, I will apply it early next week.


Kind regards,
Niklas
