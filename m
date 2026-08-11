Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086D2F39B4
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409492; cv=pass; b=OTzQQaUV57G8g2YV/cQ6kdaZZtbRVZQguxrkQAHGl5PGG2kyPUQgOwY3HTJZjQtPyV3I632a9VBi/ZR6p8lxYH9a5KaMwzfqtsAr06VbRIM+LTFpDogZsgBWGc8LKpg24QB9ZZBj7NON7zJ+0tGusdHiK3neVnlH7QKXHzy9W44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409492; c=relaxed/simple;
	bh=CRzFbVwmJ8kRC2gMZZ9OCRPLmKb0rwiRryrioE9kWw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdGHQ+CtWUECl3b/jI5MGbJETsVvRyIjGC5IsoeWn3tW2JWUEGtcadSmuTpWslg1IOoXXP6iEaj9H5i4HKI5sIybk7gGS/zUjjpG2aHqG6O4u5Ti9eEoQGzRo9uSpHXYQEPLPgOeaQShXJwAp9gJvJD/sJfbPPXOdfQwmqX4xtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bourg.net; spf=pass smtp.mailfrom=bourg.net; dkim=pass (1024-bit key) header.d=bourg.net header.i=@bourg.net header.b=IsamSwuE; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bourg.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bourg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bourg.net header.i=@bourg.net header.b="IsamSwuE"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso2149643f8f.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 17:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786409488; cv=none;
        d=google.com; s=arc-20260327;
        b=SNxyIhIkcIOBWXrJi7FJCl4XxydDqY7UHLA4YURMJ/1NCBleJmcP6ra1+HWHEmlyRL
         Pp1LtdZlnTcf/Ki44y8EI7ZkLLe+hNP/eHcmHjpI7Pet7WTw32v08z/9iIx04xMa8h0Y
         ZEAwJg7YuTxkpoLiTlKQKA7cFin3PTsQNEkHM49VKnZiZBiKROJr8zNliKoUxM+ENqAj
         rmBa10YEppRZ1FnKqk+TEPBVgjJA05ruXTqcEQJciCk9kMVpY0J4zOCLxPCDqUtYl63R
         qMnB6nbRClYexy4m+SDvDU3hOkNtgIS44gFhD5/beqqGKnSI9wWCuNQH4ItiBD+dROb7
         zmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TU+gUe471oYilrCT6YTzzByDjScHGGMPSU9HnUH7Czo=;
        fh=ySiys70pB9VrR4kDQuR8qIC60F1wL0V/DwfmkA2dj+M=;
        b=jRv67L10Q1aRKzE746uR+5HZ6acRC4tfpU74GkVnwKH67jkmyl7EYS5IS2inO21g5n
         HU18ftLka79LL7cDwGKja4IuGan1IZcJZnPOY+ZyEIsyJyii6pJMfiLw7bhYIs8f2Y31
         VOSrmWfoJ1ycD733WltE++ZJJI64pumRI0IkBHAiJtSv+qYO0S6MIIwwSV883PgvIt9O
         jqB0EgH8HlmRuFAGE3P1tC5JPtDJ8aLfSI3lYq8x2QOPX2wBXPvLktpSuigmBHTNtmOw
         VtinpuPBwJKgSB+hJ5Op/1I5pb3OXRVig8DjqowOCBAjfBQKYXa8hbEPIglDSBIGL3sl
         XfZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bourg.net; s=google; t=1786409488; x=1787014288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TU+gUe471oYilrCT6YTzzByDjScHGGMPSU9HnUH7Czo=;
        b=IsamSwuEZGskLN6CdZByVP5E1eE6HbFQj9/cogQzbF0nxFmtiDzCUjag0xFALS7SrO
         WvXCGp3DxbOvl6N1lZz21PWXInQ7NhRU5+VYmXpeBb17QPNz/WPIdT0UpQYq3EAJYMw+
         9gy8T77cPshjaQJ3wfMv+KFrhPSYEtb3BvUlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786409488; x=1787014288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TU+gUe471oYilrCT6YTzzByDjScHGGMPSU9HnUH7Czo=;
        b=MYe6w8kMgPJ+41oy3nMh3jokTigZfdTQJAyWjPymQWE1HOcd9gZJGAbOf4F2sZUqy4
         DNFl18RD4w1tUTpEnnedbw2v10/+bO40eonvTqKZVPEcJl8k97elws2Hw4rR1cks0DBh
         0aUeFVyBHjiSVelpjbjkEvJ/WbrCP5XmjZpx7dd8MNHI4lA+S+znYQBxex46R0UhezYq
         UA5/lxlXb7kS5Kkh12ZH/ZUWS0ToCSQeg+dZlcsCUtgAbgNAYINBltsmmx3Wn0kziLY8
         uiGSw6Dq2JPj2jiZUlyGn7IXkH+fI6zOlgF6csNKrWyjFFkf0vCgdJ9oUqfKEHiszMQK
         wtqw==
