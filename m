Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E1493634;
	Sat, 22 Aug 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787420830; cv=none; b=Km1JUewjDiHFaqD+7a52IwkKpoQWq6nEx2CFCuLVzO9QfrMCQUjWo75yGrWCAP/S4SqzLpBPlWDAvkJKilwDBNNtqFi4Ry7Og8h7sokAHGRMlWWm3s5NsxVr0NEyVCBLbKldxC3xK78PZOjG22r1whwCZiN6MUHTK5WF5Vu6HgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787420830; c=relaxed/simple;
	bh=bPfb+0gp9cutkCtqt/VXyz8yJyWUIXCEMg2+0vq7LS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cebUgHCI/IQ4s0ZOsxD0+r/s4S08rP8valR0l10JCCkfIhxD5guHDn8XPISqcvCTGFQZu/9OjnW2z1FbikwJ00xD9UcNqARgyXHhbk+CongWJyNpI7Qplcv/oAW0At9d/zTohqPYUdpBAcJpKl4IPcJYTd2hE0xn1V+6A1ixSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n51jg6fD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n51jg6fD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F61C1F000E9;
	Sat, 22 Aug 2026 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787420829;
	bh=6WB+C3M5a3Hl9PHOoINUYEIB1LEhBsb2GS8+jgHSNSA=;
	h=From:Subject:Date:To:Cc;
	b=n51jg6fDwwfbpb98t5TcN15ZYzgujaewKk6PzxEgp0IRmPUCwidwMWod1vqeTw6AF
	 MomN38hz3XJYTdIECKANLIM+amE0LRaPtYTHaWubswegUH3XL15dsNyd07uiJkf+fs
	 Vnc4wPa/BoJO8sGk5k0BR6CLDt842T5RWK1OtjOQgw7CfMr11Yqp7gD2xLkMES2fyN
	 CDObbu68Adulb1ewRAkghErr1WdrxoPtUP4lU4SQxuxlvUCt5qK/ZReMsG5ehRGgO6
	 bAle+wzqnzqBXX+3Z3QumtkEdbBHS5/9w4yq0sChAftXY5X3GjPHQgtvDKeAJodyln
	 woYqPP97XFz3A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v2 0/2] KVM: arm64: Fix spurious warn, null ptr deref on S2
 teardown race
Date: Sat, 22 Aug 2026 18:46:52 +0100
Message-Id: <20260822-kvm-arm-nested-virt-fix-v2-0-ac4059a0eaa6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0K6dkynKFZX3sOwKDLABGnNlDQaw
 t2tJC5dvpf89xcVSZiiuhSLEkocOfgMZleo++B8T8BtZmW0qbRFhDFN4GQCT3GmFhLLDB2/QJd
 IZ9dgQ/ak8voplPVWvtWZB45zkPd2lPBrf03zt5kQNBxca23ZYVO543Uk8fTYB+lVva7rByzTF
 Uy/AAAA
X-Change-ID: 20260811-kvm-arm-nested-virt-fix-031e9ab1be87
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Christoffer Dall <christoffer.dall@arm.com>
Cc: Wei-Lin Chang <weilin.chang@arm.com>, 
 Yao Yuan <yaoyuan@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; i=ljs@kernel.org;
 h=from:subject:message-id; bh=bPfb+0gp9cutkCtqt/VXyz8yJyWUIXCEMg2+0vq7LS8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI6H0xbY7X/zgGeR19DMrqcD7hM1tRoveL54MWeBF0W8
 SfaQe9ndZSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAi09Yy/NPWDWR/d1whbrrw
 61nPJ8yUmdihJ2L9IDTq1hwXxZ5p6tMZGbpD9Sva2iRv3gu/KS2RcyT+4iRWjaVCve7R4hcuf5n
 MzwUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

When GFNs are invalidated in L0 an MMU notifier triggers
kvm_unmap_gfn_range() which tears down all of the stage 2 shadow page
tables for nested guests via kvm_nested_s2_unmap().

To avoid lockup, the kvm->mmu_lock is dropped while doing this and the task
rescheduled once for each block of physical address space (32 MiB for 16
KiB page size), with the lock being reacquired once the task is scheduled
again.

This results in a potential race between this L0 tear down and tear down of
the guest itself in kvm_flush_shadow_all(), a race which has been observed
on real hardware.

When this race occurs it causes an invalid kernel warning when the PGT of a
nested MMU is cleared by kvm_flush_shadow_all() ->
kvm_arch_flush_shadow_all() -> kvm_free_stage2_pgd().

Patch 1 fixes this by having stage2_apply_range() no longer return an error
when it has experienced a benign race with pgt teardown when it drops the
lock.

Patch 2 addresses something more serious - bad timing can turn this spurious
warning into a NULL pointer dereference.

kvm_arch_flush_shadow_all() calls kvm_uninit_stage2_mmu() which calls
kvm_free_stage2_pgd() on the canonical kvm->arch.mmu for that guest's S2
mappings, making it NULL.

This is problematic if it happens before stage2_apply_range() reacquires
the kvm->mmu_lock, as it ultimately returns to kvm_nested_s2_unmap() which
dereferences kvm->arch.mmu.pgt with the mmu lock held under the incorrect
assumption that it means it's valid, resulting in a NULL pointer
dereference.

Fix that by checking if kvm->arch.mmu.pgt is NULL before dereferencing it
in kvm_nested_s2_unmap() and kvm_nested_s2_wp().

v2:
* Rebased onto next
* Updated 1/2's commit message to say that it was all of the kvmtool hosts
  that were stopped, as per discussion with Wei-Lin and Yao Yuan.
* Updated 2/2 to remove the !may_block WARN_ON() as duplicative, as per
  Marc.
* Updated 2/2 to abstract the VNCR IPA invalidation in
  kvm_invalidate_vncr_ipa_all() and perform the same check for
  kvm_nested_s2_wp(), as per discussion with Marc and sashiko report.

v1:
https://lore.kernel.org/r/20260812-kvm-arm-nested-virt-fix-v1-0-4ad883f1b6a5@kernel.org

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (2):
      KVM: arm64: Fix spurious warning for benign stage 2 teardown race
      KVM: arm64: nv: Fix null ptr deref on nested wp/unmap, teardown race

 arch/arm64/kvm/mmu.c    | 10 ++++++++--
 arch/arm64/kvm/nested.c | 15 +++++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)
---
base-commit: aa8e5dc6a7a2a1141ab40706a51010adcd0e57d2
change-id: 20260811-kvm-arm-nested-virt-fix-031e9ab1be87

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

