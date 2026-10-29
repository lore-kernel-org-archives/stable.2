Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.237
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301125;
	b=Cea7Tp57h5KI8YgL0jDoT5Gde9vvtisldIa1n25Gj/cY3mLH28Fljo9NtdbWdnLqBs65
	 41F2WvROeih5xkn6wVuenXP90/LvQPl8OJctwELF/gK9wO1Q2dVrLHDPVciIGMpoTAUD+
	 1YbE+DVORwiT5b7x/i9GsyhzEmd1ZMRaX6dQqBzUHbe0MJJMKFH7GBYkk46SXiCLq4ykt
	 UcrMkbZVAYYF5S2CQz2+qx+N5/1/P1U2u9pECHIt9qT9TtPX9e0+9MVKNR+D2kJOk+cbm
	 y0eqv5trM56a30A8qLQ9qxWeJjjYPYIkoxZITuH80AqX1VcbrqBzEKfV0mWz6HU3NbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301125;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=dhVNqyPxm3jM+00wO9DouSQBRFyH0+S1340RWBDvsr0=;
	b=Fisa3QMiN2h+lNQodKL/IHlxittPajwygIpPnEoC8XurEFiCuh0JBF+USkOI3u24RIQE
	 3tv6kkqOmX9NqGsmz4l7KuPTn42jdEYebvO729yB639Em2Edrme5U2JC5tRYKKCkKxrwb
	 EyLdHE1UTMQFq+DaYdKsoAQ+4oGVpnQ6s7fu1CjJLjzP8MRgKcpThZ/UyuJtkUY1BASH0
	 FbOE1PQcyu5Nh5QJJVtn1Wb0Ojn4WlV0XD4dDM+AgTOPhWGW48L0JVJ74WLustIKj4ciH
	 cTiMT9GqOxhncaAc5op43x0XLNhcgd15Wj/gzPDUZ1d4bcyEGfjdIiEnam1hT1kjRcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d01jpjsA;
	arc=none smtp.remote-ip=91.218.175.237
Received: from mta0.migadu.com (out-237.mta0.migadu.com [91.218.175.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75C606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E75C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d01jpjsA
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dhVNqyPxm3jM+00wO9DouSQBRFyH0+S1340RWBDvsr0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793301122; v=1; x=1793905922;
 b=d01jpjsAjhMuOHE0Rt+t1FBknfO9gKlbuquLkonLxnbuHOCNyEfiWZPUuc/kgXJhIPTYLpU/
 yFNeN2+SDwXekjbXQBm4ZFFRNgqHaqL2zmjs7tFsdA/Gi1WIXJghrnjFIcyeTTUg9IPnoDkB1OU
 0hTZ9ZBn0sm8P8ePWKUrHRX8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c34306586687ba84;
	Thu, 29 Oct 2026 19:12:02 +0000
X-Mizu-Trace-ID: c34306586687ba84
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so1983e87.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:11:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx5zZbiDuIS+5td9GxJYVsq/V6X5O3cOnm7Z4ilSc/DnZ3ciNF5RZnNhihYVPp3Rq6T9XMSxUo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKq2usxe/XN1cA7MYYjsJtqpY8M4X6864um8fj9kAMAu9YoBipx
	D0Vb7RVPbqsjXIxdAVB6wSxD/TT7RA6k7Y3jTshWG5WAr9wjVDHyCTOsnapGamAKr5XZ9HSN7sQ
	3vSOUxgwRHPjdZJ0QqX5w2TymIymeMMoe4OVTGp8Y
X-Received: by 2002:a05:6512:10c1:b0:5bf:c3e1:532b with SMTP id
 2adb3069b0e04-5bfd13f5375mr256926e87.5.1793301116286; Thu, 29 Oct 2026
 12:11:56 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029090522.64662-1-oupton@kernel.org> <CA+EHjTz-kXVbzcjtMte8B26f0Undr+kWjF2-d0B8TLT8n03hJg@mail.gmail.com>
 <86ld7gydqp.wl-maz@kernel.org> <CA+EHjTw0EjMHKOH8s0F6PZRR7WkmRJJrMrqTzpYoP9gm5n_9Gg@mail.gmail.com>
 <auOSYE97K5y19DAy@kernel.org>
In-Reply-To: <auOSYE97K5y19DAy@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 29 Oct 2026 19:11:20 +0000
X-Gmail-Original-Message-ID: <CA+EHjTw0vSqbP3mbg+Sy=VFcXByM6p=Z2BbMHXpQEamZu8Evxg@mail.gmail.com>
X-Gm-Features: AclHuK9KN3ZShpCMVtHDwjAltyq7vN_HmIZYhtTuwLuiqVNd0XSq_WHTMUo5iCo
Message-ID: <CA+EHjTw0vSqbP3mbg+Sy=VFcXByM6p=Z2BbMHXpQEamZu8Evxg@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: nv: Respect HA when computing translated TCR
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Oct 2026 at 18:37, Oliver Upton <oupton@kernel.org> wrote:
[...]
>
> This is definitely helpful but my understanding is that the pseudocode
> is *not* authoritative. I think the line "If a translation table hardware
> update is not atomic as observed by other agents ..." in R_NNNMB gives
> an implementation enough freedom to decide something Non-Shareable at S1
> is actually atomic after the result of S2 translation (e.g. S2FWB).

I was under the impression that the pseudocode was more authoritative
than the textual description (bugs aside, which the text can also
have). Maybe someone at ARM could help settle this? :)

> So if the implementation decides it is atomic, no MMU fault is generated
> and the update happens like normal. Now, with that being IMP DEF there's
> a good chance the behavior can vary, like we saw on the output of
> translation on N3 [*].
>
> I'll add another patch to propagate SH0 and HPD, thanks Fuad.

Thanks!
/fuad
