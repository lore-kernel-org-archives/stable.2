Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D73450391D;
	Tue, 13 Oct 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913393; cv=none; b=iSrjjb0DTXsVFD4GwWKVLrmkaybabBkFOWoGL3YCqGgHy5JxNahxt7D9lZWXZYay2khA4zv4xDJAphxC38+Pe/Aw0QKVR+Rv5RfrTWQBcW8Mi3seTIBcCO1W+Z0usXFrxl6et1dXglLd0djT5VWQKFwVvaIuhQZdLiX4hhHf4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913393; c=relaxed/simple;
	bh=XhvOeBweAajn+nJxQPZ2n8mQcmuHxvvpFb9p4pI8FUI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Uwm7J4E9pDYgXm7r4bShVYgi6NZVVrBdVFTJSgyOlsZtV6jGRVECni/xOf/AXqKKLOvg69UBbb2A4KAgL1j3F9BpHJVfeUMRqGwTiJwbxPTmwGem2/T6tdc6aAyul4dW/KFcCBW53X9PZFkWWA64qIey10UXnqhcGGC0zOY15j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YADWSCZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YADWSCZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB631F000FF;
	Tue, 13 Oct 2026 17:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791913391;
	bh=S66NLj+K+sBEkMppYnR/cBn73roEhByUF4f2CziJQcw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=YADWSCZRso0VJa9kqCVmm5xxSJpVG0ysIKUeQhNyELcVNd/ZYGiZArtykP40ZkPQS
	 gUQ1jw+Ks2NyvSO5AKif+SHUu1edCs89J9EI8Bqp1fnAKSnxspg3RawVPbqINNy4/p
	 IFfGX36M1nNgKPRDMbuKcdEkyuyr4idp8OukoM23fjNAT+6wKaYRWmKbgGwBylAbq/
	 lWymGQUGdVJD1x00bnb9vgUTk/RaYAn0RuMC/1eZ2xV88K/6MW/MUtYCdAShOrB0Lp
	 LQuMEDvBnlPV0L+HhO9cVz0XeB0ph9777wwJVQYkl0fIZV2ZujIxQTXh2huQNhWZI8
	 JOj06qEy3568w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 19:43:08 +0200
Message-Id: <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
Subject: Re: [PATCH] driver core: take parent lock on deferred probe
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Alan
 Stern" <stern@rowland.harvard.edu>, <driver-core@lists.linux.dev>,
 <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mario Peter"
 <mario.peter@leica-geosystems.com>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261013140615.1226992-1-johan@kernel.org>
In-Reply-To: <20261013140615.1226992-1-johan@kernel.org>

On Tue Oct 13, 2026 at 4:06 PM CEST, Johan Hovold wrote:
> +void bus_probe_device_deferred(struct device *dev)
> +{
> +	if (dev->parent && dev->bus->need_parent_lock)
> +		device_lock(dev->parent);

This looks like it has the same potential UAF as the other patch.  It's qui=
te
unfortunate we need the whole need_parent_lock thing just for USB.  IIUC th=
e
main reason USB needs this is because interface devices share resources of =
USB
devices and we need to keep the locking order to avoid inversions, right?  =
Is
there more to this from the USB side of things?

I think we can probably do something like this

	struct device *parent =3D NULL;

	scoped_guard(device, dev) {
		if (dev->p->dead)
			return;
=09
		if (dev->bus->need_parent_lock)
			parent =3D get_device(dev->parent);
	}

to avoid the problem, but it's still a bit ugly.

> +	__bus_probe_device(dev);
> +	if (dev->parent && dev->bus->need_parent_lock)
> +		device_unlock(dev->parent);
> +}
