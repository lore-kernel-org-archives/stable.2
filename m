Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D611A6834;
	Mon, 21 Sep 2026 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972262; cv=none; b=abf1yxxdwybKVxhEqAqrU95MwLOkQHq3BdQgW8zOQ6vSc5IrlHtnXdyUJfPoOYlPlvuF1Jehj3EKLWlSzdM7/dbluFyz8igl/8Jl7O48ZmE3pEtK2OxxcRVD6c6t2CXvMb9x1dlSSxkvhOluMPaGqBNUDfgOO6zbEGyblosOqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972262; c=relaxed/simple;
	bh=HtBwz7MpjVfsvm3vZY/Sk05dMHNZT6Od24wsVNFrNxk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=UiTnS7FI0FpWOsYFTkAre6mkj9ZR++sDwgGFNpnEh8n8KSd4U45yaXySWLaURpmzM8+F0SYGYz/oLNE+Z1OtBicge7ThW2yKf/8ekrCdei2qkpSe3tSxHEW51N2gyPWHQ9Bk0SNrTUc2qiCz0f3cKOCqE87xJmss6d/ue0yT5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wtk5edny; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wtk5edny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789972260; x=1821508260;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=HtBwz7MpjVfsvm3vZY/Sk05dMHNZT6Od24wsVNFrNxk=;
  b=Wtk5edny4RduoWLcZxji1Oinn7JvOrHt/fpj1g75iCkUJkXoBeSY0w6m
   7cnz7TrmmxffWzbv7ogfQw4Ai9gMlWPupli+UyaWFGu0c17j7FDmDyd+5
   44V8lhBL5+0c78EqsuWTyL/lP29rBwcfZ/OvZFfLwgEHrCkW5fLbSSzk+
   hIn8TmsoaTHJzFMfDInTdao+N951/4X7vksy0WnOrhcz90KNrXD/+Ld/9
   Jub3oM+zeSIbw5Z11o+A7LhhTkS+sfvSnQHQdb+q2V+I0CPARtIKwswcf
   iLtikAPbBBWGOE/pKqBeJLYU9pmdW/wuBsF/B1NKEHgbw9OPz8fJrXPRT
   w==;
X-CSE-ConnectionGUID: jp8lWRtzQjim8Is0zqeOMw==
X-CSE-MsgGUID: MjmreMj1S1enHujj7SUKxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="971835"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="971835"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 23:30:59 -0700
X-CSE-ConnectionGUID: WdnO2D4rQri/9a2FF6dXig==
X-CSE-MsgGUID: nX8TpcC+Q0+GS22QJVfQWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="300460814"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 23:30:56 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260919171710.3699710-1-lgs201920130244@gmail.com>
References: <20260919171710.3699710-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] drm/i915: fix mock ring memory leak on context allocation failure
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>, David Airlie <airlied@gmail.com>, Guangshuo Li <lgs201920130244@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Matthew Auld <matthew.auld@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 09:30:49 +0300
Message-ID: <178997224953.20141.15039837012698810465@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620

Quoting Guangshuo Li (2026-09-19 20:17:10)
> mock_context_alloc() creates ce->ring before allocating and pinning the
> context timeline. mock_ring() initializes the ring reference count and
> returns the initial reference to the context.
>=20
> If intel_timeline_create() fails, mock_context_alloc() returns without
> dropping the ring reference. The same leak occurs when
> mock_timeline_pin() fails after the timeline has been created. Since
> context allocation did not complete, CONTEXT_ALLOC_BIT is not set and
> the later context teardown does not release the ring.
>=20
> Drop the initial ring reference with kref_put() on both failure paths.
> When the reference count reaches zero, intel_ring_free() releases the
> ring VMA and frees the ring allocation. Clear ce->ring after dropping
> the reference to avoid retaining a stale pointer.
>=20
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>=20
> Fixes: 75d0a7f31eec ("drm/i915: Lift timeline into intel_context")
> Cc: stable@vger.kernel.org

We're not going to put Fixes and especially not Cc stable in
for selftests.

You should use onion teardown idiom instead of duplicating code.

Commit message also reeks of LLM generation as an average developer
doesn't need "explain to me like I have never programmed before".

Regards, Joonas

> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/i915/gt/mock_engine.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/gt/mock_engine.c b/drivers/gpu/drm/i915=
/gt/mock_engine.c
> index 79741f043f03..fa4368730d33 100644
> --- a/drivers/gpu/drm/i915/gt/mock_engine.c
> +++ b/drivers/gpu/drm/i915/gt/mock_engine.c
> @@ -170,6 +170,8 @@ static int mock_context_alloc(struct intel_context *c=
e)
> =20
>         ce->timeline =3D intel_timeline_create(ce->engine->gt);
>         if (IS_ERR(ce->timeline)) {
> +               kref_put(&ce->ring->ref, intel_ring_free);
> +               ce->ring =3D NULL;
>                 kfree(ce->engine);
>                 return PTR_ERR(ce->timeline);
>         }
> @@ -178,6 +180,8 @@ static int mock_context_alloc(struct intel_context *c=
e)
>         if (err) {
>                 intel_timeline_put(ce->timeline);
>                 ce->timeline =3D NULL;
> +               kref_put(&ce->ring->ref, intel_ring_free);
> +               ce->ring =3D NULL;
>                 return err;
>         }
> =20
> --=20
> 2.43.0
>
