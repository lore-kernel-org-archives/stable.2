Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3A12C534;
	Thu, 25 Jun 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369923; cv=none; b=Pj44yiX8STvwvqjjH0Y6XWjX6Qa0qk+k10W3lAX2j00qzSafDXWU15J0r0Z/Qg/7ANPnxaOymGh/jPUqI+KkSg34F8GHxoO8prYFe7BBSkRyHNJXIovxNanh9seC9w9RkkGQqM+mOwTC245MjHz3v/5wYUxyut9veu3x9EmslMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369923; c=relaxed/simple;
	bh=dy89IrAXyiN+3qymd4TLpp3KL+bih7ajv9Uc5kldx1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eM1EnRM7amMnrc3SIsepMQaDD1vRlNO6kC5KVphJYEv2+SCdkewLCwt1NmN7/U93DD19GWdyc3/ZxQPU6RUpVUv7Yg0M4lk28xOCCnZkSpJlTg8UfEY1XzdsZTUk+sO8+SlpeEwNpAIDK6N4D8yaWVPvuAYLKiKq5acLDHBBQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lExvJuq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lExvJuq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13421F00A3A;
	Thu, 25 Jun 2026 06:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782369922;
	bh=YP2XyFFXsHLCVZz2NxjVBRA/Nqt+Ro2yGNjctsi32KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lExvJuq/VOLgATG0xvY4jcvwc94FyB82KN4d09MBMjR8/K8tPxtWHlekqZomwZG03
	 5CrJEyhR49+ho9CT1/o7YNcnez6ggNPMhQgywanD7aTG8W55/BIylcEGTxWG3mBT6d
	 KCeLiYnGisWZrpJsgQ6MOGyKU6PseOr2HttbqXKfUEpMYlglpoVFn0YRDNBIE1ZtS6
	 bX21ZAMrThqoCxj/eRs/DlVYrY8ehqF5NWp1MsyVBxK4B9FcOxe9QtSY3H+f+A+Li6
	 jiVVYhhE5RNcRj1m1xJfV4aeEc10evNMN1OF4Cm8SDQj144JoiMEMQ7Vsmdjiu1REy
	 TN9m7MhVIO9pg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wcdpv-00000001wXB-2v9n;
	Thu, 25 Jun 2026 08:45:19 +0200
Date: Thu, 25 Jun 2026 08:45:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Magnus Damm <damm@igel.co.jp>
Subject: Re: [PATCH 1/2] sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
Message-ID: <ajzOfzITQffmfOV6@hovoldconsulting.com>
References: <20260508120601.426115-1-johan@kernel.org>
 <20260508120601.426115-2-johan@kernel.org>
 <CAMuHMdXAoZ6+Ch-qUhwbV=47PDHfgkARnZpo4h8y0h_uZP73Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXAoZ6+Ch-qUhwbV=47PDHfgkARnZpo4h8y0h_uZP73Qw@mail.gmail.com>

Hi Geert,

On Wed, Jun 24, 2026 at 10:29:41AM +0200, Geert Uytterhoeven wrote:

> On Fri, 8 May 2026 at 14:06, Johan Hovold <johan@kernel.org> wrote:
> > Make sure to drop the reference taken to the I2C adapter (and its
> > module) when enabling USB gadget mode which prevents the adapter from
> > ever being deregistered.
> >
> > Fixes: 5a1c4cb5bc22 ("sh: add r8a66597 usb0 gadget to the kfr2r09 board")
> > Cc: stable@vger.kernel.org      # 2.6.32
> > Cc: Magnus Damm <damm@igel.co.jp>
> > Signed-off-by: Johan Hovold <johan@kernel.org>

> > @@ -387,9 +387,16 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
> >         msg.flags = 0;
> >         ret = i2c_transfer(a, &msg, 1);
> >         if (ret != 1)
> > -               return -ENODEV;
> > +               goto err_put_adapter;
> > +
> > +       i2c_put_adapter(a);
> >
> >         return 0;
> > +
> > +err_put_adapter:
> > +       i2c_put_adapter(a);
> > +
> > +       return -ENODEV;
> 
> I case i2c_transfer() returns a negative error code (the other
> possible value is zero, right?), you might want to propagate that to
> the caller. However, the single caller replaces it by -ENODEV anyway,
> so I guess your patch is fine.

Yes, indeed, but that's arguably a separate change. And in this case it
doesn't really matter currently as you point out.
 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for reviewing.

Johan
