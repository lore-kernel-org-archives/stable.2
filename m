Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB803EDE40;
	Mon, 17 Aug 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977011; cv=pass; b=AgLkgXHSp/B9wowgPVQsWoroSfylOv/cuEtp4cJvXp6YICFqfZvPARA+4Utwe84lsNxgN6B3LWiZoMXbIS6I/VkhC90+5RqmXjGzIBurXLKfz/6JcRH8Yd0M4+jxstEzmfTuu4O/dAvkC1xbN3Yd5Z1IeFI3Ms5YEm8BefJrY48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977011; c=relaxed/simple;
	bh=/2jrLdUML8Wr+RGIy2cCWWnIcbKr/+VyfHueIU+RMl0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=TXcIGQx8nn6Sd8H6nFHyz2TT0Lb0AHPEHYMuSUueR7uA6lruJ9Z78m0gJJepe2JCqXZM/4NaoqSOYfRx6ERTy8lD7LIPll1EtA8tGkBNYZBezcpOrKWZSHTm3VdSUMyPMTnzqdVFKXGrl5TZ2GqzRe6hy1uWjOpWqItWvYU/3aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=fdMCEkNR; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="fdMCEkNR"
ARC-Seal: i=1; a=rsa-sha256; t=1786976993; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U6cymWYYO7LXndn2y17LP9o0JEgyHfqvJ3ux/NfjYTSOMXA9NrrNa//Xf7fyJ8ApU7ucrKRdUE4kmzwLAl78KpOuw37h+MkKa8nrOwmwJXH4dcu5dsm1RC7SUqq/BKRiqi7zHMEsLCbErYtiijAwSbTvxw3iCrat5LOa+xe/A8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786976993; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=erKOPNhhAS8hOf6hp4YHEJXpYsPwwHn/G7aMOMRsfvs=; 
	b=b326afBRjI2Y2P9eyVJy7LReoDzFCGZHtShx4tTaWtLpjCsChBYMza7hOQelkfPYvuN6Yd72/I5e2Xhexti7QIYYAo4tk27hhIXv1lZDDfZsHUzrkZ2Bj+QLOuYKWllS5Paympsu2puZAdBuMMbLEpm3BQA2EmTIHbILlOky+Xk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786976993;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Reply-To;
	bh=erKOPNhhAS8hOf6hp4YHEJXpYsPwwHn/G7aMOMRsfvs=;
	b=fdMCEkNRdXEkVujOyg8J8DBhqyPel9M9ywdjX7MUINuL94DuQuqnU6jasT85TsAL
	DwTqgFiE/h30SKmb+U+HnuwSRiGOIWC62ZttM228rEOIUmfnXYAlNibwHxramTW0aFv
	n//g1ukf93JAeIfmaGsp7kktWythK4+yjb2FbICU=
Received: by mx.zohomail.com with SMTPS id 1786976991076117.6855924745521;
	Mon, 17 Aug 2026 07:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 22:29:42 +0800
Message-Id: <DKRAH0LTEIJ8.IFPZCP0258SM@pigmoral.tech>
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Guo Ren" <guoren@kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Cc: <dlan@kernel.org>, <devicetree@vger.kernel.org>,
 <spacemit@lists.linux.dev>, <junhui.liu@pigmoral.tech>,
 <stable@vger.kernel.org>, "Guodong Xu" <docular.xu@gmail.com>
Subject: Re: [PATCH V2] riscv: dts: spacemit: k3: fix IMSIC num-guest-ids
X-Mailer: aerc 0.21.0
References: <20260817033038.2286436-1-guoren@kernel.org>
In-Reply-To: <20260817033038.2286436-1-guoren@kernel.org>
X-ZohoMailClient: External

Hi Guo,

On Mon Aug 17, 2026 at 11:30 AM CST, Guo Ren wrote:
> From: "GUO Ren (XuanTie)" <guoren@kernel.org>
>
> The initial K3 device tree used generic/placeholder values for the
> IMSIC guest configuration:
>
>   riscv,num-guest-ids    =3D <511>;
>
> According to the SpacemiT K3 User Manual this values is incorrect
> for the X100 cores:
>
>  - Advanced Interrupt Architecture (AIA):
>     - M-mode MSI: 512
>     - S-mode MSI: 512
>     - VS-mode MSI: 64
>
> Therefore, S-mode IMSIC (simsic) needs num-guest-ids =3D 63.
>
> Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K3 So=
C")
> Cc: stable@vger.kernel.org
> Cc: Guodong Xu <docular.xu@gmail.com>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>

Reviewed-by: Junhui Liu <junhui.liu@pigmoral.tech>

--=20
Best regards,
Junhui Liu
