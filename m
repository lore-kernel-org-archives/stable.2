Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6880C2D0C9D
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784486429; cv=none; b=Ow6lntrrmvdF61K9lXfKn1vUlrsIJUHw2FzIdjulJigh+GHoSR0p6+LEzsTOBAJ1GMte449ufztLVXDbY2h5yFMIJFjtkmXb+1z3JUc3azHmJBx8I/twh6dq1Mx3CwqBHlEyTEkKcerVeQA/b6rCDxyE1OaTn1zZduMnNHLtlzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784486429; c=relaxed/simple;
	bh=sbXhwiQL9w53zOdpxt2CejGm2MR157c+CewiOpxuzog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fARaurAFkUMswl0nrgE9fuNwqo2ZiSe3mUwaw1bwMLayZ+4tlsJEsHtYATZamr5CHfsvcaHOu5QsXa2sErX6/kEulB/rzKP7MgFvbs6gkjuyuQrGC9LbkMbm4Rh9Mr55C7MR6K/GXZzKAE5/STLZwvCjgqpJp3VMqP8q2XVRYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=QJVY3kzh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="QJVY3kzh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f785467faso79974f8f.2
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1784486424; x=1785091224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cChVpYVXCl1uEl+yJutgaGgGYt1KXZ1V7q0HD0QVhgM=;
        b=QJVY3kzhShWwSSf5YNWzrQ2h0mSYY/UFnXaojSDsA76yQAn81n8/TiVdbupDjXa5Ho
         zeulnJ7LWfjKeD+ZaTFteF9NjmV6h2bSnPBYDD6GrTN3RbhwCSgpONioDnPCUhCb6dow
         jJN30D8OWO2VFnhYCpLSJZYGyJ3vwwyxtQMcabrHc4iigdFDl/gmPCiB77arD3aFk3zU
         zxyvsl1IgS0rv46xzZ1en20WTi6xS0b9fU4jw61fScEvDDn1ypA3DV/EN/jQcIaBnNgU
         +6Cc55OHZ7rEIN8Mdm9dNaBQTcSnofCH4a5xny/709aH7Vb+y75uGdla2AWkALw3splH
         0L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784486424; x=1785091224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cChVpYVXCl1uEl+yJutgaGgGYt1KXZ1V7q0HD0QVhgM=;
        b=c7+4yyctwOmatpElPKree31SUPosGYm8GLTwyaHLGJoiFaX1zR4ghpP/XzY1HTrkEH
         mERCFWl9R/BVivsS7C+NobpkPW81WLFe2nbekdelsCz2J0matUJjp4yR2DUrckf2GmO9
         zBixGw1vFvvElOdpszqQu6BF/dXii+76iII5uJxFUEaCT1WZLMHdeEht0wAu2WIfovvz
         HSqsFTlC0ZOTyEjnFdi6W5XnLmNMQ2lIP7b6ZG92yQ5O11Hkwbj0a3Q/ahTDM9+CbNpD
         pCuACN3Mum95tQ16+r3owcmJ3RuZwo/LKLBCFpaBwhJycY2Aa0yMyMZTKGmwdWfqlcyd
         r9CA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5+THNySrG2sYgM92NeoFKGsOMeHmYtglPJbuUbP/69jZPD6PBYAfhvRjOI0RmOmEwpt3b7xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbw7FVZa29fe8mPFMx0oFIWWlM1zsiV6OrbLeuvGnnJoB4Wkz
	xrdN5wH+o0oajdvLosGi0jIyxavAkHgJb20S+YGfL2RntGpL7vUBunAn08VuO8RWIGQ=
