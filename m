Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4D43B6C4;
	Wed, 12 Aug 2026 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541486; cv=none; b=tvUNdu012+zfeVu0ytl7Iu0UdJldZ+jAneai19EB5DoIROOa/6JN2/etc7g8b27XQVBv9c+QHi/PwKV3lSqQfZzOqMJKRa1q6QvhE9Mkb7xuYX8E4LQ0EOmk9yXQsCxn2rIfAneea4o48/n1cKkmZY080TKYvTvbjyp+lcbx/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541486; c=relaxed/simple;
	bh=tpLslcTY/jbcjdNO9fIepj0cT1/gnbsyvrTV4i5uR9M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QW2nXSCd4IAv5cpFFfR+yU+JTXppdWJ5GeJfy4bIqML3LUCa+ju2Lt21YXr/ffAra62dpxQVwxR7gsFa8TQKnSjqI1/qClE2+pTEeQ2xNzEZSmy5vR9wbdyaj+XUzHr+fVwB9+Fo+qGO6ynUOLUBNkw0Cr+rUBEVJVEWm4dZgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5KYmKbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5KYmKbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE7E1F000E9;
	Wed, 12 Aug 2026 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786541485;
	bh=FGCvEgoYFbb+RqbPsxNvhrDGdl/2MCrgutaZMspXl0Y=;
	h=From:Subject:Date:To:Cc;
	b=I5KYmKbZPNDRWjAi5eqWjk71WYzUpliMGCzTTqETB0DpV7KGgpMXR8v3jhvnACarp
	 SI2paNES7dLDqKHYMT3PnCFXxYAgkxXgmlAbnPQ0ku10X3u3cvvv94u1OdVXV84Dn4
	 K0jNkPaV0MV3c4Ov4kU975NyBJUdnrgUAXI4REcDkQxM5RbYJuBsdX/BS4o5exagXT
	 RvRuoSTHVYtdqmr8/jB4WHvY0Qn5PbR/kG6T2K20gTh7mnDKLUGNDLqVfNi2jauTTc
	 Y1+lfBDurQrQaL68dc0mf8lP4yrF2MEqdnskPzQF1KlFdQXSDB/hc9XGGCceEZZkuQ
	 s8i20t3koP0eA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/2] KVM: arm64: Fix spurious warn, null ptr deref on S2
 teardown race
Date: Wed, 12 Aug 2026 14:31:19 +0100
Message-Id: <20260812-kvm-arm-nested-virt-fix-v1-0-4ad883f1b6a5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X27ELWgtr+SvEQ9amLmJZNCAXx3
 xs8zsDMSRGmiPSqTjJkjfoJBaSuaNp8WME6F6bGNa3rRXjPB3s7OCAmzJzVEi/6Y/cQPP0oI/q
 OSv01FH2f38N1/QG1Qt1MaQAAAA==
X-Change-ID: 20260811-kvm-arm-nested-virt-fix-031e9ab1be87
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Jintack Lim <jintack.lim@linaro.org>, 
 Christoffer Dall <christoffer.dall@linaro.org>, 
 Christoffer Dall <christoffer.dall@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205; i=ljs@kernel.org;
 h=from:subject:message-id; bh=tpLslcTY/jbcjdNO9fIepj0cT1/gnbsyvrTV4i5uR9M=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJqSle+qKhom6e/2vUq453bLztSHZp1KtZrG5dv8stnW
 7R7ccO7jlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExkvjYjw1ozx2jzeS01prZT
 v/oIrzl2OexH4w6FT1fM78i/WaScuZeRoclTjiE+3UDpu12F5J7AHfYP7xS2qjfEsv+Z4XTy945
 iVgA=
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
in kvm_nested_s2_unmap().

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (2):
      KVM: arm64: Fix spurious warning for benign stage 2 teardown race
      KVM: arm64: nv: Fix null ptr deref in kvm_nested_s2_unmap() on S2 teardown

 arch/arm64/kvm/mmu.c    | 10 ++++++++--
 arch/arm64/kvm/nested.c |  6 +++++-
 2 files changed, 13 insertions(+), 3 deletions(-)
---
base-commit: ed8384586cf9937df7ed018fcfc625b85e0ece81
change-id: 20260811-kvm-arm-nested-virt-fix-031e9ab1be87

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

