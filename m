Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09464EC665;
	Mon, 28 Sep 2026 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613899; cv=none; b=GYYW8ZK//qn3Xic1LwzfMwNqm34gbISOTTeJmrzJHkkytbl4sLMKU9fK2Erv8NhUN29Nuk1iTcGb0lYWgN8oc04qjX/NTzbTqpZyWpI9rm0cbRm5J/rGmY5jp+gQpAeNS84ZPkTn1N1pSHIQQrAKo2HmaGBQvTFPsK82h7X1j0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613899; c=relaxed/simple;
	bh=gWQFHOs73qDRXfHN/A480vDvUJBl+N73b3+Fol4Ysrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nL83KXhay10hnem8wwwBL8UFf+/WkdaZ8ffw4N7u71sQnv3Aug2QMHcoC/iqjSw/BwbdBLdycZC049Z3LOEWaAvTk5d/wBikCwWFE+Oz5IXDLZAcMoDBM8UzZXOP75dQ2Wc+AdVedK//IHkK+uy1ECVhQRRP9kIvYeZVXEpglt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=Ddia5p1V; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="Ddia5p1V"
Received: from fedora ([104.28.225.80])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SGijNl080644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 01:44:50 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=MbSyrRFNzJ0YeVpXN7dw5QAgzDG7WFJnFocIuRI8ccE=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1790613890; v=1;
        b=Ddia5p1VV7bgaNCKXG/EMi5UHoAfMP4/Nygd7/ZmWv5U6Fwl0Fobi8XyOyiSYXah
         mTRPDDs7jG65alNQPWDep3RF8ZckUrAgKWgNedK0b6XF0wo2crXwKRvcOoXV3mIO
         UxwKD682dwXvItaqsM1bNTKkXOm+HNvAR0cmkpQpslc+yRFpn1CFbTOMOxbGtDEI
         Vq+e5gKa5vKfze+WBoSG/AdD5K81tF4dfWza8u/olq2Z4lG4iy4Tu57muO011KbO
         CK5daEbkKUONmgKSr4NXW70ugyc5zUmnIinpGAlPbD0LIf3RomlTW8w+MySko5sH
         ERMMFfpBlpOWaIj5Wlam1Q==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v4 00/11] KVM: fixes for CVE-2026-46113 and related issues
Date: Tue, 29 Sep 2026 01:44:16 +0900
Message-ID: <20260928164427.4699-1-k@mgml.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a backport of the CVE-2026-46113 and CVE-2026-53359 fixes to 5.15.y.

v2: https://lore.kernel.org/all/20260626174620.1819772-1-pbonzini@redhat.com/
v3: https://lore.kernel.org/stable/20260913155523.7423-1-k@mgml.me/

Changes from v3:
- Added patches 3-6 to backport the change from gpte_is_8_bytes to has_4_byte_gpte.
- Adjusted patches 7-8 (patches 3/7 and 4/7 in v3) accordingly.

A regression has been reported in the backport of commit 0cb2af2ea66a
("KVM: x86: Fix shadow paging use-after-free due to unexpected GFN")
[1], but the corresponding fix has already been merged into 5.15.218 [2].

[1] https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/
[2] https://lore.kernel.org/stable/20260825132543.573783299@linuxfoundation.org/

David Matlack (2):
  KVM: x86/mmu: Use a bool for direct
  KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()

Lai Jiangshan (3):
  KVM: X86: Remove useless code to set role.gpte_is_8_bytes when
    role.direct
  KVM: X86: Calculate quadrant when !role.gpte_is_8_bytes
  KVM: X86: Rename gpte_is_8_bytes to has_4_byte_gpte and invert the
    direction

Paolo Bonzini (5):
  KVM: MMU: update comment on the number of page role combinations
  KVM: x86/mmu: Derive shadow MMU page role from parent
  KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
  KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
  KVM: x86: Fix shadow paging use-after-free due to unexpected role

Sean Christopherson (1):
  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

 Documentation/virt/kvm/mmu.rst  |   8 +-
 arch/x86/include/asm/kvm_host.h |  32 +++---
 arch/x86/kvm/mmu/mmu.c          | 184 ++++++++++++++++++++------------
 arch/x86/kvm/mmu/mmutrace.h     |   2 +-
 arch/x86/kvm/mmu/paging_tmpl.h  |  32 +++---
 arch/x86/kvm/mmu/spte.h         |   5 +
 arch/x86/kvm/mmu/tdp_mmu.c      |   2 +-
 7 files changed, 159 insertions(+), 106 deletions(-)

-- 
2.53.0

