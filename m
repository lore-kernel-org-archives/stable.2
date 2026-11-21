Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795253666;
	b=pNk7qUEZaUojswqiRCUk+XgYKNzzr+kkkSolpDj0c3eal7hg1k1DQFRQ1a2/vrvn3s/W
	 UpPFeM3ELv3JZ4VnjoRBGuHQ5F5X+4JKB6N2A1i6lH6sLJSbDysOt48r3ngE5X3Rm1ms0
	 QGGC3ZEX4QXDZMqkNoNpyGyI1BVJrSUvfBoARKrPAwRlt2iozlgSMbrHpsA2luwWDPk9H
	 NxeG5H3+idtxMwsWgEoaY78Oi+ZAYbqaLCeERUwZT88h/ntREVpzMnWxGDA9TtPIGz7fo
	 Qu6qotivJB4E99l/Bp/5oNKr4/j77Q11P4blrkX8uvWfBJHbbSH41424l2It9pp3XDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253666;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9v8g6X3WDYfoIYNgraXq6dzuu3lA8FjW9iHHqy+DMxA=;
	b=zCqWO9/qWqj2l51AE6k1oEHqVLB+GRkthwVAFZH7XUKs8sMvEudye+llaSnmgBZxvuTL
	 JRCa4Em4L8LGOwg6X6j6I2PXVhp0/yC2ItzAsMnyfETYuhiXjY5WOmpYiwKOGfapc0Cqf
	 2Wo2XKZMMkMrDnMF/i4BgL3FXHhIMf9lSDOM3elR8yJvQA2M7CqLje9v3+/8cKr0Bu7J9
	 Sp67N+ds4xT+nb2i7k4frTm6ZDN/XArQI9nQGW6V00cQ5LdriuMXQT9kmO+xXIBzAfrIP
	 82mkf+mMfilEDTD8zSbAVDZLtNZ1WFVwy8vAa4L8lZO0XxGNv9mjBi+2+LRxucydGlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMpn4nlx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A31D606A325
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMpn4nlx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E24B1F000D0
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795253666;
	bh=9v8g6X3WDYfoIYNgraXq6dzuu3lA8FjW9iHHqy+DMxA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YMpn4nlx9yqW6GSDHuCv/vofPRpw5pSQsOb1xZNTG4j2BCqXQ5xhe73vu0kgQKsfJ
	 HQkDht/XJ6OehNVZoGOERQAaTs31SpUkXnt/066aDrH+GmyR4cFNdBFa0telPPQezI
	 ZfCnf1iDdk20ce5G2u2rpO9JFQbSa16uufEJBGRkG2NCUbPDjQ3Eu4u35hapUCeHJ4
	 y3XD+QIPcTBnzKLlA+SisFDqBzuYJvs3446TUh5nXnsYBCTFurU1H/Y6GuPtip09bF
	 JGkZVSQe92s6m3RU4NHlpdMo9FzhsM14gj9f9nnv90XVIWLXGGdYbNRr2fsL7lXrvf
	 O6lIAMdL9rfcA==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so16837645e9.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 01:34:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEHVLyy2qberIUiOEhI1ZKd4yLgsGUh9i7uG/X9oxbSGeBcXdfWUEVqsOD/fSyD8R8ZPFm01bQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jjb3yJUdvkdoFyIvMVY67mZxa5PSoiBXukRWSl+9dJJGQ/pPB
	7u84gewVQK599hhwrom4Z/0meImHvXuFTzAWDDQT3aXwNY8kGfpJH1q0VWqXVyr7kMtwY1+cfK/
	CNlxxMsu98uZSoupBeKfsoCvVKBU6NSQ=
X-Received: by 2002:a05:600c:468b:b0:4ab:cc03:7f60 with SMTP id
 5b1f17b1804b1-4bb8881b511mr128890735e9.18.1795253664679; Sat, 21 Nov 2026
 01:34:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118053926.845109-1-hj351016@gmail.com>
In-Reply-To: <20261118053926.845109-1-hj351016@gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 21 Nov 2026 17:34:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQMLzX7ANcPtM-5yokRW-17C2cpbBOOx4ip1qpxnhTuCw@mail.gmail.com>
X-Gm-Features: Aa3M54p_k23V3n3S-vJbFZ6t12-Zbu1Qx524on7iW-P5egmHQu9WaiGNlcA1_fg
Message-ID: <CAJF2gTQMLzX7ANcPtM-5yokRW-17C2cpbBOOx4ip1qpxnhTuCw@mail.gmail.com>
Subject: Re: [PATCH] riscv: ptrace: Initialize cregs before copyin in compat_riscv_gpr_set()
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:39=E2=80=AFPM Hyunjung Ko <hj351016@gmail.com> wr=
ote:
>
> user_regset_copyin() only copies `count` bytes, so a PTRACE_SETREGSET
> request with a short (or zero) iov_len leaves the rest of the on-stack
> cregs uninitialized. cregs_to_regs() then copies all of it into the
> tracee's pt_regs, where the tracer can read it back with
> PTRACE_GETREGSET.
>
> Fill cregs from the current register state first, so that a partial
> write only updates the registers it covers, as riscv_gpr_set() does.
>
> Fixes: 4608c159594f ("riscv: compat: ptrace: Add compat_arch_ptrace imple=
ment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index a005574..32227b7 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -584,6 +584,8 @@ static int compat_riscv_gpr_set(struct task_struct *t=
arget,
>         int ret;
>         struct compat_user_regs_struct cregs;
>
> +       regs_to_cregs(&cregs, task_pt_regs(target));
> +
>         ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &cregs, 0,=
 -1);
>         if (!ret)
>                 cregs_to_regs(&cregs, task_pt_regs(target));
Yes, we need to initialize cregs from the target's current register
state so that partial writes preserve the untouched registers.

Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>

--=20
Best Regards
 GUO Ren
