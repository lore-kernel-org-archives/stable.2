Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177354968E2;
	Wed,  2 Sep 2026 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374338; cv=none; b=HS8APc8dlNqdd3dC7iEHHZC0PrkChAG7uELqRMZI3IGMgObtNm3jy3BYaigMP+0gLpRdzK8+XdDM8l17I1tFPBo1z3i1zTkuycGC5kjAHffjzci5C5Vzy2JR9jT8JMq2Po6W4N5vmX4V1mxZ4OFgVtcmFNdiAICxELyN+GhDFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374338; c=relaxed/simple;
	bh=o+O3FKFxIRxAIl49fg3LlmAdatoHNv7qC2SOtdMUhus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5996BhUrTaeIeHVC33Mw6019R0MqZmsw3LeOuKffLaDQOACnI4HY5DuYNHoU9hZn8hXsesJqx71OWyBfABCHo0rx4g2ltuyIjvDJD+EWwYFA856GhDlN7sWqcWhMzppEVfv5CMRa5+Vm5TkaKuk9qO9toT2hzyCyk5Ud58fizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiXw6pLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiXw6pLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4200D1F000E9;
	Wed,  2 Sep 2026 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788374331;
	bh=ZSS2ZyNCJhfDvdNZCG2wo1aIo6vAs4ArlqXzhHgn+3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hiXw6pLxhNG9c+u9f+cZVoGUbPPqmElbFitCuj6yFGJoq5mvtU7Q27aoVgonJyH5b
	 CMSYiUOzWVTXpm84DAi/2BqP8djFMTU8DUZ/+6Sp9btS0EP5vZ9cwUSQgQtvDLaaVm
	 XyIMg8ZAa98HHTp5yrnVI/SkIU5e+cKF7SZPMDFCWsDgCiUs/kWaJEuvcMpQfSKHUF
	 VO1s4bdr/xZiIKlAsErvaDdRwNT9B5ArnLPqIJKMnoPYdhP3i8Y5PJclPC1MGPafkm
	 FeLW5u6QVJruyeZcA55CFGaCHBQjmbLuTzWlFqx72Ym3MwXkUQaTCx+zTLTRcdyemq
	 bbBEBBeUGJxPQ==
Date: Wed, 2 Sep 2026 11:38:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Frank Li <Frank.li@oss.nxp.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Yo'av Moshe <linux@yoavmoshe.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
Message-ID: <20260902183845.GA2669394@ax162>
References: <20260827194508.446733-1-linux@yoavmoshe.com>
 <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com>
 <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com>
 <CAKwvOdnA7Ej_uppSL7U2xwxyUQoDMvO+RArj4HCUSOziH0rCqA@mail.gmail.com>
 <CABCJKuezb0HtOcMBsObczS=HBaRvMszagkOZGHyOVbXBqtJi5g@mail.gmail.com>
 <2bd0c842-d0cb-4ad7-b3a3-fed2000dea83@yoavmoshe.com>
 <CABCJKudb5RegHcNPkXG5p1TcCFAe5_8+hqBP-2GyHVK19oB94g@mail.gmail.com>
 <CAKwvOd=OLLO5AXiR54o0nU16e_pTDt_yiEPQ0GgnX8DRGJXYmw@mail.gmail.com>
 <aphSYUS7xGJjj2gT@SMW015318>
 <CAKwvOdmG92SPOuMJka6KqODqObB0F8YJ6NhpEj7eisv-ZK+GXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmG92SPOuMJka6KqODqObB0F8YJ6NhpEj7eisv-ZK+GXQ@mail.gmail.com>

On Wed, Sep 02, 2026 at 10:10:23AM -0700, Nick Desaulniers wrote:
> It does depend on
> https://lore.kernel.org/lkml/20260604-tracing-fix-cfi-h-build-error-v1-1-b27015390901@kernel.org/
> though, so you might need to coordinate your PRs to Linus with Nathan.
> Nathan, is https://lore.kernel.org/lkml/20260604-tracing-fix-cfi-h-build-error-v1-1-b27015390901@kernel.org/
> going via kbuild tree or what?

That change is already in mainline as commit 979c294509f9 ("cfi: Include
uaccess.h for get_kernel_nofault"), so there should be nothing for
upstream maintainers to worry about. If this patch needs to go back to
stable past 6.18, then that change will need to be included with it.

-- 
Cheers,
Nathan
