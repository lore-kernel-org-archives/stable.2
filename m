Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F221ABD7
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787493424; cv=none; b=bCZ8fAm0xWfT9MUQYMERwB/mQsGPDJdv71PL/YC02jvWALseIXr+1EYYzQXf8jMWqy6dW2/IPL0e/2d/899gA6jrpnedOEDXlZvEpKqu9zNZPlGxjfrq4e/f25NC8rgQxlJ8i4dr0VXbJfsWYHUembhaMViZY4zUVZ0R7ky05Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787493424; c=relaxed/simple;
	bh=/SC9PzbVjgTCZRtembq499HYS554XbNFyIsREBjFhuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwbZgaq0iH5vrOfgpMYuU3Pc/aA/dGAo+PQMS9NIzU9bu9fFE5AcAh8SUMdY8QeX9PtIpReeXZf1bNksM9FUZ1cHyyd56mY1cm/So20rqD3BHUS8Vg6vgD2l7D5PcwFHlqAm6QwkF+JUiT0ngfDsgxStWPe9VpaTOKV0ENFkvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=bYIywnNm; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="bYIywnNm"
Received: from fedora (p4270056-ipxg00p01tokaisakaetozai.aichi.ocn.ne.jp [153.201.103.56])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67ND837u016116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 22:08:39 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=shNDRQChgGVaeP68L9JHVYp3tLJln++KGLU0s+S7qqM=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1787490519; v=1;
        b=bYIywnNmxUWvyGeMljEfQY8Qf/qvvp+tujGDID0rMPnToiBm7TVOCn3NhUOgCVtJ
         fAe/lnAlFJregU9IN08XUFtPhGjSHbOlbeyMaT9KPx99TVmEmebI2breloft5BHg
         V63nY7A770xMWHA1fNVwj2v0toyO+OmGjK8sGESLqdG85rMZFITfJjm5npARTJVD
         vhzRYAhDI0M13p855qHcxdlQWuN8WqTOMdM2pL6ou56MrwZzV+f4lN+59i3Lgh8K
         giBt8vedptkTH6aQah4OMP/n9chTFfMzlTgQsG3r0bGeHHpgAIZ4dIJPN3irK3oM
         RCDsvhcl7mfOaNCtj07i9Q==
From: Kenta Akagi <k@mgml.me>
To: stable@vger.kernel.org
Cc: Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v2 0/8] backport for CVE-2026-64561
Date: Sun, 23 Aug 2026 22:07:43 +0900
Message-ID: <20260823130751.2880-1-k@mgml.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072557-gem-defensive-a757@gregkh>
References: <2026072557-gem-defensive-a757@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the backport to fix CVE-2026-64561, v1 is Sasha's series [1].

Patches 2-7 in this series correspond to patches 1-6 in v1; Patches 1 and 8 are new in v2.

  Changes in v2:
    - Added Patch 1 to backport is_page_fault_stale() as a prerequisite
      for Patch 8 and for the CVE-2026-46113 and CVE-2026-53359 fixes,
      which will be sent in a separate series [2].
    - Added Patch 8 as the fix for CVE-2026-64561.
    - Adjusted Patch 5 to rename mmu_notifier_retry_hva() inside
      is_page_fault_stale().
    - Adjusted Patch 6 to use is_page_fault_stale() in
      kvm_tdp_mmu_page_fault().

[1] https://lore.kernel.org/all/20260730192933.3123642-1-sashal@kernel.org/
[2] https://lore.kernel.org/all/CABgObfaKqT0gMUB_XRP5DW5HmpgaoTgmD-A8_zQVG2Vp5xZE4g@mail.gmail.com/

Chao Peng (1):
  KVM: Rename mmu_notifier_* to mmu_invalidate_*

David Matlack (2):
  KVM: x86/mmu: Split out TDP MMU page fault handling
  KVM: x86/mmu: Rename __direct_map() to direct_map()

Sean Christopherson (5):
  KVM: x86/mmu: Retry page fault if root is invalidated by memslot
    update
  KVM: x86/mmu: Directly "destroy" PTE list when recycling rmaps
  KVM: x86/mmu: Rename pte_list_{destroy,remove}() to show they zap
    SPTEs
  KVM: x86/mmu: Document the "rules" for using host_pfn_mapping_level()
  KVM: x86: Check for invalid/obsolete root *after* making MMU pages
    available

 arch/arm64/kvm/mmu.c                     |  10 +-
 arch/mips/kvm/mmu.c                      |  12 +-
 arch/powerpc/include/asm/kvm_book3s_64.h |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c    |   4 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |   4 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c   |   6 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c      |   2 +-
 arch/powerpc/kvm/book3s_hv_nested.c      |   2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   8 +-
 arch/powerpc/kvm/e500_mmu_host.c         |   4 +-
 arch/x86/kvm/mmu/mmu.c                   | 175 +++++++++++++++++------
 arch/x86/kvm/mmu/paging_tmpl.h           |  13 +-
 include/linux/kvm_host.h                 |  60 ++++----
 virt/kvm/kvm_main.c                      |  49 +++----
 14 files changed, 223 insertions(+), 128 deletions(-)

-- 
2.51.2

