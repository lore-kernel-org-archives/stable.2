Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180442;
	b=1lVWAspL5y079SE3Zv90YCpaFrhC3zh1Tj55ndvTp3O3pfouPBp/Wl/O3fIzHcvR0Ooy
	 0FgDVfZ0Cg0+ReCVrVut133cebK5av3nZq/qHFZX8PQnM78zHcKdMVdgEEwpV4YL79br5
	 WbNAXX4qQmGlMIyS214vdFQ987EQCfTwCjtqZ97vPSo0dQTEJ4pWGKae3po3eaCM5YHgS
	 O5I9mxq/L+4IK0QdN8IuX6nGnmAeFpdDpxdJgJDIJOQF+FwKvdouKulf+mIAtn/5U+4EK
	 AHKMSRIJAuiJXPXMVe/7U6cCdjqIlSLpEptE42kx3vkdEHz6TjCKxVvSKS3LO0mEOjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180442;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=ct9uYE0MzuKkAMie5CXMo99Xok8IAJAQ6knyjO+0/hE=;
	b=Ckrc6CZoRFA6xtKA35HfVmPlc7WvjxuqAazCilVqBZldZWyFmNUDpg6l6lavHzDpn79I
	 XEB7Mh60MpDBqtfKIabddacklIJ7bE/JCZUG+OXhWpSGOGLCdYMi+TgljQSvfd0z9+5EV
	 PzAdzNuX+iabOkUEaIhvJfp8EI0QrSfBux9e+Errj5G/zijRXG2TvaMzBKVqonT7UQLmi
	 qA9Re/Go0POcjLfqpd5BhIpgdiu3HLZFUmkRFCLjFO2QFZYdctZFAyclkhkdcizmqr+7f
	 BeX3naMOh9c0NQdwVWlTMiUcCAGxccOwOV8Cn58fp25xtWwGR6u/85qWHPiEOaXmnMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lt37JKR9;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED85606A325;
	Fri, 20 Nov 2026 13:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CED85606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lt37JKR9
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jWG4k1WDvzKmcF;
	Fri, 20 Nov 2026 14:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795180438; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ct9uYE0MzuKkAMie5CXMo99Xok8IAJAQ6knyjO+0/hE=;
	b=lt37JKR9rIh6DlBR0U+q0QMh6BHcGjljqKeNNe585NLbVM2ygPKRdX12oxxnuzcpj2ayN1
	LJJQNDX4/MMRlaGIF+wLLFH6IzidejaRKx9dlHHiKacZ8sZPi7e4OqG8KCBjBhbmbLSSzB
	pBTWzCfmfdsfRCQvMaKHBKA8OVJM5nn6+VazUHi6eMc5lo8F/PacL14BH//lG05dsaHvj9
	QLUevQvjcQfYH14M2k1oY4/x886KStGGfUKEhW/orEIha0Pz5Pjver2TZokT8jvQXrgWRa
	KO+Vr3ecu/cXkr6iqEGyhqoDtUnaocfjY8+oYSgjyWB8pbsNDekaQphEEnG8Eg==
Message-ID: <f8244837789536b0c339818a45aa3e6a52580a4e.camel@mailbox.org>
Subject: Re: [PATCH v4] dma-buf/dma-fence: Prevent misordering for error
 checks
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Simona
 Vetter	 <simona.vetter@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl
 <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 20 Nov 2026 14:13:55 +0100
In-Reply-To: <9a434a22-249b-4121-a390-95eaedb5ba6a@amd.com>
References: <20261120111615.2940647-2-phasta@kernel.org>
	 <9a434a22-249b-4121-a390-95eaedb5ba6a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: a7acc205da7b9c483bd
X-MBO-RS-META: ezmrjbsp5jwni611xb19k6cbdob6odsk

On Fri, 2026-11-20 at 13:36 +0100, Christian K=C3=B6nig wrote:
> On 11/20/26 12:16, Philipp Stanner wrote:
> > Ensure ordering for everyone evaluating the error code centrally by
> > using test_bit_acquire() in dma_fence_test_signaled_flag().
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Pushed it to misc-fixes. Thx.

P.
