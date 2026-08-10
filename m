Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB0442FAF;
	Mon, 10 Aug 2026 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394226; cv=pass; b=AwjHO/4/EANJJwjYIVn1JugZxeJdgEYGY/PHTMsFMfCYzaaMx0Cn9QK5UGUDp2aB6SpTHMpqSLB4R9Df1uqWh+xj+xu9FlItHExEqfZ9XLQ4AAbuamkyYALSa9XkuWdva7gJrVYDdgh2s3rMLHZ4+6HVWGM5yC0pMRVyT3fOWeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394226; c=relaxed/simple;
	bh=mBdORqqK8qiSxAzQcfgB9YUtYCZUye3tKk2aIMcNO6Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=riMu6yvP1Hvk2rc4D2hpyelPpwm4grfm3hbwLuqxb5nPYB+sItVp+75LY2doZZRMxTL2tQlW5qBR1mIcDBwUKiWhyOCuztytqRnM85ZcF1QyvMMZQlSO2gPLD0n3HbRe27iJCbI1D7qipGBlvjGNZ2EFc0dmUv5BLh9dc3/H+Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=TkcOxabG; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="TkcOxabG"
ARC-Seal: i=1; a=rsa-sha256; t=1786394210; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O4Ct0WmCYgu91pcdMZcEi9q7nua2iIWyOOU86mvxTRCqcyUvh3g1RA7+L7+VIL4yPRcIvOym9tIhEoN18d5nYlR8IjI4OkhEBZnke8oXFVtfxoMn3sPvrcTRi9DeA9IHb4YEC0MHMv9hviPxkBs8a5XiXgJmOnGK9ikOa44Lf8E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786394210; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oUi+iKFDxtJBsUyVPmkZnUsmIG1QL+sKC/koafNE6hY=; 
	b=BtEVIql47lcG+9vIE7w1p1P1Gl4bxzvFJPFS4PR08W8SyEc/2mHJJwFoxUn78R9PAH1n1qAt8AVjzo+vfP8RpWNfsEfs39m+gTWHonhuop3ULgOfgF1d7dU2uztfQo1TT4RtB+Uc0djV/TognSXQ3oiS1axtyEZDmBZrwes0Br4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786394210;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=oUi+iKFDxtJBsUyVPmkZnUsmIG1QL+sKC/koafNE6hY=;
	b=TkcOxabGSK8AnV5yFdlPyjA/UG4WarJIEWpyRA9tGHWUPrlmvBhvNvsxWeZRJWAT
	wo0fuNFVkK0FduQUHRcqnAzXvw6sZeonDxXc/AEDpL8CwnZX0l5BpP8FLRrgZikNtIW
	ZConJZuFEE2R4HjhbrWPpAN4ZFzQ0joT4nn+JYrBqC1JfSt8b0tnG8wZ4rKSjimFhfl
	2ETsFnOkcUulpZI55YpD6foOeuM2G7fPkBOFeA9pO7RlCSgWUqiHvrRV+L57aEl9Xp1
	3vsYkyDTzWh6aZCMPYVXwRApl5K8xfG68BJFoqhD07x1Pjn9Gpwqd85CGcRJ2aYhnMq
	i/KVbmWXeQ==
Received: by mx.zohomail.com with SMTPS id 1786394206639768.218963072738;
	Mon, 10 Aug 2026 13:36:46 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH 0/2] iommu/amd: Do not request ACS when IOMMU is not going
 to be initialized
Date: Tue, 11 Aug 2026 04:36:17 +0800
Message-Id: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAyF4VcZuV7AUoXiq8gusibVCN2k2cag7
 N2t7vLjcP4KJkXF4N5VKLKp6Tw1uL6D+KLpKajcDHwLfEneIWVGnXNeMemOFA1D8nylkYILHtr
 vU6RN/+ZjOG3r+Ja4/EJwHF+8YA04dQAAAA==
X-Change-ID: d58d0f31-amd-iommu-fix-acs-8f3d4aba8183
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, 
 Huang Rui <ray.huang@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-2f6f2
