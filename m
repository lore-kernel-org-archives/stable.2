Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E582123EAA6;
	Wed, 30 Sep 2026 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732733; cv=none; b=fcF2sGVNxVfVEDWQ+/mfTSXaU46yf3sl+JGwaXo5kFbuYcdI4oqR+b65xACA9K18xDp6qZ5ZO9msVJsoqi0XfrxAR8DUAQaflOQPN95Tb+8EIcrIxgpK2j/2BkyLtRgtcZEAnPHd4I9AUJZGzxWJo5B0ifocpHu+wrFTnjHuNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732733; c=relaxed/simple;
	bh=oYqIi495rAMQhi6h+vSrjdhsHcTJptJcAwm3flZqXZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogQkOj7h0mCiYmewsigOtd8KUuszDX0U91LLEXKhPveZ4oPETM2faTqoDL0euEjroQ/nwuTVOpNLa5E466v8auyNE6PL/z9a1I/nChw6BbuDe16wMYpAdt6oVpuSCTUul7vyX6EQm64GXBy0JQ3I6XyFWrBk3m3Z3U5RaWbkBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmkH4gja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmkH4gja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20541F000FF;
	Wed, 30 Sep 2026 01:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732732;
	bh=oYqIi495rAMQhi6h+vSrjdhsHcTJptJcAwm3flZqXZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VmkH4gjaufsJUd9+6IjlXAO7CaFOF3EAlX8oknO7ARzt0NdIp8Jef/dMt7+2DUJKA
	 WNHkrN08omaicHE7AUbTGJTL2McPBXfIJpBmr+c+JTDuifEOTeZV3ik3gwdKpyH3s6
	 Syu7eYqfWQQt6SPBmx+5tWTc52KBR+a2BX2WHDn3zHKrlHxpRmSkW3m6nx5PyDLOSW
	 oqL/TxulXHBgOddDMXs+4dQSKu2RfZd3JA0siG42rbFB6IPbBDytQOlI6LMhBPl1/P
	 9PQ68tdDEfJTiD4bL09txrYM4w6rNF8qFCmMLaC0z3GankmeUWB5ka65PAaQg8Plne
	 imqf7ZiwZc+XA==
Date: Tue, 29 Sep 2026 18:45:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, Antoine Tenart <atenart@kernel.org>, Eric
 Dumazet <edumazet@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: macb: never give hardware a NULL RX
 buffer
Message-ID: <20260929184531.36ac3dc3@kernel.org>
In-Reply-To: <20260925-macb-close-v2-1-360efa565914@bootlin.com>
References: <20260925-macb-close-v2-0-360efa565914@bootlin.com>
	<20260925-macb-close-v2-1-360efa565914@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Sep 2026 15:59:34 +0200 Th=C3=A9o Lebrun wrote:
> Theoretical bugfix, never encountered in practice. To reproduce,
> introduce memory pressure (less than 512 SKBs of free memory) and open
> the interface.

Since Linus is pushing back on our number of Fixes let's go for
net-next with similar fixes until the merge window
