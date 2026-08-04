Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68C221883E;
	Tue,  4 Aug 2026 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817752; cv=none; b=TJaoPswj5U0shD+cuWtNHxglNaSNwPpO15iUOeBNzemfr6GQiUEFLdDLbgUa6OsmgD6QNOaFqXrkC1lSIH5DxCVrzOWBcEjP/dJjGsElPYs8IoZ/s2q/hN6WQBsOZsbNiwy7hqqbyoUO2eyUbMZ1eMVsARGH6Puq4e5lNxydr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817752; c=relaxed/simple;
	bh=PWy6HkMc450frXde2fJKWbUjPH9yK5J2nsQY0CvF4yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2Go8KsmHl8rLkTHqYOH+zmNIceOgVtiOc7MAC91WbKZKfhPbb7naLo8GXRdhOJkqDq1q+Md205XBsPp72kiMpLpYc3m7cFpGuZuWqAML2EPebyK7m7IWHoKh4rb4npPq8t5ZHBNt1hPnGZmjXwISpQrAAp9EmsVqgCN3KqzW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAV2evLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAV2evLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8408D1F000E9;
	Tue,  4 Aug 2026 04:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785817751;
	bh=nPz6co9halTHG7r/bUw3VxfPO9Gwuo2/06MTqot21pQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WAV2evLmSpxaPRKKQpcpd/mj/L4i1T+VfQPSgAYdqbBR9BODhMUtddmJtk6OV4Al4
	 15qT/LUYivwG92apNeF17gOTFlstH8cpIo3i9DEzvO/JS6dCIa4xgvE9sR4dshs+m0
	 k2wOZU621JJJDNJlO+iZwfAUhazO8hVddP5bEipI4ttV/vm6+uabi/21RlzeNP581b
	 oVAapnQfVevZBitjKX3Z7xgLEizZ94nfRHP214VlNbuCSyxnhRWniee8SAttZW5w95
	 0MGm+eL6bgMGPZr7uYLimH+23DWilk3d6jI4MFYaDrKi/+gCRinneAtpWUtYMyTm1c
	 y5g3YH1gxQl9Q==
Message-ID: <8da2a239-e074-41f8-8d8d-552b1652edfd@kernel.org>
Date: Tue, 4 Aug 2026 13:29:09 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: block: zloop: clarify capacity
 alignment
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <0be2d538-8e18-45ad-9181-f7e3fb7e02ed@kernel.org>
 <8100621B7A58105B+20260804034121.1036479-1-raoxu@uniontech.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8100621B7A58105B+20260804034121.1036479-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 12:41, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> zloop divides the requested capacity by the zone size to determine the
> number of zones. Since it uses one zone size for all zones, a smaller last
> zone is not supported and an unaligned capacity is rounded down.
> 
> The capacity_mb description incorrectly states that the capacity is rounded
> up. Correct it to document the actual behavior.
> 
> Fixes: 9e4f11c1228c ("Documentation: Document the new zoned loop block device driver")
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
> Changes in v2:
> - Replace the code change with a documentation correction.
> - State that a smaller last zone is unsupported and that an unaligned
>   capacity is rounded down.
> 
>  Documentation/admin-guide/blockdev/zoned_loop.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
> index f4f1f31..fd99e5c 100644
> --- a/Documentation/admin-guide/blockdev/zoned_loop.rst
> +++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
> @@ -71,8 +71,9 @@ follows.
>  ===================   =========================================================
>  id                    Device number (the X in /dev/zloopX).
>                        Default: automatically assigned.
> -capacity_mb           Device total capacity in MiB. This is always rounded up
> -                      to the nearest higher multiple of the zone size.
> +capacity_mb           Device total capacity in MiB. A smaller last zone is not
> +                      supported, so an unaligned value is rounded down to a
> +                      zone-size multiple.

Let's make this a proper sentence:

capacity_mb		Device total capacity in MiB. A smaller last zone is not
			supported, so a capacity value that is not multiple of
			the zone size is rounded down to the closest multiple of
			the zone-size.

With that,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

>                        Default: 16384 MiB (16 GiB).
>  zone_size_mb          Device zone size in MiB. Default: 256 MiB.
>  zone_capacity_mb      Device zone capacity (must always be equal to or lower
> --
> 2.47.3
> 
> 


-- 
Damien Le Moal
Western Digital Research
