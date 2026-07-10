Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C538AC99;
	Fri, 10 Jul 2026 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713842; cv=none; b=CrtRZ3lch+5lQCfocDCIXB+AbfHrZW8EHJC88txyCe2OOE2ZC7rupP2tWLPqj6kAnHR2ozNsOQmRy/rwIYqRvKEHmY38AFxG3PV9Mu+JiXt99Oo0NisXBetMKx8i5Z9XktPNzJJc2TpjVCKx4vmbPq/QrSXs7euZOC1w9eYShrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713842; c=relaxed/simple;
	bh=XFM0uN4lOBfRtc8OOeAVzmLTA151f3cIc+2Hot55yGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf15Kt/AmjYXEJVLX6yQAXoGcDV+7wrT7ZpvcvrIsCMRkLQUh7ssb3GUxagIl4BFo0fARFC/Q2WyJG7lvXWcDZ2ihcOU5QnPbbbP2kVe4xL2cPPmIBvu+n7ChMZpmmTPjz0QcIrViB08Rt4DFfDTXKJbhQ4eQRMeOXhAp7No0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CYM3qxSX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CYM3qxSX"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5211540E02B4;
	Fri, 10 Jul 2026 20:03:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id flS1tjuJZTcn; Fri, 10 Jul 2026 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783713820; bh=UjDR/MBglSWbFFeWuS1NtIkTEWkAyJ6FFviuRnSvs/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYM3qxSXgkD2iCQ1LCN80m8rObcqrdjZU/NELyH0BMNAHZEqE8YD0NmnXM4DYuz3P
	 fkeUuJhfZ1PvuCvJu5/5Gu76Sl35yydZhr48jvSdTL+xQfPnOdPbbbzpJheRdEkQeg
	 +76N4GMxsbm8Ea21heW0bHbF2fSjlT4Z9tAN0nud7PQ4JyXGTnVudgA9r/BlfR1CXd
	 FqzXTbXUgaxgZ9XLtS5Z46esoS2m/j4MV5s2onZNe8dV0gXvZpDVg8Whnb82GOfjYd
	 M9bsYO30JYt00egSo7zMeOT1yyQwcGDTrgG+upCJb5JO2HLoo34bfRUhm0N4EplB03
	 9KF9YCEl5DLZ41JNbDCDjuooByneDgXaPvT3ej112VGAn2pqruICO0Cp+Tq9zHX8ds
	 M5aSTP9JgIKPm8Q3Zp8MANj6ZNlefZRriHntcMyIZmoq3oDzkLqtTER4y3UQnHf/hi
	 r6ioYF4osiMIxFCpRu98TCJaJehsrRrO78SorA9VicedDJnML4egGViGANYH6xaokK
	 0HkOLqKojw+fEGNM4823GWQ2nwG3yOZyfgDDWTC78fbn7pKPpAshAQA9JmpVvC6vOJ
	 U7Mt2lDMtpWLBfXLhJKcG2ETtigxMmjUtCtjPogGWqvhPWkYtkM+IvA+1id7dK6wO5
	 Z4ZgXWAPrfsPhgD1v5BBQm+E=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DE9C40E00C0;
	Fri, 10 Jul 2026 20:03:34 +0000 (UTC)
Date: Fri, 10 Jul 2026 13:03:30 -0700
From: Borislav Petkov <bp@alien8.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: tony.luck@intel.com, dbgh9129@gmail.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/altera: Use parent device for devres in
 altr_portb_setup()
Message-ID: <20260710200330.GBalFQEugXQ9nJyzGa@fat_crate.local>
References: <20260617164303.585555-1-dinguyen@kernel.org>
 <20260617221834.GAajMdOocCPq39b-s0@fat_crate.local>
 <f693b112-3473-424d-be33-d18310825004@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f693b112-3473-424d-be33-d18310825004@kernel.org>

On Fri, Jul 10, 2026 at 10:03:28AM -0500, Dinh Nguyen wrote:
> 
> 
> On 6/17/26 17:18, Borislav Petkov wrote:
> > On Wed, Jun 17, 2026 at 11:43:03AM -0500, Dinh Nguyen wrote:
> > > Anchor the devres group and the devm-managed IRQ requests in
> > > altr_portb_setup() to the actual parent device (device->edac->dev)
> > > instead of the embedded struct device inside the copied per-port
> > > altr_edac_device_dev. This keeps devres_open_group(),
> > > devm_request_irq(), devres_remove_group() and devres_release_group()
> > > all referring to the same long-lived device so the group and the
> > > resources allocated inside it are torn down together.
> > > 
> > > Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
> > > Cc: stable@vger.kernel.org
> > > Closes: https://sashiko.dev/#/patchset/20260503212558.2811480-1-dbgh9129%40gmail.com
> > > Assisted-by: Claude:claude-opus-4-7
> > > Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> > > ---
> > >   drivers/edac/altera_edac.c | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > How urgent is this? Can it wait until the merge window is over?
> > 
> 
> Can you please pick this up for v7.2?

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
