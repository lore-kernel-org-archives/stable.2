Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275810;
	b=4PXfykCZZ6tAklxxBv1aF+mUHHFYBV69QutfGFZ6dyGYJcMPQk1OPR5dOCZeYSHhLLFx
	 pSlEdBIcQJn2m/zTaIfPXeVNI98VhJKJ/cEkIK6vuhbMk3wPAtJZ+smMvXxAp9laWnr1L
	 BKJMHiMWKlqn0hFvoUpEedqj6Qlf6eoEaEN0JbmkHaVIHT8U2jCsS8kvhrfxYMN17RTRd
	 saazSkgeCwkjP31/vo7bgM3A+LgU2bC0WCcMJCMvDm0ZYqm7K0kDycPCeyYupjfLYD87+
	 LAbVF/dSlUhLYlrLT4OqVYdlJXjHCUTylMAXYlj/H5gF+ais98gTd6GG+FmJxRQbLug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275810;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=U/GLzhO+8Tu2q9rpniCo3uEIbsbNdFc1r0M6YD8YoCg=;
	b=kCzwNl84gJaIp7uzOpWSolbTelKZ4BdpMO1g97bK9jiRgTTTURyvz0IRF/2fDkztfv1Y
	 +c6SLhJujrWFRowir6ALk32LsnlYMyg+zBwVjq5zWRwVWOI0KC1tgj4goR6n2DQDmFTy3
	 QtmWOnQRl6pnr1lzErNVjBdr0d+b2yxpZVOwXDcr2WVXPEtrPy0taRMRkdYuZ8shjEMzi
	 i6gOiI0pY4J66jJuEqDTLoq1k++5Fm7+xZ3HbqLtRuMViAEjy+VwgfJQY2kzL3kSXif/o
	 MxGCu0ngb94elkgmYOpQoCNG9iHpwXoOQcEkye1ANBY2bDYk9vKDUD/m/Heegu968xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czlPgh+f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8C606A31A;
	Thu, 29 Oct 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czlPgh+f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0781F031E0;
	Thu, 29 Oct 2026 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793275810;
	bh=U/GLzhO+8Tu2q9rpniCo3uEIbsbNdFc1r0M6YD8YoCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=czlPgh+fMpcy9TuAFGsdkERT2El2sGBs/ucRkvPo4+3587dSYTprGRRYB4qR6oA9B
	 G4njPNZ27ndenSmHL3scOCo3aDKg2XlZK86YC0ecGP+EBp8H/zcxLRx2xL02gMjeps
	 lCsT5fyDK/0vbbIQZOMDvx5RWwGZgpy/Xd4q9u7z/8HMoIZ71T7RwqNHXm6ygc+smP
	 LJwuKh277g71y3psshYzmoCYpoz0TWvDO7ac9cqW2+hyqZItXi18JK8eaKKZNo1wJU
	 80tPBmmFMuv8tXkcVoUqTpkYy5nLQh0lB87f6HoSln4AjvQOHKwbA2ifdo/8thgy+b
	 opgNxx00goXsA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4D0C0198003A;
	Thu, 29 Oct 2026 08:10:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 08:10:07 -0400
X-ME-Sender: <xms:nTfjagLOU6BoivDMc2GLgDM1wkcq_oHdukaRL66sr8VWOqUeRCQ_qw>
    <xme:nTfjaglKCVAahrMP49k5B3wzDrEx7IZaKaa1DUXuCQWy41Q_1aIITfjFbfm2PKxUn
    dMbMZVTv9gokVm4RgX5MyJJl1ERU9bKX7mNtV9EXZy0dscbczK9-eU>
X-ME-Received: <xmr:nTfjamLfgk8sfmC3O2wjfcyjD9XM5rVKfMbxTVmSDFDoTsVJgDgryDIQqzs>
X-ME-Proxy-Cause: dmFkZTFyUOsv9zEwE14IcG4IXkaDraA3LYs+kVmkCd6BEWjS3bK5dNIHo8qFdbsq4nnFaR
    jNsLlK0yJkYI3ptekwEDEuw9UADrC83DWwTgWYMpMEHXvbfZicpBYdOs7QoVnAIFRHuoZy
    kkCH/EdfBs5e8UWcH58AJczdDAazoF2Yq3rHLXXHN71EABRfGNlqAxYMkeUndhWwKgP8nl
    SjB2QPnrZV50fTaurVRszgIdZSAq58bAVTbYeCGJA6fz6aAN03AvAWCkl3aiXGZ0cfcj2W
    WMxVAOSCPiAEwCALuXiqVgAK08Ya/RkQ6VwglsFoNkIjLv5F/3grdn3CsjIVgW2XDfU0t1
    w24tBm74Atv6bYuLOoEB06NfHyaZOJPljuZ5WaILR5KcTPxKV/4K+S9NppejIjRQnYg3CV
    13qkvKmqBfUzhF817W4WlFyG5+Dt4H8/wk2oyg3AWLn0wJKfGv1O6KWnQ7NbB1PzD+D4DP
    J1NVeSaxdNgXukAIN/YGjtWHUVPxMQpw7TIZdSv5Aakets5LP++3STh9Q4iuoqYi96EIrf
    OTGCjtwEI7w6WvDSK0WOE9IJjoK5DL4F5Ac3LDmEZgmy3B711tj3DpyvABSbNqttehDjjk
    /wCkyOlw5bGRcusMtl/TMBzW8yLCIFUsR+Y7S5murCZildnRBomiCinX+e2A
