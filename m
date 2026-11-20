Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179395;
	b=3/GiB7b/zt+gDru1PJJE9XFQ6RuWyRb7uiSqH4lxaFQuNXg3JBEjDne12+Jh1Fj9k6ed
	 MrI4iGyrv6u4ZEWJ5vHlNj82m4L4ud6u8Q+fT5t2iehgdD3lAEET8l8TYUBX6CFjBFfH0
	 7aSKy7zRjEq1ZZOJsJslj6krIL3ArnutQSGs9Dv4wVIDurIFPuB2ECYPkAhF8MpOxqGW+
	 H3+tSYEGNpXBYs9cNe8xMQeBO4SoqPDxLbDXKtkPJEh7q+ZAM0XXxFKsWMmcjqTgyq93g
	 VbNsERJt+6CVVYQAGJxyOSihQYkWyDu5Nf07JVGTeOZs7R0h0Gav6HE/JFGtcPSZkbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179395;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UlL1tL46u8oIf3zcC95kZ+8Bi5pqj5m8JhhkqNcg/Ls=;
	b=VspzkIX5SU7ZZKxJpV0LsRGhURtGHh84Vf8wFbPCqYh8IbH8UsF+OZkzH7ZgN8Z5o6am
	 0qMBYOTXwY+Yqnk+Lr7NJ2NNAfk2oqWGdf0rulScA6FlB+mdKXPkC5kh4FFDTW7zqB0hp
	 S+7taPMY7RH7N3uEhxP8ZByXYkdNSJEiSG7eljZLL1gxjzBmZmY39KrFsSGYghNz0ED5S
	 rD2MDfFzPq95epH7DUbLiKqh2zshsMAGeQcKXyGMnEX/tVE+ykm5OEqZdKbMpI1fBe1m6
	 5xp2T2xP7heMZbH+GFWcIYfQKoDMZLdfbQjYKTuia9wBWy9fAqiuspuu51C6h3B2RFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SuxpyM+M;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854AC606A33C;
	Fri, 20 Nov 2026 12:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 854AC606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SuxpyM+M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795179396; x=1826715396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOybFKQDeGQyV1Ly7G0MdURg3SPpaurHT+tJSAtgZFY=;
  b=SuxpyM+MKzvPidC+jdWb6fapFWV3eyuyF5EZECy4qbvhOY5NU91zNVAg
   NpAKggc3GqoTo4V47a9AwF7RuDrWXHIGhGAQaHEZ0NqkmYJ1XBwB5MllH
   AJSyaCPrWqJF3q3HIp74aAvjK3rvOtHhO0arCsczXq7FKolvhy4ST34y0
   7Cui8lk2BgUkscObZKu3e6KLbor63b5xeQQI+tDK1u/+ynbCFrbgFeEbY
   vjKmDB+RHYiO5+69Nl9ZdofTiE1aAQpvObeAxT31Mh1wUxyEzDRNNidat
   1VXOuBPTt921wyrAnbf0dUGhnE00O2x9ViuDcFbGo+v6fD+mUsnlg2c4V
   w==;
X-CSE-ConnectionGUID: y2Va7BbtSk20mQeRVjEbWw==
X-CSE-MsgGUID: AE28/QjgQyCISbS7BhySfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4059634"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4059634"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:56:36 -0800
X-CSE-ConnectionGUID: Mi5qI2h2Sue/PH+7gUYN4w==
X-CSE-MsgGUID: Fea3zjOXQl2P9uA8XPRqqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10582776"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 20 Nov 2026 04:56:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id ED21499; Fri, 20 Nov 2026 13:56:31 +0100 (CET)
Date: Fri, 20 Nov 2026 13:56:31 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Atif Ashhar <atifashhar@google.com>, Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Wolfram Sang <wsa@kernel.org>,
	Luis Oliveira <Luis.Oliveira@synopsys.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: Release slave SCL hold in
 __i2c_dw_disable()
Message-ID: <20261120125631.GJ229695@black.igk.intel.com>
References: <20261104133745.1432212-1-atifashhar@google.com>
 <20261112145238.3736264-1-atifashhar@google.com>
 <awBCclrtdWSNHl67@black.igk.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awBCclrtdWSNHl67@black.igk.intel.com>

On Fri, Nov 20, 2026 at 01:52:02PM +0100, Heikki Krogerus wrote:
> On Thu, Nov 12, 2026 at 02:52:38PM +0000, Atif Ashhar wrote:
> > When an external I2C master initiates a read to the Synopsys DW_apb_i2c
> > adapter in slave mode during kexec teardown, runtime suspend, or driver
> > unbind, the slave hardware stretches SCL low (0V) waiting for TX data,
> > setting DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY.
> > 
> > In master mode, __i2c_dw_disable() issues DW_IC_ENABLE_ABORT to release
> > the bus. However, according to the Synopsys DW_apb_i2c Databook, the
> > ABORT bit applies only to master transfers and has no effect in slave
> > mode. Because the slave cannot disable while stretching SCL,
> > __i2c_dw_disable() times out, leaving DW_IC_ENABLE_STATUS[0] = 1 across
> > kexec or rebind. Subsequent writes to DW_IC_SAR are write-protected and
> > silently dropped by hardware, wedging the slave and blocking any other
> > devices sharing the physical bus.
> > 
> > Fix this by:
> > 
> > 1. In __i2c_dw_disable(), if DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY is
> >    set while disabling, temporarily re-enable the controller so the APB
> >    interface accepts data commands without racing with the slave ISR,
> >    clear pending RD_REQ/TX_ABRT interrupts, write a dummy 0xff byte to
> >    DW_IC_DATA_CMD to release the SCL stretch, and immediately request
> >    disable via __i2c_dw_disable_nowait(). Also drain the RX FIFO if RFNE
> >    is set during SLAVE_ACTIVITY.
> > 
> > 2. In i2c_dw_reg_slave(), replace __i2c_dw_disable_nowait() with
> >    __i2c_dw_disable() to ensure the controller is fully disabled before
> >    calling i2c_dw_set_mode(), which programs DW_IC_SAR and DW_IC_CON.
> > 
> > Fixes: 9f3e065c54b0 ("i2c: designware: add SLAVE mode functions")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Atif Ashhar <atifashhar@google.com>
> 
> I don't have time to test this unfortunately :( But it LGTM. FWIW, if
> it's okay by Mika:
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Yes it's okay, thanks Heikki!

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
