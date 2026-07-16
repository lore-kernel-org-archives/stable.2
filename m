Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7895424D7A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209841; cv=none; b=eQq8dqLnAHprBPFT6xGBDQzVUzD4S+Rv5XTehBMYi0fLwACrCcx0LXiU+HyJwV36nEaH7jpFz0ems49Z0gQ1YYkmpmWUYjS1JuSzYZCk971TMLTSo8VEr54m9vHn/bS1aDk84oYSXoNt7Bozq/n4Nplq1GBQEmtrgqylbaY8aeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209841; c=relaxed/simple;
	bh=LBAVB65YK92B4TLOM1amodjrReejO9+nyhJye9VFUCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWJPnOiElAkfW1MwyZhQEerOmmD/L28ktDoG79+AJ+YxqO/wuTzvW7IGemaaSn5G6C0aTAXSM5bzSnSnLwrxUgRra3DFst37SRWT1C7Yv7WH7KD8Ecyz9ERl9hlXYf93pNAMoMlXdMwtd8l0kQGWfU+3+AsBgMUMomO92ET2/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h05k41hb; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h05k41hb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784209836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQPcDjujr/w8eHnNhJo8xYNzq4I/dcBqw+veMUH2Ivw=;
	b=h05k41hbRvsZ8l66fhzfhGC5PAMs2m4irUtWJLVBf+Pbbea6rKQzeqiUXKBVePZhtoLDB6
	iBv/7Mred7mgAhR5Q+BtRYfVvZ8/tsGAZfsp1KQnfUHn+GIMidRjS6Nw84sXz5pA1j8hRV
	Jv3s4+4tIMzv96yxjcwMHMiQBqdPvxU=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fuad Tabba <tabba@google.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.6.y] KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM hyp vCPU
Date: Thu, 16 Jul 2026 14:50:12 +0100
Message-Id: <20260716135012.302689-1-fuad.tabba@linux.dev>
In-Reply-To: <2026071626-anemia-skyrocket-b64d@gregkh>
References: <2026071626-anemia-skyrocket-b64d@gregkh>
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
index 350d1775a5ce..163538bb4ec1 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -30,6 +30,9 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
+	/* __hyp_running_vcpu must be NULL in a guest context. */
+	hyp_vcpu->vcpu.arch.ctxt.__hyp_running_vcpu = NULL;
+
 	hyp_vcpu->vcpu.arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
 	hyp_vcpu->vcpu.arch.sve_max_vl	= host_vcpu->arch.sve_max_vl;
 
-- 
2.39.5

