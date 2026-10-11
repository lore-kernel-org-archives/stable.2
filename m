Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7342050;
	Sun, 11 Oct 2026 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791695687; cv=none; b=gJp3bi93Xf7roEkc6wy+W/cwyC7c4uvegiDQVys0Hj0CmuTw2iFsVrSG2m9pGA+ubB7cfzojOfjArkvXuasHR2MuKSA7twYad2fMGRsyogPIOo0GarLZ909goJZuX9bJkgc0yuFFeGaT3uJE89mex/JhwIBhKr1XSkjOyKN1CXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791695687; c=relaxed/simple;
	bh=bsPc9QZnewzUoPnsbu1Wtsbg1fjQ9+m8MYzYIbtWTpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuxUIWPm2pUEs671vtY0bbVubix439Bi/lErGnVUE7OBcaUFApfNWnl5Q/ALiRpWUSLWUH/SPVmt7ufekZMUX3gaw66Gv62ZdxKs7nWKkb9n/huxNF/93rWnJhpCPyEmzO9aHtbOSLoTKy8n9TOXFl6jpqecdVyybB46pHvTtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mQdeUDEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQdeUDEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACD31F0089B;
	Sun, 11 Oct 2026 05:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791695685;
	bh=TzoMVDcB05PDAodT4NS5etr03uij9sNOO9aVLbmXwmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mQdeUDEreLJAcMywzBFLqzRPs6754S1vf6art6JIe7F4rd6F+PcWm+gbTM/1zg4Yx
	 ztqQU6deTdXhDSTBB5iapelEUhla7cvfn19lhj8Dp8BODJz4mHLDHVE8DvCYhfDyVY
	 ZClxDTpKdzbwilGyMB6fUF9NREMeJKmtPEMhiRMc=
Date: Sun, 11 Oct 2026 07:14:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Faqiang Zhu <faqiang.zhu@nxp.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Fix NULL pointer deref in
 debug logging
Message-ID: <2026101116-shortlist-trend-5e9d@gregkh>
References: <20260923-u-ether-gadget-npe-v1-1-ff466c55ecc0@google.com>
 <20261010142650.2664739-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010142650.2664739-1-qwe.aldo@gmail.com>

On Sat, Oct 10, 2026 at 11:26:29AM -0300, Aldo Ariel Panzardo wrote:
> On Wed, Sep 23, 2026 at 03:58:35PM +0800, Kuen-Han Tsai wrote:
> > Replace the composite.h logging macros in u_ether.c with the standard
> > netdev_*() helpers. Because dev->net remains valid for the entire
> > lifetime of struct eth_dev and netdev_printk() natively handles
> > unparented network devices [...]
> 
> Confirmed against mainline. The DBG()/VDBG()/ERROR()/INFO() macros in
> <linux/usb/composite.h> expand to dev_*(&(d)->gadget->dev, ...), so each
> use in u_ether.c dereferences dev->gadget; once unbind clears it, logging
> on the surviving net_device faults, as in the eth_stop() path you show.
> 
> The conversion is complete and safe. u_ether.c has 26 such macro uses (18
> DBG, 3 VDBG, 1 ERROR, 4 INFO; no WARNING), and the patch converts all 26
> one-to-one to the matching netdev_*(dev->net, ...). dev->net is the
> net_device whose private area holds the eth_dev (netdev_priv); it is set
> at creation and freed together with it via free_netdev(), so it is valid
> wherever dev is. The remaining &g->dev logging in the setup paths uses
> the local gadget argument, and the dev->gadget->dev access in
> eth_get_drvinfo() is not a logging macro and is outside this change's
> scope, so nothing is left logging through a stale dev->gadget.
> 
> Reviewed-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> 

What wrote the above text, it seems like this is just a llm output?

thanks,

greg k-h
