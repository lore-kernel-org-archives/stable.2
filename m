Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313456;
	b=5oB1odr46Q6+/8a9cLvPY7vxoQiqqK6Uziedh659WpAMiL3rRX/wXgiVKsskdleAK3X6
	 L52TsbRXkoO6HBRJ3oTQzfxvoISicSz4Y7aXlnXCGDDJkT/ow/KjgMoJqSxflMzHZlSE7
	 ZlKnc+ro/3pKnuUHdtVZ2lh7Ydrbwo3gafcOnbXrQrUcU53M0Fp0zKx6Vq+/UVvAF324y
	 GPhNvV8FuFzseq2cwtBJ0APDj47dHyPvBg2xzIyHePq+2qsuHr+h3QUhWbeuUv/yYtrba
	 h+dpoa+73vFSLnyT6fOpr1I6YuOuYuVrBafuAusvICXDRRQlKxRoXPN+Y6UrjPgGXvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313456;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2Zw8Q3cSC7TOlg7gGunab9fut1Ef51A+q3QX2pcDulE=;
	b=iYInixI1ZVsWZ/HtUQJD/F/v4KtcAbP8K6qS7pSEn+2wXtR3HWTHEdcdIh4Uq+/+365u
	 51SSOE1cqMtPsj3zTdFURaWvJHf7MazxiMvscI/eItnfcZzBIrIuTMalOy/kQ+R+8kMJK
	 lVg1d84Y5ACIu5zhhBVHCSGIWUO6/hOgxxJchQVu6PBSfort0tQpMH27f4p5MIJXeyrOR
	 c6BAtQnNExbuKhWq0VeCvsMGiMi1AXbmD3zMfaat+fHFei9t3wpsop3qKNhffAUjRdyWe
	 8xVPFukSiPBdPNLNdbFiYwb7AgunWp3veCcp9bXoM3RED4aVA4ZmERfOcsQz30D3Nzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqfEvkcu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7B606A33A;
	Thu, 29 Oct 2026 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqfEvkcu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EB01F031F5;
	Thu, 29 Oct 2026 22:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313456;
	bh=2Zw8Q3cSC7TOlg7gGunab9fut1Ef51A+q3QX2pcDulE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AqfEvkcuDU3/YLVs6SemPBR84f1BgtTjdDumH8ILS8bQoewwr/iLYnptpFo+2YDKh
	 phYa45Ol6Ka6ivi/mF85139+XESLz9doshbMbLYYFvOgz3YfaV/mfyKA6zPSbU1+UN
	 rmcMYCjbz+smvWq3q3xePuUlgLQh8nMp0AnOarwPVG14AWAqM2klx/dlRzn3sY+Clz
	 H7eWemBtOX6YvHTk4Vjf/vdIOVqmHxWcLji+Na+Nctil1+zrrjoTc3ekwJZB878SVK
	 G4MLq7RaWt05s1cV5Z5UkJMzP+BDq49RBRzK/b6eZ/uLEs2PXBEiZN699O6avBZO0A
	 vk6/sQBjObuuQ==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 5/5] KVM: arm64: nv: Correctly compute the effective TCR_EL1 for nVHE TCR_EL2
Date: Thu, 29 Oct 2026 15:37:32 -0700
Message-ID: <20261029223732.103785-6-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029223732.103785-1-oupton@kernel.org>
References: <20261029223732.103785-1-oupton@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It would appear that nVHE hypervisor support has a few warts which
shouldn't come as a surprise. Several fields in TCR_EL2 for features
supported in the VM (TCR_EL2.HA for example) are not correctly
propagated to the effective value of TCR_EL1.

Forward fields in bulk from nVHE TCR_EL2 to the effective TCR_EL1,
relying on config-based sanitisation to enforce the RESx behavior of
unsupported features. Deal with the slightly annoying case where the
E2H==0 bitfield names are not annotated by TTBR like they are in E2H==1.

Cc: stable@vger.kernel.org # v6.18+
Fixes: d5bbb76f4474 ("KVM: arm64: nv: Expose hardware access flag management to NV guests")
Fixes: 3606e0b2e462 ("KVM: arm64: nv: Add non-VHE-EL2->EL1 translation helpers")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h | 38 ++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 0f899addafa8..27ec73da02c6 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -20,16 +20,36 @@ static inline u64 tcr_el2_ps_to_tcr_el1_ips(u64 tcr_el2)
 	return (u64)FIELD_GET(TCR_EL2_PS_MASK, tcr_el2) << TCR_IPS_SHIFT;
 }
 
-static inline u64 translate_tcr_el2_to_tcr_el1(u64 tcr)
+#define __xlate_tcr_nvhe_to_vhe(nfld, vfld, nvhe, vhe)				\
+	FIELD_MODIFY(VHE_TCR_EL2_##vfld, vhe, FIELD_GET(TCR_EL2_##nfld, *(nvhe)))
+
+#define __xlate_tcr_nvhe_to_vhe_field(fld, nvhe, vhe)				\
+	__xlate_tcr_nvhe_to_vhe(fld, fld, nvhe, vhe)
+
+static inline u64 translate_tcr_el2_to_tcr_el1(u64 nvhe)
 {
-	return TCR_EPD1_MASK |				/* disable TTBR1_EL1 */
-	       ((tcr & TCR_EL2_DS) ? TCR_DS : 0) |
-	       ((tcr & TCR_EL2_TBI) ? TCR_TBI0 : 0) |
-	       tcr_el2_ps_to_tcr_el1_ips(tcr) |
-	       (tcr & TCR_EL2_TG0_MASK) |
-	       (tcr & TCR_EL2_ORGN0_MASK) |
-	       (tcr & TCR_EL2_IRGN0_MASK) |
-	       (tcr & TCR_EL2_T0SZ_MASK);
+	u64 vhe = VHE_TCR_EL2_EPD1 |			/* disable TTBR1_EL1 */
+		  tcr_el2_ps_to_tcr_el1_ips(nvhe);
+
+	__xlate_tcr_nvhe_to_vhe(MTX,	MTX0,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe(TCMA,	TCMA0,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe(TBID,	TBID0,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe(HWU62,	HWU062,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe(HWU61,	HWU061,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe(HWU60,	HWU060,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe(HWU59,	HWU059,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe(HPD,	HPD0,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe(TBI,	TBI0,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe_field(	DS,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe_field(	HA,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe_field(	HD,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe_field(	TG0,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe_field(	SH0,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe_field(	ORGN0,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe_field(	IRGN0,	&nvhe,	&vhe);
+	__xlate_tcr_nvhe_to_vhe_field(	T0SZ,	&nvhe,	&vhe);
+
+	return vhe;
 }
 
 static inline u64 translate_cptr_el2_to_cpacr_el1(u64 cptr_el2)
-- 
2.47.3

