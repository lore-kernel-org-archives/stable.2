Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804D38C2D0;
	Fri,  9 Oct 2026 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791587481; cv=none; b=I8OnbPGogAhjZewluhIdE/DMI8mxWIrXAMpZT++v7Gj56ld1fw2x6rYpphHQo6EuyVh+397V64tqUIC2FXXJ8NToDFPGuE9rlyDmQygtS3I6efP9uLUoBsVuBNcJhUKovZaBRpYqhqOxNXBv2oz+XcFtw0ltN1QNPudlpkKLGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791587481; c=relaxed/simple;
	bh=Z6sLO18EhXe6o3prBUltSIYaG8kTg95uwzTzjZ3Rv6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rN395H/LyNsTXL7UdbuZftZ/9Q/Rd5CmVTwhWrPXFSp19TJbVTJubqpVE1VP8FsvBp4eOfTtE1/oVRZVIO4xEBlOVFnKupYy08iyhSBJDPozSVkkrN/Tb08CMbmSsKQj8Yc0YFCP1fIVEwgy2Gj/7PvtUl61APZIfN3r8wnJ2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKWCjiVE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKWCjiVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791587479; x=1823123479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z6sLO18EhXe6o3prBUltSIYaG8kTg95uwzTzjZ3Rv6A=;
  b=NKWCjiVECL7U7z+hu8w0ssUcTzJH7eDJuWalyU5HUE5af5w/ZPuP9o1v
   J3kX3Ua83WF7DiKlGW7JAKSmXG7nQNnN+oCrF3jSC54PFQ2HPhwuvSN7I
   8cs4qVuKMGhIwAJ+2//do0ffUvwoVJ+USmH77Kz7I/QTe6sXvC79GT9gm
   vmIqqfHpChCGuxybVGep72iquL1oT5AhdHHF9HAcQaE2AzrBM98oOx+ns
   xVMbc9fHBJeYakSSqAo/yaEmBXUDtKyN+QaYntj8tyrZjLnbfO4M3hoU2
   1WsRBM0XiaN/1sSsh46eUJ6tR1g87IdAiHqG/5OjvsQL0tdrjiKc+w5TI
   A==;
X-CSE-ConnectionGUID: NmR68vLFQfaxkpdEZEbYyQ==
X-CSE-MsgGUID: wA6e7ECIROun9baEN7GY5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="398378"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="398378"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:11:18 -0700
X-CSE-ConnectionGUID: bhXLb0VWQs2bQMyYf14cvQ==
X-CSE-MsgGUID: Btma+OWfQyuhA/mE3hsshQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="440391"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:11:16 -0700
Message-ID: <cf51aeee-d951-472a-acd1-183028da966e@intel.com>
Date: Fri, 9 Oct 2026 16:11:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] NTB: ntb_transport: Avoid losing QP link-up
 requests
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-7-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260928152550.3354675-7-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 8:25 AM, Koichiro Den wrote:
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

With Logan's comment addressed,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Maybe Jon can amend it on apply.


> ---
> Changes in v3:
>   - Drop the *_ONCE changes. client_ready is now atomic_t.
> 
> v2: https://lore.kernel.org/r/20260910040836.3792333-6-den@valinux.co.jp/
> 
>  drivers/ntb/ntb_transport.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
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
>  	for (i = 0; i < nt->qp_count; i++) {
>  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
>  
> @@ -2400,6 +2406,9 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
>  
>  	atomic_set(&qp->client_ready, true);
>  
> +	/* Pairs with the barrier in ntb_transport_link_work(). */
> +	smp_mb();
> +
>  	ntb_transport_schedule_qp_link(qp, 0);
>  }
>  EXPORT_SYMBOL_GPL(ntb_transport_link_up);

