Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF27543CE69
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459297; cv=none; b=T474AmvJ0kJDRBQxDUQizDJgTztTETiKivlglbDi0sNr/WYYK+7RKBXhkqcXgfIemY48AF4JTGc+5cdpcQoyIcqNBhQ1XSk/AAwsqZVL2dWh8j/WRiRZfrv3DB7b6JGrccIVstoAybwZPki3WGQ3Im1Oqre4aTLhxSMTEpmvC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459297; c=relaxed/simple;
	bh=Mqam+9yetwgnihtDcPkksRshcXlcKbGA5O84/n+y/Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTidbcKOeyS1SPI2t/8iLgnw8XRLJNXU7e3q5KI0vAwRZFr0knFR14AUxyJ2MS9H2izcqi8Ztr6VIp0N+wW5Cu33uIJUSzLDTJkn9Bz6rbjq+lrCuTSQjOpSpMT2PGKfpZP9NsbfYaA+Uf85tK8n4x1Wbe0LhB++x/E3prqHH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfqeRKnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfqeRKnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDED1F0155B
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786459295;
	bh=xdXgRqs7Nr1fLxjk//ew78HlNUVWPILwUi7Fxa2du00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BfqeRKnTSHza2m4ZbgzufxURoNhXHn/55WSk1QDBxuYMPAlUP55GZ5aCBeY9y9cHw
	 oxCU4RxDQ9yVad0X8z5QTG1f0sOkjtu7lBwpyu+GxSSTy88fXdyCiRa4o+Tnpw9H0V
	 Bnoi6gjzXafo9uM/Be+6kEVqGon7dEQan6scVIslihTxSpZWJ9Gw9BE84VPpkOQqQF
	 FMWqWZESRdIym/Z4R8ZO/yh/SAD/L17Ja60Xo5gjT/9q8ZTPDMEqcGITzRpKHkJaQr
	 XHBZ9cHC4DjiEcZpG/Tm7WHh+gnNhf2e3Qzz4fd0XOmBxU6LDgFgAXlRKuoCJx0nIx
	 SSriCOLFTecTA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so3532317a12.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:41:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrtiuTfhM5y/S5rgqevBYIeqd1jdvkNNnWeNE1w/cUiKOH/KqWMde34bQmqDmRtVt7RgSI3T+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbvo+M9Ym8qIBmP2ZJ22I5aNJoRNhc+gRwlvoPwm0UF6RBEKK
	zy2yi72PkrHV9movK2hIYg0Z3ah9Njds2jyl0AtGZIm38bqNfSIojuFloByACC8kS4u++pfjY9V
	A36LWIjSrPGkHso7pkOvm5klYRhXcj/A=
X-Received: by 2002:a05:6402:a6c5:20b0:6a0:9cb5:4f33 with SMTP id
 4fb4d7f45d1cf-6a3644f660cmr1538034a12.13.1786459294109; Tue, 11 Aug 2026
 07:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811115749.3465579-1-gaohan@iscas.ac.cn>
In-Reply-To: <20260811115749.3465579-1-gaohan@iscas.ac.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 11 Aug 2026 22:41:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7FcV73VB58=zyscfCvP1L5sJ0CZTZ2EZNZkYB=X5dhAg@mail.gmail.com>
X-Gm-Features: AUfX_mwNj_BrvlUMS1ChJZwUqksdFIOQl2gtTOLntxho3QInMnkLV4UGOsmxN9E
Message-ID: <CAAhV-H7FcV73VB58=zyscfCvP1L5sJ0CZTZ2EZNZkYB=X5dhAg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: mm: Define DIRECT_MAP_PHYSMEM_END
To: Han Gao <gaohan@iscas.ac.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Tianyang Zhang <zhangtianyang@loongson.cn>, 
	Magnus Lindholm <linmag7@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Hongchen Zhang <zhanghongchen@loongson.cn>, WangYuli <wangyuli@aosc.io>, 
	Mingcong Bai <jeffbai@aosc.io>, Zhang Yuhao <xinmu@xinmu.moe>, Kexy Biscuit <kexybiscuit@aosc.io>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Han,

