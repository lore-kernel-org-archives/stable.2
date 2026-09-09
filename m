Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226DD39A057
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977903; cv=pass; b=LMPXPUenk6cFZsaOccbgrjzBdA7zqjD0QqdP2++p5U+hbOWYlaOwU7vc2kAEgLRJ5NPtL3HQWJ/2TseIP7DlkZATW8UMUoKdaudzZ+8/KM6hMOLUffB8EywmKgtXwPSsuYRdCJx3lgtufOcYoeSEEzWtBnb+/uPw7tdAb9B89mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977903; c=relaxed/simple;
	bh=+CDkEoDX2/LXNI3w0TZ8BPrSDg27dcd2Jkj3AIOFwBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUHvW1sGSvSqyMNFNb2Z3IqCYyntLTeKJO3iZ7M72Qgs+zhGC/IWbzqDuVVYOz6ThiH8fb0CA5Pil5mMlUnFjiBqAbP6b9O57dZfDGxcw8ymR68FgNh13liYB0RT5FvZoBd8DV98TyMUkVMW/+xUWiT+CJVliWLH8x7OrGPLOCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=K786/Ugs; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="K786/Ugs"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66cf1f9965dso5164098d50.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 11:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788977900; cv=none;
        d=google.com; s=arc-20260327;
        b=NUpouNcIE+BoYAQqKgWR+Nt6sNUI8dK6lWu6bKLzbiPy1XqPni8VmdT7KBXxpTCeeW
         BthNkeXLur+wYmOEd+PGKvJ3XPdH83/l6sPQ4EEUTJ+Ou23+hpv5YhuplGpYS4lDru6T
         wBljgr8iwhOSiWzI4lwuoiKmgAoYkxa5wLy4DPpUVOxZBhHYUUqfTMCbrAiiHk87ZQV3
         X6E3ozSyC8PX2EPjL+lnt+wz5nkSoB4Cz8bd7Y+TUT5jwbYfQWeMto4WF0U/0cY1roEq
         0u4/Yn2+YR6dVKBP/EvG9BFvqe6rd4DuEdbCl7QRE/OBuaZtNq4SGA2E0NeCPZVXs/QT
         9UTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpB1R6y/CuTo27wSddyY+/GZ4xEhTTLFsyZFIbKl89M=;
        fh=rwIs2obaP7wzPjVmGgUXmkYjm5KzR7Z2pZsCt+P1mR4=;
        b=A0bkW/dEOEmIJc61DMpl5CjQ0v3Xy2NvxwaoDxVno+oMGIQVQOTYS3XurDiKgGMO7X
         twZBxUkbWXV6H0owHBef44LrWIxYZP6I/oOoADAQTVBAyh6DL20yTbtn+AjYEmdXwnju
         I/tL1dJ8QgCTtFuuVXqSMqRvfSmq5LIG9XTc0n38izgE9PrgChNfCE+AnDW5x80bNJxM
         wKhos5jUGoyUOAG4SBYN6tEFntOy+y048SrCWhMsaH5mBlHpugHbD/JogSSUg2dxUmD8
         iE6M7EjlZOK692N+XotVnodTeDVKW9sYTknosRcOufePFvb/IqPNpKMnBXRfsF3hfAvn
         WV0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788977900; x=1789582700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fpB1R6y/CuTo27wSddyY+/GZ4xEhTTLFsyZFIbKl89M=;
        b=K786/UgsWJ13mRcFVosouCsAqsW6E3/kB3B568N2Cf80edSGyVZuDTDeiQwOOzPWUJ
         +ItaDTNfEihzO5M6PHu+v5IxS8xZR3B7+9YhBuQKcn+MdjtQr17l5FYNUgUdLSdZdbnA
         ScmCKjTF9yaAjUsdzD02XeKJenV/vSSQN8H7gRKpCCxyG3C6/Jvy86/EH+SfYAlKJIdI
         9LqxoMOEcMZQKfB+2dvrgoahLX7vtynmozey13NE5eRykP77De179uAmsNlJkUWGMfrO
         dg2benyomZnIWpR0K4fdcCEgkCU40WoG4zIPE9+t9tcqfuyaANvdXCt/JLK5pHjQe9Ra
         tM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977900; x=1789582700;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpB1R6y/CuTo27wSddyY+/GZ4xEhTTLFsyZFIbKl89M=;
        b=TolgvGKYPIWpPq9NPU4+bKZLBijFepEnnIeouyt3Or6sAEZ2qkeH0YtwXQRAzIIcXT
         mALmkMu4AoRzNgzlkEfTX7h9tXJ9gtu0Zo2lwrcxIdzRN4WjdQ35l2zDvi8/J/xgtiI8
         co0GJRqXPoGWPFn4W1S6nNA+VfgQ4KF9fFufqWBTVZjNo/hFQLHi5oDZ8S2YHIYxg0g4
         dhoSB7j8QTo5/IDd+BKdxyTCU41D9XwlHi+EDc8wSSzOiaWkD+gwCwiQxd4Yf5xXY3dC
         0iSn/8aADIgGyMsJPGKFZORT/04LtPz9icaYQwY7LqgdX4b+Q1QxidRIR3SP7tcAz254
         suGg==
