Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646848;
	b=Lw9g9uCjUTOPJg1yGZCv3iSHaPd3Svb0vXcWfSyEAr5b1wy8/fZJdP3cQRM0THM4taRG
	 3Hnyl719l3uOaWpapH6Qi2VlCwk0XWK3GkKe/Aun05gvumepu0nwlFLKIVGfyFtd/85qM
	 JFJM0XBIhJBWHMoexx8N+ae1w9R22zksjV7Vn3SUEEo8bu1XqGLuxooN4K5AbSg5bBTwr
	 M28DC6+kRIjfOxt7VTyXlX+RXGz19OQlKGodoEeQXTiRDUa31fAkphD+fQHtLwL0FxaEE
	 EPyXnfZGn6SYiezO4KGOqFjnMpR1uGcyK/Y4zuIxoOYGDXDs2KDp3uYHJxg3cro3wLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646848;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=s2e7rhOdqB7ux1alseBahOqoYTov3xDVLS0bIJyRYu0=;
	b=JIMOQuBvtAvFaiV/lYGEWQzKFPxqIjPTK1VrcJ6L5+1YPVLDluUdEM1oZmioHPHnor+e
	 zOfQs0duuG0LlUI2tehMxtwjC5q8s54ftYGYAgwsSqRpa5iK60TvGymWc1JzZZe3gn0FO
	 v1G2aErb0yY09ZHbk8C2FmVkkdmPKpi9zgPvQ5YwvC3DWSNZmSvO9+yGEZja5nYpwVC8f
	 M9sMfcdl1v7HdR3Z/HXrahvBuG7dYQ8JSn0zIurauFPh/XPlFjYeJg1WrjS26Xl8tgGxS
	 XyW8Drq1H2xw7QSEqtZcyBO+whUZ5cIh166e2B21NxCT3y+mkWp5uKgLQ4CUnOI4pGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=IDdfODWA;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98754606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98754606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=IDdfODWA
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261102191404euoutp02d853d3db9b5a6fe7150809ec084dd9da~kUE1EXMfh3082830828euoutp02F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:14:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261102191404euoutp02d853d3db9b5a6fe7150809ec084dd9da~kUE1EXMfh3082830828euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793646844;
	bh=s2e7rhOdqB7ux1alseBahOqoYTov3xDVLS0bIJyRYu0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=IDdfODWA9YvYANVuwxFWdiih5hEGTdWMuYui9lTZYzfL2x5YdYnD+xy8ZYVpVr7rm
	 uORYJfOt7+ALFxDN5DkexOLuMdzOuZO2WZxmw5dEKItqmMl+AL2JMjlTWPBSvre5xR
	 oWBuNjbRfG8KMDTLi48jUo4DxVGHZ4lbbAT26sbs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261102191403eucas1p143816f92365b447ec95071d46346e3d6~kUE0nHbmq2938329383eucas1p1Q;
	Mon,  2 Nov 2026 19:14:03 +0000 (GMT)
