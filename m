Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D864B66EA;
	Thu,  3 Sep 2026 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445483; cv=none; b=LgcaWSNsnY1J58NIdT7FSf1rG9PNccSY4wmnDkGvylXbi8PUkbORWNp+r5uJImTSvrvktIDrUtDW582xS1fGJSP1/ZubwJ71kQeFmyWXkISxGeAvqMhB59kkKYL07rZjQt613LvTz2v4t+06THYJKla0Ib/69tvSSOoSqOb/ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445483; c=relaxed/simple;
	bh=yFr4Dj2zK039tLCHyEAnaXuFZ0aOOs6XSDfsrCAx5fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2RPxlXAMNzsHmt4P363FMAN6u0uI+DOsycIdqCaYdFxArYlvf+VPOl+Vyov5sXzGwrWLbajnf1BrXBCREGQMkfQR/ZTEzfBiYZlPGYbFtdImT+8Vd16AR0yayMwlGqruIsdcpixiDjAp5oPMFnKDh/JWgKMDm2t7ZEKBNf/drY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=l4hUIQxx; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="l4hUIQxx"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4hbML94YWZz8q8X;
	Thu,  3 Sep 2026 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1788445473;
	bh=yFr4Dj2zK039tLCHyEAnaXuFZ0aOOs6XSDfsrCAx5fI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l4hUIQxxEC5UNYEvqTl4D2HiM0GE16SzQpJ5eIWx9PfDEjLoyJihbcnCta/gn+sI4
	 Rvi8DfWkjpHVvVHlp2CvbYOtXZVltUwG+KjrgEavEFtuzUj3/6h/nnKdcHIWg91elA
	 IQC9uxiGqSBpAYlvN+hea9N+yFfD9mAUg4mBb+NDFKHa5fugfYysrNTglyPnZN32ci
	 pI7aFajm8jkcaVvKDFvkAXStzVdJi3b6y2fxmvZTgiyV5DejCzNhVH3lD6K9SSdKEX
	 kieehG+hLi1mMEHzr9ros1mvhJNsjMX2Yz/ya0Qu79Ws86G6Al5QqLMwE6cFxQFO22
	 51+95eqybREDA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4hbML93sWBz8q8Q;
	Thu,  3 Sep 2026 14:24:33 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hbML70zjgz8tH0;
	Thu,  3 Sep 2026 16:24:31 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id CEDCB5FA2D;
	Thu,  3 Sep 2026 16:24:25 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4db878f3-1c55-4ecb-93d8-a97a5e0c7a29@leemhuis.info>
Date: Thu, 3 Sep 2026 16:24:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Fix BAR resize for devices on a root bus
To: lizf@honeycomb.io, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 Jon Nettleton <jon@solid-run.com>, Jon Nettleton <jon.nettleton@gmail.com>,
 Jacob Martin <jacob.martin@canonical.com>, stable@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
References: <20260731-pci-rebar-root-bus-v3-1-6732e233fc99@honeycomb.io>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260731-pci-rebar-root-bus-v3-1-6732e233fc99@honeycomb.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178844546639.4187522.4861224414337041204@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: CEDCB5FA2D
X-NC-CID: zORuCAgHZHstxjntIQgw+JFi+TKMTqleiG9N7o8t+oVYOsd+QW4=

On 7/31/26 19:34, Liz Fong-Jones via B4 Relay wrote:
> From: Liz Fong-Jones <lizf@honeycomb.io>
> 
> pci_do_resource_release_and_resize() releases the device BARs that
> share a bridge window with the BAR being resized, but when the device
> sits directly on a root bus (pdev->bus->self == NULL) it then skips
> resource assignment entirely and returns success, leaving the BARs it
> just released unassigned (IORESOURCE_UNSET).
>  [...]
> Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
> Cc: stable@vger.kernel.org
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596
Liz Fong-Jones: is this regression fix still needed with 7.3-rc1? I
assume so. But if it is, I guess it would be good to state that; maybe
reposting this might be even better, as I fear it might have fallen
through the cracks.

Ciao, Thorsten
