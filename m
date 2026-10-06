Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE028E0F;
	Tue,  6 Oct 2026 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306297; cv=none; b=ryNDO0gujM8WZS6Sa+OWSJ+jwHnwgj+SBYx/9nRwL0PiGMjZUNe+poN1wSMomBxDMP7Ho666nQtZR3Bf+To/3wh3yoMzLy1Dfw1ASQoRiL+H1NTkmj9xThC3axYQS1DdB4KLobSL1JLWA/ClitA3ZAwEoW0Jg+73/icIKGJSpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306297; c=relaxed/simple;
	bh=oNasH9LIHj1JSuBGvoFHsanx1eHLO7A5KIuVy5ezA7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tdIti4SWL2OML5zlzRWkBkhe3bq5FLcx9xVV6jbuiAzar5ZCvZ6WiOn89rffEz/+cMh/7EAXVpMo1Cjt/IIMBLeBONObSJpOMVWE60xbdBg/y0e4xNJoG6b7bef++PcH7h/Cy1q90ZreqN+akRPlBrsGkkQ48aY3nqCC4V3KSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aro3d/Ku; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aro3d/Ku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791306294; x=1822842294;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oNasH9LIHj1JSuBGvoFHsanx1eHLO7A5KIuVy5ezA7Y=;
  b=Aro3d/KunO6XJqLKbmSIqZOFDzVxi3t3Z90C7wzV7NANJsNnldmClKvA
   m0L7hh5+HwR6iyLikazVINV5HvBvCo05HrEwOfi52ZJmXHhXMVAi/9R42
   olrNLNOomn3y4FDFTAuEuFsbeONsCp4bY8mn3q9QSEOSbIuxZ1b0PfWk7
   91c/dcOlrGRnEaNp0Kph/i3JdP68tOTprXxeO64c3AylW68MVVhxaFw9x
   P/FNGOJ5ADfiNtieiNW5vwHnJzrWwwZUHYIrtZycqHzOoZf0ZusuHqvz8
   4TrivfJnTkDxiBwCwkLYPfeL5b6iQDKpBdO2Zt4nX5qYcBQfvHtVqM/LJ
   w==;
X-CSE-ConnectionGUID: xyXNYwSbSw6Q+G6lEbemQw==
X-CSE-MsgGUID: uOWj1zsETZWq++iXna3bnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="113792505"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="113792505"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:04:53 -0700
X-CSE-ConnectionGUID: VFCrjuO2TrCLXbVqlqKEVA==
X-CSE-MsgGUID: CY27euWQQ96YX58MfHprLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="280484058"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:04:53 -0700
Message-ID: <0f6b866947600528f84771227ef2b6c3f4adfbd7.camel@linux.intel.com>
Subject: Re: [PATCH v2] sched/cache: Honor asym packing over cache aware
 scheduling on hybrid systems
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: KPrateek.Nayak@amd.com, Vishal.Badole@amd.com, juri.lelli@redhat.com, 
	klaus.kusche@computerix.info, linux-kernel@vger.kernel.org, 
	mario.limonciello@amd.com, mingo@redhat.com, peterz@infradead.org, 
	platform-driver-x86@vger.kernel.org, ricardo.neri@intel.com, 
	stable@vger.kernel.org, vincent.guittot@linaro.org, x86@kernel.org, 
	yu.c.chen@intel.com
Date: Tue, 06 Oct 2026 10:04:53 -0700
In-Reply-To: <20261006135959.5709-1-kayracizmeci@gmail.com>
References: 
	<77ceef1e51b895760dc5f6c9cde985a1679545b5.1791224900.git.tim.c.chen@linux.intel.com>
	 <20261006135959.5709-1-kayracizmeci@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-10-06 at 16:59 +0300, Kayra Cizmeci wrote:
> Hi Tim,
>=20
> > +	/*
> > +	 * On asym packing domains, if the destination CPU
> > +	 * has higher priority than all CPUs in the source group,
> > +	 * prioritize asym packing.
> > +	 */
> > +	if ((env->sd->flags & SD_ASYM_PACKING) &&
> > +	    sgs->group_asym_packing)
> > +		return false;
> > +
>=20
> I think that check is redundant. group_asym_packing is set by sched_group=
_asym() and bunch of other stuff,
> but sched_group_asym() calls sched_asym() and sched_asym() calls sched_us=
e_asym_prio() that has SD_ASYM_PACKING check
> inside of it.


Thanks.  Yes, we can remove the SD_ASYM_PACKING check as the check was done=
 when group_asym_packing was set.

Tim

>=20
> Ah.. Hope I'm not missing something...
>=20
> Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
>=20
> Now, I'm going to grab a cup of tea. And sleep.
>=20
>=20
