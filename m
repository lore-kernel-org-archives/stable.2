Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996456;
	b=a4u8ejh65D8H2D2YRAQgMfoC+Ucq8m/+/ka0hNKBY5VAlWCxoTvbFVYIZXoIXmGbVP7e
	 NAOeVGEy2Rrzh25rAP7oRs7WMTNE4dQFYQCsQHl5JG8JEMA53EeTGRG6McYl5xiEwNJEk
	 nxywJmG2h15qKf0Siyc+A6eADw999hAGsMgXdhao1CO0db+7VISzUORdB3uoeHQtkl7ck
	 YKZMh9+mOyha75AI5j2LgY1E5UbTPgA0QMCF4jdCDH63WTCVpg0seXauRKE3wJs7nR/t1
	 MsVpUjO9ecGrfzLb/Hpkqv7+ycTCEkJrZJD9f6oFEfWiAcSbLsmy2yGhDStH8sY/2jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996456;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Sf2ef/DZzsnK1sMDSaxmFCha0DAq5bCsGRzR7EIIXpE=;
	b=OUV3+pD75DhwQnIbZFUQbYJcp8erSERoC890EAZqR5yfgShJM2Q/S3zxgs+WVGufOeWT
	 aXm5uwfmqOQs4q++uVD7C1ucBRJtjvxBIi8QxAPlXrQDY290Ck9UwnJguKTp2RJK73Xh8
	 OQuOO0VfZOEbNG5tfRG7UnJOrvEg97a6AGP8wgOGYmcM7RQ1W1XFZmDGWMLURHUHtoZuR
	 k0aHgIEeCNjP9UPKYT5DrxZ9Sfh8rrpflBVPTN0je2O36dS/PYazjpEyxs+xIFrBUYAMi
	 l3EoBJCoIjZRcxdNAVlF5sF4dBs/+iDl2c1au04cSZId2F+GZiTzut+7j3sav7ag/xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2QzbFoJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D8606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2QzbFoJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F021F000C4
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996456;
	bh=Sf2ef/DZzsnK1sMDSaxmFCha0DAq5bCsGRzR7EIIXpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d2QzbFoJFY+k8q9V/CGKaMctSrm9z6TSBfBrEjsKosoFas19a+BaErySppE4Ncgt2
	 +YSdxqUGJKw5Ow6BHQmZ0I0Ug7mKId8Hr0d34Dtn/ism8hNDrU1dMb81zn2rGg4keB
	 1Z5QdzO6tUdStZVyDbBk+gjvk1yWL0KOISnTmx5EVdT9jZSZut4WkMBxY2JsPLJUNg
	 dvrkhrUmgKESSnXvjOZUlz1jSYIsuRpL5f/yC03cqwDmO9+V6HuTUlWi+hVrWihCWx
	 9WNv7YMnr1sf7TR58+2c1ubP35MTMNjuajhXEep1RUviGWq5QuxI5Yx/X+Yl5d6r3G
	 XdrDIOXkQ1+oQ==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-491846221ffso605195f8f.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:07:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEyUCUJuyc2YzvDFyqGQtJ9AJjnmqhyWFLPhmTzwPDTwNG5kXivkbJUSR2YK4cKlLQeiinAY7s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Tehi64FXkPklHOwIbhX+PdXV3niJuXxMkzGb/C+BVDH3TTV3a
	f/emOi5/QeU0zZAXSd76zr0rwoHZmsB1Sl3V7baH9WuVFB76cUHRdMMVKUEzHlt86yZ1XbwIlyy
	rqy1NKh2K8XjTLe2N+nLXpmYLK9YwyaU=
X-Received: by 2002:a05:6000:4812:b0:48d:ff06:c626 with SMTP id
 ffacd0b85a97d-4a63b6fc6d5mr4531220f8f.35.1794996454710; Wed, 18 Nov 2026
 02:07:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-riscv-marchid-fix-v1-1-6d677fcd5461@linux.spacemit.com>
In-Reply-To: <20261118-riscv-marchid-fix-v1-1-6d677fcd5461@linux.spacemit.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 18 Nov 2026 18:07:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ+86jtp3Dw9pw8xf7zK=bU_txdGYjaJp+85H7WE_iKLA@mail.gmail.com>
X-Gm-Features: Aa3M54rjZmx21x9qbdtBeJSZpO91ThMWIbqg7YbcJXk95cJ0eYpg24g2amLowHU
Message-ID: <CAJF2gTQ+86jtp3Dw9pw8xf7zK=bU_txdGYjaJp+85H7WE_iKLA@mail.gmail.com>
Subject: Re: [PATCH] riscv: cpu: Fix incorrect cached machine IDs on secondary harts
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 11:05=E2=80=AFAM Peixin Xie
<peixin.xie@linux.spacemit.com> wrote:
>
> During early ISA-string parsing, the boot hart stores its mvendorid
> and marchid in riscv_cpuinfo. This happens before setup_per_cpu_areas(),
> which copies the static per-CPU data to each CPU's allocated area.
>
> When riscv_cpuinfo_starting() runs on the other harts, the copied IDs
> are already nonzero, so it skips reading their own IDs. As a result,
> secondary harts can retain the boot hart's IDs.
>
> Read mvendorid and marchid unconditionally on each hart, as already
> done for mimpid.
>
> Fixes: e482eab4d1eb ("riscv: cpufeature: Fix thead vector hwcap removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
> ---
>  arch/riscv/kernel/cpu.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index af84b97af3a1..64c0c83eff76 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -197,16 +197,12 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
>         struct riscv_cpuinfo *ci =3D this_cpu_ptr(&riscv_cpuinfo);
>
>  #if IS_ENABLED(CONFIG_RISCV_SBI)
> -       if (!ci->mvendorid)
> -               ci->mvendorid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mvendor=
id();
> -       if (!ci->marchid)
> -               ci->marchid =3D sbi_spec_is_0_1() ? 0 : sbi_get_marchid()=
;
> +       ci->mvendorid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> +       ci->marchid =3D sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
>         ci->mimpid =3D sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
>  #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> -       if (!ci->mvendorid)
> -               ci->mvendorid =3D csr_read(CSR_MVENDORID);
> -       if (!ci->marchid)
> -               ci->marchid =3D csr_read(CSR_MARCHID);
> +       ci->mvendorid =3D csr_read(CSR_MVENDORID);
> +       ci->marchid =3D csr_read(CSR_MARCHID);
>         ci->mimpid =3D csr_read(CSR_MIMPID);
>  #else
>         ci->mvendorid =3D 0;
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261118-riscv-marchid-fix-3ea3672d1e0e
>
> Best regards,
> --
> Peixin Xie <peixin.xie@linux.spacemit.com>
>
Hmm, it solved the problem on Big-little cores' SoC.

Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
