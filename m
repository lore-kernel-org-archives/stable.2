Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC413335091;
	Sat, 29 Aug 2026 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788029512; cv=none; b=cKln6ShXQKvNRcTivtpPlnw3HkLHhro9MgOqa6ZEvhkcr26XoUZx77RRwScaUMfrLZnvhZgqKExQW0UM9Y8c9E7PztKCUuDsimVKaXKqXgT4EvaHQ7fwK/75NPX/w6UxOoGfQdfrzjwwjkyi5B0BNnGOPTfX2GXkRfmpFe1hvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788029512; c=relaxed/simple;
	bh=Lnr0xoIIe8mBmFr02cK4zW5rfqJSEJ2lV75/O9dlbhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdnvRGSoHY9F6Sb50BHfsSPkxlJgeOhwwTWbKpSKtXhCl4OPQaAIbKWGCBMA+FJHHLyiHJebQzuCMWrUnNmpE1pJbqE6htAyYx+oshd7nRAVgVeiyo0d6eRLzoepXdOR48q1XAeontTsYSaY8qy6OBne46SUQ9YODkF4HuzmMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CLeTw5i5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CLeTw5i5"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 539BE40E0377;
	Sat, 29 Aug 2026 18:51:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aucMWHzsGWSk; Sat, 29 Aug 2026 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788029497; bh=BjZBpwXh61Zg34YTjMfi+r2qrk6tlOIm/PzmccxuVvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLeTw5i5DTZMs08uq3JaXiURTG2XmSrvSZF0tWuOjRnWEmuQvcc6tEe4A/Yl7h+p7
	 +Wn3J01doWBgt7isRHYb82tbgFnK1mdRK9p6pUn/VYCYjdX9jRtePYamQmB+IYNrjK
	 ueM924sIyQbqNeGafH31Zd2FennB5QsAopwbWkcVszpa3Tc7NLNKb0+K5sKm/kjLUl
	 3ElY7kXK1sKInuladrrP/ndI+lUyRs9Gb/ZjhEaLyy9H7kw9B20LJLL7FXqVkNb/Xm
	 M+g3V94tXQqgBPuCHnveERi91TvejTQJIxuldh4I7UFVkmRz0qeQZx4yC9T0tnjy8E
	 AzADIzwYZ2gVgTbE0U2L4w669zAaEurD4Q/ew0VF1hqn781+HjQPgiIRo0y6SVzVOn
	 vk4Bn8Ed8QE5nhFoip0W4Hwm+ZzByQOh8P9R5NWV1ZDzqr/1y4GtmMSJv3KrCyCFik
	 4cS0cmjwkgGbjE5X/ZWCPqVk+xtfpTWqcO10pQKe/PgZHv3c/mRUq0IsdwIZJ3AE6Q
	 lb3TAfkFNIdUZun+kKXrEaaZSmEI63vv+KZYsHqAULYQfQ581PI9Kzi83dZ484S4Rh
	 FjDZM+CtVuhY+IbNzxsBe5qlgUO7SKJbrxOsTDEWWVFeHpwqFfMAF8Z8CbXHWbBDlL
	 fq6oJE4LSqgFFN34IogLwUYQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2F3D40E014B;
	Sat, 29 Aug 2026 18:51:24 +0000 (UTC)
Date: Sat, 29 Aug 2026 11:51:20 -0700
From: Borislav Petkov <bp@alien8.de>
To: Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
Cc: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: don't apply va_align to hugetlb mappings on AMD
 F15h
Message-ID: <20260829185120.GBapMqKFM35KtL0Mod@fat_crate.local>
References: <20260828135747.724789-1-l.wandrebeck@quelquesmots.fr>
 <3faecf65-7edb-4cec-be7a-e5266dd3a649@intel.com>
 <20260829174704.GAapMbGAZMwImcvIN7@fat_crate.local>
 <0B48BE2C-2E72-4961-91D9-35E215F537A9@quelquesmots.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0B48BE2C-2E72-4961-91D9-35E215F537A9@quelquesmots.fr>

On Sat, Aug 29, 2026 at 08:15:40PM +0200, Laurent Wandrebeck wrote:
> My homelab is indeed composed of 5 thinkcenter with a10-8770e, and
> desktop has fx-8370e. Actually I hit that bug running 26.04/7.0 and
> reproduced with 7.1, 7.2 so I dug a bit more and AI (I'm no kernel
> hacker) proposed this patch. I'll happily test and report on whatever
> you'll propose if that one does not fit. SSH+sudo access is possible too
> if you want.

Thanks, just please do not send HTML mails and put your reply under the text
you're referring to when you reply. Like I just did.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