X-ZohoMailClient: External

The AMD IOMMU Initialization State Machine has the following state
transition diagram (only the very first states are showed, and the
`IOMMU_' prefix is omitted):

   START_STATE
        |
        v
[0] detect_ivrs() --> NOT_FOUND
        | ok
        v
  IVRS_DETECTED
        |
        v
[1] amd_iommu_disabled? (amd_iommu=off) --> IOMMU_CMDLINE_DISABLED
        | no
        v
[2] early_amd_iommu_init()
        |
        +-- [3] amd_iommu_detected? (!iommu=off && ...) -+
        | yes                                            |   
        +-- ... --> IOMMU_INIT_ERROR <-------------------+
        | ok
        v
IOMMU_ACPI_FINISHED
        |
        v
       ...

[0] always calls pci_request_acs() as long as there's a valid IVRS table
and no Stoney Ridge graphics. This is not optimal as ACS is not required
in an [amd_]iommu=off boot.

In a normal boot, ACS is requested due to amd_iommu_detect() requesting
IVRS_DETECTED.

    pci_request_acs+0x9/0x18
    iommu_go_to_state+0x106/0x1a20
    amd_iommu_detect+0x1c/0x50
    pci_iommu_alloc+0x26/0x40
    mm_core_init+0xa/0x120
    start_kernel+0x527/0x7a0
    x86_64_start_reservations+0x24/0x30
    x86_64_start_kernel+0xd1/0xe0
    common_startup_64+0x13e/0x158

This is intended to ensure ACS is requested before the PCI core
initialization, or else a !CONFIG_IRQ_REMAP, nointremap or intremap=off
boot would be broken.

However, in an amd_iommu=off boot, the state machine still requests ACS
at the exact same time, as amd_iommu_detect() has nothing to do with
amd_iommu_disabled.

Even worse, in an iommu=off boot, though amd_iommu_detect() bails out
early, ACS is still requested due to amd_iommu_prepare() requesting
IOMMU_ACPI_FINISHED, which is called by irq_remapping_prepare() thanks
to CONFIG_X86_LOCAL_APIC (always set on X86_64) and CONFIG_IRQ_REMAP
(enabled by defconfig), unless nointremap or intremap=off is also passed
to cmdline.

    pci_request_acs+0x9/0x18
    iommu_go_to_state+0x106/0x1a20
    amd_iommu_prepare+0x15/0x40
    irq_remapping_prepare+0x43/0x60
    enable_IR_x2apic+0x22/0x190
    x86_64_probe_apic+0xa/0x50
    apic_intr_mode_init+0x70/0xd0
    x86_late_time_init+0x28/0x40
    start_kernel+0x6f9/0x7a0
    ...

In both cases, [2] is still gated due to the [1] or [3] check, so that
IOMMU can be disabled per cmdline.

Technically, it makes no sense to detect IVRS at all in an
[amd_]iommu=off boot or if IOMMU is not supported due to platform
settings. This is probably why amd_iommu_detect() bails out before
requesting IVRS_DETECTED. Apparently only bailing out there is not
sufficient, and the bailing-out paths should really have been parts of
the state machine.

Fix it by moving the bailing-out paths and [1] to the right place in the
state machine (i.e., before [0]), and always requesting IVRS_DETECTED in
amd_iommu_detect() to initialize the state machine early and properly.
This doesn't change the IOMMU initialization/failure sequence since
commit 9f81ca8d1fd6 ("iommu/amd: Don't call early_amd_iommu_init() when
AMD IOMMU is disabled").

Signed-off-by: Rong Zhang <i@rong.moe>
---
Rong Zhang (2):
      iommu/amd: Do not request ACS when IOMMU is not going to be initialized
      iommu/amd: Remove ad-hoc checks that are never true

 drivers/iommu/amd/init.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: d58d0f31-amd-iommu-fix-acs-8f3d4aba8183

Thanks,
Rong

