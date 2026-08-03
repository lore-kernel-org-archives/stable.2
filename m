Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCEF39CD12;
	Mon,  3 Aug 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762276; cv=none; b=mC8Gf0PhoRfoCMOQTPXkE5J1q3nEjHmwfoutVFRpRuUfmr01QVPYuEOoor7r47+6Iuq6N3an2c+5ogQP3KSB6p2gOgcKqEVZZh4vzBdsvfB62SWOmYcSRf39cH1M/R970hCogqKQgKOlMQ5+8YV/4Hp900DXhEIBeXnkf75Oer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762276; c=relaxed/simple;
	bh=ZUKZQ9thx2h5E+xFzRTEWFqTvbWzS9W9fWz3rniJbrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0hNP76dAddbzt1AHYwz9yKJSrH9POYiGyzVJyJcjOb2y0ZYcsSYQtFtTCFP+DvP43MiMxDvlIawAT4UYBT9sQGvh/DVw/5SBQ6e2Icx/Y3vo4OgGbDzvXOO21f7BfCED56VEZSUKfSSaqK6/GjqD/mO+4DLwdRiHDuMe4Dyqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7pyrgZs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7pyrgZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066251F000E9;
	Mon,  3 Aug 2026 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762274;
	bh=D1cv6VZ22zxHySq7Kh00twNIIokqefR10rF1y+eC+eA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j7pyrgZsEVENWsq2u+EmiUuN/XqNXhAEAOe9FEAAvbHFznSZbDkJNwTpm0GsPFMu5
	 xs7GnzvvqhCLyPhaC5RRTKNsZ4Vucb+JFZMhuTXKWDamjk5rizCCJzxtDlGLnEE/BZ
	 fm6VsteXxqqp5bAQ1VZ2T71cU4rEO8mvlJW0KkTIG9LgBv0iLtbObOPSBfNPOFCRa6
	 OA3vqZwIkb3EjQqwbfjXwYg50EQE639vPZc6j4bRXOrhj7gWdoeOM3HTch3DZKqW+s
	 1GWNUWrG7Dece83YDCpzNTd506Cf6PzMkcruQ5RvYTisv6jmx25sRYv4m9QWgQFbbZ
	 mGWm0XQnezqMA==
Message-ID: <78d0627b-e711-4ce2-84ac-6e501898407c@kernel.org>
Date: Mon, 3 Aug 2026 22:04:32 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: restore finished zones with reduced capacity
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <2D18C0B4D202858C+20260731061139.1190909-1-raoxu@uniontech.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2D18C0B4D202858C+20260731061139.1190909-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 15:11, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> zloop_finish_zone() truncates a finished sequential zone backing file to
> zone_size. When zone_capacity is smaller than zone_size,
> zloop_update_seq_zone() rejects that file when the device is re-added
> because it treats every file larger than zone_capacity as invalid.
> 
> Documentation/admin-guide/blockdev/zoned_loop.rst, section "Overview",
> states that a zone finish operation truncates the backing file to the zone
> size. A file whose size equals zone_size is therefore a valid
> representation of a finished zone.
> 
> Accept both zone_capacity and zone_size as full-zone representations. Keep
> rejecting all other files larger than zone_capacity.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/block/zloop.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 55eeb6aac0ea..b69d798f203c 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -324,7 +324,8 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
>  	}
>  
>  	file_sectors = stat.size >> SECTOR_SHIFT;
> -	if (file_sectors > zlo->zone_capacity) {
> +	if (file_sectors > zlo->zone_capacity &&
> +	    file_sectors != zlo->zone_size) {
>  		pr_err("Zone %u file too large (%llu sectors > %llu)\n",
>  		       zone_no, file_sectors, zlo->zone_capacity);
>  		return -EINVAL;
> @@ -339,7 +340,8 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
>  	spin_lock(&zone->wp_lock);
>  	if (!file_sectors) {
>  		zloop_mark_empty(zlo, zone);
> -	} else if (file_sectors == zlo->zone_capacity) {
> +	} else if (file_sectors == zlo->zone_capacity ||
> +		   file_sectors == zlo->zone_size) {
>  		zloop_mark_full(zlo, zone);
>  	} else {
>  		if (zone->cond != BLK_ZONE_COND_IMP_OPEN &&

The problem comes from at least zloop_finish_zone() which truncates a zone file
to zlo->zone_size << SECTOR_SHIFT instead of zlo->zone_capacity << SECTOR_SHIFT.
So I think that is what we need to fix.

-- 
Damien Le Moal
Western Digital Research
