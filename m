Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196959;
	b=Q9AgkKI/TB/tnBXcqX9cCAOtSLIB/xWHDB42A+eM2iPGPojKy4GHPY7szK2v2jyPotsx
	 XthUZ3hyDOqd/4z6JMvPUUN88yNwxbvax8fn+N/UrywhE32G/OV3JP7TpYOGQb/p15n6K
	 3QjZQlcg3Orvhdd8CoWr2Eb89vp/dX15x9UEXHNFBGvMIwn0sJxg72UMLg7sw0ZIVstlU
	 fjK0UTF7Ps/k8gZSOhJH90uzQodRfA/HwKHcwMgqsFsbBvq9jGxwR5PndXXgtC7wUUDBk
	 RNC5ppXE2q68Tc9jmfUk32UbUqOQSwjJiiRD/PUq3rjzZoDkgvKISEqh1tYZyDoDqzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196959;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=nypqymsfvQMv9gnOSD48NpKI4T5P6z+DuadvXpmmCmo=;
	b=KalKdfHRMhD4lpAQIXg3KauGVWcRvvexg2/Dxc5SMcOc0/l6CxgLNHixa3cO9GJRS5w9
	 Yb9s7JDvCi8QZ8p8bKDnEHHyLO4WTcQqnicpjsV98/AN70I0ARSKbKmSvIVOwKmIf0gcQ
	 tDKnytLeY/6yKMSKwu4NOuU4WcPxJIDhtn010J0SKYTrgS69g8JoPdazdU7zIwHHkEySQ
	 Hxp0eKF4snU8UZodOGscU9Vw3aWbyoMScdScsmR8s0eNnz+TCvKogsWm9eVUrMt2gI9Pl
	 rkSzO1U06+7Kf0MvF1K1p96qI/q/YtrPIfLt7e+iipAoCRSL3MRIhJpE9OqAQ1TMgUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22E606A334;
	Fri, 20 Nov 2026 17:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F22E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E7A36732A; Fri, 20 Nov 2026 18:49:15 +0100 (CET)
Date: Fri, 20 Nov 2026 18:49:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme: zns: reject an out-of-range zone append size
 limit
Message-ID: <20261120174914.GA1484@lst.de>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn>
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
In-Reply-To: <20261115012752774qFGtgUXwZKwN-2LDj0D80@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Nov 15, 2026 at 01:27:52AM +0800, shao.mingyin@zte.com.cn wrote:
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index e31ec6f4f94f..c34015e68f81 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -27,10 +27,15 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>  		return status;
>  	}
>  
> -	if (id->zasl)
> -		ctrl->max_zone_append = 1 << (id->zasl + 3);
> -	else
> +	if (id->zasl && id->zasl + 3 < 32) {
> +		ctrl->max_zone_append = 1U << (id->zasl + 3);
> +	} else {
> +		if (id->zasl)
> +			dev_warn(ctrl->device,
> +				 "invalid zone append size limit %u\n",
> +				 id->zasl);

This warning triggers for perfectly valid values that we just can't
express.  I think we can just drop it.

