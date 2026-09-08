Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F42554087
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873775; cv=pass; b=iiA0xMc6tS+IOKY/RnoQ4FME68DURyMI8uHFoDzG92qVTEZkXe2WPlXYfmKb5GTZh3Jp4aUvZqFayFqN/Z38DaG+PNNH2FHuHFa1CQSODwgI/bCwOt22Lx/uc8+t5BipQsQvuFZ+S9v0H0933m6d5vRyTeaOIk5mrJALZopHQeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873775; c=relaxed/simple;
	bh=A7SfgZQR67JkHs4RtZ5PrBDPAkQ3dc73TAafXDV/A8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pyos4H5D6YRKKaajVGeo4OygjJVLF1yWCyxkPvZOrdzCxKiRA8gBu91skecUQtaUeKJ1ctgSDiglJ3N/IZ/Z3/Br0SlLhhFw2nrFkN/Bdpca5bqZ0aotqalqGsWp1n/DEgyHRDE1SPmhEdMhVn3N8vjLqKUWx4OrhXtSOD0bGgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx4Q8uXk; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx4Q8uXk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c252c7270faso679108566b.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 06:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788873767; cv=none;
        d=google.com; s=arc-20260327;
        b=KWjkXN5gjewwtmpYNewNPFArAdVMvwgHagHIMzVHicplnKxNa6c8E7PqyeYwtI8bqQ
         wWqrglkxsxGae+ISybuB4nDaKEt6CS5/SNApEO0OYgdglhaFjeZ4Tfk7v1D1jwzxdLkj
         fdwwi4+yISyqBTaMxTYK/vveFYF/xVwNXtrPO6M8Eata2fXcW8HsU3I3zlsSKprE98MJ
         LOBXa4C6NCXPz/D4txnGPq6XF5X2NyVNETsu4dhU/hMPjhlYyIILpYDr+MEWST/tX2xv
         VW2725D/7swTkVEu5OgvVu0FHOmuWht3zFWFkYTRycVaQYbzrUKj8qyRZ33yANGuMWYO
         j+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dHBGY2kA/rw8G86NktdRbSCOC4KbfeB6+f4Od1S5INw=;
        fh=HBHM0eodzmVwR8vO3JqVyfNUEdO3Q9Ezgmln1d+gb+c=;
        b=Nna+IFQ5NCzHjFasJbG5fDQXUM8RueMTfrJjQQpAR3ls6tecqxvbjFABPaWQfwnxtP
         n3uTOAmsK+uokR8gT+RIatm8zb4wNG5v/KHdINgOD6QNK9GyedEL0K4JcojuYYecGxVA
         3+BtcgpEF9quQnJCWzBv066P/xSnA4H12ZIpwiUWTTWhJsCxudLPoV9kBdOk1ty2rOFV
         CLFXYxxFhD4fCfCArXEKc/KcchUU42cuGeGgicw5GY1JNZ//Bi4kym8EmTyUZBeleMNw
         9OJddjdaiU2bHIs4CVkpjbJS76N989No/N/d/GBJgaeh6bXI3Uko1oGUIFO/KMWqi5G6
         c16g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788873767; x=1789478567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dHBGY2kA/rw8G86NktdRbSCOC4KbfeB6+f4Od1S5INw=;
        b=gx4Q8uXkyOmUVZKhzbF5mvFtvjRldZuZ+LBIQ51Ukb1Xp6/mvHxbzuuXYg/1J607ss
         A2sPkk5zZf1RiJ83RKArKJVMyD6InZLqvz/FrGnN3sL4NSbN3+7kN8gXG9W/CuOLgpYH
         re3UVSRFmCNUluAcNrH7C9qrStCcvIIUZFjyTfGmQ5LQCsrNJ0GgvwTmfte2G1mMUD8D
         nEyuxQAPeD20V1i4kUx948EkqcB9F3HAryVlppwiuC9EIstqsqZpLFadO4kN4j111Ig0
         MdIhngc25fZXRANz6CXR7VYsoAwYbfnbQzoQ8QaHVpsPtoggXvSEAPjLXEkGTcQSVDfi
         WXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788873767; x=1789478567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dHBGY2kA/rw8G86NktdRbSCOC4KbfeB6+f4Od1S5INw=;
        b=aGInERiBLWTy8JtuXcr5a55loJNsQ9LzAW/G0NDCc4krh2eS7Sc+weaOfRYHsq4ijD
         G9jOGwrUrueyAlt9CuEy+iKf6eBQ+zCaTIXUbZXIFJBMXsMgSd2kHjNtnObB4nOK9Jiw
         bLcqDM7p3VVTv83QDWjD7R6EL/G4uKCpzMlBboxTQZcJzwNqkHyg6Zh7/3zJzixiD5ex
         yheGyp4tCLXzBL4VNZzt3NSJDhsml3OVr0qeh/1xk11YLu1A2TwYHV/l/BhIAESPnKG5
         XM1iZJSieRyePSP+9FGLpGixRjSUTEFfvZiOlcQzlf1r00io75EcR7Ekp3V6RM5yjKK7
         b8sA==
