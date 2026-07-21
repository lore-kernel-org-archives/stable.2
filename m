Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8335959;
	Tue, 21 Jul 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593475; cv=none; b=WPD8v/+6F2ryvtwAn1FfM1Icg+7fGhDEoXP3FOrrK5YAI4jNaeYda/8Y9Qt+cIR9nplXctAJ0tngPfwdH0rpz4Qwoot9U0iSiJNB5BNpA9JAwEb8CTt1ckICQSrkpQYdiqgNxYrHIMb/xhuU9cJmjxpoGrTYHHHMOStbmEXEUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593475; c=relaxed/simple;
	bh=BXpZtrxRybyoSjR1bDcpD3Vvb5PryGt1uuKt2S3QQOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBjPU1Fu4c1PayH2JBICMmVb61JHM272BypQg0zlKQVOVNPic//OB1fSXRM7zrS3PHG4FMGIU2N2bXaCwd++tnwr1wh01mRGe0DJUCD+0w83Rxsa6F4hvvT1u9+JNO8IpTs+V5HMoCEnk6YPzmAvAaSGP8NnF265GfDThLr8as8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIoNEwId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIoNEwId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC7E1F000E9;
	Tue, 21 Jul 2026 00:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593473;
	bh=2uNMqNzihP1ioQndeO5CaMIS+dhV8QtzKEA6cu4BN8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IIoNEwIdN1CYg/VTVNQtktedSxOVF/VPoKz/1bFb+Q4D2lwOpEn1FE6br528chA39
	 hGtUk5M1GAi0FUYmW5AHwc3aUS1GJ0R3MW9pd51A4h0PurAbldOGAkne8TMGBZ4TrW
	 aLtfKzJqeDzD9pQH5IRXG7svVSGyfiNNwU4JlFnrunC+C3Pmv9ttLWlX6hsrAmbRP3
	 kISDjBBZBcOVtBXqBNifkCiSJDjssJ06EbfWD4cti3deTwd453TcClMNayzERXOTjc
	 1NFYExf5M5KBj152iBNczNanvtTRbTzx//OzghL04mvf9WM9eZgImDBkx67EevE9ai
	 MornF/TCCy34Q==
Date: Mon, 20 Jul 2026 17:24:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: pcs: xpcs-plat: fix runtime PM initialization
Message-ID: <20260720172433.77b83dc7@kernel.org>
In-Reply-To: <20260704214808.1566710-1-coiaprant@gmail.com>
References: <20260704214808.1566710-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jul 2026 05:48:08 +0800 Coia Prant wrote:
> The driver calls `pm_runtime_set_active()` before runtime PM is enabled,
> and before the clock is prepared and enabled.
> 
> This causes the clock to be unprepared/disabled later in the suspend
> callback even though it was never prepared/enabled, resulting in warnings:
> 
> clk_csr already disabled
> clk_csr already unprepared
> 
> Fix this by setting the initial runtime PM status to SUSPENDED instead
> of ACTIVE.
> 
> The clock will be properly enabled when the device is first resumed
> via runtime PM (e.g., during MDIO access).

Seems a bit odd that this hasn't been discovered until now.
Could you add more details about your platform and maybe
a hypothesis why we haven't noticed?
