Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453628;
	b=UDDsaJKVdAgvbIrtku9ec5gy/TotjR1BTw8/3vY/Kombcu/KKC22+EwkmffvGkP4tD/k
	 ieWI1Tzhe7lXtDl2WsHW46VPuobn9Y42AF6pmcH9GP6zxfZEn/JVbCvHJFg8pkTlZH6Sh
	 dG+/NtwObhx9qlOjzRFfo2qL4xfrjE9x39UFocw3mr0okFeEm2v9JZ3IL+w5rvXyU+QrZ
	 Ixa8WpHcaP60YqQys8o2Zjniz+S3CK9Na1jqhjOqlZAsSog07RJk4Sv9+RSAJKv5P0BxU
	 4thhEprGfOF48es5D665o10NevJCMgEp5Br43IJhF+04KWFA0QFDVoqVcTqRwr0fn4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453628;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EFL7RVpbg7eriH3AqFHCOPDeyuNL9tU0pmOU4dQ3GNo=;
	b=xYbXo3oQdg0BFqND7EiBuqStJz5GpDguis6WL3RzNwft3efYAsNqcCo4MFkigC0kSHN3
	 Oeb2gpGVODqC6m9G9pHyLk8kRyn8FhCwL546IM2HubTG7+ggvwEpDVMNWbiBmFt8qg7/a
	 I+ZadWLOZaCAz9Izp9T43eVMlDcpkCiqzKLIOMGRte0muDqGx9tfM+JEm6J8u6/cT63W2
	 fGXYxZ/LWO029uaZ0Q40HP8CRG64VUHp3NO6uIikhtcjrkX1EXrEks7l2BZrXL/NVqfp+
	 hr3+5ZnxM6dwLssHD+RadwkS8E66s578jwxcMhCEKiTAjfYid8jDkDEQkx9OgXrH93g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkNO5Vms;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BE606A319;
	Mon, 19 Oct 2026 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkNO5Vms
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105D01F000CA;
	Mon, 19 Oct 2026 23:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792453627;
	bh=EFL7RVpbg7eriH3AqFHCOPDeyuNL9tU0pmOU4dQ3GNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HkNO5VmsfqpvG/7vRrBgfU91eqwkT1MX3sTjDgM8GKYkx0ViU8U7t0SJvD09DTS3t
	 Q2EXPQn8H0K09q7ETipsFThUXltWdeOtAr2mxBknhJb63F1pUc81xDLqkIEwRnA6Gk
	 pWjPRYZ7babLd4jmQKpAU62p80/xRq18B20D+yB/ADhnzUKPLepzriDfF2FrY+c09J
	 1gdCEEIUFtPEZvRKO5KbFYhGtpwaCO2g71+zTYNzD3Iq+TpEAR5Ozbe24xBUw43KUv
	 28GNFop3mPASUcEG1IgRjTxWMVdwU0uYJ6+uNhrCxml00Zf9ctyI0pdqLuHxCMMlR/
	 lQ0hkLE2WlBfA==
Date: Mon, 19 Oct 2026 16:47:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Alexander Duyck <alexanderduyck@fb.com>, netdev@vger.kernel.org,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Dimitri Daskalakis
 <daskald@meta.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, Bobby Eshleman
 <bobbyeshleman@meta.com>, Daniel Zahka <daniel.zahka@gmail.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/5] eth: fbnic: harden Rx and Tx completion
 handling
Message-ID: <20261019164706.5c4e9335@kernel.org>
In-Reply-To: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 13:15:55 +0900 Yehyeong Lee wrote:
> The Rx and Tx completion descriptors carry buffer ids, offsets and
> lengths that the device writes and the driver consumes without
> validating. v2 bounded the Rx buffer index against the array only, which
> the review found insufficient: an in-range id naming an unposted slot
> still reaches a NULL page, a bare META completion still builds an skb from
> a NULL buffer, and the offset, length and the Tx completion head are not
> checked at all.

AFAIU we are not required to add silly safety checks to fast path of
PCIe and SoC drivers. They can be assumed non-malicious. 

Please don't waste our time.
-- 
pw-bot: reject
