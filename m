Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39704A3D2E;
	Wed,  2 Sep 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361398; cv=none; b=Pg+ouTfoebMX1yBeS1CKtFuG0Eh2N30ru5NcCXrC4EB+MNxx0hD12ElakQagyH4yYGIEHdWvjvPBBPAgvUT0uC2bnhTIaRLaRyV81ysRq74ZjJScwHN9AyxQmzG8VEMoYsJS1YGUe5nZgwHotssTNqK770eML6jXtiAwtR2NCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361398; c=relaxed/simple;
	bh=KD+6lCODL8Jpw7wXAp9+Ew4CxAlcbymY0Idmg/TcXDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P50w9oV35jSwlaJ3xH1XXnnWyfLpqoWbco64wGT7gfwza+tDfNaCfuBZzg48OYrBSca/BUxwA1GyOPjlDwz7bec1j/ND4aOVeLfQAkw3JQdjqR06JNp+gnuv69rOwrgWJib9hhjGMOr+e9d4oNWhK1lGpQcAf47asLTMwFzYew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXui4pf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXui4pf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E39E1F000E9;
	Wed,  2 Sep 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361396;
	bh=OCBvBOB1e1Y5F1+Ypq6H7hE+0TjSUszzUJpRr1GndiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UXui4pf3KfAnNS4KIMzvSSf4YWcpH8+KhlHwvfdG5D2nBmBPQ6XwY4BqEkQx+MhNf
	 xGRRGi2NMHxoIlrfZTQYK1XOHDbv28NWQmZCLOQsc4SMgywKBbIFGJToiNkk1Ok05X
	 MiKOlbZrXdqRYpkwcOwUA+Gzfw2ReQrBiGDYI7QDO6ta3F+ZvOl/3ESD1Z4wCdGU7i
	 gLRfTO9sTv/4PdVZv9T1Itw9c6AM2TgS3CT+VeFMWAuGjq+g9KLeo+6DFsFRCasW9s
	 kKX8W0Tgv0STUpjtWH/tplqyclv3qXhOGnQDyxLzQp4bmzK8JCa0mkLB6N5aej1f4e
	 JsJPddeAHqTUw==
Date: Wed, 2 Sep 2026 16:03:12 +0100
From: Lee Jones <lee@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/5] mfd: cgbc: Fix use of negative error code as
 valid session handle
Message-ID: <20260902150312.GC2082450@google.com>
References: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
 <20260811-cgbc-i2c-storage-devices-support-v2-1-3efa998e0ef5@bootlin.com>
 <20260902150206.GB2082450@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902150206.GB2082450@google.com>

On Wed, 02 Sep 2026, Lee Jones wrote:

> On Tue, 11 Aug 2026, Thomas Richard (congatec GmbH) wrote:
> 
> > The cgbc_session_command() return value was directly cast to u8 and used
> > as session handle without error checking. Casting a negative error to u8
> > produces a valid-looking session handle. So check if return value is
> > positive before to cast and use it.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260713-cgbc-core-fix-cgbc-remove-v1-1-79274ad62b3a%40bootlin.com?part=1
> > Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
> > Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> > ---
> >  drivers/mfd/cgbc-core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
> > index 2becaf797646..4a409234e66c 100644
> > --- a/drivers/mfd/cgbc-core.c
> > +++ b/drivers/mfd/cgbc-core.c
> > @@ -103,7 +103,11 @@ static int cgbc_session_request(struct cgbc_device_data *cgbc)
> >  	if (ret)
> >  		return dev_err_probe(cgbc->dev, ret, "device not found or not ready\n");
> >  
> > -	cgbc->session = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
> > +	ret = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
> > +	if (ret < 0)
> > +		return dev_err_probe(cgbc->dev, ret, "session handle request timed out\n");
> 
> Can we make this a bit more user friendly?
> 
> "Failed to start XYZ session"?

The other two MFD patches are fine.

-- 
Lee Jones
