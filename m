Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599469;
	b=BX75Bix5U4CeEOgbRm/a6heuQ1GxVF2fhY0KL3cp/XqjnSGuRVD9Qn7hxY/Z3qXl73Su
	 CBn5cVf/lV9xpV2SRVfKNvowb/AX8xjOXE4pUVmB/JBXCIU7bbD2J121/ggc1fRdEibMa
	 QbmpAp5pP/sTojy9YVNIUbpVXqtpJM015FOV2OhFLL7AaVASoO647/mjr0N6JAOC3r1V9
	 2HYP77CEEin/9YIDz8Fj9ffB063eoZ3XEsL5WqLC1iS5qgvH38rvudI+495QQPx2T21xI
	 VBcG97PGV7EZBWTMH1NNsiUolq+1hxDtt/7Yi5oDWVlZt1sHMbfK10SwPI1fpuINC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599469;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=H/OW4CEWM4YFWjpU+/11jWkc2eIrxnh97AOZdrSoRuI=;
	b=WWrVUYj9GTLe4BWM4pKAz90Zm/f2QTpuEIHx19Uqh4/2KDRgH7SCIkVIa/L+qRUufOt+
	 +ndqhbnFa1mOiMqBXjbac2AeFfezkNEs40gXvaat89Gy9rGWC2nzNNq1vYLoVVZd2cNFN
	 14IPApVUruN1hp/J5vpVX6WmTEP5AYFNwSclU9Ag2fOjev/YkF0SlGn7qmxa2qzu1EQuI
	 pLX3RBH3N+l0nFp0nPZgwx7uI/NsUM01+isp0800MkYFRZUohZqs6kDV/pgEuenAsvTg4
	 ytBavcRpCTloqR3AVsknN0BKWrwUVvEKQvbO/dfAE+CrFLU09AuYGGVfRT2LFKVMFlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aWmUCHh8;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B14606A31E;
	Wed, 25 Nov 2026 09:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B14606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aWmUCHh8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795599469; x=1827135469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0s78Vf6PyUG/xWZ1rRAkii/3QHz1kfVqFuBSdG7BtD8=;
  b=aWmUCHh8QJilzli7McbLQ6SW6MZts1ECyccJeuUHd+jBtMuxMCaYkkEd
   1wLHa20mUAcKLwTiisEvag5R+qZIffHXWfrS6bv/+kOHB8Vxol5Y2kCwP
   O6SIAYWtIGs2D8O4VPs4oQdJuqn78sljVyvsXzr+TacqvL5J66W3mFQD9
   V4MCrEPAjUIV0kPkN+wo595b2CI4d2oOOGsc1Th1XdPUxRaG04ATk1i9j
   FEpEmJ/dtLNNRquy0VjYM57O5hBdx0cyGERrkOHHyhAZnF+00WM1N+I9c
   Byy+7NruRTqw+Z4tWHhVDdXs6RrNn0pXZuIxl2hxFBx2DgWmj2piichRE
   g==;
X-CSE-ConnectionGUID: 6arsJvI8Tdu6pHylGMek7A==
X-CSE-MsgGUID: V3mTqCOSQua/PAiz2Y1qkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4472670"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4472670"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:27:33 -0800
X-CSE-ConnectionGUID: lihd4i8TTJep8Rmx8U6nrw==
X-CSE-MsgGUID: VsbtQc9URdyYmjdB/nSAmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11796867"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2026 01:27:31 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 5F85298; Wed, 25 Nov 2026 10:27:30 +0100 (CET)
Date: Wed, 25 Nov 2026 10:27:30 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Max Andreev <drunkbatya.js@gmail.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kyle Tso <kyletso@google.com>, stable@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: fix missed frs_sourcing_vbus() call
 during FRS
Message-ID: <awaqAnBF94n5t3sC@black.igk.intel.com>
References: <2026112206-lapped-unvalued-8696@gregkh>
 <20261122115639.2912666-1-drunkbatya.js@gmail.com>
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
In-Reply-To: <20261122115639.2912666-1-drunkbatya.js@gmail.com>

+RD

On Sun, Nov 22, 2026 at 11:56:38AM +0000, Max Andreev wrote:
> Since commit 0908c5aca31e ("usb: typec: tcpm: AMS and Collision
> Avoidance") the TCPC reports sourcing vbus while the port is still in
> AMS_START with FR_SWAP_SEND as the upcoming state. Because of
> _tcpm_pd_vbus_on() ignores this state, frs_sourcing_vbus() is never called
> during FRS.
> 
> On Pixel 11 Pro XL after an FRS from sink to source the phone keeps
> showing the charging indicator, and about 20 seconds later VBUS drops
> and the attached device reboots.
> 
> Call frs_sourcing_vbus() from AMS_START when the upcoming state is
> FR_SWAP_SEND.
> 
> Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Andreev <drunkbatya.js@gmail.com

Looks okay to me, but just in case, let's wait for comments from
Badhri, Kyle an RD.

thanks,

> ---
> v2: moved the trailers above the --- line
> 
> I'm not test theese changes on mainline, but tested on Pixel 11 Pro XL
> vendor kernel 6.1 with the same _tcpm_pd_vbus_on() code, as i see
> mainline tcpm.c is identical in this area.
> 
>  drivers/usb/typec/tcpm/tcpm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 51e5c72799f2..5caa649a92f1 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6889,6 +6889,11 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
>  			port->tcpc->frs_sourcing_vbus(port->tcpc);
>  		tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
>  		break;
> +	case AMS_START:
> +		if (port->upcoming_state == FR_SWAP_SEND &&
> +		    port->tcpc->frs_sourcing_vbus)
> +			port->tcpc->frs_sourcing_vbus(port->tcpc);
> +		break;
>  
>  	case PORT_RESET:
>  	case PORT_RESET_WAIT_OFF:
> -- 
> 2.47.3

-- 
heikki
