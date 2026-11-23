Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459990;
	b=OzE0XwyxQS+qRDvLEQrF/Rd7n0ae+xhXacRgJE1uw6Cb/F4R2nLLJPoZTVUL3p3d7zV2
	 KFL09eT8lQBU6wMD0nEmDi9H+UuxpTGV31b1Xfc9jTpKZNxK3H+8JPqa9zpYew1N/Xrf8
	 E2GVvU6Qy8MAw9XtbK8RATAO1Q9hcaIv8sZcGA3+v/I7q3WHBT6F4VADD4rmyE3h+K/Vp
	 0/9iSCM41qt7+syAeAzNxCUJpvBHOvnCr9r2cYaHG6JsvKL5cRy9BY2ygcakxdja4clWp
	 raIvFy/3MoHTNsXgy+C4wAjvgbVtxGKyVxt3OWnPa6IQA7XMEiljMVqL3nch5X6aDNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OzK8e5va1iOv1sYIdDfpKtFNB5Tj3DOer2I2bPq8P24=;
	b=U4UM3s5SKtETtluYbxkn+5tUIwkfFnvpWyRaHAuZ/5pgeLFxP41NJNgLHiDZCLkYkcro
	 u+mlgKnWqWzQ9CZdskOrktBrbGQHodOZHe+jWdsp+W3vrbQj9p+HVMW2qDyuiziFPwG4b
	 ARq+Ux9LBEaKVX+W8C0S7I16lLq8nxrYfYKCNTm2bccnlKPW2S3eiv8N3Dk0EQ+p/7p3i
	 7VwioI3EDAZjgTPxsYiiacjZXvqnfGoErYZCD7yThsAHSArnLLUeC398QeCSexN4kNilk
	 oq0Oy1JyK2PRyOuQcdbvcGAoRgBu+AQXFnquJ7q8ULsEwxEXVP8YIBm9mSFTnAn/WWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CdlLT9qA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498CD606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 498CD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CdlLT9qA
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so29179785e9.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795459989; cv=none;
        d=google.com; s=arc-20260327;
        b=JAG/AwE+TvcEQI2YehJID0vmCfg9VJC/Ir5MUbEKHlRd+DFO7qwPsLsVJcGTrp6gz6
         IyqWbcP6JxLiGsqC/Fb7E7LU13p5iRJs1imYRBT8ZcwR9Fuul9CNYTuwWH/lV2c5TUuf
         poY4o67+B/PPXn1p0F2LZHHGTMYHg/+mwP5DVds10pRCJ6xLK0zXoislPa3V4muED586
         MZAFRne/CQ/PoQyx6vOmmpfxKL30toM4O4qeHm5P6iZO5NGJN0XLEujd7R2jo5bo/k4z
         ME85d/uHx+kn7LMuFboFolPrAGQit6ZzENgQgnWBwqf8xv8Gj25IBKca+NOCMe93MU4G
         KBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OzK8e5va1iOv1sYIdDfpKtFNB5Tj3DOer2I2bPq8P24=;
        fh=05uPkr+3gpbmwRYjXDlaCx8k36Qg1K10J8T5OuCXHAk=;
        b=HMSKSpRwhCOLduhd3eBjgMoopuvxR7o3P0kRbgXq/+zRbWOjU0dHsFwIiVPaJmZ38Z
         FiGu4Xcdy5Rgfc3ho/OZgp4ONJhSx5rOoIbnCUzcYMDRibD12VDcF95CahsgbJVT6w3A
         U6a7jIbrcgHHE3CeEp9bFiE0qRBpolZo9TfwzdSWX+ZMPKJQvT/7Psu9EZ/ZSQw9IxPO
         GKM9E3pTnwypmMk/v+53c804ebGvdBV8rRgVUwnt5jK66srRA9Vee2poRenMyuQobOpq
         zHQiSZMX6BSD5Vca8LtusbmDgjlDne7c1XScX04bUXtMZaMYR8bokARxo7MFlMWqCWeM
         dsOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795459989; x=1796064789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OzK8e5va1iOv1sYIdDfpKtFNB5Tj3DOer2I2bPq8P24=;
        b=CdlLT9qA2pXjCH2WZFf7BS62GOJsjrzu1gCDGCGbr2jWqS4MWBI9UwNp8kWbyoyVci
         4oD7lh4+lFa0GL3ZUxwOZNN0ze61yWh91ebaHYl8uIZsWwopSSvC2b141+dBW/g0uJ8K
         TR32P3Bw5sjEkY51snLlefVUK63mVc9tMUbYNavLnfzp41CpH7hOh/DvT4omE9Fw8cYs
         X6GlFPUoF0x6zdoCM5c4l6x/NwxL6ZTxA1KKmBgcRus14VIcC8W4H0dQsCD0w5OUeU0Y
         DmffjVyaaX3x4/yQN1CCWPLf2CP1DL9CarMWAA7j5SJ5dZVd085JyVrOYeVDguDhgZkV
         303g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795459989; x=1796064789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OzK8e5va1iOv1sYIdDfpKtFNB5Tj3DOer2I2bPq8P24=;
        b=xBUxBuqpM3ZjwZbAeiGxVnb6duxg36oy3LNJUc6pNRnPmyLcUSZiYL/VlcoHQgWUUY
         E7S3WH7Y8dHDETOZYcvswzkTItMzlxDUvv3MWqDr0TbJfnsBWeqL5y4MAmSEOeaE029s
         TlAu7+GApYfUGnZ+IG1HieMQ9gZmFnSMZPYd7qValq3sLWRodgyLHLZA1JNQYEaMafL3
         L1jmMTFS+VLdlkZZGxAsfEUffPFabGqEt+zzWQJyno6glxn6GTYOxC1kPGF1qzpCzalZ
         +vbtkY/z8QPL/P+z9hFKDryKcZIbeXt3PCJNGxGz4ijHI+Pn6lALoN9kgVEq2PU+7PJa
         2XFw==