On Tue, Aug 11, 2026 at 7:58=E2=80=AFPM Han Gao <gaohan@iscas.ac.cn> wrote:
>
> get_free_mem_region() and mhp_get_pluggable_range() bound their
> search to DIRECT_MAP_PHYSMEM_END.  LoongArch does not define it, so
> the fallback in include/linux/mm.h applies: under
> CONFIG_SPARSEMEM_VMEMMAP it is (1ULL << MAX_PHYSMEM_BITS) - 1, a
> compile-time constant that does not adapt to the physical address
> bits of the CPU (cpu_pabits, probed from CPUCFG1: 48 on
> 3A5000/3A6000, 47 on 3C6000, 40 on the 2K series).
As far as I know, Loongson-3C6000 is also PA48.

>
> The vmemmap window only covers physical space below 2^(cpu_pabits+1)
> (VMEMMAP_SIZE), so on CPUs with fewer than 48 physical address bits
> get_free_mem_region() may hand ZONE_DEVICE a region with no struct
> page backing:
>
> - On the 2K series the region returned at the top of the 48-bit
>   physical space is outside the vmemmap window; vmemmap_populate()
>   wraps the range around and maps it into low memory, silently
>   corrupting the page tables.
> - On 3C6000 the vmemmap range of the region's last section used to
>   end exactly at 2^64 and wrap to 0, leaving vmemmap_populate() with
>   nothing to map, so memmap_init_zone_device() faulted while writing
>   struct page (reported with amdkfd on 6.16 [1]).  Commit 2969b42c8f99
>   ("LoongArch/mm: align vmemmap to maximal folio size") moved the
>   vmemmap base down by one PMD, which keeps that section in bounds on
>   current 3C6000 configs, but the 2K series is still affected and the
>   3C6000 case only holds for the current vmemmap layout.
>
> Define DIRECT_MAP_PHYSMEM_END as (1ULL << cpu_pabits) - 1 so that
> both searches stay within the vmemmap-covered physical space,
> mirroring commit f3336b48cf9d ("riscv: mm: Define
> DIRECT_MAP_PHYSMEM_END").
>
> [1] https://lore.kernel.org/amd-gfx/20250814032153.227285-1-jeffbai@aosc.=
io/
>
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  arch/loongarch/include/asm/pgtable.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index 223528c04d73..244931e4bc58 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -125,6 +125,13 @@ struct vm_area_struct;
>
>  #endif
>
> +/* Needed to limit get_free_mem_region() */
> +#if defined(CONFIG_FLATMEM) || defined(CONFIG_SPARSEMEM_VMEMMAP)
> +#define DIRECT_MAP_PHYSMEM_END ((1ULL << cpu_pabits) - 1)
> +#elif defined(CONFIG_SPARSEMEM)
> +/* DIRECT_MAP_PHYSMEM_END is not limited by VA space assignment in this =
case */
> +#endif
 ((1ULL << cpu_pabits) - 1) is not always smaller than  (1ULL <<
MAX_PHYSMEM_BITS) - 1.

So I think a better way is:
+#ifndef CONFIG_SPARSEMEM
+#define DIRECT_MAP_PHYSMEM_END (((1ULL << (cpu_pabits + 1)) - 1)
+#else
+#define DIRECT_MAP_PHYSMEM_END MIN(((1ULL << (cpu_pabits + 1) - 1,
(1ULL << MAX_PHYSMEM_BITS) - 1)
+#endif

Huacai

> +
>  #define ptep_get(ptep) READ_ONCE(*(ptep))
>  #define pmdp_get(pmdp) READ_ONCE(*(pmdp))
>
> --
> 2.47.3
>
