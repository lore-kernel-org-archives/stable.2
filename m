Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133C4AD4AB;
	Mon,  7 Sep 2026 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788343; cv=none; b=jD7HsxZ7GUO7LZjRANOdzSESICQ2JiTcZ1b+DwtFiUN+ijTM+ovKfrbQOezdXx75+AQ0DVXnDS6sIOrc3RkBuHm1AIFLSRehm7sAmDsTV+Wcf+jlVrqSZvV75fjOmWlOXGCQ3dEElJqEaGj/1oaHsHsjkiVjN/psY59kHXcboTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788343; c=relaxed/simple;
	bh=LEke2EPs1nd9N9Nxynh/mJMqpAdvs9NuQ3mp5kWf9VE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2Vv50JFZeg/+ojXFUuZKFIh/BOnfc2mpvdqmIDgTQlaCxENx7A2ICUQeFxB+blb6hpXgDTca+SMpLD/d+QTFXBmGdIxEO8L95WecD4dsfyTi/Tn2o4ZHKR/+XbHjp6R6dtG50hmTCd8XUGYo3KRdYSyQlDSsDeQgaJ8ezziORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=awq3sdmG; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="awq3sdmG"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hdp7b1WKhz8spW;
	Mon, 07 Sep 2026 15:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788788331; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEke2EPs1nd9N9Nxynh/mJMqpAdvs9NuQ3mp5kWf9VE=;
	b=awq3sdmGdjFFqitT1UNk0BqAkA+qyYbZbf+Z8qOSG+02uqNin7wCy1iX7rIox2uPTiDHBW
	z9Kd87A6zfshdOdlfvQSIYQehqxImBRY4BYmtiGvfNpPe0n75i2kROIYNYUNSpbUulBLku
	z49T8v1G/phTGJWX1WFSTYBfxPrgyDKlOMBlCqUQi7CvwW9JbYqV49dspnd5c3LxDWVi+f
	g1Po48j9W4F+PssuMZIQIsSd8+NNLEOBKPQ+sWyNXItU8BOsgEPwMALYdSZSFr3pK6huI/
	MBDtNxHEVIebcAsn6hW2TKC0uyGxdW6v/iM1kmdgoA9mzgUTGrhSzosCSrDiFA==
Message-ID: <299ef4389875fe1333bb934edcece3bee5c5526b.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
	phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>, "Jonghyuk
 Kim(MalHyuk)" <malhyuk97@gmail.com>, matthew.brost@intel.com,
 dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 	stable@vger.kernel.org
Date: Mon, 07 Sep 2026 15:38:46 +0200
In-Reply-To: <fa12360b-2ccf-41c4-a158-84e34835c0e9@amd.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: ipg9bp9sjkftrx9pyqqjiyefy5qzrbq1
X-MBO-RS-ID: fc4c7d91b475e08ac8a

On Mon, 2026-09-07 at 14:59 +0200, Christian K=C3=B6nig wrote:
> I think the memory ordering isn't really a problem.
>=20
> See if the ops pointer or the signaled bit is loaded first doesn't
> matter if you check both.
>=20
> You only need to make sure that the ops pointer is loaded once cause
> that one is used multiple times, but that is already the case by
> using rcu_dereference().

That.. sounds correct.

Although I still don't get why we then can't use the signaled state
everywhere instead of the ops pointer. That would be simpler.


Anyways.
Maybe Jonghyuk can give your patch a test run and then we could use it
as a hot-fix to backport and discuss the wider future of dma-fence
separately?


P.