X-ME-Proxy: <xmx:nTfjarV_-28KYu5uy5Q4cp4gOxYMSgMHLdqq6uXOJfXP2jZMyRCH0g>
    <xmx:nTfjarN2ZUuH1eIRvy_4lYAJIFvEAb1BZggKGV77qaOZcOtCUEqvVQ>
    <xmx:nTfjanljpf9TOX-XyD5I694ym5tQxh52SF_iZ_MrzsXgOknlXWG1-g>
    <xmx:nTfjauX1F3nRaV0zP7d-AAV91VXx1YRqH8o0wMo95npCQI8DVifD9A>
    <xmx:nTfjamIXTSENBf4e29CPVi179ndD1cOz6O8X_JvqH9nuOYu7rxH9Amnu>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 08:10:05 -0400 (EDT)
Date: Thu, 29 Oct 2026 12:10:03 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Challvy Tee <challvy.tee@gmail.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, dave.hansen@linux.intel.com, 
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com, kai.huang@intel.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/virt/tdx: Skip TDH.SYS.DISABLE if the TDX module
 is not initialized
Message-ID: <auM3KKutfutAqgWG@thinkstation>
References: <20261029080731.890996-1-challvy.tee@gmail.com>
 <20261029094705.896693-1-challvy.tee@gmail.com>
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
In-Reply-To: <20261029094705.896693-1-challvy.tee@gmail.com>

On Thu, Oct 29, 2026 at 05:47:05PM +0800, Challvy Tee wrote:
> Commit 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and
> kdump") made native_machine_crash_shutdown() call tdx_sys_disable(), but
> tdx_sys_disable() has no runtime gate: its only guard is compile time
> (CONFIG_INTEL_TDX_HOST), which is enabled in most kernel configs.  On a
> system where the TDX module was never initialized, kdump now issues a
> TDH.SYS.DISABLE SEAMCALL that it did not issue before, and the crash
> path never reaches machine_kexec().  The capture kernel is never entered
> and no vmcore is written, so kdump is completely non-functional.
> 
> Having the TDX module uninitialized is an ordinary state rather than an
> error.  tdx_enable() returns -ENODEV early when
> X86_FEATURE_TDX_HOST_PLATFORM is absent, and it also bails out if
> init_tdx_module() fails.  Any guest whose host does not expose TDX is in
> this state and logs:
> 
>   virt/tdx: TDX not supported by the host platform
> 
> The syscore path is implicitly protected: register_syscore() only runs
> after init_tdx_module() succeeds, so tdx_shutdown() cannot be reached on
> an uninitialized system.  That is why plain kexec still works and only
> kdump regressed.
> 
> The crash path calls tdx_sys_disable() directly and bypasses that
> protection.
> 
> Reproduced with 'echo c > /proc/sysrq-trigger' in VM guests on Intel
> Sapphire Rapids, Emerald Rapids and Granite Rapids platforms, in every
> case on a kernel that already contains the change described above: the
> capture kernel is never entered and no vmcore is produced.  With this
> patch applied kdump completes normally on all of them.
> 
> Three negative controls, all of which produce a vmcore as expected: the
> same guests on kernels without that change, guests on platforms without
> SEAM support, and plain kexec on every platform tested.
> 
> On a host where the module did initialize the new gate is a no-op and
> TDH.SYS.DISABLE is still issued, so the poison clearing that the above
> commit was added for is unaffected.  We do not have a TDX host to test
> on, so this part is reasoned from the code rather than measured.
> 
> Gate the SEAMCALL on tdx_module_state.initialized, the same predicate
> tdx_get_sysinfo() already uses in this file.  Putting the check inside
> tdx_sys_disable() rather than at the crash.c call site also covers the
> syscore caller and any future caller.
> 
> Fixes: 5b25f249be32 ("x86/tdx: Disable the TDX module during kexec and kdump")
> Cc: stable@vger.kernel.org
> Signed-off-by: Challvy Tee <challvy.tee@gmail.com>

The changelog is long for a three-line check, and it doesn't say why
the crash path stops. It takes time to understand what you try to fix.

A SEAMCALL that hits #UD is caught by the fixup in tdxcall.S and returns
TDX_SEAMCALL_UD; tdx_sys_disable() then leaves the loop without printing
anything. That is your no-SEAM control, and kdump works there.

On SPR and later, SEAMCALL in VMX non-root causes a VM exit instead, and
what happens next is up to the hypervisor. KVM injects #UD only since
9d7dfb95da2c ("KVM: VMX: Inject #UD if guest tries to execute SEAMCALL
or TDCALL"); before that it is an unexpected exit reason and the VMM
gets KVM_EXIT_INTERNAL_ERROR. What hypervisor are your guests running
on? Does the host log "unexpected exit reason 0x4c"?

If that is it, kdump is broken only in guests on SEAM-capable hosts
whose hypervisor doesn't handle the exit.

The changelog should say so in a couple of paragraphs.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
