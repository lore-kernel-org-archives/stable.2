Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470B3DAAAF;
	Fri,  9 Oct 2026 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791587523; cv=none; b=kYG2nUQMmiRfpXelFHwxF45Y8Na8eNbVi8CIFYJcFGs/mRicbQOAfWEajbutY/3NQkrlFrlRve0yPoR69lRA+44aWFwT+4ga7RzW+bbbtbDwZ0AHATQH0gENtuBBz6AOCn8uoZ6vJzGnh15Em2U9qaqA7khzBJCmHw1ZY5BagX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791587523; c=relaxed/simple;
	bh=GUK2rDnwBN+YuZ8PDGY0UOOLtxAxFH9Pz5ThhdA9OSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZmcf3IY5CKeWRoZq8mvbMG2dq6NcDyVQG1VjeQAPGH3DPpnQvXizBveHod0TJMwr97znAAyNjr0B0SepShqxyT7qqSEX6m879oYb0kPRdCKPBzsnrN/zsLHyPMRV2w5IxPchJ3Rn/7OsY2eGY0SbZN+92mp/geLAom8k3pUmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0gyHQZ3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0gyHQZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791587521; x=1823123521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GUK2rDnwBN+YuZ8PDGY0UOOLtxAxFH9Pz5ThhdA9OSQ=;
  b=B0gyHQZ3D0X5yFx12vOYIAuEO2su5tgCqHvLW+aMkEMw6D4Zec0dhQMG
   4V0ToR9wzOOIa0ATR3xZizyZ9SNMWOahEHkA20wGhCtrsJHnPmzBeExcB
   FrzYT7EDU0oWr4AQmt5d8iWW/mWDpT3BCROwj0QsoC7YmRKHLh8IpvyiC
   8uveV2bPXGipn/B8VoPIiLDTsMkL13np+hxtEe3vZqr1b1OdwQfKrwbZ1
   EqcNJZ/PEiRZG4sg+g9IWILO/nKOkYpi8Aex9srmVOVd3WQ4Zr/ByZUBc
   BVZz9ax8mYWKYncSZ3DjTcErm7gOZQ37wDw9uR+YVnrc/+bbM9IaM+156
   Q==;
X-CSE-ConnectionGUID: qpL4Al4jQAytPHYL1qkXiA==
X-CSE-MsgGUID: VLGHUt0kRNCj5Q2/usX/ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="297596"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="297596"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:12:00 -0700
X-CSE-ConnectionGUID: bvyPm5ccQgufkvuq4LTmng==
X-CSE-MsgGUID: LseLmrueT8KGbWjSWfr9eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="877558"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:11:59 -0700
Message-ID: <3cacaab6-c90a-44ee-b357-65ffbd1b8ade@intel.com>
Date: Fri, 9 Oct 2026 16:11:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/15] NTB: ntb_transport: Stop QP work before freeing
 a queue
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-9-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260928152550.3354675-9-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 8:25 AM, Koichiro Den wrote:
> ntb_transport_free_queue() cancels qp->link_work but not qp->link_cleanup.
> A peer link-down message can queue cleanup while ntb_netdev is freeing
> the QP. Cleanup can then requeue link work after the queue resources
> have been freed.
> 
> Disable and wait for cleanup, then link work, before freeing resources.
> Unlike cancel, disable also prevents the RX tasklet and transport link
> setup from queuing more work. Enable the works only after queue creation
> succeeds.
> 
> Clear client_ready first so RX completions and transport link setup see
> that the client is no longer ready. Clear link_is_up and active after
> the workers stop, since link work can set both back to true.
> 
> Fixes: 7b4f2d3c3b82 ("NTB: No sleeping in interrupt context")
> Cc: stable@vger.kernel.org
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v3:
>   - Clear client_ready with atomic_set().
>   - Carry over Reviewed-by.
> 
> v2: https://lore.kernel.org/r/20260910040836.3792333-8-den@valinux.co.jp/
> 
>  drivers/ntb/ntb_transport.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 571d633c4f0b..556e1d255284 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1239,6 +1239,8 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  
>  	INIT_DELAYED_WORK(&qp->link_work, ntb_qp_link_work);
>  	INIT_WORK(&qp->link_cleanup, ntb_qp_link_cleanup_work);
> +	disable_delayed_work(&qp->link_work);
> +	disable_work(&qp->link_cleanup);
>  
>  	spin_lock_init(&qp->ntb_rx_q_lock);
>  	spin_lock_init(&qp->ntb_tx_free_q_lock);
> @@ -2152,6 +2154,9 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  		}
>  	}
>  
> +	enable_work(&qp->link_cleanup);
> +	enable_delayed_work(&qp->link_work);
> +
>  	ntb_db_clear(qp->ndev, qp_bit);
>  	ntb_db_clear_mask(qp->ndev, qp_bit);
>  
> @@ -2197,6 +2202,10 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  
>  	pdev = qp->ndev->pdev;
>  
> +	atomic_set(&qp->client_ready, false);
> +	disable_work_sync(&qp->link_cleanup);
> +	disable_delayed_work_sync(&qp->link_work);
> +	qp->link_is_up = false;
>  	qp->active = false;
>  
>  	if (qp->tx_offload_thread) {
> @@ -2244,8 +2253,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  	ntb_db_set_mask(qp->ndev, qp_bit);
>  	tasklet_kill(&qp->rxc_db_work);
>  
> -	cancel_delayed_work_sync(&qp->link_work);
> -
>  	qp->cb_data = NULL;
>  	qp->rx_handler = NULL;
>  	qp->tx_handler = NULL;

