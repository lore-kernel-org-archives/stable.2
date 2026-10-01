Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC82472F91
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865673; cv=none; b=qgUY0ooKen2E+ghbtHorXgzQOnLSl6x3myqdC0O27XZPCVqwD222gwqhMYPPsnXbb3WPy6Rntr8urTnnv4N85JcIJ9r9+beZRyaiPcI+DNlrmcXeDPhiPk+z+AIxQa9Q/rMvC+PiPOgbgOzJHXzLNJK6Ibbv76v6dz8AJK7qoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865673; c=relaxed/simple;
	bh=zy6CCAracjWN8loJGw2qzYJ1aVf4c021H02q7z8NK1Q=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NogF8XveY6VCB2lnfFV2k68IoFkRfvNCf1Qzo1zcPK+IBBJhdHtdJsz3uxbomNapJMf84TH9KRF3yCJkyVdvcFnRsf1OzUn0iXdKHObkCqDjTUDSfP3fD+ZNILnJTLNz8HAtlLaZ/58uv+edwsP/XAwnXkWYQl7kaswr6wQ/luE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB30BBA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB30BBA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A957D1F00898
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865666;
	bh=zy6CCAracjWN8loJGw2qzYJ1aVf4c021H02q7z8NK1Q=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=hB30BBA2s2N6Ovnxee4U7EDLiIFvYutUVyH5YvGVftuyDKXEjmRPR9eI/Sc2q96s5
	 VJvg8LQ5H+IBARdocZ7EJGrt0Hnwuwj1ScHzhVL39k31j3M9ylFj1Oati232bC/Ao4
	 hJynvAXYZwFBa7JrBtgQvnO70nS9xFB4g8NBTsjP/POYZr6asvkvskYra6+FvyBl1k
	 +7OyiZ72bMbrt5FOGB1V7ECNnJ3jAp1AIgT4xRbDZRXRfxLWWviKZZEKNX2dDbN1LW
	 exm/4mobspo3nVDvJOBwTFsFlRnvIKNnpTXyiKLycFCnHiaWaFLD4Dd5Rg7idlVQJD
	 GKbGGmA8qwhtQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3e27d525so1660983e87.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 07:41:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy21e4+Q01zPKPhwgziq0BT0xw8KnuNtm3paOo1IijF/4pU6hPTSvM+RO52vTxkSqDT/qduzb0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtTGiAzHOgnaMpGvR4SXTtg8diGwslNzoHZz3IcCp+73SmLh8Z
	JtiBc0sY95u2aOfrFyJzGp5jyxg3pNUrBE4wFh1dsUEkQZuUyl9iT+0TS+qjXvZ+U7BWoCgveUf
	8HwF0caPEttIVVsaB6VT7hUWeOJZNM/S9vKaWq/+RAg==
X-Received: by 2002:ac2:5b5e:0:b0:5b7:de2d:191a with SMTP id
 2adb3069b0e04-5ba405ee64fmr1365647e87.23.1790865665403; Thu, 01 Oct 2026
 07:41:05 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 17:41:03 +0300
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 17:41:03 +0300
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260930-pci-pwrctrl-kfree-v1-1-f09bbffd8da3@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-pci-pwrctrl-kfree-v1-1-f09bbffd8da3@flipper.net>
Date: Thu, 1 Oct 2026 17:41:03 +0300
X-Gmail-Original-Message-ID: <CAMRc=MdXoMSvjYzsG8hO5MmcGWq8mz4pCB0whK=jHM0J9gdKLw@mail.gmail.com>
X-Gm-Features: AclHuK_MX1UIRJgcpQ8TKbaoXQoLl5jbkAQEv_2If_uRnnPzNzc-2WWFoXI33ds
Message-ID: <CAMRc=MdXoMSvjYzsG8hO5MmcGWq8mz4pCB0whK=jHM0J9gdKLw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: generic: Fix leaking array from of_regulator_bulk_get_all()
To: Alexey Charkov <alchark@flipper.net>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Sep 2026 18:07:45 +0200, Alexey Charkov <alchark@flipper.net> said:
> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> PCI pwrctrl never did, leading to a memory leak.
>
> Add an explicit kfree() for the consumers array.
>
> Cc: stable@vger.kernel.org
> Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
