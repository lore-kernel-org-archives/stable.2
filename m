Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E23B6C1D;
	Wed, 26 Aug 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732011; cv=none; b=fiCEC+VKmBRb1NUwhY4meO5UgSSflW2Wxgx+jI60+zPxfIJE5zi2Nc105c1Fk1tyA5NlPGkUAXh2ud8SCqq6Dj18Mq1DWTPUQJcMOm2XRTMayWT0PaUYLJWdfll4f+zPG3gSMy0pPkc/Lk+rOAsQCFfPHJ+0/xY6GYq240yRJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732011; c=relaxed/simple;
	bh=zKCnuFKFoAISxYZ0mt727QSfCVLybUWLQ+ZMiMObw8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MateHLbE/W26Dgp6I6rhyfKdO8cDQmfV5giarbY6/McPHTtEo4zPpMkDbSXsEeIxsDW0WpTf9hDIofFv/qSjJ6x0ymnyffJErm/0zOwEfOzJxUhbiBm2JFt4He+Qgwrvc2nI3w/Zd4c3CLgNuAa0xGgZx+GjMBmr56m6lJP+JG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmZWmqvP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmZWmqvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787732010; x=1819268010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zKCnuFKFoAISxYZ0mt727QSfCVLybUWLQ+ZMiMObw8g=;
  b=HmZWmqvPR4FQS94lgjx+PjpIjNmQfmeqYTgZDKZynJ/B1za2ALIXjJiC
   TY6RNxNQqQjTuTkbojHQ2z9yZ7CucQtQ/X/DWtuWf2wfnQornnGnNStSD
   BJYIdiH7jdgmprt85vB+/Kr5rfW/PZX5AIBwPrkSp/W1ZVvGrVxflWUXg
   Ywb/lQFRjb+OzB4t7QAUasyWfmD0sPihLEMuXmyfFsMoWpX1dmgNWD1fc
   YzYk+blgdaQcCMlsooNPyG+44yFbpf0P6SmUd8F8DDUKrpcW8JWHYNSko
   ZnsMRzPzrGox9x2KURCACQUdDvI9pztlO9YauPmJSsG4wwFhChCs9QjpF
   A==;
X-CSE-ConnectionGUID: zgE9p5OrRymZBPP4oUb6cQ==
X-CSE-MsgGUID: r9mMjGIIQFu8gBzDGzMsSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="90719731"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="90719731"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:13:29 -0700
X-CSE-ConnectionGUID: v4AFlEZuQ2ebS9idgfxxhQ==
X-CSE-MsgGUID: Uf+abpV6SUi1yAWSDLjR4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="261380416"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:13:26 -0700
Date: Wed, 26 Aug 2026 11:13:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ruslan Valiyev <linuxoid@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lukas Wunner <lukas@wunner.de>, Gerhard Engleder <eg@keba.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix NULL pointer dereference in
 serial_core_unregister_port()
Message-ID: <ao6gI3bH_dHpfIof@ashevche-desk.local>
References: <20260826073237.1377668-1-linuxoid@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826073237.1377668-1-linuxoid@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 26, 2026 at 09:32:36AM +0200, Ruslan Valiyev wrote:
> serial_core_unregister_port() dereferences port->port_dev before it has
> been checked:
> 
> 	struct serial_port_device *port_dev = port->port_dev;
> 	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
> 
> serial_core_get_ctrl_dev() takes &port_dev->dev and reads dev->parent
> straight away, so a NULL port_dev faults at offset 0x40.
> 
> port_dev is NULL whenever no port device is installed:
> serial_core_remove_one_port() clears it on teardown, and it is never
> set if registration failed before serial_core_port_device_add().
> 
> serial8250_unregister_port() reaches that state. It calls
> uart_remove_one_port(), which clears port_dev, and then re-adds the
> port with uart_add_one_port() without checking the return value. When
> that re-add fails, port_dev stays NULL while port.dev still points at
> the ISA platform device, so unbinding that device once more calls
> serial8250_unregister_port() again and oopses:
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
>   RIP: 0010:serial_core_unregister_port+0xef/0x990
>   Call Trace:
>    serial8250_unregister_port+0x1e4/0x8a0
>    serial8250_remove+0x8c/0xb0
>    platform_remove+0x5f/0x80
>    device_release_driver_internal+0x46b/0x640
>    unbind_store+0xf8/0x110

>    sysfs_kf_write+0xf2/0x150
>    vfs_write+0x6ac/0x1050

At least these two lines are noise in the backtrace in the commit message.
Submitting Patches recommends to leave only significantly important lines.

> Return early when there is no port device to remove, and read
> port->port_dev under port_mutex, since every other update of that
> field is serialised by it.
> 
> Also clear port->port_dev on the serial_core_register_port() error
> path. serial_base_port_device_remove() frees the port device but left
> the pointer behind, so unregistering after a failed registration read
> freed memory instead. That is the use-after-free variant of the same
> crash, and matches the title syzbot first reported this under.

Overall, try to re-read and simplify the text. This looks like an AI puke.

-- 
With Best Regards,
Andy Shevchenko


