Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0094BFE6E
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497404; cv=pass; b=TzfvKavAw38srVKXvzwpAsdQn5kq8uRNUMG7M6RiLao7LY0JjFxvtu5B/DJhovsdaP6ofRpmBCGiLFCqXNPU2Ah+Nuju8ZWSbwodq4jpUE9FbscWWu2v6AdhVwidXEQUiC5nBO9YQa/WZKcjAH51qDgk6TSgkWxQTRSFTenWx14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497404; c=relaxed/simple;
	bh=0fAJ96KToGBaJVYivQxfXHrnlsaMATy4LRpTL6ELZ7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbLqOP2xU9I/hkNdCxDmxxMalbC23hrdFLhwPzd2IOhp9vfYvO+B7HoeLsANciGZTtdrOawQsdelJsrRabl/HAshCV7ZZdCuxKTvxxfggdvrY/xmJ2dAWoV4rvIPH67ndDdJOU/NYIyZJ9VAfSR/e6U6IK8Qu54nrm/rsSLLX7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imblA3iD; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imblA3iD"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c294ad260fdso186343666b.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789497393; cv=none;
        d=google.com; s=arc-20260327;
        b=C2lrE6rwnj0VJ0UPxJ6r/9dlcq55NujlQswr0gq3ZFn3y5rztO6Bnt2uwdUmfV2AdA
         CM+u4gECw222jQgSUAiY3gWZE6x4VlBnLEpDarHCOHNnyArNtAjWrBI9dqSiKKWpYe8z
         TsZU321TdNfUArTpzzWCNiQgvc+rY33R+S7T5lWbZNAuBWdDIlVxnm9Yn+Z10f7cLnVw
         XX9Ujc0decVvqwFBzXl/SbbgZ5l3S1S0WpLQSNEfemCCJleGkxSYGdRUv6VjGGWiLAbZ
         HiLYFTTjG0Vv04ES23us0VAUYL2lksZuY4dxXrR0UcUEiXUvSQ93vyLxeg8xyJqtGvmX
         0gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gIXlRpFwzAqF+gXj9N4lNHJj37A+1bZjmxnWxX0j5Uc=;
        fh=ODXfZ9++47dGO2IYNp+lISxoaDDqNPmvas8LncGPjMU=;
        b=IdAeOCXITxu37WPkaUzUoncrWmQFWsZ4zan0fz6MDyLrBJfSwQtR4IJsIFx+DC8iwl
         zXxRB5Y7WS94hoyPhkAGfKKXey83t5B0JlS4LRvFFTzcULsG5E+iDogYhMs71p04sBel
         YWGmjhHJ3ia2pyxoQx6s5OTwgyHghECxXN0bXbO4ctHLXamuJD3cuCmmWSP6rgf0dln+
         s3a7A0oA/DIFjsBkmCaVMWeRTf1ZH3W3/bL+xh+attoovBpt6OLpvQ/8pi0t/XD4YiVK
         yUI/ASYqS90bSWoGdNUewuN9z5A3zYXP7RaHwPXY9xJWzVGOKKti2msY/4BEmN/IklGr
         5oMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789497393; x=1790102193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIXlRpFwzAqF+gXj9N4lNHJj37A+1bZjmxnWxX0j5Uc=;
        b=imblA3iDClAKSsVa2bgWVIUxEPPlq3RSc9OuP5ZY7CURKGVC/HGgz3MIldEi/rr4YN
         ZUm+jBo5nbanqCuCwKJnTGfGlhqlcLBBZQkRP0828Mfe8KSMEHe6cIjHDP6MXL2+qr2J
         Q8luU/6AvQ17yIa5idPBk775lNVjxzCWgrj5y8KXKM3o/avD+W9CkpacPSpFwNROOZga
         FHF1rzCWwEpU2EAplRJXu073Zm6sxKuIlVaG/+7zzrx3B2Hqo8FxFnRTULzWdQwb41SJ
         6VVru0zdOjUJStmjcZQzpXsxMA85i0oke/Z0PTFq1J7qOTxUqB8Tuf7iFVeVCWE1OB+t
         FxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789497393; x=1790102193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIXlRpFwzAqF+gXj9N4lNHJj37A+1bZjmxnWxX0j5Uc=;
        b=uX3V0GGKsqUgk0hsySwASe8zZhySDOtF0esOWIp1QJf55d9dLDcHjbjnx92lY+G7xm
         9+5BWL2X5BKhey4zbOnhXMZjPX+dKM1LhYGEkOQcWzKuZLD0KmwP4aMvWJCUK7V9yFMw
         n/ibVTsb+jPYv1FGpXIlSHbEEwC//Z7f3VcRtfDXQgycc11SVqC+yTssmWaQ8xkiIMVn
         ugiG/ePQ5jGzXa8YRrZMmRQKt6eJunR2kDJid+8WcK+AYwyPEQSrocKOU9NNRBbce2EV
         R1yKAN5sAMkpEYRK/7HUoBpJpvTvp3Lv9RJCmQkWqsEcamWHa3Nbc/2qt4ip+WbaMO+l
         AEzw==
X-Forwarded-Encrypted: i=1; AKwUvBw0W2ydP/9L9HHswgb4J7uV/5HCqj/C+MbkvpeR7FsnfdkQ8Cm7zzbT8fbUaceP8VQ1cr8Mn64=@vger.kernel.org
X-Gm-Message-State: AFuF++kM67M3RdrA6tOiFwmySQw+DeA7trpc1lIPElSvQrXDpWWZfyun
	OjF6QEv0J8iNX0tUd0PbxN5CiCZbSsb1CSzkkmJV+sLuiZS/z5Kppx9cRI1zbQ11mpJ2Bi5KHlo
	wUss9sVMtcbCxqppXDz6Wb66bWIcgCW0=
