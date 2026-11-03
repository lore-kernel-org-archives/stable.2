Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793664496;
	b=l7FUKxDkZIiCYyHPQGSaWUJmwejpByken3Fh8bVJ25mGICJ4tUuOf40+GBSIJ058Gg3l
	 cWqxAQ6TCj3FxoutLWgXLwK8eL2pz7XugsmK3oZuFvgjdxozBHOO1pcEOV9a4IZBZ+lAO
	 NCKW7sOm4PaovhmykEvuen7t118xzYE5MmOLDqaZO24aDyS5+Ft3V1jnGiHArzdP4utbZ
	 SZJmSGvvbuE+f/z/osAmxSgQ653JD0TzhE6XPlvQq+BSOpfcbOZ76TUZrIYBUSWgMRVg7
	 veYRaFYelrdJfiZmFhmVfQV2YBS9ybAKqjraIyod62N0wB1ORMoDfdvqg6kUESR/Ivw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6o0BhCJ8MPSIhdTuJplcbj2Jd16gjfRtKR3UOoBlXuk=;
	b=eEHd8WD+0NE0ai+cBoonADrQWcJqagh5wt7sJaC3U3e9CFqH5HCLnLL0PHvmsYWrBPPD
	 RDwKTbUJC2r0hOogy7KBbmDAZUsOxIV0S8mNnqt7+ryWnp2B4sKMYyPu+S40sK1bUjP3O
	 EB432iGZVOtGQXI575DqmsmQ0UB/m6ELEU4Gky8sPpRXexriHqij4QZFLqfhBB5ra5bIE
	 43jJOd/zRTdEMQYgbY2Cr2V2ba8hzI0vghdoNyh5dAOWkFvUelI4kTMo4zhDa0rfJL8mN
	 rsfJE9tW/tr7UIoxCmcMDcF9er47r4cp/zKVAl/QfEglKdVY8413WWowMyR3bkiXYZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PBWkbjJr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D77606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 00:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D77606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PBWkbjJr
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so18995ad.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 16:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793664495; cv=none;
        d=google.com; s=arc-20260327;
        b=TD/qDBPEtAV2n8eT58258ICZWf6gXP1y+W/Ws+wO9w8Sz1kLxnrl1zRfvt0PMMh4r0
         AjpUSdLeM+52U/68DHNc46X6H8cI+lX57IFKAknPUaWgSoVTSqYDO8CnAJX9Gkc9YsLj
         h75mXTfZzotZ8zWxAi5FT2aUK5xl8JEZ+W3/0IMIxTZRadG9v0PaKy/f8wcigKMaY0mY
         FhXV+QWu9Cm2/2KUJQ2nsPozSwgTgYrzd00+DlWIEZH9oLpGhcr5WN5eiaAsIa3baG4r
         tNNs371XtXrobT8VZnoOvAXmel9FDyuO5pqCF+Tf/9G7nvXr9lKq1l5vQ3RPLTN7TzQG
         MfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6o0BhCJ8MPSIhdTuJplcbj2Jd16gjfRtKR3UOoBlXuk=;
        fh=p7aI2sMM13UmI2IthuZVu8cMj+5KBCNJERBCxjbOefk=;
        b=cETjXXWb+E048w1um0nwj3CrsCPnW5R92doWHtJWoP45CTD/tfO9P3r+F97/pg0EC0
         XK/J5OvGfge8arCxpRKxi4Q0ghA7eueiEjoFDbcgGxm02l9PzH07n4G49hL1fURfq/gS
         0ourBXIuDPH/xgmJmbKHEV8v5ut+3Y0UKVtSrrTYsPloEO6KxriIVZwD5/OjxKZWZtXd
         ecmJ455jEXHWJdzNTdV8Yuo7y+aN8vAkIxHgQS4J4hAasG0HGgVxbi9WLiSJ4zS4/0fR
         xmtHQSKLAi3F7gAeiO6JpmP+R0WSw8QQ+iy+JPO9fqGf9CEPMAc4V5PLnhJZWZVujhiB
         S46w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793664495; x=1794269295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6o0BhCJ8MPSIhdTuJplcbj2Jd16gjfRtKR3UOoBlXuk=;
        b=PBWkbjJrU9TcyG32MEtv32gjh7BOYMycgKlgLBLDicqz1VbngrDYjy9oW2vto9MODE
         /z6wFEMEa35BMUWoGZrlLHzkLdh56ZNbSS67AsCxc7UgiTd8ELqSrGtce0658unDAxxn
         XjXgzXBzbRmAiejD/JTuHVGM3Vz3E5SAbPBCtgxYw0SC+YIU955tQIfIcjgjfk+UILeH
         bgHaMyiYdZtlmOGz5NZiw0H9qy6/Jd3mjX4d/VoVdjHzyoSvh/dr6+D/UN3iNLfDBHoG
         MZv400V+zZr6KhG4pOuoVENH55cXgYqJUfxoepebWuSecg3n4P2y6JKGgVSm+PRW5nAN
         pMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664495; x=1794269295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6o0BhCJ8MPSIhdTuJplcbj2Jd16gjfRtKR3UOoBlXuk=;
        b=KOvSOdXh2yZ5O0sq2HMzSDhhDp+XV4L6vD38nUuSb5rYWNxQ51hv54tmpB6c/rYENq
         EGvosAuYS3CGSWpkOM7av3EtiMzqalLKbbXqZV2xvmBwkU/Q2Ve7y+jnAJm005/65H1A
         RzrZOg2YMr3H3ZOW7jIKURwRp1DR/xIitDo1xqmKzxqGJJCtqKF9jSZSSu5nEaERv02+
         sXFFNM7dOHirfnKp4ut0UHwPhBI66z+mzwBcRjd0LjZtKxwlRWlxKVS6Vbx87wVW1SPl
         H7v1keaNPaCILmbq/nouK3/VcpHvUCF2owKyRy2xpgjMLLapFBN8AcfCCEv/Tyzm4lMF
         eFPw==
