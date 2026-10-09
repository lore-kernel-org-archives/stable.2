Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288333DA7F9;
	Fri,  9 Oct 2026 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522474; cv=none; b=dp1F02EsiPRZ6dF8Yreoxy28MqRuH4BSdIpUcmxLBIGMd0tvgMjetCa4lP9eyhbNLbWzL8OpkQRRBezUt/v9njLT8UR1SgaEFV9ddvwW1TpL2gd2SRa0M+HNLXFr7QY/ms6Auyzmd+amg5772VdvN3iiyp+osHuevnMizTFIK7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522474; c=relaxed/simple;
	bh=x1aNNo/8YX97HgJV5kOcfePNBMpST9aMFtWai/no6vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sii3eqGqHSDJk/8xAG2OdNvHR0z0NazAanVWb8k3xf/kOtGzb+wmHiX1gpT7rnjSUeu125XG/hhH1mxWAfIkBEM7vIy5CAj/oZedejUhUoP56K0vuQHNDHx5H8OKlSqXWJpP/La/Ivju5D1PVrfGkQL+9XRC2mges+SCj17ObEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LRjoVvNg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LRjoVvNg"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1924340E021A;
	Fri,  9 Oct 2026 05:07:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OZ0Y7uBpHPeF; Fri,  9 Oct 2026 05:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791522455; bh=Q/sgnTooCaDERwylVTvqmkr/jwLgvt3t3IOsBkxyjhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRjoVvNg3OprX6lLMWyZpAjUhzeMf7SACzndTCUIRciNvet2NGE0wvRHGgDEgvzfe
	 4EMiY0VRLgASwXDx1x2neeAaz2P5FYTvXBTCt6r7jKAQyCYfnmOwmwbCR2x6r4VfNV
	 8qwLNdRSARglJ9Kvxvq5UREZExX8oaMkeMEiZRudWOLndkXX9eg9dX4ifhcGepOLJb
	 uvXLgIkR2cu9cGgho2OWwbjOH7FQn3Ts+anA2QJThHwITZV5qrn5YcrXlAzqhbzn38
	 q1+lyPupiflayxErNzSjIWLyp6z7+YS0zotv9UE60FOt965fhG+sCYs94GPyY+ubII
	 xx1HiAb+ggqXoCBAJBoYPN68kUONteZc/BgKegDaiiGQ/N4x1IiAdw8A+jfkUJ9f2J
	 dRElQa2EY57IhaasxWcQg6AC2u3h6bETMXjvPjytNLEdrM/Nqa9lfAaGtcPddhC/Qk
	 B9CatwgzuvfnmKhRAfX7GqnkE3WZgtz7BcOcu1iX6r/Qd8eah58NP4qAsmSW5eY3gJ
	 78NgKSpwinWMSyTivA4ReZBrm6epmJCj0u9E1Y0AWV+wEDk3aRWg+WakqDSVvj5p1U
	 jYp5JkorWyv5WBkh/iIlMwwlaqKIrwKYTnDJMcsbrpfXzyeWWedk0YuHNPjbdQEwtl
	 0XV4LDz9lWLXG5TKnudzFW2U=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A4ED40E00B9;
	Fri,  9 Oct 2026 05:07:27 +0000 (UTC)
Date: Thu, 8 Oct 2026 22:07:24 -0700
From: Borislav Petkov <bp@alien8.de>
To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Add missing long names for SMCA bank types
Message-ID: <20261009050724.GIash2jAEvVxHhvXDb@fat_crate.local>
References: <20261009020447.90758-2-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009020447.90758-2-weiguixiong@bytedance.com>

On Fri, Oct 09, 2026 at 10:04:24AM +0800, Guixiong Wei wrote:
> Commit 47b744ea5e3c ("x86/MCE/AMD: Add new MA_LLC, USR_DP,
> and USR_CP bank types") added three SMCA bank types after the bank long
> names had been moved to the MCE decoder.
> 
> The new types were added to the enum, short-name table, and HWID/McaType
> mapping, but not to smca_long_names[]. As a result, an error from any of
> these banks is logged with "(null)" in place of the bank name.
> 
> Add the missing long names.
> 
> Fixes: 47b744ea5e3c ("x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types")
> Cc: stable@vger.kernel.org

Which of the real-bug-fix criteria at the top of that file:

Documentation/process/stable-kernel-rules.rst

justify the CC:stable tag?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
