Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CF3B442F
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389981; cv=none; b=lVV/IbD0nZe/p0jf30D+rN0QD0tcab+3ZhRpuiVeSwF8c+xrQ8c8kH9G4l0MO+WPO2LEjgZYp6Kd1gIunNsOiYsg/DuC+6ZS1Lmr2JYfjeHxYsMUarOXFxgiCfI2tDYhHdrcxCyjpZKG3Z2VKhIYTSMld25i4pobnARLRlDw3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389981; c=relaxed/simple;
	bh=AGZwW4rJfV+3Jgi6TsQvRI9xODW9i1jtyOVPpMKaweM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf6rmBB2/Wycguyl+5XCOGZPklLMWbVaFoJfySX6y65sUp1Nrh6ZdYpvdAs3vfVqr0ZCaeiWMZHFBOJuXshGugxwG59WZm7FtWo1VwZJEHlqSMQoEr11dkTQ7bb2BAvRchl+NiY5Zz0UO5M6tvR4ZEGvK1fI8mX6uu6s1dkTVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seanlyon.dev; spf=pass smtp.mailfrom=seanlyon.dev; dkim=pass (2048-bit key) header.d=seanlyon.dev header.i=@seanlyon.dev header.b=rzTZA+9P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMfdTDB2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seanlyon.dev header.i=@seanlyon.dev header.b="rzTZA+9P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMfdTDB2"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 339A9EC0139
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:06:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 19 Oct 2026 02:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seanlyon.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1792389979; x=1792476379; bh=skCSu7vCsP
	1jAvEBrU1FAT0EWBykKqwMlXtfcXHLl7g=; b=rzTZA+9PrWJSpoS7RK0PmeuMqD
	WiRGXZCDpi8fN3EXg1QsoDsY7Yo03+n4Op2nW9XPMkSe9nGXE1232hTjOY0FZUXn
	GQdNy/ar8p7nZt8Za/s/fkrmo+qJonIcbpDq+crB/rBwCK68ziA/C1T27JP9TZAb
	GiQJIZ9E/BRQZW7h+x3D6ZzpMTJTL7w0VmnAX0R5l36G8kOow1Pf+qJi65a+a7fp
	KofYNNn2hHKxEa2Itp3Qt50PSzuLoAOy3Rq/Ynub2eRncLEKT49vv0wiPh/ehSnJ
	KoJ3ip9BqN3kOkkJ4rhKPvgFhYsqKsaK1CWSCtB6EnY0Bq7wM0GWeRpSjnvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792389979; x=1792476379; bh=skCSu7vCsP1jAvEBrU1FAT0EWBykKqwMlXt
	fcXHLl7g=; b=XMfdTDB2JGLtTMrNiBLYIkhEIfTJw9Xf958WtG0u5IavH65166k
	zD13oEC+GGTZ0LDQRr5iRQbC+1WF0x/uR4r1p1jqmY35LhzlNwhaJC+cW9JOYNUp
	UkMIywimvjBXk1/AFeIzZSCY7aww/2wsRo/4mTLyrxzC6rgjF+NJBKRxV0tJ1sDd
	OdOgpCvkJBhvcrVxDu9XITLsTrkLL029V72SKypmsqFG3IM93r+8E/KlESvnDIlQ
	UWXt1DpLCqwX571dDC9cOoU4+3KgQdJl2ZUsBEC3/a52DB3CHTrIsfLJe4Cemu8f
	+mfToQzex7YRrfIwjywbXs7Zt6jXIBOcoKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=seanlyon.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792389979; d=seanlyon.dev;
	mf=PHNlYW5Ac2Vhbmx5b24uZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:jvHcfWt38bXKDNNSmeo4gmyTZJkH7TAle58zhhLPEzA3h2w
	ELj2r3N2efWOYiftLeLFtzOe/UO1YzDHAb9gSPbfF2IONfho22wsAWV4bymmnTpf
	3WZFCKuSkWdLmmg8aQuFagvR7XEcIpmJpEhQN/ALK341Mn2laNjBXEbID3uNUH0Z
	kLFw/O668a8mfVl1zJoRWQ5qw+iSbhsdEy651WnKRTeRyQqY2mhFZwggZE3JSbDZ
	VoD1FPJ+ifah/4Ljb8LlrCLxp8wO7N6GLeNDqGiI14DSLwzmWGbcH/807Huf/fA+
	bMzYLHwqOIyAozDwOhtQI2lflcZMqiPeNClFBlA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RzE7BBSI4URxbarKubWmUC8KRp6/fqCeHsfWtq56+lk=:AGZwW4rJfV+3Jgi6TsQvRI9xODW9i1jtyOVPpMKaweM=;
