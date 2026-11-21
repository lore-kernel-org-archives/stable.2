Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795252615;
	b=cqSbRURvnppUg743Y2HVmlMDgcT1+syJlb9VQoY1kKAeM/x75024i4/ssi5gAr1rqu3c
	 Hi5m48UIOsmwF6/0MO3Fh6DLzozwvkoiwe4quVN1NbI8kNjYSXhia40DwVFSup2Zh7jfj
	 JuFjsHftmo8XpRH8r4epIO8xZYW+K8+XO8HGkhSU7eazI8pyyEKpT8jg/87RRoSzbCNQz
	 r9dU/CUHrBXroHjHe52ddy4RjswvofxvXFPCE1NcKZOtnUYbioLlaw+0uIPLzmY/83qPK
	 +gCeOMVGFNjOsaiHVM7m2eZqhRsfWBELLWvOdQdy+B1I8fn47q88xY1s7//v+kuOcnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795252615;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tOLRbk1pvSirOCEBKlCoSltr6Jt7C5tsmx6tQdtsMjs=;
	b=eXubks5aW9vE6XrRVc72QNiphXAjPfS/nHeNMWfhsn3n7uUaNYKTK0IWcSVTXxipIBoW
	 Ch4F9tsoxkZMPq76cYJivRd+MV/nH54+KcituXhuJnmy0Iu8kbijIS7wZIEsxa9B/8Pab
	 bKD/jxVzKLg+mGPpqvsjO77O/dIrqDJ/XlxRQ+QsfFjAdVRzkBtzSw6LpG7EKxeGyOY1a
	 6MoQUbE9753Yu4lJAW+xOaFRVOC93CLmEIzwoJaCMQS4CnqMhPgBOZa4Pp4/Adu/IjQ2s
	 xObiRvVmw/tlWrGX9gQcQIXa+3A5opaG4Q3dUSUwS8WdMsmrKVAF+g8Um3USpq32eAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ujXkoVUZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921C606A320;
	Sat, 21 Nov 2026 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ujXkoVUZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83371F000C4;
	Sat, 21 Nov 2026 09:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795252615;
	bh=tOLRbk1pvSirOCEBKlCoSltr6Jt7C5tsmx6tQdtsMjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ujXkoVUZt/uE4hYFhXuFq6zfccUNOcJBiLt6y4DuUxCFI+d9nKtoiLT1aFj0xnAYc
	 vTcgAkUILkrTVqiRVVpqtGo1n0PVmcDXIv9pQqlgBxS4sblvb8ObmyAN1ygrt3BJik
	 M00EsUQTX7+HtkqLurgASIMJlvh+Eez7BY7eQu50=
Date: Sat, 21 Nov 2026 10:16:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: memoriaru@foxmail.com
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	badhri@google.com, stable@vger.kernel.org
Subject: Re: [PATCH usb v4] usb: typec: tcpm: exempt Soft Reset from the SOP'
 MessageID duplicate check
Message-ID: <2026112138-turban-cornbread-efa1@gregkh>
References: <tencent_443620EAE95525A375BB2D8A653406630A07@qq.com>
 <awBIRnc9lBkdVhEK@black.igk.intel.com>
 <1795204200.cover.tcpm-v4@foxmail.com>
 <tencent_D1222948818CA62395FED66DB7F2967B1809@qq.com>
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
In-Reply-To: <tencent_D1222948818CA62395FED66DB7F2967B1809@qq.com>

On Sat, Nov 21, 2026 at 03:25:35AM +0800, memoriaru@foxmail.com wrote:
> From: Zhang Hewei <memoriaru@foxmail.com>
> 
> The PD message duplicate-check and the SOFT_RESET state handling treat
> the SOP and SOP' channels differently:
> 
> tcpm_pd_rx_handler() exempts PD_CTRL_SOFT_RESET from the MessageID
> duplicate check on the SOP path (USB PD spec 6.6.1.2 note: a Soft_Reset
> message always carries MessageID zero, so the duplicate check must not
> drop it), but the SOP' branch of the same switch has no such exemption.
> A cable that sends a second Soft Reset over SOP' (MessageID zero again)
> has that message silently dropped by the rx_msgid_prime comparison, and
> the cable-side re-negotiation stalls.
> 
> Exempt Soft Reset on the SOP' path the same way the SOP path does.
> 
> Found by code inspection; a software TCPC stub was built for the
> responder path.
> 
> Fixes: 6bd181ba60e1 ("usb: typec: tcpm: add control message support to sop'")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index bb90211..89e280b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4200,7 +4200,8 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
>  		 */
>  		switch (rx_sop_type) {
>  		case TCPC_TX_SOP_PRIME:
> -			if (msgid == port->rx_msgid_prime)
> +			if (msgid == port->rx_msgid_prime &&
> +			    type != PD_CTRL_SOFT_RESET)
>  				goto done;
>  			port->rx_msgid_prime = msgid;
>  			break;
> -- 
> 2.39.5 (Apple Git-154)
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
