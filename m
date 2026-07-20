Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A228BAB9;
	Mon, 20 Jul 2026 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537264; cv=none; b=a+Gl5803KE8zlz7xn1yUGNGn/trrJnFwbt0A1MWzQt7JzgCyXFBIweEdJom+Zwm5PhtXFDtpNyPMlnoozGVitwpoopdcbuf3JVPhuHe1uQ5RDeplMyIEFLlIVBRj6LamUE85SoNod4mu+pKdhw3CxOCePXuQHzM3Yiw8b16Kwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537264; c=relaxed/simple;
	bh=ZnhFQyewYKmyoAqvB4yI+wGCCC0zn3M2BcBBJbRESOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBfDBbD3aRtwLm0YnlRbOzpXsTMCmjwYyJDANNj3BRsDC7j7PPuGqwYnaqwFFWdRC3maUeUz473MCu2tsCn2gf3LJeO24bwfxO6r/wLmxK7HxcCUlr/sYK2RHJrSOHbHc/EhPRSjZSKr6d8IcgKLhAhqU5Vrvxc+KfYZ+Q/CC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cvH98gEm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cvH98gEm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E4E0E1A110E;
	Mon, 20 Jul 2026 08:47:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B624460360;
	Mon, 20 Jul 2026 08:47:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 258E711BD3CC1;
	Mon, 20 Jul 2026 10:47:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784537258; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XDL4wqc8Z6zFPpAxeBKiakA7/RFAo9ZoLAqc9tb3T+w=;
	b=cvH98gEmTMUpb50WmIRVsmV/+eXjj/owynsms7sn3NU+lyomg6uWtR2ZSzs5ND/oBTWH6s
	qbZ4BnAiFeaDkQzpD/GgeOUe2PfiCJw+kc3kz10cP3Yp4qynDvfIq1jRr7u+6vxzIW9xOx
	6/rx9m1WUPH5OT9UisUOtC500SPPGpYdqXI0NANc/bq57YjhqnqOYldo3UlZOQoHwyUnAT
	mabkG6CHQBUjLVJNMTPh5LrEqBNv0Ay5YjMWDNyjL0RPzrUHOPXxKYGz4zOGWjBkutAgp+
	DzcuvVioY/r6scIMRvUSU+U40RxvDxUpcGOwGMwB9FD7lRkRLpE5x7euAsMC0A==
Message-ID: <fbb4b98f-9978-4f6d-a2c3-f00d255ead45@bootlin.com>
Date: Mon, 20 Jul 2026 10:47:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: pcs: xpcs: fix SGMII state reading
To: Coia Prant <coiaprant@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260717074324.3250043-2-coiaprant@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260717074324.3250043-2-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/17/26 09:43, Coia Prant wrote:
> Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
> added a path in xpcs_get_state_c37_sgmii() that reads speed/duplex from
> BMCR after AN completes. However, BMCR does not reflect the negotiated
> result on the hardware where this has been tested:
> 
> - On RK3568 (MAC side SGMII), BMCR returns a fixed hardware reset value
> - Wangxun engineer Jiawen Wu confirmed that on their side, "BMCR looks
>   like it only wants to be return as 0" [0]
> 
> The correct information is available in CL37_ANSGM_STS, which contains
> the actual link status and negotiated speed/duplex.
> 
> This bug was previously masked by phylink core, which overrides the PCS
> link state with the PHY state when a PHY is present:
> 
>         /* If we have a phy, the "up" state is the union of both the
>          * PHY and the MAC
>          */
>         if (phy)
>                 link_state.link &= pl->phy_state.link;
> 
> Thus, when the link is down, the PHY's link_down state is applied on top
> of whatever the PCS reports, hiding the broken PCS state reading path.
> 
> Modify xpcs_get_state_c37_sgmii() to:
> 1. Read link state from CL37_ANSGM_STS
> 2. If link is up, report speed/duplex from CL37_ANSGM_STS
> 3. Remove the broken BMCR reading path entirely
> 
> Also properly set state->an_complete to reflect the AN completion status,
> and clear CL37_ANCMPLT_INTR when link is down to avoid stale state.
> 
> [0] https://lore.kernel.org/all/000c01dd1593$2ac0b0f0$804212d0$@trustnetic.com/
> 
> Fixes: 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
> Cc: stable@vger.kernel.org
> Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

Give that a test on ksz9477 that has an older XPCS for SGMII, this makes some
sense to me and no regressions were found.

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

