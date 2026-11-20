Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185142;
	b=BrDRvph+YX+jbSvecEWTpF/45um3SWRVcouWN/dM3TyjAZHlJDO2Ok2bdwFzZciCfnYa
	 VwOhWt+txFZwhS38HNYQ88Id+ExMIFGwbgfj2dLFGMygwhMlq27oxEo6h0KRqPQeOOzTA
	 PcMPQY9xGLDOovCi/XptsXasgIHcs8aX3e2jdizZcMoU7Fzjfo/kesRd0b9eniJIRkb66
	 /7tompPtHODBHxobwh93msZs249KGd4T++WS2+uw7TVgFTnNdqN3RmeZipo+mpYH6Qcz/
	 4+BsrzzKI515b8piSJsSXPCmX47rTIMO6DayMRxvJ4csdWcE6BZJgvUSrlh0xwZaSXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185142;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QbgzJtNp5ktPTxmFvfp0eKpjwv5ngINk+G+cIFaMSeA=;
	b=q2vK0rtckpI029SAm2/WFV6Su5FtdXGVFlAaglBwT7tGrjMSr2erJf+Ri823DamwFXZS
	 QG0QV3W2VUvoEkcITJFXhX3YUMeZ+tplnPBZwXRZQim2UpVBY+IOPlKLTjgZKc2GeAmRV
	 mtsuNa5bT4e4WTRpjbRiPfoR/8TgB018XypjqfDAix3kbWZBhHhqX/+79ykG3NcJJFUOx
	 KUQMto5rD2JMr6V09JwtXUQPAJAjPirmAtaje73UcZOUrQ59FQqcQlwBV4nepdgWhIJA9
	 XAz7CbPi87XWd3DTMpC0EpK6ev5zktNvdIT0sYUw4mSPC5Sp3rqZ5kZqTAWvYEZWZ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i+dZu6kw;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4874606A326;
	Fri, 20 Nov 2026 14:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4874606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i+dZu6kw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795185142; x=1826721142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ug3/dFxWwthsnRmh7vqjPgSwiRqOnc5q3E5t+ZCzMxE=;
  b=i+dZu6kww7AuaPvjklj29T1DNgxtnaPQHSayqWtTbwFpbt4dCYbLdiPb
   dTkvm24mLQcnW4v0ZKLMQ11MRhZKINWCgOQpxbCCm6pV8oRGryglsBsMc
   2j4Z2Tri7mlsUBJqnv0DhcWPWYi7DegNXd4Uc+QGvAiq8oyuwofJwNjet
   FJZp+6mN1jiFfVXB+CF0QGWK6RRiNjyzuM6Tuj0zsbD0bMrvfY+7tBGdW
   i1lo7kY92g+61+pUt42p3xIxzqeUiD4qXEpYP504VLf8ZHUCtfZenLIKk
   fEquo5K5sbnQrK0xT+WabICrhwHaz2lxPOZL4cjgzMIqSU6jp6u2d3EKR
   w==;
X-CSE-ConnectionGUID: KINFPzAzSNGOPVl8sLQaSA==
X-CSE-MsgGUID: +8BibpSDRquvTnAk6Hzw4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3953346"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3953346"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:32:22 -0800
X-CSE-ConnectionGUID: u556TUf3TeeZ712z3I4+MA==
X-CSE-MsgGUID: o1nYNIEdRrmBKKTY4tn60Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10694321"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 20 Nov 2026 06:32:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id C649999; Fri, 20 Nov 2026 15:32:18 +0100 (CET)
Date: Fri, 20 Nov 2026 15:32:18 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] usb: typec: tcpm: Stop replaying
 Source_Capabilities after cable discovery
Message-ID: <awBZ8sPLAwQFxChs@black.igk.intel.com>
References: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net>
 <20261118-tcpm-soft-reset-sop-v2-2-b6decdc95e66@flipper.net>
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
In-Reply-To: <20261118-tcpm-soft-reset-sop-v2-2-b6decdc95e66@flipper.net>

On Wed, Nov 18, 2026 at 11:26:40AM +0400, Alexey Charkov wrote:
> When its first Source_Capabilities goes unacknowledged, a source that is
> the VCONN source asks the cable plug for its identity in
> SRC_VDM_IDENTITY_REQUEST. Entering that state sets upcoming_state to
> SRC_SEND_CAPABILITIES, for a message from the sink that interrupts it
> through SRC_READY. The ACK and send error paths go to
> SRC_SEND_CAPABILITIES directly and leave upcoming_state set, so the
> first SRC_READY after the contract sends Source_Capabilities again. The
> second negotiation can cut into the sink's own Discover Identity, and
> once ended in a Hard Reset between two FUSB302B ports.
> 
> Clear upcoming_state when SRC_SEND_CAPABILITIES follows
> SRC_VDM_IDENTITY_REQUEST directly.
> 
> Fixes: af8b627046bc ("usb: typec: tcpm: add state machine support for SRC_VDM_IDENTITY_REQUEST")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Acked-by: Heikki Krogerus <heikki.krogeurus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 8c5be904d772..b9146658f6e5 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5544,6 +5544,12 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_ams_start(port, POWER_NEGOTIATION);
>  		break;
>  	case SRC_SEND_CAPABILITIES:
> +		/*
> +		 * Straight from Discover Identity to the cable plug, rather
> +		 * than back through SRC_READY after a message from the sink
> +		 */
> +		if (port->prev_state == SRC_VDM_IDENTITY_REQUEST)
> +			port->upcoming_state = INVALID_STATE;
>  		port->caps_count++;
>  		if (port->caps_count > PD_N_CAPS_COUNT) {
>  			tcpm_set_state(port, SRC_READY, 0);
> 
> -- 
> 2.56.0
> 

-- 
heikki