X-Forwarded-Encrypted: i=1; AHgh+RpgDiWQ1kqrJJlvMgo+j2m7Bnk33w0qNzZLNQBlmAEU3iPFZqV8ueIWnLXo1QQU/IhB3HQ755s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwgFjVotKpGbbh2uwWmFrKpIB4cx5qz3O1cXT0P2o5lajjtAvA
	Yq7NtpqbBXgOjMy61J6t61vb3ZIEIpSlKJPST+nMwBqb6tGzz7MFi52SC/n7jvbLJdGtY3+JPqH
	7Y9MF3onB53AvPfYImcEHuXB6oKAlFWUBZ45oZq0zFA==
X-Gm-Gg: AR+sD13P9yhVVPc+DDQMQAh8SikOqJ0BA08p0qjERLraEdRQHjX99OZ79Qa7i8c17az
	aGKTk0p0WiTnhxAjJEQyyUWxVb5ojcWnbP6txyuEVxUlG+S+qU1DNHeKUXMw0yM5PusmQOm/705
	KyzK3hvsB+nTEtRspZucSJpShQOU/R4wezQobLPUwsOJqgZsNMhRO5p5SuAbxDRdDwV8Ne20LuC
	hLasJbVG5zSovTE0Exa9gxGU5m1muC4cOcD6+EuAQ7hUJqyHX0yIvk6LwtkEmoH+gjPkqDc4NAs
	G0id7U5fjII3kFDCRgFEiLnNs9Cj0Ec7Gd980OnQwt7R24x9P+OvBDmAcKdVrr3otdq3qoCSESE
	1
X-Received: by 2002:a05:6000:25f5:b0:47f:8810:cc64 with SMTP id
 ffacd0b85a97d-48130ee5cafmr34643521f8f.19.1786409488054; Mon, 10 Aug 2026
 17:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806000144.3388823-1-gus@bourg.net> <anXMug2_-vZl_pZ7@willie-the-truck>
 <30c5499e-8041-4e39-933b-c5220d53be77@app.fastmail.com> <anmwTDnFR2cgxkqR@willie-the-truck>
In-Reply-To: <anmwTDnFR2cgxkqR@willie-the-truck>
From: Gus Bourg <gus@bourg.net>
Date: Mon, 10 Aug 2026 17:51:16 -0700
X-Gm-Features: AUfX_mwbCQk-FDI59ImICq7SHb4tBkCUGzUKvFPt1wRrD1_jDiCNvRoPevXtuBc
Message-ID: <CAKL=SEpvBqMjw2Ts4ODYHCJz0K1axwmtrUGKQEJeb_rvuAQk0A@mail.gmail.com>
Subject: Re: [PATCH] arm64/efi: Do not call EFI runtime services preemptibly
 under SW PAN
