Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416D466AE5;
	Mon,  7 Sep 2026 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779766; cv=none; b=r6NkHfYpCHy0hyzBIOxIyU6lTjIgEG+UrJUCeLTcffCzbVMv5VuimeSbKt9XlRFejzadBlwcBEy55nqY2V55AswQW2rDhxk9HxA3tzcVMV5UHK4n8L1ihHEd1EWATLFm49p2SS51AcqPqvzq+RYetzP4RXmRbK3B3DOj9/xLG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779766; c=relaxed/simple;
	bh=v7azLyqL3jklC+75mnaQajaLf93DbF4PozAo0D5yAUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJfezL2NnGIBqm0imYRLw7Vp1X1NAmctoNiuOilSN+5YYyb6OHKwSPyGR/gff5fY1ip0cCUZ65t7u/cZioa079nPj5liSccRTxxdYZzYlCrxc4e3KJNAliYRIYTN/sVvVhXHq2qIBR+tvWEORpdusPib+iE0rLD1y8U+dM7xGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rKDlexZ7; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rKDlexZ7"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hdkyl6WFCzMl19;
	Mon, 07 Sep 2026 13:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788779760; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7azLyqL3jklC+75mnaQajaLf93DbF4PozAo0D5yAUI=;
	b=rKDlexZ7ldFeXZoW8qouJ3PRP78lkQfBlUplmVJ4zlqX71eUItQ7Jtz6ibU6f44spuHPTG
	suuZGF1KVEE+7Bh8v73dAzPNVvH6LK8SiLXngfz6XsK1RNyZHTIe8v7fY3J0HAPbQ0+hKN
	9dSFkRzNJSbaznj01WikxTYoEKjXFp2slicG0FnFB9vD3LFb1lHkeY3baidyMlxxm+EdFM
	8I5tEutQov1vSUlIE5PbDtzTMaqPFWeQ8fhNWmPrvbBwirY3JRARJamimBAsS/wjG7HBCG
	WTDu6hKG73+38MDidTPSejzm1OYi5B1Qd9pQD1VQ95hkyq9uPhv0Z4HQgyP2kw==
Message-ID: <206df2dad0c68b8c25862c74c0a8399940044af2.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tursulin@ursulin.net>, phasta@kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, "Jonghyuk
 Kim(MalHyuk)" <malhyuk97@gmail.com>, 	matthew.brost@intel.com,
 dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 	stable@vger.kernel.org
Date: Mon, 07 Sep 2026 13:15:56 +0200
In-Reply-To: <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: gp5wy1j99rx7dpxhyoeik9wr4ndkjrnz
X-MBO-RS-ID: a340f645c8da17d0052

On Mon, 2026-09-07 at 12:06 +0100, Tvrtko Ursulin wrote:
> On 07/09/2026 11:47, Philipp Stanner wrote:

[=E2=80=A6]

> >=20
> > So I maintain the position that we only get it right by having the
> > signaled-bit be the decoupling point.
> >=20
> > Or am I missing something?
>=20
> The driver fixes you asked about and I listed work(ed) in the context of=
=20
> 506aa8b02a8d ("dma-fence: Add safe access helpers and document the=20
> rules"). In that "world" it would have been safe. Did 035219a760ed=20
> ("dma-buf: dma-fence: Fix potential NULL pointer dereference") break=20
> those fixes a bit?

I think we all agree that 035219a760ed should not have been implemented
in that way because it does not work for drivers that provide a ops-
>release / ops->wait.

So I think the only thing we can do right now is add the signaled-check
back (like Christian suggested) and ensure correct memory ordering =E2=80=
=93
since we also cannot use the spinlock consistently, as that can still
be extern=E2=80=A6


P.
