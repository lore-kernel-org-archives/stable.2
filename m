Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4744C658
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013341; cv=none; b=ntvIdnFAcNFLT9RSuL5ywXxbwTnoePTf6cwTzmgmVis9nqW9gT2uha6eDyEUAoUCaxr+IIJxdx+rJYfOsTkkhMGv2HtDtnFuhS42wgO0oSz/luGAAwULkFnVFtzKIENeA9+dX/rNjx/WRuNDV2fvxFFinucqtgoElKE35lT1l2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013341; c=relaxed/simple;
	bh=j6H+PX1e3lYycHuDZQ2bpB3vKJGiK2cfNa2KcBwthIo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=uOduNBZbN0XDebiC/wTPro1CJk2nE9EMZLkwuk5SKCvW4li+XoB1reMjXvUy4OCJ+9oDMA1GPGMmlloylLEYmV6cMNOnMk7/8Em6HWfLlOIv/lP1Jag1Nn//3K68/o9fuxTLZZOmLOSZEIpkmXnc9z0ics4WE1n7cTR9qI3bTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqaPVJ31; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqaPVJ31"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3515266f6eeso2590653eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792013339; x=1792618139; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7OSBCOglDU5aKUGPIeFRTjWuazHyo1RPu0k6JP409Hw=;
        b=YqaPVJ31IabxiTGIs9MOyL5nDaCSr457+AqreanHlqDN47ZM7zyLDISOW96It5PC3e
         g8/1xgzDwBDKFd4ezju0eYT4mZcqMki8Iwmh0Rzi4kjOjb5DWJfNTolr34qEC6aKUT1k
         SnqXR8CqXDansaE+ks0Vy2G+89viehIQp63OVXa3K532vVx0LAbfNKAqGgTW9mc96HGq
         Z/I9CgRP+28iJPJ3KrGPX23S35yg38+JCStYZmg8Tl4XOhN1aj4Bn4AoBu9XLOCp3QqS
         YrWH4uZGgeoHVYDcFSx6jETtuct5tZpSnhEDKSfhcAKUWfmUnKqn2zA4x889sxp3C1zo
         yHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792013339; x=1792618139;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OSBCOglDU5aKUGPIeFRTjWuazHyo1RPu0k6JP409Hw=;
        b=BHSZn0KydM8NeAuPCm45UbdPDa9GlzK3qUo01ZQbKuMrFgfhdkDlRtFgAhP39qtLU0
         UUx7zNYmgpDYUxWOPVFA9AAw2WXzDgXidBMFK9zdSimovMjiDbVf7yGCfyEBfa3Y76sG
         R3H4max4sPB4hc6ZLFO++h0fD8MrsgcJsD38ZQYM+bedEGk0bCUILvE3OlUqJcOC9Rc4
         aO0zUHJrxWhBl5Epfvyi6CkkqeMYm3/qIuLmq8Wqgg59Kjq8sAL6q4JuqyBQTuAxP2Xu
         E3ydT2JkLRVOSHs8rEtLHaBI7UdN5QiuWeaWGSexsNb2smqCQLh0SVUCR5FSb8G0EM+w
         g1VQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZiWDp3Gdp7Ncx7MmBppzrwR58Bh01E5WulFf9K6XO6XjFkcFzwFmXJT/uMNXfQ0lfCLOzpJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL51wtS0b75l8l2fgf2L2RkhDJ3qaUCoCFGvMI0QTVXbt1LlrKT
	qkHIub/eHAlhu1yY/+GHD/v43UMPTlREsU/5exHVui/m8DMg5Qjd/S/RpJvU9We7aDspKBkoces
	0wRgEYduZhEFnRA==
X-Received: from dyu22.prod.google.com ([2002:a05:693c:8116:b0:35c:691e:dacd])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:e9d6:10b0:359:bdc8:c9d5 with SMTP id 5a478bee46e88-359bdd83104mr18774181eec.21.1792013325278;
 Wed, 14 Oct 2026 14:28:45 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:28:38 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014212844.11997-1-aaltinay@google.com>
Subject: [PATCH 6.18.y 0/6] KVM: x86: CPUID faulting fixes and AMD CPUID
 faulting virtualization
From: Anil Altinay <aaltinay@google.com>
To: aaltinay@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please backport the following 6 upstream commits to the 6.18.y stable tree:

1. 690dc03859e7 ("KVM: x86: Ignore cpuid faulting in SMM") [v7.1-rc1]
2. cf7d65d1d6f5 ("KVM: x86: Consolidate CPUID fault handling for emulator and interception logic") [v7.2-rc1]
3. be7fd7c3e8bc ("KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX") [v7.2-rc1]
4. d1bc99885a59 ("KVM: x86: Remove supports_cpuid_fault() helper") [v7.2-rc1]
5. e93a93f11490 ("KVM: x86: Virtualize AMD CPUID faulting") [v7.2-rc1]
6. b16c2aca369d ("KVM: selftests: Update hwcr_msr_test for CPUID faulting bit") [v7.2-rc1]

Patches 1 and 3 fix bugs in KVM's CPUID faulting virtualization (Fixes:
db2336a80489 ("KVM: x86: virtualize cpuid faulting")), ensuring that
CPUID does not fault in SMM and that CPUID faulting takes precedence
over CPUID VM-exits in nested VMX. Patch 2 is a non-functional refactoring
prerequisite for patch 3.

Patches 4-6 extend KVM's CPUID faulting virtualization (already supported
by KVM on Intel CPUs and by 6.18 host kernels on AMD CPUs via 65f55a301766
("x86/CPU/AMD: Add CPUID faulting support")) to AMD guests via
CPUID.80000021H:EAX.CpuidUserDis[bit 17] and HWCR.CpuidUserDis[bit 35],
allowing guests and container runtimes that rely on arch_prctl(ARCH_SET_CPUID)
to work uniformly across Intel and AMD KVM hosts, along with the
corresponding KVM selftest update.

All patches cherry-pick cleanly to 6.18.y except for a minor context
conflict in patch 2 (arch/x86/include/asm/kvm_host.h) and a u64 vs.
uint64_t type adjustment in patch 6 (tools/testing/selftests/kvm/x86/hwcr_msr_test.c).

Jim Mattson (5):
  KVM: x86: Ignore cpuid faulting in SMM
  KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX
  KVM: x86: Remove supports_cpuid_fault() helper
  KVM: x86: Virtualize AMD CPUID faulting
  KVM: selftests: Update hwcr_msr_test for CPUID faulting bit

Sean Christopherson (1):
  KVM: x86: Consolidate CPUID fault handling for emulator and
    interception logic

 arch/x86/include/asm/kvm_host.h               |  1 -
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/kvm/cpuid.c                          |  6 ++-
 arch/x86/kvm/cpuid.h                          | 14 ++++---
 arch/x86/kvm/emulate.c                        |  6 +--
 arch/x86/kvm/kvm_emulate.h                    |  1 +
 arch/x86/kvm/vmx/nested.c                     |  2 +
 arch/x86/kvm/x86.c                            | 39 ++++++++++---------
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../testing/selftests/kvm/x86/hwcr_msr_test.c |  9 ++++-
 10 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

