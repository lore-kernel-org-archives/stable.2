Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171448;
	b=J3b7c8yieZ5FQuRXhlc3d4Tk6ZMYSepd35R7JM/yoxRXoDaL0eTbORsCLJ6ch2QhEt9U
	 GnInX7rHHo66oHnpf1zhWbUzdn7Jcp4RJpp4Xt2rtGww/lesyuDUSJx9ZxH4sxw2Edf0p
	 FLnUCKeymdjEJXD8cb1dl8B8t/RA/UCn3HbUeChkWdi0uwdge5F8FWi9p674Psv/NtdUd
	 nlDll7d88s3Ue3JAKbaLQZ4I2urznRQ9KcldVn6yoCu6kPdvqkoaJRobEYC9xwLayCS3z
	 9OVpJoOt1+VMUCcmALdYDWPQ/RV3w9ILDs1xQNjRb6HakSd1iQMLYvp5SUNYW8UkcuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171448;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=mVXDNhTKpePvAbfVkDflQLmXiubREs0zcPgQC9SEqXU=;
	b=ijpZyJyHkKrlBenpki7BQNgDU7LZ9V2FJBsh6RTC10JuMFdCg80c9UPSFoSxcMyxR970
	 eL/RJf2eWVTnSQevIqWQbLYDSXoyp7Nn7zTyuPie2HyINwqwwMKF37qRl70GGCQLOovTZ
	 zWIi0RVKgll5KVUV7jLRStqBkXZBwAduOg4xef6OPvb2Pr7zq5VPGaS8S0VNpy9Cwbyk/
	 D8SbbBA5BILKf7Eb0lx/3brerd+oRoU5OywQgUioG8YjhUpfKm4fNUAeAdpaPxhtvFYuP
	 f82jbB7JiggxL8sNNcTjt0bXarGyTSckm/Sq3+qT3mjxCpPedwa2XAHxQ772zmxdXoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sLEF9R0R;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E932606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E932606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sLEF9R0R
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B11554E4135E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:10:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6576E60769;
	Wed, 28 Oct 2026 07:10:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E157C1032906B;
	Wed, 28 Oct 2026 08:10:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793171437; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mVXDNhTKpePvAbfVkDflQLmXiubREs0zcPgQC9SEqXU=;
	b=sLEF9R0RDNzj94mlaiGX3kLFC8vDBqXa9MkaM91CyiLp9QKvQ0zj3vVjHB+qIxWs499vEc
	u2aIG0WlfK49GieNuz5L8PeZBMVAd1RgfH4QVotVgOwjtjf6c9oTxdSqix5T5KETjDFcBN
	uJssD8pgYpUlV7z0Udf2Ubvn06la8mshtrfduWw5nS0PtFvyS0LqotvdCLliOO264DAouP
	eGSXlqBgIyB+vrfa0cvujftw+FYOeRZXVur8WpZEzwgZ8hTVdFm0ij4wRCB1YNMP3RVPuI
	HRHHw2d+7GfkngSuJ72jakqfGEak/5t6tVEAyjtI0qZ01iMp+b4y+xkYctuIRw==
Message-ID: <51f5f79a-ed6a-4c7a-809a-f0507ae7a561@bootlin.com>
Date: Wed, 28 Oct 2026 08:10:30 +0100
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
Subject: Re: [PATCH] net: phy: only remove owned topology entries
To: Jiale Yao <yaojiale02@163.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christophe Leroy <chleroy@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261028050312.126508-1-yaojiale02@163.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261028050312.126508-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/28/26 06:03, Jiale Yao wrote:
> phy_link_topo_add_phy() can fail to insert a PHY when its saved index is
> already occupied.

It's unclear to me how this can happen in real life...

>  Its caller may subsequently run the normal detach
> path.  phy_link_topo_del_phy() then unconditionally removes the entry at
> that index, including its ports, even though the entry belongs to a
> different PHY.
> 
> Look up the topology entry first and only remove the PHY and its ports
> when the entry belongs to the PHY being detached.

Maxime

