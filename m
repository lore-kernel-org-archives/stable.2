Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF142A79F
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879528; cv=pass; b=pvhHp+gH2p3jGdBHXwTkfBNew91XyKIGMCJpZ5Gl6KYZ9MrS1MguOIJMNFliJyJawzGHswTiO08cS8T2o1NMax2s//MZh9aLozvx9pYP3uhryR9qPCvpGBejCmMilz1qBECExq2DOomdm8ReOdE0lxEiq/yomqCvlJg8F97Kbos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879528; c=relaxed/simple;
	bh=HPw67P1JaDyf+3Qi++4bTv49ZviLpxGpA5izJb9AyCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gefYmtrtP/k4BybInXO3HBN7qTRwWEcBjWKFxNBdaf0sExpJSAe+oMECYIe8UaB4gJAvbD4Zk8gq/OJwT4jhQ3aHrs31tOj/54qF2UOZ1FeK+G1bc71PzLoKWDSQPQ3IP1R6CqBAUu8W07KTa66CQFaIKiZh8zWd9SxIt1oSik4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW8O/Z1V; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW8O/Z1V"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84874b52eabso419478b3a.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785879527; cv=none;
        d=google.com; s=arc-20260327;
        b=KpB0rJrETN0qkTYR0cDaivfoBUjHlpvKVm6GtcdjY3JFbWYA34Dt0AImLFe3avXUpX
         Mn8vY5Ap8vDa6tvIkdeOv2KDK6BXoTh5VeRxagKnHt0T6fe3E1MQJz7VkQB3g5dr3+FB
         YD3LWEw3ZzXWs/pTszzFJo5MMHu72Uytaq/PzmZtoY3wNQfTGpyW4U4YZCzroBWFUASE
         XZma/CWqLMaWHM5b82MnAbUZNNqnkPNS84R/Drja7HI5U4fOTDmLYH6tVNhqgr/P8gOT
         zR2PE9sgVcIAKglBikgIHagphi6O0ZTLQQ6WIFq53JRnbC/cLj68CQDSYV/18xhgmtzR
         QiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B6KIbQNVhd86qsyAZv144/o6xQEuZj0wYuM2h/vplZ8=;
        fh=Dy9gwHM6TYD7yprkeGagghohGNiplMdGIOkEw7ZWtM4=;
        b=Fp9YFcdwso5VNYCOsaG3pZpV8mB8v48b/wEuRTJ1tKFsme/s2CfUpnN9+JQ5ZYi2Wb
         hEUlDbl0mUuoev/+NmMQtfAbL4Xo79x8tFeJvUW9M8iKqq82BRkCNmYaEVgsSe2NXc9T
         91I8W4MujkQ42hd81v1kG0GWzVtn0wFEyYFpmc0HsYKOYyp9kF+ltkbhH8iDT6EOMFp6
         120Kdulsmg9Mc2Q4Pb85amUcN/iTToRsgaxdpokKDd9JKxALozkw/NjWH+/phu3sSxsL
         /zCbFhZrwE0ak8NgQwUGyehix0/07y/5XtuZATIfQ4Us9IFurhJyb2HPTydibXcEjNvK
         tvcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879527; x=1786484327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B6KIbQNVhd86qsyAZv144/o6xQEuZj0wYuM2h/vplZ8=;
        b=aW8O/Z1VCyJTc71MHaqI03EH4TJJPsZiwy8yLbJW6MDdV8EBl7iWUCxzISCQJrTkhP
         ZhUsRhmQQgQvDYGV9fwUYcqQEshx2C7AE9B4CA9yWhb2SXJBFH22MxMdo1a+7aVHsTdC
         ava6AEnTM8JzEDrd8Sxwk2pAxdgWTlartVZwWQyR1jabaxoAjAiDVLbSmhCt5eCK4Dmq
         kBmlsMSlGT3wp9+Qxa8PixFrTxA7uPXbJ7pAolL14IOybFlwwGatA4hjJDjIb8eRN8rq
         NmwTlIqJLT2lS4TZRNzZ+V9hEnIqLb/7rNTik2KyG7LmRrkTAYgJsn/MIJRfItTH2tkt
         7M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879527; x=1786484327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6KIbQNVhd86qsyAZv144/o6xQEuZj0wYuM2h/vplZ8=;
        b=Kvaa1lAm3hkpRevR9amjWhHJXllgaE3m+3v8TNWRai4hMv5VVVNqHheZa/y+Pro195
         ZJEjkKNAXDHTGXt69lwgXD6wE1VN/zfDv14lCtSfdS9FamprdgH9iFlfbcq0JAhAXOFE
         HRywXzAcS9sXBlDPsSzyE1exdeDTQTsIDj/jEYvB7BArGWaX5Jdl8qyfA2kzn5NncYgu
         +TG0U7+yagQL8z1dMezW/bNtxEf/NghY6K3nTBtuuDB+IZxcr9uefTI/9dVeCdD5BXaK
         6sRiNmUbVCmlbbGA0JXQTkMBKObp2cVOGKXVH2LTmHRW1oSnGDMDqiyE+UGAvEyGm7Gi
         wIXA==
