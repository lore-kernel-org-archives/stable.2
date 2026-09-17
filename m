Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203AC4BB26D;
	Thu, 17 Sep 2026 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643740; cv=none; b=e+/mrqQ/k7uc07dDBc3haBljaS+0u6bAztCoeRNUTX1ddjHpwc1mKMbSbEpZWTC46bK5QgYP6RemtcWN4DuDLlo+44m7Qsg178XFPFy6BC18zD5eTS+aTxrPT/Z75expCGpv+IyILNpsU7wsCfoey3zPOMD3XcPoUMb5kFo+xFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643740; c=relaxed/simple;
	bh=s6JLaKIpJHfSw6tJIYCGWUMDmPnQK3gLe1l887AEFbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eue9i5ryZnkPQ2HOPOqDotiQ4Mys2oD/aRuDh3CoMVQMqRjwTF1nNA/F84lTdQ9K+7xo0OIfRgTIAbbkm5WWZgbi4LqEWM7phj1NjFA3/9b4JROBBz1Sw2jyJGw87EqjshkGgPuePd4lEmd54wZobfsvk1VKXPW7arPmH2VrM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=GwEHIHeI; arc=none smtp.client-ip=188.68.61.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="GwEHIHeI"
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4hltK458JLz78Lb;
	Thu, 17 Sep 2026 13:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789643288;
	bh=s6JLaKIpJHfSw6tJIYCGWUMDmPnQK3gLe1l887AEFbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GwEHIHeINfVJYeWge68Jh6ImmWDsr9UN4ZWKb83TYYSp5KUlAlwiIwfYGUGrb7zQs
	 4DfVUo0bMi/IkBTdUOkXYTedcwSrUv5aNLbflagY0NYLjagoeLkQ/M54PK5Ie8Rg/1
	 PBYyAyVPwgSAmWmIhtjAQA3io19iLtOHNDwArwu4PBixjLNNP6CsASUfY/Akozx+M5
	 GxV1ic1Ncsm409yGEZPPDOrETPwMFeLiRUZTl7v+vEZXM3oAlMdXNLBjjdgVmjVevd
	 XRWntb2WMv0q1xnC5YvH49m64iTkyM1ApKN1sr2uIgbD/XUuzj63P2j6dsyO6guU++
	 +PtiWy0SC0EBg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4hltK44Q0Bz77bD;
	Thu, 17 Sep 2026 13:08:08 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hltK14fFFz8sbH;
	Thu, 17 Sep 2026 13:08:05 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 42AB85F936;
	Thu, 17 Sep 2026 13:08:04 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <7ed9e4de-2e57-4c15-875c-16512f00163f@leemhuis.info>
Date: Thu, 17 Sep 2026 13:08:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: imx6: Move clock enable after core reset
 assertion
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 leoreis.costa@gmail.com, fra.schnyder@gmail.com, francesco@dolcini.it,
 frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260813095003.356062-1-hongxing.zhu@oss.nxp.com>
 <178835852653.83808.12038237867062064510.b4-ty@b4>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <178835852653.83808.12038237867062064510.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178964328505.1084770.8025952656757850710@mxe9fb.netcup.net>
X-NC-CID: pLA65dobhYpQq9Ud69Psw9ByXz+UBnTvrXYVrT91lPvHENB8w9I=

On 9/2/26 16:15, Manivannan Sadhasivam wrote:
> 
> On Thu, 13 Aug 2026 17:50:03 +0800, hongxing.zhu@oss.nxp.com wrote:
>> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
>> inadvertently moved clock enablement before core reset assertion, breaking
>> PCI device initialization on i.MX6Q Apalis platforms with
>> ASM1061/ASM1062 SATA controllers connected.
>>
>> NOTE: It is not 100% clear if the issue is specific to the ASM1061/ASM1062
>> device or on the specific power-up sequence (reset vs cold-power-on).
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] PCI: imx6: Move clock enable after core reset assertion
>       commit: 16929741a622eb345057e41c7b335d9b297890e1
Thx Mani.

Mani, Bjorn, what's the status of this patch? Is it heading to mainline
any time soon? This (unless I got confused, which is possible!) afaics
fixes a 7.2 regression that annoyed quite a few people -- which is why
it was even briefly considered to revert about a Dozent changes shortly
before the 7.2 final:
https://lore.kernel.org/all/20260811214900.GA763236@bhelgaas/

Didn't come to this, but it afaics would be good to finally resolve
this. Or am I missing/confused something?

Ciao, Thorsten
