Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646875;
	b=fHYLwNqxc1rSnacx65L7cjw0nC835G98RGCrBpCZztAnK3JfB/dL85T+1hBOW8pBO4hd
	 1PGnv02HGpv6ny/1rpPPdfXtK+wr2ZEhWvMxc50rs4ECdkDQNVH4wYzUusYU75Bzxrivj
	 +fEA3pAhjpBlWeYOOkk5Z+VAkS07EcZ3m7uspOz38xN1cCXDD1dPbI46048ZmcYVdf9JP
	 6PYl3vzh5tdRkGPVn+wCsejwU0diDQg8oxrfGgAdaWwO1tM2ZViUASGGamDpEw/heW73B
	 +94DTzonuauwltRoOIhVnKuWWW5DIH1vTR8XsThrc3kKDmOlDjUpJuCpBHRY76L5fQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646875;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=K5vnM8YhB4kIhJqnDANi3dlcipt70T+QjZRu0IBl/g0=;
	b=TBcBEkMu4TPnc3Pa+OfidUJfooBBrsOppAJfRkMDZvaIBPTpUx3d3lhwy1SCl4H81fT0
	 Bei1s/nkFOo/ao77RLlLOBPtjUaU3MgTZykWjyomgEe1NhqwsDI7xzlDD05Dq8QNPkq2h
	 lGtmkiZstpfZzkOSbKZqqEAe9gxl1B9MdqWr6ySSYUfWAfEGYu865eShDqO+H/N/R/SLU
	 8+A6UMre+pLjhUxlkim2Tpg8mVz8cATtrJPBX6HWaUgRhABqRcnXZ799rUFDMHXeM8wvp
	 tUTftqjuiza2iq+xVrh/XjRW4552ajyL6vaLa30MZ8xhU2n3qNt3e9jThNOAuURbqhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=ekETOlMv;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE66606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE66606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=ekETOlMv
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261102191433euoutp02ad32ccd0b0514995948401c4d9c57b81~kUFP9Bvig0378703787euoutp02X
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:14:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261102191433euoutp02ad32ccd0b0514995948401c4d9c57b81~kUFP9Bvig0378703787euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793646873;
	bh=K5vnM8YhB4kIhJqnDANi3dlcipt70T+QjZRu0IBl/g0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ekETOlMvR9vpydy2eIaoNAz5KlfbKjyS86Myo14mxXMXqeTLQAJl8S9amQyADCe+u
	 vfc94yFZTJa57++NJUL8xlQanldvxSG/YlwhmY/YQBlr5yR686SdarpFEpLgTLSlWD
	 7+kpgZg1QKOkZzxGE3kt0rVBe00qN2+uHahtlee8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261102191432eucas1p256fd745ae052f1039f94f890a7b1456d~kUFPsNo2B1897418974eucas1p2t;
	Mon,  2 Nov 2026 19:14:32 +0000 (GMT)
Received: from AMDN5751 (unknown [106.210.134.141]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20261102191432eusmtip20a3287f66e83265d7cdaeb472b33180a~kUFPNnUSm0447204472eusmtip2_;
	Mon,  2 Nov 2026 19:14:32 +0000 (GMT)
From: "Sylwester Nawrocki" <s.nawrocki@samsung.com>
To: "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
	<linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>
Cc: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Chanwoo Choi'"
	<cw00.choi@samsung.com>, "'Peter Griffin'" <peter.griffin@linaro.org>,
	"'Alim	Akhtar'" <alim.akhtar@samsung.com>, "'Stephen Boyd'"
	<sboyd@kernel.org>, "'Brian	Masney'" <bmasney+clk@redhat.com>, "'Jerome
 Brunet'" <jbrunet+clk@baylibre.com>, "'Henrik Grimler'" <henrik@grimler.se>,
	<stable@vger.kernel.org>
In-Reply-To: <20261030075325.517182-3-m.szyprowski@samsung.com>
Subject: RE: [PATCH v3 2/3] clk: samsung: exynos5-subcmu: Use
 pm_runtime_get_sync() during probe
Date: Mon, 2 Nov 2026 20:14:32 +0100
Message-ID: <000101dd6afe$64582a80$2d087f80$@samsung.com>
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
Thread-Index: AQKpVTperXi7BFRv9rlREf4hmhkl4wHG2DCpAVSLecC1ancaoA==
Content-Language: pl
X-CMS-MailID: 20261102191432eucas1p256fd745ae052f1039f94f890a7b1456d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261030075334eucas1p14657a963949b4a32165d667f387a9389
X-EPHeader: CA
X-CMS-RootMailID: 20261030075334eucas1p14657a963949b4a32165d667f387a9389
References: <20261030075325.517182-1-m.szyprowski@samsung.com>
	<CGME20261030075334eucas1p14657a963949b4a32165d667f387a9389@eucas1p1.samsung.com>
	<20261030075325.517182-3-m.szyprowski@samsung.com>

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
=0A>=20stable=40vger.kernel.org=0D=0A>=20Subject:=20=5BPATCH=20v3=202/3=5D=
=20clk:=20samsung:=20exynos5-subcmu:=20Use=0D=0A>=20pm_runtime_get_sync()=
=20during=20probe=0D=0A>=20=0D=0A>=20The=20clocks=20are=20registered=20righ=
t=20after=20pm_runtime_get(),=20which=20only=0D=0A>=20schedules=20a=20resum=
e=20asynchronously=20and=20doesn't=20guarantee=20the=20device=20(and=0D=0A>=
=20its=20power=20domain)=20is=20active=20yet.=20Use=20pm_runtime_get_sync()=
=20to=20ensure=20the=0D=0A>=20power=20domain=20is=20really=20on=20while=20t=
he=20clock=20registers=20are=20accessed=20during=0D=0A>=20the=20registratio=
n.=0D=0A>=20=0D=0A>=20Fixes:=20b06a532bf1fa=20(=22clk:=20samsung:=20Add=20E=
xynos5=20sub-CMU=20clock=20driver=22)=0D=0A>=20Cc:=20stable=40vger.kernel.o=
rg=0D=0A>=20Signed-off-by:=20Marek=20Szyprowski=20<m.szyprowski=40samsung.c=
om>=0D=0A=0D=0AReviewed-by:=20Sylwester=20Nawrocki=20<s.nawrocki=40samsung.=
com>=0D=0A=0D=0A
