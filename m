Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795192669;
	b=i4/3jhrYjGI3+TPjYT4WbSOxDw8DxAfAJi1BKGpcoF7uffXsu9tPAjxYhgI4hLEQ4tvk
	 eeKlX62LT1mo8VgrulaVDMTIGoqUFjLs+veefGPGYczvW4ac1SKZU2zrfAZq+VUhc6KXa
	 p5VBPdtgY+myaQ613gQ/wgFzB+4lAfYyd4ncLxL2X01luK+P7f8UWbYxI4qD5dTBzMOCb
	 pK5Jk5BwalTCU47I5LkLv3p2PZ1AYwNAV6LH2bd2NXk4Atacfi5idOTsNIsd2nPpt9QMK
	 cYNDYHWT1OtAoRd/q4oPnSTH1M4IOh1Ox/1wy7RSD00ngBSH5AddozBr095NuUtQELw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8gVVdRXDHaBUhqI8CsaDjorE6ggyqAZgC0sVv6G0dYk=;
	b=NsU1/xxRZ7ZeU6UkaPp2NhCwrwM9QBFfkljvThw0TmzaR/dtty0TET+FNC7OUKYoJKKP
	 5NME9+foLswPH8OuwFtbMND9hPK8cq8sdURwLJ1t3xWkhhDqWTKtH0aNFBth7Q4/vhmsD
	 q8BLrkploJeVbUG8Ojzvvf2U6J1gudKF4vLKEkLnhi/TgHqWiOZG1T2ROo6ibqlP0ToNj
	 Hbggp3Z9mYutkTS23sSvhokJpvzVjXMMeYCmps62nZdgkwsZ8h8QiaZifBtYzye/iHTVL
	 uWUdFHpj4H/SkFbV8zGmY7GDWdc/XuFGTuPu5aZi2mhsHd3l7DcK4ug29LIcKORJQzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOiu824+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215C606A330
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5215C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOiu824+
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so877840b3a.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:37:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795192667; cv=none;
        d=google.com; s=arc-20260327;
        b=e/xxn1y+OCrwQ5baknx9c/LZNjOWJpIVP6IjzGp1iK+2P83TsOZ+T+7sJZINhCPjNe
         wLarEWrd1j8D7GrO1DVL1rLwb2cYTkVEvx108PrUI2jGybkdcEfQASmkMGZUFGvBlj/f
         /Ore4LHbhdAWlUK+FFCz2K8cFODAXUMvyNhU1UJjZXIcsEePfBzt9kdjocTUrFfVrL++
         xkicYnt+xmIyVqfQrLruy8o/lyFd5UFjMurZdAeb0yg9Ba1XbcNvSVxLsQnQVR5rDLph
         q75SF3tncPGUDYVKUPNsKIZVpdQvamxkWimC5mEQdFJLW3kkuAOQPuR6Ve5OL3FjHhfy
         uB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8gVVdRXDHaBUhqI8CsaDjorE6ggyqAZgC0sVv6G0dYk=;
        fh=Mdboc29plGiEkC0Iw7CpAW0h6PtWoBmrTEgPdGXXwA8=;
        b=mHfkVu25+GE7AA9ZRKalo8CdorH5J4NMLI5w+0VImIrWVK9BdUGSDIFzZGQMvt38Lc
         Ov3Dg3vkXnbcOiEDhXlWvc4u0pq9dc2QR3PE6E11oCE+tE7/rXF4EVguBGC9Vf+UFqKp
         CplWbHSe1BygMBwHFuEDKl7n+IQAxMxNXmEH7TAU6Awn9jnrx9/ULBis7EvhE7oK1OBG
         bC7/j+TJbxkVt9tIpJlCyD7onZaoaPxg99jVrIKL3IjI+N5vuMAvFyMkfXOeJsJPt9PA
         6+urPWe8sRQkiaL+Nk11Xf40R25aVsZZjgVTjqGrIu1sXbFjQ0Jot0vKl86g1dZdXEi0
         +RFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795192667; x=1795797467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8gVVdRXDHaBUhqI8CsaDjorE6ggyqAZgC0sVv6G0dYk=;
        b=ZOiu824+Qzybi4tCeLzrG2HfbR7LqOAvhjxtrLtycpDDlq5EvcJyn4toRCyBscyObG
         2F3FyeyAse5cYOzzflbdnEcBAXNCHUklhH0M3CNUJAJBrGiheGthMtGLB+4AzMK7voLO
         3PNSaKexaTcyBJ9ErwP0nWqVCqJK9Ai9tuRUpEKVZ3UGeYWKQsG/09x3la4TqHdesoHm
         N+BqgDqothmocsIqqDFAcl0OcZpKk9P6XH99DiiPzydVWtUDABK982SCGULWGF/s6B5C
         VPAUJhGNRfpKZg8aLC3X87wtQ7eL1lmIEUl50SFmUp+DbAGAyoKjf/abnBqXwUaKPuZD
         srEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795192667; x=1795797467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gVVdRXDHaBUhqI8CsaDjorE6ggyqAZgC0sVv6G0dYk=;
        b=JmoftHw9fFq2ArQ25rD8LrzKzBbWxpa9wixrXlxBWW6LOqykW20rFjxJBYFGp09Fzf
         FGErrRXy8Q37TlsVMu6NX8AFZ1LNAuGvQ0jd4JRacK0ooZg2LsYnIIf61ByQySc3USgG
         bmrjKYOkYHQMhKVR/KbMYPMUFBp9zdi6Hl+97nt34Rat+gr2rtGLM71oeI67vb/wJLrL
         P3gkwvlYIBTVcY7WTIiq7on1Lc0mSfzi/8ixyiT+WmJ8lOw258lxQy5ppHdo/UePHtlR
         vC5kIRK18eOaFy1lq6aS+zRV5Ei1JIW/4Y4TSFBhBuUvBqi6I45ozvc8c2l7g9A0NLcF
         73vg==
