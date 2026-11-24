Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525478;
	b=iOnkoghkBh+DiAQDZ8pVm5GMQcpRNi6yjZCw+vVVzQ3JixO5NzBnPytuykQkWCC9rs/o
	 y2kexmeq44jUkFsGK8SVQLJ2W3PyILNDsalfq1I4B78nKp544qGRdtCfZV3DPsFjrEa/Q
	 J0rEEVSK8+vhYS8dy55AxJw5WypweclqcYAqW6QxfOWBkRkXCe60D2ujCd8cp7P1oVq5O
	 SKQ04YgizVG1UZ3F4dN2Ny1qlPqVpFqCW75U1PKEXHHgC7M3ADHawFKXMh2qJWJVW1IVU
	 1HrNTb7pl1sz26woeFO41GxGOrXAR3UnUaU1aGaWHow1cwoJ9Krg4ldAq0XytWltVqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525478;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6zR+ooaoIngB6cZ+DZugxCDStda5ZDdfGP9G+OKs0Uc=;
	b=Cr5kJTLVlNc9BmiymR5og7gOynEFEWKvXfjr4NNMkOmucewLrInZlRHs/mR/w+U88LE2
	 UQrPpK7sIF/Po3agFKMAA7iO+9FJFQfgzzOw4flW127C3iF9N6d8Pk31wRSMzQ9UKmQj0
	 fq0C30OG+GMEiPbl3QpFmalB01PN3YC2cnWV4MOLdaGSgkWI1KBQ2Uk8MWPAQeOFD8Dwq
	 FA+5rliaLjwgBH48mmoGZEXegsAncs8MeFncq3TvdMf3RyHmgOrde2top1K3+DZ9zQGnC
	 ZBs2HrlqEq6G5UHYj5vcjyI0cgndLQySx0IXZDwGHhnOirWxMcuP8Iie86cFAGmAj9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9k908hU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D76A6606A330;
	Tue, 24 Nov 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9k908hU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4E8E51F01565;
	Tue, 24 Nov 2026 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795525478;
	bh=6zR+ooaoIngB6cZ+DZugxCDStda5ZDdfGP9G+OKs0Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f9k908hU0oHrcpvShIiOwnwIWLdC1lo0DwTz8iNcdsVB7aT8GVxZZGlTBdZ7VjwxY
	 16wOLjoxETmgGv3mTsaPcfn4jg5FZJCuauyma/YmgFyJN0c9swyDljlNVK7JmY6A53
	 kznDRwMYOGfw3Gl0MqUNeBv+tPA1K2rGRgILhbmscVK2d+uospnnWWixpVXVKOYw6r
	 vUEQxV4NXeOjh4J5w8nNphCj1AgOX5kMC/bgYwwCkZI7y7GCoGczElBJ0v2FubgaAu
	 RH6joE2jwSBTkzPTVs2WSxOrlmxWEoV81h6PFBSJCuZO7hNWYclyPt1GKMo4L9Wg33
	 lz4QeqCSwJbxQ==
Date: Tue, 24 Nov 2026 14:04:34 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
	Khouloud Touil <ktouil@baylibre.com>, Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmem: keep write protection disabled while writers are
 active
Message-ID: <p4nohmtiuicrys4i2ipwstdjt7sj3g2yyli4beygutkyn5ghky@d54oxjwiyzm4>
References: <20261117-submit-nvmem-wp-serialization-v1-v1-1-539d121f8f5e@gmail.com>
 <8c0a616b-e7a5-4043-bc86-3bee5d0c9e48@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0a616b-e7a5-4043-bc86-3bee5d0c9e48@kernel.org>

On Mon, Nov 23, 2026 at 10:56:54PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 11/17/26 10:09 PM, James Hilliard wrote:
> > The core deasserts the WP GPIO before calling the provider and asserts
> > it again on return. Two concurrent writes can both deassert WP before
> > the first one finishes. That writer then protects the device while the
> > other is still writing or waiting for the provider lock.
> > 
> > Count active writers per device under a mutex. Only the first writer
> > deasserts WP and only the last one restores it, including on provider
> > errors. Keep the mutex outside the provider callback so providers that
> > forward writes to another NVMEM device can still nest.
> > 
> > Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/sashiko-outbox-219526@kernel.org/
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  drivers/nvmem/core.c      | 35 +++++++++++++++++++++++++++++++++--
> >  drivers/nvmem/internals.h |  2 ++
> >  2 files changed, 35 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 7d4cce8e2742..c0da902d909b 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -70,6 +70,36 @@ static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
> >  	return ops->reg_read(nvmem->priv, offset, val, bytes);
> >  }
> >  
> > +static int nvmem_wp_write_begin(struct nvmem_device *nvmem)
> > +{
> > +	int ret;
> > +
> > +	if (!nvmem->wp_gpio)
> > +		return 0;
> > +
> > +	guard(mutex)(&nvmem->wp_lock);
> > +	if (!nvmem->wp_writers) {
> > +		ret = gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	nvmem->wp_writers++;
> > +
> > +	return 0;
> > +}
> > +
> > +static int nvmem_wp_write_end(struct nvmem_device *nvmem)
> > +{
> > +	if (!nvmem->wp_gpio)
> > +		return 0;
> > +
> > +	guard(mutex)(&nvmem->wp_lock);
> > +	if (--nvmem->wp_writers)
> > +		return 0;
> > +
> > +	return gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
> > +}
> 
> This refcouning belong to more generic framwork, I see few more drivers
> doing pretty much the same.
> @Bart has this been discussed before?
> 

Well, we have a use-counted gpio-shared-proxy, but this addresses real
hardware components sharing pins. This is a case of "logical sharing"
where you have a pin requested by the subsystem, which is then used by
multiple consumers. Normally, we do this at the subsystem level, like in
regulators - which BTW probably suffer from the same issue - but here
it's more visible and more likely to be hit.

We can either address it here or we can possibly introduce a use-count
helper for GPIO descriptors at the GPIOLIB level and re-use it in
regulator core. In that case, we'll still need serialization but I don't
like the idea of using a mutex and holding it over the entire operation.
How about a read-write semaphore, taking it for writing, checking if
we'll need to set value and keeping it for writing during
gpiod_set_value_cansleep() or - if not - calling downgrade_write() and
running the actual nvmem callback allowing for concurrent operations as
it is now?

Bart
