Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84543CECB
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448156; cv=pass; b=n2NPUfkdCDCp2rRHXeNdWynujADvtnTipoUiDDMKJSBrYYvOd1SweuQfKVU1w4eLcsomHLb9X7Q72Sn/r7kg0QNoVHOZtB90VnMPRl1B0Kv20oDmYl/uxxQX/A6b6uGIEbrCDVTuuNlIz3V9hgdWe0qEvVrazaEW3hRBazaXaBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448156; c=relaxed/simple;
	bh=sZh3Eij0Ok2+A/9ZSiA4CIhQ+/ECRnDzpFAm/U342+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bItSwDsTXei6o3slVx23UAI9nbjtQtdHcUcOmXeWHOtiNZYmKIShVnemfkPf0KV/cLze4WhyA37d/6oGFJnK79bM92k9pP8Niz516Fh3ta7Z5Vii2C+jR8vTOOe3ovmMGwo4dliPq1XODaGqjfpUKx1rKFxc/1sCy2aWZupCvu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sCBTq0Jw; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="sCBTq0Jw"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84867f07d63so3409275b3a.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 04:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786448153; cv=none;
        d=google.com; s=arc-20260327;
        b=rL141P0M8eOlz6ltTNqQ4D4q4mA6rAGvfhxJHRbBZQHJHJwaPYeVANwlFYuFfRHFBG
         0lhOBFUd4nE8Ngi1jv8FRIuhv0QSEQvIHBllBDof9n2F6fDOzJkKpVPMTVvs1dhnUUym
         6bQyqBTLdsXguAcnV2mo/VigEhkVama5PJzVNgbglq6HsSaVjT9K9YIaJwgZ78Z9bSBF
         Kre5Mhc7wghH25Oah5QjTs3vxXn/M5czZNkT6ECuwcwM4izmYsW37pxNvH0QHNO2PxDv
         2qMPthLZoUcTY7CqMcE21xIkqCWCARMhK+BL8NWGUmmK3AHFKIDXKHFudFutXyaXeSqL
         V7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jp9Vd2uMaaGzynTBDdsNCfSLq5DjI8JeAUCgMVAGmX8=;
        fh=2nVXeLoUZt54s8oqiqxKNcITvPoRblBNzGwmSXRnXYc=;
        b=Iakiet5xr1k+V6YYJ3ANROAmmJ5/5NCft0ty9sxs/Szh/noSWD+ct+ZQNLWDgllQ99
         LhH0l863+xJdfb5kdMI3MWs7KbANpt/72IZ7wNQaYCImI5U3g0x4A602O2Ib8fqV1lKR
         nmHyDiVzOkcXji7JbitRSX6fj5aHqqN4Rifj3yFGiuptJOeM3i+lDokgU6j4pJZbZXWW
         UXOfn9CsdSpYc4aboVXr3veSAOsWaM7W0jrY8+ZRzdBPIkwu7IPbsawMKVEQs96wZijP
         seL3TATN7HnjlvGSAvJFVfHj8ZBWUvz0XHvL3rqOtTN0nLaypF8M82+UXZGDk1MM151f
         yTUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786448153; x=1787052953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jp9Vd2uMaaGzynTBDdsNCfSLq5DjI8JeAUCgMVAGmX8=;
        b=sCBTq0JwlwdrNWiEaCnUh3MHx6GQvc3QfaorCzVP/lRtKVtr1Jn571xXOZpbt/t/2b
         1gq57XvuFZjnb4pZk2UAAqrV9YvoucNpmsiSJwoL1elx+gBpnTjWEZ5iyo6JRXqMkppi
         vsuLDBLEvR9amghYYJfvCps6GYT4MLyPqjw20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786448153; x=1787052953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jp9Vd2uMaaGzynTBDdsNCfSLq5DjI8JeAUCgMVAGmX8=;
        b=hKy+Pj8tZEOVdLRFPywZWILrYaBMF81Yh9kiHi0LBczrUyswuxiZiL/dWvykCUJ6cH
         4iaRsX7rK0aAy6Lxm0PVzqgD5HeYnOBcApPvkREgDMC0HEiq6dL3uOjvsReof/GmVX/J
         NhLvvRlxxmuBUj3b85n4RLcWmtiJB9YqDg+gSLzfTMLxC2+RCeLDXhEkHCQO08U2ER7q
         2rtWHtpSPD3MqRNv7f1Nq2B5MXp5GnZJLE5v2sne1DCQgoRyKx30PlKefaHv30AVF+LN
         0KRUPq4antLjCLf3q9Qh8D52LZDzdY3tqgWm0PP9IGDj/1AS9UnlmA3ykokmgFPCxQ2i
         DJcA==
