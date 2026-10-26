Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049570;
	b=Xs6UMHydfwhrDtMdwIPl2DZFazrF6GST6Vb6cCaUaksQuu0urJZMJlpnwqfz5aiPPGCc
	 VZWax8b5uc/GQarotL916GylGxtXqca1oszv6tOyhsRQV7crOPujPwkiP/3Rpq/ngpOjj
	 LJkT5Ryscro8EUKFolqNGOH6EF9vhkExNJ9t680l8EaSyB09moYr7YWpQX+Fh7Fy4wbQv
	 Q1ogV/I7ze2WyyTaS62rXGMwjZfZB2kzbyNLu5S2NAiRh8qybL1hz/LRm5WsSYM7DjCI7
	 kN5eSaBkDq3LvjMptSUap8WGns07Hhx/sDM1OHUNFSbQ3lIgCWHJnzheLvH1UwTXoIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049570;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=v4rC3LA7hHsU0a6ZISsX3gzHyLk3rWOWw6Gn3xsQenA=;
	b=HpNSScgNytSGNJAVLTkquOK6C6ABHLFzm53LgqCTp7qCir+HKPoWYbfvu4EA8/n+aCb/
	 62ZoM5F5rF39k2ddC06KUf5c9tsZWKFaimN/9eDoMpHfE3oOsu2jnuDFqPRb0tiVG7qdY
	 J8bOB7Xg9IjvkwmT2EMSR1yFJj9NXBsc4YP5UJ4omfGOtfkGMHxMOdyRhB39GLImPdQi7
	 55u9BFSXnzHOW34Kx1EEIfvXowpZlbtmtCdzRYi2XNsPpQojjbhVEl4GA7KP0VguAMXgB
	 0RcICBORQY7FV5msd4oyyvd/kBXd7I0wfG93cxsZaU/tA7T5BtOTBecH4k8v0NdAR7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=ktWPCtgE;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E0606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 21:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 752E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=ktWPCtgE
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id LOzNxtrJQv0ndLS6LxE5sp; Mon, 26 Oct 2026 21:19:29 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LS6KxR5ri9uv0LS6KxxFVc; Mon, 26 Oct 2026 21:19:28 +0000
X-Authority-Analysis: v=2.4 cv=M4tNKzws c=1 sm=1 tr=0 ts=6adfc3e0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10
 a=pvCKQwyQPUSeEgUCWcgA:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=v4rC3LA7hHsU0a6ZISsX3gzHyLk3rWOWw6Gn3xsQenA=; b=ktWPCtgE8iyS
	9nS+Y564cp8+GGj7ZWva+OztI07Qt1ftHRqQ7ercjjmGAfCLGlD0EX86H089BdlwAuirXv1rJe+QI
	dQnJptIixZ6qSFMsdV3D9gEyThxqNVt8U2eMBxk/UkTXTZ6FxRxehH6R3Rae9Q+KFj/bOIZpaGrEL
	xf6FB/9teMWV9aOlVkwTZheLu1gYfDew0s0QWZLGc3BPiN1NDX67E14yE0h3hy7LDFwZu9ffZJUIJ
	S0JcKTSsEhNh3wIObVv8ETzHiclZD/4XHnob+ZKtG9IFwbu3ne0sTy2gSqLJdp1+6siblfFEgr10U
	8nXgjHPyNs3EI8tLF3ovGw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52396)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLS6K-00000003Py0-055E;
	Tue, 27 Oct 2026 02:49:28 +0530
Message-ID: <104c9c54-7bac-41e9-b82c-93df0a2b3d73@roeck-us.net>
Date: Mon, 26 Oct 2026 14:19:27 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] hwmon: chipcap2: various bug fixes
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLS6K-00000003Py0-055E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:52396
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEUTA5SDsYkkIRF/lW5/cvGqq86/KEOyN4Wl7dXtDCInyW10UDUkTGk1z1GnXRNCrGaz9l1MYTTXqinQXjhEBHcAjKjlRuZ0gNsB7FiMRFxZHHgLUYwd
 ZWc2lW6OSUUiIZ043TPSEgacer+K3gya4qYT3IWJGajKBPbtXqlcox4Ag7h5tlR7pu3YLu2NoVegY/n4eOoiJGku+5g3JRYvMJ8BjQx6O2vkbWpYig1mbhVU

On 10/14/26 10:33, Javier Carrasco wrote:
> The original issue (race condition for the alarms) was found by Sashiko[1]
> when an unrelated patch affected chipcap2.c. The issue is real as the
> access to the variables is not protected by any locking mechanism
> although 2 different sources (threaded interrupts and sysfs) could
> modify them.
> 
> In further iterations Sashiko found new issues[2] that have been added to
> the series:
> 
> - Fix be16 data handling.
> - Defer probe when the IRQs are not available yet.
> - IRQ teardown ordering: split the current implementation to provide the
>    available interrupts before registering the hwmon device, and register
>    the IRQs after the hwmon device has been registered.
> - Disable the device after the hwmon device has been unregistered.
> - Enable IRQ processing when the regulator is already enabled.
> - Balance regulator counter.
> - Do not discard the pending alarms when the device is disabled.
> - Reset the completion to account for counter > 1.
> - IRQ serialization and synchronization.
> 
> The last item required a dedicated mutex because the hwmon_lock was not
> suitable to close the gaps where an interrupt might go unnoticed because
> there is some dependency between the data read and the interrupt
> generation, and also in the completion mechanism. I went through the
> different alternatives with a combination of local Sashiko and a second
> AI agent, and discarded some complex solutions to close gaps that are
> more theoretical than practical e.g. the interrupt was fired, but it did
> not reach the controller due to nested GPIO expanders. I added the
> Assisted-by: tags to those patches accordingly, although it seems that
> this requirement will soon vanish.
> 
> Additionally, a harmless off-by-one in a for loop has been fixed to save
> ~80 ms after the last failed command retry, and the error reporting has
> been fixed to show the right issue. These two ones have not been tagged
> for stable as they are only meant to improve reaction time and logging
> inaccuracies after a command fails. The deferred probe does not have the
> stable tag as it is just a reaction if interrupts were provided but
> still not available. Of course, I can add the tags to all patches
> if required.
> 
> The fixes have been validated on real hardware with an Amphenol
> ChipCap 2 CC2D23S sensor.
> 

Series applied. I assume any valid issues reported by Sashiko will be fixed
separately.

Thanks,
Guenter