X-Forwarded-Encrypted: i=1; AKwUvBz6zH36qvWSEfYw1/96J33E1RH8ZnQ9C2vvVprov4lunESLuJp84qd4NtVB3X9ynQq0zE1KQO4=@vger.kernel.org
X-Gm-Message-State: AFuF++lR0Uap8ZXaWlpJcaBPfkXNX1IdfEEWoDkHYH37ESUnRIUtZq3h
	9g9MykTgJntbNqC3gFcDevMV9Lpek34rvA/0fvgka84K/dmtCu8yNn86JCW5+nc5pCoGkr6YrC6
	AgsbufmwOddItVMJEp75J8i19O5Hti1vnYTXpgWkIiw==
X-Gm-Gg: AYBFou0ccn2mck6M3YFKjPIlvbAra3vbXei0vOTZlckI1P/kKvGF+2UgUWus2d7CJXZ
	u8HvkH+BeG2DLPuExG/ZZyHHeLS8+YrrzCuyi0QO34e3H+nGIi/NkM6lzgGKiFzayeHUN7Qkaw2
	SJ6kgZ9A8YU45k+JCNNuPIquUcFahsUFp9z5oT8gnIdBHjFH436fsSs3B01mACUQSje7Vpj/AO/
	LtH0kjN852xNj3cITHfDjDWBzvh8U08LN2IcFsuGtpFeZyJJmLzlxx5BQ72uT8d9Ne62mKRx3J3
	m8NLpdEZn6yFIrz78K1d7Hh4vK2VZJAX0tgNPXam9M/vzFtoq0wyddY=
X-Received: by 2002:a53:dd04:0:b0:66f:c1bc:4033 with SMTP id
 956f58d0204a3-66fc1bc4591mr8088674d50.96.1788977899985; Wed, 09 Sep 2026
 11:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907192129.557377-2-bestswngs@gmail.com> <20260909040807.3885815-2-bestswngs@gmail.com>
In-Reply-To: <20260909040807.3885815-2-bestswngs@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 9 Sep 2026 14:18:08 -0400
X-Gm-Features: AcwNN1Vllz-TAro1yIo4gS9pQ0u90xlbBvVitrlvw4Rqq5UUb-P30JRI5SxUS38
Message-ID: <CABFh=a73wXKY--GSfTTp6X0xcKVUNr-iUnqnJO3rZXp7RLvKjQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
To: Weiming Shi <bestswngs@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lebrun <dlebrun@google.com>, 
	Mathieu Xhonneux <m.xhonneux@gmail.com>, co+adfca3e91be95776@bugs.sh, 
	Xiang Mei <xmei5@asu.edu>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:08=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> An LWT_SEG6LOCAL program can invalidate its cached SRH with
> bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
> may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
> Post-program SRH validation then writes through that pointer.
>
> Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL programs so the verifier
> rejects this unsafe helper combination. Other LWT program types continue
> to expose the helper through lwt_out_func_proto().
>
> Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
> Reported-by: co+adfca3e91be95776@bugs.sh
> Closes: https://lore.kernel.org/all/GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQpq@=
bugs.sh/
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Link: https://lore.kernel.org/bpf/DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Changes in v2:
> - Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL instead of adding a
>   wrapper to refresh the cached SRH pointer, as suggested by Alexei.
>
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8513167a858a8..2a84f9d011314 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9044,6 +9044,8 @@ static const struct bpf_func_proto *
>  lwt_seg6local_func_proto(enum bpf_func_id func_id, const struct bpf_prog=
 *prog)
>  {
>         switch (func_id) {
> +       case BPF_FUNC_skb_pull_data:
> +               return NULL;
>  #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
>         case BPF_FUNC_lwt_seg6_store_bytes:
>                 return &bpf_lwt_seg6_store_bytes_proto;
> --
> 2.55.0
