Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996454;
	b=UP44fFlPJUQ7aCioGxN5AIuzc2D4ecQX1v0q6Q0YtOx37V4jZZI3TAHKdJFdSd7sDU88
	 Pg0fiOin2GB9SZ0iNir1KhX2NcMFJI073VaalVH61SD4UkXn8AiyREto/mVTliJHX7mH4
	 +jrkAiRHmi+XXV98gM5c3vUYjfmtrlQiirENSP4Ci+jpEWeyFvgZiJk15/iz7Ish/npdi
	 5PuPTKY4cNEocxgOfGLjEJb5jtnFbyNEYsHeLFOHWCDs8/nSFdqoiw8LpB0ULm4jEV3cn
	 mYReuNP7K2u/oihxlq37x62Eqm2br8IwNkNG5uO0InVDE51Px/tB0D0zGVkBC6J/MIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996454;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9p7nWP6aCwolh1r/jYlW6rQASc0ZzZDHEc19WN951qU=;
	b=NE5jLzVgcwhwubsf6IxqZRJJUPcbpP47ESVCjg5B52qPahVupH3vLqs81jNCOuAkwLi5
	 5KjtrU0Y2vZBrCSoPhwMSaRLsSk/1lIjtW0UpS4RIei9D45Up6HJAsgFlwCItWph9//PS
	 GYzfj/WBVCTHIPs7qz0Eqwcb2P8Di89L+3OEcXCqE9Tnd4iaN3vuXkyypBDqz3BqPssJ4
	 GHv/qF6bZYFGlZGOGvwgiEIn5qY5VTym09kdTk5WGG1Nl2OqV3QqYOfxLOsZeK9abNJVD
	 078K3w86i+EP8vobfdEuSupx1ouAnZ17rban9dyh0V2f8QEi+ic5ghGxXIWqIcdsffQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=aqa4i8Na;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A535606A330;
	Wed, 18 Nov 2026 10:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A535606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=aqa4i8Na
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794996461; x=1826532461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WV62P4nogrn/yedNrcqAoj0rawX6mdY7FKe5AzL+xxc=;
  b=aqa4i8Na/12xObUKqU5m2tbbsExjC0TaFY6hk9HcgxKLEeyFRkG5XPeu
   +eONOWY8+gCvE5hYCy5BwwCIGjSY5wj8gHhcuV/3SDHEWT3DYW0ZG3Z6P
   TnYVxba00w2R9SZb+Og/BKN+yIxzYTS2wsKFtAlmqETeOfH2LAHdDzw5K
   pG9ZVidylnJ/VOvRVy0preNj07KvtSObVnoSDrZQPTdL8kxS5Umv320Cu
   YORjfErMKXmxPmmPxP/27b5sPEmc6aDqE7b0hdtkx/AdPy1JEeVytoyQL
   8tKcw8/hsQPvdqanZv64qzxtuMe8VpHjRU/TBK6XpbhiIlYcTkGRC1+LP
   w==;
X-CSE-ConnectionGUID: CDvrusw7S4i+4/eC+9cqbA==
X-CSE-MsgGUID: RUyH8oQSQnuzLEE9CMGJJQ==
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="65717232"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2026 03:07:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 18 Nov 2026 03:07:31 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 18 Nov 2026 03:07:29 -0700
Date: Wed, 18 Nov 2026 11:07:29 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
CC: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, Nicolas
 Dichtel <nicolas.dichtel@6wind.com>, Yuyang Huang <sigefriedhyy@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] net: fix uninitialized heap leak in multicast address
 dumps
Message-ID: <20261118100729.jn66g5cvdkspoqjc@DEN-DL-M70577.microsemi.net>
References: <20261116024056.1274402-1-bsdhenrymartin@gmail.com>
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
In-Reply-To: <20261116024056.1274402-1-bsdhenrymartin@gmail.com>

Hi,

> __hw_addr_create() allocates entries with kmalloc() and initializes
> only addr_len bytes of ha->addr. Dump paths emit entries using the
> current dev->addr_len, which can grow after the entry was created:
> tun's TUNSETLINK changes a device from ARPHRD_NONE (addr_len 0) to
> ARPHRD_IP6GRE (addr_len 16). Both the RTM_GETMULTICAST dump and
> /proc/net/dev_mcast then emit up to 16 bytes of never-written slab
> memory per entry.
> 
> This discloses leftover kernel heap contents to anyone reading those
> interfaces.
> 
> Zero the tail of ha->addr at creation time, so dumps can only emit
> initialized bytes.
> 
> Cc: stable@vger.kernel.org
> Fixes: a748ee242681 ("net: move address list functions to a separate file")
> Link: https://lists.openwall.net/linux-kernel/2026/09/10/320
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  net/core/dev_addr_lists.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index d827cc21867b..53a2dfa2706c 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -100,6 +100,11 @@ __hw_addr_create(const unsigned char *addr, int addr_len,
>  	if (!ha)
>  		return NULL;
>  	memcpy(ha->addr, addr, addr_len);
> +	/* Entries are dumped with the current dev->addr_len, which can grow
> +	 * after creation (e.g. tun TUNSETLINK), so never leave the tail
> +	 * uninitialized.
> +	 */
> +	memset(ha->addr + addr_len, 0, MAX_ADDR_LEN - addr_len);
>  	ha->type = addr_type;
>  	ha->refcount = 1;
>  	ha->global_use = global;
> -- 
> 2.43.7
>

Looks right.

Just a thought, I think switching to kzalloc, like so:

+       ha = kzalloc(alloc_size, GFP_ATOMIC);

Would give you the same fix, and you would get rid of that extra tail length
arithmetic.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
