Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186716;
	b=WfVSAR1Ko3bJ5r0jEs8cLI3FXGjJhvyWooO8yIHTT3Q5WvHjxGnSPeyYJslE7C+IBBvy
	 oXPfZB4n5wijYDldoZDAmxdF35FptaQBPaCvfAGObdSihoeHeqpwu3ia0vWJ4DhWzw81T
	 2VZxyghe/RlkuUuFb0uWcEpv2RaWTFPBJZ/sRxDaHA8canjDbRuf4h+TCb59YZkX1ynv1
	 TuSEUn1KMCRorqWMkWGiuB1OT4+hH5nogty94EJqSEvfjLKCij4lcZ+9ZRftkeGvfwR7H
	 9d/NaAKcBVGiNgPz+gLawkbMob2vpBClcI9CeB8+++8Y14MnXU2Sjya4qNjR9Y2Gv0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186716;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QzeeoR9Ie9GHVw2EY/8WwRf8WnGF6DOzQqVwJKJWVJE=;
	b=ib0yvGut4Tdrzb425Nc8uWx8aXdkG36Iyxb5eKbnprtd2/d1BdvjPzlu+Tt7NwHtMsNe
	 j7+hHU6SlUdtsk8D1p+7GNwa0nq7k4lNpOoLkuIqo6rJhGqCI+NE3lxnU9xfc2DxVLtsw
	 7YQpnkfNcGcmyo0/r+UG4WCx/OAFQTYrk3gauWddGGg2zB2Ap++vFmiZ4O3xiauWmt7pu
	 HkarK9/TvnreG70z8WKNLtxMms13Az4B7bzW4/6LCiZgpFR9PEsAjcBQRx9Aeb5S+grGG
	 Ck4fF1ESVvdu6gOyuVaH9H8lhljuEfMHQXtON4PSAO0a+y2Y9RLuDbVw5rM8xkiZ8hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQAz14Wt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910A460A2621;
	Fri, 20 Nov 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQAz14Wt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FB01F000C6;
	Fri, 20 Nov 2026 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795186716;
	bh=QzeeoR9Ie9GHVw2EY/8WwRf8WnGF6DOzQqVwJKJWVJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hQAz14WtsGwjjZKhKCVZW/TJWpbUMZw13sAlNa8p4mhABSgF5ROyXpvHQFg25vrmc
	 939g4tDEofBoUSt99SDsu63OrgN6IYDmjK1+TRzqglEAQmwFgbzwuN+mmeAV8dTEo+
	 kXxjJkPjN9nGx18VVJGal6jrMLUdQm45nxFmm7xY677Rwq6mxbRJL6sP+u3RcwH5Bm
	 U4pdM5NjTid4+zjlt2nsJTnNIOSfKIOiIKXJEAS7DpKqeJXiSifzV/6MAtkKijAwoB
	 PoRqm/Y/TE5DrEKPSdo1Jz4DnZ47mzdTHcv1yEZynv4ztHaldL2ij7MHdyO3c0LA8d
	 bKSq06S2GUftg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xUQ4P-0000000681u-2YXF;
	Fri, 20 Nov 2026 15:58:33 +0100
Date: Fri, 20 Nov 2026 15:58:33 +0100
From: Johan Hovold <johan@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: musb: fix use-after-free in musb_remove()
Message-ID: <awBgGWd8Oh4j-9H5@hovoldconsulting.com>
References: <20261120-usb-uaf-fix-v2-1-cc3cb2a38ad5@kernel.org>
 <awBebBuAg2w6ZitD@hovoldconsulting.com>
 <ab82b578-8630-4ee6-abc4-50c0c6aab7b0@kernel.org>
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
In-Reply-To: <ab82b578-8630-4ee6-abc4-50c0c6aab7b0@kernel.org>

On Fri, Nov 20, 2026 at 03:56:19PM +0100, Joshua Crofts wrote:
> On 20-Nov-26 15:51, Johan Hovold wrote:
> > On Fri, Nov 20, 2026 at 03:23:14PM +0100, Joshua Crofts wrote:
> >> Currently in musb_remove(), musb_platform_exit() drops the PHY refcount
> >> before usb_phy_shutdown() is called, causing a use-after-free bug.
> > 
> > This is too strongly worded. There is a potential for a use-after-free
> > here but it's extremely unlikely to ever be an issue in practice as the
> > phy driver would need to be unloaded by root while they are already
> > unbinding the host controller.
> > 
> > Why would root want to do that to themselves?

> Okay, if I add the word potentially then it's not too strong.

It's a start, but you also should mention that this is not a real issue.

Johan
