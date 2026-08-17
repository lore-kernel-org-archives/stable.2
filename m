Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C843F8883
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967638; cv=none; b=E5I0AnLvcLH+qUkXYc6YUwA6Y46n2sqaw84q1FQBiMoZrV9MrexDvu8IzEBhpNUI3L6NLXGofsq4oBwiVGHLlQJz1laX+xLAZKt355XPs7UukXOZZ5d4+jeSj5uG4ZIw9VaTeYY7JJqb0f8IJ0XIEPYiH4voESrPpQVqGsCufvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967638; c=relaxed/simple;
	bh=+/bqTqtvaMpQwVdt40/6DcZZsmpN3J07tYSFPs6Cu4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NOtEBECBPEGXOo9rR8dl5Jgb51RlUMBcjbZtD8OVCNa+HtycpQDHxrZDLJ+P98MTZDNt5q/qzy/SGp589gDMKgDoVxOZLSk+rrT3X4j0LYjbSanamr2Qj9wMALJ/fLf3LmTUuD2UfU7CZpD6Sxyj5aKRJFlfIVoE2d5jm941JL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGuDCnlf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGuDCnlf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786967636; x=1818503636;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+/bqTqtvaMpQwVdt40/6DcZZsmpN3J07tYSFPs6Cu4w=;
  b=dGuDCnlfVEYGFboO/ouyJx/YEwYfgiKd7J9okzo7K1Q375HppbLKlv+S
   nFt186j0Afsy92OM58XVnVBvonH2m6JvhN2y6siFaNoFhMvBgi59lgxdC
   fGMcXUM2t47W36dQUy8PaD3KRC5sc0SdVRANcAbPM0hgJYghdJBznS/2n
   dybXjI9yItZ14kRskNA60DtfG6cRhkk3l9o2cOR6yvH0qIYEE980U72BN
   jA+Oq5MctCy4ob7aZDvrJ51n283ILJo6cuvkilSKQViCfxeNdps2dC+t9
   nGTa/nuxfRVSUB6F1dSuTzRSOHeWJJlREo8mVBd4X1qJunclRGZb/Qky4
   Q==;
X-CSE-ConnectionGUID: 45Zi+2RiTuW1ZDCNy6rEkw==
X-CSE-MsgGUID: Vqq6qFi9ROKRTNCZpDEx8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91118802"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="91118802"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 04:53:56 -0700
X-CSE-ConnectionGUID: PfoUBt8OSIOa3defDweSIA==
X-CSE-MsgGUID: yswT0odaTESlrrsrtneepA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="266877589"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.110])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 04:53:53 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, regressions@lists.linux.dev,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 =?utf-8?B?5ZC05rab?=
 <rpwtsama@gmail.com>, Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: Re: [REGRESSION] Panther Lake 8086:b082 internal eDP black after xe
 takeover since 7.1.6, still present in 7.1.8
In-Reply-To: <20260814193000.13@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <CAF38RzLOUW1ZB1f+Q2f9mhnYs+t4R2+UQA1PCihz_FKEu-nSew@mail.gmail.com>
 <20260814193000.13@kernel.org>
Date: Mon, 17 Aug 2026 14:53:50 +0300
Message-ID: <b2154dc24ac1756c2befdd90d95c7f6eac4dff1f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 14 Aug 2026, Sasha Levin <sashal@kernel.org> wrote:
>> Known good: 7.1.5-arch1-2
>> First known bad: 7.1.6-arch1-1
>> Latest tested bad: 7.1.8
>>
>> When the xe driver takes over from the firmware framebuffer, the
>> internal panel becomes completely black.
>> Close and reopen the laptop lid.
>> The internal panel starts working normally.
>
> Thanks for the report. I believe the culprit is 2ee8dbd880b1 ("drm/i915/cdclk:
> Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable"), which is in 7.1.6.
>
> Mainline is affected in exactly the same way and there is no fix upstream yet,
> so there is nothing for me to pick up.

Please try [1].

BR,
Jani.

[1] https://lore.kernel.org/r/20260816062344.796615-1-xspeed1989@gmail.com


-- 
Jani Nikula, Intel
