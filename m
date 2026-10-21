Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565323;
	b=rRZLOSRaVkavuUeKQck5hGyvhNbWoeqG0Jy3T8QbEBWsjMfGPdHl8JABXdb0pGl40c3f
	 eEEWv+vNuzAvYjMnt4wP20uQyC9PzBHrQhKKLn+vF6+lznpg/zdAOrXu5vYLHeYNsYxkl
	 w58JBRyTgbEbwYROIDl/F5RqsbCIo5XoT9Q8W4wr4mnV5oabRI6+3O4ittl2A5sCib+9e
	 Hb2MBnKm0IVWFIyb38DXEA/7Umn51Hhc8a5g4af41ly6FfFN3Jl9ePQM36dMlrtLp0dg2
	 JLSh2Ci7kBWhwHVeeD1wKLlnhsTVs4ujNYxo3NgSQmY0ZvE/Tx0oUcIjIR+1NAbkwxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565323;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=tVrYoC2GNyHc+u63Saj5adRRb4L9cZyGWGvPDu6WnJA=;
	b=cv58He8vezoD1y3gw2anj7Y3igAqvHdQ63J8vIvvtt3a2LBTEmdnpiWnc6pf1wI0Pm9K
	 rpfQLHn9g5crubCVMZEgQWaMCQ/zh+kF/qBxLvlb4iWSGWKUFOx7iS+brR2zyr1Dptchh
	 e4NiADKv5qU/ME3p1k7bqPfbNCN6PbjC4TYpBqdXyTTlNi/E1x2J7/kQ810qSYlTud3yv
	 0+DkUTOE98VsFihRnf0X72GkTAsDwg+5hN2SySM9GIzBsWVUG2ssW609sLySDlMtUALux
	 0ujjLxlVXSnED5rbE8HWNsCxe0w/T9RyluENKJSoWO4TiTuO7CrTId0hk9FIm7YJPOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ihL5tzHN;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A3606A320;
	Wed, 21 Oct 2026 06:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 215A3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ihL5tzHN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792565323; x=1824101323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6oPjgWhIicSGXPQcsb774ShbZMkEPy2e9MCyBSFrfjk=;
  b=ihL5tzHNBxLJYWHyyn9y0F8kguH2yp7G6qNvUeHeR+LfyaMToSuIs3br
   IqbKdfYZiKQLBJz+nU/h44V1sNn1ddIjIKOrrXBm33GK7MvgLeaESAMVK
   t/1V+vi0CvyknNkifaKDjF8dSAIQZ/AxWxw5vm6TQLvP8am5anCtB5T/4
   D3DB2kztj6Cuy/lF9msaikHNI84728gWj7q4tCdXUhL5Fuakv+EoD3Plj
   T90dQpRkg6F7W5uT5jqYOvsaY9DYFtNkjntjp9DPZF/nRhHDTI5Cmn3Ia
   Bpc33Qsiljpy1ehziyhE/nhaV7iixcU1oCrb/EbEChXl/bTrmwk9F/Qlj
   g==;
X-CSE-ConnectionGUID: /RjE1dcoSCqRlJKxbJkEyA==
X-CSE-MsgGUID: 6MIBGfrlRuqEx01Lc255bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1295811"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1295811"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:48:37 -0700
X-CSE-ConnectionGUID: Y+Spg4P1QIucNFyw57F1RQ==
X-CSE-MsgGUID: JqFSjhHYR5mYEfjWJ7cslw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3064719"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:48:34 -0700
Date: Wed, 21 Oct 2026 09:48:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] gpiolib: free the label of lines released after
 their chip was removed
Message-ID: <athgPxNXJK_9-Gcu@ashevche-desk.local>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
 <20261016-gpiolib-chip-removal-v2-2-aambrozewicz@nvidia.com>
 <atIouwa5R8sb0nS-@ashevche-desk.local>
 <20261020125921.2896041-6-aambrozewicz@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020125921.2896041-6-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 03:59:23PM +0300, Adrian Ambrozewicz wrote:
> On Fri, Oct 16, 2026 at 04:38:03PM +0300, Andy Shevchenko wrote:
> > Be consistent, in other patch it's called Call Trace:. Is it really different
> > wording in the Oopses you got?
> 
> This one is a kmemleak report, not an oops, and kmemleak prints
> "backtrace (crc <checksum>):" there (mm/kmemleak.c); I dropped the
> checksum along with the object address. 5/6 quotes kmemleak too.
> Patches 1 and 3 quote WARNINGs and 4 a blocked-task dump, and those
> print "Call Trace:". I plan to keep each report's own header in v3,
> checksum included.

Yes, this is good decision from my perspective, thanks!

-- 
With Best Regards,
Andy Shevchenko


