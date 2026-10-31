Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451467;
	b=lJEikzvMH7mr2lr98gb8ZnX+dDGERDF2baalW51LIGCcZnSWuTSiuXDuhF/tQ9EnCviL
	 XGv4sMtW1yIslkaS/1DR4UVd9a9xng4zWwjeqYT9BiBwyrk/BcvTsx3QJRmnHbdnv4sKc
	 9J4iXkuMXvNaQMkmnezzTRhb/1+z7udu2m/TByGh0O/bsvCJ8napB7y1aa9OQ/7t19QM2
	 19H8wu8B10jbQtF47gtduUh9J8C3ka3kKf2HsRjQK55eBXtqvwVH5bGpyOxmRUMM+aI1/
	 Wj3gdet2g1EqQTtaOM4Qi4nr78kcDu849jej66bpo3EiZtT/UAoDyg4+qoO4963zsVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451467;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ADpkKw8ZcHosCss31531pr6bot+Oa4C+WQwAZutcz0I=;
	b=azzgb3xjTLXPRrwOo/YQVJHnJN3nG+37z9PmKMmkzXZorERmPJ03dE2BH0Y2sreHdj9q
	 JLpNUwc4er8hvkaEPDqZa2dxuXABst2kkZtMUHET9+hAcB6S5elYRETOEjXzY+Yv2NOVm
	 tcPdCv2u9qd8SWBM7ExJXmoi+1QkyAPbKtEjLf5XwUdKDxD4SQLYUI5U1duJzIt/FjWAV
	 yBtO/VkSML3kjLMQNEB9FuSxQLgyzv8Y4ierIZkGSYO14jqwdTWfmyOxBN4a2mxad1pRE
	 to07UO1IN16ZvZgFOXufSKGKALAAzalK7v7wKDb17MMSvuAtRJ++ltNvyPrKLRsOt9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="jD7YJ/aP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC350606A31A;
	Sat, 31 Oct 2026 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jD7YJ/aP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685BF1F000C1;
	Sat, 31 Oct 2026 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793451466;
	bh=ADpkKw8ZcHosCss31531pr6bot+Oa4C+WQwAZutcz0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jD7YJ/aPzvWc8bhDb3Cu720stmkMJ7M7A1r6OUF5EjHHIePwWGqEgcPnRB2JRAQ8D
	 uIwyeF1RZDDtg0kZWv6OxsQkoh+tiAaq1fAKHXC21E0DPkIp1wqWNCQ0LQE8eiZHud
	 gmhV5aqOZPCyC3tRsRPpRL9We0FX7YDanOv38cz0=
Date: Sat, 31 Oct 2026 13:29:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Radek Podgorny <radek@podgorny.cz>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: 7.2.y took the on-air address fix without its companion
Message-ID: <2026103137-purebred-puzzling-4f88@gregkh>
References: <179097754519.501890.1801734138080126989@podgorny.cz>
 <2026100356-magnitude-esquire-89fc@gregkh>
 <179337661340.2790793.10493980332574129560@podgorny.cz>
 <2026103011-coeditor-debtless-2d94@gregkh>
 <179344898191.3643659.6660410741163325277@podgorny.cz>
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
In-Reply-To: <179344898191.3643659.6660410741163325277@podgorny.cz>

On Sat, Oct 31, 2026 at 01:16:21PM +0100, Radek Podgorny wrote:
> On Fri, Oct 30, 2026 at 11:32:40PM +0100, Greg Kroah-Hartman wrote:
> > I have no context here, sorry, what is wrong?  If that's a bugfix, why
> > is it not cc: stable?
> 
> Sorry, my last mail was too short.
> 
> It fixes a regression in stable. I sent two patches as a series:
> 
>   3889a5fcd091 Bluetooth: forget a peer's RPA once it advertises its
>                identity address
>   4914c4998961 Bluetooth: put the peer's on-air address on air when we
>                cannot resolve
> 
> The second depends on the first, but AUTOSEL took only the second into
> 7.2.8 (as a552b4bc058b). It also reached 7.3 ahead of the first.
> 
> So when a bonded peer turns privacy off and advertises its identity
> address, the host keeps connecting to the old RPA, which the peer no
> longer answers. That lasts until the adapter is powered off. 7.2.6
> connected to the identity address and worked.
> 
> There is no cc: stable because I left the tags off on purpose. When I
> posted the first patch, the kernel still hid the stale address, so the
> patch fixed nothing live on its own. Taking the second patch alone
> exposed the bug. In effect the first patch is:
> 
>   Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air when we cannot resolve")
> 
> Please queue 3889a5fcd091 for 7.3.y and 7.2.y. It cherry-picks cleanly
> onto 7.3.1 and 7.2.14. 6.18 and older don't have 4914c4998961 and don't
> need it. I have run the two patches together since September.

Thanks, that helps, now queued up.

greg k-h
