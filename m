Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180618;
	b=K6am7Q+db/LECy1kg+GjXZRR5Ax+ShO4fW3MsYuVtl2RNHIdIjuRvK/B8RIaGRTOEeTo
	 dmhseTFbo4V4LLxxzTfrQ4fSeCo/BLsQ3JF54a3Rk8VPf3SiMcyXcWODYddPFkcM9dykO
	 gNyhym0xxY4epKku4fXLJ7dBfsHgjdIEPw2RNuB8QV0neyxPCa+mz/IhxCL4/vvA6Rbym
	 PUMGMwY5yuT2YqZ7zgWqBP00Vrlc5UHXFS81aozNi4u3/WOztTN/l6+N3DB0zu8R8cngl
	 cCBAOIQaWzAbBUWprVhkdMHWvdQS5XUkBhnhWeTaUy8FlYThuQmWtrnpMple1e/pg4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180618;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=c7dPS/UtYCXPtVTm4vS/8g+0IPJtQ9sYZmAnSl23OeQ=;
	b=MbleR04V1al0hl141GyYrNhn9h12Wow3EkLR4vEMfu30TOqos9RscsQwxIHNpFxnC143
	 e03fkBCOEDQNqrhb/beLU6FwKYb4+3PHqBj+VIQhiKgNK3RwHK6ePCA4hwWd+7nngOMK8
	 QeKey2HIpjbg13O2GlvK+1lQy2y6/fEaHrXshISfL7JeJGAU0JfU/uHnOcbTxMCPuuQxh
	 eY1KelS2qcQ6hhzPQfXWB7J6YddgtGxdWSgCVK/P/1bRtIRmabqo6hxQZI2KnLcnGrlQK
	 6HPC7QA7gID9JAUlxMQfYBvgjubRt6aJiKGC/g1K9nPI2YNa7Djv19eADNUFYosUiOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kfx0OxVm;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D7606A320;
	Fri, 20 Nov 2026 13:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D9D7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kfx0OxVm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795180617; x=1826716617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yB//zI+7RxZPN6IQQJDw5n0c8DJgoR4yjSGTToAdGQg=;
  b=Kfx0OxVmrgb93aoNAgPBF6+W2NZbgBwlX428uRS+oV5irGt9PQt/hCfQ
   OQWXRWO/auNjrzrmn0lnmn1eYC1R1fFESyeTqSuv14GyBYTIy826QNFIb
   7OE2Nz8LxtRcyFkiPHDrxgR6hm72yyxNUFB/u/Lbt0fB8yUYfXxsGnVOf
   ZKtnch/EyC5znldp8Pd/oHiPSVaqME5g2mm/jM38mUcJFBZ9AT2qeHOLH
   bC4Vl95H6hRb2K+29bH+pDjAROx9WkEWrdA1aRiYVGJZ7L6FzflYirLpR
   HzbhX8v0CJ0xqf5kURmwMaQCcqs/YEpWuubxPxWijLTMH1u49cv9I8clM
   g==;
X-CSE-ConnectionGUID: y4Mkrk6BSNyLgN6dGSH5qg==
X-CSE-MsgGUID: QUSJ/ML8TWaKn2oyMyXg2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4101332"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4101332"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:16:57 -0800
X-CSE-ConnectionGUID: XGYvRCPTQWOtz0zWArkz7g==
X-CSE-MsgGUID: VIQI0BUWThqZu9kuKO5FLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11268920"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 20 Nov 2026 05:16:56 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 5EFA499; Fri, 20 Nov 2026 14:16:54 +0100 (CET)
Date: Fri, 20 Nov 2026 14:16:54 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: memoriaru@foxmail.com
Cc: linux-usb@vger.kernel.org, badhri@google.com,
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH usb v2] usb: typec: tcpm: align SOP' Soft Reset handling
 with SOP
Message-ID: <awBIRnc9lBkdVhEK@black.igk.intel.com>
References: <avw6CtZkJqvwj4eL@black.igk.intel.com>
 <tencent_443620EAE95525A375BB2D8A653406630A07@qq.com>
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
In-Reply-To: <tencent_443620EAE95525A375BB2D8A653406630A07@qq.com>

On Tue, Nov 17, 2026 at 07:36:21PM +0800, memoriaru@foxmail.com wrote:
> From: Zhang Hewei <memoriaru@foxmail.com>
> 
> The PD message duplicate-check and the SOFT_RESET state handling treat
> the SOP and SOP' channels differently:
> 
> - tcpm_pd_rx_handler() exempts PD_CTRL_SOFT_RESET from the MessageID
>   duplicate check on the SOP path (the USB PD spec 6.6.1.2 note: a
>   Soft_Reset Message always carries MessageID zero, so the duplicate
>   check must not drop it), but the SOP' branch of the same switch has
>   no such exemption. A cable that sends a second Soft Reset over SOP'
>   (MessageID zero again) has that message silently dropped by the
>   stale rx_msgid_prime comparison, and the cable-side re-negotiation
>   stalls.
> 
> - run_state_machine()'s SOFT_RESET case resets message_id/rx_msgid but
>   not message_id_prime/rx_msgid_prime, while the initiator path
>   (SOFT_RESET_SEND, SOP_PRIME branch) resets both counter pairs. After
>   a responder-side soft reset the prime counters stay stale.
> 
> Reset the prime counters together with the SOP counters and exempt
> Soft Reset from the SOP' duplicate check, aligning the SOP' handling
> with the SOP path.
> 
> Found by code inspection; a software TCPC stub was built for the
> responder path.
> 
> Fixes: 6bd181ba60 ("usb: typec: tcpm: add control message support to sop'")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
> ---
>  tcpm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tcpm.c b/tcpm.c
> index bb90211..95f748d 100644
> --- a/tcpm.c
> +++ b/tcpm.c

How did you prepare this patch? It doesn't apply.

I do hope you have actually compiled this at some point.

Thanks,

> @@ -4200,7 +4200,8 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
>  		*/
>  		switch (rx_sop_type) {
>  		case TCPC_TX_SOP_PRIME:
> -			if (msgid == port->rx_msgid_prime)
> +			if (msgid == port->rx_msgid_prime &&
> +			    type != PD_CTRL_SOFT_RESET)
>  				goto done;
>  			port->rx_msgid_prime = msgid;
>  			break;
> @@ -6193,6 +6194,8 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SOFT_RESET:
>  		port->message_id = 0;
>  		port->rx_msgid = -1;
> +		port->message_id_prime = 0;
> +		port->rx_msgid_prime = -1;
>  		/* remove existing capabilities */
>  		tcpm_partner_source_caps_reset(port);
>  		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
> -- 
> 2.39.5 (Apple Git-154)

-- 
heikki
