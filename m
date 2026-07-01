Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FE34DB52;
	Wed,  1 Jul 2026 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941473; cv=none; b=JjfT/gjqjG16DDb98e8Kcf262+2HEvv/YcrpSScoLdLsMhP50FiIpZvtOfLKiykzFeuEGiSmvQ07HEO42jviPsTwqZWCqxOybhKVxSsAoqpSUvKOVy6vlEqKHXWdkqoQaj208VKhvgGN0NoH6uMBj+iCsvBAEf7pAgnzFjLY7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941473; c=relaxed/simple;
	bh=BavMPbJC6SPhFucwGcjMaqoDqJIMp/+q1TALMp3G/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2C5aesVVfw1pb0Vka+S34l1z6I8CQzoTkWPwCSVQv4+2pjtxNmyiADCa6QGgMq5ry642ihYN6ZZB6LnWVuRh0Ah5uQTDjCOtncSsXFgck6OyriAcwKNbiuF+dYCWUw6oj9v4Ucjx7NFQdT39bz/XVjDo0CdWQsQtrttzUlR74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT/tvibM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT/tvibM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EA01F000E9;
	Wed,  1 Jul 2026 21:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782941471;
	bh=jofe61Y2KudCbIyKulWKELRw4tMt3nodxyxcXMP3OOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jT/tvibMgCayxBTWzluVaPlDE7+S3HATB+/e+Yw6wh3qenjL4YJbs+02Y9/d045Do
	 rVFNXXTTFyEUN7Udw+A8C/bICuXml7TBjbo9Z4P7AnRbr62KqXO38a2+Gwq1i2pL4v
	 NIGKWEryr0c9M9X9jo59JGQW9EwRfvc5sR36rt56bjcr1215ugBlNlOTOi8n0CdNEO
	 rbBtDLVcO5kugkaqvIQBVDN1ARNVddVloQEdg3Wrnw2f+v5aY3OJni6lAZ3hyg02Pv
	 e5GOL3n5Dn5k9ApT+Aj49sUgE6edrPZdEXBHsVAbuwvdpGmp4BUPk4CgHCZDFkKMZ0
	 3OHGLNltZkb7A==
Date: Wed, 1 Jul 2026 22:31:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, David Lechner <dlechner@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: Build mlx90635 with
 CONFIG_MLX90635
Message-ID: <20260701223106.5ac21c5d@jic23-huawei>
In-Reply-To: <CAKv63uupUcUGXwXJQL957YtUmP+OZ5makvGROvFuvS8BWF-sPQ@mail.gmail.com>
References: <20260624081309.77805-1-pengpeng@iscas.ac.cn>
	<20260625054259.76774-1-pengpeng@iscas.ac.cn>
	<ajzOA3MGaCqrgCDp@ashevche-desk.local>
	<CAKv63uupUcUGXwXJQL957YtUmP+OZ5makvGROvFuvS8BWF-sPQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 09:54:58 +0200
Crt Mori <cmo@melexis.com> wrote:

> Thanks for spotting this Pengpeng Hou; it's strange that nobody
> noticed until now. I would like to apologize to everyone for this
> mistake.
> 
> Acked-by: Crt Mori <cmo@melexis.com>
Applied to the fixes-togreg branch of iio.git

Thanks

Jonathan

> 
> On Thu, 25 Jun 2026 at 08:43, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Thu, Jun 25, 2026 at 01:42:59PM +0800, Pengpeng Hou wrote:  
> > > drivers/iio/temperature/Kconfig has a dedicated MLX90635 option, but
> > > the Makefile currently builds mlx90635.o under CONFIG_MLX90632.
> > >
> > > This means enabling CONFIG_MLX90635 alone does not carry its provider
> > > object into the build, while enabling CONFIG_MLX90632 unexpectedly also
> > > builds mlx90635.o.
> > >
> > > Gate mlx90635.o on the matching generated Kconfig symbol.  
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >  

