Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407251;
	b=MO+5yJst1Z7tWF0yKIOdB05N9c6QXpKKskNJuUDyv76L5PGXys5eGQ9CebFKjcgYj6fF
	 njKMnZiovR8qiVrI9p3Ve/uuMtN1ZItyeYeBOCzOBP3oGDHzFKYjflAYPZTLCmtFrIlM1
	 faq20aCL2Kl8VWDX5RyhXQJ3aj0yPBWv3LxIqQ5ec0IKR0iRH5zr+/Or013KSOzfy++Sd
	 ZTjmZko/A0ZaeIhQwz22x5hJegF/uaTwab+JSYF/5GTWILaCkH4ltuEvfAE2kY01YpjQ6
	 Y3bTfayyhpz9xwi5wQfn14/FASz7Hvdw4K+W6FBkCBWK5hNdbaxqPeX96rIEyuM9/vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407251;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=h+J1M25u6QeSQPD1ItsoXcibdhcAMh1COkyItBeTwFQ=;
	b=0alahNaSqkH4Xjy8wdrgZKiwHn+B6odyG5tCls1XjpkHXPIJpQxBu/91TJ/1YiVrt2OG
	 W2K+EvO75dQhZYbR08d9MZwGxojid9uLVdgNYHoYYywMVdCcH6IIANEeo1bXDmHbXzNzx
	 4hEMtyVb2TYx0FyVAPxoptwciSx8EemTdEv0UoUVrGfPkRZ5eeDl2VtMb+6ZmeWURfdJw
	 NkblR1ydiMbGp7sQwhruDJzE9hyEEbB4lZVLFa/0CIsDYK4nFLfvZlnIxFFI1WgNDby4J
	 tCja9ljZ7YZvZcAXmxdwevauvLecFw9mVKZii1q83dXPgzVxmi6sogSYuXQbRvPuhNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="G/KaiEp4";
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE95C606A333;
	Wed, 11 Nov 2026 14:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE95C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G/KaiEp4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794407251; x=1825943251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u/qCeSjdsyng+gNlk62u9VkDUlVM/0xSeuz8x0YhLRM=;
  b=G/KaiEp4YOZ1X2aPF0uxgt8SMUrirGcOvYWA8IK16dChS0rhyangSgRC
   UAGPiJp0YgPpFPhi3clrKtJzEPSroH460/T3Awo2PThI1uDg7PZfey/9W
   ryc14Xqll2pPF8loxiqGkxZ1ZJMHK8xk64a/bdekcbcg5GdXeVcY/IEBn
   QVrgl1CFTbaqXPLcjN7zkgV87xcHsyajQvMBVdRDDqcNPWrg49DjQ8Woo
   akI6aWG5vR4uvpolof3yOWRchKxRvrKxYN8/t4yeP8C97wbJglcVaErD2
   4ZK0WCbCItdq3YbDJUmGItN/yVY+aBFgVvgSFQvQeaXUKTNSEUiAiUWcg
   Q==;
X-CSE-ConnectionGUID: sq9PmeYdRFeXuDMaPKUEYg==
X-CSE-MsgGUID: D4ygh+NjRdKcRfLp23DAuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3060384"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3060384"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:27:30 -0800
X-CSE-ConnectionGUID: oZKtpEQXROibnuVXpFC2zQ==
X-CSE-MsgGUID: P+bIKwihSLCEXzhTd9B19Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8525105"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 11 Nov 2026 06:27:28 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id E8ABA99; Wed, 11 Nov 2026 15:27:26 +0100 (CET)
Date: Wed, 11 Nov 2026 15:27:26 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: michael.reeves077@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>,
	Hector Martin <marcan@marcan.st>, Neal Gompa <neal@gompa.dev>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicole Mazzuca <nicole@streganil.no>, stable@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH] usb: typec: tipd: assign partner identity to persistent
 memory
Message-ID: <avR7TnYTytU7TQKG@black.igk.intel.com>
References: <20261107-tipd-stack-uaf-fix-v1-1-efcb517924ec@gmail.com>
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
In-Reply-To: <20261107-tipd-stack-uaf-fix-v1-1-efcb517924ec@gmail.com>

On Sat, Nov 07, 2026 at 10:06:17AM +0000, Michael Reeves via B4 Relay wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
> 
> cd321x_update_work() passes a pointer to a local stack variable
> (&st.partner_identity) to typec_register_partner(). The Type-C core
> caches this pointer, leading to a stack-use-after-free and a kernel
> Oops when accessed later (e.g., via get_pd_product_type()).
> 
> Fix this by copying the identity to the heap-allocated cd321x struct
> and passing a pointer to that persistent memory instead. Move up
> the assignment to cd321x->cur_partner_identity, so this works.
> 
> Reported-by: Nicole Mazzuca <nicole@streganil.no>
> Closes: https://github.com/AsahiLinux/linux/issues/668
> Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Cc: Nicole Mazzuca <nicole@streganil.no>
> Cc: asahi@lists.linux.dev
> ---
>  drivers/usb/typec/tipd/core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 02539378ffed..dce0aa8be5e0 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -855,8 +855,10 @@ static void cd321x_update_work(struct work_struct *work)
>  		desc.usb_pd = is_pd;
>  		desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
>  
> -		if (desc.usb_pd)
> -			desc.identity = &st.partner_identity;
> +		if (desc.usb_pd) {
> +			cd321x->cur_partner_identity = st.partner_identity;
> +			desc.identity = &cd321x->cur_partner_identity;
> +		}
>  
>  		tps->partner = typec_register_partner(tps->port, &desc);
>  		if (IS_ERR(tps->partner)) {
> @@ -864,10 +866,8 @@ static void cd321x_update_work(struct work_struct *work)
>  			return;
>  		}
>  
> -		if (desc.identity) {
> +		if (desc.identity)
>  			typec_partner_set_identity(tps->partner);
> -			cd321x->cur_partner_identity = st.partner_identity;
> -		}
>  	}
>  
>  	/* Update the TypeC MUX/PHY state */
> 
> ---
> base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
> change-id: 20261107-tipd-stack-uaf-fix-d3148059c017
> 
> Best regards,
> -- 
> Michael Reeves <michael.reeves077@gmail.com>
> 

-- 
heikki
