Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF03B0AC3;
	Mon, 17 Aug 2026 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949761; cv=none; b=X4PE0cw+mIYIqAhosz6MxJTs43vSQJzIfWsPU1UwZFAFpKJA8BCWqsitAQdODuJzHDqG/eWdDA9HhcC7YUWfdef6HwyzPM7qNFWsL/MRQVRhhDUEBUJvW8Lfge+wxZec/gF0N/sJjG8bSeVpm+Z8yHnfa2UfcqJW53TaWulT1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949761; c=relaxed/simple;
	bh=byhNmhnmmWyY/1sk1SN05mSvSTgdWh+hRpFc61RDOS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfJhfDvqEhRVlov5j+OQ9V9BTjt7AYBQgwk7yq/9NQIWAghwkGVm/UP3zS9XgekIS5Fu641YDbIy8dmPwRB2PUllArF5znT2o5PSBZQ1gEJfCoYA7jzVHcd4945ySjBp+k170Pu8I/CaTIpCDWAQvPJeKjMyuxP1XR/RV2BC/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A55A68CFE; Mon, 17 Aug 2026 08:55:54 +0200 (CEST)
Date: Mon, 17 Aug 2026 08:55:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
Message-ID: <20260817065553.GB16255@lst.de>
References: <20260816191729.2865523-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816191729.2865523-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Aug 16, 2026 at 03:17:29PM -0400, Chao Shi wrote:
> nvme_query_zone_info() returns either a negative errno or a positive
> NVMe status code, but nvme_update_ns_info_block() only tests for the
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

Did you do error injections to get here?

> +	/*
> +	 * A failed zone info query leaves zi zero-initialized.  Leave the
> +	 * namespace registered so that it can still be used as a device
> +	 * handle, but do not configure the zoned limits from it.
> +	 */
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -	    ns->head->ids.csi == NVME_CSI_ZNS)
> +	    ns->head->ids.csi == NVME_CSI_ZNS && zi.zone_size)
>  		nvme_update_zone_info(ns, &lim, &zi);

The most common case for this is probably during revalidation of some
kind, and then we'll just keep the old values.  Which in general
should be fine, but might be worth mentioning in this comment?

Also we should probably log a message that we either just register
the handle or keep the old values?

