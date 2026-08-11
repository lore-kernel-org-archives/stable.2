Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574973B2FC2
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463103; cv=pass; b=aFplon29CuUBk8jU8WkSJzOx442dBAOOEMzu34EFq0RwgG3/jb70t7ky4Ai2cony6lXyQ5K3avc64ufZQsrNlKGVTIALEM8RC01+V7rPg0XAP2yfMT0TrpsvCKuU9Y1LI1VMny4orqpM2hennLrR4KHi0XeHSNQZv9x1UiQ22TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463103; c=relaxed/simple;
	bh=kiBeJRw3F0UCXM6tUWHubLSiJlh1qedjzGoqp1q+qD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVpoYhnfoi8sctsK4REz607nqXLTxGSjCzZ7o3VLVoK2pinl58fvEmNMlTTu0qv4pd4y12CjhOkb9f+PkuyErM1m8NmVsw/9LbKPRFN8du70AFqe3zw6MBVSReTiGtAMVEeAZLT/u3ALrikf3xUS8yFCv6tlhLcV3C+5ty/nCe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYHCYE+K; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYHCYE+K"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so503b3a.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786463101; cv=none;
        d=google.com; s=arc-20260327;
        b=r8m4HU5/k0eX4yVvqTmayN+JPetiV/J3tC0v2RRh3bLMsTdszFGmVnTzE0VYYLED+g
         5VOaoYmRkwXWtIMnsEbRAYfsa+oltlcQnpMJw9rOMQbkEmzboPOGQ1n+E4XTSqHAnMor
         rh8NJPRNbpYNFe0V9BdLuQUuDS/XgVer833NBi/jTjQ+v3YpTy0wZQT8uLvYzqFhw9LC
         7xCNqvi/3QIyTrI2OGpHfUtVqXoys1la8NS4xemI4pEu4GKy1vO7ipwy5jWpqwAhCHPN
         Du4r4C06Vn/Fa0CGc9clYIGmXS3Gc3SIx836x7W2QczkemN2L8qpL5ZyZSRYbRZgCUri
         JokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4gtUlPd4QXnv5aJSE6TKQZzjopWrXWWTIrsnHYKRiVU=;
        fh=NlewnwqLsNEoGvW5/1xjmNH8/eR89lmtpzmkIdXFptE=;
        b=TqTXyB7hUB3zxhN4xvARFGigkfcNhJvYfG8lyzuqKdjJ/MQKMKax2Z/bQuKIkjSdO3
         v3s6VRFW28gB6VKPlg7uguk6A2QUkIKKq7RGjRFoHshO90zXRDiFqnu5msFCp5CaAfd+
         wxxgTmwYvDxiQgx3Rscxx7gYijCXNMNcP1dF9RelxEKWXucBbP/Hj//ZEitdU28y/gpM
         8CMkbC82jDOI5NZSyFNLRzbbF4tYGD49PouphGja8h+wPz6nzsq5ls3nFmWrEG68Ansf
         FEgld7SM+/6np+dTSDgfCU36ZToC7HGjtjKJq/jIWJR43p0arAi0oIncD9+vHs2SrcPu
         Oxjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786463101; x=1787067901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4gtUlPd4QXnv5aJSE6TKQZzjopWrXWWTIrsnHYKRiVU=;
        b=nYHCYE+K93wg5yhBFxoAnHVK2YzFGdIbZ3sqpsHErwga52haBlJBzdIe/0Jgn9Oj0e
         zTDxuXz6XvM76hSsDd/t9RM4zlF4Fb6UCZwed98yo1rZikQc/OaBSbeTVF3S8+jnUnAP
         Q267m4mHNKZ2EQgPjjmJ/OZIH691TUbLQ0q46JqCfE1IWlgSKcDsQ2Dovtz18Pe2IXzV
         MBqtV43rxFtSIujgqo1+8S6jOrQD7qY6hJ+eN7rfGL49LdVDziiHDzZ4VegU5ZtvoNjK
         sQcDrVoxtCB3YAQR+UnVHUToJYs7YjlsRA7Qu5ldJU09QizTtPybuaUyezz8EERfHwpp
         oVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786463101; x=1787067901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4gtUlPd4QXnv5aJSE6TKQZzjopWrXWWTIrsnHYKRiVU=;
        b=pBEKF7ElYBNVO4BH4V9/6cV+Gntk92OrxKUPUZaT4AkCxlylXhANq55YvFq8yA6j0T
         9JN052H9JjxZ8kekXDMjigbScLaJe6mENloO2LQxqN28y8jAmKilm114trxKboZAqSo9
         W+H9jqYtSfvE6ub3MuyNZd/e9SEtk2QNOdCoDF7sNcVFqhopuRBTNp76WaPh/lpGb/32
         oG8z9Ic7rAuiFQ3aX4+oEM4GRrf+Utd4vF7zKwDtkXPl5WOx4tw3DspS6xDtMEQkRVab
         EnthoJ7QwswJXUlVMnPupqXT8O/Wn7YBGhtvQcxfCcg1RSNYw3iMSKEMENknCNlJPdPy
         w+4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpfmqCgeVPKSVas4vmqTA7hy6/rQZ1i6XC/BzrwPRQnu7eaevD3WFBdak3AEiFolJZDeRSbGpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+L6pn/ov0J6wbTApxVvlOpUUGdF5/TMsehRFO1G4xiClZg3Lc
	nR1M4YLyN/q0YY3L5ccNFUeu1pj9PwGqpRWdoQanl/euRb7Pg8GdY6xoptACESmL+ZYSersOvgd
	F5WmTap3t1undtC5ovtsffwt7GHyhgUM=