X-Forwarded-Encrypted: i=1; AHgh+RpJXOYVVjWU7kdyPYqeOJ+5uGLfiutR40x45snx4Aell32bxJKFwm6iW4tifTL32+lQYXlLgK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyk3HfDwdRm5RPkgIx9H07xdmDnSR3hU5uTTRMwhI+JVObOtI
	v1Efll61jAzADi+NPxaX+l8cTW8OiBO1Uh5MUDs9y01gT3BcYikBnI3nEMnCOe2ec5DvfR2Ku4K
	a/90k1nWdDSAToIRjzD74JFlOWeMcjee4FuqJ
X-Gm-Gg: AR+sD10oQ9lYgzSkoef6bixB6/nYsO4GeoZy6JX998dG3ALBQqNqlagVHy8M2Ecv4Ya
	H6Mo7Jny7N0r3ujCWr4hO3QgBRwYkObQv9NJjE7aU76MHpV9bUiGuReD/ti/7JHH8EP0f5PCPZz
	4TeyENzBcQMC3yffh2Izzu4JReW1XU9UqX7k19qO5NOyNPpqs3Yl/BNCvm2EuTVdaKdscwyFpgl
	qoihBzTNoxJxtRcDp9C/R3+p/Z0rwoTb1czVIa4SAMHjjky8LMuuwsPuKwtqUIsh+lT4m68mgUn
	JHsmQIFXVgqDhZwPM0FyMg9miHu2n7Ii9BvHCGYn3AEa1OTGcxqwNG+FjaSKNbeglUuFyskAAXD
	oUEK9OmHuKsKOqJFrvfvzLvQ+a9zPehorZnemkWutW3k=
X-Received: by 2002:a05:6a00:3016:b0:848:6895:b754 with SMTP id
 d2e1a72fcca58-84f2dff6cc9mr1867806b3a.28.1785879526616; Tue, 04 Aug 2026
 14:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730023309.21654-1-omeux327@gmail.com> <20260803233718.2336399-2-kuba@kernel.org>
