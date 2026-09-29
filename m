Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32937D101;
	Tue, 29 Sep 2026 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652715; cv=none; b=OASTQinwuof/EKzqMGqs1Twqj4hhupMKh520+j7dXMaLjVgvMUDoD8Ifp4AuJBwMUaKLmf/riypRjczxcWYIy/g9nbrf0fkgwimXUFbE5GucW5s9mTYnc+j4RRHz4WNNgbTYaSgLwhZzJft06I0K2+vQMiGbXlQb936+wS4Kr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652715; c=relaxed/simple;
	bh=SZnFH6V0TFQTkDaGAjaRKZjWU9qJcTYS1ecT5Uzgxz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJraz0g+swShsJlMsHRhVAsKZEY5M8fojBiYnJmM+bMIxYysz6wuBLk2tbQtsBTq90w+bFSOmwfhHAO7msXF0yDXmpX1rSPFo0hjffFduWB7VkFTfxF1Ys2Os9VREe/f1tlu0RNHflHAxciR94BgUfYWF6DpiYiFsh7SHFrN9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b2xX83qV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b2xX83qV"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B20B740E015B;
	Tue, 29 Sep 2026 03:31:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AGeAEptx5KvJ; Tue, 29 Sep 2026 03:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790652700; bh=Al1glvz/IJj4lju1yIZV4opc56skglAbD2Mb6ols/Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2xX83qVtrqyb8mS4q5XqI6B7tukE5G9Ex9svkbCNsvYQM1STItgNJZLhFH7jOprf
	 ZnqnWsAjGzvXa4ki+Ce8YhW25fxIk4zZP2MPu1m5uewrjzU6AgIY+YDt/hlX5A/WnS
	 wbNbX+EoHTWQ57uwS5dGF6frcpjZnoL0AE4nFXPdx8rIzQS6huorHx9QDgADcTu6np
	 BvX8XqqYx7r4h7hY6KqCbHuOVsdpcC3WdaaoYkl/EaeQ5mBFoP5HX1541VuIF7BN++
	 +ftjgZxmLw6V65pAWX6aM8i/A24gXBPDWi0sELtxxwdDtuq5vdkpbSXpHa+s0PTfCy
	 bMamNYiYhF4Fc3QBie1uJfojYAbTH1ij0mfqFcLiDfKSbOXnr1Beq/YZiyiYaMIVCy
	 c1ygwBZFNoQARMOYc/U5L7kfjr7H69AisDYf/erqcbyINHQjmuZKNfcZzykI6w3Fz9
	 AB3JN+Bqdtz6AOlE0Kg+4hQxJYRfXcY1nCFL38zGXtwU6l16iyFsaKV56NAt5/pM2R
	 jNueI4+E7Fdc9DKceSw2zwHEaCaNKysybe4tMHcYZyFbXrOGueSE3nkB1FCNmjUuq8
	 N5Eff6NarqWMZvBBgInzKSvjdKwBfoZ9+edWyzJuq3kWDFSrW4gIYNwFxuyg+ow3XY
	 zppgwRQH2s14Ti8O00DZC6so=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0679240E015D;
	Tue, 29 Sep 2026 03:31:23 +0000 (UTC)
Date: Mon, 28 Sep 2026 20:31:21 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Message-ID: <20260929033121.GDarsxCR4uIpLB69P0@fat_crate.local>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
 <20260925054444.GCarYKTAdrrJ5a2VYO@fat_crate.local>
 <TY2PPF5CB9A1BE6EE1ABEB80D36C3365473F28C2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE6EE1ABEB80D36C3365473F28C2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

On Tue, Sep 29, 2026 at 03:26:42AM +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
> > 
> > On Wed, Sep 16, 2026 at 01:30:37PM +0800, Ryan Chen wrote:
> > > Add ECC error reporting for the Aspeed AST2700 SoC to the existing
> > > aspeed_edac driver.
> > >
> > > The AST2700 memory controller keeps the same overall EDAC programming
> > > model as the earlier Aspeed BMC SoCs, but uses a different register
> > > layout, a split interrupt status/clear/mask scheme and DDR4/DDR5 memory.
> > > Rather than fork the driver, the existing code is first tidied and
> > > generalised, then the AST2700 is added as one more per-SoC variant.
> > >
> > > Patches 2-5 are bug fixes and cleanups to the existing driver.
> > 
> > You always put the bug fixes first in a set. So it should be 1-4 bugfixes, rest new
> > features.
> > 
> > --
> Thanks your review.

Not done yet but you can send a new version if you feel like it. For it, you
could also pick up Stefan's patch and merge it with your last one so that the
driver doesn't become orphan.

Also, think hard before you mark fixes as CC:stable because stable fixes
trigger a lot of work downstream: stable trees, distros etc. So consult:

Documentation/process/stable-kernel-rules.rst

before you do.

HTH and Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
