Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565851AFDB;
	Thu, 15 Oct 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068706; cv=none; b=YNUpR52de3t+fOU5/Rc50jsjqzPtvOx5SfSRDKRm3KyEKBdPTvBpKM/q8RwAZW2UG6IkoAnUkpKyQy9OQUpKVDCR0JWcPTE0G0MSYchbVlwxfT8+xWLSidvssSl8vGANrzdJsd8U+UQ+1HYeFkbbpj3g9w51f02TwoJ3FpOhl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068706; c=relaxed/simple;
	bh=QXllR0xP8nWVvi4ycSEzU3+CGxjq+MXIYtSkdlH3t/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsZZspeHyQK3qyakEMLK6q6fyoF7BD5uRJjxnLg1bQydNDy0YMfDauyQ6L6rmtjMxvjHdf33ToX0TA1/yFbJE5nGG2U5+lSSUuHY8qLVszl5k5zB6eE/WytL+s3osAdJ8zI1cTGwF7OLtzANFc16VN2pX1hNYJoe0NhGLkhAAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JoNhX8C7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JoNhX8C7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178A01F000C4;
	Thu, 15 Oct 2026 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792068704;
	bh=IWtHMI/eMhJnI9me/c92CVJGdl0B9ute1Ne9yIrUfww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JoNhX8C77Ykv96e4Yk0ko6Smt0zFrtP1GFRE4zwmTf3o6Jd6iuQoBEf/NAvmW6JaH
	 BIHCVrqch7YPo6bMoc5X5nXp2LHMOtCUpRSFVEXKldzxmzfdESHrirTyNb2Jf1Lpxr
	 71rZ4W/HsrP6AoOPDq6VtBzX6Z9gApAzzXSSxFa8=
Date: Thu, 15 Oct 2026 14:51:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Jan-Simon Moeller <jansimon.moeller@gmx.de>,
	Pavel Machek <pavel@kernel.org>,
	Joseph Strauss <jstrauss@mailbox.org>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] leds: blinkm: Clean up sysfs group on LED
 registration failure
Message-ID: <2026101556-boxer-underfoot-1e9f@gregkh>
References: <20260926000344.29899-1-mhun512@gmail.com>
 <179198508016.839288.4695468891309561458@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179198508016.839288.4695468891309561458@kernel.org>

On Thu, Oct 15, 2026 at 12:54:33PM +0100, Lee Jones wrote:
> On Fri, 25 Sep 2026, Myeonghun Pak wrote:
> 
> > blinkm_probe() creates the BlinkM sysfs group before registering the LED
> > class devices. If multicolor sub-LED allocation fails, probe returns
> > without removing the group. If multicolor LED registration fails, the
> > helper removes the group but returns success, leaving the device bound
> > without an LED class device.
> >
> > Keep LED class device rollback in the registration helpers, but remove
> > the BlinkM sysfs group in blinkm_probe() when either registration mode
> > fails. Propagate the multicolor registration error so probe can perform
> > this cleanup and report the failure.
> >
> > Fixes: 56e8c56c9af0 ("leds: Add multicolor support to BlinkM LED driver")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v2:
> > - Move sysfs group cleanup to blinkm_probe() for both LED registration modes.
> > - Propagate multicolor LED registration errors to blinkm_probe().
> >
> >  drivers/leds/leds-blinkm.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> > --- a/drivers/leds/leds-blinkm.c
> > +++ b/drivers/leds/leds-blinkm.c
> > @@ -671,7 +671,6 @@ failblue:
> >  failgreen:
> >  	led_classdev_unregister(&leds[RED]->cdev.led_cdev);
> >  failred:
> > -	sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> >
> >  	return err;
> >  }
> > @@ -714,9 +713,8 @@ static int register_multicolor(struct i2c_client *client, struct blinkm_data *da
> >  	if (err < 0) {
> >  		dev_err(&client->dev, "couldn't register LED %s\n",
> >  				mc_led->cdev.led_cdev.name);
> > -		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> >  	}
> > -	return 0;
> > +	return err;
> >  }
> >
> >  static int blinkm_probe(struct i2c_client *client)
> > @@ -749,13 +747,12 @@ static int blinkm_probe(struct i2c_client *client)
> >  	}
> >
> > -	if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR)) {
> > +	if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR))
> >  		err = register_separate_colors(client, data);
> > -		if (err < 0)
> > -			return err;
> > -	} else {
> > +	else
> >  		err = register_multicolor(client, data);
> 
> Please add a newline after the 'if-else' block.
> 
> > -		if (err < 0)
> > -			return err;
> > +	if (err < 0) {
> > +		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> 
> How about using 'devm_device_add_group() to automate clean-up?

Wait, why is a driver manually adding sysfs files at all?  Shouldn't
this "just work" if it's a default group for the driver?  This way (or
with the devm_device_add_group() call) will race with userspace and
loose.

thanks,

greg k-h
