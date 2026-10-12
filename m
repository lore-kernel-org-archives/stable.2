Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA249AA49;
	Mon, 12 Oct 2026 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836892; cv=none; b=r3Fu4NcMjWmq5t/N0DlqCjqvV2hyy9mewBNZR17Vxb+fW8i+3mhb0buolNK+g4gQgnvXTZIhebZCmgZFQe+hE7DlTlgvILfszd5IRYhBwWNZfLFPGbTlOSj98OIC69Vy3698KIF9xPNIUB3Cxbzvvj03sQwTNj0hxAESrkVUx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836892; c=relaxed/simple;
	bh=HhcV9cAX46l21QPoJJnWGRnUgvHnzefXF/e5LbBtemk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tsd2K73fXfK0p+tiFkXiTLRQjzVs0Y+8FwHvvlCymgcK8KgrgSh0sj9M+aJUWxR2d+HqWMP8WKpssoqLSIdpRJH4BTbtSVwsDcO0VEK4RaHLdurPU2toGKtC7KQRPIMAdARbI6yIPAcWpXshMxEaiBS0cgb2LegztrX35uGRJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeoRhPci; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeoRhPci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791836888; x=1823372888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HhcV9cAX46l21QPoJJnWGRnUgvHnzefXF/e5LbBtemk=;
  b=FeoRhPciwJZIruQCljBI5hk8Cfhzy49zJmbCnrJ25EPmM9oqvmADDBUg
   lW9yO0MaP6Lhg5xoytl6KBLAXLIVdUk8HorwU59Bh1znBQFeBVpJ9teGf
   NtxZHdrPj8ZnquIOUyEq2S/UvJt3qQVLCYoyksefS0wuQvBXZ4XrWn88Q
   RiE9DXuz+Kv1dcFxCU79xIP3sZYB8RV4758dRd5cIDk2ZXU0w7zLgM+SW
   Si4YA7w7IWZcZYN70JdqhwzHU8jVbtSTiGRfNtZw+Pgn290TOtahr7/Y2
   a7AX9IPB7hArdPGwe7oboVvN4ecGKzSbeJKtfzjWgbA0iW6Tj+Fg9Inj9
   Q==;
X-CSE-ConnectionGUID: VUALo0awRsOakQBss/gaHA==
X-CSE-MsgGUID: bg5sPVHsQ2eiSQAqP8zj0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="560464"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="560464"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:28:07 -0700
X-CSE-ConnectionGUID: yQb4YRTvQTWRrY+FLY4hpQ==
X-CSE-MsgGUID: bRPGHh87Si2dv5uN3kaxdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="904251"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:28:05 -0700
Date: Mon, 12 Oct 2026 23:28:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ferry Toth <ftoth@exalondelft.nl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Revert "serial: 8250_port: Drop duplicate NULL
 check"
Message-ID: <as1C0qoAwkBBCEcC@ashevche-desk.local>
References: <20261010193755.187706-2-ftoth@exalondelft.nl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010193755.187706-2-ftoth@exalondelft.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 10, 2026 at 09:37:56PM +0200, Ferry Toth wrote:
> This reverts commit 7885af04df6e4efd72910200c1bfc079d61202e4.
> 
> Commit 7885af04df6e ("serial: 8250_port: Drop duplicate NULL check")
> added `up->dma = NULL;` to serial8250_release_dma(), with the stated
> intent of making sure DMA would not be used again after release.
> 
> However, up->dma is assigned once at probe time.  serial8250_do_startup()
> only calls serial8250_request_dma() when up->dma is non-NULL, so after
> the first close the pointer stays NULL and DMA is never re-acquired.
> 
> On Intel Tangier (Edison) with HSU DMA this causes a regression: the
> first port open uses TX DMA, the second and later opens transmit in PIO
> mode, producing 64-byte FIFO bursts with ~50us gaps between them.

As discussed off-list with Ferry the culprit patch was inspired
by 8250_omap implementation which may have the same bug lurking.
Thanks, Ferry, for a good catch!

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


