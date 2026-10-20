Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.108.44.247
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530752;
	b=i3BFEuQaukcTSDwn1BNn0aYiUYy6GHejLEREpdqTPLtJZbF87xIGfkUAb8xEF5L038+m
	 cyXMqx6MU8QguI2EJ87OMEMifeINhzNgM0QHpV3mZnw4Sd/FfsHIUxIbaMzuu/glIucIh
	 ZtDmRqbOz1ktGVLzyr8iuYFVea11voX6iAicWYflFhTijf2KEKdjy8UIoGhIv3hActw4d
	 wsgyLgefXjhSexrqEeY3HZCjzK/5/ykllfLGusxYCmsprMnXtR8SBQVQvWbJFZPUlTRev
	 W+RqzgOTAdWmev83kzqpXbZyTdJ9g7npcRybRazN+SA39oGULheOQI7aH7EetITpcOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530752;
	h=DMARC-Filter:Received:Received:Received:Received:Received:
	 Received-SPF:MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID:X-Sender:Content-Type:Content-Transfer-Encoding:
	 X-PPP-Message-ID:X-PPP-Vhost:X-POWERED-BY;
	bh=ziFQduvBFp2/a0Qma91+j1J9NIAtLrmEIaU+o8krKdU=;
	b=5o2v6jLnkmEkj1wAW+T7Y3TYNwGTPkxDuQ/oXzPYIOUvVUC8+Hi90o5qNbZFi2nyw3Jr
	 7mn1S0aaQrCFfT/AHNMsp722+LczZiBjx0U/nKg11A14ruwFWUJ4EXZv4TRONHR2+bKO+
	 DvdwNdoh1LVcJga5LoBlESGyGD5O3pxZDoKqQd3Py2vLBRuzSE0pnVgZDneKoBFH/cDdR
	 pISqhfSNG8+nhDJ++RdTSeODnB0zGbx0kBBCv3S6fRIO9476xxu4Ov1cTCjax9bfy0jax
	 cw6jAWTM0GmQYxIRZOxk53ZklJAwzWaKdqDSTLaS7iy/TZNW7Tj/ERw6oRsXCXHMrzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kiener-muenchen.de;
	spf=pass smtp.mailfrom=tldhost.de;
	arc=none smtp.remote-ip=62.108.44.247
Received: from mr07.mx01.tldhost.de (mr07.mx01.tldhost.de [62.108.44.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A88606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29A88606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kiener-muenchen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tldhost.de
Received: from mx01.tldhost.de (localhost [127.0.0.1])
	by mx01.tldhost.de (Postfix) with ESMTP id 5A386122E84;
	Tue, 20 Oct 2026 23:12:22 +0200 (CEST)
Received: by mx01.tldhost.de (Postfix, from userid 1001)
	id 3DBA6122E77; Tue, 20 Oct 2026 23:12:22 +0200 (CEST)
Received: from mailout.tldhost.de (mailout.tldhost.de [84.19.26.10])
	by mx01.tldhost.de (Postfix) with ESMTPS id 2BB90122E70;
	Tue, 20 Oct 2026 23:12:20 +0200 (CEST)
Received: from mailout.tldhost.de (localhost.localdomain [127.0.0.1])
	by mailout.tldhost.de (Proxmox) with ESMTP id 0ED5F82A0A;
	Tue, 20 Oct 2026 23:12:20 +0200 (CEST)
Received: from server12.tldhost.de (server12.tldhost.de [84.19.26.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by mailout.tldhost.de (Proxmox) with ESMTPS;
	Tue, 20 Oct 2026 23:12:19 +0200 (CEST)
Authentication-Results: server12.tldhost.de;
        spf=pass (sender IP is ::1) smtp.mailfrom=guido@kiener-muenchen.de smtp.helo=webmail.kiener-muenchen.de
Received-SPF: pass (server12.tldhost.de: connection is authenticated)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 23:12:18 +0200
From: guido@kiener-muenchen.de
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Michal Pecio <michal.pecio@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Steve Bayless <steve_bayless@keysight.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets
 on xHCI
In-Reply-To: <a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
References: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
 <20261020184244.69b78d5e.michal.pecio@gmail.com>
 <a642dbc2e4ba0efc381c69e26821762a@tipi-net.de>
Message-ID: <d702d2b3b66d6229855515c2eed09636@kiener-muenchen.de>
X-Sender: guido@kiener-muenchen.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179253073937.20268.16253300091701606469@server12.tldhost.de>
X-PPP-Vhost: kiener-muenchen.de
X-POWERED-BY: TLDHost.de - AV:CLEAN SPAM:OK

Hi Nicolai,

The USBTMC protocol was defined by the IVI Foundation. The purpose of a 
specification is to ensure that manufacturers adhere to the agreed rules 
so that maximum compatibility between T&M instruments and client 
software (e.g. NI‑VISA, Keysight VISA, R&S VISA, etc.) is guaranteed.
The Linux USBTMC kernel driver is a class driver that has been tested by 
members of the IVI Foundation and ensures reliable communication with 
their devices. Therefore every manufacturer of USBTMC devices should 
comply with the specification and cannot expect bugs in device firmware 
to be fixed by patches to the USBTMC driver on Windows, Linux, or macOS.
If such an approach were tolerated, the development costs that one 
manufacturer omitted would be shifted onto and multiplied across all 
other manufacturers. If there is a demonstrable bug in the USBTMC kernel 
driver, we can certainly discuss fixing the driver. Otherwise I cannot 
support adding device‑specific patches to a class driver. Over time that 
would increase the driver’s complexity and encourage other manufacturers 
not to follow the jointly developed specification — something that would 
certainly not be acceptable for the TCP/IP stack either.

Best regards,

Guido Kiener

