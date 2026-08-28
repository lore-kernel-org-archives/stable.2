Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B935AC0E;
	Fri, 28 Aug 2026 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900859; cv=none; b=AnTWulPmy4XkgsnNkKsW9qoP5Ho2Rx5vCwzml1U6C6fb+k6amY0LkpJTgGvFPWUXlndfBRI0ijvekvsn1BXqo+la5atx4RDQYNvJeMnL9fAplvXTVqMj4Vgd5w+tP5orgf8zcnAT6j5YbCpxuYFoitEHJuEbsDP84kA6fgCclSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900859; c=relaxed/simple;
	bh=VrIWWpmc5vKlkCin2jq2A7cOl2DZDju3YX6kEF2v+74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCsiYGt96HUEvpRo9OBEg4G/66Aux4y55cr+KvN8lm65IpexLkV+I5156iQAafZ49Jdl50JlHjRnkCfxCp3G+GW4Du9goQUxS2nofIiqoEklavdED++tQNwOfayuwL3T0uX5gQVf1HphjNTFc3VlUsbugUqh3JSf3pkHhBFH6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmG0TcBP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmG0TcBP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787900857; x=1819436857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VrIWWpmc5vKlkCin2jq2A7cOl2DZDju3YX6kEF2v+74=;
  b=nmG0TcBP9g3/j0f+xqw9RMgScFTGJ4cwAnfviTh9e53Fb+3GcZ/kItUr
   KBK8/VVdvsUTe4LbLOc6tLeIqNYZ0H0PAnlh3Fd1EnLEo4oc6k2nGiZjR
   Fh5u4KyobeQBAZn3nAinsN9Dc33UYmg4a8HYAXhXr+kKo550qGl2K2bs3
   B/f2cwFwQQTuYHl9EiZ7oaOIEG6NQwUKNEibYBEgihoQ1zmwJ1oBLBsLf
   OkVdVYVfTT+Oy+dkwdR+zXBagDIYDbJDiOb+7mdu3P9J4Djp1UX6PpgU7
   Ao6ViWivoSNezmeUVPsLkhBGL0rgVpaZJLiWp5CiDuyjHaD0bgp6vNqiE
   g==;
X-CSE-ConnectionGUID: B1tHB1LLT9mtnf0wAaYUXw==
X-CSE-MsgGUID: Vygwy7H3Q4uQbEBuyIhgtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="90918911"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="90918911"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:07:35 -0700
X-CSE-ConnectionGUID: dOg9J/vSQQSCCbP9PmQWKw==
X-CSE-MsgGUID: SnfpyDzDSNWxXIeXpUUf3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="291577136"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.42])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:07:29 -0700
Date: Fri, 28 Aug 2026 10:07:26 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kendall Willis <k-willis@ti.com>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>, s-kochidanadu@ti.com,
	a-kaur@ti.com, s-tripathi1@ti.com, vishalm@ti.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_omap: fix wake irq cleared during suspend
Message-ID: <apEzrqovJW8iONKK@tlindgre-MOBL1>
References: <20260825-uart-wakeirq-fix-v2-1-0b9fba03d9b6@ti.com>
 <20260826145307.4GWTzB5f@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826145307.4GWTzB5f@linutronix.de>

On Wed, Aug 26, 2026 at 04:53:07PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-25 17:06:07 [-0500], Kendall Willis wrote:
> > The wake irq was cleared in shutdown(), which runs during the suspend
> > sequence, making it impossible to wake the system via UART.
> > Move wake irq setup to probe() and teardown to remove() so the irq
> > remains armed during suspend when the UART is a wakeup source.
> 
> The omap-serial has the same problem, doesn't it?

Yes likely.

> I would still like to see an ACK from Tony here.

Maybe there was some deferred probe type issue with getting the wakeirq
earlier.

In any case if there was an issue getting the wakeirq it should be handled
nowadays with -EPROBE_DEFER.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
