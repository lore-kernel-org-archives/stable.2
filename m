Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C13BD24A;
	Mon, 21 Sep 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000991; cv=none; b=NsYM/rTJCVAsY2jaZxV+9WyiwIMIjcYMyJUQH0mB6juS4/OreILNNY547WPTUKQbZuvpNv/9NdVf5o7soHvsp2BfIw2y1cLJ6J2Y8gPYT3BvWBuhGQVbPFPO8R6BEpJXMm9BnZWYAEZhfQA9PxMo4DI9ztyUKOd/DC6R1ztC9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000991; c=relaxed/simple;
	bh=SSVk/3lKlxay8grtIOLg2gd71gvlBOOgyqED/rsKdWw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JluD069dz2FagZLoMfPn2GmU3j0fO+exVgmkKJLA9FJxU3M2fx9OThCeYzua85shiC9YZSot+OoZFUy8Tlx4WOFdOldp5XX/VJN3HDkJVrKLr0P8MHmwqo1iGsAQyMINsl90s/8MoBQWmNJtU8ucR9ZLsZ7TdLONxJtSsyuf/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFrGfAlr; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFrGfAlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790000990; x=1821536990;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SSVk/3lKlxay8grtIOLg2gd71gvlBOOgyqED/rsKdWw=;
  b=ZFrGfAlrIM8Golw9tgEAz2qadBiH6L5m3W7nyk2pcWBkbjzh7IVWd1xu
   Y1LWv50Jo65/5HvpVbjCEhP5CYpSOI887qI93Efa9usRSX4ykxscNXP2L
   sAUuVFPpDfTkBPM2MnLXMVtz0HkNxZ+dNrG2Z1+YZNwxb4tmG/FVANIzm
   8Bg8Tqmyn7I/PBHmZ1TDEfJ0D2oeZLoAWzjL9R+vakW4BVt6McwGddURO
   6osjGbS2rfIvecxF2veKM0frg3KIQBti7Ucxncgmuz5g4kLxQc9E5+xfm
   2kt/UxMRKau8rhjZbjJEAUUjub9Y6GRj5N8E/R4/Gfw1zqRl3qxj3vFzr
   g==;
X-CSE-ConnectionGUID: S197eTb0R2igqKD9wGy/jg==
X-CSE-MsgGUID: Ih6sdPTFSzyAOhB3LpMdvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1022074"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="1022074"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:29:49 -0700
X-CSE-ConnectionGUID: kkYFSOSwRnmNNWCjeQaMnQ==
X-CSE-MsgGUID: DQyco8V4RY++Xlihw+hlKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271855957"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:29:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Sep 2026 17:29:38 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: jorge.lopez2@hp.com, Hans de Goede <hansg@kernel.org>, 
    linux@weissschuh.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: hp-bioscfg: fix heap OOB read and
 buffer desync in hp_get_string_from_buffer()
In-Reply-To: <CADqcGBnGHd+rRn6b=eWVjhWDU-NQ4CFb-3B9cgwBeouN-sbw4Q@mail.gmail.com>
Message-ID: <ab2078e1-4388-6311-0363-afdfc131ea60@linux.intel.com>
References: <20260824225610.18471-1-meatuni001@gmail.com> <20260824225610.18471-3-meatuni001@gmail.com> <a67d4e52-5e87-0e76-4c91-cb8ba2be31f9@linux.intel.com> <CADqcGBnGHd+rRn6b=eWVjhWDU-NQ4CFb-3B9cgwBeouN-sbw4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 19 Sep 2026, Muhammad Bilal wrote:

> Confirmed, you're right about the redundancy.
> 
> utf16s_to_utf8s() takes src by value, so it can't advance the caller's
> src pointer. The second loop then restarts from the same position and
> overwrites everything the conversion just wrote, using dst[i] = *src,
> a raw truncating cast with no UTF-8 encoding. So step 2 is currently
> dead work, and the function is ASCII-only in practice: any character
> above 0x7f gets truncated to garbage instead of being properly
> encoded.
> 
> Two ways to fix that, and I'd like your preference before I send
> anything more for it:
> 
> (a) Keep utf16s_to_utf8s() as the real conversion, and rewrite the
> second loop to do escaping as a pass over its UTF-8 output instead of
> re-deriving from UTF-16 src.

Not exactly this, but somewhere there.

You should not try to build the escaping nor utf-8 parsing/length 
calculation within the driver but use generic code for that.

To give some directions...

There seems to be some escaping function in lib/string_helpers.c but since 
we're dealing with an UTF-8 string here, there might not be a readily 
available function for string inputs/outputs.

escape_space() seems to also cover escaping \v, which wasn't among the 
characters this driver escapes. You might need to check that particular 
character in driver before calling the library's escape funtion though 
I'm more thinking along the lines of not escaping it was an oversight from 
the original submitter (given the questionable quality of this driver to 
begin with).

utf8clen() seems to exists, but is currently in inconvinient place (and 
already duplicated so it should be placed into some header anyway).

> (b) Drop utf16s_to_utf8s() entirely if ASCII-only was always the
> intent, and keep only the manual loop, fixing its bounds instead..

I think ASCII only was not the intent, but it just happens to work in 
many cases which is why this has survived so far.

-- 
 i.

