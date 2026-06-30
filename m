Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9938551A
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823133; cv=none; b=OH6Ics+PWU1dllcYqjuvJ+/58OZjtyJyaKepPEoJ5dWuuvGAhdUuyixammXAFngY7c/Y1PaQaP9XBuwRM8aIm2jcJZxfSnT5jHgA/47A9bxNQHstUGIMxDpjGtEMHld9qSSBxF+D90jRVWwRurutN2gXpdF7bWh8DXBe1glEBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823133; c=relaxed/simple;
	bh=HWLewm9KCB7MjAKi5lfHa4PConKZEGpyeTggVQfUIHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1fcJPTsxM8r0edxr0nR0Y0CqPzjYlUJvLwKtIbZ8tuFPoDC9Q5u8Vk74h8Cn18nIAYqM0GU2msSd5+V3bKeGS6xdd1s0pG4ewkDyzsOWHTJt2swJf1kfB6iUbSa7+bw3bdA2uc3FuHxU9uGAPnLUaQVhxQPpfT6EVTfPgNrqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IYD93HRg; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IYD93HRg"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eaa7b5e31eso5094626d6.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782823131; x=1783427931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=usbOUHulcGkq5pslDcl5tYYUADM4pc66+J0xE33qcCE=;
        b=IYD93HRgotQXIEA9XystXFNDgi/pIH3weHjmmw83gN3lZw1zC4MJCVTWG5/NczrUgk
         Wr6De8NJiNkZTRti2jUEhQPU1Ffhlh38sEIRlyNquV8m3TzXtiGQdDl7ZoWI+zjdkXwL
         9KACz4Ni44wXLtMe7V3K88OeJX5dlBkAKKItgaSrfTNrTC4lKvS60D98y1+9GMxNWBgG
         8z5zGajmLf/gk/yRYM4plF/h8pzzwpaZi5M6LlyaY8cINnILgPEdQpbPojtqxBIdp8Bn
         OLr4IzexORNiSyXOE5rwxA/Kh6S2iv9LH5FkGZMBuXqZcawbqO7+RBH/DLFzoE0zqz4B
         +9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823131; x=1783427931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usbOUHulcGkq5pslDcl5tYYUADM4pc66+J0xE33qcCE=;
        b=QuN8Y9cIzPfLumT1BZAjWAT5NKUob7aenBBfv4jY1bwcXqnjghH+JbNaqnWQzRp6vX
         FLHYEfsmZhfuWp4Aa1r0wfI0Mx9p0VtyuUwDomDZfjQgVkgHyE+RRrnRirybuLw2BQsQ
         emBKNUWklLZz7L2RIrBuqvy8LuMEFtbklOsKPgAE5SSmKMpgDZpEjkbzZyH3ki3/rDOs
         b6Ur/dvWE5lVrxVVThgqu6jmOH/xsRpLGRM689LkMglbnuHGWpSV+xShX4EXP7dXqcwe
         e9GOUxWIwuRbWlLkhoOZEQM58zWaeGi8JW7Unpp4YJ/YlPpC8s4B8LxO0jBDjChfLX+u
         dMoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrv1UO4s8HHQCw63TZb2AHHZvkMVPVFV3FygZoXT+OIYN3MssuIjNs88R7fD99SeXbF/VXNwws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVrmA4+RUW4Ju5iGThe7l5cdK+Xq5e2XBsaZoxJfZB6rd0ftTa
	lYBqapkbpdru4mBnSIAl/OqTFgKAqdjJs161CfXCQqd8jqBDKAXbOLwsbH3y3hRtp5I=
X-Gm-Gg: AfdE7cnmtZR5ONdAdzygYYo5TJX8aMyBjLesi/WbSL9gjFaRRaHAG/2r6VR6n8HUgmp
	JmN7ytQdHrZI1iQ9uhjUMRzSKxAJXoncXpxSuPKoyWCoqi5uISHyU/4CwrR2iEof1I3SjbuUq7u
	cdJjcaT2Cg+nFbb83VnnhLWJ5MmdfhQkvge33dHMHzPLKDjleUykhhnzOWP+Up6yf0NpZ3XSPiZ
	ETFbxvvyOqTdghzAu3mBzliQT9HXuUa4bVRwz1fVMONWwZytEsH1ylrX6HDnsjetGIfqfKYe3Aq
	zt1tgzMnHoRHirkpcyG5StjJ3ulvEQ9K7MKNAJ6H40yqws9Qjv+dNXwTPBpR0A4+Epr0OIWFb5r
	z/KiYkrm9IBOw0LCy64SGadExAnXfVf2bItUslF4N9NddgkXCGE9JvZUgrVV+DXrSBqYs8EsBk0
	Lg8jQTgyPRzWxqKYMeDCSN3pjQ8OVuTAMCDZh5QtIDwXwWWSFOO1vwn9DrCHF+B0OkWYo=
X-Received: by 2002:a05:6214:448e:b0:8db:480e:6944 with SMTP id 6a1803df08f44-8f2549e5762mr17241226d6.26.1782823130931;
        Tue, 30 Jun 2026 05:38:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a7558676sm22067246d6.40.2026.06.30.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:38:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weXjl-00000001qLK-2mow;
	Tue, 30 Jun 2026 09:38:49 -0300
Date: Tue, 30 Jun 2026 09:38:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Hu <xuehaohu@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	jmoroni@google.com, praan@google.com, kpberry@google.com,
	chriscli@google.com, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260630123849.GC7525@ziepe.ca>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623094446.4a8fc2ed@pumpkin>

On Tue, Jun 23, 2026 at 09:44:46AM +0100, David Laight wrote:
> On Tue, 23 Jun 2026 01:54:59 +0000
> David Hu <xuehaohu@google.com> wrote:
> 
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
> 
> There is a separate issue of whether this code is even needed at all.
> Where can transfers over 2G (never mind 4G) actually come from.

This is DMABUF land, you really can alocate DMABUFS of huge amounts of
physical memory, VFIO does this reliably and trivially for example. It
wouldn't come from the physical allocator.

So yes, these scenarios need to work in this code.

Jason
