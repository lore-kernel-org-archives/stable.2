Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672683C13F9
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512093; cv=pass; b=EogOWrM8LpvXD3gUKEuur01b6gIy7J+i1HM9d976D/nH7ITiZtZbqwTs0m2R5U0hwtkUU5RNL6Mzuo+qOmyAbzc0Jt8bGlr/JdRXxw+R/UTlehaqekz+rqY7QyoJMZvZ9FpBF6v/YgfkFOqJgSSX0aLzFnzK5w0IjPcJdsacIGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512093; c=relaxed/simple;
	bh=aZ8d2LKjoUbC3Vb82drSDlRzbG1SJVf7W9U8iAuF1kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7TN8hy0nvi0Vt8mT6XbmKwSGMhEQmhAr+OJ7AISJWcHcAILjk36zeDzEMMaHY0Mc5sSyat5WYE9Z3qf763pzmMP8DgDt5oroQlF0+1eMu4DioIr16NBdayV2V+oCN6JwvNb9FX2syV0HIC9xSYXxVrnVDu41/tnHKsClvykEPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbYbyO4z; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbYbyO4z"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6fb4b2a3so52917a12.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 05:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790512090; cv=none;
        d=google.com; s=arc-20260327;
        b=FodOXZUiwqxlDHbHkwpVVwjYjTEU+wkxvV1VD0UPqTzAm6opzGhu1/n0u/2B7rUcLR
         zLd7nK8KtJULuP3EutyVYTzz2yzdtlbq92jhJk3ddj1FQCRZiQ6xHzMVRedJvTb3zbry
         PSVc7HL2fE44wlX8LqMhk83+963NN7DMsnHlEph3eff52UQmS7smXwEA8RoXCI5RBZzk
         1LwlhOMjdsutYH0aSYbb3fmsi1gjBYykU8WlGqBvo6T1tUpZETZghD2IpIADfYVi2NE9
         2bbkuQU0y5ArWPfNqzeb4Z8XAF9Tp7LrSurWH0C+EMO0/jz/6lJs0J+ZXf7nQSSHz6Wi
         /g9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DcickMSZi9tlx6KRNzjylAz8LM/Bp4ZoL8EqqOqvY5M=;
        fh=hZu0foyiLsbqlPzYz22bx/oUqkV8f0Q5D9IrWUeRc4w=;
        b=bPH8O2CoWx792Xxd6mUvkii8cjok4oc/TpL80hAdKeJJVZT4/31JBFu2Xiv6z/6x5E
         g8H/0Qc6OeiV8RQb4LvVB6x+lPcjwKlyZaXqYOhw6031UibJFa7tm9HPzFmBQSDc9zKk
         4+m/2noA8+nKgBKT5zp+FOrGeKPgUersFKrHObW0sqbiXTfPBfYyapLn88aYZbnI96ve
         ypDlZR7xh+FkvjhQx/mgR6bQoLs842Vfgm5UkMrcznTzbf4qajfdYuEdK2JcYXSc5sXu
         GdVrN1DjTLpz+1wGzITmV5jkF/6SFYqGxCcPMj/Wc7R9XKpDcdAljVHNHac8C4bhGryz
         i68A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790512090; x=1791116890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DcickMSZi9tlx6KRNzjylAz8LM/Bp4ZoL8EqqOqvY5M=;
        b=BbYbyO4zlw/+BTGHKQQEDaUnBXdhSKiFufGWhPQGalR09kCBhBbY3TriGkr0pmOPrK
         jpGVWj64dFgd6IeyioCjgoYlt4oiyO/Ssndsll9WXCAlvbDhXMBI8vdgbFBqJovO7WCA
         +KZODJN05DMQo10vbauLBRol7+r5GNHXNest5rdg2R0F4A2AwRJCcHryUJj+He8lO+IU
         g8QdEeWWXP0hE0M3dChuXjzTD/A8KgqXgkWjwaISNGFF4vVrtnHi3/w2Tmr2bHAYdohw
         teHxsEa0D9jkXnrOrApMXadeMUhIxJkyu+OIsIZybxFmKfnuPvkdIE5BjOWqggfLJdhu
         a8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790512090; x=1791116890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcickMSZi9tlx6KRNzjylAz8LM/Bp4ZoL8EqqOqvY5M=;
        b=YgrrKL+fQZLsiHoOaCNw6DA+5Qw7uN3QakNBvbCRpodSdqd0Rm0qqd+5LuU/809tEp
         Aj3loyurbSS3YSg6PzF7hvA7EKFBQnn5PeBDo/LxLwOfw76wir9SwGy2qDQMV3pNm77f
         cnJ+3Y9VeP52clVvfUJVpEQNyA6VP/MXT+2Myyu02pbbsBbL6v9iUvmmN0I04a+MJUTX
         0+ExZwfOgRBAed0BJkk1ky8WwwS57A7e+mX1BxC5vBQ8WlPLvCVbs7Sklv6DvqQwo9kL
         43z8jGMV3j7FRrRIgdiatG5ILYCHX5jSt5PF7CmjFuN/U9yXNAf+37vSOLZ5w2/b/dyh
         qIhg==
