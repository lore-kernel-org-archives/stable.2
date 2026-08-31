Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA133815DD
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155450; cv=none; b=QASJLBMe1U21jZNKqO/2C8wvnTLPqj+aM1m5FGHqB1X4+BBcXs0u9oR5IBXNmESadWMp1p/c5+apG26rwEJS9palJGUJL+JUKf1MdkOY6X/8NgjsAOQg4UVGjHq4j00qRacWf5zxFwNauRt9hpuASMjIbkbdyBy4ozInpdhUGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155450; c=relaxed/simple;
	bh=4+1AjoOEMcdtmG5GS4EjWm9+KjN0DN8Rjkp+5jnZUoU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Ejmfdf1C1sbpG94aSjMMQylOkN6oNODLBVpxS++qATtkorn7LcDZzOP1gZDJ3bPWMYveRQuSyyS3Y8HYMMNiXO8Pkplrv00HpU1cjscoCIAt32uSvejrlRtAGdSrcJjcCk2i4lEE+ORE6/Gv41dC5QlJvQbqU7hTYbnWjDDLipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kmz6VrTc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kmz6VrTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788155448; x=1819691448;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=4+1AjoOEMcdtmG5GS4EjWm9+KjN0DN8Rjkp+5jnZUoU=;
  b=Kmz6VrTct1VjCHJiKbJ/o1wrFkN63Pq47nGovuGjSY/xyJ+r4m/QkUwA
   mrn5wiF/9xbpIQS1jUR++R97I5F78CUz2U7x3d4StgFkMhNJ3h6vD+7cD
   HDqyzlmXRYGIHL53lRZ2ocI11CulvrONbbm73wRYSRfzlHLjQzUkIHuXE
   Wzr6DDht/bIEA7csLWLAwCDimwKY48/rOXy+WZ6eQ/oBLalMuUYMk7L2x
   VtJ/9+dY6cT4JcULdZ9jm6p/PwuSKcgN8uYkbAu+zIVcSPGLY5YUkmn+b
   smeKc3JKMsa/NeWS5jhqDg6+ost9WCQ4S66EbSHIfokDSwgHlLei1Xwcm
   w==;
X-CSE-ConnectionGUID: COud/cRfSIuHrQjZWUCHpQ==
X-CSE-MsgGUID: EgwvJEDPQju+BDeJpAqJIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88574911"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88574911"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 22:50:47 -0700
X-CSE-ConnectionGUID: CA7ykUwzR6ynHc0RLuwRoA==
X-CSE-MsgGUID: oD+mN2joST+26lHQs6m7Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="265465160"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.31])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 22:50:44 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <BA6527E9-BF25-4EAC-AD11-7B2F92A3A01F@gmail.com>
References: <20260808184302.1509585-1-shuangpeng.kernel@gmail.com> <apSwfmDiwsuyQT6I@zenone.zhora.eu> <BA6527E9-BF25-4EAC-AD11-7B2F92A3A01F@gmail.com>
Subject: Re: [PATCH] drm/i915/gt: Fix request use-after-free in heartbeat()
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net, stable@vger.kernel.org
To: Andi Shyti <andi.shyti@kernel.org>, Shuangpeng <shuangpeng.kernel@gmail.com>
Date: Mon, 31 Aug 2026 08:50:42 +0300
Message-ID: <178815544216.17173.15017693568712093310@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620

Quoting Shuangpeng (2026-08-31 03:13:28)
> Hi Andi,
>=20
>=20
> > On Aug 30, 2026, at 18:44, Andi Shyti <andi.shyti@kernel.org> wrote:
> >=20
> > Hi Shuangpeng,
> >=20
> > On Sat, Aug 08, 2026 at 02:43:02PM -0400, Shuangpeng Bai wrote:
> >> heartbeat() detaches engine->heartbeat.systole with xchg() before
> >> checking whether the request has completed. If the request is complete,
> >> dropping the detached systole reference may free it. Concurrently,
> >> idle_pulse() can observe the empty slot and publish a newer request.
> >>=20
> >> The worker then sees a non-NULL engine->heartbeat.systole, but continu=
es
> >> to dereference its stale local rq. The newer request can therefore make
> >> the shared-slot check succeed after the old request has been freed,
> >> causing use-after-free accesses to emitted_jiffies, submit, and sched.
> >>=20
> >> If the detached request is incomplete, heartbeat() can also overwrite a
> >> newer request published by idle_pulse() when it unconditionally restor=
es
> >> the old pointer.
> >>=20
> >> Use cmpxchg() both when idle_pulse() publishes a request and when
> >> heartbeat() restores the detached request. Drop the detached reference
> >> when restoration loses the race, and reload rq from the shared slot
> >> before dereferencing it.
> >>=20
> >> A KASAN-enabled i915 mock selftest reproduces the use-after-free before
> >> this change and completes without a report after the fix.

The test should be properly submitted and reviewed first before we even
consider merging this, especially with such bad commit message. The commit
message doesn't mention a word about real world usage scenario that
could lead to this.

There are probably hundreds of ways to cause kernel to crash by crafting
selftests, and if they don't map to any real real hardware usage behavior,
that's just noise.

Regards, Joonas
