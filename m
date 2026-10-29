Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313455;
	b=CTQa+Ko1wGp6MWbTypOCQDwi6gdVCroKe6i4qS8G2tQTLITr5qfvF1bV641WEsPPmTWQ
	 6TbiXgll3moUS5qWmH12ylllH3kc5qrLK+mrmURBmNo9vFEY4xGsP9sMIdoK6ZWvA7Lg3
	 wvilj615zbIBjF+pq48aY5zF2KMXPQS5oPITh0rdXUpVNjLETo+Q0SwcU3MDMgyCIO4uk
	 +KSyb0qptvcV/wobQicN17RjE9zynTFbUWAdaSjpsMjxIhIwSSrEKyYe1Id0J6gXtl0sQ
	 uOPYxieeId4oN6x7sS3d6CdnqrnKgO+RRtN57IKmLP3soqWPOujmKuaCUb+6VuIZKOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313455;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N126slE5CyqhabSU1A4aYnWZDujVjAAleTRTMYtkvxc=;
	b=kZdohmX73T8WGW9A8sunjw2G2cuD5iRLpB61M708mX7HQ7ijhSdE+LdCNKzGQ1tWeAVf
	 CpbiildAWBV+H+HV67ur69s6Z1PcyPKKZOggOnk2KE0i5WHC1ngbXD8Pa9HWVjZvK/Tjc
	 VhvfavYBK+Auo8SJEPqX9GePW7wDo3VBlZgf6O8CK0LZzjMV23TAYDKj9I1tJJM2JWnUy
	 h4ot0Ky2a9sEN9GYKn9Qb5Va1x2Knij70S4HjwMEwTQvcfndVqqNWWCavAozDxpK4BSUd
	 Vs8G+dfjiM7nX0A26luNKlvsTQW9GHXi9J+XvhJrBTCj4GuAujQBjMo4yDTvjb2UEDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aC79kb/s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE41606A31D;
	Thu, 29 Oct 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aC79kb/s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9A61F031EC;
	Thu, 29 Oct 2026 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793313455;
	bh=N126slE5CyqhabSU1A4aYnWZDujVjAAleTRTMYtkvxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aC79kb/sqNkf5PEpPdR5iR4VUPcIFwj+qlblsZtctKLn22Ne/g+vM/XxblhA2u2tt
	 nTAeoEPoz+TkqNP9w/LeV20IW7DU8a33bswGMQDW34ixu8lPg7F2Z8vqrsYpSxqb2B
	 3O4VdE7STOfVLt8bIfEm2gobZ6N8bD0Ro48LRb/50agvliRU9a1JP9GuhdNNQXOr+7
	 Js3bM7ODmHcQSksi2SNwgY+UX/INwpqlwHCv3D2bdU4pu5G/w+NwNcPPVaEkpP1yxT
	 44uK6mB79z8OYnnTRSi7eOSGrXXmFhzSCHJfV8jnG+EOkv5FF+BfG2E7sAplpyZGnO
	 E51B/uVLsgKMQ==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	stable@vger.kernel.org,
	Oliver Upton <oupton@kernel.org>
Subject: [PATCH v3 1/5] KVM: arm64: nv: Don't advertise FEAT_LPA2 for guest stage-1
Date: Thu, 29 Oct 2026 15:37:28 -0700
Message-ID: <20261029223732.103785-2-oupton@kernel.org>
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

From: Wei-Lin Chang <weilin.chang@arm.com>

There is no FEAT_LPA2 support for NV guests as of now, but we missed
limiting it for the non-stage-2 granule size fields (TGRAN4, TGRAN16) in
ID_AA64MMFR0_EL1. Add the sanitisation.

Fixes: 9f75b6d447d7 ("KVM: arm64: nv: Filter out unsupported features from ID regs")
Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/nested.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 4d83281a7a28..cd0dabcf3f81 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1875,6 +1875,17 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
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
2.47.3

