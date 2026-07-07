Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FB42F71F
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445357; cv=pass; b=mthW0uwiSMorTdOLD7m3Kdu+Kgl0qNrbqVyB2chy6/d1ughxpWjcWZJKjxlGgsyWSqKW7AKWLBDML+c1nl3WKedeBeMPcNQcjep0DLH7HMWeYjLsRLaOBuWEBI58HcOSytLtosfd+B991RVuts/W1Mw0B8CLVTQdgwHEnKjd2nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445357; c=relaxed/simple;
	bh=LdM5/5j6tLIVGE8Dtf0f7z51xlY8G2r0NqbfkAC/psE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYcTaSPhdlnJxgVN2gcylWnmnobawMxq8DMBpcIkmhTur5IzXWW2xjWOeAgergdA0pjGjmgMmj/79OB2YwczSqhDwPppRatBJTWSJbMmx1GH9F69sJsAQDBAVDqvp0VkGJgrh5OFA8ZasW12QY57vJYLBWSHQQ5iNFNsbkuaVCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRq+0mVP; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRq+0mVP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69a45011a92so528a12.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 10:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783445354; cv=none;
        d=google.com; s=arc-20260327;
        b=JkLRqtXzrZZI91iHHh64Y+JYnqDwRmT6MPEdMkwCBR5DmWVgs+3nD8QZzfop3MsVhZ
         00DjOfKM9lRfTc3MnMzzH5grcUM5ryf+aB+HSGtBTTN9fUaN3KZQCmIDr2U+/YyPOXhv
         u57FlRf3HUxDFZ74IkBjAGklw3Oxy3dvuHM/NW61Z8upz2C27aZ3tHy/T8glj2/P8a9h
         Pmv/T/1yCK55GlhOz91QNgDQecw7odb4nvHMfms7vhTtE1PW+h0Xdj7zSlaqSh7ykt9M
         kVAsxeMr5LH7gsDmx7sNEyM7/0Fdd14VpDT804u3+x2AMMtbAG3n+r8qt4gm9vn08WKI
         NA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R9+puYpU/OAIOlXh/vX1cEz2KQswQg6IKDFW850iusY=;
        fh=smbcDgKNgeNR+1mZzNPZc8uBq+3/NLuvr1oCocuDNKI=;
        b=nUbGAUBqNEO3RoSalJvi0yxlohOQUwRtTjSrPo6otT1/eSDxtnPAIp+7Xi51EGnbbh
         Qj/pnKW5Tti5RE2pL5i7oro7XNsFE7U0RBx5OtVvKaAWoUbbqZs/wkshaOVjt/N5GUox
         CzEl2FLueQtSCyR5R4XrDToGdC8agqp68XbNDErTJ+50mk1P/5G1ILZ8JivqrDJdSM4v
         qkiQ49hpiZMBGzLtU49I23tWlHT1K7oDsp9dGTtx8pIq/LwiRKPJr6cCUGZRzRhaPVsj
         s0HjG1KRKdeiZWiq7+84HzQFfRXtq5+54PlkaWLWk6SaBIBpWGsRonK9VReymBmosz3k
         Juig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783445354; x=1784050154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R9+puYpU/OAIOlXh/vX1cEz2KQswQg6IKDFW850iusY=;
        b=CRq+0mVPUF5qsYVpSVphwQvx3rOLXQIOUkLnWuzwmhVTzEegQI7ehS+pE2M0LuaOIu
         NW6DGkcGyNyE77I9HydpJ+lSPpK9soyickncF6cHmmt2qCdk2K0SsO+NzRSM0KR1jPGY
         cEeA5hvuNRhc75cb4m1sO3cMM2L+7RFqK5BQxNFI7rdGPvGbWclfBWYkgzux/qgMv25J
         LKhdNwpNSPu6dWSceSmRfFKjuX/Rdui3BwbL3/16br1SeIeau1UMHNMdzIO/R/0w+8j5
         4JV/pG1cwwJ+BO3hv3EaaLAvGpBHYcEV4Mi3b6Rcq2tla9qDFuaL/VArSA1tle1Rdjqh
         r4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783445354; x=1784050154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9+puYpU/OAIOlXh/vX1cEz2KQswQg6IKDFW850iusY=;
        b=N6GMRUZOfTmZkFucw+FI8iDwsvNlniuPBgu+x/n4kLggZ0EWqDdPnCWzezYpKKdV0f
         twpRChYaFvGfF4gzF26SZ0FmBr3CLyk+142vtWs6rTU0JYokbd/Ct7MdZJIGNGkLN3ZX
         NMgfTxpLlAARm7AbAILf6M/XRwqHsHfSiywokgwVKBP3tBN25H2maJdbBwYLTHsgRoOt
         hAqd0bCCRragrdOypUWem9TOnZDPSW+7HY3WBIbeibG5MHls2UG3BZ0cgxOC9NvlgIdb
         Kyhp0LBDmzOcwK4CAyqawn1VGUnhqXt34uf+oxH5JuEzO1a91XFP12T8pVQdEocOuneX
         MWpA==
