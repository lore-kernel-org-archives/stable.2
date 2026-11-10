Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308815;
	b=tZxF3yMtRviD5eVx8UOacXdnERcVkeQd9ubJxzHYYeFP7FF8pQkqAj6jJbyWexV1bPCp
	 v8l1uopWxfsmJH2rkiC22VNE3SPUpBl1lBRnN4bUBu3pgO8Kpo7qJ51PsTeRwYvHc9fDZ
	 goaJMHY9sanIVYt5MGgmak2BYK+9tinsbz1qOEvwwyvGFvdpfITYHK/SK3G5dqMo6IE5z
	 gl8JziQ5lv4Ov37HJK7rnZk6Mct8TOmCQ0BP5vuDtLak2eM/BMQnRAX9thwdNMn3nUIC/
	 NMkZ+raJKEOzkRzWplo4UchZje3hX5ImIT1CuTsf3t6EH5i/M9XCB32PL3etgIzQfNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308815;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hdfqSP6O2bu/ZFVTKJWa+3T77fQJrSmp1zvbC/sdJsg=;
	b=06Cs9asP/56ykRlzm8/kIbqM1HNeRzDXk6iD/sDpc/c3z3uuYubKdC/CZNAnZoLl6Hah
	 LdpVjyaIuDcRNm2mzE9hgGsfugWo8SpHMLA3T/3RRRVq1cevOtU/s/pS3ItLm8Fj57GI2
	 CqoAYn0bp+HEHYorG01qhtOlTkQAw1tkeTl1eBOS7oJ58/nZUipg7rxI5SuaYye4ZgELs
	 87R0C0vs5NPGTBDqWtaCmc6sm7M/eSkqD5aewxOOOwKI9ZdmJshzM9TO6llgWo3kLV5Ct
	 OBEozGczW2AdnmXpVOE6sihRlpvow8pl70nR4mwPaZhBhC7AxSXaEapgt86YMq5gp+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaPBbqvl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25E606A31C;
	Tue, 10 Nov 2026 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaPBbqvl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794308814;
	b=qBJLc17Q7AOmTHytvjpSbQ13wIHAzClNZMgnl3gYLm6zfRgcPGOK7F+lU5OvD0Jxm6+r
	 fzH1CZcdA/17ArRTikgmX58JfXuZmXXhDBPBSgqWz/FvB1Zg+iC/4d4ue4Dp/z5gHBVGP
	 OouJvLJfKVKjfu8xReQJvCv8CdcVouZMUFM8jaEdjrkCZstpz+FFBvh/4ocoupfrlP4rY
	 42GBb4xIsNt4FT3Yi3cs8UbZ8YLEsi58yYJJetEmXFb2TS9Y4uCZtAXcImFanv8n/rxQa
	 2uOI2iEdLjhFU82hwmTiJNgtbDkmov61xMo37FiYpvnRCt4r6rWEP3uBj+SFNoE0+MQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794308814;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hdfqSP6O2bu/ZFVTKJWa+3T77fQJrSmp1zvbC/sdJsg=;
	b=Fu9lH5duE0dAjhVRHopV78/mJ4jrdI/l7GCvXhWqcgiVA3Z25D1d1xzqsBm2wOKGa9Ye
	 h4horm25fcrx965fPp0IWermd+LBPDrGKFee+VOkwOsiQJXMawdFQHdNyHEoclLq0LiPU
	 3aV8Z37R6Ehpt7/yRpVYh/O63D8t4DH+h2d8CnKM3fvfbo67vMlBAJbHzaHXlgVDEbV8F
	 Nlqf3vu7xYKrBwgnV5WQyRM9XOnvBNiqniX+IQhdsEcNRpnH+PWmP5VOUV1E9NRh0smRM
	 3NnYCwItepYj8k5UyJzZgeUbf4q8Rh3/VsAJMPHFkinyIrrdK1s+QALn+XLEcl9YHDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 045631F0089F;
	Tue, 10 Nov 2026 11:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794308814;
	bh=hdfqSP6O2bu/ZFVTKJWa+3T77fQJrSmp1zvbC/sdJsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RaPBbqvlwtiHrmdrreMYMiTezWh0LAMERjSnC3LHDkR0kOrzYWksC0GHw7x19pRID
	 obvFrOrDhPOi8mMH9DNZ3rZHkvHzSYsWCVnw0OKhz2XTLXbl312+ExqSerbzhfDfCu
	 R+Ijxc4Lna125A86FyOW0ATZM6gRsM4T6r5biY/5Zw8GvXA3JUvinwnXy0840ofCtH
	 V5CYgIzBODgHrguyJLEIzj7/yYPrB4f+P8pxW33DTpI68vqIhSyivEeC8hV8Gza8ov
	 tSxoWJeRuDFOqfY7phUC2n09w+xTwJTcReJJr/uGf5HXCMlnE1eaEEGcAzgcGhGlFS
	 2Lk7vUUe98EnA==
