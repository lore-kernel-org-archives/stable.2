Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473181;
	b=EliwXpZqDhIKtvIzsKFDPDC1ohqIrkGA5flgepTj2Q+JYx7unok9ixGYaM/s50xl+MEZ
	 Zp7AjzphSkilr4pxB0NPmEy1pzqZfxV2/T8mYhiwQrVokNVGwLaMRMJT+Iov8EK00R7p5
	 KBT1IsKDiwKfwzE7fhtLKtRMyVcAw1Xcrfg9cbnve53Hh0hdyqZzudMW+6NGR5/zwdeMd
	 RzyKxjbsT9dypCEC2FlVNPjS5h0n5g4cgJ0tNJavKLyWZj5BxH59SzGEqPYPpHm+n0BgT
	 WR6UUeJOdpwIslXO/4jzSLBgffvcowlXN4KGcAZnnRpjx85IhRy9B3ytbB9C/m3SB5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473181;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=X5xO1tQxHVc542YRl8XxQDbU33aenQ7GQV213HCAao4=;
	b=udVAkJEnqYXmLrJFxGCq520maRCaVOy10EaSUZwP3EPjl3fj2zy9157E5aI5y12wt4UG
	 Vc604x7+YI+3kqh8AzCDsmAqb/fo64qjsWn86tpiFpAkgG0och7pN7POrXAjqoPVRbqaj
	 Bes1bLdI69ZPjD0qvojjZV+SAOMJFnYX+f4f1DXOMFQ4ecefiJzI/eOi4Q5kfgrcF1QlA
	 AQWJESB1xCL1a/eTMNnWDVkAUwrLMkS0lbxdjS8mOBwzdNAimO73FsT2LyrC61zps3RAb
	 rb2zep38jEKrXJex73+CC/GeQXhOgTbRUw8kh5Lrxng+ookUidXxD6SeB6ac1CIk6FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mkT2w7kB;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0308606A88C;
	Thu, 12 Nov 2026 08:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0308606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mkT2w7kB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794473181; x=1826009181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PtnlpKJNBfqTK49mgpDQc+YKEm0fPAg1hXMyx7FBqg8=;
  b=mkT2w7kBIjGka5IeR0Dp262Rzyc/Gg2bhDCVP7gxSpI6OUNglr47iDb1
   akdGF2zREBmFs4+GQmlf8+igSju6+LueGrg7428/KrPC04Jyev5lC6ruM
   UtqVb1HpV/VcPF/NRfUZ1c3M683zAK+D1XDhHJ5H/bHOHGtBFjSfWiySk
   QwaBuz+vMFi1VHEh63t9d3sgcrwUbnilx8kzjXbbpLbWN4k9SiR6L0j+E
   Y+yTyPHBIVz18MCK8+0ydGKHTRdqYOCG3/XY/Bio0jvG4qWWU0csW1GRU
   pBhKCU93+t6WA7jSDGt83r3izCnHFVFeHJMBaDn/94FkwtXkiaED5XIzT
   w==;
X-CSE-ConnectionGUID: ocV0s1oSRg6Fn+8DftumUQ==
X-CSE-MsgGUID: TXJQhvtkSg+LRsbqk1pLYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3133288"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3133288"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 00:46:20 -0800
X-CSE-ConnectionGUID: 1U6o/uASRdCC9FMomnfvgQ==
X-CSE-MsgGUID: SQGJ+CdBTdy1CT3GmooNkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="9175632"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 12 Nov 2026 00:46:18 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id BECD799; Thu, 12 Nov 2026 09:46:16 +0100 (CET)
Date: Thu, 12 Nov 2026 09:46:16 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Atif Ashhar <atifashhar@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: Release slave SCL hold in
 __i2c_dw_disable()
Message-ID: <avV82EfLER5vZost@black.igk.intel.com>
References: <20261104133745.1432212-1-atifashhar@google.com>
 <20261109102006.GJ176724@black.igk.intel.com>
 <20261110190559.819337-1-atifashhar@google.com>
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
In-Reply-To: <20261110190559.819337-1-atifashhar@google.com>

Hi guys,

On Tue, Nov 10, 2026 at 07:05:59PM +0000, Atif Ashhar wrote:
> Hi Mika,
> 
> On Mon, Nov 09, 2026 at 11:20:06AM +0100, Mika Westerberg wrote:
> > > +	if (tx_hold) {
> > > +		regmap_read(dev->map, DW_IC_CLR_RD_REQ, &dummy);
> > > +		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
> > > +		regmap_write(dev->map, DW_IC_DATA_CMD, 0xFF);
> > 
> > I'm not super familiar with the slave mode so adding Heikki just in case.
> > Can this cause some unintended traffic on the bus towards the master?
> 
> No, it cannot initiate new traffic. DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY
> is only asserted when an external master has already addressed this
> controller and initiated a read transfer, and the slave hardware is
> actively stretching SCL low waiting for TX data. When no slave read
> hold is active, i2c_dw_release_slave_hold() returns early without
> writing to DW_IC_DATA_CMD.
> 
> Writing 0xff simply satisfies the ongoing master-clocked read byte
> while keeping SDA passively high (released via pull-ups), allowing the
> external master to finish clocking the byte and terminate the transfer
> with NACK/STOP instead of hanging the bus indefinitely.
> 
> > Also use 0xff instead.
> 
> Ack, I will update 0xFF to 0xff (and wait to see if Heikki has any
> comments before sending v2).

No comments yet, but just out of curiosity, I'll try to test this.

Please go ahead with the v2. I can then give you my Tested-by tag if I
figure out how to reproduce the problem fast enough.

Thanks,

-- 
heikki
