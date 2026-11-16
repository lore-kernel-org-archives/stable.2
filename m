Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822402;
	b=wusd34RTtIBnVtpO8UvwKTahGGXinKjxX+KugIKUFLCyhjZsQt048QBRos6EhM44esfq
	 +ABe9CuVlgMK8k0+pdzNmP0ByzAydzmCYVsXuRpQjzwlaDrOwU+9TuxIU9tQDSnnEnfu7
	 TDc0uCordH//jqpcJ2FOJBe5jCr2RCJuqlDjFX2I8gB4pPFR5msfykgW0q736IeYUDyE3
	 5zFZKf3cVU8LrHMRGUWg6lIsVpNl8K3czwhC9m5tRGgoGa1GZ3xAmLGxBgmE8FaNL7EPK
	 B5eU0Eby1U1XermWTw4KoyLVgmuj9YVw5nzqC/rmnmIgmMwpm4ieci1HJY/TNaPb3UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822402;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=snTWseG0kVmWo+d/p2p1Jlh3ZolTCUDlK8iJ9pssKmc=;
	b=gZcG+quclE9k7z560w5yS7/iIe3fIABG9Wh6o2vJ3SzOUe3fyjBgWo5Ucf0p1sHx91Pa
	 gMHs7gohU8oXhV2zrMan9RX27NMvOYi0VehPzgA/V6I2UacM0Ss/8JQHf59AcnECUtcaZ
	 YAG6PUdE9bCiLHbc7UmCMoabL86jSnl07oWGW455DaQupwEcG3GxlGHxvfZgOvgWcBysQ
	 Mgy9jaTq5l3s4eBkG1TVtXZspRmGraHsmX0jy+yPKHE8Z3eMDjBTPAJ1w65vU2injLL/b
	 zQVMN9nuKjjGla76L5HhFzGRpiySfD4MrmAFWUgUSkS5R7WoAyxZLBqUs5ZkcqN0QIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=vdpfPt+X;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390D606A31C;
	Mon, 16 Nov 2026 09:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D390D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=vdpfPt+X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794822400; x=1826358400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FeMo7oLrxfV2pQvuvKuquBuDJ70sUaZ0KOSQg/40CSs=;
  b=vdpfPt+XJ1/JgA7UvcJMAGzoGOWa/Lf6Uj1zFPjm5vxOzmCOHpeGh0nY
   eSyzXAZVc4UdifkxbUoaUIxhcRCjbVGsUzf9xCcmB30FzqnXFUmQpW221
   AunMScYNPzUcxItG2odJt/GkJHpfMWdc+0VTccuG9rvoj+kHLN8Lg9wsQ
   WkrFdimNXXp5jq1pz/5JXPHVBfCxKJD7GVJ8kK5SPIrSw5Ij/EfUBZ9uV
   CaQp4gk/rtyLs49sjFXdWJEbN1PfvJyE7XLZTMPtwNEVHH2+zPacN3MS3
   VM8FPfCccreAR8n1LvRMzb3AHL9S8IzIf+Rulq95r1q/clpfiXMWeQ0oA
   Q==;
X-CSE-ConnectionGUID: vGCXQfQlQSe8As76d5JMjQ==
X-CSE-MsgGUID: vH5p6b98SjmZWx43bf5Naw==
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="77267821"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 02:46:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 02:46:40 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 16 Nov 2026 02:46:38 -0700
Date: Mon, 16 Nov 2026 10:46:38 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Anthony Pighin <anthony.pighin@nokia.com>
CC: <netdev@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] net: gianfar: clear the pending Rx skb when freeing
 the Rx ring
Message-ID: <20261116094638.cwp2slcv6ewgmbmf@DEN-DL-M70577>
References: <20261112143140.1395197-1-anthony.pighin@nokia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261112143140.1395197-1-anthony.pighin@nokia.com>

> gfar_clean_rx_ring() keeps a frame that spans several Rx buffers in
> rx_queue->skb between NAPI polls. When the interface is stopped (close,
> MTU change, reset), free_skb_rx_queue() frees that skb but leaves the
> pointer set, and nothing clears it when the rings are set up again.
> 
> After the restart, gfar_clean_rx_ring() picks up the stale pointer. The
> first buffer it sees has RXBD_FIRST set, so the overrun handling frees
> the skb a second time. By then the skb has usually been reallocated, so
> the second free releases another owner's skb and data while they are
> still in use.
> 
> Clear rx_queue->skb after freeing it.
> 
> Fixes: 75354148ce69 ("gianfar: Add paged allocation and Rx S/G")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
