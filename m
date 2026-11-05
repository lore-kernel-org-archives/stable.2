Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793917732;
	b=zYP1pSkhnZA4JK8K0hB/FpkukprIRBPlgon4e9RsLo+9S2cI94gpp2fYwrDhoPMwT/xj
	 WU7xf/8M/uDgimO4JiqB7VmnFu3BXhjSVCgiD0bGaDdcFPy3uD1whmehaGEHW66/OluAG
	 daBzIyO2edpYUC4TpYcCMn3wJKwe4Hd0ep47svdkmRm53x5OODDtXCX0zeaxs+hEhuhFd
	 8tDxGjh2ChDsRFJr41LV+i/j8F4NrFVsVC57LCcNo85T5zSZSaq4VhngRqjzbtOBMSgYM
	 lA2n5JWM+wRuVMKggplZu2btc2ljHL074+2MCfyzzysf+nYPE5KaS0rAjuTT/2lJ8xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917732;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=fa9CP0gkzkemp29oqw3QTLDptskJjZgFq/jn4p5Ch+g=;
	b=nFdphsBx9LudLLVC3Jj7xaurOIIfEGrJKnTazptk2jvW20ZbZBIbdY4Uvol3OrJyb9wQ
	 61/jS6K2bYtFa0xCH5ytNGOkUvY6bbuiYha6d2nQl5+HC2MsOm1EfocJs3HlUcbYzVVcg
	 b+Ec21M2QHTL5NFJnwh1ps0+Oxv9Fhu2H+c3PravK3xE2ch/1fPbHiTBzTxbEvzt7feAs
	 VbjFfEossTJQEuUdyhTVa3XyFVCuSh7akITq/1q0GSILPsQQtByjWAb8/l5TbSk/LBXI2
	 06WAad1UR5y2seDGFYMfJsY0NCDbv4N5bsKtp6dNLdmDmfXTL7YGMxgUzg4RK9lejLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUDW+kyc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3326606A329;
	Thu,  5 Nov 2026 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUDW+kyc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793917731;
	b=gzIwERIXum4ErveU/HXF9qBPB61I+rATv3nt4RqIQ3/96rjSsOIYEXssFh5RvajB1/bg
	 Dyd00B1HElTjIUEeFinCq6x5ZSY7yK/ApL0StIJjJQFyrPQWp1UzEAjS7pmw63avlW9L1
	 Mb6pZ3/d9uEDiMYZQBgeMyWa/1Nxm7voaaqjYE5UuJ9F4L9Z611mXp+XlfNpINBTpWBN9
	 x75iN79ogQUnznz2De9aoE+d+R53So31FIm45uEtX3Ga/eq2NJ2eYVo73x8sO7FYbf+7j
	 JVyB0dhjhUKI6oqX2nMY10eKyYtAHbeXLpUYsaw9J2q3YSXMCFNQ/pJKYOgW7duE36w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793917731;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=fa9CP0gkzkemp29oqw3QTLDptskJjZgFq/jn4p5Ch+g=;
	b=mrhJpEpFx93zwYkQySIYAIzkiOnuI85ohsunH2YvxCPUUQtQmDSHyCqudxxxKp4Ken77
	 C2tlvS0k+f6MWJPM9y3KPeHv0hHC+z08WCY/OYi3FtIEiAfdF3tf6U3i5q3ivwEWdprzk
	 dpAfK8yO+8wRT8PkQjuWRLO42neud4iWik+WBMSTMOknsOX4dNjRKqyVHuZaxPd8Rp4z2
	 DBr+dXAeH2p3g7JISsUfJ25qTL2H8WwfOAdRIxh9a0cQzI86Of1P40kWsrDwbSoQoQfQ6
	 4PvNNXfABRiBTnTYyPkdmi8VQaNx+/rkmwHhyk0zCEeChKHjgmvLrBYra/1YCfbSbGA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 633291F0089F;
	Thu,  5 Nov 2026 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793917731;
	bh=fa9CP0gkzkemp29oqw3QTLDptskJjZgFq/jn4p5Ch+g=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=JUDW+kyctfEVYw5n6iSnWvaHJ/BEpuqvJkBWfEMPQ/84lW6sUIn7sai66E2Kp+DMg
	 83gm+5wxceoNzxLhZfWUoKZpFpu+Gq9uw8odGau4rU99OXLJaRck66JhZ1yEGvYAdC
	 cShKyPpc4rXqrok1EGiHFIHVdEtp03LXsTQd/E4J9acQaDe5xJr+UYD75C71bN2iyM
	 TL42j9YVcY4m3Iua6z4n9V17ARvSOSf9dm000VptAB/489TNG6NPh0IzgBL0SeWaRP
	 BmPalaZNjzM3wIzWzwkCYhzxQ0Mzhtegh3q4bOrn8vtAU33hHIZz2AfwniE1PobwQd
	 5yklIqcgrKOrw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D20D145AB7;
	Thu,  5 Nov 2026 22:28:49 +0000 (UTC)
