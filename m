Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8A3090C2
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476333; cv=pass; b=nLM17/SPNmarxmBdgsJ2IQCQZ5oGlCrxtdy4nqMRMomFKWfthwtXpy4jJgmO7+fm+27XD1DeKQ/WTsAI/wX5i7R4nzTS0E3qoB9FczMNGCSAxdDbCePYqyZHoLOQ04KOUCHqd9M7USqeHr9MFdNp9kIxV39n7frdLSsnla57o0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476333; c=relaxed/simple;
	bh=aLUr1soUynaG7nuHntz0abyPQOJiXVZFdp8AiJeBc2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Doo0Fy1RwCDUZBw4s2XtkHg6Q0tenX3HcKUD9nMMdpqEXkpgmQDXJd+PO47Bh84C9qlhrtGV5nxCKLWX0l4rUcDBc0a6iKuG9oIySS2jQbYGVM/1G37a9fslJ/oN+T1Myup0EJ4ZxSHMzFGSyXQvjFv/k5cy9mGNOimfkkNptoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnlvb4th; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnlvb4th"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so8331a12.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 22:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785476330; cv=none;
        d=google.com; s=arc-20260327;
        b=FBA2I0TFbwwX/MjQK5HZiqR2E6tGt17cpbdz8z6Aw+MdinhyjVi1c5z5xBm01+/BNH
         VyM78bVNb/WLbJK8nG2Qu7jlm3B1ZyeeOHJ3DbfWUPYVaAsJt0Wx10PUxhMIP6gENNVH
         xUvv/NzkIdUlREjvgC9JsgoigGFFshULBxWZhunu8N3fqSDfb/UqIVvMLYYxYIdr/Ink
         CzDiDuyjP5YXYTiqsWgulJ+6fLw6RSAdNY8DiKnQJQFmCNia5mOxzn7MTJAWgHPGhdnN
         mxh0BfJJ3dMYjDONkkBV9YiCsgV/OMGX9AFajxbYAXN8CkoKP6zmVEn6wH1yujrBZ5Mg
         ybBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rfXzh+hu/jKWREpYwOIBL6orsvbeWVHEpVUwhayH6Lw=;
        fh=BKlZQlE42MMglPbRm+nUlH1ISEniZNuEPmCboy+fC0I=;
        b=RO97gjDNaDvdoGKjfMXS38panNDRFZjNZgfKbtaQ3lXYv0bF/Xb6uvuO3v2wv2RdBc
         L6DFp8TKGCmD7gUmxMp+MotStQo5ayO1D6En5Lo0jffvd2rqTfZIcpUgCiYpNX0KuSss
         03VKzcRShmZbV+tZRqRVet8otAgzx8VJdX+QKVhtzFc8SnLLm6ss9NDVBU5h8c5832t0
         JPNFqZKEtvy1p/HEcBgdrrO+7D35O8n7b4v3/L29p6W4V38FfUmti9KgjMHMTYbCKrO0
         UfMJFYG/CilpP/7B1bTytxiDlMY/Cxw1AWC7LCLaPfy4Ok3Pbp5rsEUt9OhFgTxtMItT
         W+aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785476330; x=1786081130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rfXzh+hu/jKWREpYwOIBL6orsvbeWVHEpVUwhayH6Lw=;
        b=tnlvb4thSZBWRerQzSRi0JxgPiETnS04+Pi9OOtBMsaHLo8LmqZhMlpLDtR1EramkR
         NEwbpmqJucwy5DMPNM7M6gRk9G3rynTpPWNLnqowL7tnaHD2bOZDNxNiu23UQcBQGC1e
         F74l/BWsUHKtaBmjcwlMdTU89bSeMrQ21oPAyZ+r58q4fU4VIRdKrkla/WbpXnngFBte
         vBX5ZiVxCRaNq1Q3ljYeag90421e1dUdxSKbdwZ6+uvltQ/yQB75/5LRSaON6hjSWufk
         2MLCTWGOU6k709Syp5DXeWGwZ4AuyM+X4Sz34og5eOaj77Kv3B6qyqV4gYZMj/3dQv+Y
         4Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476330; x=1786081130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfXzh+hu/jKWREpYwOIBL6orsvbeWVHEpVUwhayH6Lw=;
        b=myB6jpyXIEjg+D9+nT1Yw7yqz6AgkSDjG2ULrsn9kKdKdF6Vw/X/0wy0A2mnTeFW94
         pYVa3jgwm3TSVqZxjyy4v4Xiil7BTh0Te0U6OmN8RKrAdIjcbzXNyLKOQjtywaWVd32g
         fTV6+TEoPK9I7jInn6GfOklfKRn3nbmGuYehQWt0+CV5RUS8Bcr1SulVgMuPY+Kc4oD2
         SUA0H6SQz5IKUOSqM1LZ49Pl8guh+xe9u1B4TKcuOKGL2QBIhUfkM/DSEkvrDl4096au
         qU0hso8QROjjTfjo7kDi4DBHDTmW3SE5r4EnQ1OicQXpfCoU/0GOGU/VTqCO688Bemvr
         pjhg==
