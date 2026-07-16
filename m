Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CFA427F97
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209921; cv=none; b=YnNTvV8HtufHC1D/Kl8ECRdVi06IM21q4Z+JT+0pL6bv7SymNJvtaPZVKVZ4/HBvBCtvzXdEhQlr8Az9l4Lwv7ydeMcmsAYlYvT0O4mTJ4Twl+lSaPioGaxM3l1Wya6dZg0c1tVaJiYotnRcnuimPSiPkjy5coQiYb6+IZVogWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209921; c=relaxed/simple;
	bh=M8suXWeYgfmaIuVw7umXQNd0abJwQJGQsZr268TEczM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QAxKVNceKMyvNxG3YTvNGprRtkWw+qHC5bacJdW6+QYC2StDzKqZ+EzLrQWjRTlOAiCK0c+wFwPos3qpcrwjKW35qvK7FjCdlReN9SdKpyklMVlAGSfc6/FAapurl0aTpPmxcC7cuVA7jpdZuhgQqGXvojZdT9FVmf4pr7ZH+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q5IVRAUs; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q5IVRAUs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784209917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DmVCwpsSSXUTG3Z0wZNNZ5nd72RAkiSIdT82QDdRgI4=;
	b=q5IVRAUsGkM2xV2C0/7eOA71dstGF+QZBFW8OVEY0zTkda40Rhur7yJu0UKvjKX2vtoerb
	5lF+QCjByRaf1kid/IHUXSBwIiAzlQe688/xqeqWOgjHA76jLXuOSCU4ESApoXdyjGjOjm
	zirN255iuZu6lpblyHwPiIQJ6ThTMXk=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fuad Tabba <tabba@google.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.12.y] KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM hyp vCPU
Date: Thu, 16 Jul 2026 14:51:25 +0100
Message-Id: <20260716135125.302899-1-fuad.tabba@linux.dev>
In-Reply-To: <2026071626-cattail-yippee-a1e7@gregkh>
References: <2026071626-cattail-yippee-a1e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hyunwoo Kim <imv4bel@gmail.com>

commit e8042f6e1d7befb2fb6b10a75918642bcd0acf9a upstream.

flush_hyp_vcpu() copies the host vCPU context into the hyp's private
vCPU on every run. ctxt_to_vcpu() expects a guest context to have a
NULL __hyp_running_vcpu, which is only ever set on the host context, so
that it resolves the vCPU via container_of(). While this is generally
the case, flush_hyp_vcpu() copies the context verbatim and does not
enforce this, so a value provided by the host is dereferenced at EL2
(host -> EL2).

Fix by clearing __hyp_running_vcpu after the copy.

Cc: stable@vger.kernel.org
Fixes: be66e67f1750 ("KVM: arm64: Use the pKVM hyp vCPU structure in handle___kvm_vcpu_run()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260606175614.83273-2-imv4bel@gmail.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
[ tabba: adjust flush_hyp_vcpu() context ]
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 75f7e386de75..eec36c46ce29 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -100,6 +100,9 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
+	/* __hyp_running_vcpu must be NULL in a guest context. */
+	hyp_vcpu->vcpu.arch.ctxt.__hyp_running_vcpu = NULL;
+
 	hyp_vcpu->vcpu.arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
 	/* Limit guest vector length to the maximum supported by the host.  */
 	hyp_vcpu->vcpu.arch.sve_max_vl	= min(host_vcpu->arch.sve_max_vl, kvm_host_sve_max_vl);
-- 
2.39.5

