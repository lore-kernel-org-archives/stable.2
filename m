Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BE3CCFC2
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203106; cv=none; b=SZHI2BPmxqx7f1WFCUqJClJjd6elDKWxMFLyWZO2W/B5PDuWbpKrM8So5se1Wc7GeoyhQciFG0488oTlHiVLrCgs9EjuqfNvnu4USWazomBfxKLnMXJm7rwq93G8AAyZD6pM5axLLAJVYK6pTrOUZT8u7awouFE8+H6qIpZNirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203106; c=relaxed/simple;
	bh=ALu77l9JWVXGe1A3hUFppTa6Pdqm7Gq1p7JR3rm89DU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogaz4MT4k50mOOF2jzMX8oR8yISvUGFJam5YL+ccwWHKokDu+/iXuj+E3ZgWzhFAEUQxJ9rn0CO48RyNYZ3lp6JQD+t3Jz92xfGG55v7jWvfzueVwtpleT6cHjSX1SWp0TFY+SizHxwL9HTlaPpF92SCg3Rx/yG084NvTKklv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrlgJ/mF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrlgJ/mF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49230a567a9so25856675e9.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782203103; x=1782807903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqWt0bI44jas3c/HR//JGgX6WMjaPFSRIYH+iY3eOF4=;
        b=CrlgJ/mFJMMhclIQfH5UZLv8UMNvdShR3QoAmhwaNitLBJcLRiBlrsUfeZl4+ETK0o
         4hDXPyzbKjpou5rwFUiVCZFpwoJMs5PjTWP0bsAvxy8+eTHkGmAm0AsHRoLfrpD8Nhe1
         Z/D9N6kTHy/R8yvrioyvVEK5thF71O0azIGQv4KyXXF76QYy+QSbqjyMQ4gJpyv+GhGQ
         JhRcUwa1k6vQ0vaycjKHi2N4Q3srUolQD0EmNuOM2LgsPfTfGCU55N4qVbKorv/LrHDX
         W5++kk/lBUw+4g5zhLrkoHyfSHcm/pw9j98V6S0wXeBIoiAjgO1xlFHUzgMMMNdmAGqi
         J3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782203103; x=1782807903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqWt0bI44jas3c/HR//JGgX6WMjaPFSRIYH+iY3eOF4=;
        b=aX8Xdw2L1/Jkfi7WfFjuGUzxLOOgQ1GvhuO1klXKWQkL99EQLeMOmIi1aHZMOutGhX
         fS3t+HeH5PjCTiSBUHzd2PXhbxGOyV+xeg6FfZSI2qv2/yPecTRniPnP3I2nuznM3Yxz
         WGFHsLj9mc4ND0HHmEOTo1lB6jwdM4lKZd6P+z9/nYQWbbLFM7Ng3F+7KwosL9E+SWYE
         IOnixfcugvLdd+mdmeWn6B0vhq+sX6ypRDl6tvC0utrSGOu0hhBvWurZLDrA8jqNbf0R
         fmr2coI+pjbUW+NvTvTvu2UNNAPbAwcWnEeTFs57dltZe6XyM34HukhcGPjHAq5CrVXI
         ydWg==
X-Forwarded-Encrypted: i=1; AFNElJ91uxf5ELn8IZ0wBSnrazMZVXLwcptAbGiKiVdBJhCmnnbcdaAym2q3F3Ee9UbvWiGB5ySH8Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9hXRXbR+XsRDjiPLhc8XhjqzQWPruDOG8dui1H9FORK0CwEb
	91+8Vvl65/K8la9tgucYMYgHp7FpJ051DPfcNGPGuDjSe2tuhQ6JCOLN
X-Gm-Gg: AfdE7cmKCkR8InqH2KM4CqDr5ykYkcHGekfn1GpNnTVRtUZ5z9upSXO8KW3twFdH3vS
	5kS0Rztlhl0BaiAcWLekNkqcv/je4Nc5VEZOidyMTuunXuaDz37ZD84nFB28N1/F2zJFKZBTELm
	iBNeKwwMwLAZr/KDR4p3ADRFsTjkb7wnH6cRGr2AepScE591feVA/4lQ65PSBjKhNGW50kIRZJe
	it9vyZ1axEJhaYM4HGa5oOdsh35wSlw7VBd5Gk95ammvpOwPRtlSBYFGFiNGSBAyadzsZxBKlDS
	P6wqg2EszBRu9OLN3bSz207tlITqA4AeYFyLrQmeOPZGZcD8rRwbmVVD47/eZD+vKmU9bsTqaqv
	lrCNGv6wxfg+rFcprgTevvqvc95CKr5lqwnAUqUVV7QmQgxQtJLOJjV624WrmtY/yBN/8O3nZH8
	fFCSwxsEusRVyD3ITQt0KbdqyK/oVpoumehjdt3q3EfZM1uD8WpQ==
X-Received: by 2002:a05:600c:348f:b0:492:4636:87ae with SMTP id 5b1f17b1804b1-492463687d1mr271367215e9.17.1782203103276;
        Tue, 23 Jun 2026 01:25:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923c862sm262149435e9.7.2026.06.23.01.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:25:02 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:25:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com,
 praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260623092501.17bef195@pumpkin>
In-Reply-To: <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
	<20260622091344.794e0d74@pumpkin>
	<CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jun 2026 17:26:10 -0400
David Hu <xuehaohu@google.com> wrote:

> On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> > =20
>=20
> Hi David,
>=20
> Thank you for your review. You raised many good points regarding
> optimizations here. I'll switch to using 2G as the max entry size
> (`SZ_2G` from `linux/sizes.h`), and remove divisions and
> multiplications. I'll also replace the `for()` loop with `while
> (length)`, and drop `min_t()` in favor of `min()` by casting `SZ_2G`
> to `size_t`.

You shouldn't need a cast at all.

	David L.

> I'll send out a v2 with these changes shortly.
>=20
> Thanks,
> David
