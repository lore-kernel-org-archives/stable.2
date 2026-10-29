Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264728;
	b=Jeamo7XovM5rmWfFNMtixmv/ixhFjOukLhdYh4yZGMgQWAH+cBsPrYAApgul7GrEQJaN
	 fzb/vZ2fb2T90EWfXtsBwAoF6jjOzlt87ms36XQACpCf/uj3Dm2k9AeccZyPpJMq3P8DA
	 7U7PQ7LJmzDhf00kUr2M8rwnTsPu4WfclC+CfeATzNHY8OYMOWtg+wDg8MaF7qJPfrkyF
	 s4sFxCBMKjmf+IE7AyeaaG22UNPTK28OvKyrBoFQCDxq3FdxjuJ7PGK0w8WId1OnTRif0
	 6hjXFaoAPLsMsUT8AOgh5DUZnQpW1zlP6D+Xd1koycNmL0Zbft8bSOaG56xwlDi+6sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264728;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bg0Ymif0uoiICiNRdrOrby7zyxhfmv3mM2elfFbvQOQ=;
	b=sMjPsQTpgcAuykez3Csj9IpSzy0I4oaA98UwiE4eueOb1n+l+kol/JBoR8HTaDIB/L5o
	 f+MU3oOM/iK9KXwc5Vi9LyUs8j8kac+beete1AlMtmUscvffIsw2u6Oq3tYcD2V2LWP76
	 AV/4cvMW4dqjBQmfwQVQtplT27gVDCa8GDIC/GpFwPRZBx54n8Q3gvjPjQlCQwiomlm/B
	 P849r+mnoPtGUjgGZVciiVOYlmSWT1J5G8XNUWDtzcN9/fIZ5ChVF1AWLPvZw5aedRSOm
	 w+dZXd89TejAzsHnr7UtEOnzWq4o5JsSxUbhCA/FRDJyxSIZ9HdQaCWZRTMKsy71HYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5mxlMBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD68606A31A;
	Thu, 29 Oct 2026 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5mxlMBC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7511F01825;
	Thu, 29 Oct 2026 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793264727;
	bh=bg0Ymif0uoiICiNRdrOrby7zyxhfmv3mM2elfFbvQOQ=;
	h=From:To:Cc:Subject:Date;
	b=B5mxlMBChJwT2ir73H4sxdSu3LbmJ1uMQylIcXWhsIrB7mvEuTbwaTQ20Xr4scscG
	 hLedn0FF0g2uMHsxhnzIzybMLvQ/NkI8S78z5GkLtZPHnxcWMGWRNFntpKPZVZmh40
	 rVBOXSz5evOTOIp1NVdQ5Cuw71K7rgjvYzoENQplL/IwJUtILr+PqhqSi3U5qal6or
	 7pp56cH5Cmrci8sBz5Zvi1tqrScdya3MJPTtisO8n1aaHCBLVneY9wB7eXm4+4LPjj
	 r4AsdniJTW2ExVSaIr6o9Wgj83rJ33PM8FsvJYxLjW/TVgb8mcjPk8l/SeeqyaKZ7d
	 dpRxTqcGqL3MA==
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
Subject: [PATCH] KVM: arm64: nv: Respect HA when computing translated TCR
Date: Thu, 29 Oct 2026 02:05:22 -0700
Message-ID: <20261029090522.64662-1-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Add the missing forwarding of TCR_EL2.HA to TCR_EL1.HA, which are
different bit indices, to ensure that FEAT_HAF actually works for an L1
hypervisor in the EL2 translation regime.

Cc: stable@vger.kernel.org
Fixes: d5bbb76f4474 ("KVM: arm64: nv: Expose hardware access flag management to NV guests")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
Spinning this off from the HAFDBS series since this fixes an issue with
FEAT_HAF which is already supported in NV.

 arch/arm64/include/asm/kvm_nested.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 0f899addafa8..2811ec466d88 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -29,7 +29,8 @@ static inline u64 translate_tcr_el2_to_tcr_el1(u64 tcr)
 	       (tcr & TCR_EL2_TG0_MASK) |
 	       (tcr & TCR_EL2_ORGN0_MASK) |
 	       (tcr & TCR_EL2_IRGN0_MASK) |
-	       (tcr & TCR_EL2_T0SZ_MASK);
+	       (tcr & TCR_EL2_T0SZ_MASK) |
+	       ((tcr & TCR_EL2_HA) ? TCR_HA : 0);
 }
 
 static inline u64 translate_cptr_el2_to_cpacr_el1(u64 cptr_el2)

base-commit: 9e9283e4c941e806d2735f09b66763487bc48b50
-- 
2.47.3

