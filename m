Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603223;
	b=ohUn2tYxcpdvg2BMi8r31nkO5W6bVjJ0fMxBnO9NLgq3+xazjmWCun0IcHqgQAEDLoq/
	 e4PU17zBS7cfXA5UvaX0TlSCeiPPrxBTB1M+9ca7ayApm0g6RyuNzwkZWhx9rRYg8saL0
	 Dz5a/0eCEb/dRqda+aSpFB8zihRbKyXsD7/UWCYI2twCrQqtUc4T1iBoqKiwjG9F9rXuh
	 C8zXHysB5Yi7ik3B9Tzoz4ILfgIa2Fk1bl1Ls8HpMzVAEyQZuSyZkQW/RcJeJJWsvIib2
	 TneQg66RjIJWbrQlh1BquG2Vf1Pd4xPEQQ74wdnw3IKPnp/56Wrzb18su4FRownOmbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603223;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=34E+JD94HLu2tQOT261thhU4F4zT9kW4NNRZx9aDA0o=;
	b=PKrktkDJStugOaLq4EOTZEVensQ/tjJJVHspaz/bY7830D4sMnSG74TNHfWGrhmQDxU0
	 6LMe9FObuuti6AvZUk8qk0jIcN5tfUeUecuNeNm0DyLEAuMUWSOBZHVmjkjdf9d7MJNs0
	 luGKQMS0ARPNBZAqI+i3nmE+I0VJRQD0o94mMnt9Ernp7sMS7lP+H7ZJJcndxr8t6xGUG
	 y9LzxY7r7yyFVyf/LjYodH83VXqmgsBQj1DfFVM9JgQxM3mSyMC1/FtAMIX9Z+W9qINUl
	 C9OipFnamwwwE6qS5m58cPog1Iy0PEE6rddJmvmw88i7MD+7GWGQbTM+7M33gHU3L7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=l8mmBT7X;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2453F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=l8mmBT7X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=34E+
	JD94HLu2tQOT261thhU4F4zT9kW4NNRZx9aDA0o=; b=l8mmBT7XZj6ypCWdj5kB
	YJ1PzztPYgyH9gCD0lPrnZSR9TY2N0DxnZwVQEwxvWa+OU8l3KYa8j9rrjISygcR
	iCMVBUhMwPef/FpHJACfPbHGhZ5naoEG6czTIL5lvLFw1GSot6pWDyFmXdQBOORQ
	Z02YeT4NtgjaZCulTGLRSEEYDd0PVfHb5DoT1FLqI/MR3C3ALb93ZQ/gL0mBYUHP
	eOfHEnxdVkqq/oWekyI5n95buYF4pzGOSL6Pgtvf2fB9EKqAnkXPVwdTYRgU8ISi
	Cyp9n/tYj2Tpl8tnarE79a/sUF1aoVWJ6Ps8BLt1uzvWD4pRsOffqJkNiMW6XZJl
	gA==
Received: (qmail 881287 invoked from network); 25 Nov 2026 11:40:11 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2026 11:40:11 +0100
X-UD-Smtp-Session: l3s3148p1@Q3OWcxdhlMAujnvc
Date: Wed, 25 Nov 2026 11:40:11 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Diogo Ivo <diogo.ivo.sx@renesas.com>
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i3c: renesas: Fix MDYAD(x) field length
Message-ID: <awa7C9LO_9Gr8htO@ninjato>
References: <20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-v1-1-2250225e6d20@renesas.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-v1-1-2250225e6d20@renesas.com>

On Thu, Oct 01, 2026 at 04:10:09PM +0100, Diogo Ivo wrote:
> Fix the length of the MDYAD(x) macro to be 7 bits as it represents an
> I3C address, which is 7 bits. The length of this field was confirmed on
> the documentation of the RZ/G3{E,L,S} SoCs.
> 
> Fixes: d028219a9f148 ("i3c: master: Add basic driver for the Renesas I3C controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

This is true for R-Car X5H as well. Thanks!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

