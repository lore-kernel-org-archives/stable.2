Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163E4CA770
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790292; cv=pass; b=W5qp4QRTCAb2q6c2Sczgsq1kwQ37/UnEmt6k6AU1zS/9ekPgAmyV3u/lMH8+tkkqcF0jj4NHoS3FX8ewDUQD+J1HYj5fW9krsnK1avJTkyp7rXTf5jmtFu8G+3uozJzHc6lTAVzyVAf7IOdE9SWQzayof6cxwNL72gJM4p44wAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790292; c=relaxed/simple;
	bh=YQcfcs+zJnOKaJQ5IHf2t2NLY66T+7nBA+9fE31khyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhGL3sAGa8/HTMdgS2Eg+qR5FAUhmzZiiRUwFNVE8TkDOeEE2OptWMED2q3qpcRtvxXQRr0YXuFuxq8wmCYCdxcNjteErrKM/Y7hlC5SzbVzsjzRKEZyP27xkOD6jeE3AwWgqSsLmXY7k1IhxwpEBsyjxRWTuZTC2RA8StOQMmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ft7FE0rQ; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ft7FE0rQ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52e2d1bdbc0so22316121cf.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 07:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788790289; cv=none;
        d=google.com; s=arc-20260327;
        b=ltUB1Lfu9FDDQxnyOuR6ijbWQDM/JWpsvhajGoO+b0MJ3Mp3rrQjGUjrku1x1dP77Y
         jPz3KfykpA83eh4noBYQFfWb7igZOTbHKc5/eqMnGAk5eLRdXA1u/I2dThQhJrXUfX0r
         8QNNz6dXMhmPeXNsajDV+79lHIT/+N0qxomsmNLApVbVOgueHm+VhIX+0I6NSB86IAKm
         vpYtBjsu90foJJCg+PEMa9XZnkNbhAb0tyEnHS6b9Fhr9KNkuv50sx3rfB40MuzT7rZ7
         4oUa7JqQokTm5Bdt5B04MM5bIrHJcZYYMKgHCihaMGYcKmIyAljqlEWzH8aKEJHfh+RY
         Qv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HbWRZ7ulK/8VAdzXceDJhVzPUhV9UxTFxMw6kD/qZtY=;
        fh=Anp0Lmp/KXKvqJRmL3ROT8AaHjT+0KoGIjgWR7tFF5s=;
        b=DaOC36MM8GgvqLp6brJUgrpdyxjAjjRTQhUgBtSpzzab5caZqhkAdaHxtOn65hViEX
         LZPutE1NSkh5OvU28g8XomKj4kjJzygWO9yunlk+al43soNm8bNT1fzU0OzPWPFQ+NB3
         HA/0zuZPjjxdYWm/JVCGPqfBT4beRmEHG8565jwFOAXt1HqZzfG7/aZPlwQ48c9s0Jtp
         XxJlHQbJUPpVsEMA396PD0eEQYx6smRhk+++2bbcY5+ToelXXHZV4cVA/zft0eoAAxM0
         tMKhDLZrwE/De/5aqOCMqnDBooZ1On++Jh9QYWRANgPxf69YuF8eyAr3Q38SSPIuC7qm
         nZDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788790289; x=1789395089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HbWRZ7ulK/8VAdzXceDJhVzPUhV9UxTFxMw6kD/qZtY=;
        b=ft7FE0rQwpnJ5clUH/tqZtW7KHdFzDnkTmhwB2rfJGSQbeySO4db3HkkabIHaTvw2m
         UaXTYLGQNPdFOpsUDpQdmYAtmD2Ft8u8AuyPgFwgkqYOyduLPdLYzSP1FAKYWXatKUKI
         R6YFXMV1P21AJjYknM+XSaJFIBq1f1AvxnXkjHQiV00HLpBo9s+DaNOZAzEA/H/MN4F6
         +LRK9bVit/jGW+GUeq4NUoClIfSw+sdv6uO9X5cfsITp16cvsvR4MAd1WX8oqrW0oIIg
         VWbwyxwJJr90eCaXObwO5Qi3oZjOl8M4NNRoyvlwQyxvti3VlpL3x+JTrgl0W/iYKsmp
         6yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788790289; x=1789395089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbWRZ7ulK/8VAdzXceDJhVzPUhV9UxTFxMw6kD/qZtY=;
        b=S04tDwXRMjscQNTMr2jbXP14k3oqUbrV1ZoW+TnzwzcxLsDWXedcn9mTn7hGux3IyF
         pykz9q6Jd6hvg1xClpg53sgaVasg1kGsBGH9/O60bvLoaA/DZxvE+yFVN8WHq9vw+v0n
         3Nw+yIZvk+b6PjDRYKbRHXemzxFSv6VVOMpXCyL4dk+xDDb1+2pAYGGbtYGtsJuQRQ5b
         5bfJMxQn2sk2je4C5KbkvxGRHdsmweDfeSxH4oMMGFOjfWwqk0lspvBhihu/J/nAgLpR
         wfngZIgA5NKU32eScNjmKM7T2UuiM4QgoZwKEGfv1rcKtGBDp+XUDVNpDGsoDYRhaCgq
         77uQ==