In-Reply-To: <20260803233718.2336399-2-kuba@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 4 Aug 2026 17:38:35 -0400
X-Gm-Features: AUfX_mx0qsQi4XvAs8sThQUkRgCKrDkD_PKPxvhHU85HH2SPOTpO3L4PvjQUwMA
Message-ID: <CADvbK_f6qcqPj=YqFDfkgYzzw+wJp9k5fkH1jjgM6xn1rQggJw@mail.gmail.com>
Subject: Re: [PATCH v2] sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
To: Jakub Kicinski <kuba@kernel.org>
Cc: omeux327@gmail.com, marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 7:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email says "AI seems to have spotted another related stack leak, and
> suggests an alternative fix."
> ---
> sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
>
> The patch changes inet_diag_msg_sctpladdrs_fill() and
> inet_diag_msg_sctpaddrs_fill() to zero the whole sockaddr_storage slot
> first and then copy only the family-dependent prefix of the stored
> union sctp_addr, so the sockaddr_in6-only tail of an AF_INET address is
> no longer exported through the netlink attributes.
>
> A few questions about the changelog and the placement of the fix.
>
> [Severity: Low]
> [Finding: main-1-2]
> [Sources: opus-5]
> The changelog says:
>
> >     inet_diag_msg_sctpladdrs_fill() copies sizeof(union sctp_addr) (28 =
bytes,
> >     the size of sockaddr_in6) from each sctp_sockaddr_entry.a into the =
netlink
> >     INET_DIAG_LOCALS attribute and then only zeroes the bytes from offs=
et 28 to
> >     sizeof(sockaddr_storage).  The same pattern is used by
> >     inet_diag_msg_sctpaddrs_fill() for INET_DIAG_PEERS.
>
> Can the INET_DIAG_PEERS path actually leak anything?  transport->ipaddr
> is allocated zeroed and only ever written with sockaddr_len bytes:
>
> net/sctp/transport.c:sctp_transport_new() {
>         transport =3D kzalloc_obj(*transport, gfp);
>         ...
> }
>
> net/sctp/transport.c:sctp_transport_init() {
>         peer->af_specific =3D sctp_get_af_specific(addr->sa.sa_family);
>         memcpy(&peer->ipaddr, addr, peer->af_specific->sockaddr_len);
>         ...
> }
>
> So bytes 16..27 of from->ipaddr look guaranteed to be zero for AF_INET,
> which would make the inet_diag_msg_sctpaddrs_fill() change hardening
> rather than a fix.  Should the changelog say that instead?
>
> The changelog also says:
>
> >     region) are left uninitialized.  Those bytes are propagated verbati=
m through
> >     sctp_add_bind_addr() (which copies sizeof(union sctp_addr)=3D28 byt=
es) and then
>
> sctp_add_bind_addr() copies a caller-supplied length:
>
> net/sctp/bind_addr.c:sctp_add_bind_addr() {
>         memcpy(&addr->a, new, min_t(size_t, sizeof(*new), new_size));
>         ...
> }
>
> Callers such as sctp_do_bind() pass af->sockaddr_len and store nothing
> uninitialized; only the callers that pass sizeof(union sctp_addr) do.
> Could that be spelled out so the scope of the stable backport is clear?
>
> > diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> > index c2a0de2adf6fd..610c937deffd7 100644
> > --- a/net/sctp/diag.c
> > +++ b/net/sctp/diag.c
> > @@ -85,8 +85,12 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_b=
uff *skb,
> >       info =3D nla_data(attr);
> >       rcu_read_lock();
> >       list_for_each_entry_rcu(laddr, address_list, list) {
> > -             memcpy(info, &laddr->a, sizeof(laddr->a));
> > -             memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr=
->a));
> > +             size_t copy_len =3D laddr->a.sa.sa_family =3D=3D AF_INET =
?
> > +                               sizeof(struct sockaddr_in) :
> > +                               sizeof(struct sockaddr_in6);
>
> [Severity: Low]
> [Finding: main-1-1]
> [Sources: opus-5]
> This isn't a bug, but the AF_INET/AF_INET6 to length mapping already
> exists as struct sctp_af::sockaddr_len, and the exact "zero a
> sockaddr_storage, then copy only the valid part" idiom is already in the
> tree:
>
> net/sctp/ulpevent.c:sctp_ulpevent_notify_peer_addr_change() {
>         memset(&addr, 0, sizeof(struct sockaddr_storage));
>         memcpy(&addr, &transport->ipaddr,
>                transport->af_specific->sockaddr_len);
>         ...
> }
>
> Would sctp_get_af_specific(laddr->a.sa.sa_family)->sockaddr_len in
> inet_diag_msg_sctpladdrs_fill(), and from->af_specific->sockaddr_len in
> inet_diag_msg_sctpaddrs_fill(), work here?
>
> Also, the else branch hardcodes sizeof(struct sockaddr_in6) as a stand-in
> for "the whole union", so an unexpected sa_family copies the maximum
> length rather than the minimum, and the constant silently diverges if
> union sctp_addr ever grows a larger member.
>
> > +
> > +             memset(info, 0, addrlen);
> > +             memcpy(info, &laddr->a, copy_len);
> >               info +=3D addrlen;
> >
> >               if (!--addrcnt)
>
> [Severity: Low]
> [Finding: main-1-0]
> [Sources: opus-5]
> Does this leave the uninitialized tail sitting in the bind address list
> itself?  The residue is stored by the producers, and this hunk only stops
> one consumer from exporting it:
>
> net/sctp/socket.c:sctp_send_asconf_add_ip() {
>         memcpy(&saveaddr, addr, af->sockaddr_len);
>         retval =3D sctp_add_bind_addr(bp, &saveaddr,
>                                     sizeof(saveaddr),
>                                     SCTP_ADDR_NEW, GFP_ATOMIC);
>         ...
> }
>
> net/sctp/bind_addr.c:sctp_raw_to_bind_addrs() {
>         union sctp_addr addr;
>         ...
>         !af->from_addr_param(&addr, rawaddr, htons(port), 0)
>         ...
>         retval =3D sctp_add_bind_addr(bp, &addr, sizeof(addr),
>                                     SCTP_ADDR_SRC, gfp);
> }
>
> In both cases only 16 bytes of the 28-byte stack union are written for
> AF_INET, and sctp_add_bind_addr() then persists all 28 bytes into the
> kzalloc'ed entry, so offsets 16..27 of the stored address stay as stack
> residue after this patch.  The second path is driven by peer-supplied
> INIT/INIT-ACK address parameters.
>
> Would zeroing the union in sctp_v4_from_skb() / sctp_v4_from_sk() /
> sctp_v4_from_addr_param(), or clamping q() to
> af->sockaddr_len, close this for every present and future consumer?  That
> seems worth considering given the Cc: stable tag.
>

