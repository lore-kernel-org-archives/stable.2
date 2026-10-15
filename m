Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405135581FB
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080238; cv=none; b=r+tX9fx334Pd46D2znkDFIkyRmqE/hd329vFZH9VzvF5ZHdRl0BzHAyivh7o5UQ892wHS44sHw/Oe7LZER1+W/VUF0sviML2sR/EElI5xTc5uJHFjzGkvRNy4AO9cggHC6wCZUN4rEnDnT/kHm7u+wtwyAWP/THXyBUmnVkRHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080238; c=relaxed/simple;
	bh=mAd1kLcSwnxVrxeygRYauPj5HV6MXJmqjlEl29oC1w8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e3Lq+3KbfsKe+/f+N34xOT5b0ybMKJvSvTp6SVYAfuCdSi1ylrKdWgwqhGnMPbT5xfxHu6wzB58cnYmRUJPN1rsLREK1QShp9Xm5ujuF4P9MwuhmfA6z0qAlVCaw26XCdyvvAzHLKG8qQB1y7g87r73S/3jRrjGOnBBWbCNMS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsVvl21j; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsVvl21j"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so20184555c88.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080228; x=1792685028; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVHgaIROVIh1dbKZNGZDp4okzaZe1g6+U8n1ziBMJQE=;
        b=BsVvl21jiC5EThQlnIM1aGqiHHgREW9A9DesK0JHIsp9nFhc7hCXmJnr21QFFDQDwL
         zf1B6PXw2Fk9l8wDU7gJzfLLIyB6mW67V0l2d0N7d+WqonPrD6bw4cBbkpJLWn0CUHIj
         coCOPSm9SoQe40ck3oc9vqAVqnoMaZfaFHmZ2Q1dRprstRQh6hxP/Ghv27W+i6OiXX0p
         CEx0VLCA/Z5Fh6yYXz6tyHfuTfiVy9pPpXqONTV9CQ9HMVQoXvC1VmxjHynM9WHWousb
         VEElcuRW7gytHvFt0V4am+0AJLv5YE4jSe+wNcp7H5fK5FyYFZBuDk+ONeCoIetj7JBa
         3uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080228; x=1792685028;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVHgaIROVIh1dbKZNGZDp4okzaZe1g6+U8n1ziBMJQE=;
        b=DLJwkQNWjRNnxLALi+ZWxK99zvkgREP466lb5xQ/bt6ACm+EIXzLoQ7zAYCW8IuLKY
         ephQgOlEOvL1/p9E56gBPgyQ4xVzXOiOSKQGpETy069SQPzXS3iUZFCsH0GD+MZvB4XM
         SIkSZfWOkcSa76rZmsFbLMT34+Fvx4bEzt8Cjj8F+4v3aPMUH+nwozmQXEAL2ic8NF94
         Xi9CxvvVsM55H+oNre102cvsJPlVU5sHV2dcki5vkTht+quL8cerkntq9rjWk9pu2B4R
         9Yh2l3MEm5OtxYpIhK80o9bJjV6V2PoTOJRX2Y/sGroGDve8tf74tmv4ySfHwj2LOYd4
         pHNg==
X-Gm-Message-State: AFq9FYJQsaNDOUL+GrCM5r0zj462tC20BXf5RMz6thEtJ1kQ0+Nc4qnI
	s9yqCTSN2WYvoBVGQ9mgp+1F/cccgQh2r2r6HsF3Bb0uNCj8S3PhJXDC00vcy2Ce49P0PsC9kCf
	59gw8eTIameJMEp+OzbMl7RXnc5yp2ziUqRQtXbaCDzMTbLEHSkhKTMV0e6lQr9b0t9nNVIjAkJ
	+HmR5lpeXOWqO3XODKQKd4j+eedCeq+Du0Z9e/8bzNq9tRppQ=
X-Received: from dli1-n2.prod.google.com ([2002:a05:7022:281:20b0:168:b4b9:d783])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f681:b0:143:26eb:18ea with SMTP id a92af1059eb24-16a638513f3mr33314626c88.29.1792080227484;
 Thu, 15 Oct 2026 09:03:47 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-1-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 0/6] KVM: x86: CPUID faulting fixes and AMD CPUID
 faulting virtualization
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
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

Changes in v2:
- Include KVM maintainers and kvm@vger.kernel.org on Cc across the series
  (omitted in v1 due to --suppress-cc=all).
- Link to v1: https://lore.kernel.org/stable/20261014212844.11997-1-aaltinay@google.com/

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

