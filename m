Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AF28033B;
	Tue, 11 Aug 2026 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429332; cv=none; b=hjTmKpIoUv9FHRHDnU3SOoqokLtE/M2vXlSaLR/BnhRI/pTcQJhFD8EgP1zOks86TRob6G+AVMX6IfImA1Okxi5k6z7gqCqFdESqmMW3Im2Pen8C4Qfwiop1jW3aQOb/f9S0XnyMF3DpzGlQIxJ5sCpQNJEpOhGnT/QfPvkgLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429332; c=relaxed/simple;
	bh=GMObyUPwCjPPQhWIN6HvrJoo3caoDJYLaj2BlbP2DKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwbutoo/vURrPd152TZjNOOZpWgvDR3o+VmzSHbCBt9s48merMYFoYJMLbblXbXROzGJVuLp9KZxNEaBpnN6nHyDibJsKbw+3J03BZTNXw2GDJ/uhFf1awPsBYjjShmHh8xOhl5xoQkoLbR96HVtL+aSbjXMSxRfO7+JkSKxWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJYDy1Qk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJYDy1Qk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786429331; x=1817965331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMObyUPwCjPPQhWIN6HvrJoo3caoDJYLaj2BlbP2DKA=;
  b=BJYDy1QkihfsTtsQg+4vGOtxGtP12GxBczZ0ty0a4pfafSGxZ1CgqJdW
   XSSXzJ0rfynswVlV4k1mETJxl5WYBMS/g7b6ty6iXEIRAg/qziYqyWJev
   3FQ78IiUS6nTzLQaAX248YQ8pSy9aGeGb/gcGY/v+lHIVJslZ1V3hHD0k
   uFOhaRjt2gu6vJcPaBx/iVdGjW19bz2I/r45T8+R7E8cptyHQYsDoloSF
   f15bIzsBujKL2HObZEyp0VNgaQooROq79qk76SCCK6BTWqPCJ3ZmL5bPD
   t9+00jODQelmhV0HU0jVi4vqOR+sMWzc795qlbzEIMUyV7UvQ8p+Kwedc
   g==;
X-CSE-ConnectionGUID: 0wr9YMZ+Qv2SRKUn02YGLA==
X-CSE-MsgGUID: UBd21uSgSPO49dKnHZd4jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98312128"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="98312128"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:22:10 -0700
X-CSE-ConnectionGUID: jQqtwGpyQFqs9hEqY8UoeQ==
X-CSE-MsgGUID: HOapSJczRcyjl1EAc7KRCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="267096086"
Received: from slindbla-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.215])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 23:22:09 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2168811FC6D;
	Tue, 11 Aug 2026 09:22:07 +0300 (EEST)
Date: Tue, 11 Aug 2026 09:22:07 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: raoxu <raoxu@uniontech.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-async: avoid deleting unlinked ASC entry on
 link error
Message-ID: <anq_jydB3EGDBqaO@kekkonen.localdomain>
References: <660DEFF8A732CF1A+20260810095012.2213444-1-raoxu@uniontech.com>
 <anq_U0kj6EfTN_cj@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anq_U0kj6EfTN_cj@kekkonen.localdomain>

On Tue, Aug 11, 2026 at 09:21:07AM +0300, Sakari Ailus wrote:
> Can you resend this, please? Somehow Patchwork didn't pick it up.

Please ignore. There was an issue with Message-Id coding I suppose.

-- 
Sakari Ailus
