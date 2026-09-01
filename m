Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D196469851;
	Tue,  1 Sep 2026 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293529; cv=none; b=ozO7XD4Wsix5Ug58WI1yMk2EmQYIAbzyYKLR6JOK4bgFMnCeNvtIqjuxZeplzGS2xLudWYdHK9aUQgsOOA9sKSIiTJrJUWwn/PQMJEa+mRwI0GEhBtQgPDmjHjAlxaw7mZR9YPlG5Va2TZRXnIGKyAnTSV3melT618dbCZ0BS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293529; c=relaxed/simple;
	bh=dEbdVwUF0cAe1rV3JhnryEMGtyMnIISXvwpzdtTtz+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkqRDRSR0tBfuq+tn8bl7qRAcb6499PqPitwR3IE+JEsSZr3phrgrf1LCmqm5ftKcnPhM+3Gp3W+sQ1OCsgSV58yDYseYDjEKEuswePsDF/fFr1Yv6MYFl+4P8uzIvy6OjFQy51OT3k5WrMKnm5oEwB0KBhqAC633AgWoDyw2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NoupZb+1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NoupZb+1"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 817AD40E01B5;
	Tue,  1 Sep 2026 20:11:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wmHTEmQBpPrH; Tue,  1 Sep 2026 20:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788293506; bh=4Vl7thuwy7hcbn1yBAidfGmiyVoUYY932eoV9lPvW+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoupZb+1s7oWDgh3NmhmQEdA4JeioSPKGlfKcsd/ozQlGjVpMZkbGIl/kxTuId66T
	 go55ftrS6XkKfq8ypJeCeETQwomIpxBhlGxHwS6TDBTTSlmvAzyzrzc+EXQ0ypQwJv
	 6UmDJb/qjwcbMXb4e7eiG/9y2VpurGCZqZJhfa0OLbZWUAqy5SyyD3LnhhBMX+X47F
	 B20KRaEepJNybEGg4Scn3lCL03Mz1xt4GtLVcmeHWWiRjynz9MSyW/KhOtdjVuvo1f
	 o5TaZyB7B6iGPmxzv7pIbjA58UOk0gb7/96DCEqcfqSxS5/zRgTJvl4DOxJSSl+QIl
	 C91wVTF9RZA3phzz0L78i67BramLXg2xicc0P6VRJri5Jl+iRpQFuyn9dzMPDL4MeJ
	 Y4rAJJ5uQQa6tb3iAQVTPKA/OKF6jlCdaFldmJ522IhI/h/FmEWQiu7w5p8oywW0ou
	 d+RzRKlfnDwOTBv9IOMrLqO/64Yu/xCIfS6IrW23cuX2RIbppFWbmM7Esx3NULf7iv
	 GsNdN0mjcfKCEcgnltwTjOuem/05dCx/hYfR0w0oFGCEufLY08bL8bwjrLWRm149cl
	 NP9EoeOa/55Ey489Mnif2i6K5juZp4y9+ZpaifyMoVzNGCj/dot7bBzMIaj1TtiTdc
	 Aqj82cEtYu8Mz8x8ZQFhBoQc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DABEA40E01DD;
	Tue,  1 Sep 2026 20:11:30 +0000 (UTC)
Date: Tue, 1 Sep 2026 13:11:27 -0700
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Jasjeet Rangi <jrangi@purestorage.com>,
	Smita.KoralahalliChannabasappa@amd.com, dave.hansen@linux.intel.com,
	dgiani@purestorage.com, hpa@zytor.com, linux-edac@vger.kernel.org,
	mingo@redhat.com, msaggi@purestorage.com, rhan@purestorage.com,
	rjethwani@purestorage.com, stable@vger.kernel.org, tglx@kernel.org,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/mce/amd: Fix inverted interrupt enablement
 during storm handling
Message-ID: <20260901201127.GIapcxb5k-sW8TlV_2@fat_crate.local>
References: <20260818190250.GAaoSsWiKOuj4gRYsl@fat_crate.local>
 <20260819064601.1972932-1-jrangi@purestorage.com>
 <20260819140647.GA2416@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819140647.GA2416@yaz-khff2.amd.com>

On Wed, Aug 19, 2026 at 10:06:47AM -0400, Yazen Ghannam wrote:
> IMO, disabling the interrupt is the best way to manage the storm. The
> reason for Intel to set a high limit is to keep the interrupt enabled.
> The reason to keep the interrupt enabled is because the same interrupt
> line is used for reporting "uncorrectable,no action" errors. This isn't

Where does it say that?

I guess still I can't search.

Because I see

  c3629dd7e67d ("x86/mce: Prevent duplicate error records")

which did UCNA reporting with SMIs. And there it explains why you don't want
to disable CMCI.

Bottomline is, I don't mind toggling thresholding interrupts during storms but
this needs to be tested very thoroughly to confirm it actually does what we
expect it to do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
