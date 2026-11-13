Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587935;
	b=z3q5qSqxG2IBLb7tOMjDg++8201tt1MP3T67iz6xp088fCcO5JIriB867DIrKIsR/jxh
	 M11r7Q+orc4vNasim2cJWmcwA7Ssqf4LR5RfoeTQnK+uDvn1MnVMH6gBdNZ5HWXRL0pSy
	 ovlCLkbgyA2hsmTVtmm0eKyiTEuBBiN2l8U3ryoDIStBFo16QiMRrLptmN4APYt2aE8Za
	 uf4jDy9hCEQxVK2jDeULHMz3uuE9MaO2J9ya2cZVSB3cFXRtGSYvgrAlxaouA4zWQCWYD
	 BaufXgDQqh3j8KODgWbHMX1fzMwKWuUmP3oC7qEIqg3HbXIhH1pzGwNKI6qLjXanGqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587935;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=gH3CZXGVnaleLARVDgeZM4UQpSj6R/OFXMTA8fFzluc=;
	b=KwFABLDnBUdmc1tlRV07q9S1TJkTuik0iAkxzCESpjjX4WizeAMJ5Wu5mwbozwyP1My5
	 G6TnuDI0Lt12p0kNNpUUYIc2dZ3DLssyLvB85XF7L/tB9YIu4jHgNGOrZncw+knEsfoHB
	 Jsthk6M2SCWObFc14qK6dSvQqsC4O2W7M4mGxflAP2c2RFwbMILxoxUrRC8o78fuYIR0N
	 77LV0M3dKG7AEjGU3PyTM1O43GiQY8T8DTRTKsaG/Z83ji1Gp+yxUXCTS9Ube+uQEzD2/
	 0UXvgW/UaMBFkQa2LElq1As96tGkSqh33qWLXh2P9MiCeluSdLylBzLXZtSkcL4LkxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wfzVIYff;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=I6Wuk7Qa;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03CC60A3819;
	Fri, 13 Nov 2026 16:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B03CC60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wfzVIYff;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=I6Wuk7Qa
Date: Fri, 13 Nov 2026 17:38:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794587933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gH3CZXGVnaleLARVDgeZM4UQpSj6R/OFXMTA8fFzluc=;
	b=wfzVIYfftE0HHF9yKjxkeaEVP1+yl6DsASG+DK2LnwyJ0DFU0esyjxnUa+pX2JS1rt9mJ6
	FoWydEUkjoAWDqsxqPMPXWNIBeAj00pE5UceuG9s+m88FRMUNqHMAM+O+1rNQiGAKkSCG6
	GjoiogSzdPYNu1Lup65fpWHzUcaXVAtb06QZNiVQQfRY9Lcgt8rtXMuOavur5ycTwwbO1W
	PTdMFUvITLGe2Eqoly9vj6TjUlj8LLuo5SnOXn2x+bKjdV7XPz1gxZngn7lv5pCJ9ngQ+z
	scFra9frtPGDYa9Nl/+zX4S0xcVluzL0KErHpMbgqCdfb8ZwqiPAZhcf3YArig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794587933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gH3CZXGVnaleLARVDgeZM4UQpSj6R/OFXMTA8fFzluc=;
	b=I6Wuk7QaZXoZ9SdOYfmEj36SgZ1p2sY6Qk+wsx5vNxhca4I0UQ8ZAex9fN4Tbiyj0iKgtM
	09hCFfFkfta8zyAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com, lukma@denx.de, fmancera@suse.de,
	danishanwar@ti.com
Subject: Re: [PATCH net v9 0/4] net: hsr: fix super-packet forwarding
Message-ID: <20261113163851.eArRo3ag@linutronix.de>
References: <20261112153333.20-1-xiexinet@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112153333.20-1-xiexinet@gmail.com>

On 2026-11-12 16:33:29 [+0100], Xin Xie wrote:
> HSR and PRP tag, number and de-duplicate each frame on the wire. GRO
> and GSO can hand them one skb holding several frames, which the lower
> device then drops or which goes out with a single tag or RCT and
> sequence number.

I did not forget you. Thanks for the repost. I try to handle it before
Monday.

Sebastian
