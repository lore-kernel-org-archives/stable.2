Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490EE23ABBF
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884565; cv=pass; b=jmnploABxx/UtN4WLYmI8EZVeE3FTnmNxSENCiSoU4Jb6DD/KRED/lO8/WiPkbJjVzewRIQ4bVK8QhoBayb1VWE4wXuJnS0prZUGiKHhmTspDEck+O9TZngBscJLaOOtsjciovSU76kyOFbLzjEAjViXUHBI+k/0Xbogo8CE8cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884565; c=relaxed/simple;
	bh=g3HNUhftQqwhz9Welt2hL10odBEgirJr3RX580gxRQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTlkcwFih4l/iaktPVv0Ti5RbdNnfAr0MySfkvU1HIWQkWOSp2GGqAMM2J9LjV2IrqfWjwNgl6PE1Vsdx9nFJikXXaWAFw5F5f1dYljXVR/nqUQNyqiva3xt3uR0F7Hu8euRVQ3brthbnuE2mY+655S74sMJisVe12dhbHD4EzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wia5DDba; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wia5DDba"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e5378b281aso13980395ad.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791884564; cv=none;
        d=google.com; s=arc-20260327;
        b=pxkLHgisF1GGhQ5Cz8+jjhAKZ39MZIVfY8DPgsDZavP1A5mDYoEAhmE5rTepWAryG2
         oqT9AihzHwC/UJhtrXzIwydF9fojuszHVjz5v5ug+bjcdapnc9uKb3lDiRTpyupv9v+v
         Mefz2xuMt4lZf/mTCH+US+AJ21t3IVeVJDlGVGITaClWZfwRpC3rqSprkZwmwAD2jHHu
         RIs8GpbbVeWU0FXO5vRayNcPAI+6uwe8XMN5GbcgOKr/BVS7uESCvv2LptujjoyE4GrA
         itY5LckVADotihw147dpY34F9qly7y+Sd9pVAODdpnX3jCMP85OTwZi1Z1EZDO9tti2h
         wrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mAnI3gMMigPQ9sJy4LtfAXQtpJGm0jNh6om1FnFHKWE=;
        fh=QO4qvSfhqqhGzgOe4Pbn6G9lFS60nNN0c2kB099jQ4s=;
        b=Tfx2CjIlH6rG/MFoxh4SR3M3Q2tOMqyirWo7ze2qukBQeol6pYS3azB9Z1lwEu3Un7
         M4sXE9F+pIaPRcmoGykzDW8RO5eZ0iEdJ5/b0d1xxGCyqXIt0HLTAurtp9+eHgMoakrE
         R2avRHqNUk4pXci8m48TPvdxGm1PHdFF2+gEhyGJR0INYX9HQqxWrzuY7Mz0U0HGwaSz
         D1vDoqx7XAz5c9e0jIuHN0qjEvL7IJWpT2a0GRYxTs5lXtbukh+SIbnlvNZElA8RTugs
         1H1laX336kaw9f31pmPT9hf4UvzWO2mtPoWEGODmFYh7U3f718CqNIJyDjeZZG7dz6lX
         NeyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791884564; x=1792489364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mAnI3gMMigPQ9sJy4LtfAXQtpJGm0jNh6om1FnFHKWE=;
        b=Wia5DDbaOY0bqMhCX2fawRLk61ag1O3GcX43DjG4Nq79Me6aMI+ddnJl7wcYlGdCOc
         yje7MrTMfmoCMNUZRSQr1trMjltfu33vOW/iUHH1iqGX25gBE/vWAvSLkdiFceUEJ1oS
         5/dgblaEiSNNrrxcTMNTXusZMqGOm4OGeQzqcI6al/uUfMU7cf0hh5Amkrtxa28CIlua
         aHDzkrzCpKxvNtM6bPB+y4mC7AXun1TgLXFjP4Y2AkvhspaqgsQVZoPGpSMS4ol9gGup
         6GmlWUSrnUo8d9y183gDHOwGdzEvKoxFR7gdWYLuQPpSYZMINs9HYXERt+GrcrmQ9pLQ
         uILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884564; x=1792489364;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mAnI3gMMigPQ9sJy4LtfAXQtpJGm0jNh6om1FnFHKWE=;
        b=G9Fb6HCYuNR+WizhPNKjLwUmmQgCLJIpkIEml4lGy+yA3UCqdCbba1RsUbTAqOAooZ
         V5qe3WLvwxEJhXtlqQ8CSrYlGgjdwY1oGJOd3rsfERiNQROs8e2WZWoEbLOAMC6fxZVw
         hICKYqnainiNN6RZP7bSIF9bHqJny8W65phFXURSwuhBssf93v3Oa6kIE3wvJ9mLSUN3
         ADYVaI2dje7MSHjgei2R98PnNqr21TZPjsiX7N+4ljd4m0n3I9zRMkMi79RN1fKDXoyK
         e7YAKdX6B1zKtDrvoLOTgkv6LLaSIxCJrfuanilGziB1TT4wi0lQxBoHE+ReeSdSpBdL
         JPSg==
