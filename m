Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5D33F5A8
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853656; cv=pass; b=s+XiXKGr2JVYXlcEIdMpdADvXSfqHhZ+CglUFqrBMqxkoNkVfW2DGmy7L2YyHtBnI1MsMi363iLy61oc4zzZP5mDBlEuI1j1UfIEpGxcJlFPLWo4lMLszzrOAiRnAVFP1fTlCSGhKgVSsciXzmOfy/P/XpDAMtdNvaUZ66ycw3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853656; c=relaxed/simple;
	bh=dmqo/rRKwcI4JGSucbf6w7qYELLj1zZNxK6pc8Chn7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwvZ3M+J/KofZdHeZWVYCx11sxm2hNp281G4sSuFkLrD67o6LfmMjleON/2Ii9gePu8POKddPeGsijCzGbJU2t8HfAjij16P+LJ0dZ1jBhd1eLI+zRr0Wqeqn0I6i01uHKvmnhtbHnrY/T2OuqNd3L/zyVhJxG+Xn8w1lsaVI5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n01nLI9t; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n01nLI9t"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15ea896ddc8so3432113c88.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791853654; cv=none;
        d=google.com; s=arc-20260327;
        b=II/qT6rKyt0IDiY6UHk8hWb4eX1oDR2KGb7n8LWYXpyTbq22f0hKXx16CndavuWqIv
         BmS8GT4U91vKauMhIzd/10uXGAT6GKZZAicBrnRh48hly/EOtlUm3ZI9LZKmCHw9thJU
         Np2bvs7zNAHWTBnQbqv8u2dtXe8cPHveuFXeuzCkXKi62zqB6Nh0LMXyyA0uyaw16izO
         BbnhMZf7NCbLtnRaz3TmQamcuo6+mJ6NYeKlX8+ZAA5NVtKyRMdrPuA+Hbr1X39YSljm
         6nj638nX7F17ih09yW2PYShaeZEKRhAFTYCX93AJ8DcMcg5QBjI7eBhsA5/TK6CmckGF
         jv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/Dt1a3m1BsN0Ve4mSC4iIes1pIXA7Iv0yCJdw8/D+s=;
        fh=DLtoEv7RxE4G2z+w/AQo3uRnhq1dCVz904+kAys1mtE=;
        b=W4CnKTVrEz8wympYNtypyZHweQ34+1TCp7t2Q9sxlb3wWvnkJIJs3NAfogTnKoFRLF
         eO8ypwnhHjyd73niWZRI4mhoXziMIaDlLR2VRyjtkX/EOFQN/da0/4XXHJt6+DWtST7j
         MmsDc7hCdbqoyQKIGiMMDkfVdwhbBpaNxfsgTMNzr+KVNE2tnPPeQl1vLZATlBRaBq4U
         CouXldk2C5FIzIoJ8Tvs3iOfOI9fSloQ24ZllBlWjzUp5yoWxvb7syOd/IPBym40mD7O
         0Pn5d3obqaPk+KS7Z067qaReoifg3GWATjOXpEWUiVvSZxUgDHAmlDyOQt//RGElfo1K
         AUdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791853654; x=1792458454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l/Dt1a3m1BsN0Ve4mSC4iIes1pIXA7Iv0yCJdw8/D+s=;
        b=n01nLI9tTahXPzhkNGk5WJu3/XLttTVjE6krUDQVo50KSSD/EMEaQc0e7yU6IlUkUK
         ww5YHsN6r8590jwr+wg96XCoWHngSVfyvmdTF+KMJpN5ock8xvExtQLTwjpCQwPaZOTq
         xtOp+7IlwHdnjgZwItQp5EPgpZRdzZgtQXghRAGzYOj+nSNXzeP4mcfExjmbyWePrwTx
         Py1U6e8JMFe0nOXEK/vA3vi/QJwKO4d7bhqo2EVn+zV93ae9K9Mwk0hK82KycQg0oISc
         a4uv8K5cH8uNeHTRBmwAKhdWwVaQL+F08q3qC9fQV0VOjVKn5XSDU0RcpIPXRBbdjPdv
         gTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791853654; x=1792458454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/Dt1a3m1BsN0Ve4mSC4iIes1pIXA7Iv0yCJdw8/D+s=;
        b=iywtMm1wM5J1Z6+YQeRks/jxVQCNdEsDwMHEeasvB6Vf9cZLwTcCEv7Pwidmm3/ofC
         wTlna4+uxn5lpeR7WQBc8BID+fzPu44GCsFKUM0jy4DqRBbzGs26ogZQtRpJ1PBKdvYw
         i84Hq2+ecRN1IYRtW0Ug8bot0aBqw9BSK56qTWKiXlZSSUVwGI/LvYYhw7YiWEISs0LK
         S155CjYtuhgHlj6iFG5jCvcsTqKNXfg1C1b4rZ1WIPmJ8oS77kgHnM9FuhV4majzYTyg
         d6tgMUo0liYFwKvvJFZ85b9gfChK5b+JrAhRLyYypfAyd9ZDQRDYsyvWMH3Qgar9Hzmz
         v46w==
