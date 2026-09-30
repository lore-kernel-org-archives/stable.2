Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623FC45DF72
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764056; cv=pass; b=F4LOAFGfLrlWefm+4OodZ0Fw73cnwaUQYg6ru1LOiJkEWdZ/Rdvk2wTluTeWIeq2ZfA4/7r5bwSrL9XndDWnBH6EtPGM8EKXsgGZsg+jvAWhTAIcD8Ew9AtjImzIAd78rzlWKulVpg5VZZvPDxwKl50e4U037A2IizFnu8N9MIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764056; c=relaxed/simple;
	bh=XvCWzYsO5117WS0fLcPugtOovWWwKR7emRvgKSPyYEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDTegkfdHsionDV4pIUCT/lwg1tWuNOVtl+r6R0IzHulBENerh16mu1BFa/rY8q32Qo9GfuJFmaEKQLKVP+tA8pcNTyClOk5m69qZ02supAW2vMx5g9A8Fbis4/6XcZ7e58cnU/hbIXXZZhi5uw5bytDumjCUz59NMQgFYbPcvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqDfQK32; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqDfQK32"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c5d196b0bso93408eec.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 03:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790764051; cv=none;
        d=google.com; s=arc-20260327;
        b=g1ZZQEiRzVJ+3YftIS+/qPzeAI7F7OOOBPc5kZMUAnOnhFZe3veBLhU2+WbzubyrBi
         qRahZQolUQ85cFGGi2KEy5uHNQZCMvRTQUzlcClb4Jtqj6yUYbHuIOrRv5U0+spAR0kk
         bDkVr3T7RnjMDh7zIhoCsVbV7XyrnvVtJMqW4iqXL8xtIBNDirqdPlD7x3G7a331xcVL
         klZwdSwEf1n3Clxod1QMi3E6BmpsoWRHVOjarIiq4IUfkzB0toK5aV6WhhCw94JmGKJv
         50MqZtXW2tuaKF/yKToJErljIbXXqQ1ELHdSMcYc3M3c0PCiy/RBvaSgDHZOOTlq/iQx
         bvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VnWslcQfJFoVXI2eTJRtMgF2Yhhk9njWDc0SCnJiKsg=;
        fh=6n8zcRX3cFdLvUNEM+Dw4E8CR+M/rePwBi0kMx8n0xc=;
        b=bcc2ivlUPLhcabLOFY1BOa5qZozQvEWZ1BKpDd4ZWiNSFK2F8KEPRWvFdQkomHpqcX
         SkcU/+xOjTOJ4oUwLRrMR8gQFyAZN9jdXj9T49ar/Oe3Feqr93NmCCQGmkTmzifMPRpL
         bvW2E/5g3jmjSfEbjRKUhzdYqt4WbDjEk5BfmbVKi1SSE75jHPTYyN5XtTzw4wMEPuSb
         BQYZvCQbHe8kxfOwYUadrpVr0UGHsYxbftDxAR7156GP9k+LMasM/QBSYXM/jy0GhHdq
         ivfj+uoOQm6KbPh07GNi/1i3dlaEhSdD1KWcsy7dLKTRCEJT1qKXgg8YmuBXDv6zlGgu
         2XwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790764051; x=1791368851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VnWslcQfJFoVXI2eTJRtMgF2Yhhk9njWDc0SCnJiKsg=;
        b=ZqDfQK32SxdlMSL7AML4DDYFSEn83S9XNnE8si1DlLMNsYKj+18tth+oXi+aVYu4iN
         qdK2VKpn3Bh9PxYNSNe+Ab7nCNB7/rL7TqLwUrTbqSx1Rs/1ena/9EPCqlsMXr23YEmU
         EMcdcamK7z8YhYRTaoB7hECpHWiMLiaMbI5zRnehidhHeL7CM6UKDWCwbMbgEmudN7a0
         MiB0chDVX/EV6XTAiLqLtrkcgTM2czOWF6KLhI23rgvtzuJKS4TIRnLG9AXTZPEMGz70
         vW4rZR5ErPqW0JEP7h1yBKERxrNJSbbGSk+YSpKgFVSfwVElqAKZfi5smSo/gSX6z8lH
         Lngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764051; x=1791368851;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnWslcQfJFoVXI2eTJRtMgF2Yhhk9njWDc0SCnJiKsg=;
        b=kDhT8x3b2H84At/gfhVuffI9qUSdaUfQAFi0zYUeb4gkOP4yKFKkcyJe4Hj02sX+Pu
         3z75F281B4JQjEH/nbheJvDYBTJeFBI3V3sZClrBNckRhONl3zcZuvpR2pbAodsGzGn3
         sPCT/Zz/qTo1pwC5J4QTSX4sa7ovaqxYCOw2uVO2aazZPYLegNVNBiVx6doekcZ6sXkD
         UjqrglPkqSMWiYYwWlBW0k72N0Rw1+Jbe0hv8DIfPHYs8RJT/4LtbulkNQTqF2Y+uVzZ
         TjkRDcF1Yw+WHuISNlmwRzqPO1dQJbzcZ4O4ULe/6oYTal8FPhm5e//VcEhQ+eJ0wTJy
         tSFg==
