Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B45302753;
	Tue, 29 Sep 2026 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642860; cv=none; b=hpj6Ew54SinocAKR6xi91X4UAc8KNLKufUh+L6miPyNfuKVq/GCAlNIvbjdHjHrWQ/krOISNnJnOgUY0U8wQVULypMP0gH3dWrKLHSftdKRXrBa+JdTwPhU7O1Ff/2XfQcFqLipLXwL486aYqQaDuGdDqv9Ch8SxYYySgoh0Yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642860; c=relaxed/simple;
	bh=yGCzTXNhVTF6dQEYp/nhwtpod9EeD/Bqtze4JHStqS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ph2jjb/xspAtBaz9kH2lL7bPEdG5RNY2lfH2UKPIfghyly702cGDbd6Ok7K5roFy2MsQJlOC8yVk3is+GYFdmurQ9fLy6QRUTF/P2qdgmPisMh3KTibB1c5Qwa+PdK2g8ttjneSshRO1DOSH0BWat+KYGNb5pKzwamoxSSSir6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8kYgsv+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8kYgsv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1351F000FF;
	Tue, 29 Sep 2026 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642859;
	bh=yGCzTXNhVTF6dQEYp/nhwtpod9EeD/Bqtze4JHStqS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b8kYgsv+hy2sMpIDZnymeyzHCqUqRAY2ATooq4ak2IzmJwVLlMtucVa5Hcx3hQJf8
	 Mzlr+6coFqxthyXwwDjE0U6AtLPNoJ0JQbFwpbEEAuoTQNFaz9qEMuULxIqbp25Dqr
	 IR8AJKeZXamXsvjiUYJGECpjyTt0a9O8Emy/rx95vCNJzYO5JE8YmwoKDLfVOLzIAz
	 oVHKFV/A4XzhlnZz77v6FpXlcHLWi9cviLLuERytIVrnhhzl1Sq8u954ZCF25jV49C
	 NoIogg43joFl+AXFgWONG15Tq8qmLMC48q2KqqO9Fn3vUZwtraSEHwKcKj1bGaehi5
	 CHyBI55Q4OMgQ==
Date: Mon, 28 Sep 2026 17:47:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <hadi@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, hybris
 <hybris@mojatatu.ai>
Subject: Re: [PATCH net] net/sched: cls_api: reclaim an empty proto on the
 error path
Message-ID: <20260928174738.139f1365@kernel.org>
In-Reply-To: <CAAFAkD80zx12Cskdf8NaF1pkSbLUiYSeTEmvpSR8o6P2d-JEOg@mail.gmail.com>
References: <QDISC-JCOT.v1.20260910090924@mojatatu.com>
	<20260925171834.73b5b367@kernel.org>
	<CAAFAkD80zx12Cskdf8NaF1pkSbLUiYSeTEmvpSR8o6P2d-JEOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Sep 2026 05:49:57 -0400 Jamal Hadi Salim wrote:
> On Fri, Sep 25, 2026 at 8:18=E2=80=AFPM 'Jakub Kicinski' via Hyper-Yieldi=
ng
> Back-end Review & Insight System <hybris@mojatatu.com> wrote:
> >
> > On Thu, 24 Sep 2026 04:32:49 -0400 Jamal Hadi Salim wrote: =20
> > > Tested-by: hybris <hybris@mojatatu.ai> =20
> >
> > Please stop adding these tags, they tell us absolutely nothing. =20
>=20
> This says that our _automated_ bot tested and it adds the tag before
> we send the patch.
> It does more than tdc for a specific patch set (e.g., PoCs for code
> paths not reachable via tdc) and it does find issues sometimes before
> we send out.

My main point is what I said - it tells us nothing upstream.
It's like a gerrit change-id tag, internal to mojatatu.

> If a human had done the same, wouldn't the protocol be for us to add this=
 tag?

LLM !=3D human.