X-Forwarded-Encrypted: i=1; AKwUvBwP1KbYK0c+g021rAzQayxMMDT7XN82ffe080xpD+CfACJXBkxhDKk5/22FOl71e0VL6FEWk84=@vger.kernel.org
X-Gm-Message-State: AFq9FYL92Pps9DHdm3sKwcwnRIfbNcY+wGEKIh6rtbL0r/zuL0PMbb7n
	XKV8xabpRyKHiwqriTkXyi+ouu9ySfRTPuZsrBKyJkCp1sUJ0Ki8UyLDdLoYznSuYCtIyMcQi1m
	OX0auOWgWMsyyYoJEBq8VCRrjau4/9e1JQLtJvfze
X-Gm-Gg: AYBFou3PT3yeb3+HDNWIqEW2ndaBsZYKm5mei17SIeXpmyYAVgHSyP9fXf138luonxB
	cDesX+MoG0SZUPM3cxWzQzymbo9ijFhF1FqD6c0UqXkC3JnVInuo6vAJqtMuzikFvGXygRO0Y/f
	uU4elIBBnBzxi/7jnI55mnFlZWv8mNHRxy6oMZlXzjznCFzqVDXf1KxnxX9iBbxyDIs5RAPSgM+
	rmHIep4Chcn/+Yhxv/Ngi5n84Ykb16VUzPWK0cY/xYmwccXiPLXI3+E67Yahc6MtCYQzUPbll6T
	GOvtlsO6nyUJuLm8WhjzF9YQfpsTlZNO3B8T3sfuZYabWVYBA8eMGoRRgJH53XQJDH7ERVFy5Ga
	6KQc/2Dpp3T8BymZJHKlG5e+SX/kVwt0bsnAfPDkoIYPCmassJNVVxbjbYL333bEIoVvM
X-Received: by 2002:a05:701a:c96f:b0:179:50d7:9ba4 with SMTP id
 a92af1059eb24-17950d79e34mr1584682c88.41.1791853649982; Mon, 12 Oct 2026
 18:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013010323.1058-1-kj2864@nyu.edu>
In-Reply-To: <20261013010323.1058-1-kj2864@nyu.edu>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 12 Oct 2026 18:07:18 -0700
X-Gm-Features: AclHuK9fb-xIidc3O6m-1UunJL34PxLpQ58IP8Bcl0fSdhalNCCQj8xNELr3Jyw
Message-ID: <CAAVpQUC33fc7di-7a5tgTdsuD4_ADEM8ZAXn4BcfxNDi-1df1A@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv4: add zero check for snd_cwnd_clamp
To: Kaho Jiang <kj2864@nyu.edu>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:03=E2=80=AFPM Kaho Jiang <kj2864@nyu.edu> wrote:
>
> User can pass zero to snd_cwnd_clamp via RTAX_CWND type.

We should reject it then instead of ignoring it later.


> This could lead to division of zero error if not checked properly.
>
> Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> Call Trace:
>  <IRQ>
>  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
>  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4/tc=
p_input.c:4440)
>  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
>  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
>  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
>  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
>  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
>  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netfil=
ter.h:319 net/ipv4/ip_input.c:262)
>  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c:49=
2 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./inc=
lude/li)
>  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
>  __netif_receive_skb (net/core/dev.c:6410)
>  process_backlog (net/core/dev.c:6761)
>  __napi_poll.constprop.0 (net/core/dev.c:7830)
>  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
>  handle_softirqs (kernel/softirq.c:645)
>  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq=
.c:758)
>  irq_exit_rcu (kernel/softirq.c:775)
>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discrimin=
ator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
>
> Fix by checking if user pass in zero as parameter,
> if so use the default value of snd_cwnd_clamp.
>
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Cc: stable@vger.kernel.org
> Reported-by: co+71b6509cb791e531@bugs.sh
> Assisted-by: LLM
> Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> ---
>  net/ipv4/tcp_metrics.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index dc0c081fc1f3..ff41804ad086 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -484,8 +484,11 @@ void tcp_init_metrics(struct sock *sk)
>                 goto reset;
>         }
>
> -       if (tcp_metric_locked(tm, TCP_METRIC_CWND))
> -               tp->snd_cwnd_clamp =3D tcp_metric_get(tm, TCP_METRIC_CWND=
);
> +       if (tcp_metric_locked(tm, TCP_METRIC_CWND)) {
> +               val =3D tcp_metric_get(tm, TCP_METRIC_CWND);
> +               if (val)
> +                       tp->snd_cwnd_clamp =3D val;
> +       }
>
>         val =3D READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) =
?
>               0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
> --
> 2.43.0
>
