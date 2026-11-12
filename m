Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498981;
	b=p8F/S/jtXVPcV4oHPbpBIZ7aFl3+9duu2g614MD3aEl/6nWrRxGH0Hfu/OYJrJrnqqSK
	 UXDUjctNypvM5pIVRtz++qTQyXE6TcRMNWfLL5ite0yh4N9jqwNAc83XK/7hhkVSrQZhX
	 uxFofxCg9aBJe6vgWFgBklqQ4sRSW6rNPs7D9ChPRIoeqX0KhRy2lOpLhrhGjA1dMpS63
	 OJIK4PedfUTDmx/dNocKJ85LhdGS1lYR5LkEW2WJdng/IEfDPCNVV8A3t4Kj49aDDj+Oz
	 kWWfAnfrMmRtVrZ0DVmyufLzkFq4ojXEVZqFJMjrKEa+BTDFU4u45JzTc4Pati5lGLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Q6vCcmO9UnueyWU0efgozjB5WIAOqxMCCYGcp8pVZSk=;
	b=Qo6xIxgn35X+GeLZtjLZPWE9YXRqGI94ZWjzAxXjmrAjmlwPBz76ezftTZYyf7cMGcyN
	 AeubFEsev70oqr0ly1FX5xE8Ft3scNvvo07sSPYjSQIMt9PUrPsN0+bpfgSwxExr7d0zM
	 mxehMOcyoaXuQZokS30SSgs+f+p+hDtKS3B3lEF8098iSdfTJb12xa5ASziStJkAVy/aH
	 Cpfl9jlpksmb75NUpu2sjyykXEbZl36tkOV2Nz4Nd6MhNtrW4Bpy+bQf1wlJBDgUR6sPA
	 OH4yI8NTv3UNMLKIk2v35icSBbMLtCH7sJNza+p8w4ppEQB0o19YhVEIT6eLW+Snklw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMMQwfxn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A72606A334
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A72606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMMQwfxn
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so1020041b3a.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794498979; cv=none;
        d=google.com; s=arc-20260327;
        b=WgVQwGlpcDaZ/17dSAXNeSbFnjv2GQkumJdwoDzU5eh2VMMvHGqXxJCEGmFblj0nuR
         1hmTlk2oWvl9pIKWEB8DN08bo0XtzdQ8jXISDehvTqJPewOvGe+t9enNRy1VtHh7rEYu
         cqK31GxXo5XN+s35AJQ2L8tPLlLfCz2DVo0NhPte32mY1UqLuLwLD9G1fRuVWrjBmcfm
         etRMKX7zBPoufGgkC9FHumg1ISTSRHS73Qoh47n98g9yFImGtqiQH8HloVB4emXzx0AC
         PLdmD4GbBJnwHICmlClT/bWovB+XjI7ypi3i0U2Lb5o+Uz6NTRfhZxM0xRmvAjw3kNE5
         gblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q6vCcmO9UnueyWU0efgozjB5WIAOqxMCCYGcp8pVZSk=;
        fh=7lWQtcs6QEvu1eqRY5JP8cEhGfRTR5bamWLxvi7zInU=;
        b=bxYW8qcMQBXuXy0xVYncidtp8ZnY6xyGfh/Fq69j3FqCzW4UjAQw6JI1ZBRWftyDfD
         Wu1Aqpf5P8gKlaGFQWtoFLb6bfwgng+X7obpE+c89WOIGuQU6jt50nkhkIOPyXOM7+FQ
         SnvVpTViWB9AmO/jC8717kBQ42Kn2UFgeJ5on4MDZhUkwm28wDrArRFi1aWsp4+g6hHF
         hDX8ba3mTXHVwU69qbQ9i8D0GJY1nePoIziFh8V+yGJsQWPef/TxVUsYmpKXpBoaUJ/P
         oqOZ23sOEC0yWbicZwUdtyQ/99QyNehWmoRoxWOj5N3mrOpYqbwOg5uvQ1SnCGeY6AaZ
         Vngg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498979; x=1795103779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q6vCcmO9UnueyWU0efgozjB5WIAOqxMCCYGcp8pVZSk=;
        b=FMMQwfxnGhQl73SmXTmz3Uz/fR5DEkmGqGslOlDNHRgRQuERn1ilxuNemrRhzkBGqJ
         TC/nbvr3M/UlfSDu0l0pmWhaGHUZQekv6rpZTy/rK6iz00ZHta13GKrHNvKh5xfPuT5g
         I838dUJLIEB3vfrekuxhJlBI1FAwzgFDwVDPJ2h5ZKy4tpyqQv4/yAHUkstGe39jCV+H
         hIZKrD8EB+m1u4yeOLlXftBg2cduPxnDRmRczR9bKcrC8XSO++rYLTPEaF6he/OOqXBJ
         PudvFY1qdb4BbH/1pp3C/xdGCdyusJ5RrMhGcpEQ8k+UxMN+2bJLYbHbn1Nz3ew5b/e0
         8qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498979; x=1795103779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6vCcmO9UnueyWU0efgozjB5WIAOqxMCCYGcp8pVZSk=;
        b=yUDCC5/3+pwcmZSiyp7nDtNQTr6us3nn2cOHTTj10egWayhM1yhNZ3qUWS65lKx4i1
         kljHnFp8Rlyzxp0+vdnUh/v0HmQoY9oKzZlOgHDKM4/yDbAytzfHcwnkEPUWzIbNPgtq
         U8JiKdVZPyr5cSW23a4fA/WrFsdSpSKePwvFPFe2fCdwkHKLa4T2nu3AEEZAQDhuF9rE
         qhTc2g3ducDp+8/USwHWqE1EmeMGjTk7IbPagSbg0uD2qXFqj/gi6HwCdj90xBdK9Zdq
         FWD7cZftFY0RSa2n+/w/JLQvGnAYunVt4hmaAuHN2lmfoyJRuG9gPidWcRWiaSK28SLX
         gwVw==
