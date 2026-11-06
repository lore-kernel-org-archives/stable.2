Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793959014;
	b=IFNvDKKuRLxN0djUkMFqahyoazJ0BfF0txXLs234ONxTSKcB6Sr73xL69FTB94NZrFRX
	 nqhb300+ZMVIEGKFx9Mf2iaXqxg6LvXEEotdqhYMxDeiRkyToH/0w+AL6hlmeeGuJzNE0
	 tbLpZomxjNMjyOX99SygLSJ9dRtRpaF/M60JhgHf43fc4nHtRof4e3VH7SvZSBhPDPMtX
	 kWsZx5HvRMtVqFrLLLxOTh4/Hst49/Vh4h8XfzL7uS5NOdjVIiUcsdyXJde5b8YRdpZ2Z
	 8JEHijPEfdQNg1dQlwg+0MH7OCRmNnEQ86YEO7YaL4Zsp2XwzxNg/OlTS7AK05a/8nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
	b=204aYWYNAiCawd5osFVWZaQp5WhBkaV+xmZgvmGB4okrUlZJYiKx/J/k6yU3QTH+goh/
	 J3tCvPhf34Beb78r0WQv07b1/m6XXnj20Ps6PYzAxvconDOsL4xSBYJBDx1ffJYYmfT/i
	 mXzv6wi9Vh4DMhwtpuVDwbG1OLcfBHDNeX5c+M/Mxye67APAtKEvdaRxOeNADml6czpvB
	 5T3jXQuJBRT16ECd/K7C0YP477T1T9HarJ5GQEGL8IC/+OeM5ECHIaFDemQzwW1ePaF9B
	 vAEc0MRFQup2c5XB+I2RdNNm8+RHxESoviQXVX2g+KQcEigxQAkb9E+v88VUcfy3bPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DC1WsruF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AFC606EE90
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5AFC606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DC1WsruF
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6fbf1ba31fbso190964eaf.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 01:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793959013; cv=none;
        d=google.com; s=arc-20260327;
        b=A8Z4KQgCQn7ZpHYOgwPcCt8+oM3L9H6gEPePn4mkB3Dlt+sWQIQSft591eg70m9HEf
         eusv6cWNNg/vtUsamR5YgBQbl3Nd9sItsUOHa2y25lw+JZpMQcYU/l5TIFTOdSnb64VM
         7yrsBqhgG24Exa+KgZ/jdZKJAfIqwQipfH2Q4edH+v+VzXuUJMO+RO1u7HDBu12lJgIk
         bfMG4OCLhGwoUpS+qGSesIP47P2LwFzhk+nHXN6K5bQMmgyyrOekL1fukz9n/yK+PZME
         XLFcOeNnl2E7wRw/yERlamUi+pbtGQscBF2PsmxMBmc0d2e/lwo4kMCSUUjhFaZuIcW+
         7KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
        fh=ReER5SpKTsgJtDW+a+Ovw1vyCwQg9i0Fatu2Wi+79VM=;
        b=Md68fF5X2tM6dJg+1tNw3PKUVIaY5VPKCn5loqjpKj7FJBZ0E4pTNDk7IpLFchX/xW
         XG9B7XpFRFl7ED/pO8k8Qc/k6lpzS7uNjA6B6AYVWOf+SNWAeAO+Dlme3dLTxZVT5dNl
         cJU88Wr7bWNe45LKi6QItAP1lhRzafA1awtG3RQwX05/21ZZTpwgn99vNtwj2Qr5JoR7
         iT6bZUOKvDWQiNfBj1uwM42k69bopEYigrhM/jwc5oXWXjaqrs0wss62G9AXE7ucb/al
         xlGOni+wqmMZPOtwt/3XrwJYI6y88azcjYUJuOW9lmC7mYqFxhPmgPB7wulejPZIly+A
         amCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793959013; x=1794563813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
        b=DC1WsruFLXXTN6P3n2o8JI/oF3+2jjY7BXhjVXoFXS7LL9t+q+Ib/YLlMFA7l9vs7t
         edzsh0CROOlFdpf9eVjVGXtmXwoP8tnclg+M5jjkEUODxeOZcScwo8kA+zs7oE44xIIQ
         WMbV24U9dyl0SMJdKRZFgKcy+UVpABJxLkNsnCUxI/Ebe3qqoxfBN0jUSbikb80OeSDL
         ZA18DFN4pIZeYN/xDJlFo5aMflZb3NLeq9JGwF5KKSurDeeBBx5VgUN4U+GmqnOxtus4
         bbKUmfRCQZagfIGMI69t67yxSB2N5mNl8wV+Qf3/GWkP01gd8Gv6/J7CgrDIZek6X36r
         QmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793959013; x=1794563813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXmTy9uwoF9XL/Y4Z/VfoMc9t8DpXi9yTYkuKDHufjU=;
        b=csJ9HORdygOtjSiv39+UkZLgtZ4s/hdgT4wmj7Vzc66APx033NzQ9fne0OEpkMIOZS
         nzLARIfpDZbaVfXh9oQc7jem4z0EpW5PSUUyBQ5Z8VcXotZWHJza4STvuoPprKE4/j3c
         7gNesXkFajxZ0RguyLVpS/0AJ0zpFzZVYd/dzItXRpJoa0ctoFYDHzIPbLzs+kB7Lies
         pU2ShFu/PgaqE8xja5wt7KQtcpPbEbwkG7i5gunbxmo+1kMvwSUkwiWW4/HEjcS97mm5
         PSJU5tRcozz4voPs39d3I45LJS6YUh87qboAtGAR2h/o/HfDAfgfPly0tiQbRNYDIPKI
         0SZA==
