Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793694812;
	b=WnKEHNZaTiYe0T4gDWV4CPaKudV1vI47ge3y2R9fYmwNJCnahrshgv5vUTtng0huI7fS
	 I5vmAC/OeGJIB/Jo/ZXobxHi/PDFqRCKadwkuj+sZVMNFzvjX4EAbzdTJVq6FLxv4AAFZ
	 W4hMG9B/vqvHZacR5odwdRfjToEf8WHDWxp/vwdnQwR5ZFIXfFa4g+nXfH3DN+3Ocgswq
	 Eg/eQ8VHXHqS1DFx/AxUqV8de6yvIrw8aZD2F+F06KIdduqlG5l6CcG56EKq2b6dt9730
	 2oeRZnlOtVfoWQu2krKG8aFT3zJlNetPr6F0VuCo6ao41Pe0O0iT0ao+T5mL8dBbvdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ns5UrpFr+nBqk8VeozAAQ/bQgy/bCK+3qJvpw6jQboQ=;
	b=TThXGzkm7zCy/gv7v4W7K64t3ab+Dw/GhmVmb3K6H0v7T/p19FvaWFuT4OE0ALcyAjGb
	 dnQoayGV+QFbERnZwBe8ZTlnS8MCIBO+uOjoP23/Kgq9ekQMnKTBs/gP0R5ZLV/zkajrf
	 VnZ6Rmi4K6LfQnP2yg8iVymdNv3KhSHbgiQsTF1VcOfE88yrtufILw45JfT6qCOKLN0xf
	 srJY3MpPyVxWtYTHpPGiKOr68m9EUTg4OQg45Gbhxrf+LJGb02/DxRL5Y98lX8qChT4v1
	 3VaEDN7nBYyghBDfgDgsIVAYAT6N8IC9A0NgkIVgcWRdagzhtnXhAg/VolWk3H6D7yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="d4V/cwWM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CF606EE8D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E4CF606EE8D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d4V/cwWM
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e95bd1c14cso35464675ad.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:33:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793694810; cv=none;
        d=google.com; s=arc-20260327;
        b=ly0I72COeFuGmKZCXGxjA1TARuFbKunDQO8v7xduu4gOsZazy815JL/wQywcuovIGV
         I3caQHksIWy9k0xQzS1LiojZ7CbKNjAXtM9rP31n3k/2841/v6U/UewsA/WNL6J5vxYD
         y+BE1Tfa7EpFUnQHwRJUuC61GWd7YcQ7zShgLXKBAT40NHYgBTwdclzSxziwglZd7DlP
         zoXDmSTU5SNce/IsDEPHQQPSA9tjTUlZo3jembsKETSZSyJq1+ZcE0mPSy0X2Gh8i8Bs
         SRWYwyvghKcHsaolT8pN7vmTWVePk3XZAl8TS24aWEdFpKIO8LMNi7PTHHYj9PMuiRjG
         mSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ns5UrpFr+nBqk8VeozAAQ/bQgy/bCK+3qJvpw6jQboQ=;
        fh=c8Y4N+DQmmLBwI1xYQmpYbV6TzPiiNQmIErPkVbva7g=;
        b=N0RqQgQK0L9A+eZWsRsdT5T2bff6ltxSI9pEl7om+lEdB/2SCWxXBnBnvEU3vP+cZV
         ImoxaulEdEI4ZrNxKIh47wuqeqePTmYjpbiw+jLFLt4bbLFFqrQTIMykYMlN8e0JDS0g
         D6Xg47tW3nV8JwAsJtcmAtM0t+Z+08fi8d1LjtZt2cHi0HRM62tnqpwPkrn12yaTKSSS
         XTq6T/HDRENcaMDKaZ2DmeNxxkBtZAKR8UcqHZAGpcdd6K9E+261r28QpwIFFoMHwOfS
         wjn/cYLwnxY2IJkZx/HHV/WeGGogtWPXT5+4cwDJRp1pgyrVcWBIc8Qpap+K2PlfwFdo
         K9Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793694810; x=1794299610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ns5UrpFr+nBqk8VeozAAQ/bQgy/bCK+3qJvpw6jQboQ=;
        b=d4V/cwWMXr7n6exLZLA1MpGqLFb3geTN023uWwcKZA3/hpIRx8OHoTvQ9ri2Pe8SE+
         8JCRsjlAyliZR9iF6Tu5MqDeAPS9caRk6SyULSMZUavYoiXfGNwRhsjEJ1vPqKGh1I6R
         2PfbEERtyXgZglZ5k6D4pAdMUB+hrBF4VkNm3YkOtvupEr9O7G85Gu7V3RJEDxEf0ddB
         AJwLGe2OnNOc6kPro4NAubMZr0fh82ORA2DYIpAkkDBmfSZMqprADjxSUyfNBlIhYwLa
         eP/aM1Sn8q2/EPPapW+a8N7RbOSCx4Sj7fZXTEYw9lRkx5lSwrmvpniLFM8p2Fh4MYOv
         /n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694810; x=1794299610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ns5UrpFr+nBqk8VeozAAQ/bQgy/bCK+3qJvpw6jQboQ=;
        b=doaFdme55wzi07QNIU5f7BTcaMx7wTSbYvO2lVxOvSGMCrTjcHhTjFG6LEzzqt0sIF
         0WQy6MJYMM/XmW5tYoznXUlIhNPcKgkLWVz8n1fdAfpsQoM6qt9bykQ4tdGJTpZ06WF2
         l/+rMgUe6Z8ZqVWoklmYg5JP9IIKmVC8E8YCGyPSmXYhRgirz66W3kc5JEjG7ETcRJAl
         8huLvavIY8AALtt3wx0v0yVwpVjJtc4DbkoAko1ZQI7k0qmuuKjHucVhXhgCmwAg9e7k
         h7n9S2wiZCa5XI68MwqX4imNJvh09fKiTtQXgoCJ3m2p0hvLUH4u5fdiofiFF6+8pQW3
         6zQA==
