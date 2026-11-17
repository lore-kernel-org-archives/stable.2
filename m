Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904364;
	b=jCSQT1PmmUHXkct2vahgEsvXix7mHRIIdgxXWMSCHynpIqH6pWdCVeeLKslEPVWAOcRY
	 sSHw9UjdVWS3LyCZhnMB0o8rJYUEO+MOvNp7TyRB0aYtXWJNyZzFFRH78HJ6q9Fi8y6Jx
	 B+rHvUlbB0nGjImkVhkvB9euU59bsc36WqPZ2+fPxIBFRGhpSLolkyVyLSJSu7qDR0T0V
	 JbXb0R6Je+L4C+Z8JYro6RE2hIyyDzHxAHgwnplZvLBsH+u01s8MyADVyGX1QFwgjLJ14
	 Z1INEhGxxVoLe9KbTJJwGPOG8Va5G03KRsGRler47bMGw2xRLAMS1hgZFr6gvbFwdMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904364;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qT/GxZKneo09loIC89K7UNfruX6wedJ0GdqibzloJ4c=;
	b=5ZPnSVurN7Xmoug9jJN1+AeK+FTf9yvSGxk5FvFbRiR5GoNHXaeWD6d7Ase8hTgUGv/v
	 m3FfhnjCdVyahKhY7lSqDpnk4mnW5G/NXZ7n9SY0mxYlaCvSeTYdHbL3wQvSni5HaMcMP
	 UdQwlVGOX9t/hR8ZoKb+xZQbaYX8BfIkGP1RSj7XkQsRdxQ3t8fW7TZieNZjAHWxa1FCb
	 KhK3nWtePhI/2T7OdXMEAO+qzjEaVdyFJSUtZPxzsRsiLauYI2G91+JOSrcb0jQVYnVJH
	 IXlzE+MyST45Ay4h2bLIKp7sRqjuanjM6yesze9p4pI2MRPxAS179xTtRZgWLjFrgCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LodsMxHb;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F2606A89D;
	Tue, 17 Nov 2026 08:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9F2606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LodsMxHb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794904364; x=1826440364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RBaiDKa5KQHKUGLX8tosbZklIhnurgIaIixT+p1pGa0=;
  b=LodsMxHbOFrgr8HRY0atR38+kLh3i1J1cRAdZjZFBKuxQzYtosqSv9go
   gWkuhXyNf56meZJ4ebJkEbJI78NUc0Z8Gx2htvrW5bpV3wijmT52o5GuL
   Rn3qKpHDfYuIZbnDqE+1KCs40Szd3Lu4yCnf0tenS1dr0HApCo8PmZaEx
   DO6Nal5AWblx43zMGzQSAjboggGxH0aykAkRdY/N5ZNLPkmZzNzWgmD4W
   8qIYUxRQzp2MDImtRlMWKsrPsxAg//0LM12EHQdDRnLYxaj+9OAStxUap
   ivXiFfFF7hJ+df56Fr4fSo4cSUL3tL0VH7k8sRGXUGVIOTqIpoG5Aj6W7
   g==;
X-CSE-ConnectionGUID: /ft/JSL1R9+4MGOUw01NDQ==
X-CSE-MsgGUID: TYrJ2+w9QfmR8HeApSzrqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3563659"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3563659"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:32:43 -0800
X-CSE-ConnectionGUID: 4vQ+GT8SSbWfgmn7sOY5Yw==
X-CSE-MsgGUID: id8OoRQzQvaHotgUkI7B5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10305375"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:32:40 -0800
Date: Tue, 17 Nov 2026 10:32:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/8] gpiolib: wait for pending label frees before
 cleaning up desc_srcu
Message-ID: <avwRJl8CFgKLNLCC@ashevche-desk.local>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
 <20261116-gpiolib-chip-removal-v6-1-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261116-gpiolib-chip-removal-v6-1-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 03:47:04PM +0200, Adrian Ambrozewicz wrote:
> desc_set_label() frees the old label with call_srcu() on
> gdev->desc_srcu, and gpiodev_release() calls synchronize_srcu() before
> cleanup_srcu_struct(). synchronize_srcu() waits for a grace period, not
> for queued callbacks. Once the srcu_struct uses per-CPU callback lists,
> a label freed by gpiochip_free_hogs() can still be pending, and
> cleanup_srcu_struct() warns:
> 
>   WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x239/0x330, CPU#0: init/1
>   Call Trace:
>    gpiodev_release
>    device_release
>    kobject_put
>    devres_release_all
>    device_release_driver_internal
>    platform_device_unregister
>    gpio_sim_device_deactivate
> 
> Use srcu_barrier(), which waits for them.
> 
> Reproduced with a hogged gpio-sim line, setting the chip live and back
> on a 4-CPU guest with srcutree.convert_to_big=1: it warns within 60
> cycles; with this change, 1000 cycles pass.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


