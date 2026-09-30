Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13E343897;
	Wed, 30 Sep 2026 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762425; cv=none; b=rGHfzwi2rvkBhqOmLaWypiotIdcmcNRkCdyTmMMeIAktjq7IXWyErBWgaKGFCltSdkDz3TwOGwIRdgDL0DV5iNu+gflcadPZdOjWEm/31vLD4anY1S2r29TqbX856AW5QiJqfkisVDtVoGvqVW+tRv7jUyhqZTYZVqBhxdaLfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762425; c=relaxed/simple;
	bh=ZNr4104Op5u3tfAtfvUYeYZDBwd7YpZ8HbNLGh3xu6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0a1tGq9Y15eAZ/hI3tWP89fZtuf01RA7m7Rgn9UkGaezqBz+W4+ihZVmAJvevSZbGZyx2FTGnQTwwRtSb3mcaHHifWrGL4uPCrkdp9jhQoBLmsclYnaSvJJibz3kT02xZlmaU4vpX/UpufKMIByOTkImZ0oChyx2JlAjA4ndQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W35hUxdO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W35hUxdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790762424; x=1822298424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZNr4104Op5u3tfAtfvUYeYZDBwd7YpZ8HbNLGh3xu6A=;
  b=W35hUxdO/35KoaA6k/KhbZ79jaSEsvliwsBsjw8ebkvo1JCk48HO9DYx
   pe6DRzYfaUgYlbbzZnZVyR/31Q9P44tkhjqnhckFWQep7WUX7DHzz2D40
   ZRH5WACGOtOxpIH0xSSyEXEgn9AYluyRH5JPvwDvJsFELlGvTerobBiGg
   vAIMcQSDUZQo6TS7/MQR8wFrgfKyNQZ1LSFKoKB1m/YDlhZvGeY50QqwJ
   qYX6O96Q8rHp/RhdId8boSKO9Po+ekQsfgOl15TstItktec2Vi30J5kh+
   OvRKHeJmvg6mLbgmQ4kdBavynewYFCdFKJt1Quo95rmV4H65P66sl6Bwl
   g==;
X-CSE-ConnectionGUID: cqQXP7sJStqHPCSY6WZ2sA==
X-CSE-MsgGUID: vVJyuAIHT6mzTOud8xBOCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102869162"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102869162"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:00:23 -0700
X-CSE-ConnectionGUID: XK2gG7/sTeagrMKr1Nab6g==
X-CSE-MsgGUID: dxY15kCcSqKRgH9n22ES5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278988996"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:00:21 -0700
Date: Wed, 30 Sep 2026 13:00:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hui Peng <benquike@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/3] serial: 8250: fix deadlock in
 serial8250_register_ports()
Message-ID: <arzdsky5fd5TbSap@ashevche-desk.local>
References: <20260930074850.465003-1-benquike@gmail.com>
 <20260930074850.465003-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930074850.465003-2-benquike@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 07:48:48AM +0000, Hui Peng wrote:
> In serial8250_register_ports(), mutex_lock(&hash_mutex) is acquired while
> holding spinlock_t serial_port_lock during IRQ chain registration:
> 
>   spin_lock_irqsave(&serial_port_lock, flags);
>   mutex_lock(&hash_mutex);
> 
> Acquiring a sleeping mutex while holding a spinlock causes a
> sleeping-while-atomic bug and potential deadlock.
> 
> Replace mutex_lock(&hash_mutex) with spin_lock_irqsave() in
> serial8250_register_ports().

> Cc: stable@vger.kernel.org
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

...

>  	for (i = 0; i < nr; i++) {
> -		up = &serial8250_ports[i];
> +		up = &serial8250_ports[i];
>  		up->port.dev = dev;
>  	}

What the heck is this?! Please, stop use AI blindly, turn on your brains.

-- 
With Best Regards,
Andy Shevchenko


