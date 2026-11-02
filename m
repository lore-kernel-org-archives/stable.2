Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616170;
	b=4P1GgX06HNmLH9+NzrvzuZhuWZiLGCDNeajor/7R4B5MILoTdK2o9Yd0zf8JcNmQhAkw
	 st25Ti+O8muCOwLA9AT45GA/deA628dMbMCVO6mOgaYCpPqUxgA7EKxDuhsJ/GUaEqzAm
	 WSgRoyixZjYOs0qOXr3CVJ7jma2hOwWHLCo6SO8UULMc1oepzVSRTF72ExY/gTXpgo5Cp
	 O56Szu37sxlijvTLURP01BQGYG3NlEw73SLtrRuqvFI43eZjLVKt/2QPbBRRUhm4TJjRD
	 +YIHjz0vM/tOOeFUks6Iy48G47qYSF7wictojkCBrXkQ2cV1cAYtnnqQnvfJjH9vG0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616170;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=jObuHRsCSR9IFpZLb/aXXTzGpA/BD+w9fEoP98E8Ox0=;
	b=1HqgTHEFGIvmWP2u7qNiT0OouGuHW6e7jNsMDl7sp3xzfwv4u8Dziq+smGpVw1odgOWX
	 iLkWovml3UF3fGXZ87YtfXWVM3+RVMgqu+ALE/ocvgopgVc6HRwVHu2a91qL7GQQJoI29
	 7YYOSnVtEo8ZuW2qBCJYD1cQL1sR+nW31siRmA4G+1dbPamK1OPadtXqIcEztBn+EIkFF
	 hYp80VcN1rtgvBGEkfpLkPz51FbQdOKwghtH/mr3GGUEAmOiKxK1JHeQnQk/6xcgpNJa8
	 c4zc60VsbqKwyByV0NFgrvcLBIPdsb63Mj4t+2/+k2m6qYkb6bbg1XaPjtafARv6UrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="qw0D/m8I";
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78B606A86A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED78B606A86A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qw0D/m8I
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jJ7ZZ1Yg5zMlhg;
	Mon, 02 Nov 2026 11:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793616166; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jObuHRsCSR9IFpZLb/aXXTzGpA/BD+w9fEoP98E8Ox0=;
	b=qw0D/m8Imytu8ZsgVsa+ETNeTdvMDlbM3R4/4L3q80Whi+kdxmJtsdEITuvILnSrWGWYb5
	D8TSTvx8OiPK9fJ+rLrSCKvwEIGsqve5mjLEB7BglGw5TdCtLdlJcfsHhJ3uxPW1vo73Sw
	XIn/5cG2F6QpxkcPyZ+pV+k2vOqSPsXGsetddGJ13z0W8SO9kpyTKmzEO0jRWlvfjkNRMC
	sdJz3seKpWrRpD9w/q9nA3a7cbjGrTqrrTJmWgq/5tpSUNJkfYnAImxmU/HOdvbe2dxf4q
	BXcVC5I9aYQgfyiTdftNOxVAkYRR/99qGHj1hyOCC0t16VsEfhKZGyhKXIlb0g==
Message-ID: <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing
 priority at runtime
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>, Philipp
 Stanner <phasta@kernel.org>, 	stable@vger.kernel.org
Date: Mon, 02 Nov 2026 11:42:42 +0100
In-Reply-To: <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
	 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
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
X-MBO-RS-ID: 96b871bb8528972feba
X-MBO-RS-META: 6ic51pac587qqeu37c4brbfhyxpg39nf

On Wed, 2026-10-21 at 10:42 +0100, Tvrtko Ursulin wrote:
> Another consequence of the recent revert of
> 77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run=
 queue")
> is that after the revert we need to adjust entity->rq_priority when
> runtime priority changes are requested.
>=20
> Only amdgpu does that so the impact is minimal.
>  Also considering dynamic
> priority changes are largely broken there, due currently broken entity
> scheduler list handling where the special case of a single scheduler can
> never change it's run-queue. And coupled with the fact for the rest a two=
-
> tier approach of drm_sched_entity_set_priority() and
> drm_sched_entity_modify_sched() is used, where later directly maps to
> different hardware queue priority by replacing the set of schedulers
> completely.
>=20
> Hence the regression is limited to rings which have multiple instances
> other than compute and graphics, which would be SDMA only, for which I am
> not sure any userspace actually does dynamic priority changes in the firs=
t
> place.

I can't fully grasp what the bug actually is. So is it that we forgot
to adjust the priority in the CFS series, or is it that the partial
revert made this necessary?

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: <stable@vger.kernel.org> # v7.2+
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index e12709b7bd0c..03e68b4102d5 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -456,6 +456,8 @@ void drm_sched_entity_set_priority(struct drm_sched_e=
ntity *entity,
> =C2=A0{
> =C2=A0	spin_lock(&entity->lock);
> =C2=A0	entity->priority =3D priority;
> +	if (drm_sched_policy !=3D DRM_SCHED_POLICY_FAIR)
> +		entity->rq_priority =3D priority;
> =C2=A0	spin_unlock(&entity->lock);

So is there always a bug, or only for FAIR?


> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_sched_entity_set_priority);
