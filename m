Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8D2EB5A6;
	Mon, 10 Aug 2026 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394242; cv=pass; b=LT0VY5hbqzZ6gMC5qig8F/LDK4Eg843f9Xp0J9Jm5KRVbxeIGro/2D29NfZ/w9jmEas9K6HIb+/phKXUZ2J+N4aV3yaPlDWlb2W2fDEoMJxsA8sEzzc+WkLeeIgo3IN5ZZF4D5BFW5e7oMEwhvCWWFrregvahbPkmsilj0YoZ7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394242; c=relaxed/simple;
	bh=gDCcjjQPSPrfCITkBdnkAf2KAhC+cg9NRTdkJClMC7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RM9zW0kn45UTpCdgaxvwdDYjvNES8t0Axnm735H6DJiLYwPAKD2FKpLNE+aHiCPRD4eQFDfLtBg8srFWqAeQ2F3SCpwqLY4+7P0klGd4QiYphqaI+Fpgb6JxcG5ENXVIi5wR0RGhAaMcKUqZhwHOLA9/Agz6shRyeeD5id6spp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=cdtU8R1a; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="cdtU8R1a"
ARC-Seal: i=1; a=rsa-sha256; t=1786394212; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cdyzt8j1+tGa26yNDpomQwbJz/7Sz2O2xrBFUR7K+lUsTxP7h9kUFqwjFNJbptc7Z8cQB3xofUP/88GR7F+U9y43ta0PECYOKu2mqSE+NJjBEKEC8Vc/2Ufc6e6XL3j+zWodTJ1BJRJBGzKCugulYjJ+tDnViMjPn7Jd2H4LXTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786394212; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JQI4sci6C5ySjBtkfm23T++3K82h9G4druSy5050Bkk=; 
	b=nPUtQrNiM5IzOYNEz5IzsXysJfQKvJC6OGg7yciR98Ps3fG8NlZUaxgfVdE8VXGrqte6jDXs5PnxkaGTwEj9fyShNGQLoImwW/sfo3D47HrAkZRFVUFYHK2TA1dpMY+0x8GhkHXaYLk57AYfsobDEr0ds/zx6qQPgzngbOK9PmI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786394212;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=JQI4sci6C5ySjBtkfm23T++3K82h9G4druSy5050Bkk=;
	b=cdtU8R1a+cJzJ2HD58ToHt4ABAjElfBs18dspaXxxwY8hnnGsv1bJbovVx67Y0Qz
	LyKmpQ5Q8ccGRVpQR1HNuzYUv/VjrYQfHI+p3ujf/fX4np8qjX5LSm3Q5/BZzGi+DKP
	dRVf2cSiUNw3aKN3Eu4JIpmoy5P49hagJCDHvhsiFnGwBt3YLJYnXZAyDHdOanR9khl
	4bFYff2JKF6Tx68z1ubcwvfpeG5v779ZfCVl57f0RSIVbQd/VBh/6NOVoMwqP9tCONQ
	VqkfAQrJM4/Zy73Of1+1kNjK56GykQb9BYi+oUoKWQ4nur+ptjh1JwJ+kj+IZyLy836
	vT2bcc1PTg==
Received: by mx.zohomail.com with SMTPS id 1786394210060129.50410084147654;
	Mon, 10 Aug 2026 13:36:50 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Tue, 11 Aug 2026 04:36:18 +0800
Subject: [PATCH 1/2] iommu/amd: Do not request ACS when IOMMU is not going
 to be initialized
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-amd-iommu-fix-acs-v1-1-d64e2172408d@rong.moe>
References: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
In-Reply-To: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
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
This doesn't change the IOMMU initialization/failure sequence since the
Fixes: commit.

Fixes: 9f81ca8d1fd6 ("iommu/amd: Don't call early_amd_iommu_init() when AMD IOMMU is disabled")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/iommu/amd/init.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e7d7b4cb9337..31fce7c8f530 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3428,6 +3428,8 @@ static void amd_iommu_apply_erratum_snp(void)
 #endif
 }
 
+static bool amd_iommu_sme_check(void);
+
 /****************************************************************************
  *
  * AMD IOMMU Initialization State Machine
@@ -3440,7 +3442,13 @@ static int __init state_next(void)
 
 	switch (init_state) {
 	case IOMMU_START_STATE:
-		if (!detect_ivrs()) {
+		if (no_iommu || amd_iommu_disabled) {
+			init_state	= IOMMU_CMDLINE_DISABLED;
+			ret		= -EINVAL;
+		} else if ((iommu_detected && !gart_iommu_aperture) || !amd_iommu_sme_check()) {
+			init_state	= IOMMU_INIT_ERROR;
+			ret		= -EINVAL;
+		} else if (!detect_ivrs()) {
 			init_state	= IOMMU_NOT_FOUND;
 			ret		= -ENODEV;
 		} else {
@@ -3448,13 +3456,8 @@ static int __init state_next(void)
 		}
 		break;
 	case IOMMU_IVRS_DETECTED:
-		if (amd_iommu_disabled) {
-			init_state = IOMMU_CMDLINE_DISABLED;
-			ret = -EINVAL;
-		} else {
-			ret = early_amd_iommu_init();
-			init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
-		}
+		ret = early_amd_iommu_init();
+		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		break;
 	case IOMMU_ACPI_FINISHED:
 		early_enable_iommus();
@@ -3653,12 +3656,6 @@ void __init amd_iommu_detect(void)
 {
 	int ret;
 
-	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
-		goto disable_snp;
-
-	if (!amd_iommu_sme_check())
-		goto disable_snp;
-
 	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
 	if (ret)
 		goto disable_snp;

-- 
2.55.0