X-Gm-Gg: AR+sD10eSqXhtHhYJzPU+LHzG2oq6kiAWiTbLv8t9IQYVvbC3vOxWkaa/JQXEknEhL/
	y5fhHbwIiKm5Px+3lozCw0I53+XBF10txOjCDb81qIoVaCP9EH1T104RReGot55viP5RPT/w69F
	eaQrD05UiV8Cii4m2uE2maAFvQHhcpms8as/X+2RQFhMbmkNORdnA12q+03rVBlrAxJoFy6wBYI
	2pnUhNhs+4oFVgmFSbeFudCdG16NSTwzDSeXlh77lCGGH/64krq0HvQLhLcW4VwBcza1f4xvQUa
	y4JLnpWH7dM+mRE608v7JCCPS00zYuEn+CHnOYV0mb7KlhZO1fUw4QQDeeapJLCBuQkt/Bt/kKM
	lbnJ44n1Twy/S8SSsxwFRt1TyUWsNnWlu8kEjsM93dfd6
X-Received: by 2002:a05:6a00:3686:b0:84e:1a9d:d879 with SMTP id
 d2e1a72fcca58-84fafa00b17mr1347220b3a.28.1786463101312; Tue, 11 Aug 2026
 08:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811152803.5629-1-a0yami@mailbox.org>
In-Reply-To: <20260811152803.5629-1-a0yami@mailbox.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 11 Aug 2026 11:44:49 -0400
X-Gm-Features: AUfX_mxJP8h_5PE3kHQzF7Hk7Dth_b-NuFIjAwOMUfCbiQUPxt95mvRzMhw8ci0
Message-ID: <CADvbK_d8r56n6FHFEeyz0cpmdoFJ5HXJ4m0XipQqYXTiL-YLjw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: clear new_transport when removing a peer
To: Qing Ming <a0yami@mailbox.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Michio Honda <micchie@sfc.wide.ad.jp>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:28=E2=80=AFAM Qing Ming <a0yami@mailbox.org> wro=
te:
>
> sctp_process_asconf_param() stores a newly added peer transport in
> asoc->new_transport. After all parameters in the ASCONF chunk have been
> processed, sctp_sf_do_asconf() uses this pointer to send a HEARTBEAT to t=
he
> new transport.
>
> An authenticated ASCONF from a remote SCTP peer can add a transport and
> remove it again with a wildcard DEL-IP parameter in the same chunk. The
> wildcard deletion preserves the transport on which the ASCONF arrived, bu=
t
> removes the newly added transport through
> sctp_assoc_del_nonprimary_peers(). The removal does not clear
> asoc->new_transport, leaving it pointing to the removed transport.
>
> sctp_sf_do_asconf() then creates a HEARTBEAT whose chunk->transport point=
s
> to the removed transport without holding a transport reference. During
> local address replacement, src_out_of_asoc_ok keeps this HEARTBEAT on
> control_chunk_list. After the transport is freed by RCU, a successful
> ASCONF_ACK for the replacement address releases the queued HEARTBEAT and
> sctp_outq_select_transport() reads the freed transport's state.
>
> The issue was found during a static audit of SCTP objects. With an
> authenticated peer, the reproducer triggered the same KASAN report in 2
> of 2 unpatched runs on a KASAN-enabled netdev/main kernel:
>
>   BUG: KASAN: slab-use-after-free in sctp_outq_select_transport
>   Read of size 4 at addr ffff88800b9bd95c by task python3/197
>
>   Call Trace:
>    sctp_outq_select_transport+0x549/0x8b0 [sctp]
>    sctp_outq_flush+0x306/0x2c60 [sctp]
>    sctp_transport_immediate_rtx+0xaf/0x260 [sctp]
>    sctp_process_asconf_ack+0xa48/0xf70 [sctp]
>
>   Allocated by task 197:
>    sctp_transport_new+0x68/0x650 [sctp]
>    sctp_assoc_add_peer+0x258/0x12a0 [sctp]
>    sctp_process_asconf+0x5e9/0x1090 [sctp]
>
>   Last potentially related work creation:
>    __call_rcu_common.constprop.0+0x77/0xb70
>    sctp_assoc_del_nonprimary_peers+0x7c/0xd0 [sctp]
>    sctp_process_asconf+0xd9c/0x1090 [sctp]
>
> The first invalid access was a four-byte read of transport->state at
> net/sctp/outqueue.c:833. The same reproducer completed the full
> authenticated ASCONF and local-address replacement sequence with this
> change without a KASAN report or oops.
>
Could you also post the reproducer, at least to the maintainers?

Thanks.

> Clear new_transport when its peer is removed, before it can be used to
> create the HEARTBEAT.
>
> Fixes: 6af29ccc223b ("sctp: Bundle HEAERTBEAT into ASCONF_ACK")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>
> ---
>  net/sctp/associola.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 5b0ae616e1ff..c65c83638cce 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -543,6 +543,9 @@ void sctp_assoc_rm_peer(struct sctp_association *asoc=
,
>             asoc->addip_last_asconf->transport =3D=3D peer)
>                 asoc->addip_last_asconf->transport =3D NULL;
>
> +       if (asoc->new_transport =3D=3D peer)
> +               asoc->new_transport =3D NULL;
> +
>         /* If we have something on the transmitted list, we have to
>          * save it off.  The best place is the active path.
>          */
>
> base-commit: cba9ccb47e9fa4cc77692fb896cc5ab57a667882
> --
> 2.53.0
>
