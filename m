Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793694817;
	b=uSEvu5rHWRSsz8CXPVVzlwckGecCfQ1wfknCvufWwQyVYg+ichmjrCgbD45uykmLDOaG
	 SmdCas3c4ivV/5k8nxxA61pVLMH5FYUeIjgz5ET6RnTKt06YwrWiErcYJqZeVXtiEwW2e
	 CmwWYsr34zsRYQpVnEeauM7x3J9+83OyMS01xu+cWqPl7i06fXPSQbMBWpDChazAGDIKO
	 RZ1nF+kKZLwqjaboa+RdYe6Fp3Xik8ayCX+aqJXN1VT8F1eleWEkADU1gyszz7yi4GkM+
	 u59qED1W4ds0+vUcHXG8XO3Qm3xup22WrW4Gpk1pWbzyzE43/ZborwItbNfBbn8PIKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ED+K93Toiwvb7ixUy1Vb7Gi9Hcj/hDm1vxqzJpoVcq0=;
	b=Db15WrrBj+g7mKS9GaVVPawijEq0YifNiQ7b832UPUHXrZafVQcmmSDTeeM8Hdzq64Jd
	 5VMu+X1tAa9GrWIDvdQH5uzzqS/ir5ZGptom1P2pOlkAE3I9hb3NGlTOBmWZpxNXILEjK
	 w10xMu7c989Opdligu22C5XeGM5+cWh2SSvau98We+dKyaBc4/gLGUWxQRJqeqUdTC6LT
	 WsesyTsrqBJrYa54HfI0vG7wIyaOCsHLbAaOe54Rxt9sIU1DuqvrE5p/WhNOIcob902ql
	 RxsdGdEIhjMNYZXHJDI6BX2sAdj2bcenFqwra63h11THXGMBzr/Y49+ahPuUhoNzpDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ic7SHQHw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A96076B94
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B61A96076B94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ic7SHQHw
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06210b29fso1635143b3a.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793694816; cv=none;
        d=google.com; s=arc-20260327;
        b=kHWcQOQ78OFW/6gJWTDV2maYkDCc22mCUomFlTzTS4Z5/sNQMXA80ZHwqiOFP6kg/o
         8JipOPDJ/mIHxRL+QUjqQnupyLfytAqJ8X8rEsK3IdPMpQIYI91a8BgNo72ZYicvX5tu
         YOfrlbWNhwyRDsdCmdE1NfUd/aBQVhSH2qDaP27UCQLwcuS5axGbiWSgAj47qneHnkB1
         BAAeCFeekQNURL7BfXB+p/EG2/lcuwCvbrDu32hMNRcBPr4V3aPUhHG5EdWQe2MDnEaQ
         1Cq8l/jh9oj3Iidod2KVPwV1t9W3l5IWD1xcbHT4OVj+adbzIdZbjvMOwwr1+y4cJh5o
         BNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ED+K93Toiwvb7ixUy1Vb7Gi9Hcj/hDm1vxqzJpoVcq0=;
        fh=U535YCosauhPQ2LvWus4uOUbVQMuD71nXV0ASoafj4k=;
        b=CO0dtHtC4Uv4oMaY+lKJWrF/VqdY0eklcre6/qROxB/cHNxnSVyEIos7RLS3EY06gu
         4HpE9lZ2uTNTwJe1F0wmUGI0yk/lMBbrwChp5w9ckE/rxcqDerGU2alcqdnOg4YSpAlL
         iSx1EaFyWzv9DELJsuQrCEsF9qFov97OPO44haqpp3dDNxFvmw6ZRfKBTH0qIdl6qcby
         IsgxTPpmXih7qiE90v75QYDKEwWiPQlcQEwAzMujbKcMtod5eYNcs1gin07ksLuwS88y
         U8xEEXvBYmnuDS2VOU+RmjPhO5PgI7XM9witv0MRMO9CVUU1u+NbUTaqy5Q/9XDA6Koq
         3R6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793694816; x=1794299616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ED+K93Toiwvb7ixUy1Vb7Gi9Hcj/hDm1vxqzJpoVcq0=;
        b=ic7SHQHw19m3HA1kpS+jGBES4EzxGyStBqNW0b5xP0jHqwOEO+jv2OaN4MDW0sYKnS
         RzL7lp7IMQwwu9Zc9XS6qAkjqcIMFgWLTQl5LAgeuDKCttaboGKWdJEEYTTSzAjHuabP
         SDZtAaBdzEyzexaT5gWW+CEH7AEfwUPyksNlUlaXixg+XFGXC0RW81gds2NO5P7059bO
         INIREr4tDb0WfbuHxKQ8ZAtz5t7ns39YTPVanZYFsMMUyl+TNegaEHJCmW34L4idJTM5
         Pckn/6sRnRJMfL3MYh9zGTSYyh/o7Wlwh2f9ss+GsUPRKzqLoxDpAg2mqIFkAmERtcGL
         3czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694816; x=1794299616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ED+K93Toiwvb7ixUy1Vb7Gi9Hcj/hDm1vxqzJpoVcq0=;
        b=FN9Xu1C8ixhr9qeaxro01Xq8Z6+Cpcc51nlngYZJUtm13wHMTfW4Fa5u6vAGlfgH7O
         NHouMaFK8o5K5+b9h/6SeyN7HKT0hMb7MqUhdb5YddV+MM0uhxuQMlgDMoIpL7gebNjE
         wITXymqnDKlk8fLyVOpayQfaAfHZJgRkUDimz9BewuEtSQJawxAeBbezqxte77YTiGUR
         ve6Zx90ALnbHepPE3YoGjPxrYad5cHt1v3j4XTWaIzrl8BqhkEce09AEKtvjjNEfbcmn
         YR9S2HxbrggtugHgl/rrIK4CMiOFg4atYC3q0ENLsNGWg0H547c1i1c9O5HqsO+XKyRW
         4ClA==