X-Forwarded-Encrypted: i=1; AHgh+RpJqdUZ0BrcWguyr7kFEfWWsmBnkK77mxec5ooZ5oSHVwVAk7MY1cq5FT6R/6v6kt5EUgda69o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjElCEsKP3izCS2Yt1lSU3KYJpD38wQCNVqxr/AJWIbH3g/942
	5mvu/KZSx33+3pqUIF+cuSCYMaFg56xGc/g0/muPGAxP76Jfg3qHl3+vwzm6gJPaXxzHY6dLsWU
	BMeKCVlDIZjh2zyH+k8pDdQi0yUW3k5pPOemx+puE
X-Gm-Gg: AfdE7cn+9u4uMn8GKlkjQQWXlILNhNtixaNDqkVdjl7Ut0fgCVEqQ2Cr9LIN7aPdsTx
	YEP7QSTR57MMV742oZg9gHCA2b1t1Po4avDyzaygsGeC2hE1i/OGEhiI20cM4bZyNcsTRc48Sgy
	EdRynVunWHO0f7VPhJ1ViEBwZBcyjcrylQ5s+FO/j2xL5EwOH8rMMsnNvNm3XoSf5cudajuvvTw
	Nz5XhwX4UQGIzAp2M4OySY0Qi1a82B89NApS2Dq8brz0miFTDDWbkHXscHaJOzq6I0B1+S6Hdrm
	n2Nwazv024Om4I2ZJ/IgaQfhcB24T8US0PbqL/Bs8Po+Vz8aT60wotQHZOeAWLo9PKo1CQ==
X-Received: by 2002:a50:8dc6:0:b0:697:5678:bc77 with SMTP id
 4fb4d7f45d1cf-69a913a7174mr50992a12.9.1783445353396; Tue, 07 Jul 2026
 10:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701005341.3699161-1-hramamurthy@google.com>
 <akUUXT6UwTTD2yOs@boxer> <CAPBb8HmE6q0VPa5PooFP3VFF27GU3B4622Xww6MHRT-9i4zTxA@mail.gmail.com>
 <akfd5abdGbxFl5o9@boxer>
In-Reply-To: <akfd5abdGbxFl5o9@boxer>
From: Eddie Phillips <eddiephillips@google.com>
Date: Tue, 7 Jul 2026 10:28:59 -0700
X-Gm-Features: AVVi8CfQdeyc6oT5h76mUfXFmGQ8R5NspkTFlVUAfIYShJRZEj_0O5OBCArmKxA
Message-ID: <CAPBb8HnXL-G692yRZYatA2m=X_YpNWG2eDhQzzM+Enq1apyC8Q@mail.gmail.com>
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

On Fri, Jul 3, 2026 at 9:06=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 01:03:20AM -0700, Eddie Phillips wrote:
> > > I think this deserves to be pulled out of the timer logic?
> >
> > If by this you mean pull the stats into a separate patch, I agree.
>
> Hi Eddie,
>
> instead of forming a response at the top of the mail, please have your
> answers inlined; it is preferred way of communication on mailing lists.
>
> >
> > > - couldn't you detect this case within napi poll loop?
> >
> > It can only be detected after attempting to refill the queue and findin=
g
> > that we are still below the critical threshold.
> >
> > > - if not, does it have to be per-q timer? wouldn't one global per pf =
timer
> > >   satisfy your needs?
> >
> > There are a few ways a global timer could be implemented,
> >  - The global timer could queue napi for *all* queues, which would
> > result in a lot of unnecessary work.
> >  - The global timer could iterate over each queue and try to detect
> > the critical low buffer condition, however this would require
> > introducing synchronization between the timer and the napis, which
> > would introduce expensive locking into the hot path.
> >  - The global timer could be paired with a bitmap that stores which
> > queues need to be serviced.
>
> bitmap would probably do the job but i won't insist here tho.
>
> One more question/idea:
> Before arming the starvation timer, could we first try to make a smaller =
batch
> of already-posted buffers visible to HW?

