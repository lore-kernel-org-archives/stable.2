Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168803;
	b=0VNAWI4MEd0ffdSdLb41+aDFnGs0vLik/2AJEDO6aq4e7NcwkMbLw/IIe6XjsEP8Pp89
	 0S915kARkgzBpM/tPk1R9dGalmkWLEijimG1+q/Q7hqKXW2wPdICMiS4VIZaismatBbLq
	 s05gGJE6ICEaHKOt1GlxtjbqbF+SIW5dCLH4AdClJfyCknyrBcGm+NqnLFRSIZrQqdL6J
	 jzP1+Smo3vDHYqFDRzPxQpA1Z7mT+fRLc60vRoD9lbSjeFV6kw/OA3kebe+Y7ZPkhT98z
	 T7hCbwLUtC3cMY6GMT7DSlbwQs3GXHV0Je+ZYI8a95NEnosSyAcq/RnDPBZOTQfnHog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168803;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=53IYgGn1hvZqbl/iv8n9HjV2+EPLGnQoxoloaQwl0lY=;
	b=nbEB/Iyvk1qbm3JdSWzVDQLdML2oYSOSjhr/XjFJvzk2F9pZImEGe13DbcrZnk4MlTpw
	 oxALKW86+3AyKfk0obKeBwYa56Cf05eg5gnDwNJpUvU2W1Zv//VkSRs50DmGxrV4VAJoJ
	 JoiIIRTdHb0x8CvraNp8jjup7ZWxwf4O7H8l05QFq7C2HjHjoCspJ8ZvpjeXeyyGMNNvV
	 rP3G0il2thlkzcK7vZ529xHvwjszhH+KHWe0SJpX09EHDDc2BvhVBfoB6q8saAYV3UYP7
	 Wlv+NjdYa///FXyqByc3dGcUchd23IlmDdvrvuLrD4gPNsz4Sujy9e58JWWexQimZqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RCc19Wqs;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2396606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2396606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RCc19Wqs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168804; x=1826704804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dgi6myinJZLo7hQda6QBDHER9GVUwzKuhB2DR3WDrdA=;
  b=RCc19WqsW236AMmdMNwAq7jx2lf1vW3nj6E5vOtnh5sRnmFuaBoGyXXj
   uoQODKhnioCHdN08iMOwKudklDFq0w2TigTuagDDKOXez2qQfU9kk+2gQ
   ggwJnQs7DG1Ds4wawHa0OmtfD6qRdLi0sRc5GZUChhJB6odVKsE+2vX7a
   vTuCAi+iJHgXtjeXy5653rDRPcahSfabs2jSI/26JlPYpbfvZE28msyo7
   d1MSc9z70l9S0QvghbQyPJeI6PVY3j3yk6fLUr77x/eYXVNC8oMZNSlxP
   bxlO8KT2vV+t6UuEVtEYc9PJ1ViWpAVPfwHAtQCD8GrBvszxBh2CXbrx6
   Q==;
X-CSE-ConnectionGUID: pVhdvnIRTo+f+6D7tC8w6g==
X-CSE-MsgGUID: GIckFnsaS327DBuhFsp/eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4085715"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4085715"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 02:00:03 -0800
X-CSE-ConnectionGUID: lo2pq+bMTrKi52+noe0mEQ==
X-CSE-MsgGUID: 3LqStTW3S42IF8/5fOYvUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10803200"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.253])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 02:00:00 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 98A7011F8AD;
	Fri, 20 Nov 2026 11:59:59 +0200 (EET)
Date: Fri, 20 Nov 2026 11:59:59 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 6.12 0810/1756] power: supply: bq24190: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <awAaH1vUBq1Bhb9X@kekkonen.localdomain>
References: <20261118150007.957976754@linuxfoundation.org>
 <20261118150041.869799943@linuxfoundation.org>
 <4d03745f-1cd4-4280-965e-c6527f3f3c07@oracle.com>
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
In-Reply-To: <4d03745f-1cd4-4280-965e-c6527f3f3c07@oracle.com>

Hi all,

On Fri, Nov 20, 2026 at 02:51:48PM +0530, Harshit Mogalapalli wrote:
> Hi Greg/Sasha,
> 
> 
> On 18/11/26 8:18 pm, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Sakari Ailus <sakari.ailus@linux.intel.com>
> > 
> > [ Upstream commit 2453753f395e68af947d9ac6ce37bf0eb40f7123 ]
> > 
> > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> > pm_runtime_mark_last_busy().
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Link: https://lore.kernel.org/r/20250704075442.3221283-1-sakari.ailus@linux.intel.com
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Stable-dep-of: e0844bd22a9f ("power: supply: bq24190_charger: don't reset registers across system suspend")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   drivers/power/supply/bq24190_charger.c | 14 --------------
> >   1 file changed, 14 deletions(-)
> > 
> 
> 
> Ai assisted backport review has found an issue for this backport. The
> finding looks correct to me.
> 
> Verdict: lets drop it until we have the prerequisite I think.

I agree. The pm_runtime_mark_last_busy() changes were merged for v6.17 so
these patches musn't be backported before that (and I wouldn't backport the
pre-requisites).

-- 
Regards,

Sakari Ailus