To: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 4:04=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Aug 07, 2026 at 04:56:00PM +0300, Ard Biesheuvel wrote:
> >
> >
> > On Fri, 7 Aug 2026, at 15:16, Will Deacon wrote:
> > > On Wed, Aug 05, 2026 at 05:01:44PM -0700, gus bourg wrote:
> > >> From: Gus Bourg <gus@bourg.net>
> > >>
> > >> When PAN is emulated by switching TTBR0_EL1, arch_efi_call_virt_setu=
p()
> > >> installs the EFI mm into TTBR0_EL1 via uaccess_ttbr0_enable(), and o=
nly a
> > >> return from exception ever puts it back: check_and_switch_context() =
skips
> > >> the register write by design ("Defer TTBR0_EL1 setting for user thre=
ads to
> > >> uaccess_enable() when emulating PAN"), and __switch_to() does not to=
uch it
> > >> either. switch_mm() updates only thread_info->ttbr0.
> > >>
> > >> Since commit a5baf582f4c0 ("arm64/efi: Call EFI runtime services wit=
hout
> > >> disabling preemption") the runtime call is preemptible, so the EFI w=
orker
> > >> can now be scheduled out inside that window. An involuntary preempti=
on is
> > >> harmless, because __swpan_entry_el1()/__swpan_exit_el1() save and re=
store
> > >> the state around the exception. A voluntary reschedule is not: it pe=
rforms
> > >> no return from exception, so the worker resumes with another task's
> > >> TTBR0_EL1 - or reserved_pg_dir - and the next efi_mm access takes a =
level 0
> > >> translation fault.
> > >>
> > >> There is such a preemption point in arch_efi_call_virt_setup() itsel=
f,
> > >> immediately after the TTBR0 install: __efi_fpsimd_begin() ->
> > >> kernel_neon_begin() -> put_cpu_fpsimd_context() -> local_bh_enable()=
 ->
> > >> preempt_check_resched().
> > >
> > > Hmm, can we move the ttbr0 toggling until after __efi_fpsimd_begin() =
so
> > > that this preemption point doesn't interfere?
> > >
> >
> > Either that, or tweak the logic so that the switch is done eagerly in
> > this particular case (untested):
> >
> > --- a/arch/arm64/mm/context.c
> > +++ b/arch/arm64/mm/context.c
> > @@ -266,7 +266,7 @@
> >          * Defer TTBR0_EL1 setting for user threads to uaccess_enable()=
 when
> >          * emulating PAN.
> >          */
> > -       if (!system_uses_ttbr0_pan())
> > +       if (!system_uses_ttbr0_pan() || mm_is_efi(mm))
> >                 cpu_switch_mm(mm->pgd, mm);
> >  }
>
> I think I'd prefer to avoid special-casing this, if we can. I was just
> thinking of the diff below.
>
> Will

Tested the v2 approach (__efi_fpsimd_begin() before
uaccess_ttbr0_enable()) on the board that originally reproduced the
oops: Khadas VIM3, Amlogic A311D (4x Cortex-A73 + 2x Cortex-A53, no
FEAT_PAN, so CONFIG_ARM64_SW_TTBR0_PAN is in use), EDK2-based UEFI
firmware, v7.0.12 plus this change alone (my prior workaround removed).

Both firmware description modes were exercised (DeviceTree and ACPI
boots of the same system):

  - 3,000,000 GetVariable calls (three concurrent readers) plus
    200,000 GetTime calls per mode, under sustained CPU contention
    (busy-loop load on half the cores to force scheduling in the call
    window) - i.e. 6.4M calls total across the ACPI and DeviceTree
    boots of the same system
  - SetVariable create/write/delete round-trips in both modes
  - ~15 reboots/power cycles (ResetSystem) and clean shutdowns across
    the session

Zero efi_call_rts faults and zero "Unable to handle kernel access to
user memory" events; efivars and the EFI RTC remained functional
throughout, and poweroff/reboot stayed clean. Under the unpatched
preemptible path the same board faulted within thousands of calls with
comparable contention, so this comfortably clears the reproduction
threshold.

Tested-by: gus bourg <gus@bourg.net>


>
> --->8
>
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 30cd7f804398..0ec90fd1754e 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -184,6 +184,8 @@ void arch_efi_call_virt_setup(void)
>                 efi_virtmap_load();
>         }
>
> +       __efi_fpsimd_begin();
> +
>         /*
>          * Enable access to the valid TTBR0_EL1 and invoke the errata
>          * workaround directly since there is no return from exception wh=
en
> @@ -191,8 +193,6 @@ void arch_efi_call_virt_setup(void)
>          */
>         uaccess_ttbr0_enable();
>         post_ttbr_update_workaround();
> -
> -       __efi_fpsimd_begin();
>  }
>
>  void arch_efi_call_virt_teardown(void)
>