X-Forwarded-Encrypted: i=1; AL+hErE47dIzNl4GO5H/HNWnpa4oDwCHgaUToyfx+oYOn9Sj9UvLwkfOTPwh1kpO0YhKxmgY995MZpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wAAukKabQ2TQo/ESJgt2Sw2nf06jL2zuoJYUEOTky9+yDJNHt
	KPUUEtw9O75kTDBm/9n+aM0wh4XEbpiloxsz4fFgyKpxfZy6qxIaVGmgCsFRHnUGA4/bj2sUp3N
	EvOziL3t/sXThJU0ADNJMwSLCQqUkTkBfjj5NRhaL
X-Gm-Gg: AZFdTZfQKlBB+XQOwHMX/4Z3AJJKLg0qzeo/w8LEDVmf/A61zo/Shyhgl/OM1MDpPFn
	vSPu6xy1A2FW5o8yHIBS5epwWy+fEQeKlX6ZEPdZRC7Lj8EUQEvmQ5J0ztrtbwdpBB5OKghwI37
	WquhraQlIaI4zZeUR5WqUAjIJpSHa8StPiW3wfGyvixTK9CUWJvosYeCg3J/Hhv5oAxUjKUg5lo
	Jn+RqVjVKHP96ncizfgnf3IZKDzg7lfaTqCQsfaT/P3zM9/iqDhP1LlN3M0qUHjwDVCkZ6LcM8f
	4HtYN5w774KzZ2URvTDPFemTxTTpMzfjCSFH+IE1v6yBzHQHWHiB9i5ydM+8RlFb3d9nVB5Xhx5
	MuzC7N+DOCbVd1/mZrQyCOFumx9zUQPF1z5wBeinbX37rhczDt/RT/5+HncggjoV8oghOxocEGt
	LlX6ke/HRGY+/x7ZwWazH2VLLtmngUSctJd90XPJQMycsqMWAyAAZVbQjJ+tklHBdN47NoF+A32
	h9Ny3KoZHT2RAP+bEANsqpPoYFNKOC4saa+Qg==
X-Received: by 2002:a05:600c:154f:b0:4bb:6842:66ef with SMTP id
 5b1f17b1804b1-4bb8893a963mr247968845e9.30.1795459987961; Mon, 23 Nov 2026
 10:53:07 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123025645.2385330-1-shingekinocore@gmail.com>