X-Forwarded-Encrypted: i=1; AKwUvByHHiUd8t4BRg0r+RbxB/GhwaX/dxvgQWCTn4lGP11qiBzhsm5jBHFv92DdsS1799UNZ55YRtk=@vger.kernel.org
X-Gm-Message-State: AFuF++meR8FEuS//6Tm6MwGO/y/lhs0+j3RZaA5KkTDV2Qm0TFNWWKzB
	2q/kJ3QAwmZiZWnPkq6fdFRVKyJQ410ogZzYMLKtannyctrAz/lQdnuJlERdPKIbfIdspRrHPKM
	C2YrHF2hHMUuhc7pyYl6dFH6JeTATle0=
X-Gm-Gg: AYBFou0ykpvBEP3kfaXyji67q3aez+GjT9HVzOpky3XTz/gsLfjGBMWt8m5/fw4jY8O
	NpMqhebUiWloY8ZLNlytWOPRH9eVcIWw7uXtLBXMtsM4Mct3WxVR5YZJxdUKZy0DbwAYNHRWpoj
	Ty9kWxVDxg+PkQUXi+Nbkj2V8lCHNrMoDz/2o4nJtofi+WiDel4tLCi0dlmpuJhGNkW0nNXiUWX
	D+GVktrHpUZCJJZSFMftS56t32xXO2W6LlZ+DCuGOombBhL/grr6T0fbaTS+qA486k9ZCP3JP+H
	X1ElgB8kgBcB9EpTM1QUU4SZyNETCRlWC6ILTrkP/A==
X-Received: by 2002:a17:907:3e1a:b0:c24:87e5:6491 with SMTP id
 a640c23a62f3a-c260c971f12mr1992348866b.2.1788873767245; Tue, 08 Sep 2026
 06:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-b4-x86-cfi-fineibt-func-hash-v1-1-6ffc0af5c4ec@gmail.com>
In-Reply-To: <20260831-b4-x86-cfi-fineibt-func-hash-v1-1-6ffc0af5c4ec@gmail.com>
From: Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
Date: Tue, 8 Sep 2026 09:22:10 -0400
X-Gm-Features: AcwNN1WsRJreg-ZsABv9wLtOKN98BlTKw209GAXhviOOfU8RHEZMXLmVgvJqFLc
Message-ID: <CADAM+B2jgDiyShSSXYoUG36C7yVpjx2NrhP6tOHeDjB0h+GvTA@mail.gmail.com>
Subject: Re: [PATCH] x86/cfi: Fix FineIBT hash offset in cfi_get_func_hash()
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 10:49=E2=80=AFAM Soheil Hassas Yeganeh
<soheil.kdev@gmail.com> wrote:
>
> The switch of the FineIBT preamble from "subl $hash, %r10d" to the
> shorter "subl $hash, %eax" moved the hash immediate from offset 7 to
> offset 5 of the preamble. fineibt_preamble_hash was updated to match,
> but the open-coded offset in cfi_get_func_hash() was missed and it
> still reads the hash at offset 7.
>
> cfi_get_func_hash() is used by the BPF JIT to give a struct_ops
> trampoline the CFI hash of the stub function it stands in for. With
> FineIBT the trampoline now gets the upper half of the real hash
> followed by the first two bytes of the next instruction, so the first
> indirect call from the kernel into a struct_ops program,
> tcp_init_congestion_control() calling ->init() of a BPF congestion
> control for example, fails the FineIBT check and the kernel dies with
> a CFI failure.
>
> Move the FineIBT preamble template and its offset defines above
> cfi_get_func_hash() and use fineibt_preamble_hash there, so every
> reader of the preamble shares one definition of its layout. The
> CFI_FINEIBT arm is only built with CONFIG_FINEIBT, the only
> configuration in which cfi_mode can take that value.
> cfi_get_func_arity() does not need the same treatment: the __bhi_args
> call whose displacement it reads still ends at the function address.
>
> Fixes: 85a2d4a890dc ("x86,ibt: Use UDB instead of 0xEA")

Gentle ping on this one. To recap: since 85a2d4a890dc the FineIBT preamble
stores the hash at +5, but cfi_get_func_hash() still reads it at +7, so BPF
struct_ops trampolines are emitted with a wrong hash and the first indirect=
 call
through them (e.g. a bpf tcp_congestion_ops .cong_control) hits a FineIBT #=
CP.

