Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A33EB102;
	Mon,  7 Sep 2026 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774164; cv=none; b=iFyW2D7wjdAYI77wVsyXdL6wU39iPVdQuOigb98AOu+ATlkZJwQ+zceAh4n6SMiR+MaE82puQd5tqnbZTbepmIRqyyhGTvJ9AVrLhV1x0sGmR6Ex5Bm7lBxmaWnNF1NscIqhKtQZhlFZONZzXYaHNkxw5BYvFT71mPc2rfWHVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774164; c=relaxed/simple;
	bh=0x7Vh0Nm95GXeLYiNWyTgZGfMfq6ePV52YHNzaf6jBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tx3Mm963znZWQwhz2tU70plnR3cgXgVPZ5umjAmAxsReYsZ3bwa10DCueAODQKBMr/BVctHmJbtOsj7W0MPDDCc8WwGS1cDwNm8CI/ZBdraZ+eqqKeC55b3K7o+4n8npAMoOaqJHf/JPKldb8W2+VDUxrrwZpQra7Yvz68we+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nV41wau/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nV41wau/"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hdhtx2ZGMzKmTV;
	Mon, 07 Sep 2026 11:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788774153; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNnph2fUPi7dxoCoaqnz1jcXuoTMMkQ5gHDdEQktIDo=;
	b=nV41wau/oBQZfHbzaNMbzbcu7r3stEQrxi3RAGWvTZRNZhHI6f3peB2RdQzA0avlIz0b6r
	hcT8WOPYxb/HDp85vQSiV3qlcejUGjCMjHdbfac9gyYHTxyDpDQLOEKMqMeVu/QrfwtTXf
	vAu/nl5X4NLPbo++yMtDLYLSjlJDkT1s/QeQsMPp7nxQtIFKKL5rya5+FymuEDOULzjuEA
	xrgjjaY6QYhzUy8r8+WMeXMGjO9CSVnovtTH7Djg2dZrftCKQpv5dDMGYGZ4zMPaetfjuE
	BG8yU7rvxnkg2cf0AH8ImF39R4PYNbkep6Ipwi07coE+C783Ar1B1/njCz2xbg==
Message-ID: <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
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
Date: Mon, 07 Sep 2026 11:42:28 +0200
In-Reply-To: <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
	 <20260904080618.2098450-2-malhyuk97@gmail.com>
	 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
	 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
	 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
	 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
	 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: i45czrcqg73okz4cgu8abyoebbqn6ayc
X-MBO-RS-ID: cf6f129b25ec7581d08

On Mon, 2026-09-07 at 10:15 +0100, Tvrtko Ursulin wrote:
>=20
>=20
> On 04/09/2026 20:06, Philipp Stanner wrote:
>=20
> 8><
>=20
> > If you can think of a stupid and simple solution, shoot. The only thing
> > I can think of is moving the string into the dma_fence, as a hard copy
> > :)
> >=20
> >=20
> > In the mean time, my proposal is to keep aiming for removing
> > sched_fence->ops->release and fixing pvr and amdgpu.
>=20
> Fixing the drivers sounds like an obvious thing to try indeed. Along the=
=20
> same lines as it was done for xe and panthor. It is an already=20
> established and well understood approach so shouldn't be controversial.=
=20
> After that we can discuss in leisurely pace if something better is=20
> possible in the scheduler core.
>=20
> I understand its amdxdna, nouveau, and msm. Was it attempted so far? Is=
=20
> it significantly more complicated than it was for panthor and xe?

How did the others fix that?

If we look at nouveau:

static void
nouveau_sched_fini(struct nouveau_sched *sched)
{
 struct drm_gpu_scheduler *drm_sched =3D &sched->base;
 struct drm_sched_entity *entity =3D &sched->entity;

 wait_event(sched->job.wq, nouveau_sched_job_list_empty(sched));

 drm_sched_entity_fini(entity);
 drm_sched_fini(drm_sched);

 /* Destroy workqueue after scheduler tear down, otherwise it might still
 * be in use.
 */
 if (sched->wq)
 destroy_workqueue(sched->wq);
}


We see that it
   1. stops accepting jobs from userspace (not visible here)
   2. waits until all hardware fences in this ring are signaled
   3. only then tears down drm_sched

Then nouveau might unload or free up resources.

The nasty thing is that I don't see how nouveau misbehaves here and how
the stuff might be fixed.

The problem is that the sched_fence implements ops->release, so the
check doesn't take effect.

Moreover, even if we did remove ops->release in drm_sched, it would
still be a race: a driver's contract is the hardware_fence, the rule
being that you have to signal those. So after signaling the last
hardware_fence, you could actually start releasing resources, but it
might be that finished_fences are still in-flight and are unsignaled.

So we have some sort of fence -> fence race here, too.

>=20
> As for regarding the 035219a760ed ("dma-buf: dma-fence: Fix potential
> NULL pointer dereference") sub-thread - I did not manage to penetrate
> the consensus there - whether it was established that it needs adding
> the is signaled check back (with additional memory barriers, like v1 of=
=20
> that patch) or not? Regardless of fixing the drivers or what?


As far as my understanding goes this is the only way to get this right
for everyone, i.e. also users who implement ops->release(). Then at
least the driver could unload after signalling all its fences (with the
exception of those who have a shared spinlock maybe).


However, I suppose then we would then have two mechanisms, one dancing
with RCU around the ops pointer, the other checking whether the fence
is signaled, presumably with manual ordering through barriers.

My first guess would be that maybe we should only rely on the signaled-
state and leave the ops-pointer untouched? This should also work for
pvr, notably.


P.