In-Reply-To: <20261123025645.2385330-1-shingekinocore@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 23 Nov 2026 10:52:56 -0800
X-Gm-Features: Aa3M54rjSx1yo0dE65bPncdIJw5ozLFQnetXM2ws-XF0yEzirPrTrGmtq_bnHFU
Message-ID: <CAKwvOd=aZam1UR8O5okim1PJqjm5Biv+cBQUmA8ydctUd0v=QA@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Fix genex.S build with LLVM before 21
To: Tzu-Ching Yang <shingekinocore@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Marco Crivellari <marco.crivellari@suse.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-mips@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 6:57=E2=80=AFPM Tzu-Ching Yang <shingekinocore@gmai=
l.com> wrote:
>
> Since commit 56651128e2fb ("MIPS: Fix idle VS timer enqueue"),
> BUILD_SKIPOVER_PROLOGUE uses label differences as the immediates of ORI
> and PTR_ADDIU. The LLVM integrated assembler accepts such an immediate
> only from LLVM 21 on, so LLVM=3D1 builds of every MIPS configuration fail
> with LLVM 17 to 20 unless LLVM_IAS=3D0 is set:
>
>   <instantiation>:7:11: error: expected an immediate
>    ori $26, r4k_wait_idle_size - 2
>             ^
>   <instantiation>:10:14: error: expected an immediate
>     addiu $26, r4k_wait_exit - r4k_wait_insn + 2
>                ^
>
> Wrap both expressions in %lo(). For that operator, LLVM 17 to 20
> emit a LO16 fixup instead of rejecting the operand, and resolve it when
> writing the object, since both expressions are constants by then; no
> relocation is left. Both values are between 2 and 30, so %lo() does
> not change them. GNU as and LLVM 21 to 23 emit the same code as
> before, except on microMIPS, where GNU as now uses the 32-bit ADDIU in
> the delay slot instead of the 16-bit one. With GCC, the 2 extra bytes
> replace the 16-bit NOP that padded the end of the prologue, so all
> symbols keep their addresses; with Clang and LLVM_IAS=3D0, except_vec_vi
> and the code after it, up to nmi_handler, move by 4 bytes.
>
> Fixes: 56651128e2fb ("MIPS: Fix idle VS timer enqueue")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505071331.Z0N2eSkr-lkp@i=
ntel.com/
> Link: https://github.com/llvm/llvm-project/commit/b65e0947cade9bd39036a77=
00b54c1df4ec00756

Thanks for the patch.
Confirming that landed in clang-21.

Link: https://github.com/ClangBuiltLinux/linux/issues/2201
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> Cc: stable@vger.kernel.org # 6.6.x: 56651128e2fb: MIPS: Fix idle VS timer=
 enqueue