We have large scale panics when we use BPF congestion control.
Happy to respin if a different shape is preferred (e.g. moving the
offset next to
the preamble definition), but this seemed like the best way to fix the issu=
e.

Thanks,
Soheil

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: stable@vger.kernel.org # 6.18+
> Assisted-by: LLM
> Signed-off-by: Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
> ---
>  arch/x86/kernel/alternative.c | 72 +++++++++++++++++++++++--------------=
------
>  1 file changed, 38 insertions(+), 34 deletions(-)
>
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
> index 91b1cdd16569..1b22062cabfe 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1198,6 +1198,41 @@ static bool cfi_debug __ro_after_init;
>  bool cfi_bhi __ro_after_init =3D false;
>  #endif
>
> +#ifdef CONFIG_FINEIBT
> +/*
> + * <fineibt_preamble_start>:
> + *  0:   f3 0f 1e fa             endbr64
> + *  4:   2d 78 56 34 12          sub    $0x12345678, %eax
> + *  9:   2e 0f 85 03 00 00 00    jne,pn 13 <fineibt_preamble_start+0x13>
> + * 10:   0f 1f 40 d6             nopl   -0x2a(%rax)
> + *
> + * Note that the JNE target is the 0xD6 byte inside the NOPL, this decod=
es as
> + * UDB on x86_64 and raises #UD.
> + */
> +asm(   ".pushsection .rodata                           \n"
> +       "fineibt_preamble_start:                        \n"
> +       "       endbr64                                 \n"
> +       "       subl    $0x12345678, %eax               \n"
> +       "fineibt_preamble_bhi:                          \n"
> +       "       cs jne.d32 fineibt_preamble_start+0x13  \n"
> +       "#fineibt_func:                                 \n"
> +       "       nopl    -42(%rax)                       \n"
> +       "fineibt_preamble_end:                          \n"
> +       ".popsection\n"
> +);
> +
> +extern u8 fineibt_preamble_start[];
> +extern u8 fineibt_preamble_bhi[];
> +extern u8 fineibt_preamble_end[];
> +
> +#define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_s=
tart)
> +#define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_s=
tart)
> +#define fineibt_preamble_ud   0x13
> +#define fineibt_preamble_hash 5
> +
> +#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
> +#endif /* CONFIG_FINEIBT */
> +
>  #ifdef CONFIG_CFI
>  u32 cfi_get_func_hash(void *func)
>  {
> @@ -1205,9 +1240,11 @@ u32 cfi_get_func_hash(void *func)
>
>         func -=3D cfi_get_offset();
>         switch (cfi_mode) {
> +#ifdef CONFIG_FINEIBT
>         case CFI_FINEIBT:
> -               func +=3D 7;
> +               func +=3D fineibt_preamble_hash;
>                 break;
> +#endif
>         case CFI_KCFI:
>                 func +=3D 1;
>                 break;
> @@ -1363,39 +1400,6 @@ early_param("cfi", cfi_parse_cmdline);
>   * anyway.
>   */
>
> -/*
> - * <fineibt_preamble_start>:
> - *  0:   f3 0f 1e fa             endbr64
> - *  4:   2d 78 56 34 12          sub    $0x12345678, %eax
> - *  9:   2e 0f 85 03 00 00 00    jne,pn 13 <fineibt_preamble_start+0x13>
> - * 10:   0f 1f 40 d6             nopl   -0x2a(%rax)
> - *
> - * Note that the JNE target is the 0xD6 byte inside the NOPL, this decod=
es as
> - * UDB on x86_64 and raises #UD.
> - */
> -asm(   ".pushsection .rodata                           \n"
> -       "fineibt_preamble_start:                        \n"
> -       "       endbr64                                 \n"
> -       "       subl    $0x12345678, %eax               \n"
> -       "fineibt_preamble_bhi:                          \n"
> -       "       cs jne.d32 fineibt_preamble_start+0x13  \n"
> -       "#fineibt_func:                                 \n"
> -       "       nopl    -42(%rax)                       \n"
> -       "fineibt_preamble_end:                          \n"
> -       ".popsection\n"
> -);
> -
> -extern u8 fineibt_preamble_start[];
> -extern u8 fineibt_preamble_bhi[];
> -extern u8 fineibt_preamble_end[];
> -
> -#define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_s=
tart)
> -#define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_s=
tart)
> -#define fineibt_preamble_ud   0x13
> -#define fineibt_preamble_hash 5
> -
> -#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
> -
>  /*
>   * <fineibt_caller_start>:
>   *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
>
> ---
> base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
> change-id: 20260831-b4-x86-cfi-fineibt-func-hash-e160f6eee02c
>
> Best regards,
> --
> Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
>
