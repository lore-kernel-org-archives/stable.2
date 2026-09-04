Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9077A51E437;
	Fri,  4 Sep 2026 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548803; cv=none; b=npiZC6VFu0H1MIsn4FHec9HUwOq7Azqtl5a6I51bAbUsxD52cIPk2CfXqS02MjA75vPfKuFJ1ihajmRXgcAYjJA4H155gQFKiK5OzkeDz5D9cwHohIs3q1gQYJM5jCOkTnYcRQ0feh4lNkNc2QGURxZx42lnU00Ezem5gxVf2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548803; c=relaxed/simple;
	bh=BPD4fIE2hQPUTf0oTIx+CTkhgcJjNoGrsoDwgxoCIRw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0fJJLiIp7rarJjasiB0e8rGf8OCXWO+TY5/48c6eWJiAq81TDKR9v7DZVpsXRKYYSWC5BFa+QRjYvUwLRAhbI8tHaZyfSdWznfFp2nRSqTegy3KeUpp/qbTQiUcvWXnpFCTJ2+kVoW97zKdP/NEYHcq3trBLKcAI+WbS5gVphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IcP9Q/jl; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IcP9Q/jl"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hc5Y411JPz8sZs;
	Fri, 04 Sep 2026 21:06:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788548792; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPD4fIE2hQPUTf0oTIx+CTkhgcJjNoGrsoDwgxoCIRw=;
	b=IcP9Q/jlU3GD+WteFSdXisILUqTCOPkmKmbsWQdAnMn4fA56SAlBscpRgXBKr8AtONeQhX
	BVfdLHl4RddM8Qdnh79CPCeDC7mLMjmL1xEaJ6yy5GspcYFVeLpopDjiI02yuZurggwJ2V
	YemJwHmgwcYu3E5ClOMA0NAKOI82mD6wmLClQBDfYV2z4AnO8d9gPpTMP14jo0NiTn3RI4
	KZR4GGXbCst2pqowkaixF3vLWBDVYD7/g+6tzQ+NL85u8QIyQ/FRhsFXzZFG12YIXuwMBg
	6f1FRndku5/bexC57K1akKR2SkVj93a29YddVmcw5Q/auXh5oJ1/G3+F/Wl29g==
Message-ID: <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
	phasta@kernel.org, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, 
	tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 	stable@vger.kernel.org
Date: Fri, 04 Sep 2026 21:06:27 +0200
In-Reply-To: <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
	 <20260904080618.2098450-2-malhyuk97@gmail.com>
	 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
	 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
	 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: rshw34mo1xxwztyre7cgrfju8ajtnzzf
X-MBO-RS-ID: eb457b034488acf701f

On Fri, 2026-09-04 at 14:49 +0200, Christian K=C3=B6nig wrote:
> On 9/4/26 10:31, Philipp Stanner wrote:
> > On Fri, 2026-09-04 at 10:20 +0200, Christian K=C3=B6nig wrote:
> > >=20

[=E2=80=A6]

> > >=20
> > > That sounds like a bad idea as well.
> > >=20
> > > Dropping the fence->ops is to detach the fence from the module
> > > which originally issued it and not solve lifetime problems
> > > between the scheduler and the driver.
> >=20
> > It can be used to solve that problem though, can it not?
>=20
> Yes, but I think forcing dma_fence implementations to drop their
> release callback to fix lifetime problems with the driver and
> timeline name functions is a bad idea.

The issue we're facing is not so much related with life times, is it?

Even if the driver correctly tears down the scheduler (i.e., signal all
hardware fences), this problem still exists.

>=20
> We should keep this fix simple and focused so that we can easily backport=
 it.

My hope would be that the dma_fence backend solution can be used that
*already exists*. That could then both be simple and maintainable.


Correct me if I'm wrong, but it seems we have not found an alternative
solution that can work yet?

>=20
> Fixing all dma_fence implementations to not need the release callback
> is something I really like to have as well, but not to fix this issue
> here.=20
>=20
> >=20
> > The underlying problem is that the driver has no chance to figure out
> > when the scheduler is actually done with all the sched_fences.
> >=20
> > Remember our lengthy discussions about drm_sched_fini(). Maybe we want
> > to reconsider providing a function with which the driver can wait until
> > the scheduler is done with all finished_fences?
>=20
> The problem is that won't help unless we either add more checks or
> fix the checks in dma_fence_driver_name()/dma_fence_timeline_name().
>=20
> The dma_fence object can trivially outlive both the driver and the
> scheduler instance it originally issued.

Right.

>=20
> > >=20
> > > I think we should rather re-consider patch
> > > 035219a760edb35ae9a9e96beba7f122e26a997b ("dma-buf: dma-fence:
> > > Fix potential NULL pointer dereference"):
> > >=20
> > > Here we changed the check in dma_fence_driver_name() and
> > > dma_fence_timeline_name():
> > >=20
> > > @@ -1167,7 +1167,7 @@ const char __rcu *dma_fence_driver_name(struct =
dma_fence *fence)
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* RCU protection is requi=
red for safe access to returned string */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ops =3D rcu_dereference(fe=
nce->ops);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dma_fence_test_signaled_fl=
ag(fence))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ops)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return (const char __rcu *)ops->get_driver_name(fence=
);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return (const char __rcu *)"detached-driver";
> > >=20
> > > The problem is that we didn't considered that there a fence
> > > implementations which still have a release or wait callbacks but
> > > rely on not needing to return a string for a signaled fence.
> > >=20
> >=20
> > Could we move the signaled check to amdgpu and pvr?
>=20
> Yes we could. I also considered that. But I would rather like to see
> it handled in the common dma_fence code.
>=20
> If I remember correctly either Tvrko, you or somebody else was in
> favor of doing "if (!dma_fence_test_signaled_flag(fence) && ops)"
> here but I though that this was unnecessary and we would rather
> remove the release callbacks. Maybe I was wrong with that.

I hope that wasn't me because that again looks very racy.

I think that there is no way around using the spinlock. As I have
pointed out many times, the fact that the signaled-bit is set with lock
protection and read without it is fundamentally broken :(

> > IOW, we keep the solution presented here (removing ops->release for
> > finished-fence) and the few drivers that check whether a fence is
> > their
> > own first do a locked dma_fence_is_signaled() check?
>=20
> Works for me as well, but as I said I would rather like to keep it
> simple and stupid for backporting.

If you can think of a stupid and simple solution, shoot. The only thing
I can think of is moving the string into the dma_fence, as a hard copy
:)


In the mean time, my proposal is to keep aiming for removing
sched_fence->ops->release and fixing pvr and amdgpu.

I think that will have to entail a signaled-check. Question would then
be whether we place it in the driver or the backend.


P.
