Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359A4A7C83;
	Thu, 17 Sep 2026 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789681368; cv=none; b=ZGAwEwoY/DSi/OHJcbV+WPXs9oEf4Tir8c0ca0vfyC2yBjuyRUWEQirpoLWZo6x/aEbx5YIobPnxNk3lAPeO2jsEpxn6PMZlsqoJ73imWXalliIRwIb8D6lQNtdggGt1NLX+rcmVLGVv/+bl6r0/uJgj0g7eN9LbcB7ONLivgko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789681368; c=relaxed/simple;
	bh=kUZhUVbts+ndC39LiYRFJ2AH2v71NBpBnvqeaYZgEFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGhnDKVS5kslF/8t4nPydFMdWwlWjq2R8EGhpIymN2FTtNIWTxVaVx/NdXp+vEcO8BtUZvYj2DLlRXXIVyXQTiJJD4uHC5ymcpx5hrwbnRGJFVCyVABoWQWSh1rCImMoe5jwWajImO0KRPNB/nXbPE4T4XKKviMrhH0/pTG2l5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IkH+u8se; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IkH+u8se"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01A6C1596;
	Thu, 17 Sep 2026 14:42:40 -0700 (PDT)
Received: from workstation-e142269.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 429C43F7B4;
	Thu, 17 Sep 2026 14:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789681363; bh=kUZhUVbts+ndC39LiYRFJ2AH2v71NBpBnvqeaYZgEFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IkH+u8seP17fq+zdfbRfFgZAD2GQ4dWL+zSuTnoa+he3GN5+gyMfZ9VB1WpbShiC4
	 VoxLtkoAUg7GXqndsVgmbVOip0wMw3B2cy0EyLUeIs+4p1bOulE8IWZ4jO7zhJVvfZ
	 wRBIzpHB33TB9mYB9XKOThpWiXQPUIopn20KLDhA=
From: Wei-Lin Chang <weilin.chang@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	James Clark <james.clark@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Thomas Huth <thuth@redhat.com>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] KVM: arm64: nv: Don't advertise FEAT_LPA2 for guest stage-1
Date: Thu, 17 Sep 2026 22:42:11 +0100
Message-ID: <20260917214215.74135-2-weilin.chang@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917214215.74135-1-weilin.chang@arm.com>
References: <20260917214215.74135-1-weilin.chang@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no FEAT_LPA2 support for NV guests as of now, but we missed
limiting it for the non-stage-2 granule size fields (TGRAN4, TGRAN16) in
ID_AA64MMFR0_EL1. Add the sanitisation.

Fixes: 9f75b6d447d7 ("KVM: arm64: nv: Filter out unsupported features from ID regs")
Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/nested.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 3c4fc566eafc..4a860904c1ce 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1731,6 +1731,17 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
 		/* Hide CNTPOFF if present */
 		val = ID_REG_LIMIT_FIELD_ENUM(val, ID_AA64MMFR0_EL1, ECV, IMP);
 
+		/* NV does not support FEAT_LPA2. */
+		if (SYS_FIELD_GET(ID_AA64MMFR0_EL1, TGRAN4, val) == ID_AA64MMFR0_EL1_TGRAN4_52_BIT) {
+			val &= ~ID_AA64MMFR0_EL1_TGRAN4;
+			val |= SYS_FIELD_PREP_ENUM(ID_AA64MMFR0_EL1, TGRAN4, IMP);
+		}
+
+		if (SYS_FIELD_GET(ID_AA64MMFR0_EL1, TGRAN16, val) == ID_AA64MMFR0_EL1_TGRAN16_52_BIT) {
+			val &= ~ID_AA64MMFR0_EL1_TGRAN16;
+			val |= SYS_FIELD_PREP_ENUM(ID_AA64MMFR0_EL1, TGRAN16, IMP);
+		}
+
 		/* Disallow unsupported S2 page sizes */
 		switch (PAGE_SIZE) {
 		case SZ_64K:
-- 
2.43.0

