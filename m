Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795381794;
	b=a17HjuXtnz2jTWQy1hdVosOwTQG+ByC4MwmkvTmVkRFcQZDVqztVoHCj9Yop/Bi5akXH
	 VvMDVsjYOH4erOkQwfMTf7V+oAobZ9sOX0C74c/bdfX8ohSakAJ3djWXrkSmfQGbOBag8
	 TGstt3vKW8A6lDaHR+MHrOYiOaN0zdwEM9SZk85WtdEHTETig298BYZ+p1boq/gVkst7h
	 QCi0ODCAlH6nFSWMgU2q/29fc2fdFHGO8K4v/5VPv3cYrn460s0gh6/wnO77Tj1ep4xMk
	 SyN1qB4wN81SDZIa3BpMZsaQKxfsyiBHyaaQQ0DnK84/XgkiBke5XipzN80kxdk6x4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381794;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=uxe+/upGUtn9RMUQNSI1VT9y02p7mp9sPqgPQ5Y4SGs=;
	b=PyAshVQ1QyvLyrqgLHf2bm8Q+Js9URR82nFLKvWzSFDYfAhg76sn+zaAv1WUSjoLFE4I
	 gWLC+ruoH5TDSeYlRuE3ho34/SFjQBlYktvZyEBXUQRm6g7TWemn3iBoNp+XjaXmNJ6je
	 FhiWV1VrbsXx0iTObpOvQKxOfD3DiFm3aThuVf140c+TlfvJJlMYKFwle6nFNs8PJ0Z9I
	 tBL5yjpbmX5oRxE4HwEdIZcu5cOLoQi6yCywmM7Mm24j22Cu3j4U5v2PTULMgUrIWBRYU
	 3BXbBFvstK2gxXLL5RFLee6+hl4Bu7PHzsoe11AzJqlRpAl5r7rLkO/MCgABlr8kcCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=frqHZnJk;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC1606A31A;
	Sun, 22 Nov 2026 21:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFDC1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=frqHZnJk
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B99AAA035D;
	Sun, 22 Nov 2026 22:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1795381785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uxe+/upGUtn9RMUQNSI1VT9y02p7mp9sPqgPQ5Y4SGs=;
	b=frqHZnJkTNxaPAjLmOsie2BAIg2lEWzgDqBSAagS74GBXq028DxAkyGhmH4Lc/UTP9h2/D
	ADmcniHun9j5JI2EcNeUlRI2sXkiP1oIHHQ6toy8xs3lN0UaVO5bzJDMcvdmi+aTbz/S50
	S8imbjTNZLaNYK3GEKUMvrNUwzLxzCGAxT8Tiyn169jjiBqwDaqRFSGzPXsvUqq5bmWbbR
	NJT4lhERRy1gmk2Qwaw3jqsaUKBO65i+SXIopcUp5yTebvsk7VF8qCOoyS8lVMKBbj5NOJ
	KT3DoYoxb+/tzUSxGEo5T5w0pyA7KbEWnxViY2IYi0nEV3xsBkdkaSKPnGR0RQ==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 22:09:40 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Anandu Padinhare <Anandu.Padinhare@electrifex.com>,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>,
 stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
In-Reply-To: <CAH5Ym4jkX_tD58Gtd-mzruB+hqHK7s_9knNWh+gMqUjwuYyVPA@mail.gmail.com>
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
 <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de>
 <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
 <CAH5Ym4jkX_tD58Gtd-mzruB+hqHK7s_9knNWh+gMqUjwuYyVPA@mail.gmail.com>
Message-ID: <3303844cdf7c00c5369453eb91027c1b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Sam

On 22.11.2026 22:02, Sam Edwards wrote:

> [...]

>> Do you mean "first as well" or "first instead"? Because "instead" can
>> cause avoidable packet loss:
>> 1) Initially, network is idle and ring is full of empty DMA buffers
>> 2) A burst of exactly one ring's worth of packets arrives
>> 3) The RX irq fires and stmmac_rx() attempts its refill-first (none
>> needed) then depletes the ring to the maximally-dirty state; the
>> refill timer is armed
> 
> Thinking about it more: the "unreachable packet" problem happens at
> this point too, even with the "first as well" behavior.
> 
> Maybe the best way to resolve it is to adopt stmmac_rx_zc()'s behavior
> of refilling during the loop?
> 

Only if the ring is no bigger than the NAPI budget, right?

Otherwise tne poll can't empty it unless a refill failed, and refill 
first
covers that.

Refill in the loop sounds good, but this would be IMHO a net-next 
follow-up.

> [...]

Regards
Nicolai