X-Forwarded-Encrypted: i=1; AL+hErFu4nsir/wnZwcjTysz3RitlE2Kg1WXrG0yN3mDA/FR40839+W607OTzbu3Td/tBUn3YMRTREQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xhkcZg6+smfoxrz+MzHpFzWNZrbhnURsPuub3q7t7LgxjSX9I
	/6LrDToXbQoZUk+ENuv4LrSAipDdXoUz+884D4YgJeG8XBjM39UPb4T9N/Ua3cJ5whsdJLibRIe
	cAkcQ9YoSmHequchRMat0LfLQuLuZ5rY=
X-Gm-Gg: AYBFou0RLBytUxBqQaa+qPHZH1Kfa4wMWR2T5ypkI4mVshiWYhrXnrvaav3rQvRRyyl
	vFUNp+GFIUwGeioQLIoWXVu+yFsN3pZtztEEFmK+alNHzVu1kiO/Ywvi5QmltX86gRfwc7NcaCt
	MzwqYDDjQN8Mvxvs2gcKaX9Jtb9WRjDAki9v8qqYl2JM5EUkdcc3AibRkEz+pj8iyipQY7i693f
	0QrnUmhNOQ+dINtedH6VL3L4fU1ozUM67e48EXRPCWAPoXuGty1/a7/6tyDtVomhXbkKhH+RjBX
	ZMbC14THL0AWph+wkhqJWXgIF5mUoPu1EP8fjXOVfq7TbhQZSOttFXGPvHfugG2RN/rXjnsS8rY
	ieGMOdJbdkMoYRWl7uIgVmgeoepjNarYqG3db2iZ7FzQbet5wVDXpb8GXLj/KhDqa6J9I77vWwi
	yC+9DNv8lS9SR+twE+pydzfSnvmQsyOZYjFj5jLw==
X-Received: by 2002:a05:6a00:13a9:b0:8a5:7006:1ecf with SMTP id
 d2e1a72fcca58-8bc1ca74f3dmr6405399b3a.39.1794498979018; Thu, 12 Nov 2026
 07:56:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110224233.82977-1-yves.bieri@theori.io>