The maximum number of descriptors that a single RSC packet can consume
is 19, so 8 descriptors isn't enough to receive a maximum-sized RSC
packet. If the hardware runs out of buffers, it is supposed to close
the RSC window and flush the descriptors, but operating this close to
the hardware's limits could be risky in case there are HW bugs or edge
cases we're unaware of. I think building in a safety margin would be more
robust.

> It seems the HW can accept RX buffer tail doorbell updates at a granulari=
ty
> lower than the normal `GVE_RX_BUF_THRESH_DQO` batching threshold, apparen=
tly as
> low as 8 descriptors. If that is the case, could we first use this as an
> emergency low-watermark path: when refill posts at least 8 descriptors bu=
t does
> not reach the normal 32-descriptor threshold, ring the doorbell immediate=
ly and
> only arm the starvation timer if even that lower threshold cannot be reac=
hed?
>
> >
> > A `struct timer_list` is only 40 bytes, so the current implemention is
> > not expensive. Though a global timer is valid, it's not strictly better=
.
> >
> > That said, I agree that we can clean up the structure=E2=80=94I will mo=
ve the
> > timer state from the individual RX rings to the `gve_priv` structure.
> >
> > On Wed, Jul 1, 2026 at 6:22=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, Jul 01, 2026 at 12:53:41AM +0000, Harshitha Ramamurthy wrote:
> > > > From: Eddie Phillips <eddiephillips@google.com>
> > > >
> > > > When the system is under extreme memory pressure, page allocations =
can
> > > > fail during the Rx buffer refill loop. If the number of buffers pos=
ted
> > > > to hardware falls below a critical low threshold and the refill loo=
p
> > > > exits due to allocation failures, the queue can stall:
> > > >
> > > > 1. The device drops incoming packets because there are no descripto=
rs.
> > > > 2. Since no packets are processed, no Rx completions are generated.
> > > > 3. Because no completions occur, NAPI is never scheduled, preventin=
g
> > > >    the refill loop from running again even after memory is freed.
> > > >
> > > > This results in a permanent queue stall.
> > > >
> > > > Resolve this by introducing a starvation recovery timer for each Rx=
 queue.
> > > > If the number of buffers posted to hardware falls below a critical =
low
> > > > threshold, start a timer to periodically reschedule NAPI. Once NAPI=
 runs
