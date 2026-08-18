Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C793A7F41
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071088; cv=pass; b=gi+DfbWofniXPce08LOg87UOlWrB2pxImrHC9w5pCnODVhdTnN0latlh8DpuJrp0N0V8MPwp5p4/DxsoNx+WsUE6EH3aUro3Om4uCp/MIKWhpV4IEnSGJPub3HLWcfzGJp3slsWI0nj5P4F70DcAvk/wSMSGU4O4UUZH2y4+cnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071088; c=relaxed/simple;
	bh=Sh9h9dQ3B41wdeKBbZVy3TISpoHyLpEieCveSHS9njw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o08qWnleG4hd6fwqssu54PxL7VfZs+pQpmWEAza0oWxXWmAd9vzzjbHZX7xdxHeIdHnLWRfsp6atlosJCg+i9WdVx97hGES3RAIC+crncn6SQVo+PfKqscvOq8Aq2g1jtowrb9DXfK+GMGEvfQHQBXE0Kax23gtYaoRYpohNhrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sh8eLURO; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sh8eLURO"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52d56b08213so7596111cf.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 09:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787071086; cv=none;
        d=google.com; s=arc-20260327;
        b=VUmAng5IhgdUm0gESPwg6PszgIHekUNqBDl76cuEgH4RiqzBcLPSiO4XDnMQLeehEE
         po7KP7HsnwML23DEvoY2pLOI5MFxq1nUswGBbdq9Abv/tv1vUgZnIqOEZubn4Q6x1wOY
         aDHnA5q61ll/AxrbP6oLMKfDOaJuRDsx7jBTiOwQFdC0SGygrdsatwVsUNxhTugWWyQL
         lb80oxkQvVzBX1eENA0E2UlLZq2PPbOMqHHoWSQA9A1j5SKylASAt/bGeBMTC50LtHRp
         kljjcI3N7M9VIMXQi3sqwrjAQVWk1PpVFT3OalxADVNylfHfaRzI0sXnXC3VqgKG88dD
         a/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oY4KZv/LPpDCbj+BY5rZZjX9HD2PjF++yBgjpk94Zvk=;
        fh=mqxhamjcCzGUwtBvo5EM8NfsdlOnrbodhbg35hmAygg=;
        b=o1+yKwkuNK1xtbzeXy4NUtEMcDs2bmnHXwPf44tGiP3ZV6JooBMUvxAJIGEDJc7n9f
         23xNOyFRommhGOWE/SlrDBVD8s1BdFRkYDuY1JU8dQi7e8N7GnvvQhoA4rnVt7q+4IXt
         /Wz3HajHxFAlzVyM7WNctNKs6Kzz/tvfstaOay32pXKHu2klaE3swS9WzgbBpdMOs9Tl
         Wc2Cw53v3Cdk4JBnkTmY2djFqgA8nhohszrZDbZQ/GWEYp3KHUQBxkjWwfDAMmh7AvDO
         w64tIt71fDWMGsi6f+ZAQxzRp7BG8iUQqQvwYduGvNl93kmwZDBPHd0FpxGfFuOvLqxk
         AlHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787071086; x=1787675886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oY4KZv/LPpDCbj+BY5rZZjX9HD2PjF++yBgjpk94Zvk=;
        b=sh8eLUROXPafRfB8JanLBXOki00XdzUCGEyi/Zq2iV8Y3qafpjr+21obipDFV9ZbSW
         Q9YmD2155Kk/eVGeMaj7NUPDWlcbt43a+iboTJQKTUWrlbr5rdKFFoeHchAtGFPJDzPe
         Cfw68h9q03kWUC79r+HYQ3ciUKjM5TalI7N+xomvuRzJ646eRr4bX/JrkHXUWbre9fcD
         xLxWnFztwpaykcCHE4XMlg8gyzzVKdv1sxqHHuW/YYb3QYz6cpvznOtPf1ug0hYfkXKv
         jXe1DC3cpUDsYRgyUd1ZqalzLowJ4iebZm+ZFXee2ElAAo6S/zt4a+wEVS7HIUEApSK0
         x8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787071086; x=1787675886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oY4KZv/LPpDCbj+BY5rZZjX9HD2PjF++yBgjpk94Zvk=;
        b=NrsLaf1+MvDhwh1r4881d2WGAE74ERQ8qJAkypYc2y7PAk6f7S64s8Qw3SZBOU2Gqp
         5Rc+Tp2yjaH+20v5/27va/GU5Ut17MUNKzQEog/UUv9w357A+JglN2VdGBqXuvFypesP
         LORag9A0vKpy38FIU0evzlpY4W946xWtgtSnSA8LfCI/mu1K84nMiwqett8kwvCvE5hq
         QB+b/mGYIM6nA1k2aZUsZa8g4EuIH88wwSdj//ndBo0Bb5MK8hlQpFhnxf5sMnv0DhPF
         8+QjXXGgK9F6lGWUFIN+PAjtoGAmdJ5DUc5RkvOEeH4MtnQSJ2A+l3YrqdTeGaoLhhP2
         axzw==
X-Forwarded-Encrypted: i=1; AHgh+RrY+7KUz1pdM6tBERDr63choemXjp9DWFQN3V6rUIHWIpdEZeU+a6906RHrPZSsgJ0XIw0U0e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi11mvKiy27MEE3kmBRDmyDz4DjJZcXhn7uadxNBxkI/5b32gI
	PAAHkqzWb6u/dwzIuLQqg/6g/Wikix60WiYVAksYWEJ6USl/vuGhUDPjeoOFgxPaZoxpsfoCe5D
	lHrKwr83ZZaba1bSy2I1UVMbmQAu2Im1p24JMVcWe
