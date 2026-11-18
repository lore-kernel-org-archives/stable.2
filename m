Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039876;
	b=x7G81c7Pv4M0nW6PZ153uDApXNpyp7QS64KxuN0as4+J5sfuHJOSfuPV5wWRd5mD9SAK
	 XmU3i8Txs7uAaPcEgUMUxNjsGCfoCBN/JOUMX1O+X+uFTXtW04sr8QRXWWmethZZP43XH
	 A9oJoz7aO1NScxMwovKqK6XF9kL76jH4ApJVP9dsPoMtckY7aaXhQRHtGex3RmHiSFYay
	 46agyatW+y0ZGblRU0+MaTfnUlluExIBxESph9bW/9TQ6aUdfOJZt/lPphSXeXa93zIp4
	 GhJp+G+1eJ9mjagcjyau4Peadqw3XwFMnmuOJRX/kpjgyEgiLvZxLzt+7HWFzp3Q2hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=bzjwCVP4SEToK/imQer4KQFKqGoTb9aCYir+nCxEg2E=;
	b=YYM2DAdYNEqmcY0q8DncWD+ieBxfTCPRimqX8Y+1fR/nDND+GR5ck7hdshF1ars+57EP
	 cISOeD3XzfGTe9MudK1W1wzkBNO46mijLb4wgS6FQxi87HKHDQDzg5RIeGgx9Xu9fgHpb
	 eV6yqzsW+NHehmlcCS8pfUVqqJzVumEfS7La9DZubxULi3v6CKt6Xq990/p2fa3eDDOsI
	 grJsqLzmcZs9lSC4C6xv09uHdZfTLinFJR4km5+gusGZCkTtkPj9aef8dkBPsEoUVM9MV
	 GaNaxsbuP21CgmNPr/z2FOZ9O4xAA+ASSIVJlngsuswOvIcoFqlVupwnXgDb9IC/V/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=knHv8aSH;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B1606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 127B1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=knHv8aSH
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so22500805e9.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795039873; x=1795644673; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bzjwCVP4SEToK/imQer4KQFKqGoTb9aCYir+nCxEg2E=;
        b=knHv8aSHZiR2i4XpbS6MAICu4cmODaAXFCmN5MSZDot+rw1cN2qYVjs5fHk1cLAW+r
         9m917eTgv4PP+f249uvlsFkUBYO/ksXafejTCE+2sUzt0ALpnv352ZmmSfmhJzqyrxcA
         PlPmP0m5sC/KO8KAJEEitDrejpfyAyOjd3UvzG1h46iThaRB/bt8j6cdWOLNDBufHxFO
         Z0nLfq/ZgqwsbOF8p8hgOswfaXPR5mbecyV26Es81YLEcJmv7xk7mho83zsMa+PL1mxO
         JM3ot2joemn0JzIxAb+Cbos2aokVUYm6EWHLJWiFA3Yc/iv3C4RQywvUb8GKYUh3PPb4
         /JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795039873; x=1795644673;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bzjwCVP4SEToK/imQer4KQFKqGoTb9aCYir+nCxEg2E=;
        b=ZDrpwB+DIMFWiyXq3AqPMuPdnNuzmL3FFqub3Ix1e4MJwvP1XyT+wHrqRYu3oshnhz
         +o0U5mzKtfySI75z4bgAW+NPCXa4c15M27JInDoGscOdm89CPLUDdXQmZUaivt9ukV/D
         3ktP8w7DEVjFPmVLMecXcpR56sCh1fryknN2sMByP11iShHjgQ6T2m5VRbum9e5Mjs+N
         jhZpfBHtbXLW1/qHpDOVbguVuIaU0c2ONit+6zoUfas81r2YzCLVrq38uep4nWbPtTQ3
         sqquzgOfpZ/PYfOCIJgtzwVO6Hf0V9PzxI5KWHD+QtUH41KDiDYuYxaAjuCoeyAEDsWG
         N0Ag==
X-Forwarded-Encrypted: i=1; AL+hErGpkSJMMASIOx/96UDJoFFgjYydJwFTHWlCqMILiU/QV4GvzmzisxoKlGNqCmmGZbsqKFIP2NA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jry55OtqirJ9b4izDzqsVRTTC9xSPBzzfW+YB8edgPVtpUItU
	aa+yHqZlvNgNZccUc/O1W3GUgD6Lu1op1cP7oAGjt3rf2ci/NOE16ydQ
X-Gm-Gg: AYBFou1xM8Io2rq4fOqMcLm3BrQQjt7VIlTIvNjKtQGtfY0x2brC6e1qV6YnvvBlXNP
	rvAe0HbFyUpH78Upo5A5itmcGjBhp2UbDwgb6Pvrse04iGTCKHOY8DWBk4t6aB9CWL41Dzr0MhG
	OrPUHtxPIcDy//bcvsG7rj7rSZEGXIBnTDYPMzZKM+iI6w7So+MN5yBIUe8Ndq5HCfx49nRXgoU
	eBoeszC4zjQpxuGspQPjBhQDSntSO0ZzUuuJHGjdLdPjzQfeZnXzG1nAvtiA+DU4fiERHwXL2Wg
	N+TNWJRykFd+Kq5wQKOTZZxOr8PxC3ZUWd5wqn7FacMb+kn9izdB/DwrJEJk1LaulB7jRo6p7BA
	Lccd6CI6BVPHs6b2nesyUb/SlHFKVRM65ONlwNW+k0VqYpFcAXtUuDZNd12ElmAkuk3dqI77CGU
	21arrA9CR3uNmzGkqadijf8Z0POv9ivuAeQbf1mEjHHEuYFXwHyGoDV+FP0FNyD5UsR8HSqkJCQ
	T7z5JPDC8ePhT7FACBRMwfHzt1lbFAN7dKtWUrRAvA2wGs36VaNUSw+Zn8PfXd3M47Qv7b6AlJw
	3v+RJvUF7gh3LRlmd9l029Ru13LURYuLqxK0KB6Pdk8Jejhvcm5xyZxWQqQ3tSbBBFecYtWyVrV
	0FKVleHLI
