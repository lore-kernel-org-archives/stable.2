Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185111;
	b=rG5g2mE67GZ2LZyliD9395sA+KtpVTEvPuUhlfskga12CpuUKh8ZVBSS6ZNEaz9XOrVU
	 +T9fRhTN0UUN3bqG1vswNqfrFK7JAS1dPIZK0HZQx5JsCugRpwJxyXk4D5D78csPG9zTr
	 G/3UQZw0z0n7GI1iADgRjdQfZOYzus+1BLyvzrYKy/1s0PtqST2xUWc/BosddT55V5pvS
	 ziT6pKznGOihaGCo4w0JxRhxDWTHOZakNBQ7WOh8nC7S6VptziYqCEhdxROZIx3PlwoJA
	 yLDt6UnxVosWlqE1s4kPDr+2zBCd9H0NSytBFL//UeE7wZP5UxComOU2cib/IGyFHLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185111;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=34CR+5iiHoaofQCyhefI83UO5nHYtI/vM0KER5Q61IY=;
	b=08O5h8OQwiH8BUcmNXXXZzr4416iMxlBbJ20zWwW/QIIjQcuGUhIgJVtzFjbf/ovNmgA
	 PmsR3Ncu8B1JXHtA28UEWpFYzEphf3qLoNZXfFSigZEHep2xvu6+C1hoAFb/vENEUUdp5
	 FNAj5TsqBm4B7mJDYj3FB3QYEBOaGnye/MXkQq6FrWk2Mh5qXJiWtP3wBkFb0/qLGmDjm
	 YxOm1OqwM7opttMz7koQVvpJ+bc76jd5OyT+6eIh/zAwGh3SNgIH2tfKzilPDjmARkxYh
	 9r2VnSf8lM4YhgsKPtbpU1vplfePWNNA7qzF3A0Dlrzc9BmiIfbFSu9km9JSjVJcluw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="c9e/fuXK";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6A606A336;
	Fri, 20 Nov 2026 14:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB6A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c9e/fuXK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795185111; x=1826721111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F9K3xye83Ao/ha+3ii5PfNxsGlcbGf9vFnyPkk1Q1PI=;
  b=c9e/fuXKDJ44nQ0Rjj6d0cuJMcEmygz7r98z8yRDJ54B9fQkHyGDj3+4
   1qPHcD4MIem8n34DD60sHrrLre6VL1mXRhOEm+r2Y7g8rNmXGhtqGaqYx
   mFVFtC5RSUGR+5W02GOkZx8eZHAbQTRSHIO3Y0h/oodV3UXS8mjKOo0NL
   6P8pxyiQLvku6ikLDKEuO6K+4meeYbscigVl4W/CuQrPl6ga5VuvVLAw4
   AFLTlpcI4Fyz16bBfIsgy3YrhDhCG7UISYxDctbDPY9QxbzXV7maWcT1O
   LKCdWdGcWcHbEWKj6091+iMYbVMmGTdC4YQn0TXkj4U5E3h0B4v+Cokrn
   w==;
X-CSE-ConnectionGUID: 3NdvltstQNqn8KTJv5OvXg==
X-CSE-MsgGUID: drwHch3zR/ae8/JlNuYXIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4164011"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4164011"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 06:31:50 -0800
X-CSE-ConnectionGUID: 0H454MDbRSi5nIYZszAPvw==
X-CSE-MsgGUID: vG4B7h7gRp+bG9+NTaSnYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10698896"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 20 Nov 2026 06:31:48 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id D457599; Fri, 20 Nov 2026 15:31:46 +0100 (CET)
Date: Fri, 20 Nov 2026 15:31:46 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: typec: tcpm: Keep the Soft_Reset target
 apart from the VDM one
Message-ID: <awBZ0h0zdaTwGwlA@black.igk.intel.com>
References: <20261118-tcpm-soft-reset-sop-v2-0-b6decdc95e66@flipper.net>
 <20261118-tcpm-soft-reset-sop-v2-1-b6decdc95e66@flipper.net>
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
In-Reply-To: <20261118-tcpm-soft-reset-sop-v2-1-b6decdc95e66@flipper.net>

