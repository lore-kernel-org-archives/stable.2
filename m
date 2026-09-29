Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F73FF89F
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706104; cv=none; b=VWcggmtGW8/EQcpkq4TJz1e0SNPG70qEdPvkQtv1rOmQP5I8ikQmVIJY582/DxVCgg6BhDZloZyEoD8H39mf0rtwpwCo7RbEjm5siZEdWqDmhQ1cRQP6H9u8oX5f9mgX5IjUGUrTgTxGF236r9GaW8YT8Xdv4jzVu0wJUCnZ7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706104; c=relaxed/simple;
	bh=CP4jlLryAjoI33ocElOZhqE2VCS2aVzTcIdup6lEKC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e74gQgzJkNoRdjNvFJZ3hnNfLVxuZ4Rn+rIYtShgrPgEWD/ybY7MtNAJTCPnfvqEK60HXF6h9DVgJvIbTwUiZPB0T5qeqoaudOJDOY5IroHhAqjitdoiZ4T+i/CLch7W9MvdYxJPPzuErZmU0JF7CNdKODE8ZSOdDmbE9UtLUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNBdoDCf; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNBdoDCf"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48435bcf9d9so516639f8f.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790706101; x=1791310901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=asWxT5bycUxVtD+OugmEsRzTNrfaIi0ZXtMhr+mg13Q=;
        b=eNBdoDCfMP1KCQaZFMeYBItfSdhIv51yu3/NOn0zg3oNx+Vj8hfvQL0mGHc2KFPzEt
         32vAo5+e7JjnjdJSD8pKo5UDNr3ZvJXrRgwYrSKXq2WdPACeueVHHuUSFYrAA1X2Jv3a
         zvgxy2sKxCcj9cBLWd0hAp2CNzVrzaebXqtdOxtRhDhMOLcxfiwStm7GXr8p1wZE/rM/
         Y1LKWiPC8StbYhlVoaBLHdNWXs1NFzsyF2xCgXuHzjZN2g00FwxR3nWp6wvztioi+LAf
         zB7EaroeOQJI3i5Ao4+84OYXi3wn3Id29sWJumFLtlm0XftTo1zrBKd5p2fUhf9eizZM
         2PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790706101; x=1791310901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=asWxT5bycUxVtD+OugmEsRzTNrfaIi0ZXtMhr+mg13Q=;
        b=F24h/RFedjEsb+jiRTSgneooi9NOC3I5NH1UcTOdR8niTyqtpFV6tqiVRt4KeTVyjo
         YAvzY7VGLf13+LmJhTtQ4DarZLklpY8kmSEr35w4ESVpnE8TwMDM2KgoBVZ1iP2lwu6w
         xngboPvRsOA88gbAUJpertgmr7OSw1eEqwsODJaNhe122zlehF23w//2Dq+h5rc8Rnrc
         nsgXLh174PznPfKB1RCry2lMXqQ1xJK+c30jyl7DjWuoFd5QnIwHuKcpOOEHBznC9TkT
         f8Fu2sJoB5EkjRixlMCqehR0YB9eebnVZpv768b+uDw00NGmhjGR43JFoa7CFdY4eloV
         LghQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXfwnep+UYyEVvIsNqAKyMONJzhLDf7dLvW0EtDcMHMFjnn6u0uM2hSMftnTP+dUPZqy1Am4Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n18zr5qCyNMXLPlzXDx2cR7dAIKj6MOmcFL4QWVuYD03sIMcj0
	tzJ2u/8krupgh2wgwHNd742cgiLiT2vqVCz+3p3V6BYYaFhNrq8je6cG
