Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30E41D4F1
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378654; cv=none; b=kVY5nw63E/JEysLhnm4J58S2lWl3sF/gNKAD2zy3Ov/DH8nF500XYggM15ZTabWwdKbitkiLjuABvB40thZSkk8Hwdm0+MA1me0A+0LE9vFUlfzLBG2TLph7g+7YWUHLSm/w77huklGQ9yEEFlOwuoEbFpARYo/LzwsvheRv73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378654; c=relaxed/simple;
	bh=J+9MH70WKjCvhfQjzDnccEGPpWHdgQX9VggZtRW1gCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q8D4l22dVq3tup84pYkF9rBq1Zvy/37nukibPfMrg3Hh4qD1uB98VNktgJw+CaMLyK3/1p76XjAu5pzupFgqhwgOUHFr3yPVKNQ9IWPIisZmYVFuUKiDQ5pqx5swFWvi0SIh2Pz5Xe2LihXCiNW39nTzf7Qa5bgctZjnmxr2WsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vVc7P9q7; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vVc7P9q7"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hk0Rr4XqmzKn9V;
	Mon, 14 Sep 2026 11:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789378648; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+9MH70WKjCvhfQjzDnccEGPpWHdgQX9VggZtRW1gCU=;
	b=vVc7P9q755gp/4U/gJIwsTiL0yb14ppcJy3JyoZuYrgTInpV4aYeD/x8T0CXvxsZSpaNLh
	++Ue1mZ1ivQuxUb2rDEr55qLKpBW/uuH7nY0dWCgxWmY9SbLTxYxXJqutO73Ar3YegxN8v
	JmwOWF0eBQSzAFq9krF74J3qerR4tqZ+YI8J6GoPZByIfWs890U14wpdzPnKp4lAaJumzR
	k9WIL3fL1U4xKrR6FYL9sn5YKYHJ7M3EVZXS0nz1298hiahLkM5J/lWnVRGGHPXlQ7ES3p
	FfcEAMDncHoLcZXfcxQMGR7bUAadSkMkvaGpWNcJJz5n3EDA2sZ6Ca4Q5ehGWg==
Message-ID: <28a236dcae3e2cac75b4f5afc091136db04134e7.camel@mailbox.org>
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
Date: Mon, 14 Sep 2026 11:37:19 +0200
In-Reply-To: <acfea48c-dd63-4352-917e-a97a10a8b810@igalia.com>
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
	 <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
	 <35456574-5fc6-4270-85f9-940201998116@igalia.com>
	 <2958b5de0ab4ee1c46e2068eeb7448d6e2072ee6.camel@mailbox.org>
	 <acfea48c-dd63-4352-917e-a97a10a8b810@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 386b0864b5bf0618924
X-MBO-RS-META: n9irhpodoxuj7m7t6yfpe8tg5zciq3sd

+Cc Michel (for the sched policy removal plan)

On Mon, 2026-09-14 at 09:59 +0100, Tvrtko Ursulin wrote:
> On 11/09/2026 10:36, Philipp Stanner wrote:
> > Someone from RH might or might not work on that, and perhaps that would
> > take until 2027. I'm keeping an eye open for people to pick it up, but
> > everyone's always busy.
>=20
> Again, I am happy to work on that as long as it is clear there is no=20
> duplication of effort.

I asked and made sure no one is working on it, so from our POV you have
green light.

>=20
> > Regarding the bugfix, this was reported as a performance issue on high
> > load, that only seems to be reachable for CFS users, a brand-new policy
> > that is marked as experimental and is not used by anyone in production
> > yet. So IMO we can move on on drm-misc-next with spsc-queue, which will
> > also make CFS usable then.
>=20
> I think more logical order is to first fix it with a small backportable=
=20
> fix even if experimental. That way people using 7.2 can actually test it=
=20
> and contribute valuable feedback.

I took another look and I think my only issue is basically just that
the patch addresses something which we should have done regardless of
the bug at hands. So I'd be already happy if the commit just had a
different title and slightly extended commit message, like:

"drm/sched: Fix vruntime race by extending locking"

plus sth like

"this simultaneously serves as a preparational step to replace the
spsc_queue as a whole".

>=20
> > Is there a plan btw as to how you would like to proceed with CFS?
>=20
> So for me the most typical and useful plan, and in the context of the
> desired spsc removal, is:
>=20
> =C2=A0 - Merge this fix so it gets into 7.2
> =C2=A0 - Spsc removal RFC for some upcoming release N.
> =C2=A0 - Remove experimental status from fair policy for kernel release >=
=3D N.
> =C2=A0 - Switch fair to default at >=3D N+1.

Couldn't it be enabled first for dedicated users? AFAIK it was
developed with Steam's gaming platforms in mind. Can their OS devs be
asked to switch it on or test it downstream?

> =C2=A0 - Remove FIFO and RR and simplify to single embedded run queue at =
>=3D N+2.

