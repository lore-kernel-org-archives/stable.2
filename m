Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B9476CEA;
	Fri,  9 Oct 2026 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791587353; cv=none; b=nJY90zAEg53Ywvv0x6r/aY7/qp47PuliZYic/waUdp8TFkpyWOK9E/m3kxLYjwXj47BZW/CUs1tyf1caUE5OyZZzEa3EaaOyk/pvEK3BexJeC6hB8MLZQfiYrwDbgNClmOIOWu7pd9PCzetmRwwYYhCi+XIxqRM7WGWh4KI4UWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791587353; c=relaxed/simple;
	bh=Zb+up4UzGzW05Grz1+zFFjqWdWMYcdlwJgpnbRbBdac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c24lzyWqYISk7ZBPCz0QTAGZ/Ed4+vNvlPA/rSQgm5Z5HYF81yxME5bRGi/sGimbtWDV/qBgQsVaCDyP0ZChn4yPY22GI/Fd3Jm5S0ZpeQoITtvkhCR35FAPPAgmh5u2ElEQdc+WCpOGQRZr2UySurbmRjdi25QIXaYaT8TfpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqLZUolB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqLZUolB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791587353; x=1823123353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zb+up4UzGzW05Grz1+zFFjqWdWMYcdlwJgpnbRbBdac=;
  b=GqLZUolBT60sBd2eu/DayvtwZGlku0dcPIr0i1cZqnAGg2cAsM+kSZKW
   y/hYWwT0JcG73caqwcqfAizNsqfyTPf26opzAgHmMPs+tzI2O5ceZbK6c
   Wke/inMTKZI1Rz6rQc3FoB5eZ5khrLo2VoVjSGZA5Rv4I/6riQCjDyuqp
   5oQ3pB+BK0u+q7zG28OkbKT5X0I9ejak1XROXVCFLnJgJR9eOfcsxYCO2
   xw5twIGSm+NCswCw+cZIYsFBm1kgEKcnRSzxXMJ9yQ+Y+AL/RHVELhWwq
   oo13xkiw7hzXVwjy+FDwdFfLYDLuozFxUZ4kOF5ZqZS9UTv2H8O2z7Oe0
   A==;
X-CSE-ConnectionGUID: Fwxe2v4NR5ytHDtLWllDMg==
X-CSE-MsgGUID: rWebPYJjTUeQD5PSq7Ic5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="398284"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="398284"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:09:12 -0700
X-CSE-ConnectionGUID: ozArYacaSWSNgnc/B0ksWg==
X-CSE-MsgGUID: pNi4vM1oRRisnM1w/E6idg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="440269"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:09:11 -0700
Message-ID: <e43ca753-175d-483a-940e-51e2a5757991@intel.com>
Date: Fri, 9 Oct 2026 16:09:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] NTB: ntb_transport: Avoid deadlock when
 cancelling link work
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-5-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260928152550.3354675-5-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 8:25 AM, Koichiro Den wrote:
> During initial link setup, ntb_transport_link_work() can retry with
> nt->link_is_up still false. A retry can block on link_event_lock
> while cleanup holds it and waits in cancel_delayed_work_sync(),
> leading to deadlock.
> 
> Move the conditional cancellation outside link_event_lock, before
> QP cleanup. Keep QP cleanup and MW release under the lock so link
> work cannot restart QPs between them. Put the locking in
> ntb_transport_link_cleanup() to cover both worker and remove paths.
> 
> Fixes: 3db835dd8f9a ("ntb: Add mutex to make link_event_callback executed linearly.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v3:
>   - Use atomic_read() for the cancellation check instead of taking
>     link_event_lock.
>   - Carry over Reviewed-by.
> 
> v2: https://lore.kernel.org/r/20260910040836.3792333-4-den@valinux.co.jp/
> 
> @Logan, with link_is_up now atomic_t, I dropped the mutex acquisition
> around the cancellation check. Would appreciate another look, thanks.
> 
>  drivers/ntb/ntb_transport.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 5d2ec484c3df..8941da0b3d61 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -962,6 +962,11 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
>  	u64 qp_bitmap_alloc;
>  	unsigned int i, count;
>  
> +	if (!atomic_read(&nt->link_is_up))
> +		cancel_delayed_work_sync(&nt->link_work);
> +
> +	guard(mutex)(&nt->link_event_lock);
> +
>  	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
>  
>  	/* Pass along the info to any clients */
> @@ -973,9 +978,6 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
>  			cancel_delayed_work_sync(&qp->link_work);
>  		}
>  
> -	if (!atomic_read(&nt->link_is_up))
> -		cancel_delayed_work_sync(&nt->link_work);
> -
>  	for (i = 0; i < nt->mw_count; i++)
>  		ntb_free_mw(nt, i);
>  
> @@ -993,7 +995,6 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
>  	struct ntb_transport_ctx *nt =
>  		container_of(work, struct ntb_transport_ctx, link_cleanup);
>  
> -	guard(mutex)(&nt->link_event_lock);
>  	ntb_transport_link_cleanup(nt);
>  }
>  

