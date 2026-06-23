Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73F3988F8;
	Tue, 23 Jun 2026 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245497; cv=none; b=lAjcWP/KRQ81feRB6gLSHJyT2AKVsaqULKytD5P5LuolCiSYqRP086vZW783yKmzrQW+8VAxyU1SA7dEox+9f+4z4ri/dQ1TQdVSg9bfA5VB1To630T4jEF0cRwvvnIPIJZQ1J1dnWW41/gteD+sA2xkqpIEB1yLWSfpMoILdEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245497; c=relaxed/simple;
	bh=kW91b4d2Vx0G184J/85Y4W5ZdTuxK1621sMYs06jpXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb5k+rjjwoiFarfeWvtWbuzEhFAYmbQt6dTuRedMnw4Z9z/rZYVlQp1DV6HVkMvzCydCZHYodDfw+sAPMGEEXjL0soq99khOuT5RqjJ943bVnwmtj0qYdUAjUsI66/rfnj+N2TsHhIi2baWVjymzoMvg/9Sli5DGQXbYztdxaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUsIkQxi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUsIkQxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782245496; x=1813781496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kW91b4d2Vx0G184J/85Y4W5ZdTuxK1621sMYs06jpXc=;
  b=dUsIkQxitSj2VLkN/73e/bUREtYRvi7eOaMx6HIu27Ha3coAQ18QZ7E8
   T7zIYe5rFXDtI/ldMncoQlQuQ1E9XktpScJzjX1+gmBRG2EVlIRc25VS2
   JVOXWGbKrWbnJWqkuGqiEwSOCijFSG0vhZaefWtIlmAsNESfhF4HSIL/X
   gaCUyjpRkYoOI8OcV12Yn5Bvi/XUtjlJ6vrl+BgfVicmXphYI19CGnLcw
   tZlCz7c+cK6DU/vI620UBuuNnJKTSG7jliS/5l3wqhmZM1IHBwgiYKlqN
   wRHzbE6q/P87X8NZ4L79BCYmSfST+tGDR7j8VeXTJj4wmsTTk29Ob6kI6
   g==;
X-CSE-ConnectionGUID: R91AS1UkTousHETMnnL1Gg==
X-CSE-MsgGUID: hnQa1O3vQoKImP7U7u0dxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="81975047"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="81975047"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:11:35 -0700
X-CSE-ConnectionGUID: 7e5sP7wISn6wthXldq4j8Q==
X-CSE-MsgGUID: P7NBgoiESFeBKK0b9V/v5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="248730861"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:11:30 -0700
Date: Tue, 23 Jun 2026 23:11:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] sys_info: add helper for callers that handle
 all_bt
Message-ID: <ajrob9r6cVtxqv72@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 03:34:58PM +0000, Bradley Morgan wrote:
> Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> Add a helper that strips that bit without turning an all_bt only mask into
> a kernel_sys_info fallback.

You also want a getter with check

bool sysinfo_is_all_bt_enabled(...,  *si_mask)

where *si_mask is the result of READ_ONCE() that you keep as implementation
detail inside this helper.

-- 
With Best Regards,
Andy Shevchenko


