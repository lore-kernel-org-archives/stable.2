Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B0525A76;
	Tue,  8 Sep 2026 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865685; cv=none; b=Bn7ibTHbpw30I/YJhaAjo540Zo/6gYsvEoxSQttw2drPwBFNG+2Har5kg80nZwtseS1eOn+Y/JNyxzLTfHKKig1WibDXas+ox+5tYByRUgZeExKQnZm7aXJpyAjSj7qiQk//tyzK58w6YNG7Hy2kxvO51NWp6ByiQsm7DQ4sTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865685; c=relaxed/simple;
	bh=6JP+yF/l59rk+xEN9cUvDQiQ+4zMT1Y2YqxDsIm5cLA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVXHHmoEM+BAa97iZf7xmzvenk3wnVRntib3fjXVQQSMlx8OTZsBZYj4COFaiYBRW9a6iUkfjZGfmPhmocriRiwD4oZ9/fuhqyRbMLWzyH5ZboWYRpJ08i5TfKLlyjinAGEIi8aTyMzDZE7uN51r5t9T4qWqFY42qDqPTzny/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GwfEaMs2; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GwfEaMs2"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hfLkw2XVqzMlGk;
	Tue, 08 Sep 2026 13:07:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788865672; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7Bt62xe+5MP6LLxYlu1Io9gYViozGYzljouWDKNZL8=;
	b=GwfEaMs2ZM1KbNLWf04twW9UZAKtrk0RzznFK26PlgE4yglGKlDk5BpM/6qdagCJOhOxIF
	1OrmtaKx9AByJsVFBEopM2td8IPz/U+Jn30LRY+a4ZYNsC12euOZfKG/wH31g++r4kzWiE
	ksw6/sIEYPhS8Ab8E8hKIZKEwcKxb99/dQpaRI3RzQbc9XqkezdUYyObXpq7WJqMYbUD6E
	aGLm3yt1N/shapBejM+R8wNQNoTsRv24DdQSKpkfez3+es5VQPtAdkdQT6Ta+mWbEx5JKx
	Flz48oLJdi5FS0h1DZcgd76fwWEIdYF81WrEbyMDSe2R7P3Igi0lSrR4Ig/JIQ==
Message-ID: <909f7ed1b2688fb2f727afb879642cda5cad9e5e.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, christian.koenig@amd.com,
 	phasta@kernel.org, tursulin@ursulin.net, matthew.brost@intel.com,
 dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 	stable@vger.kernel.org
Date: Tue, 08 Sep 2026 13:07:46 +0200
In-Reply-To: <20260908104910.183638-1-malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
	 <20260904080618.2098450-2-malhyuk97@gmail.com>
	 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
	 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
	 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
	 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
	 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
	 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
	 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
	 <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
	 <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
	 <206df2dad0c68b8c25862c74c0a8399940044af2.camel@mailbox.org>
	 <fa12360b-2ccf-41c4-a158-84e34835c0e9@amd.com>
	 <299ef4389875fe1333bb934edcece3bee5c5526b.camel@mailbox.org>
	 <825c1f02-b9ad-4160-8e4b-53f2393a7bff@amd.com>
	 <20260908104910.183638-1-malhyuk97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: o1s5duoqc8bbq7toip8p36w6dz5a93e9
X-MBO-RS-ID: 63113cdb2f871110c03

On Tue, 2026-09-08 at 19:49 +0900, Jonghyuk Kim(MalHyuk) wrote:
> Tested-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
>=20
> Two things it doesn't cover: it's x86 only, so nothing about the load ord=
ering
> you discussed;

Christian and I think that it shouldn't be an issue anymore. Both
values are loaded and the ops pointer cannot become invalid until an
RCU grace period has passed. Similarly, sched must not be cleaned up
before that.


>  and only the signaled case - for a fence exported before it
> signals, get_timeline_name() is still reached and reads fence->sched->nam=
e.

Is this an issue? A fence can only be exported if the scheduler exists.

The hard rule with dma_fence is that all drivers must signal all of
them before they tear down the scheduler and clean up driver resources.
This then does the decoupling.

I think that rule is really the only chance we have to get things
right.

> I haven't tried to build that case.
>=20
> Could you add a Reported-by for me when you post it? I'm happy to drop my
> v4 1/3 in favour of this, and can respin the KUnit test standalone so the
> fix lands with a regression test.

+1
I think since it's @Christian's patch he'll take care of it


Thanks
P.
