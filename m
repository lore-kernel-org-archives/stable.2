Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF912CCC5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488387; cv=none; b=bweuchK2wX/5OPrqKnMUlrD2aRQX9i6fd1cgqa52pth0mO6QyOQmPPGs6WhNhUjaVDmgiq3ecLX8sTgNc6ocI8+EvXg41ZtuQ39IqKJ/A78FqHuQveBt8kt+fc8GVEvnE9H4dqLSCKv/DiI2CAhCWVcCUDsMgJXYPGkK/rJSRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488387; c=relaxed/simple;
	bh=u3Aiw4YiS8VJikbLRVI5zqBMF0/XbmAbla4ft/2zHAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eKbMkzZCkrWXyj1N5LMedbyRAadKThAvHVcVLDh7QOi9VaaGy05wSshEP6+00ULtEuNP+k7IIn2bHBc/A1jfrglN+2C7E12Z4qZoybXB7l/9tEF6pvmSR+thbHaIb7Hjiq8ov6tSgqO2eA7lL0WgmXcl6Wdiujlw+RhqLrddoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=T0Gb6UN/; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="T0Gb6UN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1781488380;
	bh=u3Aiw4YiS8VJikbLRVI5zqBMF0/XbmAbla4ft/2zHAk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T0Gb6UN/q9xz/iMZo3+zY/Txk007UjbdC4u0yiV9sobWiRpCeeqrgJEvuY+KTDFyN
	 7wNpGBOydnLqeqAz/XvOHQ4aj0B+Khe9TY0fAcxqQwXJiCwwUlIidmsDXrmamJSvZB
	 ySPHM/R7ZLSAZSFWNPvhrPUwrPSOXnDIuwXSVocQ=
Received: from [IPv6:2409:8a4c:e12:98c1::376] (unknown [IPv6:2409:8a4c:e12:98c1::376])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id F223165982;
	Sun, 14 Jun 2026 21:52:58 -0400 (EDT)
Message-ID: <e7026309150cd147be874d2521dbc17fe0ecb1e8.camel@xry111.site>
Subject: Re: [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML
 to DC
From: Xi Ruoyao <xry111@xry111.site>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Date: Mon, 15 Jun 2026 09:52:52 +0800
In-Reply-To: <6fff98f69549a9069321a727f2333d3e4aa5e84f.camel@xry111.site>
References: <20260603153920.249671-1-xry111@xry111.site>
		 <20260603210831.item005@kernel.org>
	 <6fff98f69549a9069321a727f2333d3e4aa5e84f.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 11:46 +0800, Xi Ruoyao wrote:
> On Wed, 2026-06-03 at 20:05 -0400, Sasha Levin wrote:
> > > [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML to
> > > DC
> > > Rebased onto 7.0.11.
> >=20
> > Thanks for the series. Unfortunately it doesn't apply to the current
> > 7.0.y tree: patch 3/8 creates dcn42 resource files that don't exist in
> > this tree, and patch 5/8 depends on dml21_wrapper_fpu.c, which is not
> > created in 7.0.y either.
>=20
> dml21_wrapper_fpu.c is created by 4/8 (upstream commit
> 4bb2f0721ed8a2a70f864b9358bd6cd4d92199b3) which moves out the logic
> requiring FPU from dml21_wrapper.c to that new file, so the remaining
> code can safely use DC_FPU_{START,END}.
>=20
> The dcn42 files should be removed.=C2=A0 I'll recheck if the series conta=
ins
> anything related to dcn42 and remove them in v3.

Abandoned considering 7.1 is released and 7.0 is not LTS.

--=20
Xi Ruoyao <xry111@xry111.site>