X-Forwarded-Encrypted: i=1; AKwUvBxnOcv1cr2RHt+aeyUubc53PPYvQIvhC8Z4GzdoPp3SnlYxP+5qMreKobMO0RYMbhlUqbg/OdY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWi0cuDyV73sSYqznHCb1ml+cPACGm+dcWu2fh70Cmi/26v3Ou
	Fj8EcuQIDxvMkAgNhrR33t/0Zpee8mt2EtDbMm4ic3yD7hC3OmRTEUE8dPKVSS48IfgkTgCWAsl
	7J4xUHYanhV9tfYrxGze5CXgk38gi2Eg=
X-Gm-Gg: AYBFou2BupFMZUFFlW3AbnO+WYxE98XdUA7N0UDYvj2j5E6mPHckX8OzawyPlBPAETB
	OfIGhlfS++ADZ4rtTMzABVjRT9Rk61NLrLcSFyCa1LERJQBHUpr7V7/OKOGg/S29PEOC3YWuEnR
	+hR6kSGe7aUnvyDQxIggqmJr5GfldU9MsuLY6aSNxDMSBd8bQOceyi1/7wd2Ns2hkP6VyV7WLH5
	f56ZZbMoy6NMRwplIrKT62LWvQ2PxdHv+3jAP93GeQu2E0YhkMdjs0muiWFnekFOmVjFUXuTRfq
	RhtLp0fOoNaTrVSaImuumk2EU/yudmVuALoRG8sUzLu7ViLm3AhtZHHlXsNzzqGX0UJxDpA3NtD
	bciIiI3rwlXw=
X-Received: by 2002:a05:6402:84c:b0:6aa:a78a:6a05 with SMTP id
 4fb4d7f45d1cf-6aae1a75d8amr6810931a12.0.1790512090262; Sun, 27 Sep 2026
 05:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731151426.3194039-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260731151426.3194039-1-nicoyip.dev@gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 20:27:59 +0800
X-Gm-Features: AclHuK_N5TNcjl4ycZyFw4hCS9apkoJ8loGQgOYKm-VCZRyzq2zwxDrXoe9gA5U
Message-ID: <CAAo+4rWo3Ok=7Qu__Hfc9JsFHNNy7vCU8KL7QX8nMbkAt20Nng@mail.gmail.com>
Subject: Re: [PATCH net] rxrpc: Prevent poking connections after final put
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:14=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.co=
m> wrote:
>
> rxrpc_poke_conn() unconditionally gets a reference before adding a
> connection to conn_attend_q.  This is unsafe for the connection timer
> because timer deletion cannot stop a callback that has already started.
>
> The following interleaving can occur:
>
>   I/O thread                         Timer softirq
>   rxrpc_put_connection()
>     refcount reaches zero
>                                      rxrpc_connection_timer()
>                                        rxrpc_poke_conn()
>                                          rxrpc_get_connection()
>                                            increment from zero
>                                          list_add_tail()
>     timer_delete()
>     rxrpc_clean_up_connection()
>       timer_delete_sync()
>       call_rcu()
>
> The refcount increment saturates instead of resurrecting the connection,
> so cleanup continues after the timer callback exits.  The RCU callback ca=
n
> then free the connection while attend_link remains queued, and the I/O
> thread later accesses the stale queue entry.
>
> The kernel reported:
>
>   refcount_t: addition on 0; use-after-free.
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xc0/0xe0
>   Call Trace:
>    <IRQ>
>    rxrpc_get_connection+0x185/0x1d0
>    rxrpc_poke_conn+0x12e/0x2b0
>    call_timer_fn+0x2b/0x220
>    __run_timers+0x561/0x8d0
>    run_timer_softirq+0x144/0x250
>    handle_softirqs+0x18d/0x5b0
>    </IRQ>
>    <TASK>
>    rxrpc_put_connection+0x2fe/0x3f0
>    rxrpc_discard_expired_client_conns+0x396/0x670
>    rxrpc_io_thread+0xbfc/0x1640
>    </TASK>
>
> Use rxrpc_get_connection_maybe() while holding the attend queue lock and
> only enqueue the connection if a live reference was acquired.  The normal
> path for a live connection is unchanged.
>
> Fixes: 4241a702e0d0 ("rxrpc: Fix the rxrpc_connection attend queue handli=
ng")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/rxrpc/conn_object.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
> index 0ece717db0f8..3f4516115d37 100644
> --- a/net/rxrpc/conn_object.c
> +++ b/net/rxrpc/conn_object.c
> @@ -33,10 +33,8 @@ void rxrpc_poke_conn(struct rxrpc_connection *conn, en=
um rxrpc_conn_trace why)
>
>         spin_lock_irq(&local->lock);
>         busy =3D !list_empty(&conn->attend_link);
> -       if (!busy) {
> -               rxrpc_get_connection(conn, why);
> +       if (!busy && rxrpc_get_connection_maybe(conn, why))
>                 list_add_tail(&conn->attend_link, &local->conn_attend_q);
> -       }
>         spin_unlock_irq(&local->lock);
>         rxrpc_wake_up_io_thread(local);
>  }
> --
> 2.43.0
>

Hi David,

I noticed that an equivalent patch from Seungwon Bae, =E2=80=9Crxrpc: fix
use-after-free in rxrpc_poke_conn()=E2=80=9D, was included in your fixes
series:

https://lore.kernel.org/r/20260923133706.1496540-18-dhowells@redhat.com/

It appears to address the same race using
rxrpc_get_connection_maybe(). Since I reported this race and submitted
an equivalent fix on July 31, I would appreciate it if there could be
a Reported-by tag, or Co-developed-by tag for me.

Thanks.
Chengfeng
