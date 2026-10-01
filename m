Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3F242D97;
	Thu,  1 Oct 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845083; cv=none; b=qFYUHENQx/Q2VYj0INF7LhVVdVi2D2tOUeUz9JGFz36SY84vzl0y8ZcGjFvnC4dSJrnDR/4BwJwtjxWojSCY7RoMCnZaOmvh+wJsFpGxMWRTowb41k1obFOMB7lSZAoP5iHAYOJ5rh8LBPjYG0ZnWDPviYWevu+wAaEvYzGTgxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845083; c=relaxed/simple;
	bh=a9uVulWxMVOXfts2Iw/5Aa1VFd+QlJbHTxq32bl3IQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XquJJpmSbLwAq4Twd/TR8v4vI4j3HKF5bQswZe4Bah/5DsiFeL23BVMrpPyJfYuB9oaokOZBDHi4i07N8GosVm/J//RTcN1GDhjqyc9NWouXFP3LHZZ/WLduC4bGt66tXTTYbnbYz+Yes7CQKlqJPAlVAv552bMjZbMYVFa+qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VvHm2OKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VvHm2OKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7021F000FF;
	Thu,  1 Oct 2026 08:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790845082;
	bh=RQbQe2gHs+3CDAyt3dtTz+9Qv5WQ9txPmDK/APQjSYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VvHm2OKG7JNS2euP8edOAlfQSSi8d8RW4aTObqH6n4iGVRNmjkpKODwYJjoKATdMd
	 U2V874xaNaeEFttu0TRF4IAxLpKpSIh6frDq7EP26ION3fsoR4bkYB62Dn0yqsqg85
	 O6blGVh9RHIY0eS//Ieuk7SvoaIrjfmxPsSye+5k=
Date: Thu, 1 Oct 2026 10:57:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fan Wu <12321260@zju.edu.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: imx: cancel RS485 trigger hrtimers in shutdown
 and remove
Message-ID: <2026100149-constrict-frail-4f4e@gregkh>
References: <20260819021916.442827-1-fanwu01@zju.edu.cn>
 <46936686-3bdd-4d36-9124-e8d3376ad5ea@kernel.org>
 <C6A3233A-A352-45AC-A498-0DED1EC57147@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6A3233A-A352-45AC-A498-0DED1EC57147@zju.edu.cn>

On Wed, Aug 19, 2026 at 02:39:45PM +0800, Fan Wu wrote:
> 
> > On Aug 19, 2026, at 12:26, Jiri Slaby <jirislaby@kernel.org> wrote:
> > 
> >> serial core does not call the
> >> driver shutdown on every path that reaches remove().
> > 
> > Could you be more specific on what path it does not?
> > 
> > thanks,
> > -- 
> > js
> > suse labs
> 
> Hi Jiri
> 
> Yes. The relevant path is a console port whose last TTY user closes it
> before the device is unbound.
> 
> tty_port_shutdown() skips port->ops->shutdown() for console ports. The
> last close then clears the active state and dissociates the TTY, so the
> later tty_port_tty_vhangup() in the remove path has no TTY to hang up
> and cannot invoke the driver shutdown.  That is the path the cancel in
> imx_uart_remove() covers.
> 
> trigger_stop_tx can already be pending at that point: after TXDC,
> imx_uart_stop_tx() starts it for delay_rts_after_send, whereas the close
> path only waits for TXDC.
> 
> I can add this to the changelog if you would prefer the rationale to be
> spelled out there.

Yes, please do so.

thanks,

greg k-h
