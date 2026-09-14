Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19B416CFA;
	Mon, 14 Sep 2026 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380666; cv=none; b=KWut5Ahv8gH6jJ7zcJhISHHEQwNL9+WvZLp79LVwEPd4KTdJJIEaCUSRA4yoVsuruE5M/JPWW58WExFB01vXi0RURHvbRWvbY1KJUSnhpxBmNq0ImL9qKlQGrHasw9FIppdUUQDsw/Zq1H6aVLE7/57tXCEx7OiWcJ8EeAn7seY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380666; c=relaxed/simple;
	bh=ruDkx/hjtKZjQ2DBi6vqqtydh4RZuM+Qk/9Yu97JUd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0sTzuGFS+tW3eBj1ay3JAY/xqZTs5m7my0NaxqL4DhTn5Yh5pxkl+tg6bY3krgxRnYgTAhmBQ/JFdiUiZH0Frns/Aw1uByw1P0IcZkEUowjG6XnjdWW1N7GZprmLmLvwvV2vrcZ8cHnnGFb4/uNd5yk4rcHfYprbENkJj//W9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hn20TDJl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hn20TDJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789380663; x=1820916663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruDkx/hjtKZjQ2DBi6vqqtydh4RZuM+Qk/9Yu97JUd8=;
  b=hn20TDJlbboYSCJBos/O49suLIo362/lMQ0GwY7RMdxYaTveII322MWZ
   UgeaM1kvLfI9afNpjFOBnlyLjRSISgKEY0mVK6q0youbeVw87w5M5uFD1
   CcNl08p5hBVww151Si3+biRrgPqFkAPyXSFwb6LvYXBg2IaT8m/ZH/Lc0
   FMxaEM4LA6YyA14Y7/xpDtAeUuNvJD44ywj4Y+EJgMBpbioq+0edL5Hee
   tGz7pChUYQeZjupFwEXM6JGzrw7RGcfTttSrE0pLTg+E5NOwUfTCtf2oB
   deN2DDH+MYy3ID0N8LTXWhQh81F1PundNvvDeNyHIQuOkGV5jM01taxYN
   A==;
X-CSE-ConnectionGUID: rIJyG5NbQy+r5gsjsfQQjA==
X-CSE-MsgGUID: dIiCVw0PQuqgYXnQ5E2kag==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89606740"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="89606740"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 03:11:03 -0700
X-CSE-ConnectionGUID: ozoXV1/LTLyDzmimxTky8g==
X-CSE-MsgGUID: X727o1zGQGGzOjL1hu7UQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="268307949"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.61])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 03:11:00 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 350FF121BB5;
	Mon, 14 Sep 2026 13:11:07 +0300 (EEST)
Date: Mon, 14 Sep 2026 13:11:07 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sergey Zagursky <gvozdoder@gmail.com>,
	Miguel Vadillo <miguel.vadillo@intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] media: ipu-bridge: do not use the CVS device lookup
 for IVSC
Message-ID: <aqfIO-5KSUdsqxYE@kekkonen.localdomain>
References: <20260902211524.5572-1-gvozdoder@gmail.com>
 <bf269f69-2b22-4b31-8ef0-48fbd8d19865@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf269f69-2b22-4b31-8ef0-48fbd8d19865@leemhuis.info>

Hi Thorsten,

On Mon, Sep 14, 2026 at 06:32:41AM +0200, Thorsten Leemhuis wrote:
> On 9/2/26 23:15, Sergey Zagursky wrote:
> > Since commit c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU
> > bridge driver") the internal camera no longer works on laptops where the
> > sensor sits behind an IVSC, for example a Dell XPS 16 9640 (IPU6,
> > INTC10CF, ov02c10):
> > 
> >   intel-ipu6 0000:00:05.0: Found supported sensor OVTI02C1:00
> >   intel-ipu6 0000:00:05.0: Connected 1 cameras
> >   ivsc_csi intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: mei-csi probed
> >       without device fwnode!
> > 
> > No sensor subdevice is registered, the media graph has no sensor entity
> > and userspace finds no camera at all.
> 
> For the record: Linus pulled this directly from the list into mainline
> yesterday after I pointed to this patch in a small regression report, as
> I had seen multiple people reporting a regression who confirmed that
> this patch fixed things for them.
> 
> Bypassing subsystems like this has obvious downsides and risks; hence,
> if that got something on the wrong track, please speak up -- or ideally
> send patches to set things straight again in mainline.
> 
> https://git.kernel.org/torvalds/c/856c562c94964a74f63c6d5f38a1509a59a2357d
> /
> 856c562c94964a ("media: ipu-bridge: do not use the CVS device lookup for
> IVSC") [v7.3-rc3]

The patch seems fine to me; it was merged to media tree 3rd of this month.

-- 
Regards,

Sakari Ailus
