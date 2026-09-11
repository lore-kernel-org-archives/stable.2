Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36718382284
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119427; cv=none; b=hm26mg++EJ4ilDWN1IfleApYn4r9URoivUX5a8zEpLSJCJ9spmWKJQE/dsOVrGrVj3B8yQqbsFvDZGckkMH3W9ojm5DboGiZzrVnpP586TaQiiusMmbiRlX95DZt4DCBOqAAbz9MJjhxzsMAVcxzG+sx97loWQP8lGc0HKlC62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119427; c=relaxed/simple;
	bh=Z5wCoTIl+45aYG6hAm2vltCTS9lWXhbYWVLJFlcic3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sIYinNgZIS5UhhlXDWtm6mmZGVn/QzbOVkfeng07hEQZssk3CXAoKsyZMLY0s/mn8n4FvVqLASW8Wn2EaEtnpH0nMjBLk2pPsQ9EMGUN9kJ8UiVD0Z/Z+NglHGYFdP6Rm5rK92g+A/WCInakvbe0Q5pfA/eK6NKIcSCeuUrqH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XJ5y7hZG; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XJ5y7hZG"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hh8Zj25xlzMlBb;
	Fri, 11 Sep 2026 11:37:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789119421; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5wCoTIl+45aYG6hAm2vltCTS9lWXhbYWVLJFlcic3w=;
	b=XJ5y7hZGbQ+/SwIQVkS5g4zPN5ObhB1Uyk6wePQ2kRVakYNz9u0IO8xobpIEbxhM82jfZk
	Dfy/vyZyhONjoBNyuOhRN7zdHaTV949ed2AUjbukpm6HwvRl53RTcmL3T4l85Y9lnJ1wTV
	BiVOUaNvj45aFqEWmN6u1/PLfpPH5JpPVjcwRSAztHnEOPnsy/Q+uQEQMeL50QPOmIiLct
	kTAWKJtxZEz72uzsNu60KaVC9dKX260AWJuNixLl7N4lOb6VM/5SPX/QVF2TZele189HZm
	V7QGbjHikw0vgaz8Q8p67xfvIvSt/bbRRYuQJShe07BLzYCJqm7P9boUHj+pWw==
Message-ID: <2958b5de0ab4ee1c46e2068eeb7448d6e2072ee6.camel@mailbox.org>
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
 stable@vger.kernel.org
Date: Fri, 11 Sep 2026 11:36:54 +0200
In-Reply-To: <35456574-5fc6-4270-85f9-940201998116@igalia.com>
References: <20260907130527.52530-1-tvrtko.ursulin@igalia.com>
	 <ad1382b98d5c6cb258658e8e85156a0ccd8dd7cf.camel@mailbox.org>
	 <35456574-5fc6-4270-85f9-940201998116@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: ed1ce29a2fb0d5b105a
X-MBO-RS-META: cgshyo631h45miui1osehgunie9bzxr1

On Fri, 2026-09-11 at 10:18 +0100, Tvrtko Ursulin wrote:
> > So basically you move for locking the spsc-queue, the lockless queue
> > which is usually used with the locks next to it anyways. That's cool
> > stuff. I've suggested this for a while already
> >=20
> > https://docs.kernel.org/gpu/todo.html#replace-the-lockless-queue-with-a=
-locked-list
> >=20
> > So from a maintainability perspective, it would be far cooler if you go
> > down this road one step further and kill the spsc_queue for good,
> > replacing it with a fully locked list. AFAIR Christian and Danilo also
> > have agreed to this.
>=20
> I am happy to work on that just that a) I thought some time back you=20
> said someone from RedHat will tackle it, and b) lets please not gate=20
> this bugfix on that.

Someone from RH might or might not work on that, and perhaps that would
take until 2027. I'm keeping an eye open for people to pick it up, but
everyone's always busy.

Regarding the bugfix, this was reported as a performance issue on high
load, that only seems to be reachable for CFS users, a brand-new policy
that is marked as experimental and is not used by anyone in production
yet. So IMO we can move on on drm-misc-next with spsc-queue, which will
also make CFS usable then.

Is there a plan btw as to how you would like to proceed with CFS?


P.