X-Forwarded-Encrypted: i=1; AKwUvByP/0bMscFXEfk3V/eyqh9/UJHjwdy5UEheosnHN382rk7UoTKCdoshP5MkfjmrRk6U48eFBdc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYBFEtaN7NynYl6FpQEnqGM1BvEt/q/tsDM0u7FBUdM8ZmT3PU
	+iTPGzOaels42pdj0xKWSFMLSZzefnom9ezs4rhSHFNK4UD4ocgBQoRtN9zfblt+stpp02Lbddp
	P0mFsB2CsXRAHspq8ecop8auxlS4MHys=
X-Gm-Gg: AYBFou2StJRwKXh8ccyC0b0RjRYcn0yMvJPvIA0ElZHIhVXCI/prKM7uEkBNYB9JhGt
	HoLB2q7F39krjfe5dqHgqzrGguTXQVLUj/MTVBsjWq4Ns5XjZWE4ABS86h+MJ800JV9lFY14ZB5
	0p2BqYRkiiPHGMaIvdQwQgfP+Jyv6N2KLvaypdqAgng8OYkWi5ZnZRfwiZEURBuEzhPSlCtMInW
	WApdmUMinaPU0C8qkJY9valU7/JdUJJXosI9XSXIAughgIV0c7T0/xEQ8r2AzQM95VyKnvWY9hm
	a7LlrA+bHoGiCrtYwWdz4vVgkn8L4DvcekdYMJhEW4b+dK4Z2gJ9s/WdbK1IUnKR4QkOVAAqQDx
	09fY+zW4xiSu9R971v/HgBKwoSOca3jNpap9iL/b4eoqVNnNHozFSTe+KQskTuCyRFDarMeRjpl
	s8kuU3/xS46vGNdPclSsgj9ytwnQYwJ5ALO0MpDJ2o+41Eq057Qs0=
X-Received: by 2002:a05:7300:e9c9:10b0:34b:7c9c:9a69 with SMTP id
 5a478bee46e88-34cd8795e5fmr2234714eec.0.1790764050978; Wed, 30 Sep 2026
 03:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930101257.1649945-1-tomo@flapping.org>
In-Reply-To: <20260930101257.1649945-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 12:27:18 +0200
X-Gm-Features: AclHuK9Nh6JsI3E6OnYTw_dMYdR-qYkmEpYkodh3Keia0XE0NzXFf93RUybHrnk
Message-ID: <CANiq72nRjBM5gPGKbEka8M6uZ8aVmoCZx9z0aXSMCkm1Od42jg@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
To: FUJITA Tomonori <tomo@flapping.org>
Cc: fustini@kernel.org, guoren@kernel.org, ukleinek@kernel.org, 
	wefu@redhat.com, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	linux-riscv@lists.infradead.org, lossin@kernel.org, m.wilczynski@samsung.com, 
	ojeda@kernel.org, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:13=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org=
> wrote:
>
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Fix the following build error on 32-bit ARM with COMPILE_TEST:
>
>   ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' un=
defined!
>
> The driver divides u64 values when it converts between nanoseconds and
> clock cycles. On 32-bit ARM, these divisions are compiled to calls to
> __aeabi_uldivmod, which the kernel does not provide.
>
> The TH1520 is a 64-bit RISC-V SoC, so the driver is only used on
> 64-bit kernels. There is no point in compile testing it on 32-bit.
> Limit COMPILE_TEST to 64BIT instead of changing the arithmetic to use
> the div64 helpers.
>
> Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
> Cc: stable@vger.kernel.org
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/=
topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Thanks Tomo!

If PWM wants me to pick it up for some reason, please let me know (I
don't plan at the moment to send a fixes PR, though).

Cheers,
Miguel
