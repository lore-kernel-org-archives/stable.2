Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794858269;
	b=EtlcRqPE5reCTEszFPcbHZ1xP0zxGRSBbNhINj87BU3IEPwIW4vNXq9FqjMPoGlQ99TZ
	 sTnevW9fpo9X/mucF5L0cuh+ZEIzp7TuM6FAAT9a8ZKqEs9AwQ58YeQWvuOJDe0EJKJDD
	 7APppXhDHbwIeXFiYjIXmgSSgiXKpHRAj0H1i1xOJXpHbrU7sPSFfJd0CT8iaPAnEcWen
	 GPmUrQa1G7K0tCveIl7sYCb7eiqyG46RwO8GZZj4ajpSkkTHVA6O+89rp8rBlpGFNEPbL
	 esPrOiFvFJUZHr0xjcAXCOCePEqRs6irw+s0gIEwwhjSToBuVH7wur3KUq92+NVsHiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0GXAZLfuLwKR837KM8+lDytn2Dxn6IUb2Zze7LoZlrA=;
	b=4wa9XFMY25NZrS3DFAKjse3puO7chJ192qEpy7HE/NxMjKnVsS5BOGGDhVu+RBvsFkTQ
	 Fbci5AmCDosVKMh2sod5bnIf55Q5BcIm7LdJHdn4d7J3KYCFRn6I+ZlS5IP1hBLk2HpJO
	 NkhWP3601Sj+PZ3jBxTcSrw+YOvqO6yIZphUfn5k9gLhblDrMG09h7LiUFI1B7HAyEt/a
	 LwTCUfnR8UvusUkY1yTmgm33Ve0/CPyhli8CJPR466qgr16GU3PFj1KYNmrDqqbj198Qd
	 cGCU2GbJBPg5cI54gyKNqXeiXckJkr/bzijbb4Itsg1miiOCLGYovjyHQaNhJhANtLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BB273hOl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D1606A322
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 19:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A4D1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BB273hOl
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1746741a12.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794858268; cv=none;
        d=google.com; s=arc-20260327;
        b=rJtkkbm9fcge/dB4WNPIRkmwXsR0az0Lqhvue7lSInEY3+8K+6Sx1g+JoqXDF8Rw9y
         kBxv8vc6JWkeAMubd9MjkxjxX/N6F7b392LSzvST6aUnZ+P7Kqu6FWT3ZYK7D5cE96Jp
         cbfrbao3XsVYKD9DYKfbIGbO6asHXZPx+sMj7IEaNrs4Cs23jWmzH5InxuDi3tlJsEn/
         EQj4vehbKeMpf9DdpswhLlcJgYih2QN/naj/JXiBnAKSgwsLpX5EsQcHv87KLShPf4tl
         k6H1vlZZBp06DISUAM0AoXQ8NAHmkJuh+xDt6qT4isF91GQDDkG0GDQRuCG25ghVRJAn
         p6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0GXAZLfuLwKR837KM8+lDytn2Dxn6IUb2Zze7LoZlrA=;
        fh=TePKWGgmPo5Ezq306z5zBaeg4D3afpRxwA/s1ueoPME=;
        b=HJbxquee9jZAgIe6VzW+DE9E00b5nlKlBZBdLeqnAUjxAEXOhpnq1iCyeDZ1Sq3GYx
         AwrPWxRGoryuBVmod4ZpfiGGGckQF7liChkAWMfN1FzEhG9eiTMDbM8iehjyQsQa5FKD
         JgFxzcdQKj1QjlZOQrpZyMfgC478Qm1D8U2k0Ev18vUsjztLpvNsbfaB4ZNbS120gmR9
         ff7GjBso8fxh/W9hMGs9QGQGjFeE7llJ/DjELhSAxf4QemiRc/2YoufubE+KeGFp6IXl
         wONd3co9Aq20jfKQhbaKn1hQ7GCaWQnyzq4DB9nUcG/I69zfcy55ZGqKZnDu0pFy/d3Q
         OIJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794858268; x=1795463068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0GXAZLfuLwKR837KM8+lDytn2Dxn6IUb2Zze7LoZlrA=;
        b=BB273hOlp1RHicNqOSt1vyZZx7QGtqLiqUQwym4iCeGlGbQ5Sucmn3aYqnXXfAAaCr
         pZvtAbeGyk6DSrDkYP8/v/Cxb7IAtTfhWbJ/nG8+19tmQLa/QUYN0ms2XUzO9EOwR06p
         3jjf5Whzo9aT1swlNxQJx2BG6riCNowTM2BDcS0OO6PzQCyP8+uQcyUz1kBpXmxYbCOT
         xxF9uJ5+bd75IHiD1qou/Tw9FSDQfCyhT19/r7mJmbXBROb4dTmn+tAkmpLEJG/U9CYv
         Ky2sx9gEwcEhlCROugPhttKTwKUj4xI8DIyjit1a30pVEgN+O6HhBEtzu+O4tq3t0F4Y
         ZXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858268; x=1795463068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GXAZLfuLwKR837KM8+lDytn2Dxn6IUb2Zze7LoZlrA=;
        b=Ly1yhZxy1beli17OAV+S6tAW9AO5vovzGYkPcZ1CBXjMvaIXtT5v36DxDw0/G0ClIa
         j5JZXnigR3tDoHafruThy2cpw04B73bSHvJ9n2m6sBt6oMT5TlNZKFe/9lfAVkBhIm8J
         Y6kmC2DJxgTVFWNOGZPDmWS1x+nkFscQD3sxGLTJno/SMrVH6GkFG425dcov6fXDc4Od
         gzrT+0ObZ/Kz8pFuHoVm5rzl2phJQk2d4eZ9h9NxcsdhkXXI5FWb2Q0+TsIuqXcAKyha
         KdylFG+DMoX2jVeogt4gnMkvGL6PksP0YPUVKqYIUgSW9AKGV8q2TiCLD3fjfve92BKM
         a26Q==