X-Received: by 2002:a05:600c:a55:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4bb7da2bd37mr75678035e9.30.1795039873293;
        Wed, 18 Nov 2026 14:11:13 -0800 (PST)
Received: from archbook.localnet (46-126-188-148.dynamic.hispeed.ch. [46.126.188.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65499752asm6720364f8f.11.2026.11.18.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 14:11:12 -0800 (PST)
From: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yves Bieri <yves.bieri@theori.io>,
 stable@vger.kernel.org, Yves Bieri <yves.bieri@theori.io>
Subject:
 Re: [PATCH net] sctp: do not free a new asoc peeled off while sendmsg slept
Date: Wed, 18 Nov 2026 23:11:11 +0100
Message-ID: <GldWrQHQT5-PC10gNmItEg@gmail.com>
In-Reply-To: <20261110224233.82977-1-yves.bieri@theori.io>
References: <20261110224233.82977-1-yves.bieri@theori.io>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Dienstag, 10. November 2026 23:42:33 Mitteleurop=C3=A4ische Normalzeit Y=
ves Bieri wrote:
> When sctp_sendmsg() creates a new association and sending on it fails
> with anything but -ESRCH, it frees the association. The send can
> sleep in sctp_wait_for_sndbuf(), which releases the socket lock, and
> meanwhile another thread can peel the new association off to a new
> socket. The wait then returns -EPIPE, and sctp_sendmsg() frees an
> association that now belongs to the peeled-off socket, without holding
> that socket's lock.
>=20
> If the peeled-off socket frees the association first, e.g. on close(),
> sctp_sendmsg() frees it a second time. Otherwise a syscall running
> concurrently on the peeled-off socket can use it after sctp_sendmsg()
> freed it. Both are reachable by an unprivileged user. The double free
> on net with KASAN:
>=20
>   BUG: KASAN: double-free in sctp_tsnmap_free+0x5c/0x80
>    sctp_association_free+0x1eb/0x750
>    sctp_sendmsg+0x15ff/0x2020
>   Freed by task 836:
>    sctp_association_free+0x1eb/0x750
>    sctp_primitive_ABORT+0x85/0xe0
>    sctp_close+0x22a/0x8d0
>=20
> Commit dfcb9f4f99f1 ("sctp: deny peeloff operation on asocs with threads
> sleeping on it") fixed this double free by denying the peeloff.
> Commit cea0cc80a677 ("sctp: use the right sk after waking up from
> wait_buf sleep") replaced that check, and commit a0ff660058b8 ("sctp:
> return error if the asoc has been peeled off in sctp_wait_for_sndbuf")
> reverted it to return -EPIPE, without restoring the check.
>=20
> Fix this by holding a reference on the new association while sending
> on it, and by freeing it on error only if this socket still owns it.
> asoc->base.sk only changes in sctp_sock_migrate(), which runs with this
> socket locked, so the ownership check is stable. The reference keeps
> the check safe if the new owner frees the association meanwhile.
> Userspace still gets -EPIPE, and the association stays with the socket
> it was peeled off to.
>=20
> This was found by Xint Code, an AI code review agent, and reproduced as
> an unprivileged user on net with KASAN (trace above), without modifying
> the kernel or using error injection. With this patch the sender gets
> -EPIPE and the association keeps working on the peeled-off socket.
> Without a peeloff, a failed send that created the association (EAGAIN,
> EINTR) still frees it, and a peer ABORT while the sender sleeps still
> frees it exactly once. The SCTP selftest sctp_vrf.sh passes. The
> reproducer is available on request.
>=20
> Fixes: a0ff660058b8 ("sctp: return error if the asoc has been peeled off =
in sctp_wait_for_sndbuf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yves Bieri <yves.bieri@theori.io>
> ---
> Tested on net at b71c101bbb98.
>=20
> The fix and this message were drafted with Claude, and reviewed and
> tested by me.

So instead of sending a v2 after the review comment on the 12th, you
went on a publicity tour that easily identifies this patch[1]? Nice
going. You even left in the same task number as in your redacted
backtrace on your blog post.

[1]: https://xint.io/blog/nginx2root-remote-code-execution#6-analysis-of-th=
e-linux-kernel-lpe-vulnerability-22

>=20
>  net/sctp/socket.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index b5a57f6..e7e14a0 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2082,10 +2082,20 @@ static int sctp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t msg_len)
>  	/* Update snd_info with the asoc */
>  	sctp_sendmsg_update_sinfo(asoc, sinfo, &cmsgs);
> =20
> +	/* sctp_sendmsg_to_asoc() may release the socket lock while waiting,
> +	 * and a new asoc can be peeled off to another socket meanwhile.  Hold
> +	 * it, and free it on error only if it is still owned by sk.
> +	 */
> +	if (new)
> +		sctp_association_hold(asoc);
> +
>  	/* Send msg to the asoc */
>  	err =3D sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo);
> -	if (err < 0 && err !=3D -ESRCH && new)
> -		sctp_association_free(asoc);
> +	if (new) {
> +		if (err < 0 && err !=3D -ESRCH && asoc->base.sk =3D=3D sk)
> +			sctp_association_free(asoc);
> +		sctp_association_put(asoc);
> +	}
> =20
>  out_unlock:
>  	release_sock(sk);
>=20
> base-commit: b71c101bbb9814d163c00234d43c41f0a17907d4
>=20




