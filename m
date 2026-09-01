Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02C48A2A1;
	Tue,  1 Sep 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283768; cv=none; b=gX9+r41W1TSleDlgpndY0i5rEFnARMotIVyvxNwZ5caBaNbrAhWPxtZkpNd1fhBK/LDIGG+ePblng82PDmqAogf7EcD8YFYSw6YQ1AgSpe5Wwz5k2eEmw68XWhcbSlwDW58UB12fex9SBmPDkiSPrdkKcWtj/6ZgyC/KHkVAWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283768; c=relaxed/simple;
	bh=m41US7wD5/m/bU/Pd28DwKVOkmVALeVkqCwbRa0CEVQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cm0FX5PlEkFeCf9Xp/XjtRst42w3woaRzz56xjAt7Zz/acwGegtdIwA2DAEo+3m7ZjmAEHIualA+QK56bmdNI23AezJhhAje+p1mSidhLQeF8fssm0tGOUvCYgp/oUcpPmJ3GkSDq94QaaYys4iDYaOwuH+ARvxVpBNVWCVBQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXaBoSZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXaBoSZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414461F000E9;
	Tue,  1 Sep 2026 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283766;
	bh=FiDYFS6p+l1Wdqd8ULNeebcQWZ8P0VQ4u2EjS1QBX1Y=;
	h=From:Subject:Date:To:Cc;
	b=MXaBoSZXFZWw+CZ299hrfiu9KRf1qE7AzXJ9ha9bU6iuYozxqHOD8vzslpPuecupL
	 6/3giLdrmo+S3rlgFBdOWaiybyA4M5sQVVd8sOqBOmZckO66nNTbptIp+DTznLPf3I
	 81BTXMLd2/ifoWrMkffFK28/eMSOeU9XJaSkL0aF77ufAh52IeKK4aRtaLsIPRAsZT
	 JR/yoBfVOL+KiqNqt+nDQMuuHPbO4QxX5I4byHhd9sIoUxu/gFtsaurJ6HQkdoDO77
	 8B61PlOJp/LILtuvYoujUiKQLkS4OGpdk8ZGIxCphHzvx6m/tDnFxhN8mdsKu4/KGx
	 hse86n5twQz9w==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v3 0/2] KVM: arm64: Fix spurious warn, null ptr deref on S2
 teardown race
Date: Tue, 01 Sep 2026 18:28:58 +0100
Message-Id: <20260901-kvm-arm-nested-virt-fix-v3-0-b154676f7e4c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6CMBCG4auYrh3Tlh+LK+9hXAwwQIMUMyWNh
 nB3C4mJLnT5fsk8MwtPbMmL024WTMF6O7oYyX4nqg5dS2Dr2EJLnUujFPRhAOQBHPmJagiWJ2j
 sA2SiqMBSlWSOIl7fmeK8yZdr7M76aeTn9iiodX2b+qcZFEhIsTYmaVSZY3buiR3dDiO3YkWD/
 oD0H0hHCKtUZgVKQsy/oGVZXi6GgvEIAQAA
X-Change-ID: 20260811-kvm-arm-nested-virt-fix-031e9ab1be87
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Christoffer Dall <christoffer.dall@arm.com>, 
 Fuad Tabba <fuad.tabba@linux.dev>
Cc: Wei-Lin Chang <weilin.chang@arm.com>, 
 Yao Yuan <yaoyuan@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066; i=ljs@kernel.org;
 h=from:subject:message-id; bh=m41US7wD5/m/bU/Pd28DwKVOkmVALeVkqCwbRa0CEVQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKmc+fn5e2542kkXCJjz/BZOjf2b0Rov87/piuM6q3HW
 385SMd1lLIwiHExyIopsjz/Ir4/SCRsXucFfzeYOaxMIEMYuDgF4CJxDP8jtPW0H3PpXdifxur5
 8P6sgpykd5tn2X2PXLTy6KUf87dnMTKckFsjtq3vnYVLv4Xxqfwk82cL+R1X+nScMNw0OznxaxA
 DAA==
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

v3:
* Rebased onto Linus's tree.
* Added R-b tags (thanks Yao and Marc!).
* Put commit message for 1/2 on a diet as requested by Marc.
* Clarified logic in stage2_apply_range() as per Yao Yuan.

v2:
* Rebased onto next
* Updated 1/2's commit message to say that it was all of the kvmtool hosts
  that were stopped, as per discussion with Wei-Lin and Yao Yuan.
* Updated 2/2 to remove the !may_block WARN_ON() as duplicative, as per
  Marc.
* Updated 2/2 to abstract the VNCR IPA invalidation in
  kvm_invalidate_vncr_ipa_all() and perform the same check for
  kvm_nested_s2_wp(), as per discussion with Marc and sashiko report.
https://lore.kernel.org/r/20260822-kvm-arm-nested-virt-fix-v2-0-ac4059a0eaa6@kernel.org

v1:
https://lore.kernel.org/r/20260812-kvm-arm-nested-virt-fix-v1-0-4ad883f1b6a5@kernel.org

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (2):
      KVM: arm64: Fix spurious warning for benign stage 2 teardown race
      KVM: arm64: nv: Fix null ptr deref on nested wp/unmap, teardown race

 arch/arm64/kvm/mmu.c    | 15 ++++++++++++---
 arch/arm64/kvm/nested.c | 15 +++++++++++++--
 2 files changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 786262be6048deab760f68c8acc2c85607165894
change-id: 20260811-kvm-arm-nested-virt-fix-031e9ab1be87

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

