Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC652AD0C;
	Fri, 16 Oct 2026 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792111472; cv=none; b=KR6oikQ+DnDemRgblYC3etQCWnhudDRQ25ASHdDojBSIGCmGN68zZGp+GCbsnZU1sSoq5l4i4l5WP108QbKc+BY8I9HqICmxAuevQZ//6fsJwo7c2WPohZMgBKB0ZYJOGH63dkxS2etC9XC8fFAWFHjZMu8fUgg53uF6KLAD5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792111472; c=relaxed/simple;
	bh=FQfR2Uy2jzVs8lexuOm43ITZ5ND8JmZzbBemL/G1ZZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNI2+ztojGLixAGn4gnlLHXX0uaTYUmVvnn5OJPlJI6+2pkmQ2tY3I7exCAHPx8Z1UCmjuYD8okR5loFn08Qvq+xVnYEjuz3v1CQEVrYeEmmBz1+09wgzIysEVCoaI+Z0QzCP8OfmLMzg61rEVJl5fgIc2LqUm/wciJFb+SKUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTXVgH7S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTXVgH7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019761F000C4;
	Fri, 16 Oct 2026 00:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792111470;
	bh=47lXV+zwuFd7hifezyqbdqGpG/KkYF5mH9/T0BLT93E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cTXVgH7SVqIZpOL0pkUaevoRuZCdTs2OYPSvFmrMhh+rPOFbM5jS12nIaa498bFJ3
	 gCeMyt3lGEXgXkRMA8y6ZVBN/tSeFYQ6SUz1XRz+b765Kf7Y943A/Wi10DehOAPDce
	 OwGrPR3IF6OCyQx1WMD2qgoevxRYWi6wZQ0xHwSxS3KxrGfWIiE84OC06Nxq4t5z4D
	 hgftTyYE1YUHGRrQVA+z0Vd/gJOR12zd16w76S22Cx2PQSND6HI1AwdzPvcNLFXddn
	 OypWdtyWnThjhHPgex6ll62X5U/7hiv+K19lQtDTgy8cOmASPULdvhLZBksTPSVnz0
	 r6j6AztlhJQ5A==
Date: Fri, 16 Oct 2026 02:44:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: westeri@kernel.org, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Fix adapter reference leak in
 i2c_acpi_new_device_by_fwnode()
Message-ID: <atFs_gRIkFQ-eWfn@zenone.zhora.eu>
References: <20261012013421.3597430-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012013421.3597430-1-make_ruc2021@163.com>

Hi Ma,

On Mon, Oct 12, 2026 at 09:34:21AM +0800, Ma Ke wrote:
> i2c_acpi_new_device_by_fwnode() obtains an i2c_adapter through
> i2c_acpi_find_adapter_by_handle(). That helper uses bus_find_device()
> internally, so it returns the adapter with a reference held:
> 
>         adapter = i2c_verify_adapter(dev);
>         if (!adapter)
>                 put_device(dev);
> 
>         return adapter;
> 
> The reference is only put on the failure path inside that helper. The
> caller owns it otherwise. i2c_acpi_new_device_by_fwnode() never drops
> it, neither on the -EPROBE_DEFER path nor after
> i2c_new_client_device(), so every call leaks one reference on the
> adapter and the adapter can never be released.
> 
> i2c_new_client_device() does not consume that reference. It registers
> the new client with the adapter as its parent, and device_add() takes
> its own reference on the parent, which device_del() releases when the
> client goes away.  The reference obtained by the lookup is a separate
> one and has to be dropped here.

actually device_del() can even end up looping indefinitely
waiting for the reference to drop to 0.

> i2c_acpi_notify() in the same file already does exactly this. It takes
> the adapter from the same helper, registers the client through
> i2c_acpi_register_device(), which calls i2c_new_client_device(), and
> then puts the reference.
> 
> i2c_new_client_device() gives the client its own reference on the
> adapter, so ours can be dropped unconditionally.
> 
> Found by code review.
> 
> Fixes: 605f8fc22442 ("i2c: core: Add new i2c_acpi_new_device helper function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Pushed to i2c/i2c-2.

Thanks,
Andi