X-Forwarded-Encrypted: i=1; AKwUvBzuMpN1tZBaVaFqIdrg8S6+VCevclho2g/lUkdk+0PaPojMwxnbGsrpL0sgpfj3Dbyls4IbJTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+YdFRMUxPuN32o86/cwmcscKfTXaHQuaJTWaMXffBc0EnBOc6
	7NYzGu9YWvNTH8ixO/Y7rr6nGI8IxXjhYucD+bs7HPczx4hIsLKVS0NOFw7zaf4ZYpGMFapWIdT
	TJMimwfBrjubeuLOf7ahabs+GPxNVT9tF4MDIwtqt
X-Gm-Gg: AYBFou0Oue6Ql0TOi0hX+T6lNGhBa/gryfY6SCF+iGSFaWEYmBLu6s5d7xHuJMK9w6u
	imLiA/ojTgHBX+g2/8mN1K6CQ/rGpi1V/N5vE6uBlqWWmqfNfQXPFePwulLf/EP9B2/Gvc/IDvH
	teeN/9KbEDVOtkap9yh19czWu14gQEa44pkDbuAc3fLkZBb4GleYWihQey5t+tBcNaGyJQA7drL
	KvB2I5MMBx+KSa/0u09pNkanPnIZh4BqSUBb/ij1f5F/qSCFFATjifCPhPrFel2Yq1WlwQCMole
	I4oZgeRKIrFJop/5CHnZBZ3p60VW1DXhSPf5fyzOSm6P+K1zduzHNNRvj3XW7xECnRYKnDmo/io
	HsuKBlIibA5eXisyjQ8frg+Zlf3dOk3rYjhK+RFQ0CwvU4UELK4VOozXuv56xu9lrDj4L/+I2fR
	5znQpMtPI81IhdgtYotY3xMHmqtodydi1L9Q==
X-Received: by 2002:a17:902:e551:b0:2eb:188a:1c06 with SMTP id
 d9443c01a7336-2ecef4c9056mr883065ad.9.1793664494568; Mon, 02 Nov 2026
 16:08:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102112613.18334-1-amaan.cheval@gmail.com>
In-Reply-To: <20261102112613.18334-1-amaan.cheval@gmail.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 2 Nov 2026 16:08:03 -0800
X-Gm-Features: AclHuK80ad1IakJMKcxnca44nFjXcYHDd_hIyZGlaq7-IDmcguWTnKbuzcEk3CI
Message-ID: <CAEAWyHfCM_ZesnChP71AQvxjM4MASwukesgzuWCYECts7jiNhA@mail.gmail.com>
Subject: Re: [PATCH net v2] gve: leave refcount headroom in the RX page bias
To: Amaan Cheval <amaan.cheval@gmail.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	bcf@google.com, jordanrhee@google.com, przemyslaw.kitszel@intel.com, 
	pkaligineedi@google.com, maolson@google.com, csully@google.com, 
	willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:29=E2=80=AFAM Amaan Cheval <amaan.cheval@gmail.com=
