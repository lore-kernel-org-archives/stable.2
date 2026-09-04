Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275D3C1D75;
	Fri,  4 Sep 2026 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510703; cv=none; b=diRUpHof4KrGBBAumCJILIgh6pEtm1LwAufT8bVf0KhLI6kFKMsMqv/NZ+ZTcxO+EylnWGPkkE2hEByluBJMZWXCaIjYZ9cSO6vzT4YiBkQTOv/gUkNQltVI0N4sN9VnnlcIU83MKUNdHePzoIKseQ66EIZyFu8BHSYCZfgqz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510703; c=relaxed/simple;
	bh=L7ElWb/NHBXavL+CmkytTyzv0jpZPdju54yjjVYhf6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZJaUOkVs00G2gNrV+BU4cud0Ta7RrGJJ9WjjcEDCduwvM4b9tXpujZNSOWrxxhEF7MOJgVSNcJZfaFpjzAemBmChy6NvJ3OBdY4/47HLbFQoXKEEycaQT/1frUjjVDQzb1d234IgTyTqT/lr6oe1UwdH0maLbMux+FP09WjSC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vC3hOdaL; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vC3hOdaL"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hbqST6B9tz8twy;
	Fri, 04 Sep 2026 10:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788510697; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7ElWb/NHBXavL+CmkytTyzv0jpZPdju54yjjVYhf6k=;
	b=vC3hOdaLGpSKzz+5r+xQkZZvVGNArSifF1ec9xmlidiQZcOmm+dfTkY+zM6hf3xXwMp1Q9
	lY8AAtYNlWwwlYVO6kWyCB8vxJgNoyFJwZDd1gvUm3NDoMOuy1PasqKeQonPute1A898Ht
	+7qJCFfna8f3Xt/EkQNNTvC5CkhJL+PubTmWFTNQ7+gpLEJ9Pw2E9GXaKjGAHvTh20TtuA
	Kerf8N7xztv17h94LfSPvZo2naHAS99dkcK+4pvW5NEMUs1aQ1Y1r4Wo0ASrXi18y9BLp3
	IU7npaRXieqfSq+svqu+dJVP8VZkmfIpFy9zTBlDtf5RfUjR7l1dC3dIfqPFmw==
Message-ID: <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 "Jonghyuk Kim(MalHyuk)"
	 <malhyuk97@gmail.com>, phasta@kernel.org, tursulin@ursulin.net, 
	matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 	stable@vger.kernel.org
Date: Fri, 04 Sep 2026 10:31:31 +0200
In-Reply-To: <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
	 <20260904080618.2098450-2-malhyuk97@gmail.com>
	 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 3875ourdxg8kh4sfrtgbimuyyrhoowmf
X-MBO-RS-ID: c79d2b28304d4c4d5d7

On Fri, 2026-09-04 at 10:20 +0200, Christian K=C3=B6nig wrote:
>=20

[=E2=80=A6]

> > =C2=A0
> > +/*
> > + * TODO: Both fences implement .release, so dma_fence keeps their ops =
attached
> > + * after signalling. Dropping the callbacks would let dma_fence detach=
 the ops,
> > + * after which neither get_timeline_name() nor get_driver_name() can r=
un against
> > + * a freed scheduler or an unloaded module - the complete fix. It firs=
t requires
> > + * auditing every to_drm_sched_fence() caller, since ops-detach makes =
the helper
> > + * return NULL for a signalled fence. See Documentation/gpu/todo.rst.
> > + */
>=20
> That sounds like a bad idea as well.
>=20
> Dropping the fence->ops is to detach the fence from the module which orig=
inally issued it and not solve lifetime problems between the scheduler and =
the driver.

It can be used to solve that problem though, can it not?

The underlying problem is that the driver has no chance to figure out
when the scheduler is actually done with all the sched_fences.

Remember our lengthy discussions about drm_sched_fini(). Maybe we want
to reconsider providing a function with which the driver can wait until
the scheduler is done with all finished_fences?

>=20
> I think we should rather re-consider patch 035219a760edb35ae9a9e96beba7f1=
22e26a997b ("dma-buf: dma-fence: Fix potential NULL pointer dereference"):
>=20
> Here we changed the check in dma_fence_driver_name() and dma_fence_timeli=
ne_name():
>=20
> @@ -1167,7 +1167,7 @@ const char __rcu *dma_fence_driver_name(struct dma_=
fence *fence)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* RCU protection is required =
for safe access to returned string */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ops =3D rcu_dereference(fence-=
>ops);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dma_fence_test_signaled_flag(f=
ence))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ops)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return (const char __rcu *)ops->get_driver_name(fence);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return (const char __rcu *)"detached-driver";
>=20
> The problem is that we didn't considered that there a fence implementatio=
ns which still have a release or wait callbacks but rely on not needing to =
return a string for a signaled fence.
>=20

Could we move the signaled check to amdgpu and pvr?

IOW, we keep the solution presented here (removing ops->release for
finished-fence) and the few drivers that check whether a fence is their
own first do a locked dma_fence_is_signaled() check?


P.
