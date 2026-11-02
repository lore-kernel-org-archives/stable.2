Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616373;
	b=h80f0pZ+PXUo272hgTSeCXoiCjZWrz04ioKpHRrfcmWp7eWaAJZ9jFtFeWXMMreTh0Dh
	 WUUZUSK23hmHExtYe3iValF/veX403fc8+m8BOKzgMM5g16AiVOUUXa42uKlbFNETTAmQ
	 s2vANNIqvrxS9/6HN8L5U4AauAeEkttp4QWoas+Gn+x/e3j3nK5Ju9J8au5j9Mov54+kJ
	 DqURkx7K/ufi48wPkHGFcCO+FwfANG658vB1q9gLEXrCoAa2urQNxxO7y6i1pxO5AiaXD
	 segymQvlzS/KqlpApLYoD5/UE8gWyxf0LJ+37OScoeP0g759TaYzBuAgNDX/GcSHAIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616373;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=/4xkEfYxqjbXp4Ci01sdrxpkE7UK56jG7PU71QpI0/s=;
	b=z5SxWo5lfdLe8PDO7r/upJ/ziaqlDMehzSxrytxbTOG+lArtf/FETh0OvfIKEKzNAsQZ
	 po54Or2ROL971QAlurSp1eJwugXM4AC6RHm5uDSNnfDXrfD7bk6T9CulmgY8SKiUTkjT/
	 7Pc4u0Pqbn6DGJQVrtwQppanitImrcC6wYfsC9PFHaB7S/4kR8f2AYjf0dJluI6n7xoF8
	 nWRiIPT6OSajs8FpuY9mXlZRcb/gxIuBtLk5/A67QSRzB8nO18mdQp/7LfnpL1t/ulnyW
	 zuf+N3TfGnDqK6pjhFqLx4CgdlgNnXPfSgKqjRdqkZL0F6U6hYxDgDEYO03R8xRiVLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=It7MZITQ;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93E606A32C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B93E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=It7MZITQ
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jJ7fT3m9rzMlD7;
	Mon, 02 Nov 2026 11:46:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793616369; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4xkEfYxqjbXp4Ci01sdrxpkE7UK56jG7PU71QpI0/s=;
	b=It7MZITQW6cp44q/4p/4z29YR3KERS8hRpIOZkqiw+Cy0DRLmqIrukC/XU8X/N2MWCBP6v
	RMPxvCVydvnK85osICRqfZ3mkBA+rPuYAtYg+ryRFzs0Z2+eHwepVo+C8T6yKwM/iNxXqo
	vYEuG9Dj7FouVHIXr70teKd/yO8Y8uKnn/U/evOmsZNX5WFkc9WDI8o356Vbg4a3nI9TT8
	nfTyctcfqPMs50Y1NQSnRqPPjDoQD5NTPGjpD9pYSJK73OxMTb7Fjpai6ydXLhxjyAa81N
	0L3XPokGXHPYsh9yv18AX9Sy0Py5k+Wfoq0/igioNjW2NtnDrUM2N3pijFMT9w==
Message-ID: <45a8324481c367a69f25e8c395ff6784b441a834.camel@mailbox.org>
Subject: Re: [PATCH v2 1/2] drm/sched: Fix out of bounds entity priority
 check
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>, Philipp
 Stanner <phasta@kernel.org>, 	stable@vger.kernel.org
Date: Mon, 02 Nov 2026 11:46:08 +0100
In-Reply-To: <20261021094227.48034-2-tvrtko.ursulin@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
	 <20261021094227.48034-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: be023fd9551cd454391
X-MBO-RS-META: mryqex7mdyz7hmerchnuaoynbob4gght

On Wed, 2026-10-21 at 10:42 +0100, Tvrtko Ursulin wrote:
> When the out of range priority at entity init time is clamped to the
> number of run queues in the supplied scheduler the internal run-queue
> priority needs to be adjusted as well.
>=20
> There is no impact since none of the drivers hit the clamping path, but
> we still need to address it by moving the entity->rq_priority assignment
> to after the clamping is done.
>=20
> Note that a lot of this will hopefully get removed once again when the
> single run-queue simplification lands.

So this is no existing bug out there, but merely for formal
correctness?

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: <stable@vger.kernel.org> # v7.2+
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 27 +++++++++++----------=
---
> =C2=A01 file changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index 7be0387bac3c..e12709b7bd0c 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -130,10 +130,7 @@ int drm_sched_entity_init(struct drm_sched_entity *e=
ntity,
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&entity->list);
> =C2=A0	entity->guilty =3D guilty;
> -	entity->priority =3D priority;
> =C2=A0	entity->last_user =3D current->group_leader;
> -	entity->rq_priority =3D drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR ?
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_SCHED_PRIORITY_KERNEL : priority;
> =C2=A0	entity->num_sched_list =3D num_sched_list;
> =C2=A0	entity->sched_list =3D num_sched_list > 1 ? sched_list : NULL;
> =C2=A0	RB_CLEAR_NODE(&entity->rb_tree_node);
> @@ -144,25 +141,25 @@ int drm_sched_entity_init(struct drm_sched_entity *=
entity,
> =C2=A0		 * not to do this and to fix their DRM calling order.
> =C2=A0		 */
> =C2=A0		pr_warn("%s: called with uninitialized scheduler\n", __func__);
> -	} else {
> -		enum drm_sched_priority p =3D entity->priority;
> -
> +	} else if (priority >=3D sched_list[0]->num_user_rqs) {
> =C2=A0		/*
> =C2=A0		 * The "priority" of an entity cannot exceed the number of
> =C2=A0		 * run-queues of a scheduler. Protect against num_rqs being 0,
> =C2=A0		 * by converting to signed. Choose the lowest priority
> =C2=A0		 * available.
> =C2=A0		 */
> -		if (p >=3D sched_list[0]->num_user_rqs) {
> -			dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u nu=
m_user_rqs:%u\n",
> -				p, sched_list[0]->num_user_rqs);
> -			p =3D max_t(s32,
> -				=C2=A0 (s32)sched_list[0]->num_user_rqs - 1,
> -				=C2=A0 (s32)DRM_SCHED_PRIORITY_KERNEL);
> -			entity->priority =3D p;
> -		}
> +		dev_err(sched_list[0]->dev, "entity with out-of-bounds priority:%u num=
_user_rqs:%u\n",
> +			priority, sched_list[0]->num_user_rqs);
> +		priority =3D max_t(s32,
> +				 (s32)sched_list[0]->num_user_rqs - 1,
> +				 (s32)DRM_SCHED_PRIORITY_KERNEL);
> +	}
> +
> +	entity->priority =3D priority;
> +	entity->rq_priority =3D drm_sched_policy =3D=3D DRM_SCHED_POLICY_FAIR ?
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_SCHED_PRIORITY_KERNEL : priority;

I guess my main question regarding the code is why you moved those
lines?

> +	if (sched_list[0]->sched_rq)

Couldn't that remain in a terminating `else`, reducing the git churn?

> =C2=A0		entity->rq =3D sched_list[0]->sched_rq[entity->rq_priority];
> -	}
> =C2=A0
> =C2=A0	init_completion(&entity->entity_idle);
> =C2=A0
