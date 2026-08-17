Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8C3AFCE1;
	Mon, 17 Aug 2026 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947457; cv=none; b=V74sDFI6k/0bFFpPwy2bae3K8m5n0p3oNd66Fd2sGu9smT2a0tIQL870JfUV6k1XU6Ip70IzdHIz+R24M/i5q3vxeLS4IDJ56mNkGJgDyDKMP7OWrqJWkag5V+7pg1GG52tuRuOEwKHTOqPP7Qn5IKPi6JOAuVGAjz/J2qO+jLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947457; c=relaxed/simple;
	bh=zWbMu+g4mLblid3GmTCzofZg/CuaVf9MSUoAhOFcM1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txzgXzxOM/JAZyMFPfEudcMamitwTnaeXdGV3mib4HGzfXLggaDvegQXOtOrNRwkGKAbklvDOKgfsAEe6QvTinOOg1qXj+eRFqa/+Mdj+TrPkHnYOG9udXM7QVG1gP7c/VOj/UNpJ7BTkmydwkvbd5bW3ihGNKA67UkIku6buN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgjPYImy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgjPYImy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214691F000E9;
	Mon, 17 Aug 2026 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786947455;
	bh=/tX6CjSj8q7cMLClYhpuM83VN3AYnux1I392MajGFpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hgjPYImyB+fMfiJ0PiGwG33VK9VcGFAHrEqHNnDEDnCEVRloSONm7mAtAN/Rn+6+o
	 zTQ0UPMMIBNi1BBj2lR99jpeh4hbNW4x4tA2dCubiA1ifT4k8VocHLb8BM8rCvhhpr
	 CywYPIx2SgEmaS7gXZX0p3u5XeqIAOu4aeFmXxDBiY+NO+JA4tp1C9DhKzbITelvD5
	 3FDKOv+DAyR+yU+rHKZQ7q1Y0xRomXPksvZDCzAVk83KDJdhPhQI7DyhO03qXkIcU/
	 iQ8K6j70RDX7nCcNSKfyIMLyPoUBtuoEgIBlexX0hrp7KXx3n0+RrMR0wdnFqza+VB
	 McqlsAfmUuGtg==
Message-ID: <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
Date: Mon, 17 Aug 2026 15:17:22 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
To: Chao Shi <coshi036@gmail.com>, kbusch@kernel.org
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
References: <20260816191729.2865523-1-coshi036@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260816191729.2865523-1-coshi036@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 04:17, Chao Shi wrote:
> nvme_query_zone_info() returns either a negative errno or a positive
> NVMe status code, but nvme_update_ns_info_block() only tests for the

That seems like a bad design of nvme_query_zone_info(). Why not fix it so that
on error it returns either negative values OR NVMe status code? That would
avoid the pitfall of the error check that you found.

> negative case:
> 
> 	ret = nvme_query_zone_info(ns, lbaf, &zi);
> 	if (ret < 0)
> 		goto out;
> 
> If the device fails the Identify Namespace (I/O Command Set specific)
> command, or the Identify Controller command issued by
> nvme_set_max_append(), the positive status falls through and setup
> continues with the zero-initialized zone info.  nvme_update_zone_info()
> then marks the queue zoned with chunk_sectors and ns->head->zsze set to
> zero.
> 
> blk_validate_zoned_limits() does not check chunk_sectors, so the limits
> commit succeeds.  blk_revalidate_disk_zones() does reject the zero zone
> size, but by then the limits are live and nothing rolls them back, so
> I/O keeps being submitted to a zoned queue with a zero zone size and
> disk_zone_no() shifts by ilog2(0):
> 
>   nvme0n1: Invalid non power of two zone size (0)
>   UBSAN: shift-out-of-bounds in include/linux/blkdev.h:747:16
>   shift exponent -1 is negative
>    disk_zone_no include/linux/blkdev.h:747 [inline]
>    bio_straddles_zones include/linux/blkdev.h:1058 [inline]
>    blk_zone_wplug_handle_write block/blk-zoned.c:1423 [inline]
>    blk_zone_plug_bio.cold+0x25/0x1c8 block/blk-zoned.c:1605
>    blk_mq_submit_bio+0x18fb/0x2870 block/blk-mq.c:3196
>    submit_bh_wbc+0x575/0x740 fs/buffer.c:2824
>    __block_write_full_folio+0x728/0xdd0 fs/buffer.c:1933
> 
> Any device, firmware or NVMe-oF target that fails this one command
> reaches this.
> 
> Skip the zoned limits update in that case.  The namespace stays
> registered and usable for admin commands, but the queue is not
> configured from zone info that was never read.
> 
> zi.zone_size is an exact indicator: every path that returns a positive
> status returns before it is assigned, and after that the only failure
> left is -ENODEV, which the caller already handles.
> 
> Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
> Cc: stable@vger.kernel.org
> Cc: Weidong Zhu <weizhu@fiu.edu>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Found by FuzzNvme.
> 
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> ---
> Changes since v1:
> - Only skip the zoned limits instead of failing the update, as
>   suggested by Keith.
> - Gate on zi.zone_size, not zi.max_open_zones, where 0 is legal
>   (reasoning in my reply on v1).
> - Drop the "malicious device" wording.
> 
> v1: https://lore.kernel.org/linux-nvme/20260814160954.2839507-1-coshi036@gmail.com/
> 
>  drivers/nvme/host/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd0..87e0534cde1c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2447,8 +2447,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	if (!nvme_update_disk_info(ns, id, nvm, &lim))
>  		capacity = 0;
>  
> +	/*
> +	 * A failed zone info query leaves zi zero-initialized.  Leave the
> +	 * namespace registered so that it can still be used as a device
> +	 * handle, but do not configure the zoned limits from it.
> +	 */
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -	    ns->head->ids.csi == NVME_CSI_ZNS)
> +	    ns->head->ids.csi == NVME_CSI_ZNS && zi.zone_size)
>  		nvme_update_zone_info(ns, &lim, &zi);
>  
>  	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)


-- 
Damien Le Moal
Western Digital Research
