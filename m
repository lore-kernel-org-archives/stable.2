Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEE377A9B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577736; cv=pass; b=Y/zzpzMpsfC3Jdgxv+0Xwvtfp4cNoqDZE4Mbp9FfIQozXM/iFpDwJUJRWxIu1mMVrMDZ84YWb8y9Qb9+2NvS+qM1HbcAP92HcTOYkmh60LkF6i4gv5eAEf2xKspc28l0XyRJPuBquSW5Yt5VbnTijYfwskjR80QUL3zx7qf+94g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577736; c=relaxed/simple;
	bh=hTEIRZ6c8CGBsiEY22+3KvOmCoGOgc2cqDVTYQqzn/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOXLQjrWkIRud6Muy08ZttM7lkl2ZxyNyKrfCQ+KBz21sFwewsDgq448H6dOST3fnnpL6h5n/Z4DD9O2tNqqpaFe8E7GsQANungsEV+4jpaFmu3pV+b5UjZB5vEL+dIvYVqjCKJvfXXP2sFIJd/J16I1qGJlPu8Pi7nWTqONTUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQSBRV9I; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQSBRV9I"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b8f42bb8a9so3660e87.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790577732; cv=none;
        d=google.com; s=arc-20260327;
        b=swGNG3qF6CDsVCyKvDz6yaMA4OEFvJQPZuaIHB1CI+1mDD0R6NYUMcJ6IDuHg8xX+A
         VzxgPDTxnaVe0KmQbTHhiEDNBlCb0Zvt3kf9wqC48aoBAd1HWPm8PwI9n61nURlzqobg
         vs7lVv/hUX4+bOeOw1us7ZQswcYMfdAWej0OKulcXys5QH1urdhBSI0slze1x3pkk02U
         oRYtiU0TGNTHRiP5cueRyNUdyiwDhNHgW2tMmzNUPCVlC/Nk2w3IRjTVuncNO1Och3Ol
         0Dx+QsyLWtUDkTlnn1DngLn7oGNa2zIvxb2Ju7RJVmknkASMCI/QwRcYZ4eWR9A24QJ+
         8poQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Bf5Ra9GZUy8aIwIwYwR9PT31QHZBEGPbUTatiNyuQNw=;
        fh=vXqUiZq4icUYKQo2KQe86dw9VYXckgR7uy6q8PFsKfE=;
        b=J4paBqusHljWEwC9uiaEL2OObGb1Zv9fyhLB0oEpZsASwm0Fz+rLgn/8jN52HSmb/Q
         ci0uwAxIIJPlh4WthmfcoNQHIYackrjg5AB9oxpFoldgtFqQsVxvjzXeiEBaxbwOiiXS
         C6OD9fenGj565ePQHUwXpbtcxhV4uIZwpZUfQ4U/7iZSCy75HLJTQJYR7TzeOpG63yEc
         Mbgb4TFEVGIGqsSzQnNbF1hvhYYydfaKpVfXcHo73ankOqlSDZE43w/rG/m1qiHl47Mt
         1xZ/7aq94Tc1hi6MqKelNKy2e4NmZlsvSdIAOEp/+F93VhLbAVvVdHs+82LfzA2ZmGW2
         upCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790577732; x=1791182532; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bf5Ra9GZUy8aIwIwYwR9PT31QHZBEGPbUTatiNyuQNw=;
        b=hQSBRV9IbYZlhqyPN2lL25CtIkjrQAeJ+Zh9YbRCYTwimH8PZ/nMQ70Nnkg8LsC/xr
         73V24QmHN21NkuTwVr1hVUFZd1rALhMAZtmx7vquS6IVzDDQYhJeW0EVpxRQzYplsVaW
         jRnbsq/0QSVJlFgu7dT8uoaX7zjBu0vH0vlwur+zzRbwpHTTd1M9xXxiU30a++wWZTzS
         PvMud++jit1PZC7tBtqyl7l202GRpvdxwsQdYz2TFwz7f7FAphY69GC9d375dKvQmqC1
         h1QZuILkDj/oKH6x3MoWjqH28fPZ0AsczAppsjFC3X2RVEkUtO/fhJT7R/Jiuy1hQp7i
         vLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577732; x=1791182532;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bf5Ra9GZUy8aIwIwYwR9PT31QHZBEGPbUTatiNyuQNw=;
        b=NoMpWiQR6M6XW7Kp3D6OelEdvjZ4H17CgYiDTQh1a6PgKc7PdvdYknTDv7ufHfQYGJ
         o7Wc7t+e7Eq3zyg5yOG1eluM6MmJ9qXuICHX7UBZ1tbgnfYmJVvO31wYJjhB4v2gb5+P
         2/Hi0DwCu1iTMiTjumbnt5WhQHQ3+It8qY3U8kv5da30iaw8YL72mwBCSTWtUDhJLtXE
         E7eqz2KPMhhTnqVgcdG0iOsMoMelLo38mcNMsRKXUeTcntfRebmNazUA72oQVEz7csPx
         o8HI5yphMGOobwZc2aEop0AlrF/CMe0I7fdE/wcRm8Sfl9HsiDPs9xK25tpJJP5IyDrl
         c4Wg==