X-Forwarded-Encrypted: i=1; AKwUvBwgAIh2aaVKCZfsr6go7AGOKPOk0pPVcFoFDWIYUpEPoSZatZUmLnjpckFTOu8hVKJHwLE82Yc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LY8qYvq+4mTTTU45DVRixWvek/l21kCKSAP0pg2cqMumfzCUj
	axjGkrQbb9V7katBDOInZCGmx/Co+mcaWwGeHYS8Igv5ZJjwbgxAy3B6XVMNX2HMQNLW9iK88ET
	/nXLZUvJyErOnmHfOtf4nnhxXCfk8jM1NIzbMo2mY
X-Gm-Gg: AYBFou0lqraSOVZL949UMoF8ri6IHM2ag27Xj/mcICefl9S3CJaxG8G9BGBJnvpqmeB
	yMI6siyAediEJDz3r+bCr+ab/N7uWSFW7rNpa+itQR43yEHM58klYyqbaGXpEQZoXHA2w6YpmYl
	7YLsYAyStJ06ASJ3Y/Gcw5CtTJsHQcXZ5rUPGmBl0S+G7n6fDhMmlWU21KMlDUSXfm9DCo16mFO
	AuMaSxcdQO22nU0Uu5f07rgtf9ya0f5PjJd825YYtfUao28ouy/+83w8Zr5Mbty/2cOSNVHYS2h
	qeg+6W2wLh1HBKaUlO3157eQBy6wTEyjwG+sfn9jx59CLyjV/uYDPdOFrgIUaQwGo16ZUs9mJJ6
	+ESWEGEPeww+Eua4MM9733+xIrEOQF7tudmle
X-Received: by 2002:a17:903:1c1:b0:2e9:6333:fbb8 with SMTP id
 d9443c01a7336-2eb364936fcmr122129865ad.12.1793694809842; Tue, 03 Nov 2026
 00:33:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029211634.2232784-2-hramamurthy@google.com> <179365431852.3131.15974768163319773656@kernel.org>
In-Reply-To: <179365431852.3131.15974768163319773656@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 3 Nov 2026 00:33:18 -0800
X-Gm-Features: AclHuK822Wf9DTeUoa6mUrIKemK_tfGKzjcfqPnGUM0p_VrNgJWlcfcDSwcas6o
Message-ID: <CAHwYsirZ8CpNL4QA_ie9EX6WCs=Waq9F3JsPXL+LYPjx=RJ7ZA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/4] gve: Fix race between stats query and queue reconfig
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, jordanrhee@google.com, willemb@google.com, 
	przemyslaw.kitszel@intel.com, nktgrg@google.com, maolson@google.com, 
	jacob.e.keller@intel.com, pkaligineedi@google.com, yangchun@google.com, 
	patricion@google.com, awogbemila@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 1:18=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] At this commit, the new priv->stats_lock is not taken by the