X-Gm-Message-State: AFq9FYJFlGljyw4jVXeVF9T9rQi5dLeB/5l1W4KuDtnU9AsbnF58EkIF
	/hT7hsqYh/vFW27kv7TIQbQIuP03cecUXPSEVu/YqeLo3zk33PUZPtaJ3ZHnVMyyMDnOfu2MfO9
	26IxCn8JB9J8ls2DhdWtfT37MYyte3lnqZRo/754k2vYOZZg9tqqghglbMTo=
X-Gm-Gg: AYBFou0hg0RgowWqmH3RLJu8CRPefKQ/yXZVm2bIRWJ9P9tm1L0t3gd+RGINT8Q+E9W
	8OgFiKqZs6a+GyNxoPZE6TXUnWHwdZV0L3xG2D2mLoTy2yPitKGs/fKqgRu90G1WA8ZilZyLa48
	FF1soVanlFRkC78G154UURM4NNZ7Pt7eMmS6np9shzL95ZHjocrg+zG09XGXTxixYZz6p+bOO3G
	h4IQe7bU/rxNuOuVkLaXNy27ZKQC20YzPz3aVTcnQg2monlKGNN1Eas7EVzvXqpBI3HmVhv6JFi
	fnRfHAPeJpe8E60eWZlkII39mCf44AXUpE70yAOxg6VOAyBqQiM1t3H0E4kyDMhMtLbl9jujB/y
	jgl8kjmTuUg0=
X-Received: by 2002:a17:902:c946:b0:2e7:e73e:7091 with SMTP id
 d9443c01a7336-2e842bc6d99mr111206765ad.31.1791884562866; Tue, 13 Oct 2026
 02:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013093836.1269134-1-treapking@google.com> <20261013093836.1269134-2-treapking@google.com>
In-Reply-To: <20261013093836.1269134-2-treapking@google.com>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 13 Oct 2026 17:42:31 +0800
X-Gm-Features: AclHuK_bB5VS8GEFpHH9ZqOFM9Rsqlq1VDPi33wdjPgbjp5EcirAl-08uJfWySM
Message-ID: <CAHwYsioSa0TvmjBK2rU0KB9OKHKdcnbmybqHCvZ5VjDtMLbKbA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/5] gve: Fix race between stats query and queue reconfig
To: treapking@google.com
Cc: stable@vger.kernel.org, Debarghya Kundu <debarghyak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Please disregard this patch series. It was sent to the mailing list by
mistake. I intended to send it to myself for verification and
accidentally included the stable list in the CC.

My apologies for the noise and any confusion caused.

Best regards,
Pin-yen


