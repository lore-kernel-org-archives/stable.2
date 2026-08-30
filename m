Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B13BB674;
	Sun, 30 Aug 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788107103; cv=pass; b=KlbUr/k/433pvX91+d1NLiElkrxI3vHVlItdu/0QImU4oxBPk2xzXOP1+DaxaqjagVpTV5r+Q4pP6MsNAMzAl1e0GCIvTvFQ4dT68zxAGMx8TjdiRLqa2S4ACmfvlzuDpwRsX0KkzmPCrvYhF2VXfQFkIQNDYIOSlv6a17Co9eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788107103; c=relaxed/simple;
	bh=GmBfcRy0uBNjSyTd3QM14EIKLu45BjfLWEcmRo1I9Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LB9/3y9+WMh+8eHOLFS3gYwv0wQxXJhxW74G2rabbCNj69fcY2CvvlTxDJX+zTKz70BDQgJ3EXyJ0XCvs7u9rt6AgVKv2eQB3PuyQLyj7Ivl0l+iE+neIKZ5rALqQMUDrULD9Kp08Roh67F/SdeLNkxWWX8PvgbSVgTSt+f1N4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com; spf=pass smtp.mailfrom=yoavmoshe.com; dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b=DeGxx07c; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b="DeGxx07c"
ARC-Seal: i=1; a=rsa-sha256; t=1788107074; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XdGy/sr3rnNAf8bb96XvAwHAREUe3cxNcki7E02MDYhicdhOLJ282kjyglQU+XtaWx5TA06MqCm0wk7Q0B/d2OACuwrtYX2cfKlOiSYW9pL9vuP1peRUvK0dpoN34aYQocCRn9dlVG58C9u7MkgUbTiyOBHpI3Nl6NXJxKoozbI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788107074; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GmBfcRy0uBNjSyTd3QM14EIKLu45BjfLWEcmRo1I9Ms=; 
	b=cjG7BqArSc+oKGncPM+El5jlT03vBF0aMBJG76ONkzviNZ3SramFZHixGtyGtn3WB42lUMyzNueS+mqXEaqBgq5/+5k/2D3ICbkN2HrgX8PeOCK+2aDt8W08potEuvX1myhZOMnymnLmtSGCvM/l+tqwL43601NJHGkqUUnnYKY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yoavmoshe.com;
	spf=pass  smtp.mailfrom=linux@yoavmoshe.com;
	dmarc=pass header.from=<linux@yoavmoshe.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788107074;
	s=zoho; d=yoavmoshe.com; i=linux@yoavmoshe.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GmBfcRy0uBNjSyTd3QM14EIKLu45BjfLWEcmRo1I9Ms=;
	b=DeGxx07cvLm+imNF4WG1+C4HClXhhNxqAZhzUxJm29XeW/VnL+KUtXpFXAq+lb2P
	YhkAfbUlBj5xvj30g56/9yaKf9TRPHd7vKY8VlA2E61PA1A26xArZAM6EfUgFPgj2wb
	3C+vm/GzQAb6jackRPdpQpYV2fyZ7JSO6/uL+bKU=
Received: by mx.zohomail.com with SMTPS id 178810707135525.803322459182027;
	Sun, 30 Aug 2026 09:24:31 -0700 (PDT)
Message-ID: <2bd0c842-d0cb-4ad7-b3a3-fed2000dea83@yoavmoshe.com>
Date: Sun, 30 Aug 2026 18:24:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Sami Tolvanen <samitolvanen@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>
Cc: Yo'av Moshe <linux@yoavmoshe.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 llvm@lists.linux.dev, stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260718111340.159896-1-linux@yoavmoshe.com>
 <20260827194508.446733-1-linux@yoavmoshe.com>
 <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com>
 <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com>
 <CAKwvOdnA7Ej_uppSL7U2xwxyUQoDMvO+RArj4HCUSOziH0rCqA@mail.gmail.com>
 <CABCJKuezb0HtOcMBsObczS=HBaRvMszagkOZGHyOVbXBqtJi5g@mail.gmail.com>
Content-Language: en-GB, sv-SE
From: Yo'av Moshe <linux@yoavmoshe.com>
In-Reply-To: <CABCJKuezb0HtOcMBsObczS=HBaRvMszagkOZGHyOVbXBqtJi5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2026-08-28 10:50 PM, Sami Tolvanen wrote:
> Looks reasonable, but this still feels ARM-specific to me. How about
> adding the macro to arch/arm/include/asm/linkage.h unless you have
> other users in mind?
I've now sent a v5 with Nick's macro added to
arch/arm/include/asm/linkage.h as you suggested, plus the other fixes
Nick asked for:

https://lore.kernel.org/all/20260830155100.1020620-1-linux@yoavmoshe.com/

The sashiko-bot's comment on v5 indeed pointed out that imx5, at91 and
omap1 might suffer from the same bug: their suspend routines are also
fncpy()'d into SRAM without a type hash and called indirectly. They're
all ARM, so asm/linkage.h still seems like the right place for the
macro.

Do you think these need to be fixed as part of this patch, or as
follow-ups? I only have my one imx6 device (a Kobo Clara HD), so I'm not
sure how to test the fixes for the others.

Yo'av
