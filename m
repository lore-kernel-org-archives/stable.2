Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D580471D02;
	Fri, 11 Sep 2026 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116324; cv=none; b=rq5/vuzB+zAE39GDSsVahOGLZ8dv+gEv0Welj6qGfwK4CWOmKneCk7QRlaPXKzq4JGjXifIRjQqolYB9WwhwVMGH2jGEt2SUXACskf7HAXVlMSuQufRswXCZZGHorJQqPb90K7PSUFLreX58cqz9Z4QIOJsKoBUgDmn96t3uxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116324; c=relaxed/simple;
	bh=FVOn9eVfExPih1H3h9rhcV07hrmPKdVvx1JUdO6nt+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc075Vl1g0vp4XaaWZ13KY+JY3zU3fbHdQtOjYAm6UOZWL/IRLCfRS7nLjsuMPmvSCShHmFKzHGtM5jm9Ww5gs2vjSi9Mva9NzKvnJ6WcjgHmpyG+rPB/3bscn/nmaPdJAKdtOjPoVjgiI+qGCjurUKnyof0g4dGjnfIsrOQ/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=EMovzk/G; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="EMovzk/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789116316; bh=FVOn9eVfExPih1H3h9rhcV07hrmPKdVvx1JUdO6nt+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMovzk/GPMARYZT55zqB0h151zATgKRoNilkMVULMebzQHoNBQ7dG06rAzQLU4Zp0
	 YdD3/dUaI1yAy3c83QUjSx1IRtsVlLNNXTOT7uc45GPbUO7JDdBS6nP9cQJzKspFLF
	 PEpcIAzmeqR0/xp1O1And5+OPNSxOAjZffl0ZBKfyM3DVhCiyAp2DLcvkXFyEs9qwo
	 aAyp9yRJSricEPFLrW6Zg48aDFSkGcBy61378kkWF6ewIT5Zhw+roNjrZPAb1aox7S
	 rUYZcx9u1T6nLNvA00GbN+VZ2AaXLzm7WbNT0sL5cRbTJ+BwzMH4CDt6C/CI+gRKrq
	 j53i7v2673ksw==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id E962341444; Fri, 11 Sep 2026 09:45:16 +0100 (BST)
Date: Fri, 11 Sep 2026 09:45:16 +0100
From: Sean Young <sean@mess.org>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Rik van Riel <riel@surriel.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/19] media: rc: Ensure registered is cleared in
 error path
Message-ID: <aqO_nP1-YLQgJpLq@extorris.mess.org>
References: <cover.1788882189.git.sean@mess.org>
 <abfff8cffac8899a26cb258150b5c17b7a2009bc.1788882189.git.sean@mess.org>
 <10c85f87-85db-4ee9-ab80-edbd30f3c95e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c85f87-85db-4ee9-ab80-edbd30f3c95e@kernel.org>

On Fri, Sep 11, 2026 at 09:53:10AM +0200, Hans Verkuil wrote:
> On 08/09/2026 17:51, Sean Young wrote:
> > If rc_register_device() fails, ensure that registered is not set to true.
> > If lirc_register() succeeded, then userspace could have an open file
> > descriptor open. This leads to a use-after-free.
> > 
> > Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
> > Signed-off-by: Sean Young <sean@mess.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/media/rc/rc-main.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
> > index d93e98189c1a..1f99540456f1 100644
> > --- a/drivers/media/rc/rc-main.c
> > +++ b/drivers/media/rc/rc-main.c
> > @@ -1934,7 +1934,8 @@ int rc_register_device(struct rc_dev *dev)
> >  			goto out_raw;
> >  	}
> >  
> > -	dev->registered = true;
> > +	scoped_guard(mutex, &dev->lock)
> > +		dev->registered = true;
> 
> Is the guard actually needed?

Yes, we read registered under lock in e.g. in lirc_open(). It s
racey without.

> >  	rc = device_add(&dev->dev);
> >  	if (rc)
> > @@ -1982,6 +1983,8 @@ int rc_register_device(struct rc_dev *dev)
> >  out_dev:
> >  	device_del(&dev->dev);
> >  out_rx_free:
> > +	scoped_guard(mutex, &dev->lock)
> > +		dev->registered = false;
> 
> Same question here. I think the real fix is setting dev->registered to
> false, but I'm not sure the guard makes a difference.
> 
> The commit log mentions nothing about that change either.

You are right, the commit message needs to mention this.


Sean
