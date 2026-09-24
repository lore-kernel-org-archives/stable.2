Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC603EDE60;
	Thu, 24 Sep 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281462; cv=none; b=kH9sp32b0rMY+/uVhwH1uXT0TQmMAoKONMwF6iIuWQ7cNCvUtUqm/hFnd/GIJdZN3AVJS8fIYbm9me/IwJTQ9wrkLB/KNkc0vsjIlK0ww4qEb8fl0ZU9mtBZUJDPu11chpNKsbcLtYVBhn0QQIQkuj7xA60wcbKFyqVkQQSli2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281462; c=relaxed/simple;
	bh=/YO9vtXnYRZYpwUuNi7BudDdQUON8T54C+wtE6E7CH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUxCuwGnRV66Y4DekScvqyYFSAFo8fZzCuYR6FGaS4S43rRap0bk6dULeNuX0TYuCyRtGrioXwSsLJ3sj2XVnbSSY2t1zSdqwP+C86x0D2fEPKA/zAgqrVyQ8eoq+03p5NJhhZ9Phq/T3CuGp20U7Q83Wqn1O2RaVIdPub76IQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IA7pM3eH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IA7pM3eH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790281461; x=1821817461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/YO9vtXnYRZYpwUuNi7BudDdQUON8T54C+wtE6E7CH8=;
  b=IA7pM3eHEXtXTvQfKKAGkxjPuofZelFzhO8+tJYsYPLTsXnPBaFivJk8
   m+1ll8JJB5HtQZwGZlEJJ/6DnnddJM0FA7o898qreeTdKs2i92GuWHXth
   w7Cdxiz/dcNvD8PIMxz3p99NOnTcZGu9HzGbqh3MvaIO4iQO7aXcMWqNp
   DqwNtmPK4KDgQPnUtrUsl5FPgdMawT0wlqXcatqMUGqPUu9UoLG/5K60N
   oza6s6IZwWGGJnb4wOF7Aq2lEbEg9J7wvR+nzTxK+ce70e1B1jRF+Glyw
   BwRwhV4lsSEr5Ph2OfaqXRsa9Y4mc0N+9oGDGhS2ORj4T20ULY7L9uG5O
   g==;
X-CSE-ConnectionGUID: Q4va+WfWTYyHKj9xcYmOyA==
X-CSE-MsgGUID: ClTvms+STkSoOjbIMT5gog==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93786435"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="93786435"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 13:24:20 -0700
X-CSE-ConnectionGUID: pzjEeuGEQtyDDHYUNPK4Cg==
X-CSE-MsgGUID: zegf+RqHTAKYh0KImDuI+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="273340975"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 13:24:17 -0700
Date: Thu, 24 Sep 2026 23:24:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hui Peng <benquike@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	john.ogness@linutronix.de, ilpo.jarvinen@linux.intel.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] serial: core: reject baud_base values that overflow
 port->uartclk in uart_set_info()
Message-ID: <arWG75X9_uR3bgg5@ashevche-desk.local>
References: <90ddd895-856a-f7ae-162b-c80a6042d788@linux.intel.com>
 <20260924060511.2364717-4-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924060511.2364717-4-benquike@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 24, 2026 at 06:04:46AM +0000, Hui Peng wrote:
> In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
> uport->uartclk (an unsigned int):
> 
>   uport->uartclk = new_info->baud_base * 16;
> 
> While uart_set_info() checks if (uartclk == 0) and
> if (new_info->baud_base < 9600), when new_info->baud_base exceeds
> UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
> by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
> (16), bypassing both uartclk == 0 and new_info->baud_base < 9600 and
> setting uport->uartclk = 16 (baud_base = 1, well below the required
> minimum of 9600 * 16).
> 
> Reject new_info->baud_base > UINT_MAX / 16 before multiplying by 16 in
> uart_set_info().
> 
> Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
> &ss) with ss.baud_base = 0x10000001 on /dev/ttyS1: on the unfixed kernel
> TIOCSSERIAL succeeds (ret = 0) and wraps uport->uartclk to 16
> (TIOCGSERIAL reports baud_base = 1), whereas with the fix applied
> TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.

You should not do a reply into the same thread. Also I guess you missed my
review comments on one of the previous rounds. Taken all into account, please,
check that you addressed and/or commented on all remarks given by the reviewers
and prepare v5 accordingly.

-- 
With Best Regards,
Andy Shevchenko


