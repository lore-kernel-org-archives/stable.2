Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAD37268A;
	Fri, 18 Sep 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745887; cv=none; b=kyQzTD1yxXlGBVeWYirBYuDi0Um67CpYX8/hW0zZrwQlXsdw0CY3fLAArVDIy/pbAtikwVidld57p2OseHjUZcNuFp+tMoRnuJFupgS5PabQYMybPaL2jt8DSLoTrUQXuGG1yRbJtVxXsUf/oElHdH3DDOtQSyEyqy9TyKRjdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745887; c=relaxed/simple;
	bh=m0YxD7VmkTrQ9BK7RawhfiNW848wHmn5GitM21kxqtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=httBAQUhh75HpOJgOMhnXNwKXRd62KlwOIJQv8mAex1LcZAxQxMT+2qVIydv13YGRGQSepu/PrQml5MB9ugEK9xh6l5f6sBy/QhuuKv/2eCyFdfTFf9NIcQOoXxTtxotUZay4zlGHD9w0fUgjyxouhTa5Ss/537dAh2qa6XyDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DOkpGsAy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DOkpGsAy"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB0D040E022C;
	Fri, 18 Sep 2026 15:38:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lXDPEcajzFne; Fri, 18 Sep 2026 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789745871; bh=36JNwdFzxccnGIjCQpZ9YpuxHSaUKRaCuz6LQSxaurw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOkpGsAyt2wg3Z5tDnHQMEL+kRzGE1upsbkmP5oTtY2s6eTk/JCU4fYUGHilG/mV0
	 5csSClOXi6NRBcKaJhHA3xp+tCf4ABBvHrFQTe1V5ST9s8/SQPYiI5+bE9S7FXpI7G
	 X6jN0fRdCwTvGO/7qbjjUzVGTXxa7SKmQuz9eRp3gmePUzcRokfYcT+v3n1ivAW28H
	 gli51IruRU6GmhDgkLapgFadw66M6AO+ZbUFyb/TRJfoEL/Us1Sm5aWwhFZyWOGn6p
	 Spq//fSHDpbeEzccHAHlJoyPT+UBtWXpadz/PpWA+eUS5K9B6Lv+QYGIBwZ2d9K4G5
	 UKlqPE+pRlzayA8g59KG2yIYE2a5Txq9XpdHkQJeRMMMGT1bFQNM7CV08Dgkd329P8
	 3OY2KSTqQYa6XStqJttQPONUxcTcsjQGC6tS/wKP9KQvF2WxfAj7Qp5ujUu6bHfuYr
	 W01cm55dMB0YOwiqAWD7s/zMmUtpECgDH2PPOU5TDFLva49lnffXj/tKtN3Srusjff
	 JS8boS5f6cV8QOnSwVO9gc8ZdEAOR52pbu2t7qfNrpdkvX8LCc6IPcMw2H72QP0FvH
	 LSflkc/kS9KmbGCp821n5+6QUgKBUJfBqfN8/XCTiz8eMq/qYG7/T1hzVpnTE2e+KR
	 IK4arvGgttykH5XXGXqmHcUA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E94B40E00E5;
	Fri, 18 Sep 2026 15:37:39 +0000 (UTC)
Date: Fri, 18 Sep 2026 08:37:33 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	andrew.cooper3@citrix.com, arjan.van.de.ven@intel.com,
	sohil.mehta@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
Message-ID: <20260918153733.GAaq1avUE5atQ6yfKT@fat_crate.local>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
 <20260916225939.1144524-1-chang.seok.bae@intel.com>
 <aqzgCatxdoLDvS1B@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqzgCatxdoLDvS1B@gmail.com>

On Fri, Sep 18, 2026 at 08:54:01AM +0200, Ingo Molnar wrote:
>    It should at minimum say something like:
> 
>       Erratum GNR98: new revision %x is unsafe to apply until 0x1000405 is applied first, skipping it. Please upgrade firmware tools.

Even if you put prose in a warning message, it still doesn't explain the issue
fully. For stuff like that you need some properly written longer explanation
in the documentation.

Which I'm hoping we'll get eventually once the dust has settled down.

That's what the rest of this thread is trying to do but I haven't reviewed
yet.

> So this patch is still problematic IMO.

This patch is a minimal stable fix to stop it from #MCing. The real stuff
comes later. It all has been discussed on this very thread.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
