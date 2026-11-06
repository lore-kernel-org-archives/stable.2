Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964612;
	b=BP9xP2l05GGeGyXHpKmKUSeAuL4H/MJ/BW4bMf8Cxn33r+IhWwboOrr6yuNqGhvA8sLp
	 BWpuPcNkvgYTHSX6JhTvav1ptdPZpCZvcrvd0iiQ0L/YjQpNibrFl55QFX3UXQNbj9IGB
	 UTowjvwXQYxYEc6YnJwgkeSP2kaovMGbmR3l52wLpWIHfp/vuEsCpshjFeTGJqjdSa0Ps
	 Zfju1hoFyMDzHRBJczmYypSgkGzY4jHAyJCsGybWONC/tvmmdCDHZqS16aErrqn15/9Vg
	 4aEQbn1nVyow2S2KIKYOMLi3WkSiS1YKL9XfkhzHM6jXSGy16Byit5nLapwNISxXMoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964612;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=OGu9HnxFx7ILoi6Sr4AwkzoLyqNw7jVxivu5jz9Fz6g=;
	b=QntSDmKDpBCX3HT0djD/ibsIz5e/PRsGOimAN3bpvgbRUV7y2hxciksis7FwoJDbovsA
	 t4nYWeQHXiAvASr0MwZvjL0sJWpwdQHXSlF7OPk7MhtkGvy+1gDtPgChGZY6ARAm3eDd6
	 THRZnxnligMPnImgHz0BuYqYkjrwTMKKeg9vWuV4uhb/84qn0yA+BDS0oaTNmquhB8XBx
	 ae5UtD3+SIEtORgVDZ7unwJo5+4Ci0pQG2JnTrmGHCcIl73cTX+NR4/J5Nb1mArIwgQ7p
	 ULum6AjxmXluZgi3AIiAgsofKwHNBuHVuX1p4pB8gdssu6qv8gNNVlv0Rzf5uekrWxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IbNOfskd;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28151606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28151606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IbNOfskd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793964611; x=1825500611;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GK/563x6tR4WLUFQQaCsN8n/obNWN8uKgyI5EBMWAXM=;
  b=IbNOfskdqx/TYSHXPcTK7OEU/dsF/NeISug26AJQPwHxyo4S/WEnRJkT
   TGsSNEDFjepC8PmQvOf6OC7kRy33X+cAR0K6s6MGt/Mgz6JJa0+WMOBbN
   6wX6N54DtTSDBDfSkAbtLajS8IsN0YUvYoHFJW8/xW9PW8AHbC1x9Nji4
   AmPwcaOtXSoEXzEhOhGdC5CluNsYf0kgRiU0sASVnF3SQgQ2vH8qjLjPK
   9AT+pvo1vyZIZEfLfzq1IU6s0Lba2grzGGm4otoFAc3QRSjHiGiu3+6ox
   WsmQxWFN7RAiYhOhXBVJgv2cBnncs4aNL6/karTjc70JD/T2bicazagWE
   g==;
X-CSE-ConnectionGUID: ISh+hKVrQcSq5edE6cm+3A==
X-CSE-MsgGUID: yw/MhUB0S2WDHJdq6J2xxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2766330"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2766330"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 03:30:10 -0800
X-CSE-ConnectionGUID: ao5OsVLTTIKNcyZdmw0rGQ==
X-CSE-MsgGUID: zv1trccIT/q1DRwV0IljpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7247791"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.101])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 03:30:07 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Wentao Guan <guanwentao@uniontech.com>, joonas.lahtinen@linux.intel.com,
 imre.deak@intel.com, jouni.hogander@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Wentao
 Guan <guanwentao@uniontech.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/display: Don't drop the async-put delay on
 self-requeue
In-Reply-To: <134A26B6BCDD3C9C+20261104053910.1065103-1-guanwentao@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <134A26B6BCDD3C9C+20261104053910.1065103-1-guanwentao@uniontech.com>
Date: Fri, 06 Nov 2026 13:30:04 +0200
Message-ID: <a2b152662d219f9be0861e63ddbb78dd1971dc2a@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 04 Nov 2026, Wentao Guan <guanwentao@uniontech.com> wrote:
> cancel_async_put_work() also clears async_put_next_delay, so moving it
> ahead of the requeue in intel_display_power_put_async_work() makes the
> requeue always use a zero delay. That discards the delay accumulated by
> concurrent async puts, including the 17 ms DC-state anti-toggle delay
> requested for POWER_DOMAIN_DC_OFF.
>
> Use cancel_delayed_work() directly to cancel the stale instance without
> clearing the delay, and clear the delay only after the requeue has
> consumed it.
>
> Fixes: 30ca6365bb42 ("drm/i915: Fix assert on pending async-put power domain work when it requeues itself")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

How did you find this?

Is there a bug report about this?

How did you test this?


BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/intel_display_power.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
> index b000ec001ccfc..7da6eda46e9e0 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_power.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_power.c
> @@ -873,7 +873,7 @@ intel_display_power_put_async_work(struct work_struct *work)
>  	 * Cancel the work that got queued after this one got dequeued,
>  	 * since here we released the corresponding async-put reference.
>  	 */
> -	cancel_async_put_work(power_domains, false);
> +	cancel_delayed_work(&power_domains->async_put_work);
>  
>  	/* Requeue the work if more domains were async put meanwhile. */
>  	if (!bitmap_empty(power_domains->async_put_domains[1].bits, POWER_DOMAIN_NUM)) {
> @@ -885,9 +885,10 @@ intel_display_power_put_async_work(struct work_struct *work)
>  		queue_async_put_domains_work(power_domains,
>  					     fetch_and_zero(&new_work_wakeref),
>  					     power_domains->async_put_next_delay);
> -		power_domains->async_put_next_delay = 0;
>  	}
>  
> +	power_domains->async_put_next_delay = 0;
> +
>  out_verify:
>  	verify_async_put_domains_state(power_domains);

-- 
Jani Nikula, Intel
