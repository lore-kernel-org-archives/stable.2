Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE79360EC3
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782675109; cv=pass; b=QsRQBBsy0Em04SdGiFLSQYo0NLOLGMnHIB4lTjuXLLKm+FnlmbaDK0yaZZs8Gb773h+bDG1vcSUVIDra7atDJGfbgDJJ0W+k/Tjyr6qLZZtPGq0jAHBkD12alwQbF8Rp0mObc6T6R2G2ImyTGXWreWtqu6KW3zlYgrZuIt+gAJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782675109; c=relaxed/simple;
	bh=5Vec2FPq80QSVjNuVZcUNBJEYpCworgmUqJXo2E7kAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppiDGzctMmlxmUEfXF/jtUR78ZlrRMBOOmZclXCfoOTNAtqBKKTVz9VstQO2sZFmX3WeN9RLKMeVYPcS8KPDbylojjNHLnhXqAKMbGXzU2UOLiqOtaTqwHPI4Dfa+jjSd4CfvgCz1/UxCq0DA1QrLLnGTw2cfwPhF3WantKCxOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLe42wNy; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLe42wNy"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8894387780so1075104a12.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 12:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782675106; cv=none;
        d=google.com; s=arc-20260327;
        b=SQB1PN5Bh4Jh9q0nmgXc0ppnl/8kvpT0vDwD4lgaI/2RJrvumCMfPDF+sMAijWj6+S
         wbUYvnqNqw7m8V07pWWdCsnkQuM/YEpDLGgdTC+gPEEsazE1h04vGA4LG1f6TjZrQAod
         ceyxiM+qTQmaC2AtKIHt8aqKjoR22vJCw0oQaSwVBeJkHTQ05orP3Zo206ilEc0DNFjY
         sNkVOUvOaU4Pj4xmNHfuxBmb1NixpCa+5jSshCiADkeB4NQtS9MyAmtEnuHFKNGBf51v
         pdRxPDL//2SLU+rDdldv1gm5HqnUk95CDS4gjZqME4L3L1Rlpez6k7OuDXZV7Rq3gpqG
         738A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/2uOhKbsok01PruXCBbCuSwW7+oTM1bpDKgD31wiKSE=;
        fh=dljNS2ooK6fYvh9vxurHKUMg+Tx+AOHz+/1AkKhkEKc=;
        b=EnklEP8RlPVZA/IAoIWfBuhiKyLEQ4HNNUMzlfYBBrPnqPIeoqbRx8tIfwABW5xRSP
         sllDzid/WjGEdosnFryXboeaUpjAOVAFAIv8ukybD1w5AWNLDJb6OHzWgNEsQhHstrGw
         ACh3wJCqh7FiloLAJVsUvrn7bhaFrfHJWLHvZe0v2amzkosR8VEVTS1elV3fdQa+jsHP
         6OveKMr0TC4T/EeGlrCs1AtcLJ7z8LBpFNx9cC2bc+QqmZgAHm/sFNLWB58oIe22XRII
         R2wK1l5bfSHH+zs0X/nAz4t4m9AR+ZXGTiQuYhiqImcppehZnyR1Yc1ZYYzmvLdsz0+8
         aUSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782675106; x=1783279906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2uOhKbsok01PruXCBbCuSwW7+oTM1bpDKgD31wiKSE=;
        b=kLe42wNypXzksIeUMuS1Wujq+xe9MDeF2gnTyFNJC9/wk6nXnRygn9526eCQmTbvcY
         RgQ2oggF2WNKnqRO90miefcvdUi7qyPicLOzf4YlkXI0W6g8p4ZpcsRSZPxHM8bmocOD
         hsQF1tWk04RdO5NFqALpk0z9uGYG0Lc7N8vd+/UGvJ9WojSRNIb5Y7UXP6xSfTiwiaJl
         pUdRUKKE2kWosIcJ332e3Wtqou4fFjsTNNK+J+qrtx+HDBHGwgQYQvkWJ5MKR9qNm0SS
         nxvCp8a96BmnUiCRXBMbOY/rcD1wWfo7tMzdqtLA7ouwp0WlZsWUr+JPD7zMdUywIEHD
         Zmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782675106; x=1783279906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2uOhKbsok01PruXCBbCuSwW7+oTM1bpDKgD31wiKSE=;
        b=KgrlHksmkgO5HLS0jH4Pdq+VhFrM13TInIPHTd2vmN5IDiZrlNgXqhGY/yAaIg4w3H
         jqVvjwA+IzdZT3y/1YqvasuGgq908SI6uNhHMV7fAdugcw6kJ7ydJBvIB3Cp7qK8AIkK
         TAJINZUdvM4zj8C+sT/LeTeFptR2Zq4ibHzamScUdtUEIKztgzTHuZNbb5E5R/yfgXxN
         cTrAiEaZ54t70dLvQlnYxo98/q8czd2fwECLpnJ62WSyuJTe750ISnvgtec1KceaXeyr
         uUFa0Ye6HmuPQgCFu4DpjJi9456e5WgmKkWINcjD9JK9LKGDGGp8lLqglzttFeHZVulO
         5vCQ==