X-Forwarded-Encrypted: i=1; AL+hErGMJq6PD0OGSsrVnGAW3t3xbaAKSoNV9WrK1OJ5mzc0XsnX1l61y4ys4cxO97Kw2sYALYV49Ys=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wBii0hZuz0eUaQBN72QMDy7NprklI4qr+ZFIlxQIcng1KBR6b
	iPWJqc5wl89QQVKLCmnI2T1kux6QiQjDcH3Ga/4dOneauOxAsx+U7QqqMijhyw5zU6AZSEEa4lp
	zkQODac8AiHT+NTVNrP+RMSvy1jXC2t1aBM7y
X-Gm-Gg: AZFdTZc1YCtMYvMCI/+MaiQGFy4FRmTOXxcXu9IXbV9BbtSwdj+vw/Kb52St0JiRkSz
	Ah2Tt7nAEQkTvDz2sGozXJe2f10i2KG2gbsA0aDosywp9G90DCVR3cDNXmuli2ZC8jirJyiGwv0
	7pwqKJ+jQRLronEbUilUXzUUPIA9fCFmmylwMcco8ttm/ZhQ3AdGqZYqnXVaSEW6wv5jwTnfaAx
	h4BOv4QBekfLZZXBh02MWam2ZCeGf/0AWt4T71lzht/PalkwqWIiOBxaEmCdBhIB8xqwkI0sFYB
	KoTSEldaEhS9QNZ2H8QNYtx3uHh3/cnMXjenT5VGZGbT7Oww4hwaOngZ1hrqcFeRP6fbCTsk7nG
	tupKeN2+R8YKCEUtYqrymUGWEtJXqMxFZLA0SfxZ9HXwWPZyBzSACsWo1fxDbUbU16HXpSwS6Ol
	yo9Gh0rDCFTEwGKlNa+vMua3RbWOi+1bbJu5LItg==
X-Received: by 2002:a05:6a00:2987:b0:8b6:3e44:8aaf with SMTP id
 d2e1a72fcca58-8c87b4ee9c0mr3361079b3a.20.1795192666568; Fri, 20 Nov 2026
 08:37:46 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120050108.426545-1-xuehaolin@uniontech.com>
