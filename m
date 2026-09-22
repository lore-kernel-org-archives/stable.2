Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F204F5E14
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060244; cv=pass; b=UxjsYCO6wQzzr0HfdtH44IteejUehgAZerPzMli+dsAhL4RajgmYp47Nkx8vRennTcIdNO9cVGGJ5gC3v+Q+byDm3PNvZpEewicJMOpzX9xCRiWO3Cq7y/73lyp+PTmVgCIG+M8B4Al3igA3PfkiEmUB6aWi1E8cKf/aRYMS5vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060244; c=relaxed/simple;
	bh=gulGgmIcxQuucEmM7OxaEIEnWr9tYGmjARauLmlnFhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9lfzbHLGpazrlIp6IiySgQbG6Kf5+RU4EID2GmFBZp3URR5BBNPIfRrzA0DQGFmEwgPQJ2bfjTNYYTI0KvTnj4/QGgGarSbcK9zNNLOXsECh/QLRNdRCQonwlOBLSZAiY7QuOypJZ1KQ088y81ZH2J8sz7854rs/j/QX0FfUaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu75orBv; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu75orBv"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fded6b087so3649079d50.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790060238; cv=none;
        d=google.com; s=arc-20260327;
        b=XV575KgFaC05K5d8zejD3cwVV9WtSi/knxzlCk5+oUz1WvmmCBT6+QCcFqZgoX3nJZ
         s/etr7remKhZwlhGKy8nMS02Ovv4gDLRmQhgGorSNj0AxB4tEzYO/fdpl4YO9hyeYlnq
         Uz6VJTL/FAPOSfIg9gcsEdA84l3WI1UNuxacej7K2+ttsTNYDbjlvVuq6sI2GRgmSspv
         gYoFN7MkroaTDjzCn8jqb7hQ0ZtCJOqYO9Sw5mJFrX6OeKi0rf6wsFCu75UxAMXTzrtb
         Kt5x5flQWAu2HL8KajPbes9w4OV546677lmSBWz2dwUDbmx8tecrx/fVdtmuAquss0Gl
         wfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U4KectJeHaQp5P1/3b8Vu0MT+3IcZMHOfvXwrVXtfrY=;
        fh=PLcyfDhwvePjjEkb3DktSxED68705XxuoOfUM0+5Fs4=;
        b=jMr+rafGGiaEI7ZJlcOMPO0XQQzqSorgeLWA3qDXJ9VruTX+nRo9Y4f3uKs14mfV1R
         3q9DbS0b2iNiJI53jaZe+3p2uhWEMt60fPD+h+VrLf/67bYIcxeqC6+S+r0Bi9n2xaez
         gSivlRfLJCbsqhmX2UYCQ7Svpprwlr+5T5l7s9KWVhZj6jZ1fH13CdoZ7X+0ZAtaVwET
         ZLnoxE8hm3V6z7a14DmnwqP1+9N0DWElHr/HKfy0Ss2bcJMdVywOSncvDB725LvlSqFD
         U2b/Ovfn+kv0JyBa28zyLnJkZfwbizhBKwA9J1jy3+91erreRtlpdzc2ubCLcBip3exf
         d0GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790060238; x=1790665038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4KectJeHaQp5P1/3b8Vu0MT+3IcZMHOfvXwrVXtfrY=;
        b=Bu75orBvitgScQyBYo1pcGk5u/AVi62vH7nW+tEDgqRNof7PYMjtQl013t51uu/ZGE
         fodfN9QN2BhaKvShx0NhGBoYmcmerkrTXr+TzGYVELNs8EKwH6Fta/ZgdWUPfvJUZbMv
         LxpyMNasRkKw4ZnXkq74Nd4f3IepA6pAtNK8+hkzvvP3fcfG7yPn4ljBmg5BBhWxZqdE
         yhnl1aidJoMimUIzUuIQxyfCEdJlC40jGl8FSk2re7YkD2xgUqMtJtaCxeXalCJHOR6H
         ixEr5s8G9HXc+cXzat4SwVmUDO8PdwtIfsCrMxjd3a2IKCrDmFN6Yq4XBGjnuZNY3dBJ
         dzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790060238; x=1790665038;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U4KectJeHaQp5P1/3b8Vu0MT+3IcZMHOfvXwrVXtfrY=;
        b=CEA2ZrLdgWYr01hS2zk+R2p1I02OlqibOuRo7GXefxwNeYKmrTunHC3PewVh/kRg5k
         NYdPa9uiwR+lQyLLGUBJCEVCMPri5nrWSekBUHraTxk4LlwISjjYd0OV45H8dN7hz2Lg
         hfi9e+U8CxLCFXlwjBZrg+yuv3pz/B164QKqJoFUacdNgqbr+dIAtuan5EPNZ+PciJbg
         pnkB6NwWq8AO2sf5dNFQ0slMix4r2mGpqnXECYCUxFiA9ko5hZ8DMPdZMIloK0J861Jz
         57FXdBeATd58QenDG+cZ5lW4JNfFAfgxgDFDdHWngbcmz58tQIRhsqrcYasm4YjPP1CQ
         76BQ==
