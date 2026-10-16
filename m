Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE744AB68;
	Fri, 16 Oct 2026 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145992; cv=none; b=H3WYVtX4D8+d3SHxg46uD7NwAQ7Mcc5L9GbRUHyMDF+Vz61Ui22GzD+UZOnVtKgzN7ndQsdTsizw5rxve4KeAyAxZmLTnX8tqcyxxFbUeS1fOfwLPak9Now1VQGl4ph4i0SYWsqrwQxWLoaMYnJJTvIj94A8WRn7j0O1l9HjCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145992; c=relaxed/simple;
	bh=mV7apZJqXyrvkEGiIS0ISDfMrDM5bR6Fa2lY+w1Z2RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCmWKcKI/9HhnyCKmZBEd/tN/3DjT0sNwjfSPm8mm692Oxw7ZtYWk7rfiUyNb2swPCVQFtDFVnTHisZGAjgcMcgHezrZ9CksE/q262rzruThCK2SkPzFjcY9LIsKnQGKQMBhjbPlYkjR7oSIUsV28uRahDaZvUoIki4wMtEY8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ry7CRrD9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ry7CRrD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792145991; x=1823681991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mV7apZJqXyrvkEGiIS0ISDfMrDM5bR6Fa2lY+w1Z2RU=;
  b=Ry7CRrD9TpQ+m7XYL6cGXe1Nos35A+mdQZesw8bnAnE9eHjkX/1U0k6L
   fOPBJgG1mqRHQfaDL6RajyLjNH0W9C2YXCew2cDu88Dxy2mh3VH604FwG
   au0VqKExa/G95TyvA3y9SMkR3+ba+/2ixhjgdTwgadRBFjK4HoKcaN2MB
   ZLM5QQs0JksYL5qb/5hcbbjDzvitBrv0UZ5x8g2gz25fDus7OhxGTcJPk
   Ku3dNPsMsvhzr0aAHFcp1yqWrcfgYVFsbk4ZbvNxSHvv2YFkzshV78ZvC
   SeFMUy6EKHs0gqxwfh0sH6r23W//I0SpXn/9ta4xq1tseKI3TBz2sfUoR
   A==;
X-CSE-ConnectionGUID: /Jc/6u0WRF2b2buHB45Unw==
X-CSE-MsgGUID: HmztS/E+QHmZ3YEquonuwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="818260"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="818260"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 03:19:51 -0700
X-CSE-ConnectionGUID: VwgXEHenSZanZL/0PWwHRg==
X-CSE-MsgGUID: qfMmHcJEQR6A6fktOcfTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1795965"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 03:19:48 -0700
Date: Fri, 16 Oct 2026 13:19:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix parsing of all FIFO frames
 for odr change
Message-ID: <atH6QdvvmEPzkGE2@ashevche-desk.local>
References: <20261016-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-v1-1-b2bb168a0551@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-iio-imu-inv-icm42600-fix-odr-change-event-in-all-frames-v1-1-b2bb168a0551@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 11:28:10AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> For getting all odr change events, we need to parse all FIFO frames
> in each iio device. Fix this correctly by sending effectively all
> frames to all iio devices.
> 
> Previously only batches of frames containing a matching sensor event
> were sent to the corresponding iio device.

...

> -		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
> -		if (ret)
> -			return ret;
>  	}

+ Blank line.

> +	ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
> +	if (ret)
> +		return ret;
>  
>  	/* handle accelerometer timestamp and FIFO data parsing */
>  	if (st->fifo.nb.accel > 0) {
>  		ts = &accel_st->ts;
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
>  						st->timestamp.accel);
> -		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
> -		if (ret)
> -			return ret;
>  	}

+ blank line.

> +	ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
> +	if (ret)
> +		return ret;
>  
>  	return 0;
>  }

	return inv_icm42600_accel_parse_fifo(st->indio_accel);

?

...

Similar comments to the inv_icm42600_buffer_hwfifo_flush() changes.

-- 
With Best Regards,
Andy Shevchenko


