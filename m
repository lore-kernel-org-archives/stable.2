Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC1434984
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116996; cv=none; b=rldPanQmPChg+9Q7wU1sacyv66h0LNAtDggjUwbqks4cu4lQJc6nWQ8NhJvyBWOCY9P63p8pea3+A0Hc7hKvXzsu8JbpF7sXKYPhkCOtTW5uNhO92pop0pJi758atRIWOHsgDlGjroE3/g5+S/6K3g0U8vQaAUEFWev4Sbc+R6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116996; c=relaxed/simple;
	bh=SQeaglE9kgslrPTSoHn94UKmmp/r3+Bn/fGmP2+mi3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ia4q0WvmulnirdlWatfmjASFXPFYSs+4Ae2tDjit27wEPlCnGMB7pH/2oJgmVrQ7Dqu6ZwkVfFJ+niYeqhh1Wzp1NpQ2IiIrZnSRBfXsXDyvHM/8knCTeezXJchRHOhjv/aTUK6p4T04ltRjCdZjJzQMPZ47E692reSV8KD5E4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PzwR2YEm; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PzwR2YEm"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hh7gx3TmjzMlKK;
	Fri, 11 Sep 2026 10:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789116989; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALcg9Vd2npenlt0/QL85p1BH7ueYmsjnSxLgqn+ltps=;
	b=PzwR2YEmy86J27En3HvOQRYRRuqhQq4R4lMZ/rk4CoTTFxyZ163J2dIdgHgvBeHci6e6Wc
	7PZw2Rym2+n0H8gGVrm0Kz52ppShzDKo3v1tj3oXVD0PePAHvLNkRczz4GTbHYMWps2jqL
	j+LWmcnyS7dZASoQVdbNk5FReahby9dfCmoBLaF2hdyKM1c1JH48zCMH5P/Df6zbpjwCnv
	0ajDXD3wS8Dq4Lsp8YKJ02M5xyaj+7tZ1Rox0K/yRXhLwuSU7Cg0Yr8OIRhxFoe99VnJWO
	o7/36ZIEuRpl+lj/pSTGU0r9Yws0wFF4iHrsN+tedzA6RtoA7J/s7vlBsJ2rKg==
Message-ID: <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Do not restore unsaved virtual runtime
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner	 <phasta@kernel.org>, Pierre-Eric
 Pelloux-Prayer	 <pierre-eric.pelloux-prayer@amd.com>, Matthew Brost
 <matthew.brost@intel.com>,  Vitaly Prosyak <vitaly.prosyak@amd.com>,
 stable@vger.kernel.org
Date: Fri, 11 Sep 2026 10:56:23 +0200
In-Reply-To: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: z9t3txr6jjnc7f1rorymfnawnrafryo9
X-MBO-RS-ID: af8d3356cabcd556fd9

On Mon, 2026-09-07 at 14:05 +0100, Tvrtko Ursulin wrote:
> Prevent pushing a new job to an entity seeing it being the first in the
> queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
> side in drm_sched_entity_pop_job() has de-queued the job but not yet
> updated the saved virtual time.

I think I don't fully get the bug from that message. The bug (is it
even one?) you address is the performance bottleneck for CFS under high
load, right?

Anyways, I think I got a better idea:

>=20
> We do this by pulling the locked sections out to encompass both the queue
> push/pop and corresponding rbtree management.

So basically you move for locking the spsc-queue, the lockless queue
which is usually used with the locks next to it anyways. That's cool
stuff. I've suggested this for a while already

https://docs.kernel.org/gpu/todo.html#replace-the-lockless-queue-with-a-loc=
ked-list

So from a maintainability perspective, it would be far cooler if you go
down this road one step further and kill the spsc_queue for good,
replacing it with a fully locked list. AFAIR Christian and Danilo also
have agreed to this.


[=E2=80=A6]

> @@ -343,16 +340,17 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
> =C2=A0 */
> =C2=A0void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
> =C2=A0{
> +	struct drm_sched_rq *rq =3D entity->rq;
> =C2=A0	struct drm_sched_job *next_job;
> -	struct drm_sched_rq *rq;
> +
> +	lockdep_assert_held(&entity->lock);

btw. I think it *reads* a bit safer if the rq initalization happens
below the lockdep assertion. Also might make the diff nicer.


P.
