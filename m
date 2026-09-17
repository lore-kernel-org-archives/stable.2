Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD344CAC6;
	Thu, 17 Sep 2026 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628249; cv=none; b=nLJAT57QEYtlDW+o6xhyDan3i514tkdXrFnICQ1cjYnAr6VvZhI0v4r25puc7cU8fG1ueE94k1cbJ9w5xrSm7dtK5ik9EXhWtx/xuWO8MVMPAj3HbtlxMBi5Awa0H0LFoepRdQQLZR7pStrpPNu2RulIvv7YJx/mRU1iZemcXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628249; c=relaxed/simple;
	bh=emH1J4cBgiN5T9BbNi7z7yhKApmeSxcgOTtnbUvF3DA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ZfI8sv74hHFXEluBBAzwpK4meSezwJWL0ZpgIdvxP+VnAeZh7u7mJAT8j9SqVeFL77CT724EC+1l4wlFeNOMdOQTg9zN7vIi8pViZGs49zEHSp1aQbJX7x+Kih8osT6u9LxyWWm9gHXYtyhUSQOmL0RkJa+qvCn2L7XR8sJ7XIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nhqvs3nW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nhqvs3nW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789628248; x=1821164248;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=emH1J4cBgiN5T9BbNi7z7yhKApmeSxcgOTtnbUvF3DA=;
  b=Nhqvs3nWjxPy63A9i4ZUptin9VKCY5NdVQQoy6sbt1o4jJFb+ekcGjFd
   y85WZ72Nk7ukAsTp4KvOrhzrtNYJPKShdcxNFl6k9js4Ylt/Pzq9b8x06
   esgOx/W6/sZIDU5bukL54K6BGrErWNaz42/xxP8QUInwj9xDfiGyFmvVY
   NUfZEYMiEnhxyTRQRnfEsLz+AOh7nGTIRL8ALSfBiVrm2hVE9tCOJB/Oz
   TiHqHMA43h7z5ZKINKXiQ9KqKjZ8uzCOLFSMpjg54OuVw8GkzviXWo1e6
   xAE8/91w7iwL6Nus63QodkmKjqXfdyayc8LvtJ0Qcdr/sGbeIPLgQkbBY
   A==;
X-CSE-ConnectionGUID: t/jy3L9HSTq04uQmKMRT2w==
X-CSE-MsgGUID: I98EVbdRTeS+zkH4LukF/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93846233"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93846233"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:57:25 -0700
X-CSE-ConnectionGUID: 7sCm9ffsTReAiqJK44SzgA==
X-CSE-MsgGUID: 8gnKXQFZRDiQK/kt8e4gZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269333869"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:57:21 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260916171935.2087305-1-vulab@iscas.ac.cn>
References: <20260916171935.2087305-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] drm/i915: Fix vm reference leak in mock_gem_device()
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: andi.shyti@linux.intel.com, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org, matthew.d.roper@intel.com, rodrigo.vivi@intel.com, simona@ffwll.ch, sujaritha.sundaresan@intel.com, tursulin@ursulin.net, Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Date: Thu, 17 Sep 2026 09:57:18 +0300
Message-ID: <178962823827.28653.5098493516220452854@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620

Quoting Wentao Liang (2026-09-16 20:19:35)
> mock_gem_device() takes a reference on the GGTT vm for gt->vm, but
> neither mock_device_release() nor the setup error paths drop it, unlike
> the real teardown where intel_gt_driver_release() releases gt->vm.
> Drop the reference before mock_fini_ggtt() and on the error paths.
>=20
> Fixes: cdeea858d8df ("drm/i915: Remove unused i915->ggtt")
> Cc: stable@vger.kernel.org

We're not putting Fixes and definitely not Cc: stable for selftest
improvements.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

You clearly did not try to address any of the issues per the surrounding
coding style or understand the severity before Cc stable, but just generated
some static code fixes and commit messages with LLM.

Looking at your history of spamming the LKML with 30+ patches per day
and not a single response for requests to fix things or add the
Assisted-by tag, don't really expect you or even your LLM to read this.
So this reply is more for documentation purposes.

Doesn't really inspire any confidence to merge anything or look at any
further of your multiple patches which you send separately and not in
series in the hopes of getting some merged even when pushback in others.

If I happen to be wrong, let me know.

Regards, Joonas
