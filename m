Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16C41DE08;
	Tue, 18 Aug 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042460; cv=none; b=Aw+QmhyuPosIBwkRd8Gncv3JwHRp/Dqg98L8N7Gqut+1Ug0HlElJvNPFmR02u4bGfICOjghS5EgMB4CdEQrkrxMNIC9+goUqI8YyWviT9e+TsvU8z5L34hgNRfzAmGoYHV+o6lcPCPnuziNMvDRalNal+4LxhPXAuhvA3OpEauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042460; c=relaxed/simple;
	bh=8uj5zgupizL4ViEoE2Ejz86KYsMS3qX+uIsMaIPBbBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmzt9IWWBHSvnu6+NnBJozNPrICSphBwXg9qunMJ0LYqh17szF7dqve7FoPOIeiojBznsIDt8TmTTXjLGXb9RjJQOHix/ayDmc7UIuvrgPv8e+WsjzivLrhpRW4KYFfSGF5rvUtOe7upRxKeITiKmW0HU2V9Ak/rLJk3E8GaNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ4prGfC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ4prGfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644A81F000E9;
	Tue, 18 Aug 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787042459;
	bh=gokdKGEzJdLWCpRuqFyGo9RRYtbTA/1wiQub52LC7O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QZ4prGfCuhCixwN4DTdIH3V5xuXKZHlZJw0B+QvI+3s/slUGTQbE2cl5UTeAWCVdW
	 kO2MujsAg0jhpwyEcKpB1txxX44cRmtmjHt+nqsDrZE1VpctbpTEDDEvK1sFkwOdhu
	 +dgV25mF6ocskGciKNylhTY23YjrRm9tUdlR82b6jHjCLc0ouRtZN30KLfPdjLwiEo
	 HyVH7auAjhy7VnupM9ROvZo4aDntSHHxabxH4DfVXe+AiyQpnp0vAkQ28Q3oyvMZrZ
	 5BNUl2salxTyazH1FncXH9WHKP8n8qZx2opovaPiPziI9NjP62hKFmSW3KJoQrHp2y
	 Cmywf1NkBgCoQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwFNR-00000000ncE-1NOg;
	Tue, 18 Aug 2026 10:40:57 +0200
Date: Tue, 18 Aug 2026 10:40:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Elie Morisse <syniurge@gmail.com>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: amd-mp2: fix autosuspend cleanup during teardown
Message-ID: <aoQamVRfUnELwvZk@hovoldconsulting.com>
References: <20260808152220.2938557-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808152220.2938557-1-lgs201920130244@gmail.com>

On Sat, Aug 08, 2026 at 11:22:20PM +0800, Guangshuo Li wrote:
> amd_mp2_pci_probe() calls pm_runtime_use_autosuspend(), but
> amd_mp2_pci_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.

As I've explained elsewhere, this is just misleading. There is no usage
count leak here as the count is balanced whenever the user re-enables
autosuspend through sysfs (by writing a non-negative timeout).

Drivers should clean up after themselves and disable autosuspend, but
this is more of a clean up than a fix and should not be backported.

You've sent upwards of 60 of these in the matter of a just a few days,
some of which have even been picked up. Please send follow-ups (replies
or v2s) as soon as possible to prevent further of these from getting
merged.

> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> remove path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 529766e0a011 ("i2c: Add drivers for the AMD PCIe MP2 I2C controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Johan
