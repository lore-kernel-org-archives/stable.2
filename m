Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0575371065
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065816; cv=pass; b=bQtL3BtkYJ0rNXoysvmgyKj5ZYm8O809EuSL+OPcrbMyXp8oYWJUxTmKx3JyPtn8UN4WKe2+LGLuJb00XaFceUGmazmV4t6BWKmMxckhS7ZEswELuHmn3Lm3sZOto3Ynv00jeqD/+GsEj94xnR5keOApoJ0n3FPX7HefxwGEC+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065816; c=relaxed/simple;
	bh=nsrm07UydNikITMgTVAU6koo5bDjbCYqa6h5AOzaPIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5+LxbFBfoWZ3YRwpS6EqdFPmU+h1CZOCrpcCWuS/MZLRWpFoM7MM2/+oYVwIHO5kQFP9bSZ/kGJpx8aDQDjipbHpmaPKEwdb73kMqMTVuW1jC1QNrCxg5VfG4zHu+i9RjW66iw0D9BnlE69fAxokC15zx95sx0EAhpsGDsjaNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSuMI/yQ; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSuMI/yQ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-695a3842230so40200a12.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 01:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783065813; cv=none;
        d=google.com; s=arc-20260327;
        b=qNhrLBOcTQfgzdKQTYALTn1cP2iit8WIazdqJrtEmCnJu4ueGQ9w99GTFS9GfS2QrO
         tnSopTYbYlRaY5uOiOf7UiqSdzdTVeS95wSkpvyZAJhiBCBraDKSro98sU3EzOJp2i04
         0y3DubBEaIS1wsvUdg2Ht7kJZ1Pu2xxaQSUUVGXCYzzT5milEwaZJOEjoUoU8wQyqg8A
         Q92LpOqxiBXCBoVVrsnvQxQl3RIejKYVSLBB1attRaoCh4MiYTI4+aLSj6WiK3I7rXx+
         kC49f80K0jgBU6YnKfsv2XmtWNXbaVqfsBI0KtvA+nP4QDjmXWify4xXkR/GQ99wZ5vD
         5FZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HeKM6E3ikqLN6XP3NncyHeU2nWvurVANKF6w+ddq690=;
        fh=dn2KdlnjcOm5n05H3+2cshDorccW3340j1OzIHkK75E=;
        b=RyeJpwbcvPtEKXjz4qpb1RzGvKwckncSUyr6C2Kx7J4xwwCKm8FVvkVvF+g13Tkx10
         Xqg2HxXLb1glhUXBrPNgutMBfweLnVvkb7bBJHMoPIgroMmjX8HGoVmVADcWcIistEEw
         uXYYDa1KS1psrWvVVtOs0rgSeFitvem0kccRf4GTJqac0wDvhbzU5XkEUG4kBmsuCPpO
         3TVE8O1W5th2TGoX/UxMl/9TjJ2yJ/JS09cwEaUi+jKoSLB1klqgU8CKcvkKT9Mr5ypW
         SBlOXZoFNxdqnaBcfC3gu6ZKtSvGaypBIfMp5P2EHoZYUnp1fMqL+AOkv8A70JzWyvz+
         RmNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783065813; x=1783670613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HeKM6E3ikqLN6XP3NncyHeU2nWvurVANKF6w+ddq690=;
        b=XSuMI/yQT3IFP0Hj3kSpmQYLANGAfmwfG4a7T2Ek+cm0nKvGtzelftHlEVkrgMfCy1
         cLqvGQbgep3UoF19L/5gvAf6DC6yKE62lEQXCvmS8CmAnHMNNjdYNU3v2wz6WLqIPsvs
         aFO1Zolv9YL+uMu93qANTwW8Ncmp5wtPzoqxQOVN2AUW83WygpRruKIJJaU7ZGL2/aDd
         CTBbkHvoRL8N7U5TsUNRD8dK4C/U1koE9mRC3wkurq2IeKL6HubyFHYvyb6s1oz7W59W
         zvqiDp5GZYuKrVlnwj4BnC2KzR/SVM41YAwf53+9bKAw2MioMnbsfGCM6jwJsMi4dYaj
         PmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783065813; x=1783670613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HeKM6E3ikqLN6XP3NncyHeU2nWvurVANKF6w+ddq690=;
        b=aQXG2nCk6/brGnRh/kXRPobRl9Dp3j+eR+zkLioFAGAtDr5fyBoPOPV5fQaqjyzHYP
         8BafSFMM4aByWxFIg/b77lE0eg0muTKu6W6J+ZDh0rw7D7WhX/tpXK201SsSUKNto35Q
         +yd7muRaNWPrch5yS54sTws0fIhEjjv0g3/HwXjrrecrlONbWoAlF9U4pMgZTqkusH/c
         eHephPc7O9e2CAz0k8ARbMIcE+/KwRHX1DUKtZdJ3e0TY5JWgULQPct4E+euksLh+QLA
         8mApgCUX3oN25X1JyQJ63z9xcuTMLe0B5rZF8OPyPFOCxxJDe8fhcVDsWUs607oxKV+G
         wCEw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3ZyjLEeGunldN+fP9e8M04al7L0ax6NryJJSujnJddISf2Vq0T91BMVbfJFHmG1lsxMG7i38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7+nQD37qiwYpSWKav4AVzMu05iBSiaSxnOsJ5ev7a/eui98+
	afPDYEf5DkbHba3rrSDotG7WEIZmbkDirpYfkDh8VpnALJfL1tUJB5bchoIxZT9Rq9QoQZGMJub
	He7lzkt2mrcxKHld3wDJl+0odmXzVFp8xIs4PY9NK
