Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4D3CF1F1
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204292; cv=none; b=F7vXCVIwQRACTtFHWOOb3At6rArpM/DEtk3qQmKVp9dktKBxFex5MO29wRlw+Vyheyx+KWY9JGIrDsJv5R6QVnclXaRqqPqQTMZVDqh8oN4feO5Ou2sOcYqEIBtisc8y46BvSfP9AwQceded3hRD+/0UbXWSPhNY1TfjK8ung2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204292; c=relaxed/simple;
	bh=/NW10gd3XiJjasTwnvkAvxDjB+x+y0bolKqdPwKnlUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEtNxGyZX8usSsjK8Lb2um2gOzJI0vykzYyhEeUu/7B6zVXtchnqzpmpQLovE6eguYotJOCWI6bAaakRKOKsuu/0Kqnsn0MvM0BgQz2f/0cLqNmXgDP5AVxQEYTIWeSKeyEIYcV2u+36nhvklfXEtkLvl3SG4jUcNban2fGHE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2kQIA6K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2kQIA6K"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso79968045e9.2
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782204289; x=1782809089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd5zggzn9YY/eKp5MGwYc/7RumCc5LCFsD9dus6MWn0=;
        b=J2kQIA6KcLlAW2F536zioZdayh7HoTZMaWMlqtiBJ8sxJqanZEBwaYqmGOgBfZrqDr
         fgAcz27+KyR1wA2NJ/DLNU+PmjGTgjtaP5GYoarkkWar4Qtyu0GAlVhBJbp3PJKUEybK
         KcfHsW7uBy0L1JKfXPsCP9CQKZpDUAW5kEKzKRC0SWWZ7rQCTvOMLS1HJbbR7cUV/jYF
         /MIWfobo86UW0MCISSZQkzFnkK7pkrinnqLifr4Z8C5ByCl8DAW1vpNJh+a6Pv42SkuS
         rdseE6KfR9dXpfFALm2RDWOhHYtfCc3JUgWdRs9amRMi5JP9Hi8/wZPcgyOqk3fxyitq
         tHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204289; x=1782809089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cd5zggzn9YY/eKp5MGwYc/7RumCc5LCFsD9dus6MWn0=;
        b=fpLrZmchcGbyjHsaet53IocwcHRYbSsXXYftQ9f3JSsCNPK5djYDuz369mgaw05W+I
         K3QKU7CWb2QW4MgG/XWlGfTVw4xCzNYf3R7IQ4A+EkBjNi4GvfSKmtSo4RcQcMptf+fX
         U7JspOo8kk45ixPeMTyMLnicYR7g+WsVy+BlmK3W+6oxODIzzAc6DSVofAII0bme+fUl
         GMBYUgpK5U90GGWj2d4JTUYnLRiiWUTiKzGgT1xs5jT9pzOd/1s5P9b+CjvBt/9b5KDR
         tMyVuWgDphKxLyMZ5K95Wr3RBQty+fY5PmefyOdX/gChfOzOQxL1anh1syCP7b1gnFtD
         5lYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/iMXmV1MD8ixsmWPZGmdJsPh7mouICHPLThR9GrETHwxlKxQazd06/SLWhHjl1SGkDzBE+1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdenP3W+4/+R+iMNqfsL5zlyFpnbaLH6KswT1Ah1AqYgzAGxiC
	8UvLrsV6OlbKKYGtgksMfByqeBS6uq7w+dm6R/42Bemc9hG+HG5fgCbh77zB9gBO
X-Gm-Gg: AfdE7cmJHwSbs+NAI7za4NQIFQkkoyHlnKHN/NBQoHucL4gFWS/Zy2so2XP2nghEiId
	1Ekij14DSFGb2AxFXAQ2Ab6OSpnuUgdoFImcTDWQ2JDQE3/gr3kVzIE3gtbmk6bjwVVKFtZYFtr
	05iMPU8eKDKNNpaZhjpfOhzw2BzykZ8hDEnVsaBfYIc2S5yRuYzXAH2q1lr3xWdV5moYphFLZeF
	lbh9pWAG+vYG+T30Rn/wMfQ73L8hfZow3D1MT+PsAwvbFlGdVuYXHrFEjq1IhybSJzlVL5+tg4A
	hB0ZtZmwzyeS+D6m03rAtP7JiFGzz5I3pcO+Nr0ejfByYtdIqKpLD+y+zD2ggFl3yHqnP8Z9/XJ
	K17Ev44aDWMBjb6J0kGO1knT0r9kS07OZFRwLQGPpu2EaK4mm9VWNwJrDgDMen88F0iqIkiglwi
	kkmzNnsAxk3RyqjNZ/1tWzbOG+T9wJfKRTI+eLRhNT2gB7oGdLcg==
X-Received: by 2002:a05:600d:640f:20b0:492:408b:d267 with SMTP id 5b1f17b1804b1-4925b394574mr18459465e9.13.1782204289054;
        Tue, 23 Jun 2026 01:44:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923392dsm530639635e9.2.2026.06.23.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:44:48 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:44:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com,
 praan@google.com, kpberry@google.com, chriscli@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260623094446.4a8fc2ed@pumpkin>
In-Reply-To: <20260623015459.1153884-1-xuehaohu@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
	<20260623015459.1153884-1-xuehaohu@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 01:54:59 +0000
David Hu <xuehaohu@google.com> wrote:

> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.

There is a separate issue of whether this code is even needed at all.
Where can transfers over 2G (never mind 4G) actually come from.

The read, write and similar system calls limit transfers to INT_MAX
(even on 64bit) and a lot of driver code will need fixing it longer
lengths are allowed though.
io_uring better enforce the same limits.
So the transfers can come directly from userspace.

Not only that but you also need a single physically contiguous buffer.
Good luck allocating that!

Now maybe there are some peer-to-peer places where the large buffer
is device memory, but they will be unusual and probably need
special treatment anyway.

	David
