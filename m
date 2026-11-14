Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794662358;
	b=CZJK60lVPjp6iEnjZFERdA602PZ+hpju4SXtlj+1TKFHSyF/uwpXcZFSjHLBtJpnqz4e
	 ehe45SuE+QLOXVaDhb/h1YD814Ah6LVC064PWNaY1+rmbbj9rnTWQsvonlSVm+g9h4Ius
	 TlhLSDme0aGpyHH2IA9+1XVI5HA/Aw26k4Ex2SgNZexErnQ6KlOykkKiwNIN98GcXQ1o2
	 2xP7tELK+XQ5Xmy/MAzFfGL6XCNylPW5s5GOsidXX8Jii4KuNDeqBej4mkBbZNtES2deW
	 afBwp+EUE3iEUqnwSte5BIpn2ENQKYFTrXTI1oRFG9uTJavFqYzsgLPRGx4jiGUm4ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wxTYhvRvzFYh+gzRWgScWVeMkBBcGFa2zq2R3c9b1pU=;
	b=N7FP6Pl9LWDPtM3ok4Z6BOJoLjKoiT0xwQGrzY3qmrtIkEuGCmNjOLsNzOS3PZQB1k8k
	 JxSfByOHWdeht5T6hSweR+IL3Td5DNU7xYUs60yf61Y3DO1fTtrX0kGJ2TIeYNPxNpWF1
	 UjLirWQWJUtVU7M7j0iZ78EOmO3kIYRfR9T01JTvQhLcHfZ/UuD0VrLtRiRZ2zcVxSwj2
	 EPVyPO5CbpP77KVDVYNF4cTKrmihW0MLtHunJw/JtQX2Xr80duLGQIujRVAcKvU0T72VI
	 Q5KuAFbsXOxracctPA+1OCN7ZzoETblTa1DalDGXuyulKYMO1X1Ufa3pn6uIPQMmjhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	dkim=pass header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=AIhhcIk8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B674606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 13:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B674606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=AIhhcIk8
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4697404c2bso296406466b.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:19:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794662356; cv=none;
        d=google.com; s=arc-20260327;
        b=dFL4iEfyk9fUpGoaNubPQs8XDULG3BH51//Aasmz0e5roNJ99Irr3NrB8HXPdALk4v
         wd3cKXcnNRbzX8gg7BXrkT4N203aRfYSjjMIzphNpJN+gCMjJu2GheAxbaClQg9dp0Xx
         BLBR3Udd8H7IqMSxFlp1lgSi0oWRLxA4syQDHUMqrV+Qa86dY5YtS9K5i9XSWNNyubrK
         pA1g5m2pixuElThrtnUdrz0p7Ssx4TBZ3kfkexnV2oYXTHLaU6euFIWi00u2mzSRxlqO
         xBySRxEhFjnmwLTaA/9SCAdj2wQKCD0i6pOq94bXiDuRKCQRi4aoZL/Te+Lwy4I+fgsJ
         lANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wxTYhvRvzFYh+gzRWgScWVeMkBBcGFa2zq2R3c9b1pU=;
        fh=SlVsBihugW2dFU0xa6OvGojldNjl02Y9qetvK9mhNnk=;
        b=moXGAuy1nvsw3DduDVipMx3Xxg02D4x3PnObnj9xphPoFajYpYfQji/mzvH1Qac/SU
         J8cRG8Rq0bmjlVyY3FSSejkNLP+zxusMSVKKffjE3b7LX7BlMEhwI9UTnRp9nyru0pQl
         Yh4lRlg3dCIqcCMWRi2SByL2fjfSMTEEzNvueWtMGx8OUkYbuT9q/y8nzxY2prXOPSzo
         kiCaybL5zjnfuAGXVd6sq4GkHkHoU3aMa7Xn06L9x04+544A7L3JBQD71q9kyVR5O8N+
         AgS985T5TJJ1PWJH0dGR9ffbU74dy/+1iysMHeTat8x2m1WN827Izg4e4wv7wB2Asd7b
         XBeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grische.xyz; s=google; t=1794662356; x=1795267156; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wxTYhvRvzFYh+gzRWgScWVeMkBBcGFa2zq2R3c9b1pU=;
        b=AIhhcIk85BpB5XYi6cQKrNiT+cwhJuJ1jWvI4eV3TZOOah99AEdPKxD0Qi3qUD1vqS
         pRwkjuvf66o/kCetMo/LYQ3YQqacYyIiBzGmz3Z50wqEcBxLPUXevRrE58C0b0nlHE19
         rM4F6FX0Z4g/lOcbUqCZx5+hWvwx+cdKZ/ctH5H8u+CPcnjZ0TYa8L6a+aDHLI6g1H3a
         DZPvtV6IiS7DzEti0DNFEUrwRXgAAPLZDuaYY/feNgGzDL1u6ERtphD/ewuSaNIqVBN2
         yTNVNqXW3PVlCzIaoVLUkxAmFwhutRm76yxDgwl/L6fRhnxPTKrTNOK/jyoyouFqow5Q
         aJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662356; x=1795267156;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wxTYhvRvzFYh+gzRWgScWVeMkBBcGFa2zq2R3c9b1pU=;
        b=Y2zc3OXl5lAAksjZzWTLrZvIydKahuba75p9MJEcR1V8bxjLF0AL8cj6kDDmVyXx34
         EHOXTLJqboLvbrQgl8k3bX+OiDjlb6VXvQE47EolkSJXswu4Tbv+AsaSquccDUGYfAfQ
         Rck5RHe9fZufLGC2cRg0fA3ieziwZURnXHMpR8lWcC5RdQaJAV64JO9YKAXdlA8G9TOi
         4jPLBMElwkCWwqFSBsZcdRsT2pSfhOjoFoikCiKR6TbCRzLtVC+Yz/kKIZr3ytDtFBuR
         6jeIn2b64wxB/Bvt1PX0hyLTSNF0x27c4B0jYbrdZa0wMvos8V/sDUjEhCZN5IeG3/7O
         CsFw==
