Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F663DB630
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272316; cv=none; b=aUslhmgBRdmzJ+d9AIRG2z/zMojTcSxoB9oypHX7Q5HBti3xVAhO+QzrAYZHCnlCqhGgVCm48NgqadcUxEJaCiFoYqSmLW2bCB4uHwv8mhZxUgL4HdiEwCj/fyv2MYrCW8G3WQylqW0SsDXp2Bx4bm556rtnfdxQrcqBNDBDpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272316; c=relaxed/simple;
	bh=Yk22J3nvb0aXEfM6aoJJtvE5IvWIT+OAy6vJ0HkbklM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErPGMGbcDlwoJU64U6mhGIZW0nZhLW4WS/4kwHk0VjX5DFPnMoQSEAJhgTLhuMbISQA4B6s0DGaWcxOETZJgD7cX1YxNjqmjULlUGM3WqAbEcoQEFys6YXFtLh8J/jw46NF2e/aV8+XuHMALfiGEB1O4YcAee+FDT5hG4pSv/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=NQDqtp0j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="NQDqtp0j"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49548e01d02so2012835e9.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1784272311; x=1784877111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DvP5f2MyXpaG6bvKDFYo43XdMyCniE05LrzPCulxhlQ=;
        b=NQDqtp0jJSApJooFj34OaKkPTLqrgUhHJsFKQ+L9EyUdloYG1BIwZB6qwFUXrXIJPL
         MZ7+QFVqlppM2KdsLLrmn4SPPfMRKSyjBXtHMOZnBAxcQAQtV3kgepnzcRYpk8zp2SJF
         xgbRZUOGpYkdACwHtHsMuZGYwwla20453pBFDKtUZxOL30xjHr8L6HS+umeoHjqdNfIP
         ctK6sYLcKv2xObw9z7Awx67yvSCUiZEkgLyjPkPDlWZHKPgSeJYXjeVRdVDmKpcHIJQl
         pH6iTo1QTE+7AyDQ/IlCkagUXYrbeV8op14sPyl6yA5LdDQimlZSkBCNLopYHtULLF8+
         LyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784272311; x=1784877111;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvP5f2MyXpaG6bvKDFYo43XdMyCniE05LrzPCulxhlQ=;
        b=UYl1CZPgprwLen8+j4Zf9Rd+l0Wiay0B5xLYMHyilTs7Ahragyx+2TSkFiXJSOtQmt
         7rr7xYCs0ISTa2yEpAIwB2sHPNVT0+TlFjxCCKGPbwFFCs0JwVex29fHVm/Qkz9PsCUz
         MBYyr36diz1AtupQKvpaFN0LqyJq1MSPvPOYcpj4KaXptq7+qW4v65J0YFylBLE65jKV
         qKxqsO06ulIjkKkvE8TqZNRy4hyNgfwdvnAlzFzzBdEkwecH93NX9s+Sv2EIXjtXFI7V
         QvOz5cjWmQ4aVzkUoCLK/9fQkjE1psvncmTUkIuTQoZHe+xqhiE6DeoP/SkRNmgf98I8
         kbuw==
X-Forwarded-Encrypted: i=1; AHgh+RqY4C7q+Y9tCqcA49pOW5L2C4YDiTKvRVkxmo5+MrwIxHnKRh0DiLOQr8Nm4hrH9lL/bVWRVOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVmt2wGfaz7KiN7XV4ITDroST3OMVPMaC0rwInl651MxOeabg
	gRIacq+V8hm5qBwFG+QGqCkceyldMrg37UoCVDHqFsDqSEfIwuhA3/WikiMypcF7TdQ4d7eeLhJ
	QvlDRgK8=
X-Gm-Gg: AfdE7ck42GgZYk0R9hQ9o1J80ZDEXovaIJfhBp8j0BtqgO5FVNFR13C8ZxhUoLX6DBE
	w4ovv7sUX8Ar+YmMBi6s6ZArLVesh5s4QFJw1XXFsvMxBQERdo4Do7mpmsOUfLiCVNjNFDR8o0z
	T6dbNeixCk6xZKOKv3Nu10SPHsvs20PyivAQ5ZLIyMc4nS8g+Lk/2VEvZx3gBlFlR9vR2/vn6uE
	h5b0K++E15j+1x4jGtTtNecsCEX1fmEMkJjhlshfFmvBr+xLN5d0p4gJJtWM3TK1YUMWFVILman
	bDuGGDIV3O1dA6j5QCWk8bFIJiLkdrJv4zGFg8IDiQpszfMPRa+i+BPSBbTv+bhpI5uhSN9Ijt/
	9V1aCeLmfLIQVO7VcSwAjsMnQvZs7GVFY5Zdvf5QAcvriBfuu9i+FSIqcP8Y7FuT23jIF5DiDFh
	iU4AuHhKGV/dRks8NdY4y4GCm+WBc6JV5Zefs1gyBvtro2LefBgoLgcSMawoWH
X-Received: by 2002:a05:600c:c054:b0:493:a976:5c6e with SMTP id 5b1f17b1804b1-4954a3dce22mr7829965e9.16.1784272310670;
        Fri, 17 Jul 2026 00:11:50 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2e8529sm23363925e9.11.2026.07.17.00.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:11:50 -0700 (PDT)
Date: Fri, 17 Jul 2026 08:11:48 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: raoxu <raoxu@uniontech.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	phil@philpotter.co.uk
Subject: Re: [PATCH] cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
Message-ID: <alnVtDdoB7Zs4wfe@equinox>
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

Hi Xu Rao,

Thanks for your patch. I will endeavour to look at it and verify it this
weekend and come back to you.

Regards,
Phil