X-Forwarded-Encrypted: i=1; AL+hErEYPiwEmC38wQjvj60GbuVYN4AeWShHxzYMmSoLuKx5Xo0LI0bXj2xbdDXG0e18Ad4uNjnXZNE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tmH+BjPsQNbrzm/2wzhYG0mjDSjAqzTvLV/kMWgHLkWuozn6P
	fi1bz387S4XHJCD7iwYC70XxP0rsKwzbtD4gWj0r5dZW+fRFGWhB1fp0Ljl+URMQlJT2JILUvZ7
	00L1w+hP4H7DjYmxpRbBTqeNyJDKqmBELcgkE3TtG
X-Gm-Gg: AZFdTZfoIq0XHpfwxxJaKpXF0/w8xltMfvf8Qq7G1Tg4hPPhjXNY0xOGEWoaZ3qUUKu
	Y+7uS4PU2y1o7EJr9Xpw7jVshmyrNDJRzNnBNok6I11wLKrABCxmtZIXAPG7muEgXz57uFZPNHn
	FmfptW0CXik0sAN7arMQfnVe5v87x05MfbxwspOToAAIYUqBSX4EQQPijF3tn0H3fSHl5FSvnlO
	RTscOb4qqF6D+OLoqGmFNvFngDk7nRHtiS9XVkG9vbXROpkM0ihBmML04C/vMvmA36+DiOAgUfA
	6JeVC1wCCiC4N+GiMErIaX2l7ahHc6wMmKN8os2EYo0z7tcpP/MtoWegn8Lq+dB3eGOtEMLzUar
	XCKHcVjPYOzWBt0d3egOO3B77A447/pJPjEdHEOTPRji9d0hWS7XyZBPWwvYp789DrPDq
X-Received: by 2002:a17:90b:28cf:b0:3ac:8dfe:8ec9 with SMTP id
 98e67ed59e1d1-3b1b0b47416mr9502656a91.47.1794858267644; Mon, 16 Nov 2026
 11:44:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031211258.1626829-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <b446cedf8a7977337389f8cdc1e5acce@paul-moore.com> <341401a3fa5863542319566051bde1ea@oss.cyber.gouv.fr>