X-Forwarded-Encrypted: i=1; AHgh+RqylRHuMquiEXAa9x0f238fm1LE4XCcVxtzKb8hsRntbtjLslvlOlbpGmlI4YNB3k8tz3MTMfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nSjkK5HzAww70NdkWSH1dsJjSfjgMBIW62IO5B4Sgv1zvYPC
	N4oAtFZkk9PVeWxBAzWXGXQ/Zi+QjXdjGQiw8rmR5ofFpp5bhtzRmBsbLJZJljM62qorLj6opdG
	Xso2svUbuuD6baLey/nj48dxW8ZAaz2zk0dGHAL9v
X-Gm-Gg: AR+sD1258mKPD3vAc7d8kfZToJhmDZmdBZ3r8m/rM5idyt0dOWbeNKj0BGcNpyqMzqo
	y37oGgIJdiwrziFltlwSwBR0cdJGSuUCf7fTieqFZPJxdLyiOpksmNEsKwvW5rzUu9qXjk6zjS3
	64CoEUKJL1N6RmsJ6ngygM9NP4lj5HvycKdw9DahSvqMpeJxUef2KZVEAfJZyt0kp2IUvy142rJ
	+41sSHbGrc7h68dtra2y+T7ogFCl1KzeatE4hT6CT8f5ht+LCaBMGfRXO7K17sxID+mCBgacmd+
	bg9yJEPFrOHAvkX+St+b+4fvDedJqmGDKDCBMcK9Up0Esw==
X-Received: by 2002:a05:6a00:a21e:b0:848:34ad:3d6c with SMTP id
 d2e1a72fcca58-84fa8695cc8mr2102850b3a.15.1786448153575; Tue, 11 Aug 2026
 04:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809094418.901607-1-jhs@mojatatu.com> <20260810170533.5bdc7f80@kernel.org>
In-Reply-To: <20260810170533.5bdc7f80@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Aug 2026 07:35:41 -0400
X-Gm-Features: AUfX_mxWkTu9exAYFDwYL1OJAhg4ArY-lwr_Gk_ito2JtRWdYlQYdALEs9Pt5a0
Message-ID: <CAM0EoMke_qk2jJdWW0rHvZcwMNd7RCG4xGkpNYZpPtrSKg2Q3A@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Quentin Monnet <qmo@kernel.org>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 8:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  9 Aug 2026 05:44:18 -0400 Jamal Hadi Salim wrote:
> > cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> > bpf_prog_get_type_dev() but never verified that a device-bound (offload=
ed)
> > program's bound netdev matches the TC netdev the classifier is being
> > attached to. This let a program loaded with prog_ifindex for device A b=
e
> > attached via cls_bpf + skip_sw to device B; deleting device A then
> > destroyed the program's offload state while it was still attached to
> > device B, triggering a netdevsim WARN (panic with panic_on_warn=3D1).
>
> maybe netdevsim has a bug then.
>

Looking closely: You're right. nfp guards at the driver
(bpf_offload_dev_match() at
while netdevsim's cls_bpf path checks boundness, not the device match.

> > Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> > -EINVAL when a dev-bound program's bound device does not match the
> > target device.
> >
> > Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for spec=
ific device")
>
> This commit in itself is fine, nfp checks that the offload matches:
> https://elixir.bootlin.com/linux/v7.2-rc5/source/drivers/net/ethernet/net=
ronome/nfp/bpf/offload.c#L579
>
> Maybe the bound-devs got extended for JIT / descriptor access, and
> that added some extra risk here. So either this is netdevsim-only
> (and not worth the Fixes tag), or the Fixes tag is wrong..

Fixes tag is definetely wrong. 6c8dfe21c435 was fine for nfp; the
semantic shift happened from Stan's fix in 2b3486bc2d23 (made
prog->aux->offload non-NULL for dev-bound progs). c0c6bde586c7 then
fixed netdevsim XDP but missed cls_bpf.

It seems a v2 may be worth it:
fix netdevsim's cls_bpf path (Fixes: 2b3486bc2d23), keep the core
check as defense-in-depth without the bogus Fixes:, and walk
block->ports for shared blocks (block->q is NULL there). Or drop the
core change and fix only netdevsim. What says you?

cheers,
jamal
