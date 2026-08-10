Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD843A4F47;
	Mon, 10 Aug 2026 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357973; cv=none; b=mGBWjSTwISs1Y5Ue2Jsxt1ZXD5heedAJXlWnjJDJ66mB1CxLoIAsaYR3mwo4hcVjbngw9GMCChu6PM+YGAkyk/VyHV9VrbSBhr6hgrWO839RkUPpEubGZFWmwGzzFKtuwym/+/TyTYwRKHDqcK13O1dpKtKAjO6TGdpnxl3pjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357973; c=relaxed/simple;
	bh=cC7gqPvLUlkLwbGKdwL24vXRm9gmd31IDrCvA4drtl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u90RQ1Op0o4PC/iFK/WYqS0bgK75+qosC80F/YUGXK1pUM3UfqHAZbwDIihHsJnTssl/Gxhs2dToFxVsLvAh4+QTMdcOcN0kgTGDfbmFXNWcA+tzPRjDJtlD64HdF6UcMP0ULiqmw8bvV2uawJ6siCrG9r2Mj8NHTvY2GnJUdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABA2w8pi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABA2w8pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2126D1F000E9;
	Mon, 10 Aug 2026 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357971;
	bh=cC7gqPvLUlkLwbGKdwL24vXRm9gmd31IDrCvA4drtl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ABA2w8pip6RKbD4CUQt2E1r0p6YZ5V2YFzSD010Mb/ThhGSVDmLCI/MasIcolqLRZ
	 T1vSAIiBF64Lj6iQxVosa3lg4lb2IgNM38N0gO17nHbDPCABaG2LR/nI01vpjbDxWO
	 FM3OjQVEbo84TQ8leWSywNiEu0Pge6lV7y1sAMJZ2ZMwCVBCbMrGpEaDtOu+tAD82Z
	 /lAtRBn09bVHnk2jZGvXmdjcBTiv2QqqyAYvt+FTxF9G+k6yxf56m43lEV537XMAJ6
	 OO9ga3afrkurhf2P7QBp5x/U8K9SNIkORgZd+2GHVME/e+0soZdzf7JpFJQr+vOfTb
	 vNKOWaiXS9Qxw==
Date: Mon, 10 Aug 2026 11:32:47 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
	stable@vger.kernel.org, Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [PATCH v3 3/3] backlight: aw99706: Honor the core blank state in
 update_status()
Message-ID: <anmoz-Of5W-pjz-6@aspen.lan>
References: <20260804030255.1934470-1-junjie.cao@intel.com>
 <20260804030255.1934470-4-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804030255.1934470-4-junjie.cao@intel.com>

On Tue, Aug 04, 2026 at 11:02:55AM +0800, Junjie Cao wrote:
> From: Junjie Cao <junjie.cao@linux.dev>
>
> update_status() passes props.brightness straight to the hardware and
> ignores the power/blank state tracked by the core. Writing 4 to the
> bl_power sysfs attribute or blanking the framebuffer therefore leaves
> the backlight lit.
>
> Use backlight_get_brightness(), which returns 0 while the device is
> blanked.
>
> Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