In-Reply-To: <20261110224233.82977-1-yves.bieri@theori.io>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 12 Nov 2026 10:56:07 -0500
X-Gm-Features: AclHuK-WWnb_Avs24C603cZWJLj9kdWOrIpfiyA-Mg7U4Ik96B8IwVtXOHQS-lI
Message-ID: <CADvbK_edbUYvFXPGJzRspdG+RpV4ZnfP_WwuS4e4_sS2kbDAZw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: do not free a new asoc peeled off while sendmsg slept
To: Yves Bieri <yves.bieri@theori.io>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 5:42=E2=80=AFPM Yves Bieri <yves.bieri@theori.io> w=
rote:
>
> When sctp_sendmsg() creates a new association and sending on it fails
> with anything but -ESRCH, it frees the association. The send can
> sleep in sctp_wait_for_sndbuf(), which releases the socket lock, and
> meanwhile another thread can peel the new association off to a new
> socket. The wait then returns -EPIPE, and sctp_sendmsg() frees an
> association that now belongs to the peeled-off socket, without holding
> that socket's lock.
>
> If the peeled-off socket frees the association first, e.g. on close(),
> sctp_sendmsg() frees it a second time. Otherwise a syscall running
> concurrently on the peeled-off socket can use it after sctp_sendmsg()
> freed it. Both are reachable by an unprivileged user. The double free
> on net with KASAN:
>
>   BUG: KASAN: double-free in sctp_tsnmap_free+0x5c/0x80
>    sctp_association_free+0x1eb/0x750
>    sctp_sendmsg+0x15ff/0x2020
>   Freed by task 836:
>    sctp_association_free+0x1eb/0x750
>    sctp_primitive_ABORT+0x85/0xe0
>    sctp_close+0x22a/0x8d0
>
> Commit dfcb9f4f99f1 ("sctp: deny peeloff operation on asocs with threads
> sleeping on it") fixed this double free by denying the peeloff.
> Commit cea0cc80a677 ("sctp: use the right sk after waking up from
> wait_buf sleep") replaced that check, and commit a0ff660058b8 ("sctp:
> return error if the asoc has been peeled off in sctp_wait_for_sndbuf")
> reverted it to return -EPIPE, without restoring the check.
>
> Fix this by holding a reference on the new association while sending
> on it, and by freeing it on error only if this socket still owns it.
> asoc->base.sk only changes in sctp_sock_migrate(), which runs with this
> socket locked, so the ownership check is stable. The reference keeps
> the check safe if the new owner frees the association meanwhile.
> Userspace still gets -EPIPE, and the association stays with the socket
> it was peeled off to.
>
> This was found by Xint Code, an AI code review agent, and reproduced as
> an unprivileged user on net with KASAN (trace above), without modifying
> the kernel or using error injection. With this patch the sender gets
> -EPIPE and the association keeps working on the peeled-off socket.
> Without a peeloff, a failed send that created the association (EAGAIN,
> EINTR) still frees it, and a peer ABORT while the sender sleeps still
> frees it exactly once. The SCTP selftest sctp_vrf.sh passes. The
> reproducer is available on request.
>
> Fixes: a0ff660058b8 ("sctp: return error if the asoc has been peeled off =
in sctp_wait_for_sndbuf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yves Bieri <yves.bieri@theori.io>
> ---
> Tested on net at b71c101bbb98.
>
> The fix and this message were drafted with Claude, and reviewed and
> tested by me.
>
>  net/sctp/socket.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index b5a57f6..e7e14a0 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2082,10 +2082,20 @@ static int sctp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t msg_len)
>         /* Update snd_info with the asoc */
>         sctp_sendmsg_update_sinfo(asoc, sinfo, &cmsgs);
>
> +       /* sctp_sendmsg_to_asoc() may release the socket lock while waiti=
ng,
> +        * and a new asoc can be peeled off to another socket meanwhile. =
 Hold
> +        * it, and free it on error only if it is still owned by sk.
> +        */
> +       if (new)
> +               sctp_association_hold(asoc);
> +
It doesn't look nice to add another 'if (new)' check. Can you move
this 'sctp_association_hold(asoc);' to after new =3D true; line?

Thanks.


>         /* Send msg to the asoc */
>         err =3D sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo=
);
> -       if (err < 0 && err !=3D -ESRCH && new)
> -               sctp_association_free(asoc);
> +       if (new) {
> +               if (err < 0 && err !=3D -ESRCH && asoc->base.sk =3D=3D sk=
)
> +                       sctp_association_free(asoc);
> +               sctp_association_put(asoc);
> +       }
>
>  out_unlock:
>         release_sock(sk);
>
> base-commit: b71c101bbb9814d163c00234d43c41f0a17907d4
> --
> 2.43.0
