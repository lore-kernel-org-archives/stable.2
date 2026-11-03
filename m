Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717886;
	b=zpFF8ZSmKmpn7zvzuDcwq8TDYqYIJmUf9xAqP4YGm7bWxJg1J2E+nYeWO3CRMi2lSe9m
	 6XIayNUH16Qn++5e6jVWlUra3wpRvq2tTaN0zPmGZDU16LMqTbPclYBqxx4043EmWy5cg
	 cRJICLFVwAMHEGQRynKOaQMlrCF8L3A18D/SI54QmfIEKsjv2RsdDnUJhf6GK6bfNekUw
	 k/t7obgLckM1yQGH7R14vgfWgHazLu7+NNB4YEEMWofvdBzy0inSChk2VVvnvkwIMhutq
	 zoZffXn+18w66lyizXnNhP5wujHUIiaZWhvihAVhKZjKsVu9Be4YUBSv1IEO1JmsslA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717886;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R5KebMrP30ezLBHH/l16ZB4uhpyuj80SZyzpDuBB8fQ=;
	b=qlbi0O90NfrbwDDjKJrUsvUhh6FcKspR5mkLN9YShHY+khl0FD6pA+ce/LEB5gyrF+Ee
	 xaakR6ElM1bMJE8tPs32+6leztG5A1eHID2CHY/0CgUMB+l/diGPvJOkp8Z0OCOTk/6+E
	 wEyCz2iX47Q09Ei4kZ1aBBa1BXbPZCyJmoqhMXMBK/6uUIxhiZOfk+FmnAdiDcDtHwYr6
	 ubQernBJwAs3FLyLnmbDNBADRher3zgTch+Ag/lPtPKctmw/E6DCkmlOI3wClanTR8plF
	 H+JpMOJBh+ztw1J8JcwZjjuvcg02E+wmH07F/ihxn7VXcovzSzvFjX7IPj/4sk6M8Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqMVTiQ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A835608361A;
	Tue,  3 Nov 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqMVTiQ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6DC1F000C1;
	Tue,  3 Nov 2026 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717885;
	bh=R5KebMrP30ezLBHH/l16ZB4uhpyuj80SZyzpDuBB8fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bqMVTiQ11kQrPh08m6vf2W/1y/Yq+ERpo2flIy7syEbmDuUsIXnYa9MREKvCGHR1y
	 BETlCNZa6S8o9/qfiN3BFUi9RlgM73cRhKpnXJ3OFF/ThgHSvzeF3eFxDGKrDrfsn6
	 7RvCBcadGgvLGIEUtjuHyH5I42vY+yh2Fp4AOJ8TdWDOIhkROEepmHUX1nzbxb8LqF
	 2lQADF8kccluSgYDyd6F4rsIkMdVkxesdZNrIJO1MpaOKxylQp2QjOhg+7rz6E6aTA
	 KJjkpxUwHLkyZbl3ErtA2eXJarRes0907Tuh0ujthctFsMmfIdAMClA1nqDwcuDbwp
	 TR3Oxq2qXevMA==
Date: Tue, 3 Nov 2026 15:58:00 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 05/10] irqchip/gic-v5: Use linear DT and ITT when L2
 covers all IDs
Message-ID: <aun2eFXPsccWexvR@red-moon>
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
 <20261102-host_gicv5_fixes-v1-5-743b61626fc5@arm.com>
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
In-Reply-To: <20261102-host_gicv5_fixes-v1-5-743b61626fc5@arm.com>

On Mon, Nov 02, 2026 at 01:32:58PM +0000, Sascha Bischoff wrote:
> The DT and ITT level selector incorrectly chooses a two-level table
> when the selected L2 table has exactly enough entries to cover the
> full ID space. There are no L1 index bits in this case. ITT allocation
> correctly rejects the layout and device registration fails; the DT
> path instead allocates an unnecessary one-entry L1 table.
> 
> Select a linear DT or ITT when the L2 width equals the ID width.
> 
> Fixes: 57d72196dfc85 ("irqchip/gic-v5: Add GICv5 ITS support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  drivers/irqchip/irq-gic-v5-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
> index 6d98f3dbe34b6..866c238f08dfe 100644
> --- a/drivers/irqchip/irq-gic-v5-its.c
> +++ b/drivers/irqchip/irq-gic-v5-its.c
> @@ -337,7 +337,7 @@ static bool gicv5_its_l2sz_two_level(bool devtab, u32 its_idr1, u8 id_bits, u8 *
>  
>  	l2_bits = gicv5_its_l2sz_to_l2_bits(l2_sz);
>  
> -	if (l2_bits > id_bits)
> +	if (l2_bits >= id_bits)
>  		return false;
>  
>  	*sz = l2_sz;
> 
> -- 
> 2.34.1
> 
