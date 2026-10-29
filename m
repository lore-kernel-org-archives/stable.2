Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312826;
	b=Xbyg3J/xeOHI+xeltgTUlCaOxJ45ClcQV5vCOQQgqu/pW9pCpqRfcZezQO9xBnwwJado
	 rxOALt4/x6XO6oQ6rX932IEbIQ8jdAuzRqysTjZTDgdUQQIVVZWwVK9O0NyWKOX+RZgYg
	 B2ERYaAXB0MRYg0t/56uBvaq86SfGIlxOpqjRq7jp0rKZFQrQeQmKi7RuE1owm43QAdiZ
	 LjoZl6qKJO3kgEcKPqEnLpZkhXsZ2K5Tf2YKBUW4mwAO/TMdrUel0NGDQKixuhMPArFDn
	 zswF+ClmFQQOmMfoVfCke0qYxKxk+v9+z3ILx0M2SOpmYNBKlleBIIqPa/XsYVph+Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312826;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=c+qvZDVoKntvP031zXBxbTK1eyYefVpFxx/OJ0wzL5U=;
	b=DOr59tU5vfSIIvChGMARYglnM4dToyALuG/nokQ7cVHMmwqze6Hwri1qRrXPp0UrCu/K
	 ShCdfMbBl7nQiDYDF78Vv++0QAelYhPKIpFFgQ4HaJk0CbG+2fE2Vhb3HwF5/kOJmoKmj
	 nc7idRuuRHdUpY2VDxpdB/ol0ELxL5RLQa0VzAVMffbUhevTEjQBgCSjbU3SxLCaYef27
	 PwMB0huo+QCRSxUYLjYJPE6TDXTD4NME5DXe66o932l2YHIWduTSVR7YGaaXkcJATzpeo
	 DgkEEfoFjCWHO7MPN+YNhENrk/ONZPm58J22gvAfPTM+XllIFCBTXNuTJSJMuXmbqEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=seanlyon.dev;
	spf=pass smtp.mailfrom=seanlyon.dev;
	dkim=pass header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b="RLei1BP/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kZdMwoHV;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A1606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 518A1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b=RLei1BP/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kZdMwoHV
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F696EC0191
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:27:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 18:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seanlyon.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793312825; x=1793399225; bh=c+qvZDVoKn
	tvP031zXBxbTK1eyYefVpFxx/OJ0wzL5U=; b=RLei1BP/l/szFUnHUPMIq2KwaS
	Di+6WNliRtMn/zcOlhE2sw1g7W+IPgwFDKwMMEeHw0iwswKyQd3AmFtoGbYZWp4c
	WVCqhnkphsZIP/Hy3luhcQs9EwiHsF2HIZGhTN1qNq0H6WtPNjLwiTaosa4JAwxG
	DKyRTVyJz6AHOVWT4QZNoIlbE6r6O71SvTDJIM2RIydOWO+/qPyoMxEeTv+ahI6j
	da86/rpMObiVqy3b6rlOAx/9wXBVEh+v0Yy6aWwhD1ZKKTOLMwK+ehM6UdPVOlQS
	SeAji8sUgksK/xhZi9xCLItZwZOv9okrMXHO3r6JHoH88I8tf6wNd5luCy+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793312825; x=1793399225; bh=c+qvZDVoKntvP031zXBxbTK1eyYefVpFxx/
	OJ0wzL5U=; b=kZdMwoHVTwsn0veaKmuVGLB9WSezqvpk8D4GG9S+6pa6sywB4dm
	/2zSo8+FACUAKHg3PRkoFjWXaOkvTks6UrW3l4poh+BDRXDDE/Oa2xQM4rZa3FR+
	Asvc1YliHSWpDky/ddREVVSzHhdMhDFWyMSaKZW5XRoTzuKJc7frSxMmpRhH0jrq
	Ifm/MjTCL5LHUciyS7H54Rg2gryRPhEta0pNzrksrq/grDgtSAOQbFyw4Roo6lf0
	91PMMRN3YigRW/6SByWSjoK1RLgydK8N5DujiVGqdgIVFYIIUiNWp0RRE02gC7ds
	rkOwmO01GCdPqWnMzQzwZAbfaxneUz02iZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=seanlyon.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793312825; d=seanlyon.dev;
	mf=PHNlYW5Ac2Vhbmx5b24uZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Q0yW73HT2k4xhZZN60wAwbWhA9KRIIDchK3je0yMZOk5kHa
	k2cBctE4mzuWorvr9gj+TvtCu1ZLtXzD6mdIENSW7MVxO9ZOlgrtySl7enSanEkR
	9naO/CS7VweutD/z15OKIBhF9UM0vANoYWM3z+CdFbCt9bkN82H7b9b7Bpj3Hhz/
	DBQY7dPrbNAw3VPth2tnpdc0fXyyDCDalme+KlpQHErHZGwv6brVT2KfIPlTkdGn
	9cY7flXr3i3t76MQrvG1168Suo26EL6u8zyDsM0kus/lkjP6vlbB8GF4f2nVrYr5
	c700EVXN8z/RMTu5hLKP90V/4kRNzKsFZSyC7dQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KvBfcCEepGgQCubxIEetBiWso0zJricPoQ92z5Q5vEY=:lbADKVHdEahGZKvvXkqmKVF9EHRzpIvUPrlJlpRUdJU=;
