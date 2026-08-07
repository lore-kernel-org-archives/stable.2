Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29067369D7A;
	Fri,  7 Aug 2026 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084333; cv=none; b=sr/y8v9va9U4rE6Q6wDuOmZ6XDRUOj6ldAd9AFM59Nnp8TRlIaCINWcpSxXS5V8HSnRfUDK7QkZxTi5kJ2/tpODEB7+L3rcyaMnWd2OZJBLaurGFX/6oKcWpzUC2DSLRm/OxzuxjdO647b0Lx4xHk+s8HepEv+YXI/hbrnaOvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084333; c=relaxed/simple;
	bh=3DY21qe5V1Mu0XYl7cbJKjzotdMbU1wKpUwx14cBc64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=braQB443hIEfJbc9Y5zIcgkLxMBqF3rg0HbH4XbrWla5G07mQG4MuUB4kSlRDExi4e3H4Gcp5Enr1R0F+N3Z1m4KtoDBoMotxooJ/xYXDBYocsa3r4ddyzYkXo94w26MxQEbe+hngW+8ZU/V1MnNyHoTeg+kh/6Kc9AaqRGu5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d5QI/84V; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d5QI/84V"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 371EF40E016E;
	Fri,  7 Aug 2026 06:32:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1rZ0atGuTmYp; Fri,  7 Aug 2026 06:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786084320; bh=Y9GeMDyKAkDnm6/aKi0f7URBVyUh3xGn+TrDpE6VTjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5QI/84V2QHYVuXMBhqPZfbMjjCSyD3lSsDtSA+BHHd5+Us2m13D5g3MDDsxrBDjN
	 G2McZJrsBzmJe31wrmZLrVgzpFxDdAXSOl43+GysYHpW/2E++djnKDDIUliFHhxO4B
	 VHOshY+iu5+5UJaEamAFlmhuArFnVyLVOrNjtYFP3dfU+E1Mjc8h7jONFLShUDX1rj
	 FWfAK33w4vowvYYIXKUQce7RaP1wBhbnVvimPVqi2K/AG07s2XY2nW579RpMYsm1HG
	 na9VsWGZrWiQT3si6+zRTBi63A2ZijL37BS5dSTyaLMkACJ31O5M/C5S0KxXQZkNAN
	 OVCTzCgtFCKK7+e/jmVNezfxvkBGAkQ4tJzChhxbHiDSIrLg9YGXs0JS0uVC8ZPZAZ
	 Rq2C6WM0PgVvyLB2etbqz0q7/9lF3mPLNQBd7v4NoT0/Srf0Zo69LuMUP4I3wnSlLZ
	 I9ebbkDDdL8L8OErz4p4vbZdApSzkueXGFJIg+u5yvA7/B/5p0BjTSH5Zaw8Do5ICT
	 S36pXm/XIb/WWX78GUTDZ1rbazhaF+FLGRe6wEuIF1JKNu50wlCs3tNwoiIVcNcmPN
	 K7VI9zcgZe6NC7qe5hw6z/bxgO0e7WlsJDJ5xlikKuk1hzSJYkDoeVDRzsl6lvZgNV
	 xZHCOHhlcjW5sbOwH3PJ0lpk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C92BE40E00B8;
	Fri,  7 Aug 2026 06:31:54 +0000 (UTC)
Date: Thu, 6 Aug 2026 23:31:51 -0700
From: Borislav Petkov <bp@alien8.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	David Kaplan <David.Kaplan@amd.com>
Subject: Re: CVE-2026-68480 mitigations for older stable series (was: Re:
 Linux 6.6.149)
Message-ID: <20260807063151.GKanV71xHICuouSewv@fat_crate.local>
References: <2026080618-mulch-nullify-723f@gregkh>
 <anVdmsj0Ko294nBP@eldamar.lan>
 <20260807043032.GGanVfaF37dKFTb7PG@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807043032.GGanVfaF37dKFTb7PG@fat_crate.local>

On Thu, Aug 06, 2026 at 09:30:32PM -0700, Borislav Petkov wrote:
> Hi,
> 
> On Fri, Aug 07, 2026 at 06:22:50AM +0200, Salvatore Bonaccorso wrote:
> > In fact at least they depend on CONFIG_MITIGATION_SRSO, which only was
> > renamed in a033eec9a06c ("x86/bugs: Rename CONFIG_CPU_SRSO
> > => CONFIG_MITIGATION_SRSO") v6.9-rc1, correct?
> 
> Yeah, I'm very sorry about that.
> 
> > Borislav, can you have a look for the older backports?
> 
> Already sent fixed versions to Greg, waiting for him to wake up.

Fixes are out now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