From: Xuheng Li via B4 Relay <devnull+xuheng.cs.columbia.edu@kernel.org>
Subject: [PATCH 0/3] KVM: arm64: Fix the hyp pool size on large machines,
 plus two hardening patches
Date: Thu, 05 Nov 2026 22:28:49 +0000
Message-Id: <20261105-hyp-pool-and-map-v1-0-756bb5d8e067@cs.columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBtohAq7SrSwnGqgVBSiiO6et
 HyL/x/InIQz9OqBxKdkCb6AKgXzZv3KKK4YdK1borrB7Y4YQ9jReoeHjTg13E1sLJEhKFlMvMj
 1L4fxfT/QCcPTYgAAAA==
X-Change-ID: 20261105-hyp-pool-and-map-b5e7be9a1191
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Xuheng Li <xuheng@cs.columbia.edu>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793917729; l=1436;
 i=xuheng@cs.columbia.edu; s=20261028; h=from:subject:message-id;
 bh=gQekyKtD9gqE06JU2ATVEtl2lW315Pl8Hsi4FhanixE=;
 b=4VskGk/nnncCTlFFpyv3yW8wjN2DEulU4CGjyKuATzAXd5ZtSIs40RgAyCWjcH90faDMofvwW
 QBW4Q1u4euzD8W3zGQ3dJBTFllXoV432+H67kpL3UW0tDIXSTi0QnmS
X-Developer-Key: i=xuheng@cs.columbia.edu; a=ed25519;
 pk=L1HVV+goqxYmEMO/OXakL6uf9isSpgk2QrLlFqyZ2Qs=
X-Endpoint-Received: by B4 Relay for xuheng@cs.columbia.edu/20261028 with
 auth_id=1349
X-Original-From: Xuheng Li <xuheng@cs.columbia.edu>
Reply-To: xuheng@cs.columbia.edu

Three changes for issues we found in pKVM as part of our research
project.

Patch 1 fixes a 32-bit size computation in hyp_pool_init(): a pool of
4 GiB or more gets a truncated range and maximum order.  hpool and
host_s2_pool reach that size on machines with about 2 TiB of RAM.

Patch 2 checks the host stage-2 PGD allocation for NULL before using
it.  With patch 1 applied that allocation cannot fail, so this only
turns a mis-sized pool into a clean -ENOMEM instead of a hyp panic.

Patch 3 makes hyp_map_walker() refuse to replace a valid block mapping
with a table, which would skip break-before-make and unmap the rest of
the block.  Nothing in mainline maps into an existing hyp block, so this
is hardening; Android's interface for EL2 modules to map pages can reach
it.

Signed-off-by: Xuheng Li <xuheng@cs.columbia.edu>
---
Xuheng Li (3):
      KVM: arm64: Compute the hyp pool size in 64 bits
      KVM: arm64: Check the host stage-2 PGD allocation for NULL
      KVM: arm64: Don't replace a valid hyp block mapping with a table

 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 3 +++
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 6 +++---
 arch/arm64/kvm/hyp/pgtable.c          | 7 +++++++
 3 files changed, 13 insertions(+), 3 deletions(-)
---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261105-hyp-pool-and-map-b5e7be9a1191

Best regards,
-- 
Xuheng Li <xuheng@cs.columbia.edu>