X-Gm-Message-State: AOJu0YxNDohWS/nrY5wistlPRjzySAN+BkislZb0jwDl5/dGvIcM9Bsc
	c7Tz4vytgY3BjmIjAqGAB389oZceRrN7WNdwayIMfYPTlKIGpqd5T3RihnSRhoQoR4cRyY8C+mF
	JJzb1aXiZdaNpsMkn9bAWRKVAu2K7yxq0LBCFzece+lgl+Ql97kbh1lSK
X-Gm-Gg: AR+sD11Zr3jdh9i5JdVsZdWRPGDqPISWA0fkdeZtncG0KEBmhxpn40q1QN17dbBsQyi
	su2QcuywvqTzy70csOoitFov81VDJyGcFawlMvklRkTvZLI8xS7Cc7M8a/PkaN5b0whdLcquNEG
	6O8Uck/+wrBGKX25Y2hleX+fGD/RPbSHL8vf4eVEBvdOqXRFNKnN6U1HJUT6c+q8HjPIgXSSRDa
	w3NA9PghiOx5ebBsYYVzX1dxV8l8+LEHyKeW94Vj4GbXDIuCkCrbSzTpmePTizP83trcfi5q/g2
	t61RZNqynkHg7XDpQxCEeNdRXHd+F9t7ogYQFgfJ8R7dlV7nv9PFargMr/uJ2sqenbXIglwIo1T
	cJrJwh19fzrzyal4Iqjh8udK22A1tCoiCnGwpcSiaz2BP
X-Received: by 2002:a05:6402:a2cb:20b0:6a0:6677:37f9 with SMTP id
 4fb4d7f45d1cf-6a09815903dmr36216a12.1.1785476329213; Thu, 30 Jul 2026
 22:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026072934-distort-skimpily-0491@gregkh> <20260731052136.2424945-1-eddiephillips@google.com>
In-Reply-To: <20260731052136.2424945-1-eddiephillips@google.com>
From: Eddie Phillips <eddiephillips@google.com>
Date: Thu, 30 Jul 2026 22:38:37 -0700
X-Gm-Features: AUfX_mwuFp1cUCEYHimkmnwSee2d8EZcVZwSf81YN6884l6HSZKUGdh9TJ6HgAE
Message-ID: <CAPBb8HmWXzbtbVAG6Btpg=NpCLeSK5Npzo_Vz7kRVGzDdLby9Q@mail.gmail.com>
Subject: Re: [PATCH] gve: fix Rx queue stall on alloc failure
To: stable@vger.kernel.org
Cc: Jordan Rhee <jordanrhee@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 10:23=E2=80=AFPM Eddie Phillips
<eddiephillips@google.com> wrote:
>
> When the system is under extreme memory pressure, page allocations can
> fail during the Rx buffer refill loop. If the number of buffers posted
> to hardware falls below a critical low threshold and the refill loop
> exits due to allocation failures, the queue can stall:
>

Hey, please disregard this,

I didn't notice while running `git send-email` that specifying a patch file
drops all the command line args, including `subject-prefix`. I'll send it a=
gain.

