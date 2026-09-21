Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962CE235BE2;
	Mon, 21 Sep 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955629; cv=none; b=IQVVdKX6JA2sHWtbccqCnOi//P/ru7/FtGAGPmgzeaWcRNrTuvdpe43lxBbJtNMA2rtQcjdFk4YXwKtLUaOtHsmzhhV9YtNTwEz7Lj73Ll+3kWqAJ7OTVPQ68zkghpyvi8cu3PWg2W/gepzPgFDrHkD+KeVUbkBFih3PRW5zjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955629; c=relaxed/simple;
	bh=K1aTwpBYpq8sMqlsMRmpt0n6LWIfZ+5sPzsLTLSdyHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoKH+227D3yt/wJatAn1eHuUBGaMqsqXbsHSgLHLZ3z+twDrI0D1vkAMNxsEi8mOHNo8l0d1WoG5whTp6AeWz/y/1BsftylIymC4PXAT0pQmS1J2kEIwqzQtanIHXgdzXW5xp3dsx4z83Vns1plnLonwOPqdHIv3nYuW/pGLYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaIVF30O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaIVF30O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96DB1F000FF;
	Mon, 21 Sep 2026 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789955628;
	bh=s8v2kj3OFsQtnmtpMJhSCI/Ukbit3X8anEX6BY7mi1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZaIVF30O3LCey50q5Mz6QPiL8pAeM4snW/bbYnpGiReVw+oGpwWSVBFtGJuxyTj+9
	 W8Vjzq+9wb7NWjzZmD6Qh/hrNFE5cN/uK9aU+EOgn/o/MB8qZ/LtyHbzD0DHdcWpsG
	 pplsczoDocFeV1KOQgOkmT/fMrDnuxb8Aa0MJ0v5NKX6Dv+7bUYfyr6UuhlnZ56B6l
	 tAlJaGRcslicT+9S+omFrSP1t4owSqKP3OgUeOddR+8NwHE4UJIlxGhIfa1vXzsPLC
	 fTMyZtmhxoBN7nmip7kf8Vuv3Yilv8myl4XNYlVuBCsfdCziT0yGjKLsx1deW4sYkR
	 h3o+8Vn/OlDNg==
Date: Mon, 21 Sep 2026 02:53:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray
 <wbg@kernel.org>, Lee Jones <lee@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH 01/15] counter: rz-mtu3-cnt: put runtime PM on
 initialization error path
Message-ID: <20260921025345.2e411cd6@jic23-hlaptop>
In-Reply-To: <TYRPR01MB156190DDA845D556BF192BC0E85B82@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
	<20260914203614.2035277-2-cosmin-gabriel.tanislav.xa@renesas.com>
	<20260917014616.17b5f0f2@jic23-hlaptop>
	<TYRPR01MB156190DDA845D556BF192BC0E85B82@TYRPR01MB15619.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 06:36:45 +0000
Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:

> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Thursday, September 17, 2026 3:46 AM
> > 
> > On Mon, 14 Sep 2026 23:36:00 +0300
> > Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> >   
> > > If rz_mtu3_initialize_counter() fails, the runtime PM usage count is not
> > > decremented.
> > >
> > > rz_mtu3_initialize_counter() will fail if the requested channel is busy.
> > >
> > > Call pm_runtime_put() in the error path to decrement the usage count,
> > > and flip the check to keep the success path straightforward.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > ---
> > >  drivers/counter/rz-mtu3-cnt.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
> > > index 7bfb6979193c..48f183f0b54f 100644
> > > --- a/drivers/counter/rz-mtu3-cnt.c
> > > +++ b/drivers/counter/rz-mtu3-cnt.c
> > > @@ -506,8 +506,12 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
> > >  	if (enable) {
> > >  		pm_runtime_get_sync(counter->parent);
> > >  		ret = rz_mtu3_initialize_counter(counter, count->id);
> > > -		if (ret == 0)
> > > -			priv->count_is_enabled[count->id] = true;
> > > +		if (ret) {
> > > +			pm_runtime_put(counter->parent);
> > > +			goto exit;  
> > 
> > I'd use a guard() for the mutex and return here and one more case
> > above. Not quite the minimal fix, but will give a more readable result.
> >   
> 
> Hi Jonathan. I did the minimal fix here so it can be backported easily.
> Patch 14/15 does the guard() conversion for the mutexes. Is that okay?

Not my subsystem / problem ;)   General rule for fixes is do the cleanest
for what is 'now' upstream then if backports need to do something different
go ahead and do it.

For cases like this it doesn't really matter either way

Thanks,
Jonathan

> 

