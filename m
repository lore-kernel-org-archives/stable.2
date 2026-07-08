Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AE202963;
	Wed,  8 Jul 2026 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551936; cv=none; b=sb/MdfwIuh2xc+y/hb/8wI+PmeNzdiL54xoqRGr+Dt2lhMTmjbmdbyhxMGFyZQRvKIZNLLA1tE98ViR4HXmLPoJJlbPfdeojfItwLb/eTtPisKiGkU9sYHr4zcyTYf6Dw4rld49tBlSHAJ+/C43qkaYI/UgvqTVKCePlgSyqIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551936; c=relaxed/simple;
	bh=tgRB4vpOHqIrNfeLhZuFV5Qr1AO3OMMcO0TxW4/vi8g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J2RVCAtifUaQTrdJcKTTqqlwcF5xN+QeT4QGY26IBeqE3z/4Qcu05UMSD3liOyLouUAYs+zEuTA5CUF1QQvhqZNqQ87LztcAUZAVI6YpPRJz8gDTppQV/vMh/P3mz7pHg9GByIv4Nq1hx+mofuL0w1GXHUNQBO0NvqQRw0fXsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dya7nyRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dya7nyRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548651F000E9;
	Wed,  8 Jul 2026 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783551935;
	bh=IQw8Fmyq60Hd93Fj+TzQiJzIQ3vI9pEs45BmOecGf9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Dya7nyRRTuBslB+p/TsWw7zZcOhWHzgKIIwPb2YT7ucCHpOmXS9+bk+2OgvBT7lYu
	 Q40PAZgcaBLTPbN/9AaAdmpr7XHolSCU/K1WyvJh4JCIQljF1/CATw9mVrut8Vb8N9
	 Jtdv3Tx1NbVypq99qB7ubYoeO13CsHjhayb49AffwHk40tdUDuwcr/0pYJgMPMnQsg
	 Dgu4gsi4uAvjC/oc5iI6eqGtfv3XoZP/mo04kGwm029YGnNehetoFjcoHB1u+AU/wc
	 40IVffo8Gzg23/ygelihPQ2Viq3mE7xc4kSeej34ryNdt3mPmbxM1maY5z7BeSBXjj
	 V+C+BGlci8hMA==
Date: Wed, 8 Jul 2026 17:05:29 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, shuah@kernel.org, 
    paulmck@kernel.org, boqun@kernel.org, zhouquan@iscas.ac.cn, 
    ajones@ventanamicro.com, linux-kselftest@vger.kernel.org, 
    linux-riscv@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] selftests/rseq: Fix a building error for riscv arch
In-Reply-To: <20260707082348.36896-1-hui.wang@canonical.com>
Message-ID: <073d4140-ac91-1b5d-26a2-f519d6a2792b@kernel.org>
References: <20260707082348.36896-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Jul 2026, Hui Wang wrote:

> RISC-V rseq selftests include asm/fence.h from tools/arch/riscv,
> but the rseq Makefile only adds tools/include in the CFLAGS, this
> results in the building failure both for native and cross build:
> 
>     In file included from rseq.h:131,
>                      from rseq.c:37:
>     rseq-riscv.h:11:10: fatal error: asm/fence.h: No such file or directory
> 
> To fix it, add the matching tools/arch/$(ARCH)/include path in the
> CFLAGS and derive ARCH from SUBARCH for standalone native builds where
> ARCH is not set.
> 
> Fixes: c92786e179e0 ("KVM: riscv: selftests: Use the existing RISCV_FENCE macro in `rseq-riscv.h`")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Wang <hui.wang@canonical.com>

Thanks, queued for v7.2-rc.


- Paul
