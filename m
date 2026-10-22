Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678405;
	b=dS9t3CRkEq/LhKsNRxCKjpoXQPjSXFxQrKCf3ATXqghkR4AjcF7IgUH40t5hUWQoU+Cc
	 U8UJon1g8vchEwvmzeO60IgTelgmO0TSk/sNhC8rfsMC10OaXYw2NpMl8m0o3vvSgcWxA
	 RmTXcbTGd9giWqJCqDqacfBhpI/FJ8eyMtUW71QIQMIjr9MQRCcd5Vv9CXSdTgXtPWMLq
	 6pwGY7JLiiQUEw43eiJk6pj8iZXTAAClN8nLzDGP0+14QJy/4OvSrtjSTJLUk2g4tD/SX
	 +/4LUilWKSgsSem27KtPbQCNeWouP4Ftojz5bfQLtxuIgjirCt1pulOXtdG2aTBVkdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678405;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=iwTJzx5OtydxDTgFrFcMNZkgjWKE8i5gpoiUX72tB4o=;
	b=OV450tezmzW95s1Ul7z1BOtBFmbkjVpBwCm1h3cjj8gfL8QkYm+ajyGteGLxSIHFGITx
	 XCgJzeINLnLUk+NK9PoKkiqYbtURc77L8rmyFZse0kTNHJhuxVTs4rAS23Lt6qgi6Pd74
	 02A+PzPc7Pn2sNQ7NmHojCzzIyY7RRmTqdLP6Mnww7fZXtF3QowyFBvycekZsNdvK2Oac
	 q2TwfuGaKmr6/dF372pnZyEivSzxbml63EKDpFwBUqbFPlcgvVLM0d/QyS9tM0/UD3NH/
	 8rh3wdfmtV/B4syM/9Ixx7alSrVn8FgIKiITeWx+m17u61BgrQ7mJfU1KiTF429rTsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=keGuSoB6;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA8606A31A;
	Thu, 22 Oct 2026 14:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8EA8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=keGuSoB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792678404; x=1824214404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cw4p9aJtCbmwDNZsvzHrhxJH+Bk/E9kyYxxPz/Yv2Z0=;
  b=keGuSoB6s0RHCVdlDcwaJxTcQ11MFeq6ydkws6OIbDmCxhDu2GuDTp4d
   64aiLz0dopFPW2YK3r0nFcNUwSVKeOMGTy7zEV+jnyFqyAK2zC1uvY4Ne
   Sld5LH2HK+pVIJS6pNFsNx0cwAeKhCWu3+AiyNkv0YZNbGyE1hoLtTLSt
   HUWXpr7x7mYZMHycotOrz9ivPHn1RyvmflA3yFperVgfYbTVWS1OO+EhI
   t8ZXLtE/mDJSdjc7skV8SzVo11vSaAwzOdm0qASRK9VpgqtVufK3c8yM3
   YdGM0gvt1AhWo5zFU80RChC5Nofhc+Tid1tVRTIQtQwQqpHB52BvxIyQU
   Q==;
X-CSE-ConnectionGUID: LbGFSruTSKKHFkokrYeJVg==
X-CSE-MsgGUID: HOrAUeUSSbCbNCrhw1nNPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1301233"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1301233"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 07:13:23 -0700
X-CSE-ConnectionGUID: cqNWCnQLSqygkJJdm1Oujw==
X-CSE-MsgGUID: 3ZXlAOZ8Rq+hnjNVIkXUfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3317105"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 07:13:20 -0700
Date: Thu, 22 Oct 2026 17:13:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Christopher Hoover <ch@murgatroid.com>,
	Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] HID: hid-sensor-hub: Synchronize callback removal
 with raw events
Message-ID: <atoZ_bKG7nTdmtXl@ashevche-desk.local>
References: <20261019023420.83976-1-ch@murgatroid.com>
 <20261019023420.83976-2-ch@murgatroid.com>
 <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 06:21:45PM -0700, Srinivas Pandruvada wrote:
> On Sun, 2026-10-18 at 19:34 -0700, Christopher Hoover wrote:
> > sensor_hub_raw_event() holds pdata->lock while it looks a callback up
> > in dyn_callback_list and calls its capture_sample() and send_event().
> > sensor_hub_remove_callback() takes only dyn_callback_lock, so it can
> > unlink a callback and return while another CPU is between the lookup
> > and the call.  The sensor drivers remove their callback in .remove()
> 
> Two spaces before "The".

Which is not that bad [1], right? It's consistent in the text.

> > and keep the struct hid_sensor_hub_callbacks in memory that devres
> > frees right after, so a report racing an unbind can call through
> > freed function pointers.
> > 
> > Take pdata->lock in sensor_hub_remove_callback() too, outside
> > dyn_callback_lock as in sensor_hub_raw_event(), so the removal waits
> > for a report in flight.  pdata->lock is otherwise only taken in
> > sensor_hub_raw_event(), and callbacks are removed from process
> > context.

[1]:
"Using two spaces after a period is not strictly "wrong," but it is considered
outdated and contrary to modern typographic standards."

...

Yeah, it's a slippery slope of yet another holy war, but I think this
kind of a style is a last we should care about (main point is to be
consistent in a chosen style).

-- 
With Best Regards,
Andy Shevchenko


