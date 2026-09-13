Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231D361943;
	Sun, 13 Sep 2026 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789317454; cv=none; b=SbmWLCMxqx2xu2x03qzSNUPdBf6ID2hFYlf1u7Exy9tlEN+WBI2oTYjPdP34DnOCkE8WUQDVvZFZ2cbkikIpDus3rrBbOhPlS+rN31ILaDfQBWaobAzjdkgcYT042+gnojBENmK4J4OJNQ8OhkNxpmwkTuwwLW2q4CE9oos6iOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789317454; c=relaxed/simple;
	bh=fUuCbUwH8VFIq9RLgx+Va/qlDzgk+xgX4uq59PxIdF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJvgQUSIJ5OnyR5ICfbH+MBiMQgiCGhiwUWaG1IYHmCA29slHXTY8bl+7h0hM7oD6C+0jm+Wa2X/13XBO2dTXxrLA/nfAEOMmIQaPPIam228SNQYs5oCSHiLY9IfVSbs1oasJgtdnACIDLdbHW2ozfEImNwJIisDaMagiMouocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=gtenMDz8; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="gtenMDz8"
Received: from fedora (p3233127-ipxg00b01tokaisakaetozai.aichi.ocn.ne.jp [180.17.90.127])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68DFtZE5020593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 14 Sep 2026 00:55:47 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=01iqkdBzyjRH8Gt1HJekyOFgRe9M+r/oE9runOux/jY=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250315; t=1789314947; v=1;
        b=gtenMDz8K00PfXBaRiSgENsVz+WBGIH6R15P+oOljw9gnMU1AURyT2BWb4kdFYrs
         TRpZuLbiY1WecKqyBjfxq8/Ho7H31TA6wm3aEelidKDAPOA2uHRVpSWrnZ49o+pc
         g1PmbVswdwR3FQisULlHG+CwGIIfJ5Eqv47CzyBHcnZ7oJh0rPgM9jPWQixwO8mK
         tuG+AKWed9XTg6FeTSEXF3PUiNThprKgamfKa0f5YV/NZ5mRWVb3A7m2yHtHdMvA
         5zlgwZPXmqEAbKW8QIsRtrfOhJyRHxMV2UBijWUB+gVgwLQjhAcdAyS5vtPLXcKD
         FTQiThtLQAAvNWHV/l3TcA==
From: Kenta Akagi <k@mgml.me>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kenta Akagi <k@mgml.me>
Subject: [PATCH 5.15.y v3 0/7] KVM: fixes for CVE-2026-46113 and related issues
Date: Mon, 14 Sep 2026 00:55:16 +0900
Message-ID: <20260913155523.7423-1-k@mgml.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a backport of the CVE-2026-46113 and CVE-2026-53359 fixes to 5.15.y.

The only difference from Paolo's v2 [1] is that commit ef057cbf825e ("KVM:
x86/mmu: Ensure hugepage is in by slot before checking max mapping level") is
not included, as it has already been backported to 5.15.y.

I believe v2 was not merged two months ago because of the regression reported
in [2], which occurs when only these patches are applied.

Commit a955cad84cda ("KVM: x86/mmu: Retry page fault if root is invalidated by
memslot update") was proposed as a fix for this regression. I have confirmed
that applying the v2 patches triggers the WARN, and that applying a955cad84cda
fixes it.

Since a955cad84cda has already been backported to 5.15.218, it is not included
in this series.

[1] https://lore.kernel.org/all/20260626174620.1819772-1-pbonzini@redhat.com/
[2] https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/ 

David Matlack (2):
  KVM: x86/mmu: Use a bool for direct
  KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()

Paolo Bonzini (4):
  KVM: x86/mmu: Derive shadow MMU page role from parent
  KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
  KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
  KVM: x86: Fix shadow paging use-after-free due to unexpected role

Sean Christopherson (1):
  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

 arch/x86/kvm/mmu/mmu.c         | 174 +++++++++++++++++++++------------
 arch/x86/kvm/mmu/paging_tmpl.h |  32 +++---
 arch/x86/kvm/mmu/spte.h        |   5 +
 3 files changed, 129 insertions(+), 82 deletions(-)

-- 
2.53.0