X-Forwarded-Encrypted: i=1; AKwUvBy04WJ1ZtQ0O764JxSYN6G2RCnH45D+jHxhFXYzmwzS/1yFNk4yfzS4BEnVeepTpPuK5tWIy5E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8oc35FxtMABwdFnN4juPQ+Y8Y4Iz6zQbgciIX477xxBzGngce
	TJL0adcCX1G+VfryqoYtA1WnKNlXYvBgsu7YitE/hdmQV3GFrh3Juh+JJHDiOL/mflM0QmQHya0
	fIpWrkle6r9iYFCii4W2QKYE8AeQPFng=
X-Gm-Gg: AYBFou11NIo543dxUUe9royCcygtLN5sHmMFbQtyjGgzmF/VyUu3DEfgsOsilhhxwXa
	R3mqrqVTEUZoSKFCtEBrbENHwutRPub4wrnIRgTGpCt7cewb3C2+9l9srnhh3CYXmy81AgmFm9o
	ODj42ozuCZH+tSrsRvKLJsbhqDEs7KuxXqmYT7n3VNZwe0e1KmWM36pOnWsatzlhXyZMduNt+fc
	2LJNSN4e44PDXuKezaS9skU9hhOPom7dGbyJrgbnNxo/cwHOy5RDiPQoKNOtlCEgHcQlnKxcnB6
	iFrOb42QFX9yTgE6FktFxTqYoikr4notil79VHcGOfz8lJZNlJ5mfrwpSScDYYtmWMWwBjWBJw6
	+y2Z7b/k2asT3+IAhbTCGsriulnZX8dbEgl+ZO3Y8NoNjIJMmyHdtow3RE2DSllnJLTY2
X-Received: by 2002:a05:6820:1ca9:b0:6df:10cb:4a5f with SMTP id
 006d021491bc7-716e799cefemr1213893eaf.70.1793959008021; Fri, 06 Nov 2026
 01:56:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103090651.35399-1-amaan.cheval@gmail.com> <179382654505.488856.2284543045939069308@kernel.org>
In-Reply-To: <179382654505.488856.2284543045939069308@kernel.org>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Fri, 6 Nov 2026 15:26:36 +0530
X-Gm-Features: AclHuK8zljRi20SMMxIXqNiJVtR0YM6bZBYEmm6jP7OjzFd7Z5ca0jIffivj4yM
Message-ID: <CAG+wEg1vzCs2EXdLz6vLez_UoyzCzw0GY6=f+CmmNP+xvuXGpQ@mail.gmail.com>
Subject: Re: [PATCH net v3] gve: leave refcount headroom in the RX page bias
To: netdev-bot+sashiko@kernel.org, hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	pkaligineedi@google.com, maolson@google.com, csully@google.com, 
	willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:39=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] This patch refills the bias only after