X-Forwarded-Encrypted: i=1; AKwUvBw6bvzja3pvxs2PvXFxhXAtaCoJQMQ5WAdqu9+Ax0acRuipfHW52+qv0pnIhmG2DHiMjRA0G1c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q6XSp5/EShi5Ei4bofThjb4H17a2VKZNhfNO2sXGX1zg0FPoR
	rDMR3rE50xvulPJ9NZqaEPTYJ8Bpwc05u238XiQiBix7tv9GhmuNUb5vmAC0oS9F35dk+lLJMnb
	VQULUS0gDot30NtdZuf6COIOj/4M3M73C9WNrr7a9
X-Gm-Gg: AYBFou1RJ7RDzLR1HXFbIyKN2d+AF0/91Dx1QM8wLQ/wTo10jD6M2HzwDwq8bVMNeUU
	T1fM2s1i+wtGGDbladOJAMaK/pOr37dWQVGiTugKuq6mYzGi4Ya4mlzbLe8cvT0psvSO+tn5NpR
	2WOS1TbzvGsOPnSfQ7jywdL2hHMfi3rdAHKC5FheK/Gckh8KDEtopW1sNNFRAtFM1F75l2mJ2OB
	pQSzRn2sJR6FIObyr4LgTPl9+VkLK+KNIZ0c9vnpRIRAJ84MqAkZXrjL0SH9s45iALGji9CzaE7
	2hWNsT26r7T78dzHYytOdjicEyZI9lPg0K7JAVIzM05epVmCHGnW+1s0PfIET/QiHlwRi0IoejU
	WcSzvZflAJ+yHspnYxybdJojl7PLcfNq1Tq8n
X-Received: by 2002:a05:6a21:7988:b0:3e2:2234:62a with SMTP id
 adf61e73a8af0-3e928dcd3d8mr8688389637.55.1793694815413; Tue, 03 Nov 2026
 00:33:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029211634.2232784-3-hramamurthy@google.com> <179365432027.3131.11809571157881551820@kernel.org>
