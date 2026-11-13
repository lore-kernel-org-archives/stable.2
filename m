Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794569489;
	b=ugnY9CYQFE2zzEyP2eHtcvhYL0vSln7E/Sd2JtX7CTwrSO4azc4vRFDqpAkVEoM0K1e3
	 SFnKhOS2BPeIWzZj/qffGoP43obzpKgsnwIxEdftX5SKYxx4PkKJexU6znlZwYS/DrX4u
	 pmxpKc2GD7l1UjXf0KqBMKy0Rqd7OClLoZsE26StH70fy/r4YCu70d9IWK482qDrLnLoD
	 lZOq1HTccSURK8TyWWwTqr+qp1Jx37pHnf5cAS1eWBiMX0oaSZXmmUIPzc9F8jADASAGW
	 t9pxJl4WNZZYA5szFpKqIZZoYgIR042trVlwPd+Z9HS1Lt3L6LZbGmSIw/d48Qkx8lQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MW//+eO8ifeDOMCGO0P1S62YlRWi+XpqU3MxHUVvu60=;
	b=Ic8qIk6n5gJi+dK/cOrYyqNXRrncjywdoK6L1Ss7z24lJuu4PctPyODjb+Q2TGUNRSzJ
	 HmEZegmVZl43C+b6po/ezjvoDtlpdiCOBZjaratrTjNwz8ru7gDR0s7mg4hDvN2qe8BEn
	 DLlxZ39365km6fSCBxU4gkAscrXj6abQ1fqpEbJOrGBE3a2RO66weYJ082eCWV+HfMbnj
	 3h8upGlYj+kSEdjJfEZH+G0cd3HBNEheLKpTqYghiJlvAEqfDx6LHrMEMxcRIMwOvUqrr
	 reLAegbFaBJykvck3g4o2vmOHIOD4wlLf6dAjHuqOx8F23AnvU8xoluSMrllLrnbAYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=eZzmiXS1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C13606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C13606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=eZzmiXS1
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so11959775e9.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:31:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794569487; cv=none;
        d=google.com; s=arc-20260327;
        b=kLAGcp7H2/2nvs9B3EoxPp1yVcR8N7hTv8Q/LVeBIQbGx0IPlp5FxkT+Ug6OwYGEmo
         Atr1MxXlfLXwYt/e5wz7u1RM0DvBB42PCZ9uIC+sA5Ri2ut/GcPkPUET2/jd+72JLJSj
         sxYohedPBniD+Pc2q/Ei4xMy74yZKpha2RmnHlIl2lE+jBZ+HtyMJsy4myqt2boR6n08
         9G/foXdVaQhmB8lRz7IYlw4DRcgoXE39I98mPTNQHSD1JkZ9T2/XhTWKSUCDHkhBkpJ0
         dUnRzkgBAChHwFnupx+J4d51KsxO+Z0AZz1pB6KOz7+uAV5eBCPUD24Lf0t946806xK9
         +ZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MW//+eO8ifeDOMCGO0P1S62YlRWi+XpqU3MxHUVvu60=;
        fh=MwkCyC6SCPnuQSzgD6b2iqqDBwepTbVJtDjlk/50qY0=;
        b=Ren/8xyWfUm7IQjsfUw9kt8pI9Tfoq790VSUbcQ6Pa4XCsYN8w42ZPEWZf6E9uzz8g
         xJrLm6Bfmc9gv2D8QJM1jJzK2duezMsYJHev2ZaZBrPCQOx50qttkJWpzupH+HaJH6eu
         JqC+IFV75TJq78T5XKKOr9RSWlogx1PCPs3u2BaWUHY4RJoMV4iUioviVcxT/hf79Ax2
         6H4d4j65wpXpaKFh+V8pIu4/MCim4I4OHgXEJ0bUNUsxzpRbdXNCzjn8l0HgpfbkupaE
         UYH1MAVLoQaKrjBjLbQUE/ly2qgrULbTz/1RIJio+WojBEWOn0nM3+WZVIASXilmpm6o
         BbNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794569487; x=1795174287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MW//+eO8ifeDOMCGO0P1S62YlRWi+XpqU3MxHUVvu60=;
        b=eZzmiXS1W7ertC3npfms2hQkBYqVgQr/LcUUlflv3tneq8J0mJ5P444hFb6/978208
         TbXAYPI9LkJPCQDpp/vCAYyIP1zaiHEDCIuJm+8Sb92+VIJCIdvVYA3iNoyTK7+6GE5u
         NqCfPMFxDINLqS8QqzmHmvHQMJ5+04z/ZTfYxx92fZrE7nMy6V2KRcS6ZXcA1PZColJT
         oz8+gg7kexH3CBh/bs7SW1hx1tH6G17iOXVD0i0jK8W1lEjEosxo4nV7A5mJ1DCHINzE
         lzBcz4OyivQBIVK2zmKovz5UEAA18tAObIxRKdgWDfBmJKIIsl8+TGObguqwlyCZyYaK
         9yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569487; x=1795174287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MW//+eO8ifeDOMCGO0P1S62YlRWi+XpqU3MxHUVvu60=;
        b=Q3q1ZSpWK3Isoz0Hz7sLvh4Q5NNNlp9h2WKrYzzbvaUKcQGn0pUs4xSV+czoACC0gp
         ENKxggSnMv/nHAjQDIBfzJErc6v7dHIafyivQtoPjwt/VoIWCcuOA9Uy9iu8f1HjEN4s
         ReQKHrIVRqwKu2+o27YX1Q36ffOABCE55Q8+urfgu2wfkoPs2iESBNqaQAGX0FcMArIz
         SlSpXI2dIJ/+EM8YtjU9iViWUVhWML/tpaYCBIkbTd62sBcqGaBGO6rL5YQa52qW7rj3
         b0CM87/a9K5yT5KUlnBhij+EmmqQMSihda6KmTcvT/JhRVZhgelP+1vO1ZJEAB8u5syv
         QpXA==
