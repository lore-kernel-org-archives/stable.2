Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181028;
	b=h18IBZHkB6BFr8Tas3bNyB4+FFs4vjlwOuUs/2OKxxHLwFM+ENQOD7H/oG1ZffUOrLTS
	 Ksu4dbJ6yhnxD22HfoWnE0wjFqmPafGHLHXQfuHN7F8+TZFaFOUgnQzfwZ0jFwU7nQeBM
	 g55eLLgqIPW4j+t9VIeUTkejn7NBzDvbUxcBd3UOIlfBVD6CQAWU83zjzogglkWRP/ezR
	 ypZ0S21mlPBeP4xB2G0ZHzfcH18viESPTirMqi8UYIYxb6TrqUyj+/Yt/qLXhANOZGA+q
	 tkMWXQ/Iftsu5YXeZDIIQPxCcagtogn4eUW7phWLNZ0ANw41RA82N2hAxpFl3teBK2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181028;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=sOqxMPdWLiPEPnbW/dainGjC9YwYsR76yz4ROyC6bYI=;
	b=0ZUie085c7VlyFNFn2C3p4v/R6o0UWtju//8t/TGnNzs4EEiAt8QEQ911DFy14wYhp92
	 ZMpkOHHprR+vEXQ0hEDS1kL67tG1pTG8TPFzU/S68+sScmSxxMkCwqOLSlWY3VsNyNvth
	 Oa2A1xqMsRTiswxbANvLtXcEpBeU4RjZ9gJGyGXdKCEiRAMiIxuCgJmwcByt5p1RYCRO0
	 AwMmG2stKT+Jl23m8C8r+d6gGimfN6e4s7E/s9InrFQwUS74ig6GZEyPwX657oj/72n77
	 r+DcvIyjv1oheDC7m2rqpsEM9QzS1f8FH0Jdop64TjCOylnGVBdi57ga6/l06B3FDmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=XCC4+jSY;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C6606A32A;
	Fri, 20 Nov 2026 13:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B3C6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=XCC4+jSY
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jWGHt6Zl2z8swc;
	Fri, 20 Nov 2026 14:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795181018; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOqxMPdWLiPEPnbW/dainGjC9YwYsR76yz4ROyC6bYI=;
	b=XCC4+jSYmTk/gDAFiCdj09c2SAjdcWEbCABInPrTuE7t3+gUyAf2QjJED1oQDKc3+6uHEd
	89nqaqpLs4H9GIbhHdWYzcC3otNZXO5oJmoL2J26fJrSlBzcyfViPGjk0iAu8xR8EsseMt
	NS26dou9nogpQwZ8Lre+ynmKF97lmgedpTGSZIUAPWjazm0BeWPhCFMHCUMSCOqSDb5SD+
	HHuLCdUtfw7OgHVbzRzsqTfgMBP0QBHZ/D1gHX+vWrT+rrCUgpHDIjHTP+qyEHe9i8HIeN
	ZH6NAWk7sPbEixSi8C/R1R9d98Fdb/QV6VDicxr4wIM4fYBh9+lF2u3Ue7nQKw==
Message-ID: <0e037df8633ca4b4f898d9d29be76bd569709eca.camel@mailbox.org>
Subject: Re: [PATCH 1/3] dma-buf/dma-fence: Ensure correct ordering in
 dma_fence_timestamp()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Simona
 Vetter	 <simona.vetter@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl
 <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>, Alex Deucher	
 <alexander.deucher@amd.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 20 Nov 2026 14:23:36 +0100
In-Reply-To: <1505a605-a5ba-4fed-bc91-89177faee4a0@amd.com>
References: <20261119131830.2535266-2-phasta@kernel.org>
	 <20261119131830.2535266-3-phasta@kernel.org>
	 <1505a605-a5ba-4fed-bc91-89177faee4a0@amd.com>
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
X-MBO-RS-ID: e03930609996b477a7e
X-MBO-RS-META: d87dhhig8ddq5unpkr33gdp69ergtxsd

On Fri, 2026-11-20 at 10:33 +0100, Christian K=C3=B6nig wrote:
> On 11/19/26 14:18, Philipp Stanner wrote:
> > dma_fence_timestamp() tests two fence flags with test_bit(), not
> > providing any ordering.
> >=20
> > The while loop + cpu_relax() seem to satisfy the desire to avoid
> > locking, effectively rebuilding a locks spinning behavior in the rare
> > case that a fence is signaling right now. Contrary to proper locking,
> > however, correct memory ordering is not guaranteed.
> >=20
> > Ensure correct ordering with locking.
>=20
> My words when I tried to clean that up the first time: "Another
> alternative would be to grab the spinlock when that happens."

:)

>=20
> I don't remember the story why the busy loop was used and can't see
> any reasons why it wasn't done this way in the first place.

I reached a point where I don't even want to know the story. Whatever
the reason is, it will be something insane <.<

>=20
> But my suggestion is to completely drop the
> DMA_FENCE_FLAG_TIMESTAMP_BIT as well. As far as I can tell that was
> only added as indicator that the timestamp is set, but we do that now
> for all fences anyway.

Agreed, but the API has been ossified by amdgpu who again violates
layering with drm_sched and by i915, who does something extremely weird
in intel_breadcrumbs.c. They seem to have built their own fence there.

amdgpu should be portable though.


P.
