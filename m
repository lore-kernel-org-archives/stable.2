Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA82338595;
	Wed, 12 Aug 2026 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494331; cv=none; b=uSHoYlVCrkprYBpocJGr94E96k2PaKeGqZlWm5FbcvkcvmeQ+XQ7rD3CEqXsaKl0lhpmvGzA9oCzGSAWMig82p+ENVcvS+2ARmvMdKHML8LVkfXjCuYnUWYKDk5diQCkvx6EMYWD/swJtVvk1x8cK5jUqr2JuMAcScrpJe3Fk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494331; c=relaxed/simple;
	bh=jI7t08jzUlKAg2x6wRoPgije0pQyu4v8NmbxsVi1reg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoZ48l2AWMnd1/pGIAoirUUGldBacZrnlkRQ6VsSKXeFk+vlwjPswoyKbuSgqcnctJl04GAETZjpCEu6d+ISXfY/qnDpeKWTBlS19VXSCuAE3oCqJmNYRIzRhUDmELwwJKkxtXKwWxAIhrdB3vhkPK1ra8QCYfkgRzY2DHxwxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UAhnqVZ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UAhnqVZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2501D1F00A3A;
	Wed, 12 Aug 2026 00:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786494330;
	bh=p4m/slOnKiXgIqSQr29NHTyzS2ZdgE5vaZWhE5yhu1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UAhnqVZ81aDYG6pYXa2KfUOgjI5NdQFF2zWKZ6UyNG3z2Olhw16BXFMI5R1HrBB1R
	 Z2naQpOpDu2x+ZMOFcGJtHYAri4wy1uocdEYMh6FTnbOIGEM71y0CXxhR29RbIKAu3
	 2JXvbsVkzykAz4EElNQuxMMru/hpUkkeEEyW1yiM=
Date: Wed, 12 Aug 2026 09:23:57 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Martyn Welch <martyn@welchs.me.uk>,
	Hao-Qun Huang <alvinhuang0603@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: fix flush_image leak in tsi148 bridge
Message-ID: <2026081240-shanty-prepay-648e@gregkh>
References: <20260727111534.729615-1-congnt264@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727111534.729615-1-congnt264@gmail.com>

On Mon, Jul 27, 2026 at 06:15:34PM +0700, Cong Nguyen wrote:
> When error checking is enabled (err_chk=1), tsi148_probe() allocates an
> extra master window resource, tsi148_device->flush_image, which is used
> to flush posted writes by reading back over the VME bus. Unlike the
> regular master windows, this resource is not linked into
> tsi148_bridge->master_resources.
> 
> Because it is not on any resource list, it is freed neither by the probe
> error path (which only walks the master_resources list) nor by
> tsi148_remove(), so it is leaked whenever err_chk is set and either
> probe fails after the allocation or the device is unbound / the module
> is unloaded.
> 
> Free flush_image in both the probe error path and tsi148_remove(). This
> is safe when err_chk is disabled: tsi148_device is allocated with
> kzalloc() so flush_image is NULL and kfree(NULL) is a no-op.
> 
> Fixes: d22b8ed9a3b0 ("Staging: vme: add Tundra TSI148 VME-PCI Bridge driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> ---
>  drivers/staging/vme_user/vme_tsi148.c | 3 +++
>  1 file changed, 3 insertions(+)

How was this found and tested?

Did you forget an Assisted-by: tag?

thanks,

greg k-h
