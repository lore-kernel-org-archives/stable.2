Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F43BCD00;
	Mon,  3 Aug 2026 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762132; cv=none; b=aj7Y60btZcjsOau50BtxTb9LVdAWGS8Ze2EDILZ/rhiIbPBr/GIER8cEdZjemSWwK4c9+U5UAAvG0cogalXcJLThsqgR0DvKzBAQn+7Ac6kPKoTfEPVj7/17yaY+aeq5oSc3oK5S8MMlvq+SroGd5+aNIGsJOPh/+Fwj61QHwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762132; c=relaxed/simple;
	bh=NdVH5UnPIcR8sCVSXiPGOl8TJlQb63rdYlYGxkZgPwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZgIUlaU6N5ti802Wf64xpCNRQ9OYn5VnksZWtISCAp5oj2FddZNHy4U2qwGbrir71gww1WtLQvWC7geLOUF4hRH7yvIJBFa9eDnuUJzmCTWLFipp4zYFBFzTnI/wWS3LqSsqKKbkqXuxgt1brvpRg8Fc+vUWX4ktFmfRHWV6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOJr/n1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOJr/n1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD261F000E9;
	Mon,  3 Aug 2026 13:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762128;
	bh=pXzD0gO2e1hNQR5V3zklsDSptDxGKPZhI2uRPLHOX7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IOJr/n1KTqxyXJhlF0mjg1uGqTLPoHOmOobxOoQlQ5lHWeoObSq9RAdaGD1uhE9DL
	 a4LeYXfKsu0jjJ+vWMk/s8EufzCLxwqBczNb8jNg7b/8+IPXu8zfeqBpFH18BJV79R
	 P7VeBQpoNYJZ/WD4Dfh86cJuLSezkPGzy8YsRWf0cZFqLDRuakXdA9BBuWojfldmdO
	 HpKbVNb0GCcouhesT9gMWumCMrqh01xMxpixFMoRdJcWhV2MkoQbiUQkfgap7H5ONL
	 RWm8evbVCF78xG2j4iBwFu75jxr2qvfFQXte8GCiik4jXqZPgsyYH6R40TqjXDfUfe
	 21FvpPvQy9LaA==
Message-ID: <0be2d538-8e18-45ad-9181-f7e3fb7e02ed@kernel.org>
Date: Mon, 3 Aug 2026 22:02:05 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: round capacity up to a zone-size multiple
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <906CDA1B6AAAD5B8+20260803095810.3453016-1-raoxu@uniontech.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <906CDA1B6AAAD5B8+20260803095810.3453016-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 18:58, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> zloop_ctl_add() derives the number of zones by shifting the requested
> capacity by ilog2(zone_size). Since zone_size is validated as a power of
> two, this is equivalent to integer division and discards any remainder.
> However, Documentation/admin-guide/blockdev/zoned_loop.rst specifies that
> capacity_mb is always rounded up to the nearest higher multiple of the
> zone size.
> 
> Only configurations whose requested capacity is not aligned to the zone
> size are affected. Aligned configurations, including the defaults of
> 16384 MiB capacity and 256 MiB zones, keep the same geometry. An affected
> device is also internally consistent and remains usable, but it is
> smaller than requested. For example, capacity_mb=130 with
> zone_size_mb=64 currently creates two zones and exposes 128 MiB instead
> of the documented three zones and 192 MiB. Since this does not cause an
> error or an I/O failure, and normal test configurations generally use an
> integral number of zones, the discrepancy can remain unnoticed.
> 
> Calculate the number of zones with DIV_ROUND_UP_SECTOR_T() so a partial
> final zone request is represented by one additional full zone. This
> matches the documented control interface while preserving the existing
> sector_t handling on both 32-bit and 64-bit architectures.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/block/zloop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index b69d798f203c..e29d82ff52ae 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1187,7 +1187,7 @@ static int zloop_ctl_add(struct zloop_options *opts)
> 
>  	__module_get(THIS_MODULE);
> 
> -	nr_zones = opts->capacity >> ilog2(opts->zone_size);
> +	nr_zones = DIV_ROUND_UP_SECTOR_T(opts->capacity, opts->zone_size);

Your explanation and this change are consistent, but this is going to break many
things because we do not maintain the size of zone per zone and instead always
use zlo->zone_size, assuming that all zones have the same size.
Your change would result in bad things. For instance, zloop_finish_zone()
truncates a zone file to zlo->zone_size, which would be too big for a last runt
zone smaller than other zones.

So nack for this patch. Instead, I think we should fix the documentation to make
more explicit that we do not support a smaller last zone.

>  	if (opts->nr_conv_zones >= nr_zones) {
>  		pr_err("Invalid number of conventional zones %u\n",
>  		       opts->nr_conv_zones);
> --
> 2.50.1
> 


-- 
Damien Le Moal
Western Digital Research
