Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55419046E;
	Tue, 18 Aug 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079804; cv=none; b=hvQTFsUG74XwbaMF+/cIyYwDcQwu4eS74zzGCES2z9J6GOsKxKV4cALx+CxrNCkQdE4bsFArkARyxnHa8rMSZHogYyMPEyoBVggGyqMnkBYopNtRPZCfg6xz2fmhas7THMFIcxNq3hvPKHVuAwx41lff+H8L5eEpRh2ls2+2xQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079804; c=relaxed/simple;
	bh=AqYGZmK5X4R3/2IFOq+AOsrxjMMezAk1xB5HuGyH9yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTM9cPJAnXLbb+M0HhKJ3Epd/ySvoe+/cz7i02z/MyXi1fRC5j1hIqxC943fEt61FglE/UHKSu7JevQeaIwmw5hSnTc+hrVSV0NR93EMzzyZyMPypVmTAqFxilebqRvNzzF7LvEhFPlhjsCsMkXL+wBowU2VnszWP/WsG9dn9KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SSVubH5c; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SSVubH5c"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C67F940E03E2;
	Tue, 18 Aug 2026 19:03:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xJdlcgk4CM2P; Tue, 18 Aug 2026 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1787079788; bh=gpJYc9Vw6C/498hwOYA8I36M5jzPHkvEYhvrtSFCYes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSVubH5cgaGZyHT5C1a0QePES8+4S4pvCxECyOQaGRNF29OfLmmp+aQzF9txN0wUS
	 w+sXLf4MiisnF+RTubhSg8Lk709J67p1AD8VoLYB83n+jb51UlmU0CME+Pd62y0vwM
	 4HA4NMApb2+lUA9rm7xBlnhT0v+fDwsVX3NBEv6MyEzMFsRHytXSRweYimQtsw+jv/
	 VqQFwALfWwXXBsL9LyKhk1RxiC9omW1hFhaOAvt+czrJ5HnG2ZdKg5pdh/DKpRGxVF
	 CWMt8fYWgDmrTq34tWmU0UvOBpt8x6+dU7sylNWAxudABwtrOJI7RW+NPDzCtmC3rj
	 fWz11oaeLnduI158BVBE7bD2dg1YCoDV8zORMhDYKsPg31qx3ysTUVxJkurQOzaBJf
	 HmKUGk2Jh/ZwURWC529+hO1uqkQovQzwtYbRdS6wiKdtSWDVF95rwn+ITR7JsrxSu+
	 fS76r4lABt+YtBMUX+PrwOg9Vgua8gQi++3P9NAxVP88bf6V1yUp/C9Go+sxywQ3YU
	 8Twpr/j2zT0Bapx3WzouC5H7k2drVzNPLvI6x0cGz1Ekk7akBqvPi0DiK8GfpEZRwg
	 o76Iuc5syqvpuFRb/2/BEEhxsEWZh/8w3Ux3OHmgBG/fw/rJO1wiSazz3GMJLPsp2e
	 Sg/x+SBYrBA6NltgCOoRG2jI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2390A40E02D9;
	Tue, 18 Aug 2026 19:02:52 +0000 (UTC)
Date: Tue, 18 Aug 2026 12:02:50 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jasjeet Rangi <jrangi@purestorage.com>
Cc: Smita.KoralahalliChannabasappa@amd.com, dave.hansen@linux.intel.com,
	dgiani@purestorage.com, hpa@zytor.com, linux-edac@vger.kernel.org,
	mingo@redhat.com, msaggi@purestorage.com, rhan@purestorage.com,
	rjethwani@purestorage.com, stable@vger.kernel.org, tglx@kernel.org,
	tony.luck@intel.com, x86@kernel.org, yazen.ghannam@amd.com
Subject: Re: [PATCH v2 1/2] x86/mce/amd: Fix inverted interrupt enablement
 during storm handling
Message-ID: <20260818190250.GAaoSsWiKOuj4gRYsl@fat_crate.local>
References: <20260814232446.GDan-jvtKrj4Bh8Nsa@fat_crate.local>
 <20260817185110.1644857-1-jrangi@purestorage.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817185110.1644857-1-jrangi@purestorage.com>

On Mon, Aug 17, 2026 at 12:51:08PM -0600, Jasjeet Rangi wrote:
> Inverting `on` in mce_amd_handle_storm() alone is not enough because
> clear_bank() will immediately and unconditionally enable the interrupt
> again.

And?

What would happen then?

Did you read my previous reply?

"The thresholding interrupt should not be a problem because with increased
polling frequency during a storm, we should not be really getting thresholding
interrupts because the polling code will pick up all MCEs that get logged,
first."

Or do you have somehing in mind here which I cannot guess?

> Also, the threshold is sysfs configurable. For example, if the
> threshold is set to 1, even when storm handling is on there will be
> effectively no polling.

Yeah, we don't protect users from themselves, you know :)

> On Intel the threshold is temporarily set to a very high value because
> the goal is to effectively disable interrupts for CEs without disabling
> interrupts for certain UEs signaled via CMCI. In older kernels the Intel
> driver used to disable the interrupt.

We do clear MCi_MISC[ErrCnt] to 0 so that's the "highest' value we can do
before we raise an interrupt there :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