X-Gm-Gg: AYBFou1lofGYYbjxQTv+eyMMtrq9RKYYLFYwfcgqhrCVi1CuvaxEk0gw6Lslz3RSJnj
	355hnvi9V2PSuEw6dmLpNvNk/Tgv1Hr1Iv2Sd8vduxXiRNkbbLqbC2xP+G8HEaFq33imi4WQ0BK
	MdNuCGE1Y0QqcWMtZ8CUeHsleGjsqhU33mwrTSXvDKmcW64dT6xOkeS1L6wHJ04gKJtLiAuK5Kk
	rc6sDGfsah40GWODJqar6ded5mTWGECldxxqLWqRrNs4mOH5AoNXTIbcZ4gREVF1UUnjgdWvVps
	EB1lfFuug/cVekD4VNgtS+rg3H98hDqdEvVq9LblLn1JFlMVz4np4Eqq/i5Ki6AY0hx1vEDPWhR
	XhnNMr2h8U8+R9nmeE6ZwqRJFTrhJofI2qT2sQatK
X-Received: by 2002:a17:907:c0f:b0:c25:f7dc:2d3 with SMTP id
 a640c23a62f3a-c29c8b917c2mr383788566b.20.1789497393092; Tue, 15 Sep 2026
 11:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826103012.240453-1-meatuni001@gmail.com>
In-Reply-To: <20260826103012.240453-1-meatuni001@gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 15 Sep 2026 23:36:20 +0500
X-Gm-Features: AcwNN1WcJfuWtzktYvt8Aa0_L2cgMeEC3hDziX2ljeuoLSbyMQO8ELH7LkNEO_U
Message-ID: <CADqcGBnQMBwAHLfeg_1Jvr5A_w5D-MmNJpCBHVMisiBp7mqfNA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: hp-wmi: fix heap OOB read and memory
 corruption in hp_wmi_perform_query()
To: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping.

On Wed, Aug 26, 2026 at 3:30=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> hp_wmi_perform_query() evaluates an ACPI WMI method and expects a
> struct bios_return header in the returned buffer. However, it only
> checks that the ACPI object type is ACPI_TYPE_BUFFER without verifying
> that obj->buffer.length is at least sizeof(*bios_return) (8 bytes).
>
> If the firmware or ACPI method returns a buffer shorter than 8 bytes:
>
> 1. bios_return->return_code at offset 4 reads out of bounds from the
>    allocated ACPI buffer slab.
>
> 2. If return_code evaluates to 0 and outsize is non-zero,
>    (int)(obj->buffer.length - sizeof(*bios_return)) evaluates to a
>    negative integer (e.g. -8 for a 0-length buffer). actual_outsize is
>    set to this negative value and passed to memcpy(buffer, ...,
>    actual_outsize), where the signed negative value is cast to
>    size_t (e.g. 0xfffffffffffffff8), attempting to copy ~18 Exabytes
>    and triggering an immediate kernel crash. Additionally,
>    memset(buffer + actual_outsize, ...) performs an out-of-bounds
>    write before buffer.
>
> Fix this by ensuring obj->buffer.length is at least sizeof(*bios_return)
> before accessing the return code, and compute actual_outsize safely
> using min_t(u32, ...), which is sound specifically because the guard
> above already rules out obj->buffer.length being smaller than
> sizeof(*bios_return) by the time that subtraction runs.
>
> Fixes: c3021ea1beee ("hp-wmi: allow setting input and output buffer sizes=
 separately")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> v2: Rebased onto current platform-drivers-x86.git 'fixes' (confirmed
>     matching current mainline, blob b2773fc1aca414792b99406315496a2c3a64d=
d06).
>     v1 was diffed against a stale local copy of hp-wmi.c that predated
>     a batch of unrelated upstream changes (GPU MUX switch support, new
>     OMEN/Victus board IDs), so its hunks no longer applied. The fix
>     itself is unchanged, only the base and line numbers moved. Also
>     correcting the recipient list: Hans de Goede's address is
>     hdegoede@redhat.com, not hansg@kernel.org as v1 had it.
>
>  drivers/platform/x86/hp/hp-wmi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/h=
p-wmi.c
> index b2773fc..d7ad206 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -691,8 +691,9 @@ static int hp_wmi_perform_query(int query, enum hp_wm=
i_command command,
>                 goto out_free;
>         }
>
> -       if (obj->type !=3D ACPI_TYPE_BUFFER) {
> -               pr_warn("query 0x%x returned an invalid object 0x%x\n", q=
uery, ret);
> +       if (obj->type !=3D ACPI_TYPE_BUFFER ||
> +           obj->buffer.length < sizeof(*bios_return)) {
> +               pr_warn("query 0x%x returned wrong type or too small buff=
er\n", query);
>                 ret =3D -EINVAL;
>                 goto out_free;
>         }
> @@ -711,7 +712,7 @@ static int hp_wmi_perform_query(int query, enum hp_wm=
i_command command,
>         if (!outsize)
>                 goto out_free;
>
> -       actual_outsize =3D min(outsize, (int)(obj->buffer.length - sizeof=
(*bios_return)));
> +       actual_outsize =3D min_t(u32, outsize, obj->buffer.length - sizeo=
f(*bios_return));
>         memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual=
_outsize);
>         memset(buffer + actual_outsize, 0, outsize - actual_outsize);
>
> --
> 2.55.0
>