In-Reply-To: <179365432027.3131.11809571157881551820@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 3 Nov 2026 00:33:24 -0800
X-Gm-Features: AclHuK-uTwRUWqjeH6O0SjydL7KmsN4mH1_Yc-h01HcY9iplIbcgjsLNyxbxyTY
Message-ID: <CAHwYsioiPrbhRNQgqywB=TFqTExwPT6UYFVOx4ZBn-yYyzauHw@mail.gmail.com>
Subject: Re: [PATCH net v4 2/4] gve: Fix backward stats when interface goes
 down or configuration is adjusted
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
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The commit message and the Fixes tag describe only part of what
>   the patch changes.
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but on 32-bit
>   SMP kernels tx->statss of an XDP TX ring has writers that are not=E2=80=
=A6
> - [Low] This problem wasn't introduced by this patch, but check_down() in
>   tools/testing/selftests/drivers/net/stats.py has the docstring "Test=E2=
=80=A6
> - [Low] This problem wasn't introduced by this patch, but
>   pkt_byte_sum.stat_cmp() in=E2=80=A6
> - [Low] This problem wasn't introduced by this patch, but the single-
>   queue RX restart path never calls u64_stats_init() on the new ring's=E2=
=80=A6
> - [Low] This problem wasn't introduced by this patch, but
>   gve_rx_post_buffers_dqo() updates rx->statss (rx_buf_alloc_fail)=E2=80=
=A6
>
> --
>
> gve: Fix backward stats when interface goes down or configuration is adju=
sted
>
> This patch keeps baseline rx/tx packet, byte and alloc-fail counters in
> gve_priv. They are saved during full queue teardown in
> gve_queues_mem_remove() and during a single RX queue stop in
> gve_rx_queue_stop(). Both ndo_get_stats64 and the netdev_stat_ops base
> stats report these baselines, and gve_get_base_stats() also reports the
> live XDP TX ring counters.
>
> > gve_get_base_stats() sets all the stats to 0, so the stats go backwards
> > when interface goes down or configuration is adjusted.
>
> [ ... ]
>
> > Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
>
> [Severity: Low]
>
> Does this description cover everything the patch changes? The message
> blames gve_get_base_stats(). The patch also changes ndo_get_stats64:
> gve_get_stats() now calls gve_add_base_stats().
>
> That part fixes an older bug. In the tree before 2e5e0932dff5,
> gve_close() already freed the rings on every ifdown:
>
> gve_close()
>     gve_queues_stop(priv);
>     gve_queues_mem_remove(priv);
>
> gve_queues_mem_remove() set priv->tx and priv->rx to NULL, and
> gve_get_stats() only summed the live rings. So the ip -s link and
> /proc/net/dev counters already went back to 0 on ifdown.
> Documentation/networking/statistics.rst says:
>
>   Statistics must persist across routine operations like bringing the
>   interface down and up.
>
> Could the changelog mention the rtnl counter change, and could the
> Fixes: tag be revisited? With the current tag, stable backporters may
> treat trees without netdev_stat_ops (older than 6.13) as unaffected,
> even though they have the rtnl reset on ifdown.