On Wed, Nov 18, 2026 at 11:26:39AM +0400, Alexey Charkov wrote:
> tx_sop_type holds the SOP* of the VDM being sent, for its retries, and
> SOFT_RESET_SEND also reads it to tell a Soft_Reset for the cable plug,
> after a VCONN Swap, from one for the port partner. Nothing sets it back
> after a VDM, so once a VDM has gone to the cable plug, such as Discover
> Identity on SOP' before the first contract, every Soft_Reset meant for
> the port partner goes to the cable plug instead. The cable plug accepts
> it and the port goes back to its ready state, but the port partner never
> sees the Soft_Reset: a source whose Source_Capabilities got Not_Supported
> is then left without a contract. The VCONN Swap, in turn, overwrites the
> SOP* of a VDM that may still be pending. This left a FUSB302B-based
> source without a contract until it was unplugged, after its partner
> missed a message following Discover Identity to an e-marked cable.
> 
> Keep one target per context: vdm_sop_type for the VDM and its retries,
> and soft_reset_sop_type for the next Soft_Reset. Point the latter at the
> cable plug only for the VCONN Swap, only once, and back at SOP whenever
> the protocol layer starts over or a Soft_Reset of the port partner
> starts, along with the SOP' MessageID counters.
> 
> Fixes: 6bd181ba60e1 ("usb: typec: tcpm: add control message support to sop'")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Hopefully Badhri or RD have time to take a look, but LGTM:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index bb90211660ca..8c5be904d772 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -675,12 +675,13 @@ struct tcpm_port {
>  
>  	/* SOP* Related Fields */
>  	/*
> -	 * tx_sop_type determines which SOP* a message is being sent on.
> -	 * For messages that are queued and not sent immediately such as in
> -	 * tcpm_queue_message or messages that send after state changes,
> -	 * the tx_sop_type is set accordingly.
> +	 * Messages that are not sent right away carry their SOP* separately,
> +	 * one per context so that one cannot redirect another:
> +	 * vdm_sop_type for the VDM being sent, including its retries, and
> +	 * soft_reset_sop_type for the next Soft_Reset.
>  	 */
> -	enum tcpm_transmit_type tx_sop_type;
> +	enum tcpm_transmit_type vdm_sop_type;
> +	enum tcpm_transmit_type soft_reset_sop_type;
>  	/*
>  	 * Prior to discovering the port partner's Specification Revision, the
>  	 * Vconn source and cable plug will use the lower of their two revisions.
> @@ -2003,7 +2004,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
>  	port->vdm_state = VDM_STATE_READY;
>  	port->vdm_sm_running = true;
>  
> -	port->tx_sop_type = tx_sop_type;
> +	port->vdm_sop_type = tx_sop_type;
>  
>  	mod_vdm_delayed_work(port, 0);
>  }
> @@ -3065,7 +3066,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  		} else {
>  			tcpm_ams_finish(port);
>  			port->vdo_data[0] = 0;
> -			if (port->tx_sop_type == TCPC_TX_SOP)
> +			if (port->vdm_sop_type == TCPC_TX_SOP)
>  				break;
>  			/* Handle SOP' Transmission Errors */
>  			switch (PD_VDO_CMD(vdo_hdr)) {
> @@ -3102,7 +3103,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  	case VDM_STATE_SEND_MESSAGE:
>  		/* Prepare and send VDM */
>  		memset(&msg, 0, sizeof(msg));
> -		if (port->tx_sop_type == TCPC_TX_SOP_PRIME) {
> +		if (port->vdm_sop_type == TCPC_TX_SOP_PRIME) {
>  			msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
>  						  0,	/* Cable Plug Indicator for DFP/UFP */
>  						  0,	/* Reserved */
> @@ -3119,7 +3120,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  		}
>  		for (i = 0; i < port->vdo_count; i++)
>  			msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
> -		res = tcpm_pd_transmit(port, port->tx_sop_type, &msg);
> +		res = tcpm_pd_transmit(port, port->vdm_sop_type, &msg);
>  		if (res < 0) {
>  			port->vdm_state = VDM_STATE_ERR_SEND;
>  		} else {
> @@ -5529,6 +5530,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		port->message_id_prime = 0;
>  		port->rx_msgid = -1;
>  		port->rx_msgid_prime = -1;
> +		port->soft_reset_sop_type = TCPC_TX_SOP;
>  		port->explicit_contract = false;
>  		/* SNK -> SRC POWER/FAST_ROLE_SWAP finished */
>  		if (port->ams == POWER_ROLE_SWAP ||
> @@ -5801,6 +5803,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		port->message_id_prime = 0;
>  		port->rx_msgid = -1;
>  		port->rx_msgid_prime = -1;
> +		port->soft_reset_sop_type = TCPC_TX_SOP;
>  		port->explicit_contract = false;
>  
>  		if (port->ams == POWER_ROLE_SWAP ||
> @@ -6193,6 +6196,7 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SOFT_RESET:
>  		port->message_id = 0;
>  		port->rx_msgid = -1;
> +		port->soft_reset_sop_type = TCPC_TX_SOP;
>  		/* remove existing capabilities */
>  		tcpm_partner_source_caps_reset(port);
>  		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
> @@ -6210,6 +6214,7 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SNK_SOFT_RESET:
>  		if (port->ams != NONE_AMS)
>  			tcpm_ams_finish(port);
> +		port->soft_reset_sop_type = TCPC_TX_SOP;
>  		port->upcoming_state = SOFT_RESET_SEND;
>  		tcpm_ams_start(port, SOFT_RESET_AMS);
>  		break;
> @@ -6220,7 +6225,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * A Soft_Reset Message Shall be targeted at a specific entity
>  		 * depending on the type of SOP* packet used.
>  		 */
> -		if (port->tx_sop_type == TCPC_TX_SOP_PRIME) {
> +		if (port->soft_reset_sop_type == TCPC_TX_SOP_PRIME) {
> +			port->soft_reset_sop_type = TCPC_TX_SOP;
>  			port->message_id_prime = 0;
>  			port->rx_msgid_prime = -1;
>  			tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TCPC_TX_SOP_PRIME);
> @@ -6439,7 +6445,7 @@ static void run_state_machine(struct tcpm_port *port)
>  	case VCONN_SWAP_SEND_SOFT_RESET:
>  		tcpm_swap_complete(port, port->swap_status);
>  		if (tcpm_can_communicate_sop_prime(port)) {
> -			port->tx_sop_type = TCPC_TX_SOP_PRIME;
> +			port->soft_reset_sop_type = TCPC_TX_SOP_PRIME;
>  			port->upcoming_state = SOFT_RESET_SEND;
>  			tcpm_ams_start(port, SOFT_RESET_AMS);
>  		} else {
> 
> -- 
> 2.56.0
> 

-- 
heikki
