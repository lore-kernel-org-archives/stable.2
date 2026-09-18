Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B55208B7
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759103; cv=pass; b=Cg+n3MuDY2u8l4VeTSEiAA50AHUJTgwArE/fC9l9gOc6R1RtclqDjJyTvRmoTVeiIYo4sDt5MI5yHG2N/MW5IlE78ajZQqSAx0svUlfZeIJbTfH8EKIqe6ASDYXzsp67hrnIMXgcvNSfQ2WVC6aCTU5i/0ei4jeLbn8jCJINPb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759103; c=relaxed/simple;
	bh=d+XJY6IjEfDw6B+KKS046I9YvRYsBRFL5fcv5i6AeZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEiaiA8md4eT26lMG3ErEhsjqXpt+aldWS+qDxANB2I2cWSVRsZLI43JePZ/zIdZ9rOam6HrI8DxU2M4W2F56NagE2Q5xly2RoQCTZ8rHQ11kmK5x7WQfX3X8y1IrU0IHa9xskb3gaGvXbIL2LMVNjAEGi3NkivbWyI11moyNkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2Pw+oiv; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2Pw+oiv"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8631d0023daso876381b3a.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 12:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789759097; cv=none;
        d=google.com; s=arc-20260327;
        b=SCb8yTypwajdnJdGK1xFQfizIAOFz3tBgijKn5Xia4jTs6FQ4WYiO6DoBq8fVHr82E
         pY5pFyLrezK+9nlAIhqxYC3yIQ1wRX8jlo5nB2tYa7R1fjpEjbjtZoyJmGtDdlUA+Ymd
         Gnjd6l+ORxGkKezQkVv41w0EWKUx4BfhLt4umBPC7XBvvbYcuNBN1p3Aj6/9O/CbKg/T
         GWPw52mfaj5zYaSxYLIsk8DibZ8UzOgbD7QMf643uC9Jb/QD1rsmQYLAKG2IIOy08sLz
         nxUPJZMbJHbqRzhgeIe+19maLZy93gJyxl5xdnq1AEilEQJVchR6FIT59qMH1VHxMuer
         buoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2troVCYCbvQMPjyP8m9Thskq3hQDCRWw6lGuoi8DN70=;
        fh=QEguaGWo+eEve/EWj4TANP2zsI6oKjezQLNjlzVU1mU=;
        b=nGoTW/paNLM/3dU9rxzD5oWrDjCIB0IUvXwarZ5M3d011cJCaXqJDQerOl3ezZujYu
         Rx+QZ0YVHK4MyvM8GZTsJaVJdlSpdUANtJhd6Aqi8ruRLKRdtY5guZMO3SZyE/YW4f/c
         a9JrGYu+LLKFgUKagh9bnxuYOree2ySO4BIpYJh+nOVSa7fsPEiBb4VHCn7/ok2qsOBj
         j09OwGAsPaj513nYz6oWqWdne1o34uZBPE+bOeQt0BRprHrU3fKgzZ+EVI+2uY+b8aJk
         tOycT2XB+WgWP3BDStC0Atw5AVPbkxG0ZEW/lYN+xqRJSojJQGC+bmT9VDwZysiybb47
         t4Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789759097; x=1790363897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2troVCYCbvQMPjyP8m9Thskq3hQDCRWw6lGuoi8DN70=;
        b=i2Pw+oivlDpwZA9WTvtnw+0/1M/n7/s5NjSEjRRbghCeabioGNa59ZCrMZ7Mbv1Je0
         FgXKpuS1E2A1LyIfN/QdEIKFh6qVX7VmE2GCllCGWkqqBZcqEZbOg9fX0dZ1PSAvkz5n
         Om0U0sJOmZoWDnY9nV6RJxQlxCgPj7jeKJwcmOpgajwi2LfynleHOOw5NCfBLATqTrNH
         e39v8RySMTRWQcEF04tDvUmhA++WWH/eYWHOmTs1I/6iKR3haHNE9qE9LWSm8n1zzXVq
         RoUis+EGa7GW0t1IvGlNCghW7Ssl9si39ErvYThos18K21NQdlMcydlxhoxlXxiQlncd
         2uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789759097; x=1790363897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2troVCYCbvQMPjyP8m9Thskq3hQDCRWw6lGuoi8DN70=;
        b=XKq4iMxHFC8+ArrKfNlWWmeXkP/1wMUc5PMzv3Lo4jCepsHufWsZWPbYmBcHxPccx5
         6ZH+hcEKgXakHYyQDkpL6FSQVe22ZTu4ZweiRFh5S1XXe4RUsArI7qK0TAE6OUps6srQ
         3MM5tn9CRSQ0ZHnsdnqeJDvPEz5wHlda5dBem5N3V+xEhLvdyUwGpYhChohg/JIJ9fI5
         fDDK4cY7QK7Sd6vLDHt7ttT2y3pPiq0N/LoiSxbPCvB8bj7qrXgmg7+dC6VpN8ZLlg9q
         8HF1fQvdeYl7R/KW4RUIVgfO4CwkQJcRe+DYrH5talSLrrPE7OXS1e6XiK2u0JtrYq8V
         I+oA==
