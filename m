Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F463D25A2;
	Mon, 31 Aug 2026 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174510; cv=none; b=toK6B0eJUveHE/SlZmRdzQcI5lKpxQVG3nhLiANDdvHpqWxFX2Xb8hRUztDowyV+bxVLqeXhX/wVBQRRf9oHDLqVejkUI5x+4mTfrBy+m87vdxJdXBYFcYrqIb0WCA2NMRmCbo2i9h9CpITJ8lJAhV4I8yHKlddLRhjYlg2UupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174510; c=relaxed/simple;
	bh=kKccmS7eRB4L4HV9y+iO1p2KE3KISTsfA84ty4yDud4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/nov2cxFuDerpVdGRNNlSubFdc2oRl5GR4d3vF4SviXBKY3Dk20AbafchPnpqeJqXDMBENokchpgs7gkUieRKa9zEDSgs90UqaDG6nvZphabMonNzgeFR4GMDdp8XmcvwfGZJ/D85UHxyxaQNn3WkfovvQ4yWRh0Zi3RrprWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZcN8ZnQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZcN8ZnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788174509; x=1819710509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kKccmS7eRB4L4HV9y+iO1p2KE3KISTsfA84ty4yDud4=;
  b=IZcN8ZnQv1sATJFI9KAF6nQ2oJtjb1M0A1Qw+9ETjFeBM1Bqx/bb7MEH
   U9udUFUOIwwCc8BCNVLibXPFviIaq3oKtEJ2kOSa9REi/ZDiTV+OEwSsR
   xGtqdVvne8J1To/bTowC4rgmOPK8hT4oib/UQyMP/40PplN3oVKtXfJv9
   4coFi9f+u//GWvgKnJcbe7GIApm9x0xkccL8O3NVnHHc7/7b+0Id/3s8B
   G08IMG3TPl3RTOayA8hC90jKycMEE/4tczkELms76Eg5v6qMFdPt+BSeG
   yMdhfEcU0sQtlVVBwNRIr9kZlyU4MCLH/PBldu+Qe7xIjhHkDfYGIBrsw
   g==;
X-CSE-ConnectionGUID: F7HrEydsRLmiiBt6k0FRfg==
X-CSE-MsgGUID: pXI87qnTTNm8v66eukO/xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="91090870"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="91090870"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 04:08:27 -0700
X-CSE-ConnectionGUID: XGnTctFpS4SC13sVYf6UTQ==
X-CSE-MsgGUID: 3K+Ytra7RRe0WshVcLUWaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="266965622"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 31 Aug 2026 04:08:24 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id E272A99; Mon, 31 Aug 2026 13:08:23 +0200 (CEST)
Date: Mon, 31 Aug 2026 13:08:23 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: constrain TCPM_SOURCING_VBUS event
 handling
Message-ID: <apVgp-eSmlF3-XKA@black.igk.intel.com>
References: <20260827-sourcing-vbus-v1-1-9be1aca991a0@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-sourcing-vbus-v1-1-9be1aca991a0@google.com>