X-ME-Sender: <xms:WrPVal6mOY3rSg81sT0-A9NSdZ7jgsZOuKOniukXHK8ok3LxSYDqIw>
    <xme:WrPVauyYr6t__PEoVFJuvOlnV9tdQV477dvyrqxkdKHnqau8Dp2U45oC-afzIzJKr
    NmLh9fXEfURSq2fNBzghjpKmrsETITS-Elzyo9ZH3bPYzxMoO4vkCZV>
X-ME-Received: <xmr:WrPVan8LzIf26vZzEPfK04GwEDvxJLlpVrrvSDuoy5mm8nCzCOOvK7mFY6lixPhc17VB6mPuy983biGP9xBuKhyTMvc>
X-ME-Proxy-Cause: dmFkZTE+hzeJAZQnGrgLhmSW9gh/tQXt9DaFejGM570UW0kAlfkbKUO/i4O0N5sEnRhUhq
    6/YaxA5ux0CJfN5JfG3K0/FCNnt3PuSbFKfF62ypE+ZI4Vw0iL7W8Gl4s0awi35f/5rhmQ
    tA6DJ53sxwc9wDhkCoXVtR5SY84HXgmRKi3r0lMtCLHGbpiDtF9BEn66ulkg8komwp+QuK
    p9E0a+6botTksQxdE9E230skmR3By5GWLKYHAMMfTvIciY9IdGkiSfGWDnWNS32hE13qvn
    yExIF4LQxpmlqUM2w/QiMpY06JA63uTXp1XmC7xz+lH1p5sRf01m2uU0m1b/1hQvaFNJfP
    5XpJnRszuH+3xzNUd/8MZdpnggzhYsXPRzcNLVO9RCk5QhIOCTJUQgV+9xRuwsi3opYP0X
    rHi3lRSMDgnFMtAO7Dtn0e+gxYgPqsvkw9Zy9mLe2xVBO5LebTEyHujEngdRh8Ps599slf
    1bIqq9g4/JuKWzBUll3lVfl/oxAgmmhYDsREljwwIQmx0/z+hmoj7yUQPXuLA6am8h6bxf
    6GJ5UXSKCF0CW/P54/KODmi/M76VxRuN999PN9+w93adwvwJwSUj6lMmyLnNKt9/xvpD2P
    HMPnyW4yFyof0eNsQZKBWIMoRjgJMGYS3PgQJtS+Ac4Iw41vFuHuNhsKgcdw
X-ME-Proxy: <xmx:WrPVaiHpuzLG227CRr3P0zbUh891oShNjaV8Wdoc_WAS-zjRILvWTw>
    <xmx:WrPVahCiTXHzweTDrTNF4z2JVny8Uzut_301Oxq8Yjg9ZtTU2fQn3A>
    <xmx:WrPVamn3wwQ1miiZf4EzWcDZ0FGG5rLcZG71KWyNuS-WmAujs8rdHw>
    <xmx:WrPVakTPTkSnmhrsj-xYZVIORCGNjjUqE0CyCaU0XGDM-nMQ6WCNaA>
    <xmx:W7PVarN7iuc--8U8c0KlmpBZGL80sD93cX0u_ct7Di0G5MWgIccONjf1>
Feedback-ID: i07c64b5b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:06:18 -0400 (EDT)
Date: Mon, 19 Oct 2026 02:06:17 -0400
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
Subject: Re: [PATCH 7.2 00/10] 7.2.12-rc1 review
Message-ID: <atWzWVLwz3JlH5iy@ncase>
References: <20261017155059.698368299@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017155059.698368299@linuxfoundation.org>

On Sat, Oct 17, 2026 at 05:54:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.12 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built, booted, and tested on hardware for x86_64:

- AMD Ryzen 9 5900X, Nvidia RTX 3080 (nouveau)

No regressions found.

Tested-by: Sean Lyon <sean@seanlyon.dev>

Thanks!
Sean