X-Forwarded-Encrypted: i=1; AKwUvBzc2oii9ClBoQIAEzMjYriW4u6A84+iIP2bKvLjMP6KZWfUA2r0a/NbaZYGaFMQI5M4uaFy0Iw=@vger.kernel.org
X-Gm-Message-State: AFuF++nfohWkqmLXrKD6YirJQL6kul1UTGmnGs4oCSCw+X8HJ57Bvouf
	jpK69S86qDkgOQP72GSPLa3Q2XvykmHWQ9i3BY2teDg0DZmr7uuNhf5sxcS0oa3MoKjkb8N1G1J
	SGtSBo4BMMaAEOOmuZ2ilg++EXuiyX14L+NTake38
X-Gm-Gg: AYBFou3/9JVUmMtIeFOQZEclJW/bVqfa8hm6tV2jK2V3P0LOkj/j/rot1vqpQZKnNoi
	HyFggVSa34lpAD8B+LI2xA4a8FkET7PhyIjW/YCn0cK6eKNwE9cL37UCGPXGHuCX3+7+6umCBNT
	3WagHcxQtfkvfm/CiF6C/CvFnVhezVA1Waxm5SViQqPNMdQRM+Owtyoc6DxnEDtToSMXo8Gxf3L
	T7DdR8giJ6qutZ3t0Jv+zqaiqEgi0sNMrwI1zvyAQG/8tSHfzufwPYL6VVKfBIihxkbK5LZ3RF3
	Hq1q+Ep3bf3bH9OD0h1CUc98GnhxoC+lgokqKWaiwViG//5X3JIyZrdgZUe/jHoVK5zRugS9Nch
	Tl2PQogxTht0Cuo6Rq8072H/U80OPFkYA6jv7k/cHglnHW3oQuovoVodvpQ==
X-Received: by 2002:a05:622a:447:b0:52f:a17e:a37c with SMTP id
 d75a77b69052e-530548b37demr250752421cf.21.1788790287557; Mon, 07 Sep 2026
 07:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788775605.git.zihanx@nebusec.ai> <d1b0d3a224167afa0ee61db0c9f778a2d12ff9b6.1788775605.git.zihanx@nebusec.ai>
In-Reply-To: <d1b0d3a224167afa0ee61db0c9f778a2d12ff9b6.1788775605.git.zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 16:11:16 +0200
X-Gm-Features: AcwNN1UohThSqovfEz5VNgNu8UI12XNXXPGGypkZuhzhsenoEmI5CUiOgty9A4k
Message-ID: <CANn89iJjUL9LJPipeCZKq3F=Rjhq-gdCKwnuW0pkvvpS_ai7UQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] inet_diag: cap bytecode filter complexity
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Vega <vega@nebusec.ai>, 
	Luxing Yin <root@tr0jan.top>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:53=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> inet_diag dumps run request-supplied bytecode through inet_diag_bc_sk()
> while walking TCP, UDP and MPTCP hash buckets under their bucket locks.
> The auditor currently accepts an arbitrarily long program, so a dump
> can spend unbounded time in that locked section.
>
> That fact is already present at the git epoch: tcpdiag_bc_audit() had
> no op cap, and tcpdiag_dump() ran the bytecode under the listener and
> ehash locks. Later inet_diag extraction only moved the same code.
>
> ss(8) filters only need a handful of compare/host/mark operations.
> Reject programs with more than 64 ops in inet_diag_bc_audit() so TCP,
> UDP and MPTCP dumps share the same limit. 64 is a policy cap above a
> normal ss(8) filter, not a lock-hold budget.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>  net/ipv4/inet_diag.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 34b77aa87d0a4..1ca528cd3e72b 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -725,6 +725,12 @@ static bool valid_cgroupcond(const struct inet_diag_=
bc_op *op, int len,
>  }
>  #endif
>
> +/* ss(8) filters only need a handful of compare/host/mark ops.
> + * Bound the program so dump walks cannot run an arbitrarily long
> + * bytecode sequence under the socket hash bucket locks.
> + */
> +#define INET_DIAG_BC_MAX_OPS 64

This is unacceptable.

I am tempted to say that any hash bucket with more than 1000 sockets
in it is a problem, not only for inet_diag.

Since there is no soft lockup, this really looks like an attempt by AI
to break legitimate Linux uses.
(Or slow down as your prior versions did)
