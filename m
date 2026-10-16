Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024257F757;
	Fri, 16 Oct 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172002; cv=none; b=OMGtr9eMh2VVZQBia4ZziSQ12t/OSXCWvmHR0AgAh3A2Br4HseWEmehoGOUuIEdH3zi44jeprk6i8ovaKaisirzJtxdpzDa69XixiJeY9LqFADdDA97oyu0E8MLHX+XlhGPXEtl0+9DTeZ+OS2+k9jdV9cr+RAife5YaBU11ato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172002; c=relaxed/simple;
	bh=n0PeZJEGslSnriXOfJu/uW2cmVRr6rGV2g0te8yDZnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYlzeSlqfk6rK0JGUAYP53fghYiyYcqcQEp7+VU2qAbk9Y+6k5DPktz8b9nsXOHVR7JPcVXqTtO/0qSWg6AZlTAU27C1N/24UWlu+yuTvI5kPTeHUyRPd5BIlAkdY20nZBgAtFrLaxlfL2F0FuIc2khlyBfw2pTVnPwmFO4RiP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7qfKAd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7qfKAd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2A61F000C6;
	Fri, 16 Oct 2026 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172001;
	bh=WAohLFbfB3ODHlNwzUD2th50q5S7ZDLMMgJY3ZAcjLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j7qfKAd36sYNh02scguDPskmxqtOazJxSsoxy6OLEyr67piIWEX550m7aqkt5IuGd
	 xk0he9AuPD6EP3y9KqMy9GBdYWAZP0wB8quGdwHkmYoMqY2WIlBmIw0AjCgScdeSSO
	 XT1grBBed18JNwCBnaR1X99X9vLHup3tzfJrPc+0GTFbI3ggbsMiFDe5PIhFSLg24v
	 nwTo1J74nKMp3mvG6Y2qSwwyY4HQcYMMyR8LfIcPK+/7WxG8ZU2iWwNdgCc3RAwu+O
	 0lzq0WKRml61S693SNDSnd1NB/A/tFYlrgnsl0fjkC488qtoZtoTNuCR+gZwBAvI28
	 5XR0PXmJ57qJA==
Date: Fri, 16 Oct 2026 18:33:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Martin Kepplinger" <martink@posteo.de>, "Sean
 Nyekjaer" <sean@geanix.com>, "David Lechner" <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 "Martin Kepplinger" <martin.kepplinger@theobroma-systems.com>, "Christoph
 Muellner" <christoph.muellner@theobroma-systems.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Joshua Crofts"
 <joshua.crofts1@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v10 00/10] io: accel: mma8452: Allow open drain
 interrupt pin configuration
Message-ID: <20261016183315.184c6c0a@jic23-hlaptop>
In-Reply-To: <8733u8n624.fsf@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
	<dAyKULwunTSyJswxrFIpB8ECEAybMkvW-mArZ8lYOcKRTbekTIUNXyjnN0kqvequ9qJOPuBSNDdxkJijqhL5Bw==@protonmail.internalid>
	<20261011140002.6e9d68d3@jic23-hlaptop>
	<8733u8n624.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 08:34:59 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Jonathan Cameron" <jic23@kernel.org> writes:
> 
> > On Mon, 28 Sep 2026 10:26:16 +0200
> > Esben Haabendal <esben@geanix.com> wrote:
> >  
> >> Extend the mma8452 driver with support for configuration of the
> >> interrupt line in open-drain mode, which is needed for hardware designs
> >> where the interrupt line is shared with other chips.
> >>
> >> Adding drive-open-drain property to mma8452 device-tree node for such
> >> designs to enable switching pin configuration to open-drain mode.
> >>
> >> Signed-off-by: Esben Haabendal <esben@geanix.com>  
> >
> > Applied patches 1-9 to the testing branch of iio.git.
> > As mentioned, I think 10 needs a bit more review time.
> >
> > We may loose sashiko coverage. In theory you can tell it about
> > dependencies, but I'm not sure how that works with a temporary
> > testing branch.
> >
> > There are some notes on using message-id: tags in the cover
> > letter in https://b4.docs.kernel.org/en/latest/contributor/prep.html
> >
> > I gather from the LPC session last week that sashiko should work
> > with those now.  
> 
> Cool. But in this case, I guess using message-id or change-id would
> be wrong, as it would declare the entire series as a dependency, which
> thereby includes the patch that is being sent. But Maybe I could use
> patch-id to declare dependency on patches 1-9/10.
I think so, but I haven't tested that yet!

J
> 
> /Esben

