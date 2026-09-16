Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBB481FDF;
	Wed, 16 Sep 2026 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550099; cv=none; b=YLNLFqARJt5cgbYHexPppsO59niD0oqb6hCHZ9A8ypm5XZXXUAAr+lMqNnDJwWoI5P/Yh/dZtNmqJYa8Ux9oN+JmkD46F3BUssjPWTJGcVjBK70UgHlnJwf24ll2XB6m5aCK1SsWboiSYHFTSmDrMmrYfFpJ0/tQq1tO65QxP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550099; c=relaxed/simple;
	bh=UopWjlwMF3bjhzOzb3h9pMV+6wfrWbRilvHvIHUhrb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex172HkNjBd+B3dG8DKOYaQYeN5GuSRERWOAnnXP0uvbydQ2flVe8a//a1Iuklo4dzTGYt9uaGdMSgFJlrYEGosRtOXXYraZI7Ad1Dh4QUL3Fd4wyrM8wqDU2+VBfzwu9KBtBlbxq/TY3sbjt3OWjTHXt+o2aWbKWyXW8WSLjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9RvePjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9RvePjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C551F000FF;
	Wed, 16 Sep 2026 09:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789550049;
	bh=BodzLEqlrUVJHz6lO02G+Wl1n2t5FZKPPceRuU58IM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K9RvePjC5ZjOKjhuM/i26A7E9mNoXeUe/EGzQlCF234FP8BU4uvcg3wNA0NfCs82x
	 RKKcUDcWpj8UGjzpAfatri8J3mKYJ5YeqfF8L8/nr61uACotSx+AnkcMzZGX61ShWX
	 r8HmV76Z8abJex/qCR9p9N9gsTczzZ56P7Tc1nqDKJqC7G1l3Gn04n1j8FusuE+rXP
	 hrhRBzYVMcagifgJHlBjTvnhRptB2K8qwcmYHamQCzwOadqhjeMzwIjYtHy0h9vZuq
	 gnEhh4QEEP9Vwoe+Y0QR9XxGrVylBs9uin7ZfMddwHgtH7Bpbn+D8S8LL55QHy9Mx8
	 E0alZKLR/q8MQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x6liQ-00000005xMX-2H9f;
	Wed, 16 Sep 2026 11:14:06 +0200
Date: Wed, 16 Sep 2026 11:14:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: core: add missing
 pm_runtime_dont_use_autosuspend() call
Message-ID: <aqpd3viN1UoZBkgL@hovoldconsulting.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
 <20260915090223.1346-2-joshua.crofts1@gmail.com>
 <aqpOlKtxeROh-G_s@hovoldconsulting.com>
 <20260916102132.00005129@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916102132.00005129@gmail.com>

On Wed, Sep 16, 2026 at 10:21:32AM +0200, Joshua Crofts wrote:
> On Wed, 16 Sep 2026 10:08:52 +0200
> Johan Hovold <johan@kernel.org> wrote:
> 
> > On Tue, Sep 15, 2026 at 09:02:18AM +0000, Joshua Crofts wrote:
> > > The fail label in usb_new_device() disables pm_runtime on failure, but
> > > doesn't call pm_runtime_dont_use_autosuspend(), causing resource leaks.  
> > 
> > No it does not, as the device itself is about to be freed. Sure we could
> > disable autosuspend again here, but it does not really matter.
> > 
> 
> Okay, commit message aside, you still need to call dont_use_autosuspend()
> on teardown as the driver doesn't use the devm_* counterparts.

No, you don't *need* to call it, but it is good practice to clean up
after yourself even for the theoretical corner case of someone forcibly
rebinding a different driver (which will soon also be tainting the
kernel).

But in this particular case (usb core) where all callers *free* the
device after the function returns it does not matter one bit.

> Currently
> (according to my cocci SmPL [1]) there are 195 instances of this in the kernel.
> 
> ...
> 
> > But this one should not have a Fixes tag and does not need to be
> > backported.
> 
> Yeah, you already mentioned this in IIO once [2]. I found several instances
> of patches like these being backported however, so perhaps times have changed.

If you write a misleading commit message and add a CC stable tag,
chances are that a maintainer will miss this when reviewing and then
the commit gets backported.

That in no way means that you should continue doing so on purpose,
that's bordering willful deception.

Johan

> [1] https://lore.kernel.org/cocci/20260915064327.1377-1-joshua.crofts1@gmail.com/
> [2] https://lore.kernel.org/linux-iio/aoQEyeHUiTwWenBL@hovoldconsulting.com/