On Tue, Oct 13, 2026 at 5:38=E2=80=AFPM Pin-yen Lin <treapking@google.com> =
wrote:
>
> Fix a concurrency bug where network statistics queries race with queue
> reconfiguration or interface teardown, causing a Use-After-Free (UAF) or
> NULL pointer dereference.
>
> Currently, statistics queries access priv->tx and priv->rx without
> locking. When an interface is brought down or reconfigured,
> gve_queues_mem_remove() frees these arrays. A concurrent stats query
> can dereference freed queue structures and crash the kernel.
>
> This issue was discovered and actually triggered by the
> drivers/net/stats.py selftest. When an interface was brought down,
> querying per-queue statistics via Netlink caused a kernel NULL pointer
> dereference in gve_get_rx_queue_stats():
>
>   BUG: kernel NULL pointer dereference, address: 00000000000000a0
>   RIP: 0010:gve_get_rx_queue_stats+0x17/0x50 [gve]
>   Call Trace:
>    <TASK>
>    netdev_stat_queue_sum+0x11c/0x250
>    netdev_nl_stats_by_netdev+0x21b/0x2d0
>    netdev_nl_qstats_get_dumpit+0xd2/0x220
>    genl_dumpit+0x32/0x90
>    netlink_dump+0x1d2/0x450
>    __netlink_dump_start+0x1db/0x2a0
>    genl_family_rcv_msg_dumpit+0x9b/0x100
>    ...
>
> Additionally, concurrent stats queries during queue reconfiguration can
> race with gve_queues_mem_remove(), causing a Use-After-Free.
>
> Fix this by introducing stats_lock to serialize stats queries against
> queue teardown. In gve_queues_mem_remove(), queue pointers are set to
> NULL under stats_lock before freeing. Stats readers acquire the lock
> and verify pointers are non-NULL before reading counters.
>
> This change was tested using the DQO RDA queue format.
>
> Cc: stable@vger.kernel.org
> Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
> Co-developed-by: Debarghya Kundu <debarghyak@google.com>
> Signed-off-by: Debarghya Kundu <debarghyak@google.com>
> Signed-off-by: Pin-yen Lin <treapking@google.com>
> ---
>
> Changes in v3:
> - Retitled from "gve: Add NULL pointer checks for per-queue statistics"
> - Protect all stats queries and queue lifecycle updates with spinlock
>   (sashiko)
> - Refined the commit message
>
>  drivers/net/ethernet/google/gve/gve.h      |  2 ++
>  drivers/net/ethernet/google/gve/gve_main.c | 37 +++++++++++++++++++---
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index c280ff35ee77..6f1eef11715b 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -883,6 +883,8 @@ struct gve_priv {
>         struct workqueue_struct *gve_wq;
>         struct work_struct service_task;
>         struct work_struct stats_report_task;
> +       /* Synchronizes stats accesses and queue teardown */
> +       spinlock_t stats_lock;
>         unsigned long service_task_flags;
>         unsigned long state_flags;
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index a6c18e2431cc..b6168bdf2ce7 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -114,6 +114,7 @@ static void gve_get_stats(struct net_device *dev, str=
uct rtnl_link_stats64 *s)
>         int num_tx_queues;
>         int ring;
>
> +       spin_lock_bh(&priv->stats_lock);
>         num_tx_queues =3D gve_num_tx_queues(priv);
>         if (priv->rx) {
>                 for (ring =3D 0; ring < priv->rx_cfg.num_queues; ring++) =
{
> @@ -141,6 +142,7 @@ static void gve_get_stats(struct net_device *dev, str=
uct rtnl_link_stats64 *s)
>                         s->tx_bytes +=3D bytes;
>                 }
>         }
> +       spin_unlock_bh(&priv->stats_lock);
>  }
>
>  static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
> @@ -1386,9 +1388,13 @@ static void gve_queues_mem_remove(struct gve_priv =
*priv)
>         struct gve_rx_alloc_rings_cfg rx_alloc_cfg =3D {0};
>
>         gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> -       gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> +
> +       spin_lock_bh(&priv->stats_lock);
>         priv->tx =3D NULL;
>         priv->rx =3D NULL;
> +       spin_unlock_bh(&priv->stats_lock);
> +
> +       gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
>  }
>
>  /* The passed-in queue memory is stored into priv and the queues are mad=
e live.
> @@ -1402,6 +1408,7 @@ static int gve_queues_start(struct gve_priv *priv,
>         int err;
>
>         /* Record new resources into priv */
> +       spin_lock_bh(&priv->stats_lock);
>         priv->tx =3D tx_alloc_cfg->tx;
>         priv->rx =3D rx_alloc_cfg->rx;
>
> @@ -1413,10 +1420,11 @@ static int gve_queues_start(struct gve_priv *priv=
,
>         priv->rx_desc_cnt =3D rx_alloc_cfg->ring_size;
>         priv->tx_pages_per_qpl =3D tx_alloc_cfg->pages_per_qpl;
>         priv->rx_pages_per_qpl =3D rx_alloc_cfg->pages_per_qpl;
> +       gve_init_sync_stats(priv);
> +       spin_unlock_bh(&priv->stats_lock);
>
>         gve_tx_start_rings(priv, gve_num_tx_queues(priv));
>         gve_rx_start_rings(priv, rx_alloc_cfg->qcfg_rx->num_queues);
> -       gve_init_sync_stats(priv);
>
>         err =3D netif_set_real_num_tx_queues(dev, priv->tx_cfg.num_queues=
);
>         if (err)
> @@ -2296,6 +2304,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
>         if (!gve_get_report_stats(priv))
>                 return;
>
> +       spin_lock_bh(&priv->stats_lock);
>         be64_add_cpu(&priv->stats_report->written_count, 1);
>         /* tx stats */
>         if (priv->tx) {
> @@ -2360,6 +2369,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
>                         };
>                 }
>         }
> +       spin_unlock_bh(&priv->stats_lock);
>  }
>
>  /* Handle NIC status register changes, reset requests and report stats *=
/
> @@ -2775,9 +2785,15 @@ static void gve_get_rx_queue_stats(struct net_devi=
ce *dev, int idx,
>                                    struct netdev_queue_stats_rx *rx_stats=
)
>  {
>         struct gve_priv *priv =3D netdev_priv(dev);
> -       struct gve_rx_ring *rx =3D &priv->rx[idx];
> +       struct gve_rx_ring *rx;
>         unsigned int start;
>
> +       spin_lock_bh(&priv->stats_lock);
> +       if (!priv->rx)
> +               goto unlock;
> +
> +       rx =3D &priv->rx[idx];
> +
>         do {
>                 start =3D u64_stats_fetch_begin(&rx->statss);
>                 rx_stats->packets =3D rx->rpackets;
> @@ -2785,20 +2801,32 @@ static void gve_get_rx_queue_stats(struct net_dev=
ice *dev, int idx,
>                 rx_stats->alloc_fail =3D rx->rx_skb_alloc_fail +
>                                        rx->rx_buf_alloc_fail;
>         } while (u64_stats_fetch_retry(&rx->statss, start));
> +
> +unlock:
> +       spin_unlock_bh(&priv->stats_lock);
>  }
>
>  static void gve_get_tx_queue_stats(struct net_device *dev, int idx,
>                                    struct netdev_queue_stats_tx *tx_stats=
)
>  {
>         struct gve_priv *priv =3D netdev_priv(dev);
> -       struct gve_tx_ring *tx =3D &priv->tx[idx];
> +       struct gve_tx_ring *tx;
>         unsigned int start;
>
> +       spin_lock_bh(&priv->stats_lock);
> +       if (!priv->tx)
> +               goto unlock;
> +
> +       tx =3D &priv->tx[idx];
> +
>         do {
>                 start =3D u64_stats_fetch_begin(&tx->statss);
>                 tx_stats->packets =3D tx->pkt_done;
>                 tx_stats->bytes =3D tx->bytes_done;
>         } while (u64_stats_fetch_retry(&tx->statss, start));
> +
> +unlock:
> +       spin_unlock_bh(&priv->stats_lock);
>  }
>
>  static void gve_get_base_stats(struct net_device *dev,
> @@ -2915,6 +2943,7 @@ static int gve_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>         }
>         INIT_WORK(&priv->service_task, gve_service_task);
>         INIT_WORK(&priv->stats_report_task, gve_stats_report_task);
> +       spin_lock_init(&priv->stats_lock);
>         priv->tx_cfg.max_queues =3D max_tx_queues;
>         priv->rx_cfg.max_queues =3D max_rx_queues;
>
> --
> 2.56.0.385.gd3acb90ef8-goog
>