X-Forwarded-Encrypted: i=1; AKwUvBzsN9v8znMNgsSTLYjfQZ2xXdVpqxIyL1RkMkqHz2dTmCMq3GgA2c5NIiaxO1Fp94FD9+eyU1o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLS7X0yI8Jn78YB2SUZYpblp0ESH+8xX9ih3l9WnZkcBeRlrCAj
	48HLi0n0ptbddtIN+TEd42ej+66OSJqy6WlbuYYpu66KxzFZkS1Kj8iqFvKghv/E6A2QSk8z4DF
	uFgl7rDGDUeFS78bvCiec/LtuuUql1YVEHBOaap+z
X-Gm-Gg: AYBFou3Ea/uqfPPRwJz50CnOD/WVFM2IoRsdo1wmLavrElOC5gn5OGetd4SoLpd/Mt4
	cYd1GWkPQbOdznWvWJu1s9p2kLYo+j/sHr1Q0rPSryAj+ZT8i5LtppciWlR8tKMnpa88bK1z0Zh
	6PK9xv+y9qnEr35L+69+5qBjMnVmBiU96CYXvq0dAFd2vZNk+uHl+cSAC+jHklm0tWkHulU13OH
	r3PZByvs2DjmRVPfJtcbtxXHSn/5mzq1Zok20pkc/cDXz/XJKyf2WcItU/xteNYRi0ikfNFTcp4
	EMisiE5qxFqUDyu0hn07rgXixF73cIA1h2/esmTCyFSyW7zjx27UotPM6lpn3eO2YKxqyaRQ9Yq
	EIwzvNkT/evIn4v8c4yv9TSU=
X-Received: by 2002:a05:6512:118e:b0:5b2:a967:c0e1 with SMTP id
 2adb3069b0e04-5b8ef0d8197mr147876e87.0.1790577731865; Sun, 27 Sep 2026
 23:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908142632.2795308-1-fuad.tabba@linux.dev>
In-Reply-To: <20260908142632.2795308-1-fuad.tabba@linux.dev>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 28 Sep 2026 07:41:35 +0100
X-Gm-Features: AclHuK-BFXQVxwev1h4oFTaX98t3AUrNTYP55S4zDU1gVDwi9bqTXCzyYzdaWQM
Message-ID: <CA+EHjTx-MGu=Rh90WDnTWMS4=8vcOdbhR35g42BtRBy7wqXBXg@mail.gmail.com>
Subject: Re: [PATCH 0/3] irqchip/gic-v3: Lifetime and range fixes in the GICv3
 and ITS drivers
To: Thomas Gleixner <tglx@kernel.org>
Cc: Radu Rendec <radu@rendec.net>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Will Deacon <will@kernel.org>, stable@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Tue, 8 Sept 2026 at 15:26, Fuad Tabba <fuad.tabba@linux.dev> wrote:
>
> Hi folks,
>
> Three fixes to the GICv3 and ITS drivers, from reviewing the GIC series
> floating around and chasing down Sashiko's reports.
>
> The first releases the partition node that gic_irq_get_fwspec_info()
> takes from of_find_node_by_phandle() and never puts. Sashiko raised it
> on an of/irq patch of mine, and I said a fix was forthcoming [1].
>
> The second widens the per-device MSI clamp, which truncates to zero when
> GITS_TYPER.ID_bits is at its maximum and then denies every MSI on that
> ITS. I couldn't find an implementation that reports that maximum, so
> this is one value at the edge rather than something anyone is hitting.
> It carries Cc: stable because the commit it fixes was itself
> backported, so drop the tag if you'd rather.
>
> The third clears vpt_page once its_vpe_teardown() has freed it, so the
> NULL guard holds if teardown runs again on the same vPE.
>
> Based on Linux 7.3-rc2 (df2908090cda3).

Gentle ping on this one; it has R-bs from Marc, Radu and Zenghui.
Anything else needed for it?

Cheers,
/fuad

>
> Cheers,
> /fuad
>
> [1] https://lore.kernel.org/all/CA+EHjTx7eP_30vP47=UFk_wMAut-2uf+2DF-MZqn2SLE_k-8qg@mail.gmail.com/
>
> Fuad Tabba (3):
>   irqchip/gic-v3: Release the partition node in
>     gic_irq_get_fwspec_info()
>   irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32
>   irqchip/gic-v3-its: Clear vpt_page after freeing the pending table
>
>  drivers/irqchip/irq-gic-v3-its.c | 3 ++-
>  drivers/irqchip/irq-gic-v3.c     | 7 ++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
>
> base-commit: df2908090cda368b01ff43709f51890076c56157
> --
> 2.39.5
>
