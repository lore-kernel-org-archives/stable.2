Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D793CF677;
	Thu,  4 Jun 2026 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555306; cv=none; b=Ng3PBdTHFfJmV9SbORsz53xIJlyU09jjU65EQnnMdducgRIFZ5HelYtNGg7Gj2PvFGepx50CxdNGjKP6toR8BBW0Zg/kKoW9t7TwgtKSlO3GnhzUMgxZqaBQkWagBjy9omPZ9bSzxV5/ggfbEiMKdCZpXcOlZImmhdJ+gek67fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555306; c=relaxed/simple;
	bh=4Oo83pfWxxz500o86x4DgBAtJ2tDHel8DNMTbUCbJAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAPPlN+DRtEw6fEh3MmWVLml8yutKMFB17zAo96Tj2U2LuDSFae/7pLzvuB0jmF5KFbIK2rTCbybvKGBOoJQhC5Kj2N8IU16Hl/VftR+AqG71V8Alz8SWf7PMvCVajfGVKrixIWvcaExE5BDXl1uja2Pl1FBEmTa2fcoKU6d0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTrBy21N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTrBy21N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D201F00893;
	Thu,  4 Jun 2026 06:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780555305;
	bh=Xsy9WUBW3BCpZbwwOyakkEGoxoD/uwZq2V/PrCveiYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fTrBy21NZTvPYvmaC8/3c236EhKZ3MVK98Tcb/tlDr0B1rF2zurtx86QawtsoSFNA
	 e8wNjWYP7r0PM/g/n0AlJIfubHqT2nUUtEq0hk7wTAoDnT7CBWr/i/N0OSUmBqA4aZ
	 ZdKViTzTGWheXd3Hx42g5E1LKp52gOGUGVWQOnSEFO+As4+M3NvG23MVniUScFrWnn
	 GWngQeKiPUakEiWu7vKj1A/vquwFTR9S6H0IgkVA4Q1Hj9BYPfFhw5n6Bd5VaizOvl
	 HwWYwz7xr9jDKxIqJMb3hr2tJThq+M9PitXLimkOiJVy7ae/ArCV8INpEH9Dr0CiPr
	 YNkL79u4OXwDA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV1lv-0000000AtEJ-0kyF;
	Thu, 04 Jun 2026 08:41:43 +0200
Date: Thu, 4 Jun 2026 08:41:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v3 RESEND 3/5] Bluetooth: btusb: fix wakeup source leak
 on probe failure
Message-ID: <aiEeJ8PscwEOFWDc@hovoldconsulting.com>
References: <20260603143643.2514595-1-johan@kernel.org>
 <20260603143643.2514595-4-johan@kernel.org>
 <CABBYNZLr+kLHkjRGOEgyVK7RSfvu0KGjJNrnp5mh-sM66i=5WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLr+kLHkjRGOEgyVK7RSfvu0KGjJNrnp5mh-sM66i=5WQ@mail.gmail.com>

On Wed, Jun 03, 2026 at 02:06:08PM -0400, Luiz Augusto von Dentz wrote:
> On Wed, Jun 3, 2026 at 10:37 AM Johan Hovold <johan@kernel.org> wrote:

> > @@ -4181,7 +4181,7 @@ static int btusb_probe(struct usb_interface *intf,
> >         if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
> >                 err = marvell_config_oob_wake(hdev);
> >                 if (err)
> > -                       goto out_free_dev;
> > +                       goto err_disable_wakeup;
> >         }
> >  #endif
> >         if (id->driver_info & BTUSB_CW6622)
> > @@ -4427,6 +4427,9 @@ static int btusb_probe(struct usb_interface *intf,
> >         }
> >  err_kill_tx_urbs:
> >         usb_kill_anchored_urbs(&data->tx_anchor);
> > +err_disable_wakeup:
> > +       if (data->oob_wake_irq)
> > +               device_init_wakeup(&data->udev->dev, false);
> >  out_free_dev:
> >         if (data->reset_gpio)
> >                 gpiod_put(data->reset_gpio);
> > --
> > 2.53.0
> 
> This seem to trigger a compilation problem according to sashiko:
> 
> The goto statement targeting err_disable_wakeup is wrapped in an ifdef
> CONFIG_PM block earlier in the function, but this label is defined
> unconditionally here.
> []https://sashiko.dev/#/patchset/20260603143643.2514595-1-johan%40kernel.org

Indeed. Sorry about that. I just sent a v4 addressing this here:

	https://lore.kernel.org/lkml/20260604063740.2595260-1-johan@kernel.org/

Johan
