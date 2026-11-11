Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405622;
	b=qV5YPQ5Mo/qO60gKrZ+Yl1J6JohQUPzxJz5dclwrtKz4U7F64y0/fNTzW+VKgUQYKWMs
	 kqfNlJjiwHKju3gAclTBKLROtyH9Gp3l/8m359xlOaD7CwXNXVguSTgUNRme9rVAAl1cF
	 nQfIbYlDganRKKtQHvDspgP3IHqaV8cIgF8ValCVjj7sEwQNciUWS04bcCDg8tnoK15cl
	 w+NdSy6SR6HtaRJgFmO90VFJI4m4FF+KML7U2Cw9dfB7K5Lnsvk6KgLmllSDokpse9l2m
	 GhbEMghY/YqObRzJ64tiWrcIkBUZ6BEvappgOJwd09fxi4Rwc7x/8f5R/vyVv2G2fBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405622;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=72RedqSRj8wj0gbesJ4FFuwugiOLntBxqq9IL6zM74U=;
	b=2JArT4xZQmjC7dJVOCl19joZ/n7cciuO0nqAWxCXDJ26Q0FX5WJgaw6BM6y28QAibvhx
	 L8UrdZbVTQ124CMwMaegO0cYfmIlvxkai2brJfmTKwDPPjCEpE+q7mm/j6wtG1fmsXjyF
	 fW/JVwsvjILRBJHQSWTFRMScuO5/o8b1Y32JZEF7JEwR1fjNTRqpPYDoT0hi4I7YOHaSw
	 APiTu5/kLjn9UkBYHl8OnqGYi3Ib1hQ+GCS+Iq1l4Z6P0jIUt2xzf2KJQ/HzndCjbx+25
	 vpxepkX3Tg4COvBZH9cGf1oicutHC53TfErnuMhvndvd3idtsEFuVOKf4biBob3AF+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJpUfPEB;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B2606A327;
	Wed, 11 Nov 2026 14:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31B2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KJpUfPEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794405622; x=1825941622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxSnup0BBLqBjt4RQz3Yb7cZrq1BAMox75Jj3crU0Yk=;
  b=KJpUfPEBE/P1+g2+n5y6/SGU2QAF9o8Fewlt5AfCyPu6XtcTecE1EXHD
   Pv6MtePP0WAxDeZkw1JM2OZVVSKwq3+2rFvaXobEKCw5jzOoHFijB/Bu/
   FFVFTyeyVKaw4Z2ybiSncZK5BM4nVbhcBi4hH4J+6JGSQ2lFo8ELXCbqi
   Ad/HDkU85wvMV4Q3j5gd39U6dQWnbb2V8KIobbdXIgRpIoecVcs8QDoLb
   xYEg5zEwHg6Wx94jiqXnUWmQJLT+NRXq3vAZJroQeJREaqaR5KPBiS1ZP
   3DNDLdoUohZZNg/ovyHk68Ezvm4TeObNqa7Sa4TF0xR4I4pwfPx3xZiZY
   A==;
X-CSE-ConnectionGUID: K2nL9Tr7TM+yT/IZA28u9g==
X-CSE-MsgGUID: vjglvPQyTYW4CkqClJlS7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3173255"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3173255"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:00:21 -0800
X-CSE-ConnectionGUID: b+h7LCqkSbCsj2u85RSz8A==
X-CSE-MsgGUID: OO+nQO2LR52dGizoz1nquQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10148410"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 11 Nov 2026 06:00:16 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 65C0899; Wed, 11 Nov 2026 15:00:15 +0100 (CET)
Date: Wed, 11 Nov 2026 15:00:15 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/5] usb: typec: cable comms on RT1711H-compatible TCPCs
 and FUSB302
Message-ID: <avR073vYmypIFVGY@black.igk.intel.com>
References: <20261103-husb311-cable-comm-v1-0-6217dabc1a85@flipper.net>
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
In-Reply-To: <20261103-husb311-cable-comm-v1-0-6217dabc1a85@flipper.net>

On Tue, Nov 03, 2026 at 03:21:21PM +0400, Alexey Charkov wrote:
> Neither the RT1711H family (including the HUSB311 and ET7304) nor the
> FUSB302 lets TCPM talk to cable plugs today, so cable discovery is
> skipped, and with it the cable's current and speed ratings.
> 
> The RT1711H family handles SOP' like any other TCPCI-compliant TCPC, but
> enabling it exposed a problem in the TCPCI core: it set SOP' in
> RECEIVE_DETECT whenever the TCPC can talk to cables, regardless of who
> sources VCONN. With the partner as the VCONN Source, the port then acks
> and processes the partner's own traffic with the cable plug.
> 
> Patch 1 fixes a TCPM bug that cable communication on the FUSB302 made
> visible: after a VCONN swap, a source resets the cable plug twice.
> Patch 2 lets a TCPCI TCPC receive SOP' only while it sources VCONN,
> which also affects the Maxim TCPCs, the only ones that enable SOP'
> today. Patch 3 enables SOP' on the RT1711H family. Patches 4 and 5 add
> SOP' to the FUSB302 driver, receiving it under the same VCONN rule.
> 
> Tested on an RK3576 EVB1 (HUSB311, source-only) and Flipper One boards
> (FUSB302B):
> - Without patch 2, a FUSB302 sink sent SOP' Discover Identity over a
>   cable with no e-marker, so the HUSB311 had no VCONN to source. The
>   HUSB311 acked each one and its TCPM answered over SOP, after which the
>   sink soft reset the contract every time.
> - With patch 2, the same messages went unacked and the HUSB311 port
>   correctly ignored them.
> - Over an e-marked 5A EPR cable, the HUSB311 sourced VCONN, read the
>   cable identity and completed discovery, while the FUSB302 sink kept
>   SOP' reception off.
> - With a FUSB302 as source on the same cable, it sourced VCONN, read
>   the cable identity and completed discovery. The cable plug accepted
>   the FUSB302's automatic GoodCRC to its replies, which the datasheet
>   leaves undocumented for SOP'.
> - Between two FUSB302 ports on the same cable, VCONN swaps both ways
>   moved SOP' reception along with VCONN, and each new VCONN Source
>   soft reset the cable plug over SOP'. Without patch 1, the source did
>   so twice.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

These look okay to me, but let's still wait for Badhri and RD.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Alexey Charkov (5):
>       usb: typec: tcpm: Stop a source from repeating a cable Soft_Reset
>       usb: typec: tcpci: Receive SOP' only while sourcing VCONN
>       usb: typec: tcpci_rt1711h: Enable SOP' communication
>       usb: typec: fusb302: Tell SOP' messages apart from SOP
>       usb: typec: fusb302: Enable SOP' communication
> 
>  drivers/usb/typec/tcpm/fusb302.c       | 63 ++++++++++++++++++++++++++---
>  drivers/usb/typec/tcpm/fusb302_reg.h   | 10 +++++
>  drivers/usb/typec/tcpm/tcpci.c         | 72 +++++++++++++++++++++++-----------
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c |  1 +
>  drivers/usb/typec/tcpm/tcpm.c          |  2 +
>  5 files changed, 119 insertions(+), 29 deletions(-)
> ---
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
> change-id: 20261103-husb311-cable-comm-46f2e77e4c18
> 
> Best regards,
> --  
> Alexey Charkov <alchark@flipper.net>

-- 
heikki
