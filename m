Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98C4F93CB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063136; cv=pass; b=VzKjWofOuC7oLaA91oYMNvaOlzw+g8bFvP7h9GFyO1hHG8nhWcWbybZNW9aU5bvtxblQXb5gy/2poY16Z8s8+G79V2i4p629pN2adP+mnnxe+ECp1KTxwTfVVbqtOBhP+PyzKr4JxO7lPpP+FAu4PqgHXluMwFo7UK3Jjo2w1Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063136; c=relaxed/simple;
	bh=vwk3YHzhVRubUb6LXpTknkCoqeslrv42vzJiu5ebNn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooj11lS4Dnn68WKagMWeD8T3puFSpvnzjJ4hcvVEBpS7oEbX+3Jp5zLxsTgTKF7AtUouyviUYRrjRc2VOCeM7CxCrbU3A/dpFJGyf9hqBaVX33tn1Zao+RLSSGVgfQ2JFpr38IJUlesNj0l4jvXdVeIkvd3RI4hpJG+ujipwyts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNg6zioy; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNg6zioy"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab1ef11so3369030d50.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 00:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790063127; cv=none;
        d=google.com; s=arc-20260327;
        b=CJwlQ6azYLFgzCuR6VlA2UdnkvWZrjgCRflQeEHyB9ivj9OK4CqxedihSHC3XkgRi4
         L7q2vb0y9kLJkDSO7lq2dZc0X73iGZ4VKw0EFrxZ2jxeNMWtoT2Zb1cc/M8aUa9BFPu6
         Gr1FIY+bUPaVgT8sNn6b2tSq35HWLhVPWDLo+/k52by5yUAbEy2KCYwWa+h/HWoZImjb
         ovA0t7d4NkhU0CKzoOAoOvwftmntzubuZkrOu07emW9mO3BhdmMNn8poV4OGIk9x+/T7
         liSlolceBSr5xXg6/pRm8lIiWekfDmqCSawUqCL6nfRMpdSnMjCF1FR288Yo4eHTvpC0
         pGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H+UYLFM6FSgyZSccr2Im7M4AUKvCegECPqck3iL9VdA=;
        fh=0dGEhnbNnCTMUdyFG4WsLaS4d3vsDfnDdTusSJvA/8g=;
        b=PuLzco0L6lfKR0WF8Xg/NBxNV6Yf9BVPyAT6rYVkeG3nxKCUJHafr7usd5dxqn8GZ/
         /XKrXijfuervyOXTD+ub7aBJ9eYqims//atXa/oXRxsniO19Poa7Yrq22lVVBBHCw+l2
         +ncNGXqLg/ifPa3U29/9tWSqPraSvYeRcwQkYaljYRuH307YToWrIJ14mCvgKZZzVdDB
         yWc8A2jJmqHLG0+2NeV4OlX1IXnO6iYr7qUoQVAfo+sS7XDC8yBB2qFcrLj2RDxLbA2O
         /20Lha35IP3M9nDJYSXo80cxixZdxVoktSZ70ZcoCm6VxE73zFdgOg1nWIbjizlYEn9s
         /8kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790063127; x=1790667927; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H+UYLFM6FSgyZSccr2Im7M4AUKvCegECPqck3iL9VdA=;
        b=hNg6zioyPkj3Vxo6UL4pmtbNqUQn/ScNQyw72P3LgDdRR8KZwwVyW9UoRfULYdcO8K
         Hdxa7466v0D3DLvtELMdXcPbNOobkoYIarzfkp2zA6FdRpjfZm1nCYMbM8ZvHzeUbh+0
         9b0h/H4dDBIjSr6nrw9bnfkNbsJ9kkH2MxVfMW3hm+HC+X3WCRel6i2q6ReK2CHlNAYG
         DP3Dw1zD6p5rJBrKehWRwfGWJPDG79sojIvw1aez+dkkDzdfYWFzAiU6mjhGT3avWJ0P
         9VDEPOkzh1/HnqlSqMax9NIoxl5NSC8O7tejwQNZt4yYe4jW0zB/P6djsh0x/u4jmzUv
         lPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790063127; x=1790667927;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H+UYLFM6FSgyZSccr2Im7M4AUKvCegECPqck3iL9VdA=;
        b=QXjSC2PSpX+eleK01ZaNlrfGE5UmjRyHlEq+F6nHqMCIoqipq5URUTLQiOoqddYeuk
         RGOTWm93CRsJ1kG5nCCMfm6k8MfAgWIAL2d72PK11hJ89SsQnvOrUhaQgZzuCvFGUeJT
         hr5rgFvyX0uxAGKH4gA9ChrgYkU05JOjyckmbcVqIUX5fQfLN9ct8cHaLQVZ3T035gYK
         d2/apme6OUNdUQBebO6USfpbCBstBYukzhhxZTUNl0d8oSAKhWfwRpz6eWutLgMLmGia
         qdXcf6ROK7pi3s1PmtKjVurzQ1Xr/DlGVCNshaOpRJuaResqe4E4Jz1sIS0odMulHW42
         Wohw==