Yes, ndo_get_stats64 has dropped to 0 on ifdown since commit
f5cedc84a30d ("gve: Add transmit and receive support"). We will
mention the ndo_get_stats64 counters in the commit message and add a
Fixes tag for it in v5.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 26fdd22644f4d..b5e2f39a903c5 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -84,19 +112,41 @@ static void gve_get_stats(struct net_device *dev, =
struct rtnl_link_stats64 *s)
>
> [ ... ]
>
> > +static void gve_get_stats(struct net_device *dev, struct rtnl_link_sta=
ts64 *s)
> > +{
> > +     struct gve_priv *priv =3D netdev_priv(dev);
> > +
> > +     spin_lock_bh(&priv->stats_lock);
> > +     gve_get_ring_stats(priv, s);
> > +     gve_add_base_stats(priv, s);
> >       spin_unlock_bh(&priv->stats_lock);
> >  }
>
> [Severity: Low]
>
> This is a pre-existing issue and was not introduced by this patch. The
> commit message cites the check_down test case in
> tools/testing/selftests/drivers/net/stats.py. Its docstring says:
>
>     """ Test statistics (interface and qstat) are not impacted by ifdown =
"""
>
> However, check_down() only compares qstats from netfam.qstats_get()
> before and after ip link set down. It never reads the rtnl stats64.
>
> If the new gve_add_base_stats() call in gve_get_stats() regressed,
> wouldn't check_down() still pass?
>
> [ ... ]
>
> > @@ -2744,7 +2809,9 @@ static int gve_rx_queue_start(struct net_device *=
dev,
> >               return -EAGAIN;
> >
> >       gve_per_q_mem =3D (struct gve_rx_ring *)per_q_mem;
> > +     spin_lock_bh(&priv->stats_lock);
> >       priv->rx[idx] =3D *gve_per_q_mem;
> > +     spin_unlock_bh(&priv->stats_lock);
>
> [Severity: Low]
>
> This isn't a bug introduced by this patch, but is rx->statss ever
> initialized on the single-queue restart path?
>
> gve_rx_queue_mem_alloc() calls gve_rx_alloc_ring_gqi() or
> gve_rx_alloc_ring_dqo(), which zero the ring. The only u64_stats_init()
> calls for RX rings are in gve_init_sync_stats():
>
>         for (i =3D 0; i < priv->rx_cfg.num_queues; i++)
>                 u64_stats_init(&priv->rx[i].statss);
>
> That function only runs on a full queue start. gve_rx_queue_start() then
> copies the uninitialized statss into priv->rx[idx].
>
> On 32-bit kernels with CONFIG_DEBUG_LOCK_ALLOC, the seqcount's lockdep
> map is never initialized. Can later stats updates or reads then trigger
> lockdep warnings? The stats_lock added around this copy doesn't change
> that.
>
> [Severity: Low]
>
> This is also a pre-existing issue and not introduced by this patch. Later
> in gve_rx_queue_start(), the DQO path calls gve_rx_post_buffers_dqo()
> from preemptible process context:
>
>         else
>                 gve_rx_post_buffers_dqo(&priv->rx[idx]);
>
> When a buffer allocation fails, that function writes rx->statss:
>
>                 if (unlikely(gve_alloc_buffer(rx, desc))) {
>                         u64_stats_update_begin(&rx->statss);
>                         rx->rx_buf_alloc_fail++;
>                         u64_stats_update_end(&rx->statss);
>
> On 32-bit non-RT kernels, __u64_stats_update_begin() uses
> preempt_disable_nested(). That only asserts that preemption is already
> disabled; it does not disable it.
>
> If the writer is preempted while the sequence is odd, can a reader on
> the same CPU spin until the writer runs again? gve_get_stats() under
> spin_lock_bh(&priv->stats_lock) is one such reader. Lockdep builds would
> also warn here. gve_create_rings() reaches the same code regardless of
> this patch.
>
> [ ... ]
>
> > @@ -2844,12 +2913,30 @@ static void gve_get_base_stats(struct net_devic=
e *dev,
> >                              struct netdev_queue_stats_rx *rx,
> >                              struct netdev_queue_stats_tx *tx)
> >  {
>
> [ ... ]
>
> > +     tx->packets =3D base_stats->tx_packets;
> > +     tx->bytes =3D base_stats->tx_bytes;
> > +     /* XDP TX rings are not exposed as netdev queues, so report their=
 live
> > +      * counters here to keep the device totals consistent with
> > +      * ndo_get_stats64.
> > +      */
> > +     if (priv->tx)
> > +             gve_add_tx_ring_range_stats(priv, priv->tx_cfg.num_queues=
,
> > +                                         gve_num_tx_queues(priv),
> > +                                         &tx->packets, &tx->bytes);
> > +     spin_unlock_bh(&priv->stats_lock);
> >  }
>
> [Severity: Low]
>
> This is a pre-existing issue in the selftest and was not introduced by
> this patch. Does pkt_byte_sum() in stats.py really check that these
> totals match ndo_get_stats64? stat_cmp() returns at the first key that
> differs:
>
>     def stat_cmp(rstat, qstat):
>         for key in ['tx-packets', 'tx-bytes', 'rx-packets', 'rx-bytes']:
>             if rstat[key] !=3D qstat[key]:
>                 return rstat[key] - qstat[key]
>         return 0
>
> With live TX traffic, a correctly increasing tx-packets decides the
> result before tx-bytes or the RX counters are compared. The test can
> therefore pass while rtnl and qstats disagree in the later fields. That
> includes the XDP TX contribution added here.
>
> [Severity: Medium]
>
> This isn't a bug introduced by this patch, but are the writers of
> tx->statss on the XDP TX rings serialized on 32-bit SMP kernels?
>
> gve_xdp_xmit_dqo() picks the ring as smp_processor_id() %
> num_xdp_queues, so several CPUs can share one ring. It updates statss
> after releasing the lock that serializes those CPUs:
>
>         spin_unlock(&tx->dqo_tx.xdp_lock);
>
>         u64_stats_update_begin(&tx->statss);
>         tx->xdp_xmit +=3D n;
>         tx->xdp_xmit_errors +=3D n - i;
>         u64_stats_update_end(&tx->statss);
>
> gve_xdp_xmit() in gve_tx.c does the same after
> spin_unlock(&tx->xdp_lock). gve_clean_tx_done_dqo() also updates the
> same statss from NAPI:
>
>         u64_stats_update_begin(&tx->statss);
>         tx->bytes_done +=3D pkt_compl_bytes + reinject_compl_bytes;
>         tx->pkt_done +=3D pkt_compl_pkts + reinject_compl_pkts;
>
> Could overlapping write_seqcount_begin()/end() calls tear the 64-bit
> reads? Could they lose a sequence increment and leave the count odd? If
> so, the retry loop in gve_add_tx_ring_range_stats() would spin forever
> with stats_lock held and BH disabled.
>
> gve_get_stats() and gve_get_ethtool_stats() already read these counters
> before this patch, so the new reader in gve_get_base_stats() neither
> creates nor widens the exposure. Hitting it needs a 32-bit kernel and
> XDP_REDIRECT into gve from several CPUs while completions are running.

All the other comments are pre-existing issues and out of scope for this se=
ries.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029211634.2232784-1-hramamurthy%40google.com

Regards,
Pin-yen
