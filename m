Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE482E719B;
	Sat, 17 Oct 2026 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792233251; cv=none; b=kK/j/btUaQT/9wEjRDoNo2JUngRCtfNqB9KbAVzJ5UewPBHYv6SgCVsXaGISjap8pCDuafpPF9OKJ6gNToonQei8SzHh37As/r7nJD1/R6ggXEaa+R670N0Rt+EXZZZCF/JEMWrxN/Dezua3rdxJNrzH1Q5yGHc4/L/qRqTGXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792233251; c=relaxed/simple;
	bh=qBONbEIboh2MlAgrG1UFsbiiLfsszbTEih8wpPe671A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMnvFgnfEuVy+xwFiYSR7127n188pdU/X/pLgJmlfi1Rr6IAPlmdgypqDKFltAQzYizfzgrYqDVoXgEiEm1aU4b0j1VDDStbz2f/UCB95QXYCyeReDQXr1z0kIqnCqtgEivflehPq4kRL8V+zbQdFFeBsI0RyBpBtQNBo3a6seU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FqybWiE+; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FqybWiE+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=sZzWUcIAA2c0Q37uYzsYIsOQf1QMgb2uNEy/L4s1hKI=; t=1792233248;
	x=1792838048; b=FqybWiE+NOhFYF6DNvpqj5n2NTodYXMJAGAfWBR/sToRTwvpEWlqnVZywQXqj
	zudtivYiK988XOBlzySNtvlOcyT+/VH/3rY73EOfC73cjtbD7mlBmx8cVBPAsRQDNr7JkJbe0hjIF
	o3h5UkmxEC2T3YlYvPv+cbFkkkyE0zsgpKMZluEx+h2D3FLoD7x8B/Rk50gTr+2XYJc6uePdDFa+s
	bzK1En8ADA2MzgYEmgLdrtMF2h1JxRnMjahmd/2qHy8LeyoiliGdF+pVf3KIsUWjVE9gqcVIBVmGb
	fR4FBYhk5l3l59TD6hP57dBiV8QWy8OPbhoR1tsKs3zfiFz9RQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xI1jn-00000001t7p-23Zx; Sat, 17 Oct 2026 12:34:03 +0200
Received: from dynamic-002-242-066-005.2.242.pool.telefonica.de ([2.242.66.5] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xI1jn-00000002z6y-0gKZ; Sat, 17 Oct 2026 12:34:03 +0200
Message-ID: <cf92126e6c10883ace50789869a45dada32e4859.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 1/2] sparc64: flush only the aliased page, not its
 whole folio
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>, "Matthew Wilcox (Oracle)"	
 <willy@infradead.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Andrew
 Morton	 <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org
Date: Sat, 17 Oct 2026 12:34:02 +0200
In-Reply-To: <c74a2d45-2267-b380-c7fe-b6a2d3f8251b@kernel.org>
References: <20260928132102.1707-1-kaloz@kernel.org>
	 <20260928132102.1707-2-kaloz@kernel.org>
	 <61ab29d3-929f-49de-bb64-5a49318ede00@gaisler.com>
	 <c74a2d45-2267-b380-c7fe-b6a2d3f8251b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Thu, 2026-10-15 at 21:26 +0200, Imre Kaloz wrote:
> I like the nr idea. Since sparc64 is the only user of move_pte(), it
> would be a small change: move_ptes() would pass nr_ptes, the generic
> version would ignore it, and sparc64 would flush every aliased page in
> the batch. I=E2=80=99d still keep it as a separate patch on top of this o=
ne,
> though, so the fix can go to stable as a plain sparc64 backport.
>=20
> Matthew, Mike, Andrew, would you be fine with move_pte() taking nr?

With the merge window for v7.4 likely opening on Monday, I hope we can
still get these two patches squeezed in as my latest tests showed that
the kernel would crash very early on my V240 test server without these
two patches applied.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