X-Forwarded-Encrypted: i=1; AKwUvBzsJF7Kgz6bX6yOAtfEVEjhdOZnPm7h7lxiHumBruVsJC3hlY7l71zlV8V08Rvvdl3lGGuwa5Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lxzinP5a4KAuPtsc/wcYlHOYJN25e5I3lmP6+E0XEIG+CeSbV7
	rNDi76PJu8/usO0C9gyV9gdq5l5UQnt/r12BPvKlRVIC9pavd0nzSzheTt8HTt601m28E/gL7yf
	ZvomHYvEQVcJwqjkTCsQpSTD6kJdC77c=
X-Gm-Gg: AYBFou2xcHI4NQAqxEiPjI10WVLYRygCWU41/Msi8y954sMVdBxBohy21t8zJC/YE0k
	K2FMmPCxKjkf3a48cAXBRGwsJtEpQHeZYSy0Ey4zCEkbeux7eiiUmKvObK7tvC7pd03h6yg2MJQ
	dmFjzg6b1ThK8Ky3D2a1pYynFjcS3QAW3FETh+6jvHeBtI/Dx/jXm8+OTLReguYJGb/2+7qFarf
	m6oLn9kD1hRigiD7j9G6PggrjAnrdUhAEdfWr9y5snJBW0JdT0v61BicSiqA68f8Wx7vekDaw7m
	TDWVXK6SN7olpUBFn3pO+KUXMn35teQmgffAQwgQZpy6GdUgkq5BSvP+Uw==
X-Received: by 2002:a05:690e:4504:10b0:66b:14e5:d226 with SMTP id
 956f58d0204a3-6717fcca387mr2794016d50.34.1790063127085; Tue, 22 Sep 2026
 00:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915090457.2342778-1-lgs201920130244@gmail.com>
 <CAPY8ntA2h_ChCWJbAmCVygYiviTdsd9TA2LcVh5ffto__LgZAg@mail.gmail.com> <aqz4fLrtW3f7OoYk@kekkonen.localdomain>
In-Reply-To: <aqz4fLrtW3f7OoYk@kekkonen.localdomain>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 15:45:13 +0800
X-Gm-Features: AcwNN1WbgY-jD334r7w3_JXPxi1yr4UDfUsx_etRp47_SqH8gSMFaJ8SCAMR3JA
Message-ID: <CANUHTR9_XR7Q1CJQwKHd6dZRLaJdRNpHxYbUVXkJj_iM7ywoeA@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: ov5647: fix power cleanup on remove
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, Jacopo Mondi <jacopo@jmondi.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dave, Sakari,

Thanks for the clarification.

On Fri, 18 Sept 2026 at 16:45, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Dave,
>
> On Thu, Sep 17, 2026 at 02:27:30PM +0100, Dave Stevenson wrote:
> > Hi Guangshuo
> >
> > On Tue, 15 Sept 2026 at 10:05, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> > >
> > > ov5647_remove() disables runtime PM without powering off the sensor if
> > > it is still runtime active or updating the runtime PM state to
> > > suspended.
> > >
> > > pm_runtime_disable() prevents further runtime PM callbacks and waits for
> > > pending operations, but it does not force the runtime suspend callback
> > > to run. If the sensor is active when the driver is removed, the external
> > > clock and regulators can remain enabled and the power-down GPIO can
> > > remain deasserted.
> > >
> > > After disabling runtime PM, call ov5647_power_off() if the device is not
> > > already runtime suspended, and then mark the runtime PM state as
> > > suspended. Checking the runtime status avoids disabling the hardware
> > > resources a second time when runtime PM has already powered off the
> > > sensor.
> > >
> > > This issue was found by manual code inspection.
> > >
> > > Fixes: 089b7c70f0d8 ("media: ov5647: Use pm_runtime infrastructure")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > > ---
> > >  drivers/media/i2c/ov5647.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> > > index 3facf92b3841..d42d009772ac 100644
> > > --- a/drivers/media/i2c/ov5647.c
> > > +++ b/drivers/media/i2c/ov5647.c
> > > @@ -1271,6 +1271,9 @@ static void ov5647_remove(struct i2c_client *client)
> > >         v4l2_ctrl_handler_free(&sensor->ctrls);
> > >         v4l2_device_unregister_subdev(sd);
> > >         pm_runtime_disable(&client->dev);
> > > +       if (!pm_runtime_status_suspended(&client->dev))
> > > +               ov5647_power_off(&client->dev);
> > > +       pm_runtime_set_suspended(&client->dev);
> >
> > I was unsure whether pm_runtime_set_suspended can be unconditional or
> > should be in the if clause. There are numerous drivers doing each.
> >
> > As it happens, Sakari's just answered that in [1] that it should be
> > conditional, so I'd take that as gospel. It looks like he's given a
> > similar answer on your ov2740 patch.
>
> Runtime PM is a bit mystical in some places. pm_runtime_set_suspended()
> appears to be setting the device's Runtime PM state disabled as it name
> implies, but it may also e.g. increment dev->power.disable_depth. I'm not
> fully certain if this is by design or not.
>
> --
> Sakari Ailus

Would this be the right way to change it?

-       if (!pm_runtime_status_suspended(&client->dev))
+       if (!pm_runtime_status_suspended(&client->dev)) {
                ov5647_power_off(&client->dev);
-       pm_runtime_set_suspended(&client->dev);
+               pm_runtime_set_suspended(&client->dev);
+       }

If so, I can send a v2 with this change.

Thanks,
Guangshuo
