Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8229A9C3;
	Sun, 18 Oct 2026 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364897; cv=none; b=UsUI17cQ5zzvD9oJCPiZD+O7nxpBXpq9Lyy9s91ygjYiwUwFTJIvdB9nkGhHj04sxLGrm29Ft6dO9R9K/sqAByjzJbNKOw6dYUQfOBMayG8oCrQq6v7Q7yt61mwE2gMkPGrfiY6qaK09v+5se0M+QM3U8b8HGw/ab0PhZQNDz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364897; c=relaxed/simple;
	bh=ZmcpLFVQZPRHuYrsHvbW+eViRHleAGV3pTQoktyukQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKSqFwbK9UXdi3YynqLtiWIxdXQJr1n2Ba5+zv00fTQ0Y7ll6NL4JqAotVHnAI4jW19HAcA5oIOlrgz5vRgOVlVAAPYCTh+m+4tTyfHFfhUt5ncUSMduZhWatGkWBDMPE701C80TrQBZVP9uzFJ9vxulCnzJdOLV4sHwyPjyp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fRzrluIw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fRzrluIw"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B2E9A40E0298;
	Sun, 18 Oct 2026 23:08:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id anzsJwdXaDan; Sun, 18 Oct 2026 23:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1792364882; bh=+0o5mrQL/bfW4WDLXl+sV+VpFI4s1XRL0zNlQ2imy3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRzrluIwQ/Mei7shyJ8HMppvo74zIbS7AZ5X88KlkqGSs5XYeKJe/x7aDn1WEK2Qs
	 PB6meqVrIKzo3YsI0FvwS6UZmb/LU1WBjYAAqmZVM8MWwpDZXp9F19ZQtmrrlbxjmK
	 cdkI2urRpzmXKrtCzTKIPnYpSjN2VSbl52UcBYRUW1d5Qe+g3Xb6u8IQ5O2xVqZl4/
	 PaSSPNmzsLMZaXKhJAYXL7WqwkcitsWjr+StxqKWH2r03rdvLunUQPcTgPjd2JYWTn
	 MLQWK7yKCwYlQU+rHglFTwEVLBSsg1071+eI/UUj/IIMmssf67kX8fgnGjsK/uw4aP
	 Gh51iGzBBAInBa/xyTzxaNj80FuNOEbweFkVNp3ri+HHxe0w3Joa+2V6jxzpVRNgW0
	 vNvpXdjP+WeLSMb6Ez6KHnKB16Aw8xSWOMwnD7w9DPqLiBbuzY/zqrsWnwGzgbTcmZ
	 doHausO2qF3saXVXnm0g5MY4m9B7JxJ7r9cTKHjNY2INAmHQfiFB5tjyQRF0pRkt6r
	 Qk0Lwr+DJ/5PewroxTyLa4PqJIGaDh851JYxxFuClMoV0JkNXZIGT1ZxWpyypo/1Q2
	 Et9qSolgVU+Esc6xyGHWasPIFghHOqidGQ2ej3jkYAtNO0T9yC2ed8yds7O4Acz46W
	 NoYDMD0dhEQWotwQ671VDoEA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C54D40E0299;
	Sun, 18 Oct 2026 23:07:54 +0000 (UTC)
Date: Sun, 18 Oct 2026 16:07:51 -0700
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Guixiong Wei <weiguixiong@bytedance.com>,
	Tony Luck <tony.luck@intel.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Add missing long names for SMCA bank types
Message-ID: <20261018230751.GBatVRR1NLJCBJrLIB@fat_crate.local>
References: <20261009020447.90758-2-weiguixiong@bytedance.com>
 <20261012140330.GC15198@yaz-khff2.amd.com>
 <20261017195145.GAatPR0dQVZGEMHglh@fat_crate.local>
 <20261018223431.GA3236@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018223431.GA3236@yaz-khff2.amd.com>

On Sun, Oct 18, 2026 at 06:34:31PM -0400, Yazen Ghannam wrote:
> "a" is better.

Nope.

Typing raw error values from a screen because the machine died and there's no
serial, or making a screen cap and then OCRing it and then finding another
machine to decode it on after checking the OCR did read the hex values
properly and yadda yadda...

	vs

simply reading the properly decoded error decode from the screen is not
better, no matter from where you look at it.

> The same "is not updated with the latest error definitions" applies to
> the kernel.

You probably mean distro kernels. Because we try to have those updates
mainline as fast as possible.

> And it's usually easier to update tools than patch the kernel (and also
> deal with backporting, etc.).

Yah, backporting kernels has a lag in it but if the decoding updates are
upstream, distros do tend to pick them up.

> In any case, this patch isn't about error descriptions. It's only about
> adding the names for some bank types.
> 
> The bank types were added three years ago. AFAIK, the missing names
> haven't been an issue. So I'm curious if this patch is actually fixing a
> problem. If so, then that's fine.

We dump the smca_long_names:

  pr_emerg(HW_ERR "%s Ext. Error Code: %d", smca_get_long_name(bank_type), xec);

On that patch I objected to the Cc: <stable@kernel.org> marker but if distro
kernels are the problem wrt decoding MCEs, we can change that and simply route
all *purely* decoding patches to stable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
