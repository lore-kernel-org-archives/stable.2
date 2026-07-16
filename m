Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B23BA22E
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187342; cv=none; b=me9f8DLI9fptMRdpw9gCe1ctuUwrm+w+50ox9qaThB3YS8MPH4lOO3qIhdetUgyY6Sycw8bGPAe5IrP35sY4eHDayCK1+1IaGWvt9IgrQCSO7Vw6CJgGLjoz+8F0FHaO4swrItGcUYi4QR+XMM9BZBebn/DhGZEgs8FYoNIpvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187342; c=relaxed/simple;
	bh=hxORfej92Mg3Nc3HOQEk9GYvQcPqeBj1nyJGytpPx9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=AmexrHxqiBzmadyV0A3a11dz6DN4E9dQYR+eLPhkWopYTWMG2AyBePlI2j/W5T6AbZnqjeD2vImuKIFtXRvCTZGCALGX95Nv6YI2sRed5T+HyHtQXRewBcI0y1cY2G/Mi9qljNpMnQFj3WdQ/EioAQB2YseF6qzzssxW+wQ8DoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gpW2bGyQ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gpW2bGyQ"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260716073538euoutp0123f1ae40c8bd1dfe38b58c396b8d61b2~CtO5zK6032678626786euoutp01W
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:35:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260716073538euoutp0123f1ae40c8bd1dfe38b58c396b8d61b2~CtO5zK6032678626786euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784187338;
	bh=M+e8FMjxlu8Cvc0CcQFMRL+Ex/ZuCg6jnE3zP0pwq4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpW2bGyQPkW2DQuND9WIVOPGBhWEhVs8s4iSAo6piFBydKSW/pGoysIKwRWhZCZIL
	 29o2QSF4xI2Ede9bQm8CnFzo3TZynFYuT12fcqvO4I4AZusZ2YGKUG06wTFI7n00sA
	 Mm/Q5KESOpgVg4EeQ05UmmzFfHItHV9HTMUV6/ng=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260716073538eucas1p24a4107355cfa7017ab15cca1a61f7148~CtO5UFkJv2490924909eucas1p2p;
	Thu, 16 Jul 2026 07:35:38 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260716073536eusmtip13d05195b5fa03e5b16b777862996ec76~CtO4Qrw5B0331203312eusmtip1g;
	Thu, 16 Jul 2026 07:35:36 +0000 (GMT)
Date: Thu, 16 Jul 2026 09:35:33 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Shiming Cheng =?utf-8?B?KOaIkOivl+aYjik=?= <Shiming.Cheng@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "imv4bel@gmail.com"
	<imv4bel@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "alice@isovalent.com"
	<alice@isovalent.com>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, "nbd@nbd.name"
	<nbd@nbd.name>, "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"willemb@google.com" <willemb@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Lena Wang =?utf-8?B?KOeOi+WonCk=?=
	<Lena.Wang@mediatek.com>
Subject: Re: [PATCH v7] net: gro: fix double aggregation of flush-marked
 skbs
Message-ID: <aliJuE/c+tNaSAU0@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <99ce187af1495ffac592bfcf7ef97fc61a7f780b.camel@mediatek.com>
X-CMS-MailID: 20260716073538eucas1p24a4107355cfa7017ab15cca1a61f7148
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----KNnB4kTNYKyYcmQL5sxXd.jAMLTdcyVYkfyqBoax5Juj2j1a=_3e3ed_"
X-RootMTR: 20260716073538eucas1p24a4107355cfa7017ab15cca1a61f7148
X-EPHeader: CA
X-CMS-RootMailID: 20260716073538eucas1p24a4107355cfa7017ab15cca1a61f7148
References: <20260709014704.3625-1-shiming.cheng@mediatek.com>
	<willemdebruijn.kernel.2801a1401793d@gmail.com>
	<99ce187af1495ffac592bfcf7ef97fc61a7f780b.camel@mediatek.com>
	<CGME20260716073538eucas1p24a4107355cfa7017ab15cca1a61f7148@eucas1p2.samsung.com>

------KNnB4kTNYKyYcmQL5sxXd.jAMLTdcyVYkfyqBoax5Juj2j1a=_3e3ed_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Thu, Jul 16, 2026 at 01:41:12AM +0000, Shiming Cheng (成诗明) wrote:
> Hello everyone, 
> 
> it looks like this has been peeding for a while.
> Is there anything else I need to do or follow up on ?
> 
> Thanks
>

Hi,

There was an announcement
https://lore.kernel.org/netdev/c0cd72bd-6298-47a4-82a3-c43811c98063@redhat.com/
and currently there are over 1000 patches waiting for processing
https://patchwork.kernel.org/project/netdevbpf/list/

So need to be patient.

BR
Jakub Raczynski

------KNnB4kTNYKyYcmQL5sxXd.jAMLTdcyVYkfyqBoax5Juj2j1a=_3e3ed_
Content-Type: text/plain; charset="utf-8"


------KNnB4kTNYKyYcmQL5sxXd.jAMLTdcyVYkfyqBoax5Juj2j1a=_3e3ed_--
