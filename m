Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066448;
	b=UoXEQQ8yKK3vFv9ZiOqoYC4DQ0Ja5EddoFbHJGcnj7El0jJcycHyGoTO3ZBQn6fK9A21
	 5ZWgbL0ofK/uymKx/WmYzA8XyL4QLgGhP0IZ6xHZ/LeT7ibKZBgL80AHVAW2w/HPva7Q9
	 T9Flon+1fZM/Tk/5oLa8ZNlK6PDMC8K5w+KeFgSHmmIYzd3xH4bj+7ejMCNJAjPGkvNDY
	 z5dzgcZWggJ8/SGpEpi6Ghb/k6STR+irkq+uvnp8UorRn+ucTlFSgkxGldEas8pcSkPRK
	 TmYUf6GCmfSw8kx8PbWjsCtoN7NSfGG8eXQSoV+49ghLZR0l2SCLBJgJoDAYYR8RSrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066448;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=duhbiXksGFrPIHyXVWTK8sp/MGLnQlxtL+yPNY6djtQ=;
	b=VUpCDBXE2JK6pkz9QVrTJiDEVSqIzK81f3EdizRh7vbRc9PE2p3fOWgazsAM3+DoEc4W
	 Nu3frjldZcz+mGgoPSZOFUq54elLkLJ+bGJt9tgavGfudoMelmEY/LBoZUoC1vxcg+q+2
	 xr07K1FFWLWQg8tJ+KhXukbsxYUstjxEeZRy7tSnJAikqogmKM4v7rOjyGalH81R7OgIq
	 cBXYctgvBzFfaYjn6gcobG6yaMODYhPBxMlNRJMn+rC0hTfk56eHkXT4Tjb0ukBnQUbsv
	 cYJnbb/u3zG/er+hnvIhagJBQlTpB9I8sR00R0B0QqXqRHdwflfpCNumpYtqhz/3Ubw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C1gmdFMj;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3C606A320;
	Thu, 19 Nov 2026 05:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC3C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C1gmdFMj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795066448; x=1826602448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rUwySB+EKtGnAKmhHNKadJinh4vPXLfcbG1RLYUvgas=;
  b=C1gmdFMjJ8iDhd0UN1Yek1pQRL05u6VVnncPJcn+BrQP75kuX6qQEXW0
   aEozaPNdWPxM4qWaXecU5EqMYmxJpS/7xu8oNB9j2V7v3NP06YxMvQ6gl
   SaQVsrUoi4s8l7scFG/FtiXJEnMWsL7/6rwCpUsnDLtHXOZ185fQb1nwb
   q6f24/7fAVj43xYe+W6lAtA9JCJAxy4IowWg7ZUwV5fpyaKkEO6hKURLz
   LictgF4CYs8/+Uzn/y0/Yv/UdcUrGF8FD18vZhV5rR805609OmZAj33vI
   rPGABhkSU4adDEAB5gIBrbFWLUTtev+jgCyK23TgW+YlE2wLqrEuqbPnZ
   w==;
X-CSE-ConnectionGUID: OesxkPDQTha8TzLudQoNiA==
X-CSE-MsgGUID: MIRJU2gKTGWJ3+1QpYuORA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3748711"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3748711"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 21:34:06 -0800
X-CSE-ConnectionGUID: /bT2lp0RRG+nBQ+epg7gfg==
X-CSE-MsgGUID: tIxJRLOhSGiENTrt8je08w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10332335"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 21:34:05 -0800
Date: Wed, 18 Nov 2026 21:42:04 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: jez@sfcompute.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Andrew James <ajames@sfcompute.com>,
	John Ranzie <jranzie@sfcompute.com>
Subject: Re: [PATCH 2/2] thermal: intel: hfi: Disable HFI left enabled by a
 previous kernel