>   single-queue (queue-mgmt API) writers of priv->rx[idx].
> - [Medium] At this commit, the device-level qstats totals drop to 0 once
>   the interface is down.
>
> --
>
> gve: Fix race between stats query and queue reconfig
>
> This commit adds priv->stats_lock to serialize the stats readers
> (gve_get_stats(), gve_handle_report_stats() and the per-queue qstats
> callbacks) against queue teardown in gve_queues_mem_remove(). Queue
> pointers are now cleared under the lock before the ring memory is freed.
> The per-queue callbacks also return early when priv->rx or priv->tx is
> NULL.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2437cd8ba6331..26fdd22644f4d 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -69,6 +69,7 @@ static void gve_get_stats(struct net_device *dev, str=
uct rtnl_link_stats64 *s)
> >       int num_tx_queues;
> >       int ring;
> >
> > +     spin_lock_bh(&priv->stats_lock);
> >       num_tx_queues =3D gve_num_tx_queues(priv);
> >       if (priv->rx) {
> >               for (ring =3D 0; ring < priv->rx_cfg.num_queues; ring++) =
{
>
> [Severity: Medium]
> Does stats_lock cover every writer of priv->rx[idx]? The single-queue
> restart path still rewrites the ring contents without taking the lock,
> and priv->rx stays non-NULL the whole time:
>
> drivers/net/ethernet/google/gve/gve_main.c:gve_rx_queue_stop() {
>     ...
>         gve_per_q_mem =3D (struct gve_rx_ring *)per_q_mem;
>         *gve_per_q_mem =3D priv->rx[idx];
>         memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
>         return 0;
> }
>
> drivers/net/ethernet/google/gve/gve_main.c:gve_rx_queue_start() {
>     ...
>         gve_per_q_mem =3D (struct gve_rx_ring *)per_q_mem;
>         priv->rx[idx] =3D *gve_per_q_mem;
>     ...
> abort:
>     ...
>         memset(&priv->rx[idx], 0, sizeof(priv->rx[idx]));
>         return err;
> }
>
> These run under rtnl and the instance lock. gve_get_stats() (via
> ndo_get_stats64) and gve_handle_report_stats() (from the stats report
> worker) hold neither of those. They only take stats_lock.
>
> Suppose a devmem, XSK or page-pool queue restart races with a read of
> /proc/net/dev or with the stats report worker. Could the reader then see
> a partly copied or zeroed ring, including its statss? It would then
> report torn rpackets, rbytes, desc.seqno or fill_cnt values.
>
> The readers only copy scalar counters, so this looks like wrong
> statistics, not memory corruption.
>
> The later patch in this series, "gve: Fix backward stats when interface
> goes down or configuration is adjusted", wraps these writes in
> spin_lock_bh(&priv->stats_lock). This patch is tagged for stable. Would
> it make sense to move that part into this patch?

Agreed. We will move the spin lock to this patch in v5.
>
> [ ... ]
>
> > @@ -2786,9 +2796,15 @@ static void gve_get_rx_queue_stats(struct net_de=
vice *dev, int idx,
> >                                  struct netdev_queue_stats_rx *rx_stats=
)
> >  {
> >       struct gve_priv *priv =3D netdev_priv(dev);
> > -     struct gve_rx_ring *rx =3D &priv->rx[idx];
> > +     struct gve_rx_ring *rx;
> >       unsigned int start;
> >
> > +     spin_lock_bh(&priv->stats_lock);
> > +     if (!priv->rx)
> > +             goto unlock;
> > +
>
> [Severity: Medium]
> When the interface is down, this early return (and the matching one in
> gve_get_tx_queue_stats()) leaves rx_stats and tx_stats untouched.
> netdev_nl_stats_add() then skips them as NETDEV_STAT_NOT_SET. At this
> commit gve_get_base_stats() still reports zero:
>
> static void gve_get_base_stats(struct net_device *dev,
>                                struct netdev_queue_stats_rx *rx,
>                                struct netdev_queue_stats_tx *tx)
> {
>         rx->packets =3D 0;
>         rx->bytes =3D 0;
>         rx->alloc_fail =3D 0;
>
>         tx->packets =3D 0;
>         tx->bytes =3D 0;
> }
>
> After some traffic and then ip link set dev down, does the device-level
> qstats total drop from the live counters to 0? That looks like it would
> still fail check_down() in tools/testing/selftests/drivers/net/stats.py.
> That check requires every qstats key to be non-decreasing across ifdown.
>
> The NULL dereference is fixed, but the totals now go backwards. The next
> patch in the series, "gve: Fix backward stats when interface goes down
> or configuration is adjusted", seems to fix this. It folds the ring
> counters into priv->base_net_stats and priv->base_ring_err_stats in
> gve_queues_mem_remove() and reports them from gve_get_base_stats().
>
> Given the stable tag, is it intended that this patch alone leaves the
> qstats totals non-monotonic across ifdown?

Yes, this is intended. This patch focuses on fixing the kernel panic
and the next patch addresses the stats values across ifdown.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029211634.2232784-1-hramamurthy%40google.com

Regards,
Pin-yen

---

pw-bot: cr
