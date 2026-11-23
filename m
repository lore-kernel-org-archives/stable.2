Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415306;
	b=5HhrvRqPJkCBNxGrm0uGM7m8G4HfWA/zXozUB0DaxZTtacBaKutt5peV6O114xq/qLzC
	 EVQjej72Y7k233n3CgQ+ItFOHXYwApVirdtaSyISrUdJxC7il+qFK1MmY/PMifBYdHTSS
	 bJUjmTvbJ/2GqbSj1pWe9i4a6yx5Mssc16+hNXIjAvO6NzHCVgJXRuO6KoLqsSMatBdWV
	 6GRv+gtjQnbpZBf3Air+ItXTLxHihCjASCIMY/LhpTWBfUpqbZ9F+hUy4Qk396MHRiw2W
	 IPb4pqudcH5o70za0ipQnTjq6h8uxeCcv1cFZgJLPxde9PD4wWuGzWRJN3DRDiH+/sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415306;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9Do6A6bkw7UrGMEL6iSs8ctS3fr5QAv60balSROo8WY=;
	b=UppdH34OyOSR1sTyaXDICPAusVdGmMxVYofdz6Yx7Cz3FHrQazQ14VDsT602HOsJmpnN
	 5E2DYGs4GzBjCOsUosfyd/3pgPte1eBsdWTYElpleMQtH84NY6p0v3SyWSq+vaeEa9ix2
	 2S4Qdkq4Fm5bBtl/LUzBgLaAhDaao1eeJx03Hjm9Zr90949KoerQuXpromdbWnPclfEUO
	 NsDqhazw6vfA/S2JuwyT/YPVOR54bHOdjsxQgErpz2D8B1g2wD96bgf2S77nTAHvzZS5w
	 jpTrfVJTlzpu/Ju5BN4etPV2OZxRfSWnBm0ZwCvtnCKPvHtjY1N9+rvObl56KWU4+mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=FDLcCc7T;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA9606A31A;
	Mon, 23 Nov 2026 06:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CAA9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=FDLcCc7T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=FDLcCc7TJb9uroW6TilmI+UlMIeFAv0uqJVf4c/+HUJM1VZCjuIzWhJmOQHsoN6Kmh0XgW5FAoLlA
	 qH+JQFDWn5AN5+gd0K2byBJ4uMSL9UDG6WezCAX5I5yIRAVAIookKH6ZR8KG2U3Qy8aIRtW7EhCSvv
	 WTNXdpYGKe9CXIB0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56b03dcfd61e-373c7;
	Mon, 23 Nov 2026 14:28:20 +0800 (CST)
X-RM-TRANSID:2ee56b03dcfd61e-373c7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[104.224.130.48])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96b03dce908d-89c0d;
	Mon, 23 Nov 2026 14:28:19 +0800 (CST)
X-RM-TRANSID:2ee96b03dce908d-89c0d
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ip_gre: fix stale header length after erspan version change
Date: Sun, 22 Nov 2026 22:27:50 -0800
Message-ID: <20261123062752.27920-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120060254.3766851-1-bsdhenrymartin@gmail.com>
References: <20261120060254.3766851-1-bsdhenrymartin@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 20, 2026 at 02:02:54PM +0800, Henry Martin wrote:
> +	if (data && data[IFLA_GRE_ERSPAN_VER]) {
> +		int len = t->hlen;

The bug is real (on 0 -> 1 the GRE sequence number even overwrites the
GRE base header), and the patch fixes the packets. But t->hlen has
already been reset to tun_hlen + encap_hlen by ipgre_newlink_encap_setup(),
so the delta is wrong. iproute2 always sends IFLA_GRE_ERSPAN_VER, so
each "ip link set erspan1 type erspan ttl N" on a ver 1 device lowers
the MTU by 8 (1450, 1442, 1434, ...) and raises needed_headroom by 8.

Saving t->hlen before ipgre_newlink_encap_setup() and always
recomputing it fixes that in my tests:

	erspan_calc_hlen(dev);
	hlen = t->hlen - hlen;
	if (hlen) {
		dev->needed_headroom += hlen;
		if (!tb[IFLA_MTU])
			WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - hlen, 68));
	}