In-Reply-To: <341401a3fa5863542319566051bde1ea@oss.cyber.gouv.fr>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Nov 2026 14:44:15 -0500
X-Gm-Features: AclHuK9Yi3vY1OnQknBBHtyXXbTvT6zYozVYLT34YTLRhSFwwbQtKY8uTdDr2v0
Message-ID: <CAHC9VhQECaSwpjUgSoCgZAgEphEk2jKnZFESn4ivM6JAjrC7HQ@mail.gmail.com>
Subject: Re: [PATCH] audit: fix UAF in kauditd_send_queue()
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Cc: Bradley Morgan <brads@mainlining.org>, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:44=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<jeremy.jean@oss.cyber.gouv.fr> wrote:
> On 2026-11-04 21:36, Paul Moore wrote:
> > On Oct 31, 2026 Bradley Morgan <brads@mainlining.org> wrote:
> >>
> >> kauditd_send_queue() grabs an extra reference to the skb header before
> >> netlink_unicast() since it may need to retry a failed send. If unicast
> >> delivery reuses that same header, the receive path stores the
> >> destination socket in skb->sk without taking a socket reference.
> >> Consequently, after the receiver consumes the skb and closes the
> >> socket, the extra reference taken on the skb header makes kauditd
> >> release a header whose skb->sk points to freed socket storage.
> >>
> >> KASAN reports a UAF as:
> >>
> >>   BUG: KASAN: slab-use-after-free in sock_rfree+0x44/0x140
> >>   Write of size 4 at addr ffff888004f94140 by task kauditd/31
> >>
> >> Clone the header before netlink_unicast(), then use the clone for
> >> delivery and keep the original skb only for retries. If cloning fails,
> >> handle it as -EAGAIN so the send can be retried.
> >>
> >> Fixes: f3d357b09295 ("Audit: save audit_backlog_limit audit messages
> >> in case auditd comes back")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> >> ---
> >>  kernel/audit.c | 11 +++++++----
> >>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/audit.c b/kernel/audit.c
> >> index 9412af9144bc..5e739fa606be 100644
> >> --- a/kernel/audit.c
> >> +++ b/kernel/audit.c
> >> @@ -790,6 +790,7 @@ static int kauditd_send_queue(struct sock *sk, u32
> >> portid,
> >>  {
> >>      int rc =3D 0;
> >>      struct sk_buff *skb =3D NULL;
> >> +    struct sk_buff *skb_to_send;
> >>      struct sk_buff *skb_tail;
> >>      unsigned int failed =3D 0;
> >>
> >> @@ -810,9 +811,11 @@ static int kauditd_send_queue(struct sock *sk,
> >> u32 portid,
> >>              }
> >>
> >>  retry:
> >> -            /* grab an extra skb reference in case of error */
> >> -            skb_get(skb);
> >> -            rc =3D netlink_unicast(sk, skb, portid, 0);
> >> +            /* Keep the original header unowned for retries. */
> >> +            skb_to_send =3D skb_clone(skb, GFP_KERNEL);
> >
> > As Bradley pointed out, this appears a little confusing as the existing
> > approach of skb_get()+netlink_unicast() should end up doing something
> > very similar to what you are proposing due to netlink_unicast() calling
> > into netlink_trim() which in this case should always end up doing a
> > skb_clone().  I'm sure I'm missing something, can you help me
> > understand
> > why this proposed patch is different and solves the problem?
> >
> > Also, do you have a reproducer for this?
>
> Dear Bradley and Paul,
>
> Thanks for the comments. The fix is closely related to the current
> code but the main difference is that netlink_trim() does not always
> reach its skb_shared() clone path. Moving the clone earlier in the
> execution avoids the UAF.

Thanks for the detail.  With that in mind, I think doing our own
clone() is okay, but the ternary operator for error handling is a
little uglier than I would like in this case.  Removing that, tweaking
some variable names and comments, how about something like this:

  /* clone the skb for retries in case of error */
  skb_clone =3D skb_clone(...);
  if (skb_clone)
    rc =3D netlink_unicast(...);
  else
    rc =3D -EAGAIN;
  if (rc < 0) {
    ...
  } else {
    /* consume the clone and continue */
    consume_skb(skb_clone);
    failed =3D 0;
  }

--=20
paul-moore.com