> Cc: stable@vger.kernel.org # 6.6.x: b713f27e32d8: MIPS: Move r4k_wait() t=
o .cpuidle.text section
> Cc: stable@vger.kernel.org # 6.6.x: 2b6d718c8dbe: MIPS: Fix whitespace da=
mage in r4k_wait from VS timer fix
> Cc: stable@vger.kernel.org # 6.6.x
> Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>
> ---
> v2: only the stable tags change; the code and the rest of the changelog
> are those of v1 [v1]. The tags now start at 6.6.x and name the two
> prerequisites Maciej suggested [review] plus b713f27e32d8.
>
> What each stable series has today, and what it will get with the tags:
>
>   series  56651128e2fb  b713f27e32d8  2b6d718c8dbe  will get
>   ------  ------------  ------------  ------------  --------------------
>   7.3.y   yes           yes           yes           this patch
>   6.18.y  yes           yes           no            2b6d718c8dbe + this
>   6.12.y  no            no            no            all three + this (a)
>   6.6.y   no            no            no            all three + this (a)
>   6.1.y   no            no            no            nothing (b)
>
> (a) On 6.12.118 and 6.6.162 the three cherry-picks and this patch apply
>     cleanly. For malta_defconfig, genex.o builds with GCC 8.1 and 16.2
>     and with LLVM 13.0.1, 17.0.1 and 21.1.8 (6.6.162: also 11.1.0),
>     and kernels built with GCC 16.2 and LLVM 17.0.1 boot under QEMU.
>     56651128e2fb needs b713f27e32d8: without it, all the code after
>     r4k_wait in genex.S is placed in .init.text. Both were queued for
>     6.12 and 6.6 in 2025 and dropped because of the build failure
>     fixed here ([1] below).
> (b) 56651128e2fb conflicts in idle.c on 6.1.y and older.
>
> [v1] https://lore.kernel.org/r/20261104030147.3117325-1-shingekinocore@gm=
ail.com/
> [review] https://lore.kernel.org/r/alpine.DEB.2.21.2611040746160.6502@ang=
ie.orcam.me.uk/
>
> The notes of v1, unchanged:
>
> > No MIPS hardware here. Against mips-fixes (v7.4-rc1). All builds use
> > W=3D1 and kernel.org toolchains.
> >
> > - genex.o, before and after, with GCC 8.1 to 16.2 and with LLVM 17 to
> >   23, both with the integrated assembler and with LLVM_IAS=3D0. Configs=
:
> >   64r6el, 32r6el, 64r2el, 32r2el, eyeq5, eyeq6, malta (little and big
> >   endian, MIPS32r1, microMIPS little and big endian), ip22, ip27,
> >   loongson3 and cavium_octeon.
> >   - The objects are byte-identical before and after with GCC, with
> >     LLVM_IAS=3D0 and with LLVM 21 to 23. The only exception is the
> >     microMIPS ADDIU above. The 4-byte move with LLVM_IAS=3D0 is harmles=
s:
> >     set_vi_handler() computes the offsets and the length of the vectore=
d
> >     handler from symbols before copying it, and ejtag_debug_handler and
> >     nmi_handler are only referenced through their symbols.
> >   - LLVM 17 to 20 now assemble genex.o for all of these configs except
> >     microMIPS and Octeon, which the integrated assembler rejects for
> >     other reasons. For malta (little and big endian, MIPS32r1), ip22
> >     and ip27, these objects are byte-identical to the LLVM 21 genex.o.
> > - vmlinux of 64r2el, 32r2el and malta, built with GCC 8.1 and 16.2,
> >   LLVM 17, 20, 21 and 23, and LLVM 17 with LLVM_IAS=3D0. Where both sid=
es
> >   build, vmlinux is byte-identical before and after. With LLVM 17 and
> >   20, genex.o was the only object that failed before, and vmlinux links
> >   after. No new warnings.
> > - The malta kernels built with GCC 8.1 and 16.2, LLVM 17, 20 and 23, an=
d
> >   LLVM 17 with LLVM_IAS=3D0 boot under QEMU 6.2 -cpu 24Kf. That CPU use=
s
> >   r4k_wait(), so interrupts go through skipover_handle_int. Each kernel
> >   boots to an init that keeps the CPU going in and out of idle and then
> >   reboots; a QEMU trace shows every interrupt that lands in the idle
> >   region resuming at r4k_wait_exit. A microMIPS kernel does not boot
> >   under QEMU -cpu M14Kc with or without this patch, so the microMIPS
> >   change was not run.
> >
> > In the 2025 thread [2], Nathan suggested requiring LLVM 21 for MIPS in
> > min-tool-version.sh, and Maciej an #error for older Clang. Both would
> > also stop LLVM 17 to 20 builds with LLVM_IAS=3D0, which work today, and
> > the stable trees would need the same change before 56651128e2fb could
> > go back to them.
> >
> > On 6.18.y, which also allows LLVM 15 and 16, the patch applies after
> > 2b6d718c8dbe, and LLVM 15 and 16 fail and are fixed the same way.
> >
> > The 56651128e2fb backport was dropped from the 6.14, 6.12 and 6.6
> > stable queues because of this build failure [1], so 6.12.y and 6.6.y
> > still lack that fix.
> >
> > [1] https://lore.kernel.org/r/2025051415-unloader-likely-b0e6@gregkh/
> > [2] https://lore.kernel.org/r/20250521224450.GA2412476@ax162/
>
>  arch/mips/kernel/genex.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index be1b049d856f..ef27965f6ad9 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -146,10 +146,10 @@ r4k_wait_exit:
>         MFC0    k0, CP0_EPC
>         /* Subtract/add 2 to let the ISA bit propagate through the mask. =
 */
>         PTR_LA  k1, r4k_wait_insn - 2
> -       ori     k0, r4k_wait_idle_size - 2
> +       ori     k0, %lo(r4k_wait_idle_size - 2) /* %lo() for LLVM < 21 */
>         .set    noreorder
>         bne     k0, k1, \handler
> -        PTR_ADDIU      k0, r4k_wait_exit - r4k_wait_insn + 2
> +        PTR_ADDIU      k0, %lo(r4k_wait_exit - r4k_wait_insn + 2) /* dit=
to */
>         .set    reorder
>         MTC0    k0, CP0_EPC
>         .set pop
>
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