X-Forwarded-Encrypted: i=1; AL+hErHiPfzF2ZE6vOZW8nMr+4AUVb/aL90Ns1B9K8ZWBJyCqI1LrV70XiwpdktY9nYKN/F3BV6Ca1o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/o/yNlsih+8A35M35IXmnORm94GpoOfKKmSSry4en5BY/txK83
	xTOGtRQwTcJuLyIZhyJ9r82rVM1Za0mQO35Qre7Adt1iMYwyZROPg5wlPiTrik80hudPxmNxdNh
	XhdsC2VqYKpwJVgmNxd3J5w+PCarEEvZfghxGslDtxQ==
X-Gm-Gg: AYBFou1qdRZ76ufq2oEHUVxv1MoYK2HaM+XtDjiklL+r6Rg+q9G1zQKK6Ch9STHmKsd
	SbWJF05qbFB4QfGvCDWmEiHww7ncxIMvtJ/NDeMLJHHLaI2Nn///QIfNV3slKLt117fXRlu/Ei4
	sfxOkkiGAEDwzSFcIZLJn8x7vEtqJIc9n0Kd25ZTc1BdEkFzSk4gLkSCxEFgsk+gO1aCVg1MWRt
	xNxbFbdhRw8ELzTs4+48JHQckD6c4EIKLB6pmvGIsyQ/DctP7W3u+35o0Ch/hPurWTpwkfJOr02
	vhNsZeLr+MScNmyCYF4ZA/ggUg+o0txkzBgDcbsKRXdRJwjIgHok4Uwl1bbi/S/Rzewr4V7g+PK
	DSp0/d33+BhWQGvP+cm2pGC0eRCndCjkbIPTZLyLdBSdzJQIhCvE2wdzs9KanckGLMuLwj0E=
X-Received: by 2002:a17:907:9622:b0:c3f:dce3:20c5 with SMTP id
 a640c23a62f3a-c50968394b6mr566230866b.44.1794662356386; Sat, 14 Nov 2026
 05:19:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104151914.2651241-1-opensource@grische.xyz> <20261104151914.2651241-3-opensource@grische.xyz>
In-Reply-To: <20261104151914.2651241-3-opensource@grische.xyz>
From: Christian Schmidbauer <opensource@grische.xyz>
Date: Sat, 14 Nov 2026 14:18:51 +0100
X-Gm-Features: AclHuK-t4Vi3tD5hB2DBl1bIr6nwi9vm4FOrc1kbogOcAMqHwa7CaPoB_seqTKw
Message-ID: <CALsH2cy0OUN+6EA3Jt0e8B5JGGhVpyR=EuFOaJvxOv-LnfOOvw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net: stmmac: dwmac1000: don't discard frames
 with only a checksum error
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	Oleksij Rempel <o.rempel@pengutronix.de>, stable@vger.kernel.org, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@nokia.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Replying to the Sashiko review [1]:

> Suppose the MAC sets ES on an oversized frame with a valid FCS only
> because of bit 7. Is that frame still dropped here?

No. In threshold Rx mode it reaches the stack if it fits one Rx buffer.
It is marked CHECKSUM_UNNECESSARY only when Rx COE is on and the
engine reported no error for it.

> The giant-frame status is also no longer recorded anywhere.
> [...]
> Could the status parser be told what bit 7 means (Rx COE enabled and
> its type, ATDS or advanced timestamping)? Then bit 7 could be part of
> the mask whenever it means Giant Frame.

Dropping or counting such a frame needs a new argument for the
rx_status callback, which all four descriptor implementations and both
Rx paths use. I would rather not change that interface in a fix for
net in order to drop an intact frame, and I have no testing hardware
on which bit 7 reports a giant frame.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/message/20261104151914.2651241-3-opensource%40grische.xyz
