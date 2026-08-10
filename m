Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC953876C4;
	Mon, 10 Aug 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381582; cv=none; b=L7JnzuHr3eXp6bXO8HrOl7mx0KiZPvRPTp4Vsohm0+lzyIh+CodtvEpYqRnu9nDs2vv3pPrShFALnGN/qx6UndEblpXuRvypHPKqydU2fYvkN9krYByiXrDX6Q7+y6SlXo3onL+gMzwRXpYaA6nrk8VrupGTpNfrXABuLj5OoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381582; c=relaxed/simple;
	bh=1ORMP8gd/6VKAjjhv+JmIQhO7i6YW8HRoG3EcfyadgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dB1NiB1rUWJa6ZnMpxyVcb8jvEqE6B3ACnRWybd04h5WUFhuLDZx3LtP3ow/y6sADIec8nhl7KIsiLV1CU/A7DRTgrdp6jDiYe+2rirJMtVKAa4jGAy4BX/fBnj4yjz62YRf8obxGsAD50lpA3l8fDseCs3V7hRrs29evhc+XOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asMIQGAu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asMIQGAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C131F000E9;
	Mon, 10 Aug 2026 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786381581;
	bh=5CEKvdjZ+GqV7pqn1nM6jfrimrYnL16pPlu4q1fQ5xU=;
	h=From:To:Cc:Subject:Date;
	b=asMIQGAuH+bY8/eRhEhYan4Y0Q39sbZsdOmdZOsJGyiJkB+8pAomI0kPRIvLctkt9
	 Aeo7Rm1/d9U5PTwpKUq39ZJaIJM1TrHLv4dBqlb3RR7mk4M/5gA7dS2EjeUXct50vP
	 BLZ/NnXIUnr3T10Mi1LWk56560/5E0LW2QjAqeIpAxo1uVPCyCzPmhXvkir0tV4612
	 74RdYxxo2oqErcv1lG9KVIIb3PUe6nVSE+J4o8DCCGyO+srzmVijT/SUWCP+cU/KLN
	 BBwvaQuQ3OvyU5ln5qNPlDpZcoSKRixMjV9C7VQ3yXqI7FDfCnpPE3xLCru8xdJ3it
	 HYS7PcslXtAcw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wtTS7-0000000ECcp-0cSL;
	Mon, 10 Aug 2026 17:06:19 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: Correctly cap TLBI Range to the architural limit
Date: Mon, 10 Aug 2026 18:06:16 +0100
Message-ID: <20260810170616.746100-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, fuad.tabba@linux.dev, weilin.chang@arm.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

TLB Invalidation by Range has a fairly powerful way of encoding pretty
large ranges in a small number of bits. This range can be based on an
arbitrary VA, which means it is pretty easy for a guest to generate an
overflow should the hypervisor be naive enough to add the range to the
base...

Make sure the range is capped to the limit dictated by the address bit
that determines the VA range. For an IPA invalidation, this is further
corrected down the line to ignore the upper range.

Fixes: 4ffa72ad8f37e ("KVM: arm64: nv: Add S1 TLB invalidation primitive for VNCR_EL2")
Reported-by: Wei-Lin Chang <weilin.chang@arm.com>
Link: https://lore.kernel.org/r/yifz3wn5gk5sr6mapi32trgk5m5kp33bquctsjmkifebnsnndt@fix6u4rthx4g
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/kvm_nested.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index c83be6d0e79ac..1ed7083358096 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -305,6 +305,12 @@ static inline u64 decode_range_tlbi(u64 val, u64 *range, u16 *asid)
 	num	= FIELD_GET(GENMASK(43, 39), val);
 	*range	= __TLBI_RANGE_PAGES(num, scale) << shift;
 
+	/* Cap the range to the correct half of the address space */
+	if (!(base & BIT(48)))
+		*range = min(*range, (BIT(48) - base));
+	else
+		*range = min(*range, ~base + 1);
+
 	return base;
 }
 
-- 
2.47.3