Message-ID: <20261119054204.GA7495@ranerica-svr.sc.intel.com>
References: <20261028-hfi-kexec-v1-0-956234dcfb2b@sfcompute.com>
 <20261028-hfi-kexec-v1-2-956234dcfb2b@sfcompute.com>
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
In-Reply-To: <20261028-hfi-kexec-v1-2-956234dcfb2b@sfcompute.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Oct 28, 2026 at 12:14:46AM +0000, Jez Ng via B4 Relay wrote:
> From: Jez Ng <jez@sfcompute.com>

[ ... ]

> 
> When the first CPU of a package comes online, check
> MSR_IA32_HW_FEEDBACK_CONFIG and disable HFI if it is already enabled. If
> a client subscribes later, HFI is re-enabled with this kernel's table as
> before.

This is not true on all processors. Some ignore later writes to
MSR_IA32_HW_FEEDBACK_PTR and, when HFI is enabled again, keep writing to
the table programmed by the first kernel after reset. Perhaps this
sentence can be qualified?

Also, would you be willing to check whether your Sapphire Rapids systems
honor later writes to MSR_IA32_HW_FEEDBACK_PTR?

[ ... ]

  
> +	/*
> +	 * A previous kernel may have left HFI enabled across kexec. Hardware
> +	 * would keep writing to that kernel's table, in memory this kernel now
> +	 * owns.
> +	 */
> +	if (hfi_disable_if_enabled())
> +		pr_info("HFI left enabled on package %u, disabled\n", pkg_id);
> +

By the time this message is printed, memory corruption may already have
happened. Perhaps this should be a pr_warn() that mentions the potential
corruption explicitly?

As you acknowledge in the changelog, this code runs rather late during
boot. HFI could be disabled much earlier, from intel_init_thermal(),
which runs at CPU identify time: from start_kernel() for the boot CPU
and from smp_init() for the APs. This also works when the next kernel
has CONFIG_INTEL_HFI_THERMAL=n.

Maybe something like this in therm_throt.c or intel_hfi.h, called first
thing in intel_init_thermal():

static void intel_hfi_disable_stale(struct cpuinfo_x86 *c)
{
	u64 msr_val;

	if (!cpu_has(c, X86_FEATURE_HFI))
		return;

	if (IS_ENABLED(CONFIG_INTEL_HFI_THERMAL) && system_state >= SYSTEM_RUNNING)
		return;

	rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
	if (!(msr_val & HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT))
		return;

	wrmsrq(MSR_IA32_HW_FEEDBACK_CONFIG,
	       msr_val & ~HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT);
	pr_warn("CPU%d: HFI was enabled by a previous kernel; disabled it. Memory may be corrupted.\n",
		smp_processor_id());
}

intel_init_thermal() also runs when a CPU comes online after boot and
on resume. Such a CPU must not disable an HFI instance that the driver
enabled for the other CPUs of its package. intel_hfi_disable_stale()
therefore checks system_state. Before SYSTEM_RUNNING, no client can have
asked for HFI. SYSTEM_BOOTING would not work: the APs come up during
smp_init() with SYSTEM_SCHEDULING.

I tried this on a Panther Lake-H system (one package, 16 CPUs). I
disabled the shutdown path of patch 1 and subscribed a thermal netlink
client to leave HFI enabled across kexec. The boot CPU disabled HFI
before smp_init() and acpi_init(). With your patch 2 alone, HFI remained
enabled 2.9 seconds longer. You should see a larger difference on your
systems, since 21 of their 30 seconds were spent in acpi_init().

A package with no CPU online at boot, for instance with maxcpus= or
nr_cpus=, keeps writing to the previous kernel's table until one of its
CPUs comes online, if ever. The check you added in intel_hfi_online() is
still needed to catch such a package when it comes online. With the
earlier check, that is the only case in which your check can find HFI
enabled. Only the syscore shutdown callback, in the previous kernel,
protects the time before that. Could the comment above your check and
the changelog say so?
