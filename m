Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0943C055
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016393; cv=none; b=AhQxxyxfGJeqq1kSyKwhKuWHL4RrKQNHrwh7ELBRtxBsG3obO/2TJ5h9AEjTs8GHEoqlF9UqzlKJTVBMCw9g1FlL+L2UZLUTC1EhfT2Yqv/dXVh9nlLSkdsDCmt770cBahby2Xgu6xfd4+kq1dWN+t7QRv7CCH2uoMaK5MAwEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016393; c=relaxed/simple;
	bh=iLalscaeIcy/OSRJBRHPqe3+AZur8ik1rs4zkdnvHAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GIqNAJlc2xYCoWpf1dXg9CFKA1d0bgQLihPELftawQnN6vQh1g6VlCo4CjF9rFzPYXZUkavJ8lsmDT4GIfJ7DQePIp4VMMhOymUXJZCRQaJiHg2O4fKmQ89g8dllseciXV/xvHp1gOabML42sm53pJ5cG1pT6uGYMPRa/4yAfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bvn94t4l; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bvn94t4l"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3592749a017so1421177eec.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792016390; x=1792621190; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aOCc7tbAQ45kPkD8KQf9Xxo8+MXZSl2iBJtYnN//q/Q=;
        b=Bvn94t4lCyWzImDkIfiIImtxfUoTUw/5aaa3wTMsA38rQg5c5cSO/U+emOa35V8PhM
         sEcB8tG25OV0Ifko4knLEYLZgNdJQHTI/JXXbsLztLabgpg8kK60IiluDxpcB8G9H++4
         nVBcsJd/WO0DjvzEako9thhbsQrMZZMLft8T5KCW5TEpFRBaR0JWztTB0pKQM0ZwYz+7
         e+0JvVU1BpO3dMbPLDiRQm0j6cXyOJKO70FgBeTUz+AaPSDxQ0xnuIiV30fVtzrmAHjA
         8k8Rh0V+P7D72rFKYQ1RV2nX/U3qvfhw1AYsfakIE5arGUHhwGBbejvnGHk4w+kDGB+D
         qGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016390; x=1792621190;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aOCc7tbAQ45kPkD8KQf9Xxo8+MXZSl2iBJtYnN//q/Q=;
        b=HmBEW+kzlwrpyHfCH1sAHlInn6L+ioOmyNX5jYWzi6beXtDgp4pFk1Ge2cGF6vhW7U
         uQBIG0QsTrfA5CrgJ4fXi3zGxr9HCXS+lFsPe5+EVgeiGeEsrFm13QlfY021tMM0xI+n
         E6FrpUpGcKi0TNHo3f1Tmy3Fr15J3cGaQtkLPP1wuR6uAkN6qp0Dv2D8CGHUMBpN3B+v
         168xtTUi1dmu6JTGb3xUqO0Umi5hNZ7cVTCIAB50B3ySbii9O8K0I1tmDNCA0qepm4Od
         33gWB0SGJEaXeAH/xmOocxFxWz3GCiGkcKpoYg6I2+nFp+I3JsgbkEKTZ9j6QzSJDlTP
         vOsQ==
X-Gm-Message-State: AFq9FYLcWlggsjTSix8JZAF1sbS/4pzGt4sseMkihyXgTbijvGwNuXBi
	iZLNgpnAoMgzxvFFYhcCPFTjEW3s/VbrL4YquxFv0HaJi1F/6TZ8oyhQCn3dRshy5rKIdSgP2lI
	T57+WHXgoWzLXNhDUquhah4fIp5adA8EAEssh0XwIY83hudai2MOIoawFrUr6MkoDq0Q5fT7nyC
	URee0vt33XPEa6ljGmobsKvfP5ARVR0XslyGYBCUUsk0nn0pg=
X-Received: from dyvs2.prod.google.com ([2002:a05:693c:42c2:b0:351:4b2e:418a])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:ce83:b0:355:29c0:9cac with SMTP id 5a478bee46e88-35529c09e80mr21905183eec.10.1792016389868;
 Wed, 14 Oct 2026 15:19:49 -0700 (PDT)