X-Gm-Message-State: AOJu0YwoAD3qCTZbwcwE8N40FBHEStf1foh0dQTLjqkZ5Q3FV8GWiA6R
	D6vshpKJykv8M1be3piJHOGIo7WFAWfoAAqpT4d9U+HjF5ywV599z7X4aYral83KnwNbkNpjbdZ
	khtDdxkPx5mCC4bHi7e20I8EAxT4M5NU=
X-Gm-Gg: AfdE7cnfwHU4CWfhzN3OmA29+ZgWttg1um2qhVWh5JEfYLkcB1kVIO5rtxRYNgPszdL
	54RT4dQc1xJtBv40cagAeO02QtGHFPONZc6hGmiI/i2s9bABZ7o8OE6kg8+gHmXbyiTIpqupsjF
	m7XK7k+lQzPTG1QgnSgMr2o3cIm7HL3WTvm9XBCP+JXDA9XdLoaVb3dVKZohkTZXoavszFNF68S
	20Y/Hht1Z25ukcZN238drRMi7xq7/g2O0phuqmwm0uqy+xpGUG4aVDsyrr2XJQUah6LI7+x
X-Received: by 2002:a05:6a20:4320:b0:39b:a997:9e40 with SMTP id
 adf61e73a8af0-3bd4af421f5mr14041563637.46.1782675106346; Sun, 28 Jun 2026
 12:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org> <20260528194657.359703301@linuxfoundation.org>
In-Reply-To: <20260528194657.359703301@linuxfoundation.org>
From: maher azz <maherazz04@gmail.com>
Date: Sun, 28 Jun 2026 20:31:35 +0100
X-Gm-Features: AVVi8CcYcqhNF7J4MoyzTB4keq832TrF17vVni4XBUZFmL3tagoZp2lKbZlnrlM
Message-ID: <CAFQ-Uc-wu8fbTDXhtyODCz36_1DBue5ay7V2LpzjrUgHs+0WvQ@mail.gmail.com>
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Is there a CVE assigned to this issue already? Thank you for patching it.


