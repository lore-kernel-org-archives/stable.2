Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795302501;
	b=yTd3etO0gsVH5I+lwn6fSnDiy2kI8Ihy8qClYjD0eetjYJdp/vKeeNWjsBJnubSf8cdO
	 X1eMlqxJ9pWW+20OX/KlFH4OqN4CccKjyXiWtLZbI59dlTrWD6BF+eMmTjj0eXdpbBBiM
	 1F2qkJg0QaPunj7cbkBo8MMavEI4MIoq/wQq/7Xpkozy6vP4bZ/I8VYIHiQGBTnvJxOeN
	 ry4kluIbJPMcaKbGvHoKiwXDfK5TtjvYocPtfgyNxIGl2D6torFWn0ht24UTNIQgttfVY
	 I6qHuTSSOB3nLqpMgMlRbeTae1VScQDpYYRO84gts3ZbkwOJXK4E+90tHZbIaasSkiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795302501;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=H/CBwGcnijyRu1LgxwMqIktWt8iJi1924oX4F9L6lNE=;
	b=cZVDkDQzvy/ETKj+H/g5NgnPpc5XlNwCKexwx7yGc+bptKoudJdgL1t/l+SsoQx4vtzM
	 QHANHX4gNSvGkU/WHjKbhm5EIEh1CZiVAvorQYeI27mQGzbRejVOr9FjfMSrI+gJR5Sdc
	 Agut6nb9/+sHfBgDaIntnNzWx9eOKJ3Eegs1LIoxiwgs/keOM9MDXyUoRs+GyZHSQLVPM
	 YVYMNqO3SUSJwkfl/fqahx4Lrmj92CARW+H8Oa1yWfCyCmiyG3IwOAICFvxsPlCvNlWWk
	 pqb8YgCEVltNKx6/nwrrfiy9neTT++8FrA0pLOAFiua3ky9qaLoPqDaGcErI68L3+vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFcUDguT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C07606A330;
	Sat, 21 Nov 2026 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFcUDguT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD641F000C0;
	Sat, 21 Nov 2026 23:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795302500;
	bh=H/CBwGcnijyRu1LgxwMqIktWt8iJi1924oX4F9L6lNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GFcUDguTktk0PmCr+SxS352kExTu+3RpYMZ316Z7fssWn9QGkqHksLFgvSuqfqmIw
	 bwmVboVY7AfpS4V4E1b6wFwiLC8D8Ufte4kaClWE8OSG/UreoJftDO4dkMUyZ9f1j0
	 PishGfgZUfoZo7lCQwdCoIFDHRlv5M96dT1UOpJHo9UXnCpieB8M6OUmRGj3gP5mUX
	 iP53uoChhuI6IXG3dYBvc1gdiQuX8B2BgWxrfoNyJVIl1euoOM7ZKjfLts69Yi/x7M
	 AbDWdmuE1BBPP1Nnd+2eFF9iTCgzMZn7wFqX4VkUNfenWnVQSeij6wZzYM3rqSiPC7
	 prFg8McwGpUHw==
Date: Sat, 21 Nov 2026 23:08:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 07/10] iio: adc: qcom-spmi-adc5-gen3: Free TM auxiliary
 device wrapper in release callback
Message-ID: <20261121230815.5e49b4fc@jic23-hlaptop>
In-Reply-To: <av8yO-0PUvvGsQgt@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
	<20261119153151.1397003-8-lee@kernel.org>
	<av8yO-0PUvvGsQgt@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 19:30:35 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Nov 19, 2026 at 03:30:40PM +0000, Lee Jones wrote:
> > struct tm5_aux_dev_wrapper embeds a reference-counted struct
> > auxiliary_device, whose memory must be released from its dev.release
> > callback once the final device reference is dropped.
> > 
> > Allocating the wrapper with devm_kzalloc_obj() on the parent ADC device
> > and providing an empty adc5_gen3_aux_device_release() causes parent
> > devres teardown to free the wrapper immediately after
> > auxiliary_device_uninit(), even if external references to the embedded
> > struct device are still held.
> > 
> > Allocate the wrapper with kzalloc_obj(), release it from
> > adc5_gen3_aux_device_release(), and unwind cleanly on early error paths
> > in adc5_gen3_add_aux_tm_device().  
> 
> ...
> 
> >  #include <linux/platform_device.h>
> >  #include <linux/property.h>
> >  #include <linux/regmap.h>
> > +#include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <linux/unaligned.h>  
> 
> > +static void adc5_gen3_aux_device_release(struct device *dev)
> > +{
> > +	struct tm5_aux_dev_wrapper *aux_device =
> > +		container_of(dev, struct tm5_aux_dev_wrapper, aux_dev.dev);  
> 
> container_of() is also in a separate header, id est container_of.h.
> 
> > +	kfree(aux_device);
> > +}  
> 
> ...
> 
> >  	ret = auxiliary_device_add(&aux_device->aux_dev);
> > -	if (ret)
> > +	if (ret) {
> > +		devm_release_action(adc->dev, adc5_gen3_uninit_aux,
> > +				    &aux_device->aux_dev);  
> 
> Oh, this is interesting... Usually the release devm_*() calls point
> to a misdesign somewhere. But I haven't checked the twisted flow of
> this code.

It's one of those complex / annoying cases where a driver uses devm but
carries on with a subset of features if a particular bit doesn't work.

Right answer here is probably a devres group.

That is independent of the handoff dance done here.

I'd move the auxiliary_device_init() earlier, stop messing
with the memory being devm controlled at all except by adding
a put_device() in a dev_add_action_or_reset().
Actually that's already done by the auxiliary_device_uniit.

Anyhow, whilst I haven't looked at this that closely looks
like right clean answer is a dev_res group for the whole
function (can be done at the caller if neater). That allows
either handling the group over to normal devres cleanup on
success, or cleaning it up on erorr.

That plus the move of the kfree into release as Lee has done.
Also smells like tm_props lifetime is probably wrong as well
and should be part of the release rather than devm_kzalloc.

Jonathan

> 
> >  		return ret;
> > +	}
> > +
> >  	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux,
> >  				       &aux_device->aux_dev);
> > -	if (ret)
> > +	if (ret) {
> > +		devm_release_action(adc->dev, adc5_gen3_uninit_aux,
> > +				    &aux_device->aux_dev);
> >  		return ret;
> > +	}  
> 

