Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBA448399
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543412; cv=none; b=XLcHLMpRM58ap2YtnlEPg9lvuiL/QI2cbYFXpm1+SEjcewbTkMSjxkFBT0d++bLpdXC98e5BVplx31x1mFm4yqXa7NzAFqBMxiRQT4xY0nArXIIhAIzVAGG8kZ2vjCrcvFUWCCJAFeYo8sHtB3TnlUQ8eZgrGyAxrD6mzGD+tsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543412; c=relaxed/simple;
	bh=enXKx7Hs6kAeb6eftCq6yc1nHOzd5D+PNTY9rTPv1hM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCe4IrDXlamdlO1wjesdCqzpOhBaoS3El+fcWE1K1ttIFXMLhmazD6A1lUlp+QVNI8RKbK0G/kEFTnk4IEVTeb/r2rroeV5Jsgo0PrxELsRbfMqj7zRv0WQZYkLCTdrK+tC5J++vZMzOgCu1+rS8ajc0LgEByLIpg4jhgbH5+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uDVhELxM; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uDVhELxM"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hl9Mk4CvxzKp4h;
	Wed, 16 Sep 2026 09:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789543378; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enXKx7Hs6kAeb6eftCq6yc1nHOzd5D+PNTY9rTPv1hM=;
	b=uDVhELxMnPG9PuTwD/vxA52OIDDa3G1qh2sc1DdSCIotIjs2gOjwjI9nvxMWtX/HSI3hSv
	xUbDMqyr05F1FE3uZVZlfm2SAmxWkqrzr6P5LpYHnfVBUJR5LEZfRdY5WC5K8RmH24zhQ4
	nx1re/IxD/izT+ZRDVVjs18PT/iCS+rgq+CF1bIq5Km97t91EueirGknvcRTFjpjK05NgD
	BDc3in1NQiwxxMSP8EB9AmxvEYDfholNEYsB1bcgKKxIONuRmMjurMILXiVyddFeL75aC9
	6M7xytKhoHo/nLGYiWdmabYUlxJbqY4jFsKmCpo6beLrUc3y8IpNC82dj1j4Cw==
Message-ID: <166cf2ef60079cb1598db6687ee9395d447ba8e5.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Do not restore unsaved virtual runtime
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
Date: Wed, 16 Sep 2026 09:22:52 +0200
In-Reply-To: <20260915150557.62847-1-tvrtko.ursulin@igalia.com>
References: <20260915150557.62847-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 4mc338tpkdujkpseogqzxpj41o8waqwx
X-MBO-RS-ID: 5a6222f57c809116da5

On Tue, 2026-09-15 at 16:05 +0100, Tvrtko Ursulin wrote:
> Prevent pushing a new job to an entity seeing it being the first in the
> queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
> side in drm_sched_entity_pop_job() has just de-queued the job but not yet
> updated the saved virtual time.
>=20
> Restoring the unsaved virtual time, which is at this point not a delta bu=
t
> still an absolute value, pushes the said entity to the rear of the run qu=
eue
> for a potentially very long time.
>=20
> We close this race by pulling the locked sections out to encompass both
> the queue push/pop and corresponding rbtree management.
>=20
> This is aligned with the future direction to replace the current lockless
> job queue with one of the fully locked standard list primitives.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
> Suggested-by: Luke.Wildhardt@proton.me=C2=A0# via Claude Opus
> Tested-by: Luke.Wildhardt@proton.me

Shoved it to misc-fixes, thx guys

P.