X-Gm-Gg: AfdE7ckF/9hWwPDgspg8DmhYVaKPSXrEOifbl6iy7Axry4gNDsJDyExG26bv01HtoAH
	+l31a/7DFhil0AQvbIFzdXGVGTM2K2U8RbprbfWEdwzRHvGLJBeFnlvS7GsZxyIywdizACkXmhR
	3r8iuc8awLeabKel6AHfvoqh750XyVTdtLCxxDhr+W/8HAzMKkgxvayFytcElZ2DnVb8PctRp88
	s1iDwcu8CELCpWzlYE3uPqyrbixp2ViprUzGkqmsemFToZoIo8WjViib+pw2WY6MDyQxhCQz4Mo
	2JzEo12rcOjB+EkZArIlTIOhNrfSat/5cFwUZh8RwG+Rp4zgGZZlUC6XWfLJmHfXDmmo2KR7xan
	3Ugzsevy2Wa/wQQxqvvt+ajisnGppvkXJrIuWoy157jCgtbA1mMfYtYAMHHGGzoXNtFzrdGooi6
	hy6eVPjCYVdoSu8e3MfsxMdUOqcPl3C+pgcObcPpVvVcG0ZVAjoLPCwFUyVF8w
X-Received: by 2002:a05:600c:524c:b0:495:4e12:6ae5 with SMTP id 5b1f17b1804b1-4954e126afamr107220415e9.26.1784486424495;
        Sun, 19 Jul 2026 11:40:24 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de8895dsm22842685e9.4.2026.07.19.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:40:24 -0700 (PDT)
Date: Sun, 19 Jul 2026 19:40:22 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: raoxu <raoxu@uniontech.com>
Cc: phil@philpotter.co.uk, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
Message-ID: <al0aFtSXRNqVpbAw@equinox>
References: <461EA3D17ECF5C5C+20260713082013.3423808-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461EA3D17ECF5C5C+20260713082013.3423808-1-raoxu@uniontech.com>

On Mon, Jul 13, 2026 at 04:20:13PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> mmc_ioctl_cdrom_volume() first reads the audio control mode page into a
> 32-byte stack buffer with cgc->buflen set to 24.  If the device reports a
> block descriptor, the function increases cgc->buflen to include that
> descriptor and reads the page again.
> 
> For CDROMVOLCTRL, the function then builds a MODE SELECT parameter list
> by moving cgc->buffer forward by offset - 8 bytes.  This drops the block
> descriptor from the outgoing payload and leaves a new 8-byte mode
> parameter header in front of the audio control page.  However, cgc->buflen
> is left unchanged.
> 
> With a standard 8-byte block descriptor, cgc->buffer points at buffer + 8
> but cgc->buflen remains 32.  cdrom_mode_select() therefore asks the low
> level packet path to write 32 bytes from that adjusted pointer, reading 8
> bytes past the end of the 32-byte stack buffer.
> 
> This is not hit by CDROMVOLREAD, and CDROMVOLCTRL only triggers it on
> drives that return a non-zero block descriptor length, which helps explain
> why it has gone unnoticed.  The overread is also sent to the device as
> extra MODE SELECT payload, so it may not produce an obvious local failure.
> 
> Reduce cgc->buflen by the same amount as the buffer pointer adjustment so
> the MODE SELECT transfer covers only the intended parameter list.
> 
> Fixes: 3147c531b6b5 ("cdrom: split mmc_ioctl to lower stack usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/cdrom/cdrom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 62934cf4b10d..4f1fd389260f 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -3187,6 +3187,7 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
>  
>  	/* set volume */
>  	cgc->buffer = buffer + offset - 8;
> +	cgc->buflen -= offset - 8;
>  	memset(cgc->buffer, 0, 8);
>  	return cdrom_mode_select(cdi, cgc);
>  }
> -- 
> 2.50.1
> 

So I've looked at the patch and surrounding code in more detail now,
certainly seems correct to me - nice spot.

I can confirm I've build and boot tested it too, and for what it's
worth, I can still set the volume correctly with a simple C binary I put
together.

One thing however - I don't think your Fixes tag is correct. I went back
and looked at this commit (3147c531b6b5), and the problem is still
technically present even prior to this refactor, all the way back to the
initial Linux git commit (1da177e4c3f4).

Are you happy for me to adjust this therefore? Assuming you are, I'll
pass this up for inclusion with the adjusted Fixes tag. Let me know.

Regards,
Phil