>   gve_dec_pagecnt_bias() reaches 0, and it lowers the per-page bias from=
=E2=80=A6
>
> --
>
> gve: leave refcount headroom in the RX page bias
>
> This patch lowers the gve RX page refcount bias from INT_MAX to USHRT_MAX
> and stores it in a u16. This leaves page_count() room for references the
> stack takes with get_page(), such as splice() and tee(). When the bias
> reaches 0, it is refilled with a fixed batch of GVE_PAGECNT_BIAS.
>
> Link: https://github.com/amaanc/kernel-bias
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/=
ethernet/google/gve/gve_utils.c
> > index caed38cd5f2b3..cb6fba3122d5b 100644
> > --- a/drivers/net/ethernet/google/gve/gve_utils.c
> > +++ b/drivers/net/ethernet/google/gve/gve_utils.c
> > @@ -93,15 +93,9 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_in=
fo *page_info)
> >  {
> >       page_info->pagecnt_bias--;
> >       if (page_info->pagecnt_bias =3D=3D 0) {
> > -             int pagecount =3D page_count(page_info->page);
> > -
> > -             /* If we have run out of bias - set it back up to INT_MAX
> > -              * minus the existing refs.
> > -              */
> > -             page_info->pagecnt_bias =3D INT_MAX - pagecount;
> > -
> > -             /* Set pagecount back up to max. */
> > -             page_ref_add(page_info->page, INT_MAX - pagecount);
> > +             /* Out of bias: take another batch of references. */
> > +             page_info->pagecnt_bias =3D GVE_PAGECNT_BIAS;
> > +             page_ref_add(page_info->page, GVE_PAGECNT_BIAS);
> >       }
> >  }
>
> [Severity: Critical]
>
> Can this free a DQO-QPL RX page that is still registered with the device?
>
> Because the refill happens only at 0, the 1 -> 0 transition hands the
> driver's last reference to the consumer. With INT_MAX a page needed about
> 2^31 handoffs to get there. With GVE_PAGECNT_BIAS it happens every 65534
> handoffs.
>
> On DQO-QPL, gve_xdp_done_dqo() redirects the buffer before it touches the
> bias:
>
>         case XDP_REDIRECT:
>                 err =3D xdp_do_redirect(priv->dev, xdp, xprog);
>                 if (unlikely(err))
>                         goto err;
>                 gve_reuse_buffer(rx, buf_state);
>
> gve_reg_xdp_info() registers QPL rings as MEM_TYPE_PAGE_SHARED. If the
> redirect target is an AF_XDP socket in copy mode, the page is released
> synchronously:
>
> xdp_do_redirect()
>   xsk_rcv()
>     xdp_return_buff()
>       __xdp_return()
>         page_frag_free()
>           put_page_testzero()
>           free_frozen_pages()
>
> Suppose the page is at pagecnt_bias =3D=3D 1 and page_count =3D=3D 1. Tha=
t is the
> normal recyclable state once all earlier consumers have released their
> references. The QPL page then goes back to the buddy allocator while it i=
s
> still DMA mapped, registered in the QPL and owned by the buf_state.
>
> After that, gve_reuse_buffer()->gve_dec_pagecnt_bias() calls
> page_ref_add(page, GVE_PAGECNT_BIAS) on the freed page.
> gve_try_recycle_buf() then sees page_count - bias =3D=3D 0 and posts the =
page
> back to the NIC. Could the device then DMA packet data into memory that
> has already been handed to another user?
>
> The v3 notes say XDP on DQO-QPL "will be blocked explicitly in a separate
> patch". In this tree, gve_xdp(), gve_verify_xdp_configuration() and
> gve_set_xdp() do not check queue_format.
>
> gve_set_netdev_xdp_features() sets xdp_features =3D 0 for DQO-QPL, but
> nothing on the attach path enforces it. xp_assign_dev() also falls back t=
o
> copy mode when NETDEV_XDP_ACT_XSK is missing.
>
> That note is below the --- line, so it will not be in the applied commit.
> The patch is also tagged for stable without naming the prerequisite.
>
> The commit message also says:
>
>   Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do
>
> Those drivers refill at bias =3D=3D 1, so they always keep a reference. F=
or
> example, igb_can_reuse_rx_page() does:
>
>         if (unlikely(pagecnt_bias =3D=3D 1)) {
>                 page_ref_add(page, USHRT_MAX - 1);
>                 rx_buffer->pagecnt_bias =3D USHRT_MAX;
>         }
>
> Would it be safer to refill at 1 here, as v2 did, so the driver never
> gives up its last reference on a QPL page?

The scenario is real, but it is reachable only because XDP can be
attached on DQO-QPL at all, which the driver does not support:
commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
RDA") dropped the queue_format check that used to refuse it, and the
core only checks that ndo_bpf exists. Harshitha indicated on v2 that the
right fix is to block XDP on DQO-QPL rather than to change the refill
point.

Harshitha, I know you mentioned Google would send that patch:

  https://lore.kernel.org/netdev/CAEAWyHfCM_ZesnChP71AQvxjM4MASwukesgzuWCYE=
Cts7jiNhA@mail.gmail.com/

Since this fix depends on it, I'd like to post v4 as a two-patch
series with the DQO-QPL block as 1/2, so that the fix and its
prerequisite reach stable together. If you already have one in
flight, or would rather send your own, please let me know and
I'll drop 1/2 and rebase on yours instead.

pw-bot: cr

>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261103090651.35399-1-amaan.cheval%40gmail.com