In-Reply-To: <20261120050108.426545-1-xuehaolin@uniontech.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 20 Nov 2026 11:37:34 -0500
X-Gm-Features: Aa3M54qNypMyBmyBYevUfk0cK2R-oXwezfsszARlwdxXW7NeEApwkkiP6N3Sz0g
Message-ID: <CADvbK_fKB1P4c3KkZobQwGc84snyZG-b7NYXi7xPwN04ojcW9g@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix race between sctp_sendmsg free path and peeloff
To: Xue Haolin <xuehaolin@uniontech.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 12:01=E2=80=AFAM Xue Haolin <xuehaolin@uniontech.co=
m> wrote:
>
> From: Haolin Xue <xuehaolin@uniontech.com>
>
> sctp_sendmsg_to_asoc() may release the socket lock while waiting for
> sndbuf space (sctp_wait_for_sndbuf) or connection establishment
> (sctp_wait_for_connect).  During this window, another thread can peel
> off the association to a new socket via getsockopt(SCTP_SOCKOPT_PEELOFF),
> which migrates the association by setting asoc->base.sk to the new
> socket and moving it to the new endpoint's association list.
>
> When the waiting thread resumes, sctp_wait_for_sndbuf() detects the
> migration (sk !=3D asoc->base.sk) and returns -EPIPE.  However,
> sctp_sendmsg() still calls sctp_association_free() on the migrated
> association when err < 0 && err !=3D -ESRCH && new.  This frees an
> association that is now owned by the new socket, leading to a
> use-after-free or double-free.
>
> The connect-wait variant was fixed in commit f14fe6395a8b ("sctp: fix
> race between sctp_wait_for_connect and peeloff") by adding the same
> sk !=3D asoc->base.sk check that sctp_wait_for_sndbuf already has.  This
> patch applies the analogous fix on the caller side: guard the
> sctp_association_free() call with asoc->base.sk =3D=3D sk, and hold an
> extra reference across the guard check so the association memory
> remains valid even if the new socket is closed concurrently.
>
> Note that the sndbuf variant of this window predates the connect
> variant: the unguarded sctp_association_free() in the sendmsg error
> path existed before the sctp_sendmsg_to_asoc() refactor, and the
> sctp_wait_for_sndbuf() sk revalidation check was already present in
> v4.14.  The Fixes tag targets the refactor commit because that is
> where the current code structure (sendmsg calling sendmsg_to_asoc
> which sleeps) was introduced; earlier kernels have the same race in
> a slightly different code layout.
>
> Discovered by manual code inspection, following the public report of
> the SCTP local privilege escalation (Xint "NGINX2Root", 2026-11-18).
> The issue was not triggered here and the fix has not been tested
> against a reproducer; compile-tested only (make M=3Dnet/sctp).
>
> Fixes: f84af33138a8 ("sctp: factor out sctp_sendmsg_to_asoc from sctp_sen=
dmsg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haolin Xue <xuehaolin@uniontech.com>
> ---
>  net/sctp/socket.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index b5a57f61ee6d..0039c54a55d6 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2082,10 +2082,29 @@ static int sctp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t msg_len)
>         /* Update snd_info with the asoc */
>         sctp_sendmsg_update_sinfo(asoc, sinfo, &cmsgs);
>
> -       /* Send msg to the asoc */
> +       /* Send msg to the asoc.
> +        * Hold an extra reference for newly created associations so the
> +        * memory stays alive across the migration check below; see comme=
nt.
> +        */
> +       if (new)
> +               sctp_association_hold(asoc);
>         err =3D sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo=
);
> -       if (err < 0 && err !=3D -ESRCH && new)
> -               sctp_association_free(asoc);
> +       if (err < 0 && err !=3D -ESRCH && new) {
> +               /* sctp_sendmsg_to_asoc() may have released the socket lo=
ck
> +                * while waiting for sndbuf or connect, during which the =
newly
> +                * created association could have been peeled off to anot=
her
> +                * socket.  The hold above keeps the association memory a=
live
> +                * across this check.  If the association was migrated,
> +                * asoc->base.sk no longer matches @sk and the associatio=
n is
> +                * now owned by the new socket; freeing it here would lea=
ve
> +                * the new socket referencing freed memory (use-after-fre=
e /
> +                * double-free).
> +                */
> +               if (asoc->base.sk =3D=3D sk)
> +                       sctp_association_free(asoc);
> +       }
> +       if (new)
> +               sctp_association_put(asoc);
>
>  out_unlock:
>         release_sock(sk);
> --
> 2.43.0
>

I think this is a dup of
https://lore.kernel.org/netdev/20261112172149.27355-1-yves.bieri@theori.io/

Thanks.
