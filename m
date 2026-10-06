Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B78649EC4C;
	Tue,  6 Oct 2026 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307662; cv=none; b=GgqLEG6DvtvaElcFm+zazkMfyhm7EsDyu5uBM9oR+E9Mx6bCm65QBsEJqOLO5g+6BqwODEepg5++eMiJyQE3kJee08hVgBQleQlZiPSGF+FxBJk0P8wwDHXK/EonkC8ZMIIV21S5ul3Gq1YTfP3Dc0VXvnoOehfSyLkP9A3B+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307662; c=relaxed/simple;
	bh=WMv17R0J3Z7eGBZvPlXRb5kFiiqo5/opfKPcfVDpp5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W4hen93lm4VF8D0r5dnaLc4tVGe5P4glI5aFUeQT+ZS530kTUd27/M1Tm+HiZ08Lte55ceYUclQj9CFTZM9I+OGLAipJf4UGN23xRlNd2WQ4k+itoM+qyJBDbD0f5mjS2mxE7GWKdivC5noZV/fRkaPEHpwwexOeGhAtQyXM8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GB9w4kji; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GB9w4kji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791307660; x=1822843660;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WMv17R0J3Z7eGBZvPlXRb5kFiiqo5/opfKPcfVDpp5U=;
  b=GB9w4kjiBChpsRpS1CmyLIUidWUB0N3X8plSLFNZyLYV4uvPfMhrH5na
   PNUzkckNpv0umBjXkumRnkLA/qIAYgXtu3Kp4nqXnSxhyfzXGMSWOHZ3c
   Rhr2HGIQcpfP/N9iyM374yFttN/vAvpcSn7QuoAY89FPXIXg4wmcLMa3T
   GdARajSIdItXmqGPj9Civ8mGuSNXf0+ewMY4PqaLABTPECeAsqeOQrXkM
   yYMlAkeMGiOE4X/M/mY6y02HW2n20Yyz4cudgQZK7hUgHKOMZpxF8+sI9
   Jm0N0yQDWWfV59eMtVlP1m1emCPSNDa2lx4s1wdPYv+SdJ4L0b29GO3T2
   A==;
X-CSE-ConnectionGUID: Sc/0DsH+RyamDDArlOxJ9w==
X-CSE-MsgGUID: WclIGKAISPW66RJJUroecw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="117528744"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="117528744"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:27:39 -0700
X-CSE-ConnectionGUID: DbVhI4KES7+S03g7s8TJsg==
X-CSE-MsgGUID: xeOWG9zXRlq850fSlfl2Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="277333458"
Received: from unknown (HELO [10.241.243.185]) ([10.241.243.185])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:27:40 -0700
Message-ID: <7b407bbb5c0e10dae7925936e8fcf0aaa6b0c9dc.camel@linux.intel.com>
Subject: Re: [PATCH v2] sched/cache: Honor asym packing over cache aware
 scheduling on hybrid systems
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chen Yu <chen.yu@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Chen Yu <yu.c.chen@intel.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Vishal Badole	 <Vishal.Badole@amd.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, 
	platform-driver-x86@vger.kernel.org, K Prateek Nayak
 <KPrateek.Nayak@amd.com>,  Ricardo Neri <ricardo.neri@intel.com>, Kayra
 Cizmeci <kayracizmeci@gmail.com>, stable@vger.kernel.org,  Vincent Guittot
 <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Klaus
 Kusche	 <klaus.kusche@computerix.info>
Date: Tue, 06 Oct 2026 10:27:38 -0700
In-Reply-To: <asUT-eR9yteRmB_v@three-body>
References: 
	<77ceef1e51b895760dc5f6c9cde985a1679545b5.1791224900.git.tim.c.chen@linux.intel.com>
	 <asUT-eR9yteRmB_v@three-body>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-10-06 at 23:30 +0800, Chen Yu wrote:
> On Mon, Oct 05, 2026 at 11:29:53AM -0700, Tim Chen wrote:
> > Date: Mon,  5 Oct 2026 11:29:53 -0700
> > From: Tim Chen <tim.c.chen@linux.intel.com>
> > To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.co=
m>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com=
>,
> >  Mario Limonciello <mario.limonciello@amd.com>, Vishal Badole
> >  <Vishal.Badole@amd.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
> >  platform-driver-x86@vger.kernel.org, K Prateek Nayak
> >  <KPrateek.Nayak@amd.com>, Ricardo Neri <ricardo.neri@intel.com>, Kayra
> >  Cizmeci <kayracizmeci@gmail.com>, stable@vger.kernel.org, Vincent Guit=
tot
> >  <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Klau=
s
> >  Kusche <klaus.kusche@computerix.info>
> > Subject: [PATCH v2] sched/cache: Honor asym packing over cache aware
> >  scheduling on hybrid systems
> > X-Mailer: git-send-email 2.32.0
> >=20
> > A regression was reported on an AMD Ryzen AI HX 370 running a cache
> > intensive Clang full-LTO link. The little cores run at a much lower
> > frequency (3.3 GHz vs 5.1 GHz) and have only half of the L3 cache
> > (8 MB vs 16 MB), so pinning such a task to the little-core LLC
> > hurts twice, and full-LTO builds slow down dramatically compared to
> > pre-cache-aware-scheduling kernels.
> >=20
> > Asym packing and cache aware scheduling express conflicting placement
> > strategies. Asym packing wants a task to run on the highest priority CP=
U,
> > whereas cache aware scheduling wants to co-locate the tasks of a proces=
s
> > on one LLC regardless of the priority of CPUs in that LLC.
> >=20
> > When asym packing tries to migrate task to an idle core that has higher
> > priority than source cpu, let asym packing win.  Moving tasks to a high=
er
> > performing idle core will buy more performance than cache co-location.
> >=20
> > Prioritize asym packing over LLC balancing for regular and active load
> > balancing.
> >=20
> > Fixes: 23b2b5ccc45c ("sched/cache: Introduce helper functions to enforc=
e LLC migration policy")
> > Reported-by: Klaus Kusche <klaus.kusche@computerix.info>
> > Closes: https://lore.kernel.org/lkml/2180ea5a-eb28-4152-8d4d-cd00b0c24b=
2e@computerix.info/
> > Suggested-by: Kayra Cizmeci <kayracizmeci@gmail.com>
> > Tested-by: Klaus Kusche <klaus.kusche@computerix.info>
> > Tested-by: Ricardo Neri <ricardo.neri@intel.com>
> > Cc: stable@vger.kernel.org # 7.2.x
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >=20
>=20
> I leveraged AI to test it on top of 7.3.0-rc2 using an emulated hybrid se=
tup on a symmetric
> AMD Ryzen 9 8945HX (Zen 4, 16C/32T, two 32 MB L3):
>=20
> By hacking the AMD pstate driver and QOS to limit the L3 cache ways:
>=20
> =C2=A0 - LLC0 "big/fast": =C2=A0 CPUs 0-7,16-23, max freq 5.46 GHz, 16 L3=
 ways (32 MB),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ITMT prefcore ranking 236
> =C2=A0 - LLC1 "little/slow": CPUs 8-15,24-31, max freq 3.29 GHz, 8 L3 way=
s (16 MB),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ITMT prefcore ranking 100
>=20
> Workload: an 8-thread pointer-chase ring (24 MB working set).
>=20
> This patch works as expected:
> Before the patch:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cache-aware=
 ON =C2=A0 =C2=A0 =C2=A0 cache-aware OFF
> =C2=A0 throughput =C2=A0 =C2=A0 ~230 M/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ~530 M/s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (-56.6%)
> =C2=A0 placement =C2=A0 =C2=A0 =C2=A06 of 8 threads =C2=A0 =C2=A0 =C2=A0 =
8 threads LLC0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stuck on LL=
C1
>=20
>=20
> After the patch:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cache-aware=
 ON =C2=A0 =C2=A0 =C2=A0 cache-aware OFF
> =C2=A0 throughput =C2=A0 =C2=A0 520.7 +- 18.3 M/s =C2=A0 =C2=A0512.9 +- 1=
6.6 M/s =C2=A0 (+1.5%, noise)
> =C2=A0 placement =C2=A0 =C2=A0 =C2=A08 threads LLC0 =C2=A0 =C2=A0 =C2=A0 =
8 threads LLC0
>=20
>=20
> Tested-by: Chen Yu <yu.c.chen@intel.com>

Thanks for validating the patch.

Tim

>=20
> thanks,
> Chenyu=20