X-Forwarded-Encrypted: i=1; AKwUvBybpkM7zT5M0btpycaDZeJs5FNCbGqULvncQ/hpAXDckLmJ5Mc6Z/Y+5FmkOlxUxTFvHHo+yio=@vger.kernel.org
X-Gm-Message-State: AFuF++l4B95bIRjK4AKutoWqm0uX3vPdHLbvPbwHfVkYIkDFuPdGtmGB
	+u2vhyG0fBy1niJ1IPy9QUEC1s2uWxNDMg3tCmFgM2dEuZ1cOPCt/UTKfFC+qZTcYng1Wl/S/XP
	rTJRLpoD/yUpv35V4UJmXJMy71kvYJ9Y=
X-Gm-Gg: AYBFou1AmFuLmaMgv7Dp/0xYAwBHFm5jvbCD4fOQAt8dLvQlNaIn1IhmlboA1mYOKQP
	f/aHZZT6Kmf3DfI1bEpJiUu3CxDr7/fP8cnN5YEJypiJopSskjiJge1mamBRsvHUoMrJbVQZ5On
	xzmb0fdGRt/2EfUJ44ImJHNJyrOXPcVHxKjr2eInmoS2lbomXgU/csf0RZ5ZVW3f+Dk6JNImazC
	rCtP8GK2rPyDttVdQcFHbr4ICi/zG2U2OJDww5lrNaO5cSqiu/6BsfnCkddtIFRpXX3nSLy7RT2
	3aYgtioxQ5D1Fno46uU3aJdUzO0rUo4zqdvbBHy81GYaEjrpSseMX/i0Uw==
X-Received: by 2002:a05:690e:1505:b0:671:26c4:3ac6 with SMTP id
 956f58d0204a3-6717fcb4a0bmr4394504d50.37.1790060238169; Mon, 21 Sep 2026
 23:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921092128.346375-1-lgs201920130244@gmail.com> <20260921115423.GD1466037@killaraus.ideasonboard.com>
In-Reply-To: <20260921115423.GD1466037@killaraus.ideasonboard.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 14:57:05 +0800
X-Gm-Features: AcwNN1WVoOYZCsSEVw6iHCW5xpwHzTDhebwFRSBQ8UxzNV5HWEqjVLiq3FnnnXA
Message-ID: <CANUHTR86sJ_W+0WHHWM1EA_5SASER5OBhZJR-=jmhQd9vuUyqA@mail.gmail.com>
Subject: Re: [PATCH v2] leds: flash: sgm3140: fix child node reference leak
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Luca Weiss <luca@lucaweiss.eu>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Mon, 21 Sept 2026 at 19:54, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Why did you submit a v2 ignoring my latest comments on v1 ?
>
> On Mon, Sep 21, 2026 at 05:21:28PM +0800, Guangshuo Li wrote:
> > sgm3140_probe() obtains a reference to the LED child node with
> > device_get_next_child_node(), but the reference is not released after a
> > successful probe.
> >
> > The child node is also passed to devm_led_classdev_flash_register_ext().
> > The LED class device stores the fwnode without taking a reference of its
> > own, so the reference obtained by sgm3140_probe() must remain valid until
> > the LED class device is unregistered.
> >
> > Manage the child node reference with a devm action registered before the
> > LED class device. This ensures that the LED class device is unregistered
> > before the child node reference is dropped, while also handling probe
> > failure and device removal.
> >
> > Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> > v2:
> >   - Keep the child node reference alive until the LED class device is
> >     unregistered, as pointed out by Laurent Pinchart.
> >   - Manage the reference with a devm action registered before the LED
> >     class device registration.
> >
> >  drivers/leds/flash/leds-sgm3140.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
> > index dc6840357370..973676b1dbb1 100644
> > --- a/drivers/leds/flash/leds-sgm3140.c
> > +++ b/drivers/leds/flash/leds-sgm3140.c
> > @@ -182,6 +182,11 @@ static void sgm3140_init_v4l2_flash_config(struct sgm3140 *priv,
> >  }
> >  #endif
> >
> > +static void sgm3140_fwnode_put(void *data)
> > +{
> > +     fwnode_handle_put(data);
> > +}
> > +
> >  static int sgm3140_probe(struct platform_device *pdev)
> >  {
> >       struct sgm3140 *priv;
> > @@ -220,6 +225,10 @@ static int sgm3140_probe(struct platform_device *pdev)
> >                       "No fwnode child node found for connected LED.\n");
> >               return -EINVAL;
> >       }
> > +     ret = devm_add_action_or_reset(&pdev->dev, sgm3140_fwnode_put,
> > +                                    child_node);
> > +     if (ret)
> > +             return ret;
> >
> >       ret = fwnode_property_read_u32(child_node, "flash-max-timeout-us",
> >                                      &priv->max_timeout);
> > @@ -276,7 +285,6 @@ static int sgm3140_probe(struct platform_device *pdev)
> >       return ret;
> >
> >  err:
> > -     fwnode_handle_put(child_node);
> >       return ret;
> >  }
> >
>
> --
> Regards,
>
> Laurent Pinchart

You're right. I sent v2 too quickly and failed to take your latest
comment on v1 into account. Sorry about that.

What led me to this issue was the documentation for
device_get_next_child_node(), which says the caller must call
fwnode_handle_put() on the returned fwnode. I focused too narrowly on
balancing that reference and missed the lifetime implications of passing
it to the LED core.

Would it make more sense for the LED core to take its own reference to
init_data->fwnode when associating it with the LED device, and keep that
reference for the lifetime of the LED class device? The driver could then
drop the temporary reference obtained from device_get_next_child_node()
after registration.

Does that sound like the right ownership model?

Thanks,
Guangshuo