On Thu, May 28, 2026 at 9:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 7.0-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> [ Upstream commit ae38d9179190a956e2a87a69ef1dd6f451b51c4d ]
>
> When a large message is fragmented into multiple skbs, the zerocopy
> uarg is only allocated and attached to the last skb in the loop.
> Non-final skbs carry pinned user pages with no completion tracking,
> so the kernel has no way to notify userspace when those pages are safe
> to reuse. If the loop breaks early the uarg is never allocated at all,
> leaking pinned pages with no completion notification.
>
> Fix this by following the approach used by TCP: allocate the zerocopy
> uarg (if not provided by the caller) before the send loop and attach
> it to every skb via skb_zcopy_set(), which takes a reference per skb.
> Each skb's completion properly decrements the refcount, and the
> notification only fires after the last skb is freed.
> On failure, if no data was sent, the uarg is cleanly aborted via
> net_zcopy_put_abort().
>
> This issue was initially discovered by sashiko while reviewing commit
> 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
> but was pre-existing.
>
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%4=
0redhat.com
> Reported-by: Maher Azzouzi <maherazz04@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Link: https://patch.msgid.link/20260514092948.268720-1-sgarzare@redhat.co=
m
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>  1 file changed, 34 insertions(+), 49 deletions(-)
>
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 8bea16dd22407..e8fb2e20db0f3 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -72,34 +72,6 @@ static bool virtio_transport_can_zcopy(const struct vi=
rtio_transport *t_ops,
>         return true;
>  }
>
> -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
> -                                          struct sk_buff *skb,
> -                                          struct msghdr *msg,
> -                                          size_t pkt_len,
> -                                          bool zerocopy)
> -{
> -       struct ubuf_info *uarg;
> -
> -       if (msg->msg_ubuf) {
> -               uarg =3D msg->msg_ubuf;
> -               net_zcopy_get(uarg);
> -       } else {
> -               struct ubuf_info_msgzc *uarg_zc;
> -
> -               uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
> -                                           pkt_len, NULL, false);
> -               if (!uarg)
> -                       return -1;
> -
> -               uarg_zc =3D uarg_to_msgzc(uarg);
> -               uarg_zc->zerocopy =3D zerocopy ? 1 : 0;
> -       }
> -
> -       skb_zcopy_init(skb, uarg);
> -
> -       return 0;
> -}
> -
>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>                                      struct virtio_vsock_pkt_info *info,
>                                      size_t len,
> @@ -319,8 +291,10 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
>         u32 src_cid, src_port, dst_cid, dst_port;
>         const struct virtio_transport *t_ops;
>         struct virtio_vsock_sock *vvs;
> +       struct ubuf_info *uarg =3D NULL;
>         u32 pkt_len =3D info->pkt_len;
>         bool can_zcopy =3D false;
> +       bool have_uref =3D false;
>         u32 rest_len;
>         int ret;
>
> @@ -362,6 +336,25 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
>                 if (can_zcopy)
>                         max_skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_B=
UF_SIZE,
>                                             (MAX_SKB_FRAGS * PAGE_SIZE));
> +
> +               if (info->msg->msg_flags & MSG_ZEROCOPY &&
> +                   info->op =3D=3D VIRTIO_VSOCK_OP_RW) {
> +                       uarg =3D info->msg->msg_ubuf;
> +
> +                       if (!uarg) {
> +                               uarg =3D msg_zerocopy_realloc(sk_vsock(vs=
k),
> +                                                           pkt_len, NULL=
, false);
> +                               if (!uarg) {
> +                                       virtio_transport_put_credit(vvs, =
pkt_len);
> +                                       return -ENOMEM;
> +                               }
> +
> +                               if (!can_zcopy)
> +                                       uarg_to_msgzc(uarg)->zerocopy =3D=
 0;
> +
> +                               have_uref =3D true;
> +                       }
> +               }
>         }
>
>         rest_len =3D pkt_len;
> @@ -380,27 +373,7 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
>                         break;
>                 }
>
> -               /* We process buffer part by part, allocating skb on
> -                * each iteration. If this is last skb for this buffer
> -                * and MSG_ZEROCOPY mode is in use - we must allocate
> -                * completion for the current syscall.
> -                *
> -                * Pass pkt_len because msg iter is already consumed
> -                * by virtio_transport_fill_skb(), so iter->count
> -                * can not be used for RLIMIT_MEMLOCK pinned-pages
> -                * accounting done by msg_zerocopy_realloc().
> -                */
> -               if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> -                   skb_len =3D=3D rest_len && info->op =3D=3D VIRTIO_VSO=
CK_OP_RW) {
> -                       if (virtio_transport_init_zcopy_skb(vsk, skb,
> -                                                           info->msg,
> -                                                           pkt_len,
> -                                                           can_zcopy)) {
> -                               kfree_skb(skb);
> -                               ret =3D -ENOMEM;
> -                               break;
> -                       }
> -               }
> +               skb_zcopy_set(skb, uarg, NULL);
>
>                 virtio_transport_inc_tx_pkt(vvs, skb);
>
> @@ -424,6 +397,18 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
>
>         virtio_transport_put_credit(vvs, rest_len);
>
> +       /* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> +        * skb_zcopy_set() increases it for each skb, so we can drop that
> +        * initial reference to keep it balanced.
> +        */
> +       if (have_uref) {
> +               if (rest_len =3D=3D pkt_len)
> +                       /* No data sent, abort the notification. */
> +                       net_zcopy_put_abort(uarg, true);
> +               else
> +                       net_zcopy_put(uarg);
> +       }
> +
>         /* Return number of bytes, if any data has been sent. */
>         if (rest_len !=3D pkt_len)
>                 ret =3D pkt_len - rest_len;
> --
> 2.53.0
>
>
>
