Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DF2AEE1;
	Tue, 18 Aug 2026 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044932; cv=none; b=M/hLUHf2lDznTomZr/+yRBDEpb/p61GpAikJtAbbts9Hr+esmacDJKvSRR8fX0Q1gZQgti60O9RfdqHA9qQ60OepV8Zx4rBVK6Gcwav9RYB6CbJ2zTxQvYnjAJsGg5TuuzKJLhmeabsrOnilfESuLQashmwripvhnCQUk1wiCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044932; c=relaxed/simple;
	bh=FwfKntgeSoBYn2T5/vnj0/dhfzhdvUzkoN3ZEPf5C4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmL3s0OangK6LK5PRMtCPZ+ZB26dmsXoOduAtjBQCn0AofUCNVg/we1hi+PrzszyzsVvCmBeLPbvM0ztzxC9NE+hCAGSkEha67wNfXap7YkZEBSknOUo3zBBoA0zykf6wCf64cEYWlM7gZr/kznph0egj8+BJvzlLbZD/9rw8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBtyjcwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBtyjcwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D7C1F000E9;
	Tue, 18 Aug 2026 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787044930;
	bh=rlMpRkO0B1Y3vJHGlf5N8MK3VeLDRs8jsE+W9kL3NqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gBtyjcwcM/3VoTnHU2brZbF5myD5GWkpYcosT2Wpt3BF5WYVB2J35IDxT5Ff1AU4e
	 n4rLwIz3OWmajdWTIJUYmHTHSOMDaYA0wQygfVKbCr9z6yZKkzTxeU1m2hQqZiSNOG
	 yld+G4tyKxHkKfBikZChIADi4S8w6A7Eh35LIwy0y0V+yEs+CCQEcsG5gXsjdG5G0g
	 czPPjvMkPsmX1XHwXkAsuwDRU+X+z2V4dwK84wpJY9JP0UfNm+6xv1yNS2q6tIZ1PH
	 ngXa4GgXP2V22O96AsgUQwoVz8kortZ5d/n0D+bO4MDjaVHOZ4JAevxVP+hZ5iJqM/
	 L2OgL1GEmHFhA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwG1I-00000000ojn-13G1;
	Tue, 18 Aug 2026 11:22:08 +0200
Date: Tue, 18 Aug 2026 11:22:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bus: sunxi-rsb: fix usage_count leak when
 autosuspend_delay is negative
Message-ID: <aoQkQAxADxBQXNeH@hovoldconsulting.com>
References: <20260808062029.2597581-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808062029.2597581-1-lgs201920130244@gmail.com>

On Sat, Aug 08, 2026 at 02:20:29PM +0800, Guangshuo Li wrote:
> sunxi_rsb_probe() calls pm_runtime_use_autosuspend(), but
> sunxi_rsb_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during driver teardown, this reference is not dropped and usage_count
> remains unbalanced.

As I've explained elsewhere, this is just misleading. There is no usage
count leak here as the count is balanced whenever the user re-enables
autosuspend through sysfs (by writing a non-negative timeout).

Drivers should clean up after themselves and disable autosuspend, but
this is more of a clean up than a fix and should not be backported.

You've sent upwards of 60 of these in the matter of just a few days,
some of which have even been picked up. Please send follow-ups (replies
or v2s) as soon as possible to prevent further of these from getting
merged.

> Add the missing pm_runtime_dont_use_autosuspend() call before disabling
> runtime PM.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 4a0dbc12e618 ("bus: sunxi-rsb: Implement runtime power management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Johan