> 1. The device drops incoming packets because there are no descriptors.
> 2. Since no packets are processed, no Rx completions are generated.
> 3. Because no completions occur, NAPI is never scheduled, preventing
>    the refill loop from running again even after memory is freed.
>
> This results in a permanent queue stall.
>
> Resolve this by introducing a starvation recovery timer for each Rx queue=
.
> If the number of buffers posted to hardware falls below a critical low
> threshold, start a timer to periodically reschedule NAPI. Once NAPI runs
> and successfully refills the queue above the threshold, the timer is
> not rescheduled.
>
> The threshold is set to 32 because a single maximum-sized Receive Segment
> Coalescing (RSC) packet can consume up to 19 descriptors in the Rx path.
> Lower thresholds (such as 8 or 16) would be insufficient to process a
> complete maximum-sized RSC packet, risking packet drops or unexpected
> hardware behavior under memory pressure. Setting the threshold to 32
> guarantees a safe margin to handle at least one full RSC packet.
>
> Cc: stable@vger.kernel.org
> Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Eddie Phillips <eddiephillips@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Link: https://patch.msgid.link/20260709211906.3322883-1-hramamurthy@googl=
e.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> (cherry picked from commit b65352a1bac64442ad95e64f385b40ccb9f1b0db)
> ---
>  drivers/net/ethernet/google/gve/gve.h        |  3 ++
>  drivers/net/ethernet/google/gve/gve_main.c   |  3 ++
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 33 ++++++++++++++++++++
>  3 files changed, 39 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 822bdaff66f6..75773524ba81 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -10,6 +10,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/timer.h>
>  #include <linux/u64_stats_sync.h>
>
>  #include "gve_desc.h"
> @@ -35,6 +36,7 @@
>
>  /* Interval to schedule a stats report update, 20000ms. */
>  #define GVE_STATS_REPORT_TIMER_PERIOD  20000
> +#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
>
>  /* Numbers of NIC tx/rx stats in stats report. */
>  #define NIC_TX_STATS_REPORT_NUM        0
> @@ -218,6 +220,7 @@ struct gve_rx_ring {
>         struct u64_stats_sync statss; /* sync stats for 32bit archs */
>
>         struct gve_rx_ctx ctx; /* Info for packet currently being process=
ed in this ring. */
> +       struct timer_list starvation_timer; /* for queue starvation recov=
ery */
>  };
>
>  /* A TX desc ring entry */
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index a8fb51e77fea..38333731f5d0 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -508,6 +508,9 @@ static void gve_remove_napi(struct gve_priv *priv, in=
t ntfy_idx)
>  {
>         struct gve_notify_block *block =3D &priv->ntfy_blocks[ntfy_idx];
>
> +       if (block->rx && !gve_is_gqi(priv))
> +               timer_shutdown_sync(&block->rx->starvation_timer);
> +
>         netif_napi_del(&block->napi);
>  }
>
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 8756f9cbd631..c9bc85293c27 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -16,6 +16,16 @@
>  #include <net/ipv6.h>
>  #include <net/tcp.h>
>
> +static void gve_rx_starvation_timer(struct timer_list *t)
> +{
> +       struct gve_rx_ring *rx =3D from_timer(rx, t, starvation_timer);
> +       struct gve_priv *priv =3D rx->gve;
> +       struct gve_notify_block *block;
> +
> +       block =3D &priv->ntfy_blocks[rx->ntfy_id];
> +       napi_schedule(&block->napi);
> +}
> +
>  static int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
>  {
>         return page_count(bs->page_info.page) - bs->page_info.pagecnt_bia=
s;
> @@ -185,6 +195,7 @@ static void gve_rx_free_ring_dqo(struct gve_priv *pri=
v, int idx)
>         completion_queue_slots =3D rx->dqo.complq.mask + 1;
>         buffer_queue_slots =3D rx->dqo.bufq.mask + 1;
>
> +       timer_shutdown_sync(&rx->starvation_timer);
>         gve_rx_remove_from_block(priv, idx);
>
>         if (rx->q_resources) {
> @@ -237,6 +248,7 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *pri=
v, int idx)
>         memset(rx, 0, sizeof(*rx));
>         rx->gve =3D priv;
>         rx->q_num =3D idx;
> +       timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
>         rx->dqo.bufq.mask =3D buffer_queue_slots - 1;
>         rx->dqo.complq.num_free_slots =3D completion_queue_slots;
>         rx->dqo.complq.mask =3D completion_queue_slots - 1;
> @@ -334,6 +346,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
>         struct gve_rx_compl_queue_dqo *complq =3D &rx->dqo.complq;
>         struct gve_rx_buf_queue_dqo *bufq =3D &rx->dqo.bufq;
>         struct gve_priv *priv =3D rx->gve;
> +       u32 num_bufs_avail_to_hw;
>         u32 num_avail_slots;
>         u32 num_full_slots;
>         u32 num_posted =3D 0;
> @@ -374,6 +387,26 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
>         }
>
>         rx->fill_cnt +=3D num_posted;
> +
> +       /* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> +        * visible to the hardware, the hardware is in danger of starving
> +        * and cannot trigger interrupts.
> +        *
> +        * We use a threshold of 32 because a single maximum-sized RSC
> +        * packet can consume up to 19 descriptors in the Rx path. Lower
> +        * thresholds (e.g., 8 or 16) would be unsafe as they could cause
> +        * the device to drop/stall on a maximum-sized RSC packet.
> +        *
> +        * Start the timer to periodically reschedule NAPI and recover.
> +        */
> +       num_bufs_avail_to_hw =3D
> +               ((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> +                bufq->head) & bufq->mask;
> +
> +       if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
> +               mod_timer(&rx->starvation_timer,
> +                         jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_=
MS));
> +       }
>  }
>
>  static void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_rin=
g *rx,
> --
> 2.55.0.571.g244d577d93-goog
>
