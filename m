Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1B4AF16C;
	Mon,  5 Oct 2026 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224421; cv=none; b=COG6S93k1JwtQMvGHuT5exYH7cyBDxrOGYKvM6wPIjTkEvG3i4laCIEd94NO4L5EW71twY3JFr28CE8a09JW1/m4Yfe8Dd3X+cy1fi7EUV1yUifeZCesEWKGtW1mNJdYj6ErDz2/H3ewP5/Ei7UbGuAwUAkxuEDGAhgs8PS7SiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224421; c=relaxed/simple;
	bh=u9gRhPSqI1RxmddsmsTOcJb5Um6f5nB6yTdSQ5JCLvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4jP4i8inopSDchVjBOCuLlZ+uRzsnT/iio2AbqRPD3Vr9nu+UPLilAWntzidL2On6brLypHgI4nP2laHZgC6X+r44c0l4TfKc2+EAGQ9ee7tzZ3ro3CqFF577rdRT4ycLsH7jpFKYCt8NHzCppMwdeQBRcly1GihRpW+ebOyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UQIubSk1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UQIubSk1"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0F28040E0326;
	Mon,  5 Oct 2026 18:20:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LvgLAoQ1mMwH; Mon,  5 Oct 2026 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791224406; bh=s8KeXRed3YAjZFs85med3SgZDGBuc1I4LD8UFJ0xho0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQIubSk1qiv+WCddBK9bC5gLfkFd1DnNV1zrEW7GWYm4ta2enlDIaJBzY5YAdzHym
	 V6NQD1EnuRvIKtELV4MnOxtZQzJQfcufy2e+7+ZM+oy37Im34Z9tNwvwQ2xn4NS1Dz
	 ldfgS5+zM9FSMGzAM1d1kkEZMd9j+9mdoH7RKt4KERkhSeNAlujfCwvjaR2rXWInJn
	 pNcq1HXXKeyV+8fTyVQd3Llo/yQhxd9rSmVwmoRKhqAuY1qFW1b15OiJ5D7SskBWX6
	 LscaiRCvf2reWtd/5AZGrkhtafhsk2XNHqx5/TfvkJeXtcL2m3MCJo0bSzfx3EEqAt
	 u4LABocktJiAfzi746auLFpKzdIc+Rl0eyPE3+3sq+kPUIZB044OxX2y1RZniuqUYZ
	 0Fq4FENc3dThuwQNHfzi1EM7VURsoZY1W8eZqtoEkNgqiPwZ4gmAuVHdkX/LD1yLxr
	 TTw3AybIs+89JZuMJTU+mp0zo95kFug99bv147iMu1AzyXzDU0zKmIiI5r+zit2p26
	 apFILlIntW9vq1ixSlRKytNuIVeZfJNan83DxGDVznPQEZq2sO3KUAkaZw8K9mTyzt
	 O/VSNziGNbMzqTIMCcvzwkzvOlugU5XWknGY+Fd7IqD7sooNI0viDSEYbaWgEmuR/M
	 9YWIUtjBgx5pbAWwAAfie3M0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAAB640E02A8;
	Mon,  5 Oct 2026 18:19:59 +0000 (UTC)
Date: Mon, 5 Oct 2026 11:19:56 -0700
From: Borislav Petkov <bp@alien8.de>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] EDAC/amd64: Mask UMC chip select to the four
 implemented selects
Message-ID: <20261005181956.GAasPqTL5dULZdj9TJ@fat_crate.local>
References: <20261002113204.3358815-1-Vishal.Badole@amd.com>
 <20261002113204.3358815-2-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002113204.3358815-2-Vishal.Badole@amd.com>

On Fri, Oct 02, 2026 at 05:02:03PM +0530, Vishal Badole wrote:
> For DRAM ECC errors, the chip select value can be found in the
> MCA_SYND[ErrorInformation] field.
> 
> ErrorInformation[2:0] was first documented in Zen1. The 3 bit field
> implied that up to 8 chip selects may be used.
> 
> However, all Zen-based systems have only ever had up to 4 chip selects.
> So only bits [1:0] would contain a valid chip select value.
> 
> Future systems are redefining the field to ErrorInformation[1:0]. This
> matches the existing 'up to 4 chip selects' implementations. And it
> frees up the extra bit for other decoding.
> 
> Change the current chip select mask from 0x7 to 0x3 to prepare for the
> decode change.
> 
> Fixes: 713ad54675fd ("EDAC, amd64: Define and register UMC error decode function")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
