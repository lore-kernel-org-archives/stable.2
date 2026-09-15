Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6CA439908
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492601; cv=none; b=bqoBa4pvJaC/6oYtzlmQbxQf+yqqUrI/hlIXZZ628tKzgE03XAtKUg6+sXTzS7aiSV0thx40tMNGgxWsiL8xCfub9XVhpPYhScpS7POxhecRwIO8WnL5ENPH2Dy6yVJ2wRMEOx4p0/z4Rj6YYyUeMAo5BMY11Q/GiYVUbwaqajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492601; c=relaxed/simple;
	bh=NnAg2IqiYPZJtutky7T34AojRmXsQp7qqdWDe84q+Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7V2+4cBykwP5CcoDSJSppzWFE80TgQCzZulBnaoLOcSU7dAVt6QzuYCUONnt1gCzyPskX9xdPNe0rCJXIS+s95e1OUfWG5sgAro0kTasoZcWee+SPBIEPX0O4ZbTQC5SQLSrsHkm0YSX3/CzbM/L7VK7aYuvqt4l56HRJN1vn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Epb7KtAN; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Epb7KtAN"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so26200a12.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789492599; x=1790097399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z07CFjx8H2xq9rRTGNurbKjB49jEqOcwktaCUE8S8Vs=;
        b=Epb7KtAN7muNepDJlDUtJ/y+yrCzxXGFf4+P+BOqMLhmYXIi4Cz5wdm1pM9VtVzTSS
         z3SlljsH++YrqOm2KlmmbrhiRp3GnRpjs6wgjOPIBVtd+tUYQNAeeiVioo2thCm2aR8z
         v986OfTj8tVh25sgoazk/WStGnH4RV/eL3BWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492599; x=1790097399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z07CFjx8H2xq9rRTGNurbKjB49jEqOcwktaCUE8S8Vs=;
        b=lk5aHfFbnzGMSjiuAnQe/1VzRwvw+6r7dkS6KPoflWAZwwpS8uBzt+mn9crs9J428Y
         Y/rQHnkrdK2Lrtt7Abn5TsDTZ8Kh0V2o+e16Qu5z5kECZU9d6MK2rtScUcYLSwyG1lXJ
         LXOrPAmQDo2UgOWfIffNyuAStNRUBLkpMJzDcOomhUezs0TGCm6PF0josnEpOuvRj8Vj
         uyYThIwPDi/nBPxfaBH1F/8OqkQnVKdCrMlusc5yE3HEPsC0F3qwokXeI+SLX5FaL7pt
         cPAd98AvERtCfeGfvj+beQslQ0nEZFz3dtm7H0HJcIgQGDlkx6UaK9qqIB10hHx26qty
         nnLw==
X-Forwarded-Encrypted: i=1; AKwUvBzDh5A149OHgue5ebPfHSB8da1GfqPzlokEPCkY7Dd+g/nc28/xswJd5OJrRLcQoNY+EM6NkOk=@vger.kernel.org
X-Gm-Message-State: AFuF++lAj3i4vKE7HrH3yQC/4erRyauFgvxTwVevBVLU0nwrLyYJDr2y
	GBSiH+UlTxPWnmg8R+8PszYd+mnUaWVzmla487XyeA+FKXfkEAPIHS7nI2KnSzuRkg==
X-Gm-Gg: AYBFou3C7VRXAlVxdlytJMJeEdefW0+vtfq+TVEj4IClWOAs6B0Jn5K8bLngYx1GFro
	+nsWFEtPp7iqU1lkXY5et1tcNPAE1cZ4IfPqybnBjGa1TLHL6qNZd3VIguC5L0AVkExu/OnZRkA
	t/xa7gcGRV474Bg4ler8tcrGhzWhqe6Jou+7kTd10Bg8UODzOAPIO2GvFHFWHBQnn6xJi0aSdwh
	Kmo/Bt753ZFwt+n4IjyTjvOQuOIIgZNxJKUGTErQap9JVchxemtVQg8HJ4kArtT1+3shELB5t+7
	jLeCqdyQVjA4gbrMVTzAXe8oOCxdTz0IobktuSzSH+RCToyILYtRTpSkJN4ihjIfdXuGaZbg8AZ
	1C753kzLgrS5LaN15BsafI/8HPxLNXf2gUkXbx+YAuc5YGvkSK9Lu0Tm8iNN/aFJyQfPl5dYqiI
	KS4TTLY46kb5CPeCFS/BXIYbRRvxhHbdwG2r1Fw1IGKv+4Yi5JyCaKcIlUfUrDDaJ/w5uuA1oA5
	q+RXBCKxYACNpF8hFmjT19A7JKNq51NsYSA2Q==
X-Received: by 2002:a17:90b:5784:b0:39d:f7dc:61e4 with SMTP id 98e67ed59e1d1-39df7dc6273mr11488160a91.9.1789492598902;
        Tue, 15 Sep 2026 10:16:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:60c4:eed3:a48a:b9f4])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-39dfdd0baaasm6317988a91.9.2026.09.15.10.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 10:16:37 -0700 (PDT)
Date: Tue, 15 Sep 2026 10:16:35 -0700
From: Brian Norris <briannorris@chromium.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Darshit Shah <darnshah@amazon.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Honor "pcie_ports=native" when enabling DPC
Message-ID: <aql9c-XzjPKee9bv@google.com>
References: <20260903230537.GA2273943@bhelgaas>
 <58ea18fe-6e7d-49ab-b6cf-992db4aae732@linux.alibaba.com>
 <44256f8c-5087-4550-a522-34a828c40c1c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44256f8c-5087-4550-a522-34a828c40c1c@linux.alibaba.com>

Hi Guixin,

(I've rearranged the quoting a bit, to follow bottom-posting properly)

On Mon, Sep 14, 2026 at 07:01:16PM +0800, Guixin Liu wrote:
> 
> 在 2026/9/4 10:34, Guixin Liu 写道:
> > 
> > 在 2026/9/4 07:05, Bjorn Helgaas 写道:
> > > So I think we should resurrect that series and update it as needed and
> > > solve the problem that way.  I dug out the links just for
> > > completeness, but we should probably just start with the most recent
> > > ones (v11 or v12):
> > > 
[...]
> > >    # v12
> > > https://lore.kernel.org/r/20201126011816.711106-1-helgaas@kernel.org/
> > Yeah, this series is better than mine, wait for your to recover them.
> 
> Hi Bjorn, still not see you resurrect this series.

In general, I believe the Linux community tends to move by people doing
the work and sending patches, not as much by asking someone else to do
something for you. Maintainers may provide advice, suggestions, tips,
reviews, etc., but that doesn't mean those suggestions translate to
work items the maintainer will do. So...

I'm not Bjorn, but I interpret the above "I think we should resurrect
that series" as, "if somebody wants this problem solved, they should try
reworking and resending that series again". i.e., you should do this, if
you want this problem solved.

That's just my interpretation. I hope it's helpful to you.

Regards,
Brian
