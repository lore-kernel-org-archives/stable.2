Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978343C7A4;
	Mon,  7 Sep 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772400; cv=none; b=pQlf8dpncWSHll8sqP6FZeRv3nPHf6sKob4bOYhVLq7F5F3CmshVmuRMKtII26Zjbsf5aEpz6Z8MUk4iPYCLZqr8qUH2NA09FyidIwodGQr6yogGtx+XczUDZpkNLK/Va8dFwsLVp8XmNzKR4Dr2uDTxS60PA78tzIdquo+Dmb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772400; c=relaxed/simple;
	bh=+nx3n+PzXzC6DOzQXZ7N2voWtZWW3dQVBhwwo0gwc5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXRCnlmhfrufu5Ruc+95RCXZzFY5KTHq0lBJUO9N/vBTHiXnBvaoeAC+7coiVXinwANEtX80SURnlgYabsagmacWaQVCLmdG0yEiA597Uzo6m6tRPHRULQwnLSIWwv/KxnuJ0OawE5N1DWrqPOTmS6o2+pbiOJaiBl6gyma/SbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtXtIETH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtXtIETH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2112B1F00A3A;
	Mon,  7 Sep 2026 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788772399;
	bh=y4SUmAjDEly6YVaAoBlF8zQKasOjSErO5Fvq9njDkOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AtXtIETHQeGhdUx4HLuok9i6EOSPi5lpyinqM6NO2mfkd7ryd0Rtf9r2JmcVFFBub
	 juI5Gb3EGNXILnhVmSw96cJhqcf2/WSqyKLQB9yG5IUsFHL+r1fx+JpCMzhIGOjaPS
	 WTHPxl72SDGZTCeS7hPSq83ajiSj3+S+IhCfJAIRFVImiiqLRqToDMqieRJWM+zxZq
	 F/0tYWyyZ7uleoilbviY1yTyFJndmsIVSrbhqarfr4K9dySISAr9MfOby3ljg4rS76
	 t0gjptkBAwuJZmqEB2woazNiffitar2upMJBXdSxFqPPmN8fqX4IDKnKQMAKkYfSGs
	 1hFHbFGz34y8Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3VPg-00000000X77-47N8;
	Mon, 07 Sep 2026 11:13:16 +0200
Date: Mon, 7 Sep 2026 11:13:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
Message-ID: <ap6ALMESM5SMQhFV@hovoldconsulting.com>
References: <20260907065501.101013-1-johan@kernel.org>
 <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>
 <ap56NTVMq8GlbjmR@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap56NTVMq8GlbjmR@hovoldconsulting.com>

On Mon, Sep 07, 2026 at 10:47:49AM +0200, Johan Hovold wrote:
> On Mon, Sep 07, 2026 at 10:17:38AM +0200, Oliver Neukum wrote:
> > On 07.09.26 08:55, Johan Hovold wrote:
> > > The wakeup condition needs to be checked after adding the task to the
> > > waitqueue and updating the task state to avoid missing a racing modem
> > > status update or disconnect.
> > 
> > I am sorry, but in this case I have to ask:
> > Isn't TIOCMIWAIT inherently racy against the hardware?
> 
> What do you mean?

Ok, I think I see what you're getting at. Nothing prevents a modem
status change just before calling TIOCMIWAIT from being missed. That is
indeed a general problem with the interface.

Johan
