Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0901279329;
	Tue, 22 Sep 2026 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046377; cv=none; b=WPYw7Hipft9PnCgYMAVcH6EYMGNgGhYyMjtLSZgyp/CvZ/5wpkgoG640fpttK1dqBJGw6j/EQgtSPxvy3TWVV3AV1CEbE4I6KXiul/kIEgcWNXAyCX/9mmvLk1cRPdWfc7/bS7XA+oky2WNDrse8Ur6fM79cA/yr4R+0o3AhO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046377; c=relaxed/simple;
	bh=t9h8ZVkyMnzfe78FDh6yAY9agt1lEEmfFjtXgEfbJMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oirx2gFSumlD4ONsPrRcYiSGwFJnyX6gfNvi3exl8e+sSxKydMK/VsUoKS3UjEVncf2AL5274aaCOihQR9iiX4lF2PdklIsmTVk3olGne9HKPpL36m1xVrCziHs3U/jIGKl4u2NxomJIU7JZYi9MiPQgZK7OdhG7tOg69k7ljFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kuELMu5S; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kuELMu5S"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C1FD40E015D;
	Tue, 22 Sep 2026 03:06:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QU5ejKskzQrx; Tue, 22 Sep 2026 03:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790046362; bh=kH1JZ27xJw/Zb8sSjLOGFLtkumZbC4RSOO28oxUsB3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kuELMu5SA05bU1VTv3AkSiButq37SAbQyyhm9Loy+I0LUkOAKJRtJzwFTfRHmxibb
	 u7zQYD8ppy8R9my0SxaWJ63+OisFW0dww/JHpOqc4yxMx2vu/IIyYAbUL6nvyhWzcX
	 ccv21IchubY0J7LEOhm0bL+LRZLdInyHfc1+bum+Tz8lKQHL6MvcpKqs/atC0JlWaf
	 wUeaVwzzhon2gNlExGlCMJh4OY97HmGT6elu3ob6MarcIkscAgqUrqN4vP+jG3scEb
	 SkAOlS8zHIlWvkB1iwxuGFToQgBIXWjca6SysOUOZUJ6A9poBm/Tx2nwPekC2Ckj8c
	 AY5o3P4iGD/YgoXqfjsj80RQRD9NVwB2QfodpiT8zezgxLtIKsdtsYXRa/qQ13a+87
	 oCvQascsPgkbSpsUTssKUV3g2e7fhn5QFxv6HEmUObd73LlOcQ1rJVP7mAMqaRPXGK
	 vtVD5LfJB3NiYbbQb5x6WSnCpiWWRZ44AFFNTt9cpPRGF147Dyfvk0mPPBVp3r2XRS
	 KEGETn9F7MecGh2vd/tBeGMUcuBGzJBFlUBBDSJA9t/+81xs/BrSWP0Kmqm2v4vs85
	 xJ0MyLXh3HWR4iON3zkwOO8cUEVmeD68xvquDXx2DfOPHhZO/7lKIk3+b0xx0M0rCK
	 W2I43ef0VQW4hGAwg3RyHXYs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 031A440E00E8;
	Tue, 22 Sep 2026 03:05:51 +0000 (UTC)
Date: Mon, 21 Sep 2026 20:05:48 -0700
From: Borislav Petkov <bp@alien8.de>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	platform-driver-x86@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init
 failure
Message-ID: <20260922030548.GDarHwjL6ocubz8Lzp@fat_crate.local>
References: <20260921082609.244774-1-lgs201920130244@gmail.com>
 <arFKFmkpldopUIMI@quoll>
 <89bd2593-e0ef-4b9b-8c9b-833aff327a3e@kernel.org>
 <CANUHTR91qqHtCbaFHSqcMa8eZuD7EnTqyFSfDMwX=LsiMiHoEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANUHTR91qqHtCbaFHSqcMa8eZuD7EnTqyFSfDMwX=LsiMiHoEA@mail.gmail.com>

On Tue, Sep 22, 2026 at 10:11:36AM +0800, Guangshuo Li wrote:
> We apologize for the pressure this caused to the community. We will be
> more careful about organizing patches by subsystem, preparing proper
> patchsets, and following the kernel contribution guidelines before
> sending future work.

If you're wondering how to really help the community, try to review and test
some patches you see on the ML. Whatever you choose - there's no shortage of
patches. You can even let your AI run on them and see what it catches.

This would be a lot more helpful than only dumping patches on people and
waiting for review.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
