Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E728640B;
	Mon, 29 Jun 2026 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738284; cv=none; b=tKecof8cwCP2kfkUzTlafsgRw2XEgoBaf3yIUYAjPjqFnAIgw7mf7CxXPGdcwQFIyUUF2Ve8FHFG4F2HxI4S5Mdm6P7WXRUXPcjHva+ZMmrtxmyDSuLJunrvgeg9jiJnjEmwu5YtP4RoY9z841O+fQDAHUHhBNVJM+n8s3AvSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738284; c=relaxed/simple;
	bh=roUq0HgZG2spQtmWxczSIxhaz13hGW5+fW0oDsAWTqA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=kDnNsAjMe/9GeiBmdzW3942q2TyfcuWkvjEQAhDxRTxAmcj2h/R1MK11mWVQeLFJDyhFP1Rc7gUly7zFWMnfrqih7w8b7rmc1pZX5BDJseujW5iI3XMbeDX68IaEsf2uFdgfr0MoCk+8ZDUtXASOSXzEQNQwGUhc+zI3nOD6wRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XX+zf/ND; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XX+zf/ND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782738283; x=1814274283;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=roUq0HgZG2spQtmWxczSIxhaz13hGW5+fW0oDsAWTqA=;
  b=XX+zf/NDgkxptXcLW0pDRHDxcQ35Uw9BymjXTMdhG6LaGrVlc7OTW/8c
   0KJauRmXIq6yigq6MrTH3ZpuZGju4SnTzlFFXB/wk4gtwh/TQOGmJL5wY
   C2g0ay9qTBGj4WJuBezsfzz23Se/4jgeRaVkjRRoL7uSefMU2pAE3NHRk
   Z56pJmb9YoqXmdDthRJpClkCp5oSCSN6C6pvKkKjMg8iznr91qIRzCnIJ
   w2fwBTXoOBSmJCvHUSdDI1Qwj6yZAVRhfq6z7hV3x45XQ7q4NpR4eiC2I
   HyKmNyohJ/PRVzvFCQYszzmwfwLfzw6CX4giUeHNMUCrZyISGxypECn8Q
   g==;
X-CSE-ConnectionGUID: JfJWG2jdRAiRlJroOI82cw==
X-CSE-MsgGUID: XcmitjnYSluyPLTHEV1PzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83474565"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83474565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:04:20 -0700
X-CSE-ConnectionGUID: IwiEzdBrSuqY5afV3Yz3UQ==
X-CSE-MsgGUID: fSOm1UQaT2qxvSdmnuWphw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250255687"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 06:04:17 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260628140327.46842-1-vulab@iscas.ac.cn>
References: <20260628140327.46842-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/i915: fix kref leak in __live_active_setup error path
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: jonathan.cavitt@intel.com, tzimmermann@suse.de, kees@kernel.org, matthew.brost@intel.com, vulab@iscas.ac.cn, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
To: WenTao Liang <vulab@iscas.ac.cn>, airlied@gmail.com, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, simona@ffwll.ch, tursulin@ursulin.net
Date: Mon, 29 Jun 2026 16:04:12 +0300
Message-ID: <178273825261.121848.1051842737561955544@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620

Quoting WenTao Liang (2026-06-28 17:03:27)
> When heap_fence_create fails, the early error path calls kfree(active)
> directly instead of __live_put(active), bypassing the kref_put path that
> would call i915_active_fini for proper resource teardown. This skips
> cleanup of the i915_active state while the initial kref from kref_init
> remains unbalanced.

Is this AI generated? It hardly makes sense. The object was just allocated
and initialized, unbalanced kref which will be freed is not going to be
issue here at all.

Did you actually look at i915_active_fini?

Real reason to fix this would be to avoid the debug_object tracking to
get out of sync. That should be in the commit message and not some
generic high level description that can be read from the code
change itself.

> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Fixes: 5361db1a33c7 ("drm/i915: Track i915_active using debugobjects")
> Cc: stable@vger.kernel.org

In any case, we wouldn't put Fixes and especially not Cc: stable code
for selftests which need special Kconfig to build and modparams to run.

Regards, Joonas
