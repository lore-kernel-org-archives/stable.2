Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4751E458
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905123; cv=none; b=Sghu/2oHFoWOas5da6CTcQeQip3a3GlhzAdsmlh7ZZ4Wj47DReAbpxJ1YM9DdboZuTus9WOwIGLxPfEczURl1G9EDiEjskWX30n7mW0BFj4Y56xSBxYhbcugweJW4VwHrot3q/U3TMxFvdv3Ofrjl0qhptqITuwpRppLxvSmFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905123; c=relaxed/simple;
	bh=+pymZ98Dy2MYL98Qf2NPi43dCBGsagDiffDTJLsYvhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP5CkdkN/qjJrJlE3jXWYmQu0VXaACG8ARnHAEOOzR7yMUhXppG1FGdTGG+ItqRymBEkTPqYmKes9ynxT84ahb5kDO8bOsBzVBlD0quAhtN+aBi6m7Qmz2EiU/cHVeedNW8ItqBk39f+3TCotnT+x07hABLJeb8ijO7DLXvfGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEj7iA/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEj7iA/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8CC1F008A0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905122;
	bh=4F3772xvP/drA3c9vrxz+P+Q6IJXRSI5tR2v5Oellco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FEj7iA/fBr19AoqXmcQFV+js1kenW45cPOdtGRP05vI9kKDnEca6KB9w2gthfLGto
	 XBDGT4kE63/COqf0EetcfAxlittSWAveZxSWvywqqqIoysqlkSu9eRjF9yY392uKiz
	 CKlu/qmb3lsVjujBKyTSu8bchMy6SPRSzZqQGICUXFvx6pPOuhcjqhv/sK/ok8l4ig
	 adwsfz6M9BroE/fcXiBxJcwYCoyoYy1+POwRHWkxziA5nFGDaQpI3fxXsf74Tu60Df
	 pNv7LksoLfsY4kwtRy0wLM7FPGUhgWBdRtXYgbsAFloYD6I8AFwHzkaW0+qlty2C3q
	 uLJV82vhcXbSg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso3901756e87.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:25:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw3kO+DhAaPX0dZ74/whBl46UG4UCbqTR/hTL2IDjU1nmrJ+gdNU94bAzMiOQSCxiDcB8zRvaY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXqCBfzmgU2gfpiv4dt6krcJkn4ZkdfawDn/eC4Aebwpz757LZ
	mzB8J+L2rM9H99w0IauUlNOXn7hewxUs+5T4hjSqr0GMjO3Pb/gdya18GXvEQhAEfNeWhPvzPri
	OuXQ+B89e9D8kwMPA90NvvkK2Y7Qo130=
X-Received: by 2002:a05:6512:1189:b0:5bc:dd8e:df73 with SMTP id
 2adb3069b0e04-5bcde8ec6bdmr4773910e87.62.1791905120367; Tue, 13 Oct 2026
 08:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012104645.975190-1-keng-yu.lin@hpe.com> <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
 <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com> <20261013060957.1023448-1-keng-yu.lin@hpe.com>
In-Reply-To: <20261013060957.1023448-1-keng-yu.lin@hpe.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 17:23:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hndk_ck1hcgWXyGX=OHmbfbhKsrJQsNQF9DQrucRNMDw@mail.gmail.com>
X-Gm-Features: AclHuK8QCbrFD11rbLJ4O9CnWewM1tjYpOyXZ3Pkx20A_3xxWuvZnpLMT13boNk
Message-ID: <CAJZ5v0hndk_ck1hcgWXyGX=OHmbfbhKsrJQsNQF9DQrucRNMDw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during enumeration
To: Keng-Yu Lin <keng-yu.lin@hpe.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Matthew Ruffell <matthew.ruffell@canonical.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, andy.liang@hpe.com, 
	david.chang@hpe.com, s.collins@hpe.com, jenifer.golmitz@hpe.com, 
	pravallika.kamma@hpe.com, zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:10=E2=80=AFAM Keng-Yu Lin <keng-yu.lin@hpe.com> w=
rote:
>
> Hi Rafael, Mario,
>
> The initial read is not needed to fix the reported D3hot-to-D0
> failure. I added it to avoid extra BAR writes on devices already
> in D0.
>
> pci_power_up() does update current_state, but need_restore is
> calculated before that update. The check includes:
>
>         dev->current_state >=3D PCI_D3hot
>
> For an initially unknown device with PMCSR reporting D0 and
> No_Soft_Reset clear, this still requests a BAR restore. Reading
> the state first avoids that request, although the final
> current_state is D0 either way.

Fair enough, but if the device is in D0 already, it need not be
powered up, so if you make a point to update the power state upfront,
you may as well skip the power up if the outcome is D0.
