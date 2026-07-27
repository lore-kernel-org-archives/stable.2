Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B03C3F66
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190800; cv=none; b=JSJPi5LowszszQwXgc9BBotLzoTvT1r6RzpFjOAGY2uqYdJiIhwLmQyBElUtnpFuyp7I7JwWsmZKj/ZhwMfT/BZwRcqexMQXWCZnvNZFECaYT9KIPEqYCDvE7j7eu6FE1Wl+4lwRYDWqp/REXVeqvpxvSUU/vL95mdrzTiMFh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190800; c=relaxed/simple;
	bh=cNRHiiLiJsf3KLh0Bytz1SZ5CeEFE5NxKBWIn8LlAI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2vOYEceuY691ngeT5KBdpnwx6LKCr/9oXfPQwUYRXSNXEgGBSBbdUPRZuNARWouapA1NIVLj+tiTG9sn5uWQMmuULDbmCRmM2C53vZhpawTboPr+XRaLuV38ud9RjwmI19TgxgOr4cagb4ChSA+7PrUXWTZihVLLQ8eSnv8hjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THRcpOZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THRcpOZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4921F00A3D;
	Mon, 27 Jul 2026 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190797;
	bh=HAXvjkGBuFSTGJRHHJQWkwhlZaveFVppmIfS5ZHAFmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=THRcpOZS76tHvV5TWSPqYdWIWK29RjnR0NhviYzTNTJ6KAgz69sYsOhOgMhc+1Hxw
	 2WOhxln2d5LI0A6a5WnQVq58cFwMr4KyJ9cLMNFFqcvRispqnOvIYERInquwK/0gfW
	 Pj9kZFOntZ06w/t4rvuyqx/LWcqgOZ2bUOzQntAPQTOoHi3XaSGSnO5cRHrjCvWtgS
	 2VE+VFpDikBG4cJgMsBtmdJSF4izghnA1vbX84t2toYAcqw2p8OFr1F7jWWo21+iZc
	 iW86n5fvr/BRx/E4aNKze/rIUC7vyZX6Pf03VJQUjbExDcZRJPhxt8FwPL1HOfzcRk
	 NBs2gcxVrsY/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xie Bo <xb@ultrarisc.com>,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH 6.12.y] RISC-V: KVM: Serialize virtual interrupt pending state updates
Date: Mon, 27 Jul 2026 18:19:43 -0400
Message-ID: <20260727202413.stable-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727023348.2173961-1-xb@ultrarisc.com>
References: <20260727023348.2173961-1-xb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 10:33:48AM +0800, Xie Bo wrote:
>@@ -174,6 +187,9 @@ int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
> 			       unsigned long *out_val)
> {
> 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
>+#ifdef CONFIG_32BIT
>+	unsigned long flags;
>+#endif

This declaration landed in kvm_riscv_vcpu_aia_get_csr(), but the use site
is in kvm_riscv_vcpu_aia_set_csr():

>@@ -198,8 +214,12 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
>+		if (reg_num == KVM_REG_RISCV_CSR_AIA_REG(siph)) {
>+			raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);

So on CONFIG_32BIT builds 'flags' is undeclared here and rv32 KVM fails to
build (KVM on riscv only depends on RISCV_SBI && MMU, so this is a real
configuration), plus the declaration in the getter is unused. The two
function prologues are identical, which is presumably how the hunk
anchored in the wrong one.

Could you send a v2 with the declaration moved into
kvm_riscv_vcpu_aia_set_csr()? Everything else in the patch matches
upstream d024a0a7879e ("RISC-V: KVM: Serialize virtual interrupt pending
state updates").

I've queued your 6.18.y patch. I'm holding the 6.6.y one until the
corrected 6.12.y lands, so that 6.6 doesn't ship a fix that 6.12 is
missing - both will go in together.

-- 
Thanks,
Sasha
