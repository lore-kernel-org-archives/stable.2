Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78E248F72;
	Sat, 17 Oct 2026 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266723; cv=none; b=Cgey2vhG8UTmB3UPPJ0ydo9t1vNKxh1nL4Nz3I8e7XGUEkcZG+yWWT3RUyIZMMInog4avjiE8DxqaDxDf2wShVgBORAALqnhyBZalI4y+kO9CxMOs6sjB4ljW6Lgt9BkQureJAN94T6hpXVDawZLrrHkMBeTdkOONkJ+2pgd+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266723; c=relaxed/simple;
	bh=QWHnOIR/gEegt66Twr9xj92A74B+8WmceSQg0bWLy0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/R13b7VO9A+x61FsjntzAHYmYzmnTjkZdFpL5OE/x/9E2VYCq97FcjbdSCdhMIfwsdB3x3WFyGPFoVe4aMG8bRZkNJNpP7opCplsvR8jgr/373lnRuiMhkbjSSqv91qdG1txoHPFJ8aCHKUWQCIq/XzN/iFZkV9PFpzk9q3LNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MmSchGBV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MmSchGBV"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2279640E0488;
	Sat, 17 Oct 2026 19:51:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WlMeZV5jlWpO; Sat, 17 Oct 2026 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1792266716; bh=w+9+z6Y+dnThsE+OuxfD+pno9gifp3roJ194Xgds+ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmSchGBVUxuO5u4Iy4NP9tQApG86Xu1drct2WmTTeHSt3yYoILE/Jr0GZa41iCDR8
	 MDURCsq3/HO961phhUtniAudQa8y2goGZITHFhoM1SSzd8T1aAMD/n0JDBjAmIqzKb
	 I6THNB4p3cWIueXZZEfv2Ye3+TNI5xAlSTZI9S+Uia2yeZqkr9JwRz+oAAd8u+9Bzt
	 IbASSEKco8dtDp7ZobRGB9Fdfaw/BClECEqhJP6ogNWhuYH36+TtwaIqT5qANoYEN1
	 37zPq5Agq053V4LPYuVfnFUshAKtftAMWyjPGdoSPzXShqgHLp03nvkc18eSl6qi5J
	 Lm8Bic3FdSfkNzJxAos3pn+RzCtxKhLpS/SX23H/NPyBJWAXMMIIV2n3A39arZHhbG
	 bkSIEW1m7wy2ykcdW0wZZzc2BqucA58S89XyX0osVRSzltxckiXNDPKD7VlKcN83FH
	 FNZDquJgdZqU2yD2B0hX6vKLvxujAkyNoRMFU9Jle2tBIOPDRu8+tslIaurYVRYODb
	 ObEdMM1V7H7B0foLwOl9/Q/n4jWpeu/NchG2mnXiRwUzU9sqYboY4736y3SMlpPXr0
	 1tRvXrp5BCrWl1p2L40d7+5+7bWkypYCdDIbuOJBfT96tDPqCNgFuuuf9hcNuiM9ky
	 jCJtqLjB1HxOLjNOWREqnvZU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8862440E015B;
	Sat, 17 Oct 2026 19:51:48 +0000 (UTC)
Date: Sat, 17 Oct 2026 12:51:45 -0700
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Guixiong Wei <weiguixiong@bytedance.com>,
	Tony Luck <tony.luck@intel.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Add missing long names for SMCA bank types
Message-ID: <20261017195145.GAatPR0dQVZGEMHglh@fat_crate.local>
References: <20261009020447.90758-2-weiguixiong@bytedance.com>
 <20261012140330.GC15198@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012140330.GC15198@yaz-khff2.amd.com>

On Mon, Oct 12, 2026 at 10:03:30AM -0400, Yazen Ghannam wrote:
> These were intentionaly left out as it as it seems users have been
> moving to user space decode tools.

You're making the old mistake:

a. a naked MCE record in dmesg, you have to open the PPRs and actually decode
it by hand. Or use a tool but most of the time, that tool is not updated with
the latest error definitions, and you need the exact machine info in order for
the tool to decode properly, yadda yadda...

b. Get a fully decoded error string in dmesg.

What is better: a) or b) ?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