Received: from AMDN5751 (unknown [106.210.134.141]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20261102191403eusmtip1f42027cdbbe547c1d58e82c8ae5ad0d7~kUE0IlKdS2525825258eusmtip1r;
	Mon,  2 Nov 2026 19:14:03 +0000 (GMT)
From: "Sylwester Nawrocki" <s.nawrocki@samsung.com>
To: "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
	<linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>
Cc: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Chanwoo Choi'"
	<cw00.choi@samsung.com>, "'Peter Griffin'" <peter.griffin@linaro.org>,
	"'Alim	Akhtar'" <alim.akhtar@samsung.com>, "'Stephen Boyd'"
	<sboyd@kernel.org>, "'Brian	Masney'" <bmasney+clk@redhat.com>, "'Jerome
 Brunet'" <jbrunet+clk@baylibre.com>, "'Henrik Grimler'" <henrik@grimler.se>,
	<stable@vger.kernel.org>
In-Reply-To: <20261030075325.517182-2-m.szyprowski@samsung.com>
Subject: RE: [PATCH v3 1/3] clk: samsung: exynos-audss: Propagate
 -EPROBE_DEFER from input clocks
Date: Mon, 2 Nov 2026 20:14:03 +0100
Message-ID: <000001dd6afe$5302e900$f908bb00$@samsung.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKpVTperXi7BFRv9rlREf4hmhkl4wFbmI8MAoPLQMe1ZFafoA==
Content-Language: pl
X-CMS-MailID: 20261102191403eucas1p143816f92365b447ec95071d46346e3d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261030075333eucas1p21e27f19273b7e71c53d6ef620e52bf55
X-EPHeader: CA
X-CMS-RootMailID: 20261030075333eucas1p21e27f19273b7e71c53d6ef620e52bf55
References: <20261030075325.517182-1-m.szyprowski@samsung.com>
	<CGME20261030075333eucas1p21e27f19273b7e71c53d6ef620e52bf55@eucas1p2.samsung.com>
	<20261030075325.517182-2-m.szyprowski@samsung.com>

> -----Original Message-----
> From: Marek Szyprowski <m.szyprowski=40samsung.com>
> Sent: pi=C4=85tek,=2030=20pa=C5=BAdziernika=202026=2008:53=0D=0A>=20To:=
=20linux-samsung-soc=40vger.kernel.org;=20linux-clk=40vger.kernel.org=0D=0A=
>=20Cc:=20Marek=20Szyprowski=20<m.szyprowski=40samsung.com>;=20Krzysztof=20=
Kozlowski=0D=0A>=20<krzk=40kernel.org>;=20Sylwester=20Nawrocki=20<s.nawrock=
i=40samsung.com>;=20Chanwoo=0D=0A>=20Choi=20<cw00.choi=40samsung.com>;=20Pe=
ter=20Griffin=20<peter.griffin=40linaro.org>;=20Alim=0D=0A>=20Akhtar=20<ali=
m.akhtar=40samsung.com>;=20Stephen=20Boyd=20<sboyd=40kernel.org>;=20Brian=
=0D=0A>=20Masney=20<bmasney+clk=40redhat.com>;=20Jerome=20Brunet=0D=0A>=20<=
jbrunet+clk=40baylibre.com>;=20Henrik=20Grimler=20<henrik=40grimler.se>;=0D=
=0A>=20stable=40vger.kernel.org=0D=0A>=20Subject:=20=5BPATCH=20v3=201/3=5D=
=20clk:=20samsung:=20exynos-audss:=20Propagate=20-EPROBE_DEFER=0D=0A>=20fro=
m=20input=20clocks=0D=0A>=20=0D=0A>=20exynos_audss_clk_probe()=20fetches=20=
the=20optional=20pll_ref/pll_in/cdclk/=0D=0A>=20sclk_audio/sclk_pcm_in=20in=
put=20clocks=20with=20devm_clk_get()=20and=20only=0D=0A>=20checks=20IS_ERR(=
)=20before=20falling=20back=20to=20a=20default=20parent=20clock=20name.=0D=
=0A>=20This=20means=20a=20transient=20-EPROBE_DEFER=20(e.g.=20because=20the=
=20clock=20provider=0D=0A>=20behind=20=22pll_in=22=20has=20not=20registered=
=20its=20real=20clock=20yet)=20is=20silently=0D=0A>=20treated=20the=20same=
=20as=20the=20clock=20simply=20not=20being=20present,=20so=20the=0D=0A>=20m=
out_audss/mout_i2s=20muxes=20get=20permanently=20registered=20with=20the=20=
wrong=0D=0A>=20parent=20name.=0D=0A>=20=0D=0A>=20Fix=20this=20by=20checking=
=20for=20-EPROBE_DEFER=20on=20each=20of=20these=20clocks=20right=0D=0A>=20a=
fter=20fetching=20them,=20before=20anything=20is=20registered,=20and=20bail=
ing=20out=0D=0A>=20of=20probe=20so=20it=20gets=20retried=20once=20the=20rea=
l=20clocks=20are=20available.=0D=0A>=20=0D=0A>=20Fixes:=20547f33509ccc=20(=
=22clk:=20exynos-audss:=20allow=20input=20clocks=20to=20be=20specified=20in=
=0D=0A>=20device=20tree=22)=0D=0A>=20Cc:=20stable=40vger.kernel.org=0D=0A>=
=20Signed-off-by:=20Marek=20Szyprowski=20<m.szyprowski=40samsung.com>=0D=0A=
=0D=0AReviewed-by:=20Sylwester=20Nawrocki=20<s.nawrocki=40samsung.com>=0D=
=0A=0D=0A