Date: Tue, 10 Nov 2026 12:05:28 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>,
 Kent Gibson <warthog618@gmail.com>, Adrian Ambrozewicz
 <aambrozewicz@nvidia.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/5] gpiolib: don't overwrite the entire flags field
 in gpiod_free_commit()
Message-ID: <20261110120522.000057f9@kernel.org>
In-Reply-To: <avLsrOqdXSFSH6WM@ashevche-desk.local>
References: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
	<20261109-gpio-desc-flags-atomic-v2-4-c4c54b476628@oss.qualcomm.com>
	<avJAv_3ACjvyc9VU@ashevche-desk.local>
	<gw26q2blrbmmxwzv7vfjxwc5bzqzfgt57zs7bvt2kdx7x6a6qk@6i5z3a3crqft>
	<avLsrOqdXSFSH6WM@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Tue, 10 Nov 2026 12:06:36 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Nov 10, 2026 at 09:54:11AM +0100, Bartosz Golaszewski wrote:
> > On Mon, Nov 09, 2026 at 11:53:03PM +0200, Andy Shevchenko wrote:  
> > > On Mon, Nov 09, 2026 at 11:27:08AM +0100, Bartosz Golaszewski wrote:  
> 
> ...
> 
> > > >  #include <linux/acpi.h>
> > > >  #include <linux/array_size.h>
> > > >  #include <linux/bitmap.h>
> > > > +#include <linux/bitops.h>
> > > >  #include <linux/cleanup.h>
> > > >  #include <linux/compat.h>
> > > >  #include <linux/debugfs.h>  
> > > 
> > > No need, bitmap API implies all bitops.  
> > 
> > I honestly have no idea what the policy is on "proxy" headers. In some
> > cases people advise against them, in others they say to include them.

The main proxy header one should beware when adding new drivers or tweaking
is kernel.h, better to just use the iwyu principle.

There are a few loose exceptions (i.e. not fully iwyu but good enough), e.g.

- bitops.h implies bits.h
- bitmap.h implies bitops.h
- acpi.h, i2c.h, spi.h etc. imply the corresponding linux/device_id/* header
- if you have an opaque pointer (like struct device * but don't use any
  functions from device.h) you can just skip the header entirely.

This can be also "automated" using iwyu-tool (which requires LLVM). I have
a mapping file tailored for IIO but surely you can swap the iio headers for
gpio ones.

https://lore.kernel.org/all/20260512073505.1310-1-joshua.crofts1@gmail.com/

> > Is this documented anywhere?  
> 
> No, but feel free to start such a documentation. In IIO we did a huge work
> to enforce IWYU principle, and there we have some tribe knowledge about
> the dependencies and guarantees. (Cc'ed some people.) In this case the
> bitops.h inclusion is guaranteed by bitmap.h. If it stops doing like this
> it will be a flag day.

Would be great if someone documented this in detail, at least people who read
the docs and LLMs would learn it :P

Javier Carrasco Cruz wrote a blog post on iwyu-tool where he links to my
mapping file:

https://hackerbikepacker.com/iwyu

-- 
Kind regards,
Joshua Crofts
