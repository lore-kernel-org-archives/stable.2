Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EBE3F8257;
	Fri, 14 Aug 2026 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714374; cv=none; b=FoQeydI/GF2qJsoUeicb5plz5yHM/pu13N0bqjkIOamqhTvlgffODWYEjHASWk1ApO5y0vs+ULLzCjN/fAfTESZFIydkLAY4Cxk5Fzzz/55TVsRpyjG4AEGfJJ95ZT8ouqK3uVJsOXJ7VN8V5NsRbIwaq569ZiiQC8KwA5O8SMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714374; c=relaxed/simple;
	bh=djElI9sO+iFcbqG0tckEqomJ3fvS5Hf5fazHwi3BFA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC0jAM6h03FNcP2NbLwN/agthiJXwkzskiYBMj8G1n12JqM8FckTABj7lu1fnHGp3UimjWneE6wtl4JZWbIeNJIx2e9wTrK9zDwHErF1LJ5N752Gd3AuPUpYmAPtHfVtg1jZfYFUYtBNTypix2/r60EsAWlLxoAdKIkxK5DSUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtOLpjnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtOLpjnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6691F000E9;
	Fri, 14 Aug 2026 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786714372;
	bh=m5imFIyl91SzmOG/eJYLbFffP4jPZHEnM0gsadR+09o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OtOLpjnkIry1pAKAo0UkhscBaxFNjGq8pUCLIgRaggmYWdS14ncYK9nShlzvNoMW+
	 atnlIOjLPFMvJ5d+wo8S8OfAyy8Ymw1RcmnUlyYwSG9u0EMnymigYiK5Ukful0DdLK
	 BNJAxFBJUlaL7kQWj8cbduo79Fomoq3q/Nxe45EN383IpHLAGICu7IpyWphaqhy0AX
	 YgGKxCI7Zfc1muLtfr8AH13IA8/PGtdptPce9694RnOfR9XMV6uFBEcMIsxtnZQ/Ef
	 aE8VROYhTS9DiKuHtcns8yJnjBI7f0X7+ZkO+Uwrc2hEtNaAPokGAZb6oQgFvxlfVf
	 9XIKGXnksZaVQ==
Date: Fri, 14 Aug 2026 15:32:49 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: Re: [PATCH] HID: multitouch: keep MT_IO_FLAGS_RUNNING inside the
 flags word
Message-ID: <an8YyovFve8HVP4C@beelink>
References: <20260724000841.933327-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724000841.933327-1-qwe.aldo@gmail.com>

On Jul 23 2026, Aldo Ariel Panzardo wrote:
> MT_IO_FLAGS_RUNNING is bit 32 of td->mt_io_flags, which is a single
> unsigned long. On 32-bit architectures a long is 32 bits wide, so the
> valid bit indices are 0-31 and bit 32 falls in the next word. Both users
> take and release the flag with atomic bitops:
> 
>     test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
>     clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
> 
> so on a 32-bit build every report and every sticky-finger timer expiry
> reads and writes the four bytes that follow mt_io_flags in struct
> mt_device -- inputmode_value, maxcontacts and the is_* flags -- instead
> of the flags word itself.
> 
> Before commit 46f781e0d151 ("HID: multitouch: fix sticky fingers") the
> flag was bit 0 and the word only had to hold three flags. That commit
> reserved the low eight bits for per-slot state (MT_IO_SLOTS_MASK) and
> moved the flag out to bit 32, one word too far on 32-bit builds.
> 
> Put it at MT_IO_SLOTS_BITS, the first bit above the reserved slot range.
> The value is only ever used as a bit index, so nothing else has to
> change.
> 
> Fixes: 46f781e0d151 ("HID: multitouch: fix sticky fingers")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260723224211.613112-1-you@example.com?part=1
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---

Same result than the previous patch of this non-series: already
superseeded by an already applied patch, which I just checked was
already in 7.2-rc3 at the time of the submission.

Cheers,
Benjamin

> This applies on top of "HID: multitouch: bound the slot index before
> touching mt_io_flags", which introduces MT_IO_SLOTS_BITS. The two are
> separate defects with the same Fixes: tag, so they should backport
> together.
> 
>  drivers/hid/hid-multitouch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index a75c821f7758..e7d811ed4123 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -99,7 +99,7 @@ enum report_mode {
>  
>  #define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
>  #define MT_IO_SLOTS_BITS		8 /* bits covered by MT_IO_SLOTS_MASK */
> -#define MT_IO_FLAGS_RUNNING		32
> +#define MT_IO_FLAGS_RUNNING		MT_IO_SLOTS_BITS
>  
>  static const bool mtrue = true;		/* default for true */
>  static const bool mfalse;		/* default for false */
> -- 
> 2.43.0
> 
> 
