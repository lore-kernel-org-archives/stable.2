Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4248E0C0
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395136; cv=none; b=FDuLIgfV+p9gOPONLQuM9iexyAlMeCq1Rgo1ETFyYfWOmZOc9dKXDgaaqOoltrnyFeyqrUlRydO29nznVRZwssU0RKSoQ1f47d9UTjRiWnt/1qVAp+6h6lGgauMFlc6a7LOchN09Upb85+vcJTkF7ERVvQw4KjbeT1isfOr2Px0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395136; c=relaxed/simple;
	bh=IZkEtTUfskSomLMipc9Ku+crMNuoH+WFlzgZ10E2GeM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=IIH8jqOgUbLs9Sy8WtzMDJlaXI9ws1qs1VR/uPMMGKNNv6pO2KJ9ronugwNZw0VHdyyVcc4s1XQMVpdXFh3vYulCEs2qbnGSwKzjsaTVV+Wj3FJj6+lnj6kM6O43FeAcaAQ2eLD3aqUMQAyvIOtDTKzmCn13QaBXCQ2F9T12QNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UbS1bgLz; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UbS1bgLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792395102; bh=IdiSV7QWld7YiHkNrnxkbOYb29Vk9yxXrLeq//wBYhk=;
	h=From:To:Cc:Subject:Date;
	b=UbS1bgLz6xXTssK5mhFqfJLOi+nnivoqWF8d8UcMSFWf6WLhW9D94QDCq+Hmp7ya8
	 +K0ikCLYggV9C/22yxOu6JaMoN+uYMbljnJp7EnEbhqReDLRCug0iB7Xv9/kNem9S3
	 k+4+qa/W/oOV+OZ142SCHg1kSJR3/O7d7QDEgnL8=
Received: from localhost.localdomain ([123.60.231.41])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 798A5494; Mon, 19 Oct 2026 15:30:24 +0800
X-QQ-mid: xmsmtpt1792395024tmfhuyqfr
Message-ID: <tencent_7F47B27F7FE811035796A0AFC61993769409@qq.com>
X-QQ-XMAILINFO: MyzM/wvJS/65bfvV/QZT3tO6rT0VUHXh/BSYKCkt4Ptr0+7Sjy9GbptKAMVeWt
	 Jn/OTO6LuY8t4vpaDcNRKCMT/k6IKZm2dZIP0S2P12Kx9LjQJJehZxUcU1z8tiREjT6uJb++rA/e
	 ryjgROc5wIn8iQAltQyI/zdDrRFAXMYg+5lt8KbSrYowyRqCzqGkZndFeToYqg1T2Zbs7tQJA9AZ
	 /akQ1aTboj+HOAZOt2I9sB2MZExdMs84mXWJB+GqgvkAFy2s69+9TEC2zYS7uuZnLS7rEQBdibaX
	 FspbC4iqwtTPjL4dlsCOI2iscCy3rxSPUhN+mGx1FWQzTQ630BOBBpnAgW5+n9AbG5B1YVCnfRvn
	 kZ3YD6gHFAY891gwi3Vpp40p7t2CZBJb0Fro0bCqctQPm83osntjHkfHsNoanv8GoDrNBJisY4j9
	 DK0GDEB2tnxcmub5wWmN+GJgmsp8OtzZ/0TWM0mOHN6cXUhV+3dD7F1q5XYNvK2FYu/8JCpcmrWe
	 4xQUJstkLP6y9W8SRtLtmr9ubZ+nhYW+6+DkJffZ5DtFxzU2wdVilxUW6UETAJOkNuGlxIxa9X+l
	 CqKn8tHXuejAJkSh0ieYdhJOAJaYXZrIsOCYdf/UYtdb+uJd/MJ/GTkM9KIDvchAgfIR7AgGBqXo
	 aQsUDM/hMUMg6rBQ95KdeVTZ//atpocbhjgmsrCjWj/ZFYz/D/M4WUwEdhxNwg8HMUctR1OF9S2F
	 UzG69CuQMWEIHWfgwYbBlzyKXEiOyK/pXqipIeRGwwL/GxVqRkJ+Vr76HP2upj113gr4Rn1e0qvw
	 ae2/97sIYFpWDSq5JWNNbXVlbLw10hOiX9zh3QRENNFzWFc2E948cSdZeCFTbXUtEv/h194PDMAx
	 09U4SmNQeFSPjV53x+Wi+LHlzcJwPt3seS9eq6hNnpn//xlvezlddB9sHwaLtKLcall+4TMQZApW
	 gNCCsOlEplCZdBXs31v+ZO2d8HZMN+m8OLT04RZNEElbnKR9IOk5GcaVwz10/2/KYo+1zECJLahQ
	 cosIdPxc4L8nHBf7Ae
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Absoler <absoler@qq.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.linux.dev,
	Zhang Kunbo <absoler@qq.com>
Subject: [PATCH] arm64/cpufeature: Fix malformed SME I8I32 hwcap entry
Date: Mon, 19 Oct 2026 15:23:39 +0800
X-OQ-MSGID: <20261019072339.384264-1-absoler@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Kunbo <absoler@qq.com>

During the backport of a75ad2fc76a2 ("arm64: Filter out SME hwcaps when
FEAT_SME isn't implemented") to v6.6, the I8I32 hwcap entry was mangled
into:

	HWCAP_CAP(ID_MATCH_ID(has_sme_feature, AA64SMFR0_EL1, I8I32, IMP,
			      CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),

which uses the wrong macro (HWCAP_CAP() instead of
HWCAP_CAP_MATCH_ID()), references a nonexistent ID_MATCH_ID, drops the
ID_ prefix from the register name, and leaves the argument list
unterminated, breaking the build as soon as CONFIG_ARM64_SME is
selected:

  arch/arm64/kernel/cpufeature.c:2899:2: error: unterminated argument list invoking macro "HWCAP_CAP"

The error has gone unnoticed because the entry sits inside
CONFIG_ARM64_SME, and SME has depended on BROKEN since it was disabled
in v6.6.61, so this code has never been built. It breaks the build for
anyone re-enabling SME on top of 6.6.y, e.g. distros backporting the
upstream SME fixes.

Fix it to use HWCAP_CAP_MATCH_ID() with the ID_AA64SMFR0_EL1 register,
matching the surrounding SME hwcap entries and the backports of the
same change to 6.12.y and 6.15.y.

Mainline is not affected; this was introduced by the v6.6 backport.

Fixes: d5024dc5e644 ("arm64: Filter out SME hwcaps when FEAT_SME isn't implemented")
Signed-off-by: Zhang Kunbo <absoler@qq.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5db25bfb854f..ab60dc4dd9e7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2896,7 +2896,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I16I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I32),
 	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
 	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F16F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
-	HWCAP_CAP(ID_MATCH_ID(has_sme_feature, AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
 	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
 	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, B16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
 	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, BI32I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
-- 
2.54.0