> wrote:
>
> gve's GQI and DQO-QPL RX paths set every RX page's refcount to INT_MAX an=
d
> hand references to the stack by decrementing page_info->pagecnt_bias, to
> avoid an atomic op per packet. This leaves the page no headroom: while a
> fresh page's buffer sits in an skb its refcount is already INT_MAX, so a
> single get_page() from the stack wraps it negative.
>
> splice() of received TCP data into a pipe takes such a reference, and the
> onward splice into a socket then fails: skb_splice_from_iter() sees
> page_count() < 1, sendpage_ok() fails and the send returns -EIO (since
> commit 2e910b95329c ("net: Add a function to splice pages into an
> skbuff for MSG_SPLICE_PAGES")). tee() of the pipe fails with -EFAULT via
> try_get_page(). On GQI the reuse check gve_rx_can_recycle_buffer() also
> sees page_count() < pagecnt_bias, WARNs and calls gve_schedule_reset(),
> so a task that merely pins a fresh RX page (e.g. holds spliced data in
> an undrained tee() pipe) can reset the NIC.
>
> Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do: the bias
> only has to make the per-packet atomic rare, so a small value leaves
> page_count() ample headroom below INT_MAX for the stack's references.
> Refill by adding a fixed batch and setting the bias to it, which keeps
> the rule `references =3D page_count() - bias` intact.
>
> Refill when the bias drops to 1, not 0, so the driver always keeps one
> reference of its own. That matters when a consumer returns its
> reference before the driver has decremented the bias:
> DQO-QPL passes the QPL page itself to xdp_do_redirect() and only calls
> gve_dec_pagecnt_bias() afterwards, and an AF_XDP socket in copy mode
> returns the buffer synchronously via xdp_return_buff(). If the refill
> waits for bias 0, the last handoff of each batch happens at bias 1,
> when the reference being handed off is the page's only one, and that
> put_page() frees a page that is still DMA-mapped and registered with
> the device as part of the QPL. That is a use-after-free: the driver
> then takes new references on freed memory and re-posts the buffer, so
> the NIC keeps writing packets into a page that may already belong to
> someone else. INT_MAX hid this because one page had to be handed off
> 2^31 times to get there; a 16-bit bias gets there after 65535.
>
> Reproduced on gVNIC in GQI-QPL mode (GCE n2-standard-8, 6.12) and
> in DQO-RDA mode (GCE c3-standard-8, 6.12) with the help of
> relay.py -- a small splice(2) TCP proxy -- relaying a download while
> the RX ring is refilled with fresh pages:
>
>   ethtool -G eth0 rx 512 && ethtool -G eth0 rx 1024   # fresh RX pages
>   ./relay.py $HOST 8080 &                             # splice()s both wa=
ys
>   for i in $(seq 200); do curl -so /dev/null \
>       --connect-to $HOST:80:127.0.0.1:8080 http://$HOST/file; done
>
> Most downloads failed with EIO before the fix (tee() with EFAULT) and
> all completed after it. relay.py is at the Link below.
>
> This bug was found and fixed with the help of an AI coding assistant
> (Claude Code) over an interactive session; it read the driver and
> splice/pipe code and ran the tests above.
>
> Link: https://github.com/amaanc/kernel-bias
> Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> Fixes: 58401b2a46e7 ("gve: Add rx buffer pagecnt bias")
> Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> ---
> v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@=
gmail.com/
>
> v2:
>  - Refill when the bias reaches 1 instead of 0 so the driver keeps a
>    reference of its own across every handoff. At bias 0 a consumer that
>    returns its reference synchronously, such as an AF_XDP socket in copy
>    mode on an XDP_REDIRECT from DQO-QPL, freed a page still registered in
>    the QPL.
>  - Commit message: explain the refill point, drop the build notes.
>
> Re-tested on 6.12.113 (c3-standard-8, DQO-RDA, which still uses the
> bias on 6.12), fixes EIO/EFAULT from splice/tee nor a NIC device reset
> after applying the patch.
> DQO-QPL is untested; I have no access to that hardware.
>
> Built allmodconfig W=3D1, no new warnings.
>
>  drivers/net/ethernet/google/gve/gve.h           |  2 +-
>  .../ethernet/google/gve/gve_buffer_mgmt_dqo.c   |  4 ++--
>  drivers/net/ethernet/google/gve/gve_rx.c        |  8 ++++----
>  drivers/net/ethernet/google/gve/gve_utils.c     | 17 ++++++++---------
>  drivers/net/ethernet/google/gve/gve_utils.h     |  8 +++++++-
>  5 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index b7ce6e8632db..18d7edbf4b3b 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -119,7 +119,7 @@ struct gve_rx_slot_page_info {
>         void *page_address;
>         u32 page_offset; /* offset to write to in page */
>         unsigned int buf_size;
> -       int pagecnt_bias; /* expected pagecnt if only the driver has a re=
f */
> +       u16 pagecnt_bias; /* expected pagecnt if only the driver has a re=
f */
>         u16 pad; /* adjustment for rx padding */
>         u8 can_flip; /* tracks if the networking stack is using the page =
*/
>  };
> diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/driv=
ers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> index 6880d1531ba5..571f851d6dcd 100644
> --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> @@ -149,8 +149,8 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
>         buf_state->last_single_ref_offset =3D 0;
>
>         /* The page already has 1 ref. */
> -       page_ref_add(buf_state->page_info.page, INT_MAX - 1);
> -       buf_state->page_info.pagecnt_bias =3D INT_MAX;
> +       page_ref_add(buf_state->page_info.page, GVE_PAGECNT_BIAS - 1);
> +       buf_state->page_info.pagecnt_bias =3D GVE_PAGECNT_BIAS;
>
>         return 0;
>  }
> diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ether=
net/google/gve/gve_rx.c
> index 81ea800e66e9..6533fff06155 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx.c
> @@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *r=
x,
>         page_info->buf_size =3D rx->packet_buffer_size;
>         *slot_addr =3D cpu_to_be64(addr);
>         /* The page already has 1 ref */
> -       page_ref_add(page, INT_MAX - 1);
> -       page_info->pagecnt_bias =3D INT_MAX;
> +       page_ref_add(page, GVE_PAGECNT_BIAS - 1);
> +       page_info->pagecnt_bias =3D GVE_PAGECNT_BIAS;
>  }
>
>  static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev=
,
> @@ -230,8 +230,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *r=
x,
>                         rx->qpl_copy_pool[j].buf_size =3D rx->packet_buff=
er_size;
>
>                         /* The page already has 1 ref. */
> -                       page_ref_add(page, INT_MAX - 1);
> -                       rx->qpl_copy_pool[j].pagecnt_bias =3D INT_MAX;
> +                       page_ref_add(page, GVE_PAGECNT_BIAS - 1);
> +                       rx->qpl_copy_pool[j].pagecnt_bias =3D GVE_PAGECNT=
_BIAS;
>                 }
>         }
>
> diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/et=
hernet/google/gve/gve_utils.c
> index caed38cd5f2b..adcdccd54684 100644
> --- a/drivers/net/ethernet/google/gve/gve_utils.c
> +++ b/drivers/net/ethernet/google/gve/gve_utils.c
> @@ -92,16 +92,15 @@ struct sk_buff *gve_rx_copy(struct net_device *dev, s=
truct napi_struct *napi,
>  void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
>  {
>         page_info->pagecnt_bias--;
> -       if (page_info->pagecnt_bias =3D=3D 0) {
> -               int pagecount =3D page_count(page_info->page);
> -
> -               /* If we have run out of bias - set it back up to INT_MAX
> -                * minus the existing refs.
> +       if (page_info->pagecnt_bias =3D=3D 1) {
> +               /* Refill at 1, not 0: the page's own reference is counte=
d
> +                * in the bias, and a consumer can put the reference we j=
ust
> +                * handed off before we get here (e.g. a synchronous
> +                * XDP_REDIRECT return). At bias 0 that put would free a
> +                * page that is still mapped for the NIC.
>                  */

DQ QPL mode is not supposed to support XDP at all. The bot correctly
caught that xdp_do_redirect() is inadvertently called in DQ QPL mode
but the more holistic fix is to explicitly block XDP in DQ QPL mode.
Since the driver is not supposed to support it(and doesn't)

We will send up a patch to explicitly block XDP in DQ QPL mode, so v1
is the appropriate fix.

With that change, feel free to add to v3:
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

Thanks for providing the reproducer script, I verified it on a N4 VM
which runs DQ QPL mode. So,
Tested-by: Harshitha Ramamurthy <hramamurthy@google.com>

> -               page_info->pagecnt_bias =3D INT_MAX - pagecount;
> -
> -               /* Set pagecount back up to max. */
> -               page_ref_add(page_info->page, INT_MAX - pagecount);
> +               page_info->pagecnt_bias =3D GVE_PAGECNT_BIAS;
> +               page_ref_add(page_info->page, GVE_PAGECNT_BIAS - 1);
>         }
>  }
>
> diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/et=
hernet/google/gve/gve_utils.h
> index bf2e9a0adb36..a5e3413234d0 100644
> --- a/drivers/net/ethernet/google/gve/gve_utils.h
> +++ b/drivers/net/ethernet/google/gve/gve_utils.h
> @@ -25,7 +25,13 @@ struct sk_buff *gve_rx_copy_data(struct net_device *de=
v, struct napi_struct *nap
>  struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *=
napi,
>                             struct gve_rx_slot_page_info *page_info, u16 =
len);
>
> -/* Decrement pagecnt_bias. Set it back to INT_MAX if it reached zero. */
> +/* Up-front references gve holds on an RX page, so handing a buffer to t=
he
> + * stack is a pagecnt_bias decrement, not a get_page(). Keep it in a u16=
 so
> + * the 32-bit page refcount keeps the headroom every page needs below IN=
T_MAX.
> + */
> +#define GVE_PAGECNT_BIAS USHRT_MAX
> +
> +/* Decrement pagecnt_bias. Top it up to GVE_PAGECNT_BIAS if it reached 1=
. */
>  void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info);
>
>  void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
> --
> 2.47.3
>