Date: Wed, 14 Oct 2026 22:18:54 +0000
In-Reply-To: <20261014212844.11997-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261014212844.11997-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014221854.275719-1-aaltinay@google.com>
Subject: Re: [PATCH 6.18.y 0/6] KVM: x86: CPUID faulting fixes and AMD CPUID
 faulting virtualization
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Anil Altinay <aaltinay@google.com>, Jim Mattson <jmattson@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+Cc: Jim, Sean, Paolo, and kvm@vger.kernel.org (omitted from the initial
send due to --suppress-cc=all).

Full thread on lore:
https://lore.kernel.org/stable/20261014212844.11997-1-aaltinay@google.com/T/#t

On Wed, Oct 14, 2026 at 9:28 PM Anil Altinay <aaltinay@google.com> wrote:
>
> Please backport the following 6 upstream commits to the 6.18.y stable tree:
>
> 1. 690dc03859e7 ("KVM: x86: Ignore cpuid faulting in SMM") [v7.1-rc1]
> 2. cf7d65d1d6f5 ("KVM: x86: Consolidate CPUID fault handling for emulator and interception logic") [v7.2-rc1]
> 3. be7fd7c3e8bc ("KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX") [v7.2-rc1]
> 4. d1bc99885a59 ("KVM: x86: Remove supports_cpuid_fault() helper") [v7.2-rc1]
> 5. e93a93f11490 ("KVM: x86: Virtualize AMD CPUID faulting") [v7.2-rc1]
> 6. b16c2aca369d ("KVM: selftests: Update hwcr_msr_test for CPUID faulting bit") [v7.2-rc1]
>
> Patches 1 and 3 fix bugs in KVM's CPUID faulting virtualization (Fixes:
> db2336a80489 ("KVM: x86: virtualize cpuid faulting")), ensuring that
> CPUID does not fault in SMM and that CPUID faulting takes precedence
> over CPUID VM-exits in nested VMX. Patch 2 is a non-functional refactoring
> prerequisite for patch 3.
>
> Patches 4-6 extend KVM's CPUID faulting virtualization (already supported
> by KVM on Intel CPUs and by 6.18 host kernels on AMD CPUs via 65f55a301766
> ("x86/CPU/AMD: Add CPUID faulting support")) to AMD guests via
> CPUID.80000021H:EAX.CpuidUserDis[bit 17] and HWCR.CpuidUserDis[bit 35],
> allowing guests and container runtimes that rely on arch_prctl(ARCH_SET_CPUID)
> to work uniformly across Intel and AMD KVM hosts, along with the
> corresponding KVM selftest update.
>
> All patches cherry-pick cleanly to 6.18.y except for a minor context
> conflict in patch 2 (arch/x86/include/asm/kvm_host.h) and a u64 vs.
> uint64_t type adjustment in patch 6 (tools/testing/selftests/kvm/x86/hwcr_msr_test.c).
>
> Jim Mattson (5):
>   KVM: x86: Ignore cpuid faulting in SMM
>   KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX
>   KVM: x86: Remove supports_cpuid_fault() helper
>   KVM: x86: Virtualize AMD CPUID faulting
>   KVM: selftests: Update hwcr_msr_test for CPUID faulting bit
>
> Sean Christopherson (1):
>   KVM: x86: Consolidate CPUID fault handling for emulator and
>     interception logic
>
>  arch/x86/include/asm/kvm_host.h               |  1 -
>  arch/x86/include/asm/msr-index.h              |  1 +
>  arch/x86/kvm/cpuid.c                          |  6 ++-
>  arch/x86/kvm/cpuid.h                          | 14 ++++---
>  arch/x86/kvm/emulate.c                        |  6 +--
>  arch/x86/kvm/kvm_emulate.h                    |  1 +
>  arch/x86/kvm/vmx/nested.c                     |  2 +
>  arch/x86/kvm/x86.c                            | 39 ++++++++++---------
>  .../selftests/kvm/include/x86/processor.h     |  1 +
>  .../testing/selftests/kvm/x86/hwcr_msr_test.c |  9 ++++-
>  10 files changed, 46 insertions(+), 34 deletions(-)
