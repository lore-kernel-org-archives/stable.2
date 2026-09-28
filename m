Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF01367F26;
	Mon, 28 Sep 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614644; cv=none; b=YxBLjrVib59QAuDsuR+aqbNAgbW0LAgKZ2WDSzV4vTAeee6wpDB52bKa69Mt5odkF5X4Q4P2jBjodLH1Y2XTTgicRAEkY1xl5jG0/b04Idso3IKZNcP55cRcOM6q+JvV3KqFHZoJJX128vLfZbkB8lOAY3vhwM3C4wTY/IhaHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614644; c=relaxed/simple;
	bh=edQ8OKVpoBcCK5pL9fIA53ajMPlMAuSTnCrxbaGT85w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=UVYgiV/gWNVbPJn0xFS5JTw7Xi8XGNkqu+5BQ/Om+gzknGndOt/wJX3r/dADJOuiShjiJR2OZwt5DGzeWQc4aanSBEyBYIbJr9xOGgNbQ3RyHtwRdq0R0wZZIvSQDsYjRcWcplES8+5IFpfS3MpvKIbUNCbqlomHIUE79fgvKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=qvT2itlJ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="qvT2itlJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=E3Vil3IB8YG9zel+yDOGhB3iTU71Z7/tffn36RqQM4g=; b=qvT2itlJQP6YSTOgZ+jaIv47K6
	GHAy2nrBsxntYICQK+PLjsOxNVRFpBT9dIwiahW7MdHg1InOrSHVcq+yu18s1ZZkYApaHJRVjPljO
	4pdxUNCjNOd1eIlKPSVMc36B0xWkl8AiHNOc1gbxQAp0VUPFDz7h2yrmPf6cTPgS0g6SuCsI7pzzM
	/godnXp9/1LTt/tG0FqwEEZmrbSGjnak7OX5t0ECKecKEj2plAu2c+MUflGp7yhK644dc4fToYbtr
	dxoJTSFpevUVM95E2NMswjUgZ7Fxn2gGr+LmqFw6DrPyYVXoxSAnvt+rq4GVH0p0HcrPEFS3K1UBT
	8d21Ffsw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xBEfG-00000002aLo-3knH;
	Mon, 28 Sep 2026 10:57:20 -0600
Message-ID: <49bb5e64-4428-4133-b201-e7475fd07f1d@deltatee.com>
Date: Mon, 28 Sep 2026 10:57:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Frank Li <Frank.Li@kernel.org>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-7-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260928152550.3354675-7-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v3 06/15] NTB: ntb_transport: Avoid losing QP link-up
 requests
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-28 09:25, Koichiro Den wrote:
> ntb_netdev_open() can call ntb_transport_link_up() while the transport
> worker is completing setup on another CPU. Concurrent transport setup
> and a client link-up request can both read the other's flag as false and
> leave QP link work unqueued. The QP then stays down until another link
> event or client link-up request.
> 
> This is the store-buffering pattern described in
> tools/memory-model/Documentation/recipes.txt ("Store buffering").
> 
> Add a full barrier between the store and load on each side.
> 
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Thanks, I find smp_mb calls difficult to understand, but I think these
are correct. I expect I ran into this problem a few times back when I
was working on this code and had no idea the cause or how to fix it.

I have one minor suggestion below for the comment, other than that:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 51d9e9969065..d290e5869c21 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1101,6 +1101,12 @@ static void ntb_transport_link_work(struct work_struct *work)
>  	/* Publish the link only after every QP has been set up. */
>  	atomic_set_release(&nt->link_is_up, true);
>  
> +	/*
> +	 * Prevent both sides from missing each other's flag. Pairs with
> +	 * the barrier in ntb_transport_link_up().
> +	 */
> +	smp_mb();
> +

I don't find this comment all that easy to understand. Can we expand it
a little? Maybe something like:

 Order the link_is_up store before the client_ready loads below, so
 that this path or ntb_transport_link_up() is guaranteed to see the
 other's flag. Pairs with smp_mb() in ntb_transport_link_up().


Thanks,

Logan

