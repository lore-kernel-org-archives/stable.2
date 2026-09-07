Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181333CAE8D;
	Mon,  7 Sep 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777586; cv=none; b=KtrH/c/8Dvf/pyJauzqMNtfYpviCuC+ep3kpyeHq4HLxEMnJopQvK6A/9Seqm1k7ZVL6uWGvajCtug+eKOs0jSoSRR3CbA7OcbvVRTFNrN3U36ZI22s+jJHdxJWk5lGVB075fNdYt5LLdYamBNjrxa3ojdIeNanHC1ijJjYD1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777586; c=relaxed/simple;
	bh=0ZrT/K/Cb9gaNHINuULmzP5NtRYCGITb/99LD3gIsdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFkrqNYNaQ4zE1b38AlWjJ8txQZURkjxJA8Xd9H3jC31bxDB5UNbQNwu6wdu1EAJwfiR9O5WQxjaAZr4BJwFLAmpgk5yvgRS38sAf+MlCrQ00fxVyFI6CHZ7Atmsg7kEWzXc8ByhSY4ct3mhnpg6URcv37zfCAon6t4Dqb+lCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6BReP0u; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6BReP0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788777584; x=1820313584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ZrT/K/Cb9gaNHINuULmzP5NtRYCGITb/99LD3gIsdE=;
  b=U6BReP0ux+GEbqqNGk5MDouWYaXflBjOeeWZwCRCQUnirDTOJHt5Jair
   uojMJn1/5hSTcX8QQBSkRFTKn79a/alc34Ce/P+pn5thcBXFjOOBxodQs
   AnusQwSctclKY2SAB/3Zy07MO4RrwUGPdaHybh48PQSrI6fARv3CcXXpH
   Ih03RPYBQ/nEaQdRCZIqPvfzMuVAUVU4eajjwvxFYT7pK6G9Ul++OJLew
   BXoaP+MJassevLy9UgWHCDGoc8w9UNUBaJznvJvnHSIapNtXjI2mgbZWO
   ysU377fYl1+l8RKQi6iyU5jNFQBAosCOokknluHImdtXMefuGuyeKSKtL
   A==;
X-CSE-ConnectionGUID: r6BSXqWIT7mkeD+wpwx7Vg==
X-CSE-MsgGUID: TlqgB8HpTPKuSRNqYjjhFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="106695810"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="106695810"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 03:39:43 -0700
X-CSE-ConnectionGUID: Y53h1MfVQyyro4KAca8dBA==
X-CSE-MsgGUID: BZuHkW03SgS6qYNkaoUSlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="274483667"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 07 Sep 2026 03:39:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 773E099; Mon, 07 Sep 2026 12:39:40 +0200 (CEST)
Date: Mon, 7 Sep 2026 12:39:40 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: recover after failure to start the frs
 ams
Message-ID: <ap6UbOSYDh6GDDhB@black.igk.intel.com>
References: <20260903-frs-error-handling-v1-1-ad0fee541847@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-frs-error-handling-v1-1-ad0fee541847@google.com>

On Thu, Sep 03, 2026 at 12:22:21AM +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Reset the port if the tcpm fails to start the FAST_ROLE_SWAP AMS by
> initiating error recovery on it.
> 
> This helps in cases where some cables (incorrectly) signal an FRS to
> an FRS capable port during disconnection. The TCPC autonomously starts
> sourcing VBUS on detecting the FRS signal. However, the VBUS sourcing is
> left on when the FAST_ROLE_SWAP AMS fails to start (as tcpm_sink_tx_ok
> is 0 as CC is open due to the cable disconnect). This is because the
> code sets the state to INVALID_STATE without resetting the port state.
> 
> Log snippet before changes:
> [  101.401960] AMS FAST_ROLE_SWAP start
> [  101.401971] Sink TX No Go
> [  101.401982] sourcing vbus
> [  101.401987] VBUS on
> [  101.402159] VBUS on
> [  109.257809] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_READY, polarity 1, disconnected]
> [  111.267442] VBUS on
> 
> After changes:
> [   70.541211] AMS FAST_ROLE_SWAP start
> [   70.541220] Sink TX No Go
> [   70.541228] state change SNK_READY -> ERROR_RECOVERY [rev3 NONE_AMS]
> [   70.541362] VBUS on
> [   70.541365] sourcing vbus
> [   70.541367] VBUS on
> [   70.541374] state change ERROR_RECOVERY -> PORT_RESET [rev3 NONE_AMS]
> [   70.541410] disable vbus discharge ret:0
> [   70.543028] Setting usb_comm capable false
> [   70.544009] Setting voltage/current limit 0 mV 0 mA
> [   70.544034] polarity 0
> [   70.544239] Requesting mux state 0, usb-role 0, orientation 0
> [   70.555550] cc:=0
> [   70.555595] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms [rev3 NONE_AMS]
> [   70.555697] VBUS off
> [   70.555702] VBUS VSAFE0V
> [   70.555762] CC1: 5 -> 0, CC2: 0 -> 0 [state PORT_RESET, polarity 0, disconnected]
> [   70.587794] VBUS off
> [   70.587799] VBUS VSAFE0V
> [   70.655672] state change PORT_RESET -> PORT_RESET_WAIT_OFF [delayed 100 ms]
> [   70.655682] state change PORT_RESET_WAIT_OFF -> SNK_UNATTACHED [rev3 NONE_AMS]
> [   70.655686] Start toggling
> [   70.656274] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> 
> Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index a8cd1959c426..c1045d850897 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7113,7 +7113,7 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
>  				port->upcoming_state = FR_SWAP_SEND;
>  				ret = tcpm_ams_start(port, FAST_ROLE_SWAP);
>  				if (ret == -EAGAIN)
> -					port->upcoming_state = INVALID_STATE;
> +					tcpm_set_state(port, ERROR_RECOVERY, 0);
>  			} else {
>  				tcpm_log(port, "Discarding FRS_SIGNAL! Not in sink ready");
>  			}
> 
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260903-frs-error-handling-253b87a09fa2
> 
> Best regards,
> -- 
> Amit Sunil Dhamne <amitsd@google.com>
> 

-- 
heikki