Instead of only copying the valid address length when dumping entries from
address_list, the comment suggests that the unused bytes should be
initialized when the address is added to the list.

For transport_addr_list, the path:

  sctp_assoc_add_peer() -> sctp_transport_new() -> sctp_transport_init()

already guarantees this:

  transport =3D kzalloc_obj(*transport, gfp);
  ...
  memcpy(&peer->ipaddr, addr, peer->af_specific->sockaddr_len);

However, for bp->address_list, sctp_add_bind_addr() relies on the new_size
parameter to copy the correct address length. There are currently three
callers passing sizeof(addr) instead of af->sockaddr_len:

- sctp_raw_to_bind_addrs()
- sctp_unpack_cookie()
- sctp_send_asconf_add_ip()

These should be changed to pass af->sockaddr_len to sctp_add_bind_addr(),
as shown below:

diff --git a/net/sctp/bind_addr.c b/net/sctp/bind_addr.c
index 31737f144c7f..1b9bfac17816 100644
--- a/net/sctp/bind_addr.c
+++ b/net/sctp/bind_addr.c
@@ -294,7 +294,7 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr
*bp, __u8 *raw_addr_list,

                if (sctp_bind_addr_state(bp, &addr) !=3D -1)
                        goto next;
-               retval =3D sctp_add_bind_addr(bp, &addr, sizeof(addr),
+               retval =3D sctp_add_bind_addr(bp, &addr, af->sockaddr_len,
                                            SCTP_ADDR_SRC, gfp);
                if (retval)
                        /* Can't finish building the list, clean up. */
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index b472565fc7f2..8da6d97b6062 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1861,8 +1861,11 @@ struct sctp_association *sctp_unpack_cookie(

        /* Also, add the destination address. */
        if (list_empty(&retval->base.bind_addr.address_list)) {
+               struct sctp_af *af;
+
+               af =3D sctp_get_af_specific(chunk->dest.sa.sa_family);
                sctp_add_bind_addr(&retval->base.bind_addr, &chunk->dest,
-                                  sizeof(chunk->dest), SCTP_ADDR_SRC,
+                                  af->sockaddr_len, SCTP_ADDR_SRC,
                                   GFP_ATOMIC);
        }

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index e4ea57a642c1..1f934a9b2e5a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -634,7 +634,7 @@ static int sctp_send_asconf_add_ip(struct sock
         *sk,
                        af =3D sctp_get_af_specific(addr->v4.sin_family);
                        memcpy(&saveaddr, addr, af->sockaddr_len);
                        retval =3D sctp_add_bind_addr(bp, &saveaddr,
-                                                   sizeof(saveaddr),
+                                                   af->sockaddr_len,
                                                    SCTP_ADDR_NEW, GFP_ATOM=
IC);
                        addr_buf +=3D af->sockaddr_len;
                }

Note that the same issue does NOT exist in the following functions:

- sctp_copy_local_addr_list()
- sctp_copy_one_addr()
- sctp_bind_addr_dup()

Although they use sizeof(addr), the addresses being copied are already
entries from address_list, where the unused bytes have been properly
initialized.


Hi, MingXuan, can you give it a try to fix it in the proposed way above?

Thanks.
