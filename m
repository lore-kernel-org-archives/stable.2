Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672347143D;
	Wed, 14 Oct 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007944; cv=none; b=dXMKMMvUfkvGpSEWfBCM7Z+VsWak/4zjGVuJprVkoRodoIRJTuHc3m+lmcPD4pEJ+PP+27v1Zb30O1+BykG+21PF6EaBX4H0FpNlE8g+a/8KP8WE4kIO9baYVc5mycB7/pLfkLqa/zMhjEtaRgRE1KoTf+T4p2ggE3ZUQkF+jl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007944; c=relaxed/simple;
	bh=hiLwKxvcV0lpXtZh04hY0S+tdD/qJ6dDwVbBKSrEqhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th7P1bW1sE16GllXwqWanhzrrXRPXMx0rdG1UueBu8jdfRFOxiuZBW3cNVuov9h7oSDc+7EJdEhEtNJw29W5y6zJGpX4S55x/UG4Vnx9Zgd6S3FlJfYJhmjMqeelDDPKeklLwq2CbBZ4pZO6N+YthebBMb0qHJ6a7VMsrWlc3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QVVZ5vi0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QVVZ5vi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792007950; x=1823543950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hiLwKxvcV0lpXtZh04hY0S+tdD/qJ6dDwVbBKSrEqhI=;
  b=QVVZ5vi0Ox0rmRYKktLo2Cv68Hph9tPrNJ5cHrUue435AnqPM3iKw+ID
   KGLt2WBXzuGYWJd4dC1018eofJY9+2DhQxiM90fmyROm9/RF8Ydi9Dtck
   l+RnP4QhGxloe2TtRq4rP3wIrB6awy/V+QMSYIiY79WZqbVRsmNOSkr87
   JI6z/fVKc7T/qP7XOW26r/A6wvaV6H+ymDLVWAf837vL8XkSeR1lwHjrN
   9JZ/uTtzzQg4WUYYuwFR2D20owi7oflA7xeo9WQLgbB9fQ5ND908bKDMP
   Iyxn8b7lY3dgD3m54OaF0vRdQOu6fic6ihbAVF3hQN1o55R4+sL8Tt2Qp
   w==;
X-CSE-ConnectionGUID: 9cTc4mc2Q9KSu8O/EXolLA==
X-CSE-MsgGUID: 7M4PT3xqTESVATViwMLhQw==
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="296466926"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2026 12:59:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 14 Oct 2026 12:58:56 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 12:58:54 -0700
Date: Wed, 14 Oct 2026 21:58:53 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: <stable@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "open list:NETWORKING DRIVERS"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: korina: fix dma_unmap_single() length in
 korina_rx()
Message-ID: <20261014195853.ncvqfx3qkedhv7a7@DEN-DL-M70577.microsemi.net>
References: <20261013132319.22253-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261013132319.22253-2-fourier.thomas@gmail.com>

> dma_map_single() is called with size KORINA_RBSIZE and
> dma_unmap_single() is called with size pkt_len which might be smaller.
> Therefore, parts of the buffer may stay mapped after dma_unmap_single()
> is called, which leaks a resource and might leave exposed mapped memory
> that might be eventually freed.
> 
> Change dma_unmap_single() length to KORINA_RBSIZE.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
