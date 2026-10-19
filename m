Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59483B38AD;
	Mon, 19 Oct 2026 04:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383567; cv=none; b=SRfUSCk5jJbJMqOpGnhsgKx01uHL1s3eWgjhBTC+3NtIlxz8BZKKt6knv6nDv9CzhhV4yKON0gcLENtjYb1rKMDmfp6QOba4WHNgkli2pmoyJG7/9M/2y9aEpZ4H1YR8cRjVD+MmLLnqAEMXGAW2o/UXqobN92dFVFrf7xm/Qj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383567; c=relaxed/simple;
	bh=Hniv5Rxo4Srf/AQP3ouchkZsDzCPDxDuv4EWUbI2HuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiYd+e77StT7B4RTyEsKaxIWZSaog+if53mfxkVS29zXm1f0IiarxxYWAuCrHJMqkVndfCJ7T6XaJQ42j0UIwTLT+0yWFcFiew+NYEJocaF9m29AAYdzHaF5zQMn1uyQO+0RP5mOcvWQvPpW9icksBf/5XLiTn9tGw0LTkUi4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HsQcTih0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HsQcTih0"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AD69340E02A8;
	Mon, 19 Oct 2026 04:19:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xbL_rZk8CS-o; Mon, 19 Oct 2026 04:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1792383559; bh=m4C6NDAdLfTLYUdsWad3uh+TsP43kSzO0JJ54T+8QwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsQcTih0LnyYEIQVxNe/gnMNQrSpTpB7nzTAlePZAVEj7hCxsipn6tlLuMrfalsl2
	 7eiU3QcXeCJ9dF7n3wJq7vInGY2wO/fSD44OMgnKiEIuFHEztuTTfGw/SRVZ/eohjs
	 v5qDpB5F0dV/C/MDrI28axozW1kDtOzwSr9Gh1CNH3feF0uajtZgt1teyDkQhswGjj
	 /3QpHO+smvC0DBQ+BaTodkqhfdry9poWt/W4LVzkntYECAQP7xUo7OiOL6TE8ZM+7C
	 PUYbspn1DVsaTYVSEEENGHD8KO8GDRCj1YBM5iO+KCEMAo9yaghlTUhMi74wfYuylJ
	 /FWS9bePFKGbgIb91k6hsSrFromh6S9iDieKfFGQzGwghLsP/COrvmIzhfd930n7Us
	 wwJiQjh2HI/apvEeomPQL+S+PIQzKP0XxVXDEMNSCE78ssx4eWyWsuZcjn4tzkmWmZ
	 u1KzechXTvuil4bsDrkELsQGUcFTNs1I6f/ufXeWTLo+YotOBFJXiL5mnQD/tyJFpg
	 jEsNc5/nb+R/4a0gDxabbl4FEv7de7GXvaQk9o68NnoEZL+ohheXs40ksO7Yne+HJw
	 xQQgpik7JiC2TSsPOIoW7CjB8KTuJgA4ubIWlbSku1Yf9WFpsDQPg0kzDogboIycSj
	 vc0HHYT/oHROSSAqJvIFT3bc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2703F40E021A;
	Mon, 19 Oct 2026 04:19:12 +0000 (UTC)
Date: Sun, 18 Oct 2026 21:19:09 -0700
From: Borislav Petkov <bp@alien8.de>
To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Add missing long names for SMCA bank types
Message-ID: <20261019041909.GDatWaPatyL2pHDLKo@fat_crate.local>
References: <20261009020447.90758-2-weiguixiong@bytedance.com>
 <20261012140330.GC15198@yaz-khff2.amd.com>
 <20261017195145.GAatPR0dQVZGEMHglh@fat_crate.local>
 <20261018223431.GA3236@yaz-khff2.amd.com>
 <451788d5e97cba38274e663d2b7952c593e959be.461d4034.890c.4720.915c.a7839a9cc59e@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <451788d5e97cba38274e663d2b7952c593e959be.461d4034.890c.4720.915c.a7839a9cc59e@bytedance.com>

On Mon, Oct 19, 2026 at 10:16:32AM +0800, Guixiong Wei wrote:
> Regarding Boris's earlier comment, I agree that the Cc: stable tag
> was not justified here and will drop it.

You don't have to resend - I'll fix it up.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
