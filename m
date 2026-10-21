Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.19.26.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585785;
	b=bBpzT6796PB+m8qzWQSbVy3Dc3d9QKDGD7WXO1/hFw8AeH4rRFr6yrxdxfE0HlTJw/1f
	 GwUv3diAL2vBJJFB6ukagzuddWmtyBxudIImpn/9zfu3kY2mBS8tCrJY9/qbiZ6Mp2FuH
	 u9hbIcgKFIf27+xp5Edn224BXk5ehghgHSsGkiD2JUKqFaepSR/BctIqQvM2WFx4tyy+V
	 9IId4WhvkDHzfOsqMlxwTh4hDdQ1oMbcNwEG82r2i3h0fKDS1dEt5xjP6uzXX5Ylx4b2c
	 NaltjNpUAiq9jx3L1sQX17CgsqT2vRn0qJ8QaNntxnrs0XFneVaOKC/sy5B8aMxINNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585785;
	h=DMARC-Filter:Received:Received:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-PPP-Message-ID:X-PPP-Vhost:X-POWERED-BY;
	bh=pv4vAOfMeLWLsM9ahdk5vDfcsMcW1ciiFDbHu5/SBQ8=;
	b=tPyGGVKIppDDatLzbfOvunUT7bck/fOrXS9aXg9v/vpXEdydEIYuHtaqav36WU0+jJQO
	 ukitgN5jUkf4GMgG6wV8dVDyFORa/3wpBwxIZ0Wfu73KQfoX67MWtyRliwSQo7jhVrap7
	 zRntGHo+cn7N76iIvrZvqTY9VcFPQzy40UspyrTL2hT2aWW09lS9RmZ5iwkZDADqyVivE
	 emymLgIQbmYTXqxjDn6DoiKrvF9WV5u+Rcr3ZANRd0dgBtma3uqwa6yjYxONXFnoSUoVW
	 8Fi2niGFYqYdV6Lh3HJasIlwj6JtlucoKm11RFOboS8RM73S+dlObJncE8TVFFytGMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kiener-muenchen.de;
	spf=pass smtp.mailfrom=tldhost.de;
	arc=none smtp.remote-ip=84.19.26.246
Received: from mr08.mx01.tldhost.de (mr08.mx01.tldhost.de [84.19.26.246])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5C606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E5C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kiener-muenchen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tldhost.de
Received: from mx01.tldhost.de (localhost [127.0.0.1])
	by mx01.tldhost.de (Postfix) with ESMTP id 4FC2E122E91;
	Wed, 21 Oct 2026 14:29:40 +0200 (CEST)
Received: by mx01.tldhost.de (Postfix, from userid 1001)
	id 439F7122E65; Wed, 21 Oct 2026 14:29:40 +0200 (CEST)
Received: from mailout.tldhost.de (mailout.tldhost.de [84.19.26.10])
	by mx01.tldhost.de (Postfix) with ESMTPS id 3F405122E12;
	Wed, 21 Oct 2026 14:29:38 +0200 (CEST)
Received: from mailout.tldhost.de (localhost.localdomain [127.0.0.1])
	by mailout.tldhost.de (Proxmox) with ESMTP id 293E681E9A;
	Wed, 21 Oct 2026 14:29:38 +0200 (CEST)
Received: from server12.tldhost.de (server12.tldhost.de [84.19.26.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by mailout.tldhost.de (Proxmox) with ESMTPS;
	Wed, 21 Oct 2026 14:29:37 +0200 (CEST)
Authentication-Results: server12.tldhost.de;
        spf=pass (sender IP is 93.104.90.53) smtp.mailfrom=guido@kiener-muenchen.de smtp.helo=[192.168.13.48]
Received-SPF: pass (server12.tldhost.de: connection is authenticated)
Message-ID: <ccc73234-743d-4161-abf9-2ba1f301b55a@kiener-muenchen.de>
Date: Wed, 21 Oct 2026 14:29:36 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Michal Pecio <michal.pecio@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steve Bayless <steve_bayless@keysight.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
 <20261020184244.69b78d5e.michal.pecio@gmail.com>
 <a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
 <d702d2b3b66d6229855515c2eed09636@kiener-muenchen.de>
 <bcb7b29468175cd13f08bdd363b8c733@tipi-net.de>
From: Guido Kiener <guido@kiener-muenchen.de>
Autocrypt: addr=guido@kiener-muenchen.de; keydata=
 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
 367l2lvnrwgkpj9ug6CmNuE929AH2iQD
In-Reply-To: <bcb7b29468175cd13f08bdd363b8c733@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179258577743.508294.11951329127478998559@server12.tldhost.de>
X-PPP-Vhost: kiener-muenchen.de
X-POWERED-BY: TLDHost.de - AV:CLEAN SPAM:OK


Am 21.10.2026 um 09:46 schrieb Nicolai Buchwitz:
> Hi Guido,
>
> On 20.10.2026 23:12, guido@kiener-muenchen.de wrote:
>> [...] Therefore every manufacturer of USBTMC devices should
>> comply with the specification and cannot expect bugs in device firmware
>> to be fixed by patches to the USBTMC driver on Windows, Linux, or macOS.
>> [...] Otherwise I cannot support adding device‑specific patches to a
>> class driver.
>
> I agree, it would be a better world if every vendor stuck to the specs.
> Unfortunately reality is often different, and we are the ones stuck
> with the devices on the production line.
>
> Anyway, I get your point about keeping quirks out of the driver. It
> looks like the maxpacket part can be fixed in xHCI instead, since ehci
> and dwc2 already accept HS bulk endpoints below 512 bytes (see the
> discussion with Michal). The ZLP issue of the Rigols can be worked
> around in the application. So I'll drop this series. 

I'm happy that you found a better way!

Thanks,

Guido


