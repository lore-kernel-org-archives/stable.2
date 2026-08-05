Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A673CB56A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905634; cv=none; b=NaXph+0bjaRBaojAA4FY3e2MtvhdbCNaq9PTMz8eH1THLuificWjxrWR3slNxJeayLmev3gg8Xe1DPSKjz7DzYWOsXoJHa5Na/UKV9qBhy5eWf2VB5EulP0OxxZdETf+rQLJwnz2WQ21UEp/y8XJbX8fhxBNW/+/bohx21FAbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905634; c=relaxed/simple;
	bh=vRwjsM5xXnKdcyCTyukRvv6xJjBvYDL+6EfJNM3AJkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oW83XFFC3RDN7n4tE/ohOdwB9vs4s6YppCvHTH8bP9AHeApyrFb0FZrwKVyP/guJhXqKlk1uOGxxKE7DTCWZCW7IlT+SL2y3UU1w0AYlQ4P33fzbZxFcVHdepZvVoDs4JZw8tkk4FoqT7re56XI0d4FG/2XcfZSf1I+Rmeq9IMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/LsUJI6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/LsUJI6"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso331829a12.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 21:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785905632; x=1786510432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5geohaxBsDx9rnOZdu68dW9bxex9dycQnzSElI378c=;
        b=G/LsUJI6MIGcUxr5u/BBhmnGsfqnAhVWg9hiQ3ZB8fOSiB5OlXtvzFdeLc+K/DgP75
         XLuJoGTda05ASgYpL4u5kky6I4I7bk0hcvYIlT21iRTu95ulr2Q6HMoviCrk4UGf3yzb
         MwbrPuCwlBY3osrZzTzsa1rGl9X6AzHsGiuLaVMXNYSPZ9EGtTn/Nu+/vrROdSs4fBev
         9pjekYGvDjipE5tmOqhLq3BXRCQu/KJcNzUpOh4DfiJwrUQkU8DTfh3GaXNG9j9rger0
         JGyGC7ywvlnipM9jRQUyS/mgmHRO0I9/7fVgOQmWGl8nYZ/ctUsUF9zklyli0RPx+mfH
         yT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785905632; x=1786510432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r5geohaxBsDx9rnOZdu68dW9bxex9dycQnzSElI378c=;
        b=G0mblBsH7PpvCfuTUVtpxLOFVBe74WI/GQAaV/1/MxYlGrmuRZYCW7yrH1qEBGEXLZ
         DGkaIqyM82xFR0sMV+ISTF6R70Dg9mF2DP5ZB7zJFgpTH55cJ/dTF3Vd4jMtoQfjfulg
         8omD3FlKe3syHfi54rCE+seP78pIrTdsLoxznKtg++EWpjEhEn1PSQ5hnhzkijF7Iyo7
         yi+e8vDo4y1iGyyIkll16vI7RjUO35fThWkvuZyIFlkpvUGidoQRsmhN7076gucqfca9
         HYcE/xcJsxQ08MQoDem38LFvNa9uIifvBGBbJZXX6NSfRy2TFkD/IuVc9E1/iIj90M/l
         SmqA==
X-Forwarded-Encrypted: i=1; AHgh+RpXtkHxp67NeJQSEhk0m8kcVmhPY2xAglyp5Frfm11ScqAZ9Mi4Kfn/4O8QbVPgVEH/qtGpeuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwYI2AcmyZuN7GWz/NZNEi9oLMC6MNjjZWC2O3iufzKlw2ZC7
	WjVdoKgX0qT2D2X9dP4pc+dvgNHhUL5vRGC9LC55H4stX8ooqyTXR02E
X-Gm-Gg: AR+sD13uyUaV05E2XRoAjtWKFAJPwDVy9CYnxFU9jhm6zJ4d0pGgIm2ScvY2iVY2OFk
	PlI3riL9yVXDbRkEHL7bFD3Bwm3W7r+vIGOFFH8dj2fXEX82pK8Tf4qhRgteDaPfjGyfBeQ647q
	3Yge/w4SG5yhP0AY/XRHtyuWZC6btJzuxHh7Jhs9Z0tZcWNHw1URRDZc+6O8Y/4T8pP1lRtrD7a
	K+XvTxQ1HIvehUyyZOqeKL2fv39/EaDi4lHe6UenRQ3Y7zcWpJjJ+QSg2nLay+hdQPFmirvGCde
	sBMfknqpP3AZUwd5f+MGt1uRmjX1UdAxMuup2Jz/Ai97YoFlJMw9kR+9o3yuzatHq8r5wav6h5Y
	YrbPFpWwKwBFibRGdvR/a5xQBAFo9B2YwpbsZj8VW2YVmxl2WInCObFOBNJclZow1VeY+BozW30
	BD71Ys3pOjuoKNWZtnAzdQAIZPZT5RTXsTzPLclNXcI7r7SJp3gJJDHYUtVwxaecnQ1r8lvXzPm
	9Az50JlRqZo32Fyne4DSrTVmGgsatZLg6ZS2oz7
X-Received: by 2002:a05:6a21:b97:b0:3bf:b8d8:8296 with SMTP id adf61e73a8af0-3cb85ea6f84mr4478577637.26.1785905631930;
        Tue, 04 Aug 2026 21:53:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf3a:ac93:79c4:84fd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df88csm8511990c88.11.2026.08.04.21.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:53:51 -0700 (PDT)