X-Forwarded-Encrypted: i=1; AKwUvBzL6UxoG4z7xbvYaskbMmcJtAPcXBi7s8b2KVYTxO+DssEYU+sFzdQ+SlWYgSr0rk/yUdb2qBU=@vger.kernel.org
X-Gm-Message-State: AFuF++n6X4RMPGUzxztu/6iQjyILy/auyXmqdtOUL2NH+KytFNMZRDk5
	QHXyX2ghMTqgpEJDcZoY2I1AGRsxn3FbmpAB4kyLWHUaZWVZ0K0AtTiQxLBQz9YGJnAXhqSY0bP
	dzy7dqq7M1WPHy94WwnrT22xAwZewzVY=
X-Gm-Gg: AYBFou3+Y4ea9j7HW6ghsq/VDD8kX4KCkuFoLIph4QGZgmwRAg560mAoQ9ejIQ7m44M
	DdtnEFOQwiDomwV6r1I6n8KDRa5/VuzR+qn9iXzKoZXawsXUfWL0AbhgadCb0WK5y9Bn/O82x2t
	ni5x1aLC7qoCiv9fMhAvyRVkPL811hE9P3qkwFfhAi2EvUKjbM+takBDxY8KCMGFzNcJ6flmGyq
	2Y/9tbw7jwgK7WKwPjCgUE5AbZY5Bu+rmAvnErdSyQHpKc/cQslvYDdPJCqTHSv0gwCADo5LVFh
	3oV3gG8Xf/hFkbZ3ywR/DGKSpFuOoPOu0kUxxV4s4GIuzpvjXCrkWp4oGmhPy8fRF7lhg2XniN5
	DkpcPjehF9M7b1rhbRhG8FgemUqNF2tFANnrbh/EHNkETjFa5vx+IZvhu
X-Received: by 2002:a05:6a21:a382:b0:3d3:ad3c:49aa with SMTP id
 adf61e73a8af0-3dd8c5161d0mr8117225637.24.1789759097369; Fri, 18 Sep 2026
 12:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915095017.942213-1-sunyiqixm@gmail.com>
In-Reply-To: <20260915095017.942213-1-sunyiqixm@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 18 Sep 2026 15:18:05 -0400
X-Gm-Features: AcwNN1X66cAUN51FSkageQ3G0yykNkwaD2lYLObSNsrm0QVEPTOJRupGwVR0DZU
Message-ID: <CADvbK_f2oTzRA4x5+5QsTkKeXAmodgD3Noypi7sULf3-7MKQPA@mail.gmail.com>
Subject: Re: [PATCH v3 net] sctp: avoid livelock while updating retransmit path
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sunyiqixm@hotmai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:51=E2=80=AFAM Yiqi Sun <sunyiqixm@gmail.com> wrot=
e:
>
> sctp_assoc_update_retran_path() can loop forever when every remaining
> transport, including retran_path, is SCTP_UNCONFIRMED: the state check
> runs before the wraparound test, so the loop cannot observe that it has
> completed a full pass.
>
> Fix this by considering a transport only when it is not UNCONFIRMED,
> then checking whether the walk has returned to retran_path. This makes
> the full-pass termination independent of the transport state while
> preserving the existing fallback selection semantics.
>
> Also restore the NULL guard around the retran_path assignment. In the
> all-UNCONFIRMED case there is no eligible replacement transport, and
> installing NULL would leave later retransmit-path users and the debug
> print with a NULL path.
>
> Fixes: 4c47af4d5eb2 ("net: sctp: rework multihoming retransmission path s=
election to rfc4960")
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
> Changes in v3:
> - Post as a new, independent thread.
> - Drop quoted review discussion and the reproducer attachment claim from
>   the commit message.
> - Link to v2: https://lore.kernel.org/r/20260902025206.phbpyxmpf4zrtdpx@s=
unyiqi-llm-kernel/
> ---
>  net/sctp/associola.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index c0512c827d0f..4521be3bd85a 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -1289,18 +1289,19 @@ void sctp_assoc_update_retran_path(struct sctp_as=
sociation *asoc)
>                 /* Manually skip the head element. */
>                 if (&trans->transports =3D=3D &asoc->peer.transport_addr_=
list)
>                         continue;
> -               if (trans->state =3D=3D SCTP_UNCONFIRMED)
> -                       continue;
> -               trans_next =3D sctp_trans_elect_best(trans, trans_next);
> -               /* Active is good enough for immediate return. */
> -               if (trans_next->state =3D=3D SCTP_ACTIVE)
> -                       break;
> +               if (trans->state !=3D SCTP_UNCONFIRMED) {
> +                       trans_next =3D sctp_trans_elect_best(trans, trans=
_next);
> +                       /* Active is good enough for immediate return. */
> +                       if (trans_next->state =3D=3D SCTP_ACTIVE)
> +                               break;
> +               }
>                 /* We've reached the end, time to update path. */
>                 if (trans =3D=3D asoc->peer.retran_path)
>                         break;
>         }
>
> -       asoc->peer.retran_path =3D trans_next;
> +       if (trans_next)
> +               asoc->peer.retran_path =3D trans_next;
>
>         pr_debug("%s: association:%p updated new path to addr:%pISpc\n",
>                  __func__, asoc, &asoc->peer.retran_path->ipaddr.sa);
> --
> 2.34.1
>
Acked-by: Xin Long <lucien.xin@gmail.com>