X-Gm-Gg: AR+sD13YyYW77TPCNkrmvrLSStPbgyNCA68b42DA90OoPBlMZ5DEg/X3kmW22jjfS9k
	hMwYyLXu0mrEzhzpBDh1b9XYbcJ8juPRaoXmRpuE1VKCr1RsBHhraErhdC/PeYZqQC4KsDQ231I
	GC10/Sfcks+bpySXohIRBUWTmooQjZQ/coFVaXCBdb1XaOgEBzKaq/DszPuWaNMMQ/sGGESaI1h
	0e4zznP2TtIJpXz8z8jT4IXGQCPjlje8W+sP1WIgRr6BOc4Lc/E6j64S/ZdHflR4oDuU6ACA7hq
	F8WGjxuTBPKiSCkgCbJYDxUYeNz0wwX5cOYi7vXGuiTPrI2atDR00Zvp4emIeQ9X2+6+rBr+qys
	fNNxlEnepRoM1U1fCLkpv/VHC2oKu5ZAQ5huWfdNJMz+SIpCtMXh+hXP1nBTSxWGzNVK3HCO+78
	Hq/BmcPHELqoBG9jk=
X-Received: by 2002:a05:622a:2c1:b0:50f:c403:7ffb with SMTP id
 d75a77b69052e-52dbee29221mr75074751cf.18.1787071084785; Tue, 18 Aug 2026
 09:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818162108.11456-1-a0yami@mailbox.org>
In-Reply-To: <20260818162108.11456-1-a0yami@mailbox.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Aug 2026 18:37:53 +0200
X-Gm-Features: AcwNN1U1om7v4QT9QgPTTnQjR7bEOsR3MTisCxiHdQ6oxIld1g0M2CmqzreeQEg
Message-ID: <CANn89iLBDiwaLZ-1cp50HQahgrDD8ZDw8mix6C+Ukf3v-4xXxQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix AO info use-after-free in tcp_ao_connect_init()
To: Qing Ming <a0yami@mailbox.org>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:21=E2=80=AFPM Qing Ming <a0yami@mailbox.org> wrot=
e:
>
> tcp_v4_connect() adds a SYN-SENT socket to the ehash before calling
> tcp_connect().  If TCP-AO is configured, tcp_connect() first verifies tha=
t
> a key matches the peer and the bound device's current L3 master.
> tcp_ao_connect_init() later resolves the L3 master again and removes keys
> which do not match it.
>
> The socket lock does not stabilize the bound device's VRF membership.
> Detaching the device from its VRF between the initial validation and the
> L3-master calculation in tcp_ao_connect_init() can therefore make the
> validation succeed while initialization observes the default L3 domain an=
d
> removes the only key.  The subsequent AO lookup then fails, so the no-key
> path clears tp->ao_info and frees it directly.
>
> The receive path can find the socket in the ehash and load tp->ao_info
> under RCU before acquiring the socket lock.  A reader which loaded the ol=
d
> pointer can thus continue into tcp_inbound_ao_hash() after the direct fre=
e.
>
> The issue was found during a static audit of TCP-AO object lifetime.  An
> unprivileged reproducer in self-created user and network namespaces raced
> connect() with detaching a veth from its VRF while sending TCP-AO segment=
s.
> It triggered the same KASAN report on two fresh boots:
>
>   BUG: KASAN: slab-use-after-free in tcp_inbound_ao_hash+0x585/0x19f0
>   Write of size 8 at addr ffff88800bf88128 by task tcp_ao_vrf_race/232
>
>   Call Trace:
>    tcp_inbound_ao_hash+0x585/0x19f0
>    tcp_inbound_hash+0x677/0xa80
>    tcp_v4_rcv+0x1c3e/0x3ab0
>
>   Allocated by task 235:
>    tcp_ao_alloc_info+0x43/0xf0
>    tcp_ao_add_cmd+0xdf7/0x13b0
>    do_tcp_setsockopt+0x168c/0x2640
>
>   Freed by task 235:
>    kfree+0x1b8/0x550
>    tcp_connect+0x252/0x4f00
>    tcp_v4_connect+0x1114/0x1720
>
> The bad address is 40 bytes inside the freed 128-byte object, matching th=
e
> tcp_ao_info counters.key_not_found field.  The two runs used 1000 attempt=
s
> each, reached the no-key path 366 and 411 times, and produced one and two
> KASAN reports respectively.  With this change, the same reproducer reache=
d
> the no-key path 366 times in 1000 attempts without a KASAN report or oops=
.
>
> Use tcp_ao_destroy_sock() for the no-key path.  It unpublishes the AO inf=
o,
> updates the socket memory and static-key accounting, and defers the free
> until after an RCU grace period.
>
> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>
> ---
>  net/ipv4/tcp_ao.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index e4ec60a33496..4dc5910da076 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1191,8 +1191,7 @@ void tcp_ao_connect_init(struct sock *sk)
>                  * at least one tcp-ao key that matches the remote peer.
>                  */
>                 WARN_ON_ONCE(1);
> -               rcu_assign_pointer(tp->ao_info, NULL);
> -               kfree(ao_info);
> +               tcp_ao_destroy_sock(sk, false);
>         }

Why keeping WARN_ON_ONCE(1) then?
This will crash with panic_on_warn=3D1.

pw-bot: cr

Please wait ~24 hours before sending a new version.
