Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363832E12E;
	Thu, 24 Sep 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253006; cv=none; b=X8r906M9LRQT02SWPw6MCMg83KytDrTj7leIKvfdLxrigXjrXgTwWw0ouufrSZIHyJCZvI0ub06CJ4hcf4RMlBhmGz2OLyPo4N5++NPfOspzMijpA0VcunEBJlBORQU/BH8tGsdiMOahOBOrq2oMsy6dw8wYvqtULoDWoffZGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253006; c=relaxed/simple;
	bh=f+MVWQmcnSQ+UPKx5gJICWDkBFHUiYEkQVbJJEz2JWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rca7qf09h35/PIBHdAKDwU0iFFSL+YlLpv83qXazMBGP/UD5jQ/zfcAj7bO+R+qJWHqQNT6zcexGisUYJE3G6YfsGnQAUyjNq9OYIHUM7tRlbGxbNpka7V8tEMIYEMjldmVTl1TKSMVNirIi4LhIOXWOEBsWKCjaHisiUSn7Hkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHtCv02O; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHtCv02O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790253006; x=1821789006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+MVWQmcnSQ+UPKx5gJICWDkBFHUiYEkQVbJJEz2JWw=;
  b=GHtCv02OYLk42DQ6HoSPaeAqy8hEzl1qmPg13zV+7VJDYAJbMmHryATP
   Kzmscov3Ru9saUI5lMXxErtCSK1gPPwKCFYqxybRIglqMg8n+Hr4Eznpl
   WFMlbCZpcXf2b/fI+1aS2sxwy+dZtBXekn0sKgFZCoF9Q3K9WDnq616kV
   mEIo/yWBRRRlEJtdkGZfEAffYEyGunQT0e+v6/VpH+UMRi3bBGZv8xmQ+
   v6TR8h84SrpUuklBSFASmRfSyUVUCXDZerCbzhpNnaxq80S0rOsn8SrP/
   S0+DWFPMvPNSLemJDUvY6MSEWU4H7qe0qBR5I4EGONX0H91XKRug9f89s
   Q==;
X-CSE-ConnectionGUID: WdhdDCGqTimDO4yFWfKmoQ==
X-CSE-MsgGUID: PrlFyoHtSuKBDOxCMMEUPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="112806613"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="112806613"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:30:06 -0700
X-CSE-ConnectionGUID: PcJOzqv7S4WNy8FZlClREQ==
X-CSE-MsgGUID: DpXCHyF+Spi3++WnhdBkUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311927677"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:29:58 -0700
Date: Thu, 24 Sep 2026 15:29:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hui Peng <benquike@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	john.ogness@linutronix.de, ilpo.jarvinen@linux.intel.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] serial: core: allow third iteration in
 uart_get_baud_rate() fallback
Message-ID: <arUXxEZo2374oRpO@ashevche-desk.local>
References: <20260924060511.2364717-1-benquike@gmail.com>
 <20260924060511.2364717-3-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924060511.2364717-3-benquike@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 24, 2026 at 06:04:45AM +0000, Hui Peng wrote:
> In uart_get_baud_rate(), when the requested baud rate is out of range
> (try == 0) and old is non-NULL, the function copies the old termios baud
> rate into termios, sets old = NULL, and continues to try == 1. If the
> old baud rate is also out of range (for instance, after uport->uartclk
> was lowered via TIOCSSERIAL so max = uport->uartclk / 16 is smaller than
> both the old and new baud rates), try == 1 clips baud to [min + 1,
> max - 1] and encodes it into termios via tty_termios_encode_baud_rate().
> 
> However, because the loop bound is for (try = 0; try < 2; try++), the
> loop terminates immediately after try == 1 without re-evaluating
> baud = tty_termios_baud_rate(termios) for the clipped rate, hitting
> WARN_ON(1) and returning 0, which then triggers a fatal divide-by-zero
> (Oops: divide error) in uart_get_divisor():

>   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x136/0x260, CPU#1: init/1
>   ...
>   Oops: divide error: 0000 [#1] SMP KASAN PTI
>   CPU: 1 UID: 0 PID: 1 Comm: init Tainted: G        W        N  7.3.0-rc3-g5dd1818b15d9 #1 PREEMPT(lazy)
>   RIP: 0010:uart_get_divisor+0x5b/0x100
>   Call Trace:
>    <TASK>
>    serial8250_get_divisor+0x123/0x1a0
>    serial8250_do_set_termios+0x21e/0x1610
>    serial8250_set_termios+0x77/0x90
>    uart_change_line_settings+0xf6/0x720
>    uart_set_termios+0x1c1/0x5b0
>    tty_set_termios+0x5f7/0x920
>    set_termios+0x533/0x7d0
>    tty_mode_ioctl+0x8e4/0xd10
>    n_tty_ioctl_helper+0x3c/0x270
>    n_tty_ioctl+0x4e/0x2c0
>    tty_ioctl+0x1028/0x1480
>    __x64_sys_ioctl+0x184/0x1d0
>    do_syscall_64+0xda/0x4b0

Submitting Patches suggests to leave only ~3-5 *significant (or important)
lines of traceback. At very brief look the last 7 do not add any valuable
information.

> Increase the loop limit to try < 3 so that the clipped baud rate encoded
> on try == 1 is evaluated and returned on try == 2.
> 
> Tested in QEMU against Linux 7.3.0-rc3 by setting /dev/ttyS1 to B115200,
> lowering baud_base to 9600 (max = 9600) via TIOCSSERIAL, and calling
> tcsetattr() with B57600 (old = B115200), reproducing the WARNING and
> Oops: divide error in uart_get_divisor() on the unfixed kernel and
> verifying clean execution with 0 warnings/faults with the fix applied.

-- 
With Best Regards,
Andy Shevchenko


