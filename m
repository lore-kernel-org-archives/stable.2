Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795301690;
	b=blB/pUsy7pv1OT5QyNHdQdKl5k70K0rruobBntxL+Z2FR1vIf+pv+jnpZrs3OhuM7QZd
	 KrREsxMfjvIWj6TqyuaPOucZgkpHI+XYZ5D6oeyT8UsQXo77TAE0zSwgkuWJLiWGbk2Yu
	 6rqHVMNqCi5Xu/zjjWnfoQfnWovzRW5mCvplTAAQBXiTQBNh2hn13qgrljTld4z51fiRU
	 dH8ymK3xcGJjS0aXDbDg2InHELxe3VgujdeNnsGgDMeX5EVXZQnKZZdhEyUa+0uA1Qr8l
	 ktzNaFVRMsEWKRFT9ws+b8veNwoBC+0jirI/2fW7LYlZ7u3lZCCi+VMcCWnW4iz+2eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vwJGYwdMksY473f+wzhC1CDp6YsMw3dZ37Y093id8qA=;
	b=L6ETb2S0A4jxRgZnEa050b8g9f6T3EURC2VPLiicf/W3bugv3/LWzct01lP2kDJ1jw1X
	 YC+hSENzWvCkR5RHBPMJdklxJYJ/+9sCaM9DdDPp5HmEcXupocAvgFTH7659rtSickN6Q
	 blqc0/6Ucq1Q2mCYb7cltjlkzWh4RwznVd7kHRwqH5IAViQyfO6mDQDIM05BQPUBObki5
	 ijpr/46pr0VeRAM1b6lGiDkmCs6yFUapEBkxEwOJkHQVLVFS4J/IX4U+GgwEAF5EwKl0B
	 pVkPCAZRXSNHzWWLqCMHDsD1dvQLWI4M2cBzo0OnkfktOX4MjCMIyZ+Nih5ha2Idpdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJIqocAy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665A606A320;
	Sat, 21 Nov 2026 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJIqocAy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95D21F000C6;
	Sat, 21 Nov 2026 22:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301690;
	bh=vwJGYwdMksY473f+wzhC1CDp6YsMw3dZ37Y093id8qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bJIqocAyWDTl1fpSjbwT0OWlomRmKmeM0506zf3VfkRDdEJdE2CdzujXgfa1KH1zy
	 apwhD39o7t5RFlDoGqgs6NQIFIiyy1Q502eATzNMzw3UKXRFr1fCKHZHj4BmET5bYx
	 zVFqwzkRLmpBYZT/WIDwpza1bipg6W0tH+/iQH8RdEO6E6dx8+7PBcjZnWS7qMk3Hv
	 feo8ZvH0UPwcMR9W7iyBIgSMsd+fxvkm0ICEM6L4s5zp9q23oOHnF/IpQDwWc1FTNV
	 UH3fJ9dDdEsUrjsZc8cB13bnOIUVnQk0jBdofCieQJLrUls/aQ8CNyFz0xPRHL2l3N
	 0tnLSMh1b1joQ==
Date: Sat, 21 Nov 2026 22:54:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Marius Cristea
 <marius.cristea@microchip.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Bogdan Bolocan <bogdan.bolocan@microchip.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 06/10] iio: adc: pac1934: Fix custom attribute
 allocation and channel bounds
Message-ID: <20261121225445.47f60e23@jic23-hlaptop>
In-Reply-To: <av8xnBRNUzEo4YdZ@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
	<20261119153151.1397003-7-lee@kernel.org>
	<av8xnBRNUzEo4YdZ@ashevche-desk.local>
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

On Thu, 19 Nov 2026 19:27:56 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Nov 19, 2026 at 03:30:39PM +0000, Lee Jones wrote:
> > pac1934_prep_custom_attributes() sizes the pac1934_custom_attr pointer
> > array using sizeof(*pac1934_group) instead of
> > sizeof(*pac1934_custom_attr) and adds 1 byte rather than one pointer
> > element for the terminating NULL entry.  When active_channels_count is
> > zero, only a single byte is allocated and iio_device_register_sysfs()
> > reads past the allocation when scanning the attribute list.
> > 
> > In addition, active_channels_count is counted over info->phys_channels,
> > whereas the population steps unconditionally inspect all four entries of
> > info->active_channels[], which can write past the end of the array on
> > 1-, 2-, and 3-channel chip variants.
> > 
> > Allocate active_channels_count + 1 attribute pointers with
> > devm_kzalloc_objs() and bound the population loop by
> > info->phys_channels.  
> 
> ...
> 
> > -	int i, active_channels_count = 0;
> > +	int i, j, active_channels_count = 0;  
> 
> While at it, can we move to make it more like a reversed xmas tree order?
> But see below first.
> 
> ...
> 
> > +	j = 0;
> > +	for (i = 0; i < info->phys_channels; i++)
> > +		if (info->active_channels[i])
> > +			pac1934_custom_attr[j++] = pac1934_shunt_attrs[i];  
> 
> But i is not used outside of the loop, can we rather have
> 
> 	i = 0;
> 	for (int j = 0; j < info->phys_channels; j++)
> 		if (info->active_channels[j])
> 			pac1934_custom_attr[i++] = pac1934_shunt_attrs[j];
> 
> ? In such a case the above hunk won't be needed.
> 
This change seems reasonable but significant enough I'm not going to just
tweak it whilst applying.

So v2 on this one please.

Thanks,

J