On Thu, Aug 27, 2026 at 09:16:17PM +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> When a sink detach occurs while waiting for TX send status, the old
> TCPM_SOURCING_VBUS event along with TCPM_VBUS_EVENT and TCPM_CC_EVENT
> can be queued in port->pd_events. Because TCPM_SOURCING_VBUS is
> evaluated after TCPM_VBUS_EVENT and TCPM_CC_EVENT in
> tcpm_pd_event_handler(), a stale TCPM_SOURCING_VBUS event can override
> the detach handling and incorrectly set port->vbus_source and
> port->vbus_present to true.
> 
> Add a state guard to check that the port is either operating as a
> Source (tcpm_port_is_source(port)) or in a Fast Role Swap (FRS) state
> up to FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED before processing
> TCPM_SOURCING_VBUS. Otherwise, discard and log the event.
> 
> Log snippet for error condition before fix:
> [72792.204955] state change SRC_ATTACHED -> SRC_STARTUP [rev3 NONE_AMS]
> [72792.204960] sourcing vbus
> [72792.204962] VBUS on
> [72792.204970] AMS POWER_NEGOTIATION start
> [72792.204974] cc:=4
> [72792.205319] state change SRC_STARTUP -> AMS_START [rev3 POWER_NEGOTIATION]
> [72792.205325] state change AMS_START -> SRC_SEND_CAPABILITIES [rev3 POWER_NEGOTIATION]
> [72792.205332] PD TX, header: 0x11a1
> [72792.216911] PD TX complete, status: 2
> [72792.216957] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms [rev3 POWER_NEGOTIATION]
> [72792.218005] VBUS off
> [72792.218013] pending state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED @ 650 ms [rev3 POWER_NEGOTIATION]
> [72792.218020] VBUS VSAFE0V
> [72792.218024] state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED [rev3 POWER_NEGOTIATION]
> [72792.218458] CC1: 2 -> 0, CC2: 0 -> 0 [state SNK_UNATTACHED, polarity 0, disconnected]
> [72792.218467] VBUS on --> VBUS left on
> [72792.218980] disable vbus discharge ret:0
> [72792.235193] Start toggling
> 
> After fix:
> [ 1195.291691] state change SRC_ATTACHED -> SRC_STARTUP [rev3 NONE_AMS]
> [ 1195.291698] sourcing vbus
> [ 1195.291700] VBUS on
> [ 1195.291707] AMS POWER_NEGOTIATION start
> [ 1195.291710] cc:=4
> [ 1195.291758] state change SRC_STARTUP -> AMS_START [rev3 POWER_NEGOTIATION]
> [ 1195.291794] state change AMS_START -> SRC_SEND_CAPABILITIES [rev3 POWER_NEGOTIATION]
> [ 1195.291798] PD TX, header: 0x11a1
> [ 1195.297056] PD TX complete, status: 2
> [ 1195.297092] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES @ 150 ms [rev3 POWER_NEGOTIATION]
> [ 1195.297177] VBUS off
> [ 1195.297184] pending state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED @ 650 ms [rev3 POWER_NEGOTIATION]
> [ 1195.297227] CC1: 2 -> 0, CC2: 0 -> 0 [state SRC_SEND_CAPABILITIES, polarity 0, disconnected]
> [ 1195.307469] cc:=2
> [ 1195.307544] pending state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED @ 650 ms [rev3 POWER_NEGOTIATION]
> [ 1195.307555] Discarding sourcing vbus! Invalid state SRC_SEND_CAPABILITIES
> [ 1195.957636] state change SRC_SEND_CAPABILITIES -> SNK_UNATTACHED [delayed 650 ms]
> [ 1195.957732] disable vbus discharge ret:0
> [ 1195.970196] Start toggling
> [ 1195.970468] VBUS off
> [ 1196.051637] VBUS off
> [ 1196.051642] VBUS VSAFE0V
> 
> Fixes: 8dc4bd073663 ("usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)")
> Cc: stable@vger.kernel.org
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index a8cd1959c426..2d6b14aa2085 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7119,16 +7119,32 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
>  			}
>  		}
>  		if (events & TCPM_SOURCING_VBUS) {
> -			tcpm_log(port, "sourcing vbus");
>  			/*
>  			 * In fast role swap case TCPC autonomously sources vbus. Set vbus_source
> -			 * true as TCPM wouldn't have called tcpm_set_vbus.
> +			 * true conditionally as TCPM wouldn't have called tcpm_set_vbus.
> +			 * If TCPM calls tcpm_set_vbus to source vbus, vbus_source would already
> +			 * be true.
>  			 *
> -			 * When vbus is sourced on the command on TCPM i.e. TCPM called
> -			 * tcpm_set_vbus to source vbus, vbus_source would already be true.
> +			 * When TCPM_FRS_EVENT and TCPM_SOURCING_VBUS arrive simultaneously,
> +			 * handling TCPM_FRS_EVENT above transitions the state to AMS_START
> +			 * with upcoming_state FR_SWAP_SEND.
>  			 */
> -			port->vbus_source = true;
> -			_tcpm_pd_vbus_on(port);
> +
> +			if (tcpm_port_is_source(port) ||
> +			    tcpm_port_is_debug_source(port) ||
> +			    (port->state == AMS_START && port->upcoming_state == FR_SWAP_SEND) ||
> +			    port->state == FR_SWAP_SEND ||
> +			    port->state == FR_SWAP_SEND_TIMEOUT ||
> +			    port->state == FR_SWAP_SNK_SRC_TRANSITION_TO_OFF ||
> +			    port->state == FR_SWAP_SNK_SRC_NEW_SINK_READY ||
> +			    port->state == FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED) {
> +				tcpm_log(port, "sourcing vbus");
> +				port->vbus_source = true;
> +				_tcpm_pd_vbus_on(port);
> +			} else {
> +				tcpm_log(port, "Discarding sourcing vbus! Invalid state %s",
> +					 tcpm_states[port->state]);
> +			}
>  		}
>  		if (events & TCPM_PORT_CLEAN) {
>  			tcpm_log(port, "port clean");
> 
> ---
> base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
> change-id: 20260827-sourcing-vbus-9f87cc4b6257
> 
> Best regards,
> -- 
> Amit Sunil Dhamne <amitsd@google.com>
> 

-- 
heikki
