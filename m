Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C86302CC1;
	Wed,  9 Sep 2026 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932865; cv=none; b=KD212G7aEmwuuWV/KNTg7Mpz6FNsOPjZQDuJnsrC3GE5zb2+PUgW5+ZAMByGN6gYxc8SXjVKpW36LbWGhstI8XNg3uBk91U7Xi4BXswuOeFG4N0z43N84l0BqCCLXCQZuX3x0v5U5cFHhj6c1BKUkXgqLZvcqkJdqIIhaqBgPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932865; c=relaxed/simple;
	bh=0OX7NS0OHrMcjPYcf0nWdOyQaiJxpeRx3bGnjIIZ+nQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOiHnS3vsft1Q/WnzsjIezwcbyFKzDEGRSQ5BVpR29ASEbd9w9Sp/+xE2jwDbPQglCsYtBh3x9nR3+j4JM31A3ugu4zNSoOMpz14ToZLUPkDThf5KnQ7U7IudmRzOeY8kBtZ7d+/xRAlociC7dMG3mhks0FGBDmC7C2phThsy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BdAPqQCS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BdAPqQCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788932854;
	bh=QXi4CxIsKcFvAvcPGZXQs2Kbt4qOqbHhroxMBzzNvgY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BdAPqQCSCLiA3BLGFkoi4pwfXq9Nciain3C0UiJ88sQo+oW+A4mOuJChPKVJaJc4J
	 rnXAnGPsmYvz/9jgM002rlvpKsBUBR272pNPj6pHGpyGQDuuoOP20KDlkjHsovyElr
	 KLokXclSXQ6v7PbgDLoZkzogzFQdzsBSlquAU/6lnWJadkrPuVM7FRyw5U5KgA5Cdk
	 QeJKkyQdhvsl7yn3TaXTOa79fEqYl1i06fYjRAlgDA1XWKpcv+EYy+cSUREnLNtX8s
	 UAi1XgTxIQkN+tCDDik9p2VeJSGyovPjNU9+DKxxqqNKEpvUUiCtUJli2lWFGRLH3t
	 /0sdbSsI4Bbiw==
Received: from [192.168.68.117] (unknown [180.150.113.112])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2604A60917;
	Wed,  9 Sep 2026 13:47:33 +0800 (AWST)
Message-ID: <f9d084200f79269c02e96cb165fcd3ba67be5271.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/8] Add Aspeed AST2700 SDRAM EDAC support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Borislav Petkov <bp@alien8.de>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>, Tony Luck
 <tony.luck@intel.com>, "devicetree@vger.kernel.org"	
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"	
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"	
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"	
 <linux-edac@vger.kernel.org>, Krzysztof Kozlowski	
 <krzysztof.kozlowski@oss.qualcomm.com>, "stable@vger.kernel.org"	
 <stable@vger.kernel.org>
Date: Wed, 09 Sep 2026 15:17:32 +0930
In-Reply-To: <TY2PPF5CB9A1BE6E8F9A377C5FB805E6D9DF2B12@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
	 <20260902160843.GCaphKC-y8HpkiAIWh@fat_crate.local>
	 <TY2PPF5CB9A1BE6E8F9A377C5FB805E6D9DF2B12@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 07:13 +0000, Ryan Chen wrote:
>=20
> > Subject: Re: [PATCH v2 0/8] Add Aspeed AST2700 SDRAM EDAC support
> >=20
> > On Mon, Aug 24, 2026 at 10:42:27AM +0800, Ryan Chen wrote:
> > > Add ECC error reporting for the Aspeed AST2700 SoC to the existing
> > > aspeed_edac driver.
> > >=20
> > > The AST2700 memory controller keeps the same overall EDAC programming
> > > model as the earlier Aspeed BMC SoCs, but uses a different register
> > > layout, a split interrupt status/clear/mask scheme and DDR4/DDR5 memo=
ry.
> > > Rather than fork the driver, the existing code is first tidied and
> > > generalised, then the AST2700 is added as one more per-SoC variant.
> > >=20
> > > Patches 2-5 are bug fixes and cleanups to the existing driver. Patche=
s
> > > 6 and 7 rework the implementation to accommodate the AST2700. Patch 8
> > > adds the AST2700 support itself.
> >=20
> > Sashiko has comments:
> >=20
> > https://sashiko.dev/#/patchset/20260824-edac-v2-0-c8d8bb693586%40aspeed
> > tech.com
> >=20
> > Please address them: if valid, fix them, if not, explain why they don't=
 need to
> > be fixed.
> >=20
> > Btw, I don't see Stefan reviewing this driver and his last mail on LKML=
 is from
> > 2025 so it looks like we'll orphan this driver too.
> >=20
> > Thx.
> >=20
> > --
> > Regards/Gruss,
> > =C2=A0=C2=A0=C2=A0 Boris.
> >=20
> > https://people.kernel.org/tglx/notes-about-netiquette
>=20
> Hello Boris,
> 	Thanks your review.
>=20
> I've already replied to both of Sashiko's findings on their respective
> threads:
> 6/8: https://sashiko.dev/#/message/TY2PPF5CB9A1BE61E82EEE55F3F725362CCF2A=
D2%40TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
> 8/8: https://sashiko.dev/#/message/TY2PPF5CB9A1BE62172BCC358347C4836CCF2A=
D2%40TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
>=20
> Short version: neither needs a code change. On 8/8 the premise doesn't
> hold - u-boot masks every implemented DRAMC interrupt source
> (INT_MASK reads GENMASK(16, 0), bits 31:17 are not implemented), so no
> non-ECC source can raise the line and the spurious detector cannot
> kick in.=20

I feel this is a fragile analysis given multiple components involved. I
think it would be easier and safer (both in terms of kernel behaviour
and guarding against change in u-boot behaviour) if we have the kernel
driver take complete ownership of the interrupt configuration.

Andrew
