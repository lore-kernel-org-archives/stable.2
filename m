Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907A3F65E7;
	Wed, 19 Aug 2026 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149196; cv=none; b=pkdO1GUYTtfzM/jlXuDocv54Yiye7hgdhLp5waA9aRIW/BVTG98hf3s/KCM6h3RwYWKhpWCpeiFG0TKDAMgff7WjwENQ6jfC208DB1W35pj1ODTmETvvMtKJ5gZvYtFU2iEEwzq4U2vGxfaMn7ucu8MgZB5cTI4EbZZ+e3p11bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149196; c=relaxed/simple;
	bh=eIf3uf9b94n0cauaXxTxg8+Xq05zT7f01ZIILCfdkVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGSzJR/WP3dm3UCoBsFvSnrueomuWMJkD1C8vhWsZcg9mNkliH8bqD4pRo3N8gFIYeQ9OdlnsxrglLkYQCml087cWQRY8dHjJiIxqmIdh/wM446RbDzLImEjSgErbgKt7p3K6lhlCQ+AVQHqTi4OJbindB+/BAd3yyjVm0hKxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU+WwN/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU+WwN/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F801F000E9;
	Wed, 19 Aug 2026 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787149195;
	bh=eVGSUqUhGi8YP9xabsA38iZbVV4kFc0PiRnwuIwPrGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aU+WwN/x9i28+AD9AAWogvHC54qAKTpGuP9nTt//p4zFRnqaWRa1X2r3ZfKSLw+UI
	 Eg+Se7kneVbLol06VNilJB0/eV5KPW88Wi7TYYUeBVcQuQocwmtPvlfaQE2vQT150G
	 SS+w7kgT3njH2wphOxR6cJpM5EQQatCWBLmJ492C04kcS/VrABKpSYCnJiYt72ul62
	 yA/hpWxalIBtdfC+TI+mTtCkqwLXPbaSHCEFElIxyWOPHX10398tGvRkfNUjXrgwhA
	 NJaXap8/hd86KV51isr79ZwauyQ8xClY+9KRj7c0Su5PnhArruCbNQQSFLQ9FRG9mN
	 HVsyAvA/9R71Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwh8z-00000001DdM-0Cfm;
	Wed, 19 Aug 2026 16:19:53 +0200
Date: Wed, 19 Aug 2026 16:19:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mmc: vub300: fix Use-After-Free of inactivity_timer on
 disconnect and probe failure
Message-ID: <aoW7iR8Rp4hUCtHq@hovoldconsulting.com>
References: <20260818210322.53266-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818210322.53266-1-meatuni001@gmail.com>

On Wed, Aug 19, 2026 at 02:03:22AM +0500, Muhammad Bilal wrote:
> The vub300 driver arms inactivity_timer during probe and acquires a kref
> reference for the running timer. However, vub300_disconnect() sets
> vub300->interface = NULL and drops the driver's kref without shutting down
> the timer via timer_shutdown_sync().
> 
> If the timer expires after the host is removed and vub300 is freed,
> or if concurrent work items re-arm the timer,
> vub300_inactivity_timer_expired() accesses the already freed vub300
> structure, causing a Use-After-Free.

No, this cannot happen as the timer holds another reference.

> Fix this by explicitly shutting down inactivity_timer via
> timer_shutdown_sync() and releasing the timer's kref reference in
> vub300_disconnect() and probe error cleanup paths.
> 
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

How was this "issue" found? Are you using an LLM?

> ---
>  drivers/mmc/host/vub300.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 8e45dc1a4a12..9f84bd1531e2 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2350,6 +2350,8 @@ static int vub300_probe(struct usb_interface *interface,
>  
>  err_stop_io:
>  	vub300->interface = NULL;
> +	timer_shutdown_sync(&vub300->inactivity_timer);
> +	kref_put(&vub300->kref, vub300_delete);
>  	kref_put(&vub300->kref, vub300_delete);

And this results in a reference underflow.

Johan