X-Gm-Gg: AfdE7clqldL8GHtH45dA0Gw2HfDlnk5sg9BaurUDcrlJGZ864zupipJZ9NMmGWyY6Ir
	1uHUPf2R4qP0Y1mnt/VyG6nU8avmtKFcAy0EX1vYgrAzq3Suz/cYbotRcUq7pYGbcuQyxYVEA/8
	FYJJLyHWJQsEnKXYnWHJyamvwQIaoE/rvgG3rHr7bhUWSDNwse4s3KXk0cdr39JNMSoVyx3HOfR
	lyj54uyFBxNTRoGqgQ6Nq06G33vAeZcRwlCqwrIkQpeml6AYMhlUpxSjXrm7aDQfNNKdPFEQalj
	CrDJinLA5B3Gj7UmCtip9xwOsNCfKLF3OZoogls+SnJSDehlJjnjHKTJamwS3Dw=
X-Received: by 2002:aa7:d04f:0:b0:68a:83c2:9c75 with SMTP id
 4fb4d7f45d1cf-698ad313987mr90294a12.0.1783065812576; Fri, 03 Jul 2026
 01:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701005341.3699161-1-hramamurthy@google.com> <akUUXT6UwTTD2yOs@boxer>
In-Reply-To: <akUUXT6UwTTD2yOs@boxer>
From: Eddie Phillips <eddiephillips@google.com>
Date: Fri, 3 Jul 2026 01:03:20 -0700
X-Gm-Features: AVVi8CfMg_UmMCbmPDneAQPVpYdoK3tz-RuErvKHVuxcH7xgCNjKG9yXtl3SgO8
Message-ID: <CAPBb8HmE6q0VPa5PooFP3VFF27GU3B4622Xww6MHRT-9i4zTxA@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix Rx queue stall on alloc failure
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	sdf@fomichev.me, willemb@google.com, jordanrhee@google.com, nktgrg@google.com, 
	maolson@google.com, jacob.e.keller@intel.com, thostet@google.com, 
	csully@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I think this deserves to be pulled out of the timer logic?

If by this you mean pull the stats into a separate patch, I agree.

> - couldn't you detect this case within napi poll loop?

It can only be detected after attempting to refill the queue and finding
that we are still below the critical threshold.

> - if not, does it have to be per-q timer? wouldn't one global per pf time=
r
>   satisfy your needs?

There are a few ways a global timer could be implemented,
 - The global timer could queue napi for *all* queues, which would
result in a lot of unnecessary work.
 - The global timer could iterate over each queue and try to detect
the critical low buffer condition, however this would require
introducing synchronization between the timer and the napis, which
would introduce expensive locking into the hot path.
 - The global timer could be paired with a bitmap that stores which
