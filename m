Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168869;
	b=ZKOWJEC0zFKDPjPasDcaQiYFdIIijNKmCAgnujf6xt9q5M2JhOulzQeGEqHY7QMEznyh
	 i041ev2FKDgm4HQlkQvB8F2OKc54B1nndplBjgZDY8k5FlDa7yRLKRPNSwDiG53K/7HqI
	 0WQC1sppathVOvvgTJT9V5OnUqKP/6jpBjZiVHxxbujoBjYHEP/syfZyY+CDnv1jjL1XZ
	 usBm9zqFJvJ+fm46654BzgmWqWPsxMgj4kCi8oUJOlth0u3ifme0oiCGu7qV3/YNr1lq2
	 Vh/vsXotWB7FlBfDNvVkmyPYnxIS9TKrWaw9lnkHlAXZrNjQJB15py6vXBYVT3L2CIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168869;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=tuJA0XDaKwz11CrlbVlHVIWMZJx66TbVl81T/rjPki8=;
	b=yThzLPwO66rP6VwR9olP3PnYqXizoN27bGEpP7/nQ+5VmcpUwJi9EWzor1+PviH5a6eh
	 vIf9CpWRk3TS71D7MlbPqPRRa2QvO8tlO6VbcqjzIzURuVplD0l587otnmiuILNfb+ddo
	 +GRbKlM8j2jN/fvcz796sOi9/QAV2j5TFRbWJ50IRLjw7I4/cXI4GiEEfWMhcMTaXjQ53
	 fO4BVqQssIk5JZZIa4h2NMD5bgkR043CVH4K9BzU1sR9MAYyQt8hDv9NTeCPI4h9vv8r4
	 bu6ABkjAjXt0746OZpOXP2/foLeUHWMAKq1AsgEdSzj2x+ciI37FsSsifNdi5zNyhRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="Vz//ANnY";
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595F606A33B;
	Fri, 20 Nov 2026 10:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B595F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Vz//ANnY
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jW9p91Nv7zMlyX;
	Fri, 20 Nov 2026 11:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795168865; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuJA0XDaKwz11CrlbVlHVIWMZJx66TbVl81T/rjPki8=;
	b=Vz//ANnYWzDPxmgoY0vJq5qnG3FZlDUzowfc2BZoBkQWOki4fnvqncbjlnjgzDsOfoHUus
	BBb0rU/UEebNzxtacD9M34Uj8SwTCwLYQlv/mgXbdJebxmb/9KU7UhdxaBOENfIilzlYPk
	hsmp2DWW9CiJyb8nxJHzVDvLJ9KJ2/N7JkZZJZPCq9hDegvPO8JRB32PgJpZZ9jBFHhq+v
	+cH7IElqfhizxTP6m8ESYFe0iivegorXU/4KoBAkJmpAh3f8NjzgsMST+juIc+e+hya3hy
	qzwtaiR6ygiHdX4MFJQA6ga60+vVyKl+aL/Ht9bjGu1OEfi7aqVHUs3X+k5jXw==
Message-ID: <d53b0e41ca767a2acb1f6ee29344567f34385d8c.camel@mailbox.org>
Subject: Re: [PATCH 2/3] dma-buf: dma-fence: Add
 dma_fence_overwrite_timestamp()
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
Date: Fri, 20 Nov 2026 11:01:01 +0100
In-Reply-To: <a8fe714b-6d26-4777-8b9c-4299ecdc3f44@amd.com>
References: <20261119131830.2535266-2-phasta@kernel.org>
	 <20261119131830.2535266-4-phasta@kernel.org>
	 <a8fe714b-6d26-4777-8b9c-4299ecdc3f44@amd.com>
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
X-MBO-RS-ID: fa50b291f261fae32f2
X-MBO-RS-META: gjw3fjryizx7ih8jrimp6njyrwmw4ndz

On Fri, 2026-11-20 at 10:38 +0100, Christian K=C3=B6nig wrote:
> On 11/19/26 14:18, Philipp Stanner wrote:
> > A fence's timestamp is just an opportunistic data point for debugging
> > information etc. drm_sched, for example, uses the timestamps for its
> > scheduling algorithms.
> >=20
> > In rare situations it can make sense to allow users to overwrite a
> > timestamp with a more accurate value. This is relatively harmless since
> > the timestamp has no meaning for the implementation itself.
> >=20
> > Add dma_fence_overwrite_timestamp().
>=20
> I think that this is a very bad idea since it gives the impression
> that overwriting the timestamp on a fence is ok.
>=20
> That was only done on the scheduled dma-fence because nobody cares
> about that time in the uAPI. For all other cases that can blow up.
>=20
> I would rather come up with a clean approach for the scheduler to
> track the spend time per entity which would make that hack completely
> superfluous.

Yes, I agree.

The *one* feature we would have needed in C is a public-private system.
With structs in APIs it's often completely undefined what the user can
and cannot touch.

That led to API ossification. Just look at drm_sched, where we now
cannot trivially change API internals anymore because external parties
conveniently use this or that.

> IIRC Tvrtko already created patches for that, I'm just not sure if
> they were ever committed.

I suppose it should be somewhat easy to track that data in
drm_sched_fence.

Maybe Tvrtko can point me to his ideas so I can take a look.

Thx
P.