X-Gm-Gg: AYBFou3qRE1G9mxG5cC6aas4m5SyvPo82q9bSLTh0/Bhfq/LTd4/1bC59vFbxC6djMs
	g6LAXFjgWRV0JvMfmVuIBSm+siUh1qccXTVDcGIiB5bIHKOOiGCVA94QlO8/nfOXAcPYzB5thxv
	zIGU2dcjnMrgLoAyA8bkWqzqzyQ9mdLgUcsqIdgSUe7Pw15c4LgPUgNdEMTNifTFR8stmJlKqCS
	ZA11jzIemkSSk7RrtQa0K7cQ1WICmfxw/e2LiBl1wy8wVzPDzO/e6PF+7mapYrOoD0qaQTxGhWE
	9dHCbEdeuR/bmT6V7CxIreKY8npZE6xxLusGvfsDw2GlI9/vS0CvV665hnTxyFH+BHFGxzDWbnW
	kWR2J6rSoQ2v3Sdaq+9SSf2L8ckVEFRoG4JqdJ1X9zt9G6fW6o/cjkBFcovvmDhQo2cAvVmNnUp
	gTs2fRTWBpasWidEqzVqp9EXpuzOGpmYECU+eVGFeANpc9H25cPAPqt4dEZeRXbMFqcWl+cbv0J
	NCKJcHOgpJWZ8h3SrUwdh32MKn/+RE=
X-Received: by 2002:a05:600c:6986:b0:4a0:87d:81e4 with SMTP id 5b1f17b1804b1-4a0087d8302mr80719615e9.1.1790706100902;
        Tue, 29 Sep 2026 11:21:40 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a014f6c05bsm283385e9.4.2026.09.29.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:21:40 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: tim.c.chen@linux.intel.com
Cc: KPrateek.Nayak@amd.com,
	Vishal.Badole@amd.com,
	justinstitt@google.com,
	kayracizmeci@gmail.com,
	klaus.kusche@computerix.info,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	mario.limonciello@amd.com,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	platform-driver-x86@vger.kernel.org,
	ricardo.neri@intel.com,
	stable@vger.kernel.org,
	x86@kernel.org,
	yu.c.chen@intel.com
Subject: Re: [PATCH] sched/cache: Honor asym packing over cache aware scheduling on hybrid system
Date: Tue, 29 Sep 2026 21:21:37 +0300
Message-ID: <20260929182137.196669-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d7cd3f7d528dff79d2a702543e7d97a44c0c078b.camel@linux.intel.com>
References: <d7cd3f7d528dff79d2a702543e7d97a44c0c078b.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tim :>,

> > Let's say when entering can_migrate_llc_task(), dst_cpu is CPU0, while src_cpu is CPU1.
> > And CPU0 has a bigger asym_prio than CPU1. No SMT. When entering can_migrate_llc_task() and sched_asym()
> > from there sched_use_asym_prio() returns true without checking if the core is fully idle or not.

> sched_asym() does check whether the destination core is idle in sched_use_asym_prio() for non SMT domain.
> 
>                   (false for non-SMT sd)           (check idle core)
>        return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
> 
> That is also a pre-condition for setting group_asym_packing.

Sorry for not showing the code earlier, here it is: 

static inline bool is_core_idle(int cpu)
{
	int sibling;

	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
		if (cpu == sibling)
			continue;

		if (!idle_cpu(sibling))
			return false;
	}

	return true;
}
static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
{
	if (!(sd->flags & SD_ASYM_PACKING))
		return false;

	if (!sched_smt_active())
		return true;

	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
}

On sched_use_asym_prio(), before the idle check a CPU without SMT returns true.
But I'm actually wrong on that one because on that one we're laying
on the idle protection outside to the CPU. If there are not any
other brothers, and I'm idle then my brother-family
is idle... Ah I messed up describing this.

But is there are any idle protection outside? I couldn't
find any. I could be missing something tho.

> > And sched_asym_prefer() comes back true too, so sched_asym() returns true and, we just returned mig_unrestricted.
> >
> > I could be missing something, If I'm not tho is that on purpose? If it is, the last paragraph needs to change
> > since it says that "asym packing tries to migrate task to an empty core" and after that "higher performing idle core"

> I think I did try to point out the idle core aspect in my commit log:

> "When asym packing tries to migrate task to an empty
> core that has higher priority than source cpu, let asym packing win.
> Moving tasks to a higher performing idle core will buy more
> performance than cache co-location."

I know. I was trying to say that if we're not choosing an idle
core this needs to change.

Thanks,
Kayra

