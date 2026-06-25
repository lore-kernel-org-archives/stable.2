Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD351C84DC;
	Thu, 25 Jun 2026 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368729; cv=none; b=Nzbaip6RgDvrtq9O9TYC96BJpqQs4nwtxNGzb06BL9QQiuor96Unk6tlibyUsYRMgMYfnkghMhNGe/KUG5cRMEw4SmDPB11daQ1eeypB/oynF6REAzDdMGbet4xI0KmYGnhp26ASXo2bjps6AP72dCDM84YZsdqMXXi1jBcZLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368729; c=relaxed/simple;
	bh=qN6rxeLPrWEPmxFGStMS4jQk+7YyeMkk+HD//Wyqj8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnZ3f+DhzE/EfVfAPd/xtHXCo40BmNrcx9hf8Oe/lXcN2fV2NqdLA3AqhQ9JnKQqTpBNp3RNzh6oKzbjS29piYLaIHwlZBXuLm0quP7LG8ZrzK0JL7nVYhwVoXkoxqMRhs4h0GwnOQo+CtUrvWaKDz6UmJ6fP63aV+WZc6b7bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khlGueke; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khlGueke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782368727; x=1813904727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qN6rxeLPrWEPmxFGStMS4jQk+7YyeMkk+HD//Wyqj8g=;
  b=khlGuekehxIYGRsaXyCDnpMbCaFnB4iiP3JmMAjfTeM070vUTXPopv/w
   Q/In1v1NA84v+G1II+xtnJFUvXGhueGUURkJlq6bNTIvWHh8tWHmxtz32
   WMxmm9UWUe74LSrEMRmn59TFUyPQcKKGWf9BkPs2wBoqcMDK1VNC+Gdv1
   Xikk7uozr19FSoC/A5xSouFJX5h1B9QHfiWND+2VoDMoOWk2DHbwc7Jr8
   7HP9RIHVDUIrTFfDzNTbGaqrs7gB7UnfT38MwBs0QQbmSsJc7mlutjEqp
   qMzBnJisDzQcb8s9LNZh+MNJYB1neFHwGYJLu+GZa+s4Fxu5ry8hczHDK
   w==;
X-CSE-ConnectionGUID: vTfxrjgKSvqalvJ9Bd+q/g==
X-CSE-MsgGUID: y4Bph3PHRt6c7Jm2oAU//w==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100566504"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="100566504"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:25:26 -0700
X-CSE-ConnectionGUID: mgpo7onQQoGmj/svgy/OYA==
X-CSE-MsgGUID: 38zIrkM8TsC/DcZrYr1OfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="255127244"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:25:21 -0700
Date: Thu, 25 Jun 2026 09:25:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
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
Message-ID: <ajzJz_YgpTRLiJxX@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
 <EB858B12-203D-4173-A44B-4926129983F4@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB858B12-203D-4173-A44B-4926129983F4@grrlz.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 09:44:37PM +0100, Bradley Morgan wrote:
> On June 24, 2026 9:34:19 PM GMT+01:00, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
> >wrote:

...

> > It would be nice to have the conventional [0/N] cover letter to tell
> > readers what this is all about.
> 
> I added a what I changed? I'm iffy on cover letters, if you want I'll do
> it...

FWIW, always do cover-letter when you have 2+ patches in the series.
And do not add it (there are rare exceptions, though) when it's a single patch.

-- 
With Best Regards,
Andy Shevchenko