> > > > and successfully refills the queue above the threshold, the timer i=
s
> > > > not rescheduled.
> > > >
> > > > Also add a new ethtool statistic "rx_critical_low_bufs" to track th=
e
> > > > number of times the starvation recovery timer is triggered.
> > >
> > > I think this deserves to be pulled out of the timer logic?
> > >
> > > Two questions tho:
> > > - couldn't you detect this case within napi poll loop?
> > > - if not, does it have to be per-q timer? wouldn't one global per pf =
timer
> > >   satisfy your needs?
> > >
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> > > > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > > > Signed-off-by: Eddie Phillips <eddiephillips@google.com>
> > > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > > ---
> > > >  drivers/net/ethernet/google/gve/gve.h         |  4 ++++
> > > >  drivers/net/ethernet/google/gve/gve_ethtool.c | 14 +++++++++++++-
> > > >  drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 32 +++++++++++++++=
+++++++++++++++++
> > > >  3 files changed, 49 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/et=
hernet/google/gve/gve.h
> > > > index 2f7bd330..8378bef2 100644
> > > > --- a/drivers/net/ethernet/google/gve/gve.h
> > > > +++ b/drivers/net/ethernet/google/gve/gve.h
> > > > @@ -13,6 +13,7 @@
> > > >  #include <linux/netdevice.h>
> > > >  #include <linux/net_tstamp.h>
> > > >  #include <linux/pci.h>
> > > > +#include <linux/timer.h>
> > > >  #include <linux/ptp_clock_kernel.h>
> > > >  #include <linux/u64_stats_sync.h>
> > > >  #include <net/page_pool/helpers.h>
> > > > @@ -41,6 +42,7 @@
> > > >
> > > >  /* Interval to schedule a stats report update, 20000ms. */
> > > >  #define GVE_STATS_REPORT_TIMER_PERIOD        20000
> > > > +#define GVE_RX_NAPI_RESCHED_MS 20 /* msecs */
> > > >
> > > >  /* Numbers of NIC tx/rx stats in stats report. */
> > > >  #define NIC_TX_STATS_REPORT_NUM      0
> > > > @@ -318,6 +320,7 @@ struct gve_rx_ring {
> > > >       u64 rx_copied_pkt; /* free-running total number of copied pac=
kets */
> > > >       u64 rx_skb_alloc_fail; /* free-running count of skb alloc fai=
ls */
> > > >       u64 rx_buf_alloc_fail; /* free-running count of buffer alloc =
fails */
> > > > +     u64 rx_critical_low_bufs; /* count of critical low buffer eve=
nts */
> > > >       u64 rx_desc_err_dropped_pkt; /* free-running count of packets=
 dropped by descriptor error */
> > > >       /* free-running count of unsplit packets due to header buffer=
 overflow or hdr_len is 0 */
> > > >       u64 rx_hsplit_unsplit_pkt;
> > > > @@ -334,6 +337,7 @@ struct gve_rx_ring {
> > > >       struct gve_queue_resources *q_resources; /* head and tail poi=
nter idx */
> > > >       dma_addr_t q_resources_bus; /* dma address for the queue reso=
urces */
> > > >       struct u64_stats_sync statss; /* sync stats for 32bit archs *=
/
> > > > +     struct timer_list starvation_timer; /* for queue starvation r=
ecovery */
> > > >
> > > >       struct gve_rx_ctx ctx; /* Info for packet currently being pro=
cessed in this ring. */
> > > >
> > > > diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/driver=
s/net/ethernet/google/gve/gve_ethtool.c
> > > > index a0e0472b..71b6efbf 100644
> > > > --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> > > > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > > > @@ -46,6 +46,7 @@ static const char gve_gstrings_main_stats[][ETH_G=
STRING_LEN] =3D {
> > > >       "rx_hsplit_unsplit_pkt",
> > > >       "interface_up_cnt", "interface_down_cnt", "reset_cnt",
> > > >       "page_alloc_fail", "dma_mapping_error", "stats_report_trigger=
_cnt",
> > > > +     "rx_critical_low_bufs",
> > > >  };
> > > >
> > > >  static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] =3D {
> > > > @@ -58,6 +59,7 @@ static const char gve_gstrings_rx_stats[][ETH_GST=
RING_LEN] =3D {
> > > >       "rx_xdp_aborted[%u]", "rx_xdp_drop[%u]", "rx_xdp_pass[%u]",
> > > >       "rx_xdp_tx[%u]", "rx_xdp_redirect[%u]",
> > > >       "rx_xdp_tx_errors[%u]", "rx_xdp_redirect_errors[%u]", "rx_xdp=
_alloc_fails[%u]",
> > > > +     "rx_critical_low_bufs[%u]",
> > > >  };
> > > >
> > > >  static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] =3D {
> > > > @@ -151,12 +153,14 @@ gve_get_ethtool_stats(struct net_device *netd=
ev,
> > > >  {
> > > >       u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hspl=
it_bytes,
> > > >               tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
> > > > +             tmp_rx_critical_low_bufs,
> > > >               tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pk=
t,
> > > >               tmp_tx_pkts, tmp_tx_bytes,
> > > >               tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
> > > >       u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_uns=
plit_pkt,
> > > >               rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, =
tx_pkts, tx_bytes,
> > > > -             tx_dropped, xdp_tx_errors, xdp_redirect_errors;
> > > > +             rx_critical_low_bufs, tx_dropped, xdp_tx_errors,
> > > > +             xdp_redirect_errors;
> > > >       int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
> > > >       int stats_idx, stats_region_len, nic_stats_len;
> > > >       struct stats *report_stats;
> > > > @@ -197,6 +201,7 @@ gve_get_ethtool_stats(struct net_device *netdev=
,
> > > >
> > > >       for (rx_pkts =3D 0, rx_bytes =3D 0, rx_hsplit_pkt =3D 0,
> > > >            rx_skb_alloc_fail =3D 0, rx_buf_alloc_fail =3D 0,
> > > > +          rx_critical_low_bufs =3D 0,
> > > >            rx_desc_err_dropped_pkt =3D 0, rx_hsplit_unsplit_pkt =3D=
 0,
> > > >            xdp_tx_errors =3D 0, xdp_redirect_errors =3D 0,
> > > >            ring =3D 0;
> > > > @@ -212,6 +217,8 @@ gve_get_ethtool_stats(struct net_device *netdev=
,
> > > >                               tmp_rx_bytes =3D rx->rbytes;
> > > >                               tmp_rx_skb_alloc_fail =3D rx->rx_skb_=
alloc_fail;
> > > >                               tmp_rx_buf_alloc_fail =3D rx->rx_buf_=
alloc_fail;
> > > > +                             tmp_rx_critical_low_bufs =3D
> > > > +                                     rx->rx_critical_low_bufs;
> > > >                               tmp_rx_desc_err_dropped_pkt =3D
> > > >                                       rx->rx_desc_err_dropped_pkt;
> > > >                               tmp_rx_hsplit_unsplit_pkt =3D
> > > > @@ -226,6 +233,7 @@ gve_get_ethtool_stats(struct net_device *netdev=
,
> > > >                       rx_bytes +=3D tmp_rx_bytes;
> > > >                       rx_skb_alloc_fail +=3D tmp_rx_skb_alloc_fail;
> > > >                       rx_buf_alloc_fail +=3D tmp_rx_buf_alloc_fail;
> > > > +                     rx_critical_low_bufs +=3D tmp_rx_critical_low=
_bufs;
> > > >                       rx_desc_err_dropped_pkt +=3D tmp_rx_desc_err_=
dropped_pkt;
> > > >                       rx_hsplit_unsplit_pkt +=3D tmp_rx_hsplit_unsp=
lit_pkt;
> > > >                       xdp_tx_errors +=3D tmp_xdp_tx_errors;
> > > > @@ -269,6 +277,7 @@ gve_get_ethtool_stats(struct net_device *netdev=
,
> > > >       data[i++] =3D priv->page_alloc_fail;
> > > >       data[i++] =3D priv->dma_mapping_error;
> > > >       data[i++] =3D priv->stats_report_trigger_cnt;
> > > > +     data[i++] =3D rx_critical_low_bufs;
> > > >       i =3D GVE_MAIN_STATS_LEN;
> > > >
> > > >       rx_base_stats_idx =3D 0;
> > > > @@ -337,6 +346,8 @@ gve_get_ethtool_stats(struct net_device *netdev=
,
> > > >                               tmp_rx_hsplit_bytes =3D rx->rx_hsplit=
_bytes;
> > > >                               tmp_rx_skb_alloc_fail =3D rx->rx_skb_=
alloc_fail;
> > > >                               tmp_rx_buf_alloc_fail =3D rx->rx_buf_=
alloc_fail;
> > > > +                             tmp_rx_critical_low_bufs =3D
> > > > +                                     rx->rx_critical_low_bufs;
> > > >                               tmp_rx_desc_err_dropped_pkt =3D
> > > >                                       rx->rx_desc_err_dropped_pkt;
> > > >                               tmp_xdp_tx_errors =3D rx->xdp_tx_erro=
rs;
> > > > @@ -381,6 +392,7 @@ gve_get_ethtool_stats(struct net_device *netdev=
,
> > > >                       } while (u64_stats_fetch_retry(&priv->rx[ring=
].statss,
> > > >                                                      start));
> > > >                       i +=3D GVE_XDP_ACTIONS + 3; /* XDP rx counter=
s */
> > > > +                     data[i++] =3D tmp_rx_critical_low_bufs;
> > > >               }
> > > >       } else {
> > > >               i +=3D priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
> > > > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers=
/net/ethernet/google/gve/gve_rx_dqo.c
> > > > index 02cba280..303db4fa 100644
> > > > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > > > @@ -18,6 +18,16 @@
> > > >  #include <net/tcp.h>
> > > >  #include <net/xdp_sock_drv.h>
> > > >
> > > > +static void gve_rx_starvation_timer(struct timer_list *t)
> > > > +{
> > > > +     struct gve_rx_ring *rx =3D timer_container_of(rx, t, starvati=
on_timer);
> > > > +     struct gve_priv *priv =3D rx->gve;
> > > > +     struct gve_notify_block *block;
> > > > +
> > > > +     block =3D &priv->ntfy_blocks[rx->ntfy_id];
> > > > +     napi_schedule(&block->napi);
> > > > +}
> > > > +
> > > >  static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve=
_rx_ring *rx)
> > > >  {
> > > >       struct device *hdev =3D &priv->pdev->dev;
> > > > @@ -120,6 +130,7 @@ void gve_rx_stop_ring_dqo(struct gve_priv *priv=
, int idx)
> > > >
> > > >       if (rx->dqo.page_pool)
> > > >               page_pool_disable_direct_recycling(rx->dqo.page_pool)=
;
> > > > +     timer_delete_sync(&rx->starvation_timer);
> > > >       gve_remove_napi(priv, ntfy_idx);
> > > >       gve_rx_remove_from_block(priv, idx);
> > > >       gve_rx_reset_ring_dqo(priv, idx);
> > > > @@ -136,6 +147,8 @@ void gve_rx_free_ring_dqo(struct gve_priv *priv=
, struct gve_rx_ring *rx,
> > > >       u32 qpl_id;
> > > >       int i;
> > > >
> > > > +     timer_shutdown_sync(&rx->starvation_timer);
> > > > +
> > > >       completion_queue_slots =3D rx->dqo.complq.mask + 1;
> > > >       buffer_queue_slots =3D rx->dqo.bufq.mask + 1;
> > > >
> > > > @@ -232,6 +245,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv=
,
> > > >       rx->gve =3D priv;
> > > >       rx->q_num =3D idx;
> > > >       rx->packet_buffer_size =3D cfg->packet_buffer_size;
> > > > +     timer_setup(&rx->starvation_timer, gve_rx_starvation_timer, 0=
);
> > > >
> > > >       if (cfg->xdp) {
> > > >               rx->packet_buffer_truesize =3D GVE_XDP_RX_BUFFER_SIZE=
_DQO;
> > > > @@ -365,6 +379,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring=
 *rx)
> > > >       struct gve_rx_compl_queue_dqo *complq =3D &rx->dqo.complq;
> > > >       struct gve_rx_buf_queue_dqo *bufq =3D &rx->dqo.bufq;
> > > >       struct gve_priv *priv =3D rx->gve;
> > > > +     u32 num_bufs_avail_to_hw;
> > > >       u32 num_avail_slots;
> > > >       u32 num_full_slots;
> > > >       u32 num_posted =3D 0;
> > > > @@ -400,6 +415,23 @@ void gve_rx_post_buffers_dqo(struct gve_rx_rin=
g *rx)
> > > >       }
> > > >
> > > >       rx->fill_cnt +=3D num_posted;
> > > > +
> > > > +     /* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descript=
ors
> > > > +      * visible to the hardware, and no doorbell was written, the =
hardware
> > > > +      * is in danger of starving and cannot trigger interrupts. St=
art the
> > > > +      * timer to periodically reschedule NAPI and recover from sta=
rvation.
> > > > +      */
> > > > +     num_bufs_avail_to_hw =3D
> > > > +             ((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> > > > +              bufq->head) & bufq->mask;
> > > > +
> > > > +     if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
> > > > +             u64_stats_update_begin(&rx->statss);
> > > > +             rx->rx_critical_low_bufs++;
> > > > +             u64_stats_update_end(&rx->statss);
> > > > +             mod_timer(&rx->starvation_timer,
> > > > +                       jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESC=
HED_MS));
> > > > +     }
> > > >  }
> > > >
> > > >  static void gve_rx_skb_csum(struct sk_buff *skb,
> > > > --
> > > > 2.55.0.rc2.803.g1fd1e6609c-goog
> > > >
> > > >