Date: Tue, 4 Aug 2026 21:53:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Shengzhuo Wei <me@cherr.cc>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Zhouwang Huang <honjow311@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()
Message-ID: <anK_oQqFpZLwCA-a@google.com>
References: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc>
 <anJGWjlmRxNMoVLG@pve>
 <CAFqHKT=AEy0-AZsUmcFGbo1iQ00J+ZMdY_9dNJp64wq1QSk6Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqHKT=AEy0-AZsUmcFGbo1iQ00J+ZMdY_9dNJp64wq1QSk6Gw@mail.gmail.com>

On Tue, Aug 04, 2026 at 02:24:14PM -0700, Derek John Clark wrote:
> On Tue, Aug 4, 2026 at 1:06 PM Shengzhuo Wei <me@cherr.cc> wrote:
> >
> > On 2026-08-04 17:50, Shengzhuo Wei wrote:
> > > ---
> > >  drivers/hid/hid-oxp.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> > > index 20a54f337220dc2aee3483a14d542b66c487bd60..abd622ff1b26b312ad9c8a4375822832f8371533 100644
> > > --- a/drivers/hid/hid-oxp.c
> > > +++ b/drivers/hid/hid-oxp.c
> > > @@ -1501,14 +1501,14 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
> > >       drvdata.gamepad_mode = OXP_GP_MODE_XINPUT;
> > >       drvdata.rumble_intensity = 5;
> > >
> > > -     INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
> > > -     mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
> > > -
> > >       ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
> > >       if (ret)
> > >               return dev_err_probe(&hdev->dev, ret,
> > >                                    "Failed to attach configuration attributes\n");
> > >
> > > +     INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
> > > +     mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
> > >
> > >  static void oxp_hid_remove(struct hid_device *hdev)
> > >  {
> > > -     cancel_delayed_work(&drvdata.oxp_rgb_queue);
> > > -     cancel_delayed_work(&drvdata.oxp_btn_queue);
> > > -     cancel_delayed_work(&drvdata.oxp_mcu_init);
> > > +     disable_delayed_work_sync(&drvdata.oxp_rgb_queue);
> > > +     disable_delayed_work_sync(&drvdata.oxp_btn_queue);
> > > +     disable_delayed_work_sync(&drvdata.oxp_mcu_init);
> > >       hid_hw_close(hdev);
> > >       hid_hw_stop(hdev);
> > >  }
> > >
> > > ---
> >
> > Hi Dmitry,
> >
> > Thanks again for the v1 review. Sashiko's v2 review raised two points I
> > want to act on:
> >
> > 1. "Uninitialized work struct access during early raw events" -- agreed.
> >    v2 moved INIT_DELAYED_WORK(&drvdata.oxp_mcu_init) to the end of
> >    oxp_cfg_probe(), widening the window in which an early status report
> >    could mod_delayed_work() a not-yet-initialized (zeroed) work. I'll
> >    fix this in v3 by keeping INIT_DELAYED_WORK() before
> >    devm_device_add_group() and moving only the mod_delayed_work() after
> >    it: the work is then initialized before any raw event can arm it,
> >    while a probe failure still can't leave it armed.
> >
> Hi Shengzhuo,
> 
> I dealt with this when writing the hid-msi drivers as well, and
> Sashiko will continuously come up with new issues for each revision.

Yes, so we do not require patch submitters to act on all Sashiko
findings (and quite often they are not right), especially pre-existing
ones. So feel free to ignore this.

For this particular instance maybe simply drop this change from v3: it
is all broken anyways. The driver should initialize all internal
structures (work items, lock, etc) beforehand and then start configuring
the behavior since events can be coming in at any moment.

And on probe error it should try to clean up everything (again, on the

> The next issue is going to be that the attributes are initialized
> before the setup function has run to query the device after the MCU
> will accept messages. The solution I found was to move
> devm_device_add_group to the end of the init work queue once the query
> has been completed, then inform sysfs with a `change` uevent. Perhaps
> that pattern will be useful here.
> 
> For ease of reviewing, below is the cfg_setup_fn from that driver
> 
> > 2. "Global workqueues permanently disabled on inert interface removal."
> >    The driver keeps all state in a single static global drvdata, and
> >    module_hid_driver() binds it to every interface of the device, so
> >    oxp_hid_remove() runs when any interface is unbound. With
> >    disable_delayed_work_sync() and no enable_delayed_work() anywhere,
> >    unbinding an inert interface disables the works for the still-bound
> >    gamepad interface. cancel_delayed_work_sync() (v1) re-enabled them,
> >    so it didn't have this side effect.
> >
> >    This looks like a symptom of the static-global-drvdata issue rather
> >    than disable_delayed_work_sync() itself -- with per-device drvdata
> >    each interface would have its own works. Before I send v3, would you
> >    prefer to keep disable_delayed_work_sync() (and address the
> >    multi-interface case via the per-device drvdata refactor you
> >    mentioned as a separate patch), or go back to
> >    cancel_delayed_work_sync()? I'll hold v3 until I hear from you.
> >

Yes, so feel free to ignore Sashiko or (if you have spare cycles)
address this global instance in a separate patch at some later time.

> 
> I had planned on devm_alloc the drvdata per device once the msi
> drivers are done. If you are willing to take that on I'll be glad to
> test with my F1 Pro. Out of curiosity, do you have a device available
> to test as well? If so, which model do you have? I can ask the
> community to test on any device family that isn't covered.
> 
> To your question, I don't think the bug fix switching to
> disable_delayed_work_sync is worth the side effects without first
> addressing the global drvdata issue. That would introduce a true
> regression to fix a theoretical logic bug. I would rather you either
> switch to the devm_alloc drvdata first or hold that change until I'm
> able to do it later myself.

If there is possibility to have multiple instances then this driver is
FUBAR in the current shape: one device instance fires up work items for
another device. So holding the patch makes no sense IMO.

Thanks.

-- 
Dmitry
