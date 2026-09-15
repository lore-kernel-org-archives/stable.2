Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804CE37DAA2
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481845; cv=none; b=cZXSXcdV9OiIck4AkS/dbH72Q6iOnkvX8DBT+PP8TV8764NnbarJ91s9V4q8s1a04u8atB51jf9hpRZg+7QY/GvDLAvv2WR0C09qPJXKa8ZdCXClEdIvzydfpMJZAd/cLFqNXi1Obt9YDWFeW8dxgTz4RzX5YSyAwBxppz4jMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481845; c=relaxed/simple;
	bh=qoUybKolGpMVSrpKPnSxjyM3WuM7fg6PJ5WlGQw4DUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btBLKE30ZXqJ9O7O3cAkdcYO/XMkuakSdSCgZaz4kEeRPAe8N1SrBUya/lXwUWQ7qFOLTuWOc1+IxQAixyZAB+R7O2kb0ptmI1lWvnVqDNNssvAWQC1s9SQyj2TnlIqIEJXDxI0NEbEqXNkjSy1vJ1w7FSZeIUQH2aonoDe/kBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZdWWWKWA; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZdWWWKWA"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hkkcH3C1VzKmJ9;
	Tue, 15 Sep 2026 16:17:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789481839; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoUybKolGpMVSrpKPnSxjyM3WuM7fg6PJ5WlGQw4DUk=;
	b=ZdWWWKWAwwVvTwg3DG9y6HRFrPQvVvFCflhZlxEBY3eZcoJ9HlEgt0YwmRkVUknQf4/TxT
	ifYLmn5xLUaPa+x1w7S/o8FJieMJX9IR2f1QFJWJajOumis6bnKHM+wzANxWZkzFF5brkg
	kBxSKSl88p/kDmKZqsUAuEZJFkq93Dhk8GrsM+ZUBoj0u6rscuNXf0jq3xv6p7HAcMUQ/3
	RNr93oJzqr1v8oGRbTtGMlC0Hp0jinJIHbYVvo0AoARIvGL8GW7pDzmOEUU6OeUTDe2f+T
	Veb8rw3ztsxW6QiyP70YlScK+UYDGQnW5qi3nIIOmsvCk+QQkjLq27yMpWyjvA==
Message-ID: <aa8db13d6133855cee5a76cb8b77b05c3eec9807.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Do not restore unsaved virtual runtime
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Matthew Brost
 <matthew.brost@intel.com>, Vitaly Prosyak	 <vitaly.prosyak@amd.com>,
 stable@vger.kernel.org, Michel Daenzer	 <mdaenzer@redhat.com>
Date: Tue, 15 Sep 2026 16:17:11 +0200
In-Reply-To: <0766f89f-380f-49ef-a55b-dda1d3bedeac@igalia.com>
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
	 <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
	 <35456574-5fc6-4270-85f9-940201998116@igalia.com>
	 <2958b5de0ab4ee1c46e2068eeb7448d6e2072ee6.camel@mailbox.org>
	 <acfea48c-dd63-4352-917e-a97a10a8b810@igalia.com>
	 <28a236dcae3e2cac75b4f5afc091136db04134e7.camel@mailbox.org>
	 <0766f89f-380f-49ef-a55b-dda1d3bedeac@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: p43c91dk7ogw8pydrfzy6i1m848dauj1
X-MBO-RS-ID: 3d384f5940539f8fe9c

On Mon, 2026-09-14 at 13:31 +0100, Tvrtko Ursulin wrote:
> On 14/09/2026 10:37, Philipp Stanner wrote:

[=E2=80=A6]

> > I took another look and I think my only issue is basically just that
> > the patch addresses something which we should have done regardless of
> > the bug at hands. So I'd be already happy if the commit just had a
> > different title and slightly extended commit message, like:
> >=20
> > "drm/sched: Fix vruntime race by extending locking"
> >=20
> > plus sth like
> >=20
> > "this simultaneously serves as a preparational step to replace the
> > spsc_queue as a whole".
>=20
> As I think it is fine as is I would prefer not to spend time on a respin=
=20
> unless you insist.

As I see it every patch that fixes something by moving or adding a lock
solves a race condition. So we should call the child by the name. By
calling it that we also publicly agree on our desire to extend locking
and document in the log that drm_sched is moving towards that goal.

If the effort bothers you too much, I could also apply it and thereby
rephrase a bit.

We can then request backmerge into misc-next and base the followup-
cleanups on it.

>=20
> > > > Is there a plan btw as to how you would like to proceed with CFS?
> > >=20
> > > So for me the most typical and useful plan, and in the context of the
> > > desired spsc removal, is:
> > >=20
> > > =C2=A0=C2=A0 - Merge this fix so it gets into 7.2
> > > =C2=A0=C2=A0 - Spsc removal RFC for some upcoming release N.
> > > =C2=A0=C2=A0 - Remove experimental status from fair policy for kernel=
 release >=3D N.
> > > =C2=A0=C2=A0 - Switch fair to default at >=3D N+1.
> >=20
> > Couldn't it be enabled first for dedicated users? AFAIK it was
> > developed with Steam's gaming platforms in mind. Can their OS devs be
> > asked to switch it on or test it downstream?
>=20
> It wasn't quite developed for single game use cases, but with the wider=
=20
> goal of improving the code base and DRM landscape in general.
>=20
> Also, I think it could give us false confidence since the matrix of=20
> hardware + kernel setups is quite small. Even this bug wasn't caught on=
=20
> an official platform, neither could I repro it on a Steam Deck. So I=20
> would say a release or two after it is set as default is quite safe=20
> since it can be easily reverted with a one line change.

OK.


P.
