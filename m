Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A391E7C2E;
	Tue, 29 Sep 2026 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712494; cv=none; b=dgg5zWyxDxwbRs6A4qYm/zSWd7gnzsu6zfOq2ACbch0iLaOj4HjCdlJVad5UJs22W3ZD68cT2mUN1chJx0/DFufvHmLbc9TpXpDCYYfnh3TacoNHkU9CgPImspMqujazp99QsZN5MbpxoiGqJ4a/m3/ccQcSLBPLq6PH4OOGgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712494; c=relaxed/simple;
	bh=gwh/pPh375u9p5DNQBbUCo0K4wZPDp6sLcgyGcFrx30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JSL3WKzGplxmgbsTCop83Vxo9iXcWpBKTFYpU2YVGXxPRRGaYJLXcdoZZ7n3SXIH+1qsBvwvCYef/qsYsh2y1F/CSsaj08/HjrwHguXg7SryYbZpraG1DxmB0xTvGeL3RkKm3+yhQzS6355pbX6ypdmUgl88lrdjL2iqnVTwpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHI7Ewz9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHI7Ewz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790712492; x=1822248492;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gwh/pPh375u9p5DNQBbUCo0K4wZPDp6sLcgyGcFrx30=;
  b=oHI7Ewz9y0EByEtF1ih74McH9vODs7YBx7OBYXTknU5URs5bQu+wTRT0
   VapCVB9s6nesS/pYJfFb6aRyuzYZZ0z/45CSYhDs/PexfUlSblzjkPIIv
   DlQvjzysw3a3TuZLDdkAb4Oezf06slu0TLOfqY0+nYwwsdb8corv+SOd2
   eRfWN7MfQub9m2OdtPPqEkD7smPNWMM+jp7fbaJCzZfAtb364FH9jk6ra
   bbqVsQ52oeQupoQnioIcmrH99XUVFx7UkPuRnc5CJOjx7w0ENttoAYdcc
   1GA8jC4uwTJlnDBYarO3Gb4x6s6IcaIevFSKyBo+V+F7Fl0HPLCUmeAV4
   A==;
X-CSE-ConnectionGUID: N7SeLkngRleMHXagUiFjGQ==
X-CSE-MsgGUID: wRclPje5Td+qwTPm7Zg5IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90661223"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90661223"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 13:08:12 -0700
X-CSE-ConnectionGUID: JwyhR5AJQZKjdzIASOvAJw==
X-CSE-MsgGUID: CHKO1bdKQAy0LRqczSX0wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274675769"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.111.124]) ([10.125.111.124])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 13:08:10 -0700
Message-ID: <7790ab6c5da3aeac42f6878f0a167c6cddebb354.camel@linux.intel.com>
Subject: Re: [PATCH] sched/cache: Honor asym packing over cache aware
 scheduling on hybrid system
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: KPrateek.Nayak@amd.com, Vishal.Badole@amd.com, justinstitt@google.com, 
	klaus.kusche@computerix.info, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, 	mario.limonciello@amd.com, mingo@redhat.com,
 morbo@google.com, nathan@kernel.org, 	ndesaulniers@google.com,
 peterz@infradead.org, 	platform-driver-x86@vger.kernel.org,
 ricardo.neri@intel.com, 	stable@vger.kernel.org, x86@kernel.org,
 yu.c.chen@intel.com
Date: Tue, 29 Sep 2026 13:08:09 -0700
In-Reply-To: <20260929182137.196669-1-kayracizmeci@gmail.com>
References: <d7cd3f7d528dff79d2a702543e7d97a44c0c078b.camel@linux.intel.com>
	 <20260929182137.196669-1-kayracizmeci@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-29 at 21:21 +0300, Kayra Cizmeci wrote:
> Hi Tim :>,
>=20
> > > Let's say when entering can_migrate_llc_task(), dst_cpu is CPU0, whil=
e src_cpu is CPU1.
> > > And CPU0 has a bigger asym_prio than CPU1. No SMT. When entering can_=
migrate_llc_task() and sched_asym()
> > > from there sched_use_asym_prio() returns true without checking if the=
 core is fully idle or not.
>=20
> > sched_asym() does check whether the destination core is idle in sched_u=
se_asym_prio() for non SMT domain.
> >=20
> >                   (false for non-SMT sd)           (check idle core)
> >        return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
> >=20
> > That is also a pre-condition for setting group_asym_packing.
>=20
> Sorry for not showing the code earlier, here it is:=20
>=20
> static inline bool is_core_idle(int cpu)
> {
> 	int sibling;
>=20
> 	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
> 		if (cpu =3D=3D sibling)
> 			continue;
>=20
> 		if (!idle_cpu(sibling))
> 			return false;
> 	}
>=20
> 	return true;
> }
> static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
> {
> 	if (!(sd->flags & SD_ASYM_PACKING))
> 		return false;
>=20
> 	if (!sched_smt_active())
> 		return true;
>=20
> 	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
> }
>=20
> On sched_use_asym_prio(), before the idle check a CPU without SMT returns=
 true.
> But I'm actually wrong on that one because on that one we're laying
> on the idle protection outside to the CPU. If there are not any
> other brothers, and I'm idle then my brother-family
> is idle... Ah I messed up describing this.
>=20
> But is there are any idle protection outside? I couldn't
> find any. I could be missing something tho.

Actually idle cpu is being checked as a pre-condition for setting
asym_packing.

               /* Check if dst CPU is idle and preferred to this group */
                if (env->idle && sgs->sum_h_nr_running &&
                    sched_group_asym(env, sgs, group))
                        sgs->group_asym_packing =3D 1;

Are you saying that we should update the first chunk to add an env->idle ch=
eck
to match the asym_packing migration pre-requisite? Like below?

@@ -10847,6 +10849,10 @@ static enum llc_mig can_migrate_llc_task(struct lb=
_env *env,
 	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
 		return mig_unrestricted;
=20
+	/* Prioritize asym packing over cache awareness */
+	if (env->idle && sched_asym(env->sd, dst_cpu, src_cpu))
+		return mig_unrestricted;
+ =20

I think this is a valid point.

Tim

>=20
> > > And sched_asym_prefer() comes back true too, so sched_asym() returns =
true and, we just returned mig_unrestricted.
> > >=20
> > > I could be missing something, If I'm not tho is that on purpose? If i=
t is, the last paragraph needs to change
> > > since it says that "asym packing tries to migrate task to an empty co=
re" and after that "higher performing idle core"
>=20
> > I think I did try to point out the idle core aspect in my commit log:
>=20
> > "When asym packing tries to migrate task to an empty
> > core that has higher priority than source cpu, let asym packing win.
> > Moving tasks to a higher performing idle core will buy more
> > performance than cache co-location."
>=20
> I know. I was trying to say that if we're not choosing an idle
> core this needs to change.
>=20
> Thanks,
> Kayra
>=20
