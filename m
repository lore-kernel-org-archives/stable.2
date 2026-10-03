Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76142282F2A;
	Sat,  3 Oct 2026 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013398; cv=none; b=ZOgRxfAPxmDNITE9JSye82DMAO1PQaEBWqKgb33UKzgc2V9ygM5ADtbQa4mxsTboIFlC/MqW72GActmRYq+UYOFeQdd/QqVGbL/55RyG0nn6VzqCAIwbKhqwY9CtkMEKl1T66eguqHtWo5fhgiRCxUYkItmNA/RGy5f+4SSqNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013398; c=relaxed/simple;
	bh=8hpnAQ5IHvGQlpu8Mc/fUf4qUTHEVGC6KHm2a+KVWUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thJxCuxrw2ANhjJlZ/SR9NLnm+H+9e6ZGiPlaK3jlYjB0rFU9HwmLNcJbfsmgopHof+nrJEloBFj49kTHsRdV6gAPE03Hn74VsS5gp9Dwx+K3x3eTFYEeSmF9k3SGFwUcXwmBRd/hmNIsH6THCVxRuM8W/1Xy/4mjp89lhJX/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YzTtxB03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YzTtxB03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2561F0089B;
	Sat,  3 Oct 2026 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791013397;
	bh=SF9K5Mghlg3GQOMOGKxFY3Re01imsf1abm6svs0RQ18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YzTtxB03K+V+wsqeJ49G/xScy02Bioov3KJItO0rFb43XVyYiqSV8n5tvRXisv0Ue
	 AH6yQuywcwkbT2tWcybdN0Ch2GA2hHFPkAQwNReDuiKeFGFQlPwvozknogZur73w5y
	 PhsUEfWlYjutIpirKlBrcZc0XWui5/QAESbaGFZg=
Date: Sat, 3 Oct 2026 09:43:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Radek Podgorny <radek@podgorny.cz>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: 7.2.y took the on-air address fix without its companion
Message-ID: <2026100356-magnitude-esquire-89fc@gregkh>
References: <179097754519.501890.1801734138080126989@podgorny.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179097754519.501890.1801734138080126989@podgorny.cz>

On Fri, Oct 02, 2026 at 11:45:45PM +0200, Radek Podgorny wrote:
> Hi Luiz, Marcel,
> 
> 7.2.8 picked up, via AUTOSEL,
> 
>   a552b4bc058b Bluetooth: put the peer's on-air address on air when we
>                cannot resolve        (mainline 4914c4998961)
> 
> but not the patch that was sent and merged immediately before it:
> 
>   14b015afb556 Bluetooth: forget a peer's RPA once it advertises its
>                identity address      (bluetooth-next only)

There is no such commit id in Linus's tree :(

> They went out as a two-patch series because the second one depends on
> the first, and the commit message now in 7.2.8 says so itself:
> 
>   Without that, a peer that turns privacy off would be dialled on the
>   address it abandoned rather than the one it is answering on.
> 
> That is the situation in 7.2.y now, and it is a regression against
> 7.2.6:
> 
>  - hci_connect_le() substitutes the cached irk->rpa for the identity
>    address whenever the IRK has one.
>  - __hci_conn_add() in 7.2.8 keeps that RPA when LL Privacy resolution
>    is off or the peer is not in the resolving list, which is the change
>    a552b4bc058b makes.
>  - Nothing in 7.2.8 ever clears irk->rpa. The only writes to it install
>    a newer RPA, in hci_find_irk_by_rpa() and hci_add_irk().
> 
> So a bonded peer that stops using RPAs and advertises its identity
> address is dialled forever on an address it no longer answers on. In
> 7.2.6 __hci_conn_add() converted the address unconditionally, so the
> same peer was dialled on its identity and the connection succeeded.
> 
> 14b015afb556 is the invalidation that closes this: it clears irk->rpa
> in process_adv_report() once the peer is seen advertising its identity
> address. Nine added lines in one file.
> 
> Could it go to mainline as a fix during the 7.3 cycle rather than
> waiting for the 7.4 merge window? Once it is upstream it reaches 7.2.y
> by the normal route. I deliberately left a Fixes: tag off it when it
> was posted, so as not to invite a backport while __hci_conn_add() was
> still masking the stale address -- that reasoning does not hold any
> more now that a552b4bc058b is in a released stable kernel. I am glad to
> repost it with Cc: stable@vger.kernel.org if you would rather have it
> that way.
> 
> For the stable team: if holding it is not workable, reverting
> a552b4bc058b from 7.2.y restores the 7.2.6 behaviour, at the cost of
> re-exposing the bug that patch fixes. Only 7.2.y is affected; 6.18.54,
> 6.12.111 and 6.6.157 carry neither patch.

I'll wait for this to hit Linus's tree before pulling it into the stable
releases.  Please let us know when that happens.

thanks,

greg k-h