queues need to be serviced.

A `struct timer_list` is only 40 bytes, so the current implemention is
not expensive. Though a global timer is valid, it's not strictly better.

That said, I agree that we can clean up the structure=E2=80=94I will move t=
he
timer state from the individual RX rings to the `gve_priv` structure.

On Wed, Jul 1, 2026 at 6:22=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jul 01, 2026 at 12:53:41AM +0000, Harshitha Ramamurthy wrote:
> > From: Eddie Phillips <eddiephillips@google.com>
> >
> > When the system is under extreme memory pressure, page allocations can
> > fail during the Rx buffer refill loop. If the number of buffers posted
> > to hardware falls below a critical low threshold and the refill loop
> > exits due to allocation failures, the queue can stall:
> >
> > 1. The device drops incoming packets because there are no descriptors.
> > 2. Since no packets are processed, no Rx completions are generated.
> > 3. Because no completions occur, NAPI is never scheduled, preventing
> >    the refill loop from running again even after memory is freed.
> >
> > This results in a permanent queue stall.
> >
> > Resolve this by introducing a starvation recovery timer for each Rx que=
ue.
> > If the number of buffers posted to hardware falls below a critical low
> > threshold, start a timer to periodically reschedule NAPI. Once NAPI run=
s
> > and successfully refills the queue above the threshold, the timer is
> > not rescheduled.
> >
> > Also add a new ethtool statistic "rx_critical_low_bufs" to track the
> > number of times the starvation recovery timer is triggered.
>
> I think this deserves to be pulled out of the timer logic?
>
> Two questions tho:
> - couldn't you detect this case within napi poll loop?
> - if not, does it have to be per-q timer? wouldn't one global per pf time=
r
>   satisfy your needs?
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Eddie Phillips <eddiephillips@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h         |  4 ++++
> >  drivers/net/ethernet/google/gve/gve_ethtool.c | 14 +++++++++++++-
> >  drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 32 +++++++++++++++++++=
+++++++++++++
> >  3 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index 2f7bd330..8378bef2 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/net_tstamp.h>
> >  #include <linux/pci.h>
> > +#include <linux/timer.h>
> >  #include <linux/ptp_clock_kernel.h>
> >  #include <linux/u64_stats_sync.h>
> >  #include <net/page_pool/helpers.h>
> > @@ -41,6 +42,7 @@
> >
> >  /* Interval to schedule a stats report update, 20000ms. */
> >  #define GVE_STATS_REPORT_TIMER_PERIOD        20000
> > +#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
> >
> >  /* Numbers of NIC tx/rx stats in stats report. */
> >  #define NIC_TX_STATS_REPORT_NUM      0
> > @@ -318,6 +320,7 @@ struct gve_rx_ring {
> >       u64 rx_copied_pkt; /* free-running total number of copied packets=
 */
> >       u64 rx_skb_alloc_fail; /* free-running count of skb alloc fails *=
/
> >       u64 rx_buf_alloc_fail; /* free-running count of buffer alloc fail=
s */
> > +     u64 rx_critical_low_bufs; /* count of critical low buffer events =
*/
> >       u64 rx_desc_err_dropped_pkt; /* free-running count of packets dro=
pped by descriptor error */
> >       /* free-running count of unsplit packets due to header buffer ove=
rflow or hdr_len is 0 */
> >       u64 rx_hsplit_unsplit_pkt;
> > @@ -334,6 +337,7 @@ struct gve_rx_ring {
> >       struct gve_queue_resources *q_resources; /* head and tail pointer=
 idx */
> >       dma_addr_t q_resources_bus; /* dma address for the queue resource=
s */
> >       struct u64_stats_sync statss; /* sync stats for 32bit archs */
> > +     struct timer_list starvation_timer; /* for queue starvation recov=
ery */
> >
> >       struct gve_rx_ctx ctx; /* Info for packet currently being process=
ed in this ring. */
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/ne=
t/ethernet/google/gve/gve_ethtool.c
> > index a0e0472b..71b6efbf 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > @@ -46,6 +46,7 @@ static const char gve_gstrings_main_stats[][ETH_GSTRI=
NG_LEN] =3D {
> >       "rx_hsplit_unsplit_pkt",
> >       "interface_up_cnt", "interface_down_cnt", "reset_cnt",
> >       "page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt=
",
> > +     "rx_critical_low_bufs",
> >  };
> >
> >  static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] =3D {
> > @@ -58,6 +59,7 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING=
_LEN] =3D {
> >       "rx_xdp_aborted[%u]", "rx_xdp_drop[%u]", "rx_xdp_pass[%u]",
> >       "rx_xdp_tx[%u]", "rx_xdp_redirect[%u]",
> >       "rx_xdp_tx_errors[%u]", "rx_xdp_redirect_errors[%u]", "rx_xdp_all=
oc_fails[%u]",
> > +     "rx_critical_low_bufs[%u]",
> >  };
> >
> >  static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] =3D {
> > @@ -151,12 +153,14 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >  {
> >       u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_b=
ytes,
> >               tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
> > +             tmp_rx_critical_low_bufs,
> >               tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
> >               tmp_tx_pkts, tmp_tx_bytes,
> >               tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
> >       u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit=
_pkt,
> >               rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_p=
kts, tx_bytes,
> > -             tx_dropped, xdp_tx_errors, xdp_redirect_errors;
> > +             rx_critical_low_bufs, tx_dropped, xdp_tx_errors,
> > +             xdp_redirect_errors;
> >       int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
> >       int stats_idx, stats_region_len, nic_stats_len;
> >       struct stats *report_stats;
> > @@ -197,6 +201,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >
> >       for (rx_pkts =3D 0, rx_bytes =3D 0, rx_hsplit_pkt =3D 0,
> >            rx_skb_alloc_fail =3D 0, rx_buf_alloc_fail =3D 0,
> > +          rx_critical_low_bufs =3D 0,
> >            rx_desc_err_dropped_pkt =3D 0, rx_hsplit_unsplit_pkt =3D 0,
> >            xdp_tx_errors =3D 0, xdp_redirect_errors =3D 0,
> >            ring =3D 0;
> > @@ -212,6 +217,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >                               tmp_rx_bytes =3D rx->rbytes;
> >                               tmp_rx_skb_alloc_fail =3D rx->rx_skb_allo=
c_fail;
> >                               tmp_rx_buf_alloc_fail =3D rx->rx_buf_allo=
c_fail;
> > +                             tmp_rx_critical_low_bufs =3D
> > +                                     rx->rx_critical_low_bufs;
> >                               tmp_rx_desc_err_dropped_pkt =3D
> >                                       rx->rx_desc_err_dropped_pkt;
> >                               tmp_rx_hsplit_unsplit_pkt =3D
> > @@ -226,6 +233,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >                       rx_bytes +=3D tmp_rx_bytes;
> >                       rx_skb_alloc_fail +=3D tmp_rx_skb_alloc_fail;
> >                       rx_buf_alloc_fail +=3D tmp_rx_buf_alloc_fail;
> > +                     rx_critical_low_bufs +=3D tmp_rx_critical_low_buf=
s;
> >                       rx_desc_err_dropped_pkt +=3D tmp_rx_desc_err_drop=
ped_pkt;
> >                       rx_hsplit_unsplit_pkt +=3D tmp_rx_hsplit_unsplit_=
pkt;
> >                       xdp_tx_errors +=3D tmp_xdp_tx_errors;
> > @@ -269,6 +277,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >       data[i++] =3D priv->page_alloc_fail;
> >       data[i++] =3D priv->dma_mapping_error;
> >       data[i++] =3D priv->stats_report_trigger_cnt;
> > +     data[i++] =3D rx_critical_low_bufs;
> >       i =3D GVE_MAIN_STATS_LEN;
> >
> >       rx_base_stats_idx =3D 0;
> > @@ -337,6 +346,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >                               tmp_rx_hsplit_bytes =3D rx->rx_hsplit_byt=
es;
> >                               tmp_rx_skb_alloc_fail =3D rx->rx_skb_allo=
c_fail;
> >                               tmp_rx_buf_alloc_fail =3D rx->rx_buf_allo=
c_fail;
> > +                             tmp_rx_critical_low_bufs =3D
> > +                                     rx->rx_critical_low_bufs;
> >                               tmp_rx_desc_err_dropped_pkt =3D
> >                                       rx->rx_desc_err_dropped_pkt;
> >                               tmp_xdp_tx_errors =3D rx->xdp_tx_errors;
> > @@ -381,6 +392,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >                       } while (u64_stats_fetch_retry(&priv->rx[ring].st=
atss,
> >                                                      start));
> >                       i +=3D GVE_XDP_ACTIONS + 3; /* XDP rx counters */
> > +                     data[i++] =3D tmp_rx_critical_low_bufs;
> >               }
> >       } else {
> >               i +=3D priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_rx_dqo.c
> > index 02cba280..303db4fa 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > @@ -18,6 +18,16 @@
> >  #include <net/tcp.h>
> >  #include <net/xdp_sock_drv.h>
> >
> > +static void gve_rx_starvation_timer(struct timer_list *t)
> > +{
> > +     struct gve_rx_ring *rx =3D timer_container_of(rx, t, starvation_t=
imer);
> > +     struct gve_priv *priv =3D rx->gve;
> > +     struct gve_notify_block *block;
> > +
> > +     block =3D &priv->ntfy_blocks[rx->ntfy_id];
> > +     napi_schedule(&block->napi);
> > +}
> > +
> >  static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_=
ring *rx)
> >  {
> >       struct device *hdev =3D &priv->pdev->dev;
> > @@ -120,6 +130,7 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv, in=
t idx)
> >
> >       if (rx->dqo.page_pool)
> >               page_pool_disable_direct_recycling(rx->dqo.page_pool);
> > +     timer_delete_sync(&rx->starvation_timer);
> >       gve_remove_napi(priv, ntfy_idx);
> >       gve_rx_remove_from_block(priv, idx);
> >       gve_rx_reset_ring_dqo(priv, idx);
> > @@ -136,6 +147,8 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv, st=
ruct gve_rx_ring *rx,
> >       u32 qpl_id;
> >       int i;
> >
> > +     timer_shutdown_sync(&rx->starvation_timer);
> > +
> >       completion_queue_slots =3D rx->dqo.complq.mask + 1;
> >       buffer_queue_slots =3D rx->dqo.bufq.mask + 1;
> >
> > @@ -232,6 +245,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
> >       rx->gve =3D priv;
> >       rx->q_num =3D idx;
> >       rx->packet_buffer_size =3D cfg->packet_buffer_size;
> > +     timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0);
> >
> >       if (cfg->xdp) {
> >               rx->packet_buffer_truesize =3D GVE_XDP_RX_BUFFER_SIZE_DQO=
;
> > @@ -365,6 +379,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx=
)
> >       struct gve_rx_compl_queue_dqo *complq =3D &rx->dqo.complq;
> >       struct gve_rx_buf_queue_dqo *bufq =3D &rx->dqo.bufq;
> >       struct gve_priv *priv =3D rx->gve;
> > +     u32 num_bufs_avail_to_hw;
> >       u32 num_avail_slots;
> >       u32 num_full_slots;
> >       u32 num_posted =3D 0;
> > @@ -400,6 +415,23 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *r=
x)
> >       }
> >
> >       rx->fill_cnt +=3D num_posted;
> > +
> > +     /* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> > +      * visible to the hardware, and no doorbell was written, the hard=
ware
> > +      * is in danger of starving and cannot trigger interrupts. Start =
the
> > +      * timer to periodically reschedule NAPI and recover from starvat=
ion.
> > +      */
> > +     num_bufs_avail_to_hw =3D
> > +             ((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> > +              bufq->head) & bufq->mask;
> > +
> > +     if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
> > +             u64_stats_update_begin(&rx->statss);
> > +             rx->rx_critical_low_bufs++;
> > +             u64_stats_update_end(&rx->statss);
> > +             mod_timer(&rx->starvation_timer,
> > +                       jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_=
MS));
> > +     }
> >  }
> >
> >  static void gve_rx_skb_csum(struct sk_buff *skb,
> > --
> > 2.55.0.rc2.803.g1fd1e6609c-goog
> >
> >
