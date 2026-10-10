Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC23955D5;
	Sat, 10 Oct 2026 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791646382; cv=none; b=VdJ5tarN9p3TNaeg71DkM77KZ4F5XYasoJxJb7KyZg9QIB2NRrLTlJ+qNMu5gV56ZKOklwRHStBOnuUzy19ZW1XU5x4loKzVJKWfxvHWGnDxlCX7I8QIcKc28NcgxbvaqfEoh2ZK2w25BB+xfOguNxJlx3gLBCGXgEW3WVBOsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791646382; c=relaxed/simple;
	bh=C0XglV9S5eeOapG38PHlrdrd1CrDr5+pCUALWLQ9KMo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkmjCkvFGdKE828cCr4sYyfzGGLqli0HXMoKe/JWIJlEN5D2l5PfQfipZt2X5Hpb2z6uY+pylCcTGFeKYMDoAmROf17NQUYgB7IW496P5n1HNOAM9rwsx5cP1/X77GLkpToXBAJP6Yw1h3X/R+CsBFxJPf+NJq3HjcTlt/wE684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Afy7iCSq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Afy7iCSq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791646387; x=1823182387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0XglV9S5eeOapG38PHlrdrd1CrDr5+pCUALWLQ9KMo=;
  b=Afy7iCSqQ7zLwtV6FEdKqq5w7GQGpKPXOoXT7Dd++o9QEk6gs6lb42qr
   8kGAZYxfna5Ctn+a54IOakznuxVVj1Mg+rKcBh7KdYa+i89YJDNuZ4bux
   NSF2hm1r5XGjsH3MDestlskMsU8tK/aQdV0U0OmVIH51/g3CIgjAtI675
   6d9m1u2uTS4pvN5jYG6BVGUwI003OsYFVPFy1gibRXWVA+DpL/tYcXHpy
   F4dHw7FI5hFA/w1W/zZ4yDj+eiiGNLq2fk1QlXLJLkMItU8VpP7/Wjc2K
   Z7+BmICQAF5oo/Nn/s8VC8ddHcyQLKjKQ9A7aDUqNXMpCfFJIDafK5SiI
   w==;
X-CSE-ConnectionGUID: ZeTUSNaGRLirMEN3sJxl3A==
X-CSE-MsgGUID: W8pJeT+FRWeY4kkw/IeR3A==
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="63905774"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 08:33:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Sat, 10 Oct 2026 08:33:00 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sat, 10 Oct 2026 08:32:58 -0700
Date: Sat, 10 Oct 2026 17:32:57 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: <stable@vger.kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: alacritech: fix dma_free_coherent() in error
 path
Message-ID: <20261010153257.b6urngqvxjml77rs@DEN-DL-M70577>
References: <20261006140912.50828-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261006140912.50828-2-fourier.thomas@gmail.com>

> In slic_init_stat_queue(), a series of coherent buffers is allocated
> with the length size. The size is then stored in stq->mem_size for
> normal deallocation. However, in the error path, stq->mem_size is also
> used but is not initialized. This error may leave the freed buffers
> mapped, leaking a resource and allowing the device to access freed
> memory.
> 
> Change the length in error path to size.
> 

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