X-Forwarded-Encrypted: i=1; AL+hErHTFBYrCtng2HqoVgbHll4iDPRv6Q0+4gX9SOnO5PktDi784Hm76Q8KPtoPFAiIoj6JvfNJ4CM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9p01nqk+eJUf47DxyC6tiVJf25s7Ad2gQY1FDsB4JzV2fU8ckD
	94jrbSutILX82ZauCYwsnbchd813DROAInhD4iGC7s//l9CaUvDsqhAJ1gImZ2iDWF+Ah83+mfT
	18P6f+MX75x66Hf19jVo4lADnzywOVlHeQVf3FAHwiw==
X-Gm-Gg: AYBFou1ELMPRNcE23bhoHr90VAWZUMWBotC3EtRSAlmoz0we0SmhzYz7nQbj8uU0ERJ
	xipMlpuyt1DCnZrXF4a8K4HvhUc+8oI68k/LGQ/KmzbpBrlrmYLvilgMqnDHhZ4uhkQpLy1EepC
	sKPbJQX/QWPV71zohEcjwgxw82jtmJ2h784AUyk+SAC4zY3CU3Yxh5qthIW1v7HdBXUyUwhEbQE
	6NbooqYafAYfM1SIgU6VJO2Oc0jNA0mW6EVH61uP7068eQ4cV/6AYkiaVxfqsS21wHqOQQ579s+
	utjwfaDW7P+e1HoBvwgxLMjcrqaY8WHKRtfXPP3KDhhhttPAXtYeyIo/sFvkpQbQ25jBcXt7lxl
	WJHRLjLnC3aCUHr1vV46bLehNJifs9nhQACCc6TWwlSS9dPeo58t41J+YjJllz4wWSQj3dBRMfN
	495jJl35Jk4ymHGI626y8zmak5oIwxoTgyZ/4pGuoiz1hl9GC6lNcrs2U=
X-Received: by 2002:a05:600c:8b55:b0:4a2:a3b:7aa8 with SMTP id
 5b1f17b1804b1-4bb55a02927mr44985235e9.3.1794569486922; Fri, 13 Nov 2026
 03:31:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016101458.221648-1-suunj1331@gmail.com>
In-Reply-To: <20261016101458.221648-1-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 17:01:15 +0530
X-Gm-Features: AclHuK90R6Cy2P8s5V5asYEwdHQCx6nGX6JWvDYYKndKeaNm5EjrRpe8coA3QcE
Message-ID: <CAAhSdy2KUD5xXFeKY0OD=iUzQzRHW87KjCamPQxcdxK-riq9FA@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Set Accessed bit in dirty-log write fault
 fast path
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: atish.patra@linux.dev, tjytimi@163.com, inochiama@gmail.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	andrew.jones@linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:45=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> kvm_riscv_mmu_dirty_log_write_fault_fast() considers a leaf with W
> and D set already handled, even if aging has cleared its A bit.
> On hardware that faults when A is clear, the fast path returns
> true without setting A and skips the slow path that would set it.
> The guest retries the same store, but A is still clear, so it
> faults again. This repeats indefinitely, preventing the guest
> from making progress.
>
> Host reclaim or page_idle can trigger this while dirty logging is
> enabled, potentially hanging vCPUs during live migration.
>
> Require _PAGE_ACCESSED in addition to W and D before treating the
> fault as handled, and set A along with W and D. The existing
> cmpxchg loop retries if aging changes the PTE before the update.
>
> Fixes: 7705be59eb2d ("KVM: riscv: Fast-path dirty logging write faults")
> Cc: stable@vger.kernel.org # 7.2+
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.4-rcX

Thanks,
Anup

> ---
> Testing:
>
> On a HiFive Premier P550 (EIC7700X, which traps on clear A/D bits),
> run:
>
> dirty_log_perf_test -v 3 -b 256M -i 3
>
> While the test runs, repeatedly mark all system RAM idle through
> /sys/kernel/mm/page_idle/bitmap.
>
> Before the fix, the test did not complete its first iteration in
> over 11 minutes, with lock_stat showing about 16k read-side
> mmu_lock acquisitions per second from the fast path.
>
> After the fix, all three iterations complete, each taking about
> 29 seconds under the same aging workload.
>
>  arch/riscv/kvm/mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 78a1826c466d..042d1e3b3547 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -591,14 +591,15 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fas=
t(struct kvm *kvm,
>                         dirty_marked =3D true;
>                 }
>
> -               if ((pte_val(old_pte) & (_PAGE_WRITE | _PAGE_DIRTY)) =3D=
=3D
> -                   (_PAGE_WRITE | _PAGE_DIRTY)) {
> +               if ((pte_val(old_pte) &
> +                    (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) =3D=3D
> +                   (_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED)) {
>                         new_pte =3D old_pte;
>                         ret =3D true;
>                         break;
>                 }
>
> -               new_pte =3D pte_mkdirty(pte_mkwrite_novma(old_pte));
> +               new_pte =3D pte_mkyoung(pte_mkdirty(pte_mkwrite_novma(old=
_pte)));
>
>                 if (kvm_riscv_gstage_try_update_pte(&gstage, ptep_level, =
gpa,
>                                                     ptep, old_pte, new_pt=
e)) {
> --
> 2.52.0
>