X-ME-Sender: <xms:OcjjavXoYbRC5ReY17VGGF0BO1sz3F1hlY9fjTANsxJ9-KD_3Jacww>
    <xme:Ocjjajed29hfF-9WSxvkT-SgiOI3JZvG4Ju5WOS6JkAwFW1sIkqsbo9_-dRWPcoSw
    W3fzvQ5aLBaVXuckmWFwVUGUrKG9NUrZTyRPR2FFXzfG__6Dx4K9Vc>
X-ME-Received: <xmr:Ocjjam5BiU51VdPCCUeoVLIzIbKfz-H5cjtsr46v_8hH-Gq-RHLRvLWdg-ckEkQVuwn_55pyjrHpviZknA_ReSz-UB4>
X-ME-Proxy-Cause: dmFkZTF5//9darI5cdAP9cgOMZ9g5DzAEkTMytA9leshKDo+hCJHoq5xa0eca5YBSLUe2D
    booja4g9cXkeaxOSVMy7rVqCAzQ6dCku7PUvgrp5uQymaKYXBYIx1AUNs9rIptHDQVlEmv
    Ip0JmzyHuGvc2wiAN69PNfDc9kCjf6A+1v04h4hA3sMt4t7qR+FGl3iVJCJls2orKWb7kV
    6sD3te5KHHQxh/TypaHsyYZu9+pHHeuDjxhYtOvvtKCZdcGxgcS2ngFzCDuttiMl4JyfEz
    1W2B5qY98cJESz2ByAENSn35XqVnBmI//It5PdG/W/T5dq9pPu6FY0Rb2B69pI5miZOYkW
    bSdZ3cI2yCCwlqySo+0JHNTI+teP06l7UhwE6jiDiN6spqsWMiyfCN6GWDd22NBfPg1ViY
    PltAom86eH1qbiRpOkR9VKsA9VPv1OGVWubZxstfflohr3fvfg1AVj/zMqcbT7VRP1Ialw
    CEJaUlvblfGoXJeS2UP2N212P06J3e6hqASolf777lC16rYnY6PMOCYGCofSdg9IN6MIC4
    pyTQSuyypSzebGljCGWXwz81TWOplrcXCRsG7r0hM8i5QSniQoQARGp+CSEbjCZZEPqfJQ
    C28twK7DYpHpMPimjl07Ww5eSXaRhK55S1Nu5PjVKHjvqM/FfOlfzMr0FVMQ
X-ME-Proxy: <xmx:OcjjauSZFMpaZMyB-bfMcdCjFR9e2sPcENRi5aWkFx3Zw700rhhycA>
    <xmx:OcjjahcXpJ4cM4Zy6HbvFeHn4-71fv1o-CJvUx58GOkqkDOcvedZuw>
    <xmx:OcjjamQVLPT7MjokE_rQbeY3onPm9-6JEyP-j788g1NozR-g_qOWog>
    <xmx:OcjjaiMV9wtx5OoFIDuA1_mwcn1iDYnyQZZCoonMJUug_OEQ2oeWuA>
    <xmx:OcjjajodCIYB15_t8wd0nJE_Iak_l0D45qipZXCmLyZFT9s48Ycv4IFy>
Feedback-ID: i07c64b5b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 18:27:03 -0400 (EDT)
Date: Thu, 29 Oct 2026 18:27:03 -0400
From: Sean Lyon <sean@seanlyon.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.2 00/88] 7.2.14-rc1 review
Message-ID: <auPINwnKN3lNnh8J@ncase>
References: <20261028165942.107695352@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028165942.107695352@linuxfoundation.org>

On Wed, Oct 28, 2026 at 05:59:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.14 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built, booted, and tested on hardware for x86_64:

- AMD Ryzen 9 5900X, Nvidia RTX 3080 (nouveau)

No regressions found.

Tested-by: Sean Lyon <sean@seanlyon.dev>

Thanks!
Sean
