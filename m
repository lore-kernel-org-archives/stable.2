Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56823D7F4
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296692; cv=none; b=OgmjCu8ymFhY3pq4yRSKxlp8JT3V+ccl8vUU30i+gs1wmRFw/Mk0g93FXKoMLPrIItb80YELorphezO1XEwMMXoyKwzDYsotlDUjyioP+2KfPAhIOj3GX8YG45FXYM+7bqt/kfFX23uuJIXiF5uK0qugC90a4LhmaAkKoYH/Rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296692; c=relaxed/simple;
	bh=5Mey65aFEMMsVLYRqQkLW5v1sN0ij2YCq1EqZjWXdng=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Rd01fkHWDwCyBEBznC+cEgIjYWxcTNov2Y6vh+gKMjgfd08C/FuDaoVT+KVXLCCDrs5viPNzgHa3T55BsnLr1OvOcz3alCk0WJpK7J53QYUX+jeSINrVmfq2kU2RSTdigYsD9dgKt91oE8wPUfFmIdt+jNBHFqaiG6UvB3YZYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5QH2w/h; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5QH2w/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782296690; x=1813832690;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=5Mey65aFEMMsVLYRqQkLW5v1sN0ij2YCq1EqZjWXdng=;
  b=T5QH2w/hM1c1wAgl2ja+P2DOLoPv+mMe2axJjZc+grrI1UEtHcX54uE2
   SrqRE1ThY0YbvQZSlDXnpd44svB2m3L0YXIZp89L41cQA0o0bdHZBUemC
   7VZaehg+ym2QCKTsLXxrlLaPvEdEM/nqEaeWm6O2TL96m5WgPl784Kc4g
   CcycSyta7XiEunZ9KDKqEJ91+353hVAVYYFZzKpQUHuRrW6Nj2XlvEOX0
   ur4p7xiPF0X9VtKKl1/LXDa2l/asj2Pi8fUF+AyUxNGTiQRtzI1JYxlT8
   cjDoNaLzJA0z3Q6/vK/5st4J6C/lcdlajao27wLWh27YVQv3cXX24SQy2
   Q==;
X-CSE-ConnectionGUID: O1yquWoLSqKPRvojegT8Bw==
X-CSE-MsgGUID: e5yBgEbNQuqt3L8plAl2hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93651635"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="93651635"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 03:24:49 -0700
X-CSE-ConnectionGUID: 9yUWxfg3QY+DmmslQGYWdw==
X-CSE-MsgGUID: QHjZWvbwRI6DZnFG3U7AgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="243420969"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.147])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 03:24:47 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DJH67X9IJD3J.1YRKHO7I0JSZF@intel.com>
References: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com> <DJH67X9IJD3J.1YRKHO7I0JSZF@intel.com>
Subject: Re: [PATCH] drm/i915: Return NULL on error in active_instance
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Martin Hodo <martin.hodo@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, stable@vger.kernel.org
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Date: Wed, 24 Jun 2026 13:24:44 +0300
Message-ID: <178229668435.102045.3320967434448969310@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620

Quoting Sebastian Brzezinka (2026-06-24 12:27:07)
> Hi,
> On Wed Jun 24, 2026 at 11:09 AM CEST, Joonas Lahtinen wrote:
> > Avoid returning &node->base when node is NULL due to OOM
> > during GFP_ATOMIC allocation.
> >
> > Discovered using AI-assisted static analysis confirmed by
> > Intel Product Security.

<SNIP>

> > +++ b/drivers/gpu/drm/i915/i915_active.c
> > @@ -318,7 +318,7 @@ active_instance(struct i915_active *ref, u64 idx)
> >        */
> >       node =3D kmem_cache_alloc(slab_cache, GFP_ATOMIC);
> >       if (!node)
> > -             goto out;
> > +             goto err;
> just a nit: this jump is not neccesery, you could return early.

We specifically want to embrace the onion error handling idiom with goto
rather than doing the spinlock release inline here.

Preferred error handling should look more like:

	if (!try_lock(lock))
		goto err;

	mem =3D alloc();
	if (!mem)
		goto err_lock;

	if (!bla_bla(mem, bar))
		goto err_mem;

	...

err_mem:
	free(mem);
err_lock:
	unlock(lock);
err:
	return ret;

Rather than:

	if (!try_lock(lock))
		return ret;

	mem =3D alloc();
	if (!mem)
	{
		unlock(lock);
		return ret;
	}

	if (!bla_bla(mem, bar))
	{
		free(mem);
		unlock(lock);
		return ret;
	}

	...

Regards, Joonas
