Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0A3CDBA4
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020689; cv=pass; b=l4jE9SIfH11KdcdiNgAby5VE7zgeRxcguPV6ADhDS0oDo69yWj916tBdu4Rn1+28wLNHj+p50qfVMog4zrsN7hdZH6sxC5Xfv7apqOaOEjpSfX74mveiku/4Ylk0tih5oPcUMEGVWvajEIo+4YxlT9UQDsZ592jiZkrxZBbDDyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020689; c=relaxed/simple;
	bh=aVIY0fcdB+TxzKraWgL56vzwXD30AFT+2P7KJPTHESQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ0z84rNEb0O7El/3jyXJRHwebYGuORBr8w2t4OKC1mbF8/vviL4sOQ+UK1WkpRQiHVgRgq/XOw4Qpzc46XEfdsQdiNv8Ly83ExGxFjd1pALzdBm/w1cRXg3xsuwEGRfulWdo0wXGCe/0H6dUUVH4aFaJC2+wU05AsXF4WZKuHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=W+Rm/4q2; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="W+Rm/4q2"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso2511647b3a.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790020685; cv=none;
        d=google.com; s=arc-20260327;
        b=LbtCeB2DiDHeBKfuuKV0hkibQm2QgwQOM128P5ZaKQc6Rj38eOqL/BJqAEx8lIJwa5
         fYO0Een/XbPuWv6UTtp4kPKgSNn+bBvgujWd9ixb4ydqSaMpZitHV7J+ICQ7PbpMGK0K
         /7dX5Atf0SPBZTGN8gCWUPj+UKaFTpgZgzc6hfGBXYCDOMHFxuRqz2G4CvypCbDPYrIv
         wkxkzHSoeLgqXBJGUcjxKp8t9yGvG1pLm+QXs0w0Cl5G+v65Ct6/jnF/nOJeJt51NA8u
         BaxUFY7jIyuXVjatGFe2stqKn4d/2JL//jFiQJRBDa7apbZT0o8txnNmCJYG989HaGet
         Bkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ir8YjhAZ4HBKfv4xjXY9QLHR7YUA9HcIqSwoU+P+HV0=;
        fh=c782wPMUFpLz5LNNdJBrWGju2uzZvokNJt5zh1c9G8E=;
        b=ohzDwNSHv0hjSR8bdfV+lYAjmVNb2pGmCLSF8ol4v1GbiWi4hS44RAZ03MF++FxCOH
         v0YzRDIGNvubwV6O1+tHJu7MYd6vHmf/H4hsGJoyGJ4aQ+mfne8/Ipe5TT+aVKw7yaoB
         r24Sw0Ggn9wBGjNzuAAy69mN77WWluvxGVdmVIw/zskBKwvZHnrPCTbLpE39MmTEhuRV
         Itv0qBdlhgVpG/Ps3czH/Q6Al8Msu2YRZ8oYcr32QcFKrGzNEjtfP2Q2L+k0rr0kFxm1
         1fZG4VZhLOcF7IwFWw0qr8zZab5Iz2zR34UhNuz3TkcD4wqXZws7RJzpEfE9iKYS78ZY
         rgUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790020685; x=1790625485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ir8YjhAZ4HBKfv4xjXY9QLHR7YUA9HcIqSwoU+P+HV0=;
        b=W+Rm/4q2w64AQOlMdLST0LcN7wx+3eVZKaD2KVeA8dvyUcVr/UJvYi107uV0lFgkZT
         QFtImlvuWqvEXGxXB/B+SbUlOwc59wzphjpTJuAn8uYCzvKkLIWI5AdltnWOkqIVUXxS
         vu8rzMWMqpmlftNmbI+fnYSRyGhEb3nPupvIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790020685; x=1790625485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ir8YjhAZ4HBKfv4xjXY9QLHR7YUA9HcIqSwoU+P+HV0=;
        b=QN78d3+vmasBI0gp8kXGz8j4yXrFSgVp6J4WchDfjo5C1nCpYTbdjiB1lzcCsJc2Wb
         6RgPSP32h1Yze/2T+KBG3zvX3ogvhBYb7dFDoqkDZAzoQLyhKEV4rNs/OfNAsLn0Zq/J
         oz66GLcjeouip9rfSX38a6CCDw4MjDs1sHCh+L1r7oCulDxJtP7xQr+snEncGG7MtKmZ
         3MfOV2Ee+dp8koJ4HLdnnE0nlBsUJrRUf8ZUT/1hAzMe2qhSvQGBjJ9MNeNKVzFzu7NB
         Eu0KNOtH8oyoW1RZAT+BtUV14kTn/wFUOetRCpxM35v4UZUVrtf8toZ2Ou9O7gDO1ema
         kZRg==
X-Forwarded-Encrypted: i=1; AKwUvBwB6P+MbG8EV8IlYk7U7r/m5o+s7hTYHOKzb9kBW1LySWdv2L9LDVgkM9HhwcFmYsq+c/SBX10=@vger.kernel.org
X-Gm-Message-State: AFuF++na79YzTJI+Fh13ajD7oMWwHdnF4KZtEM+BjXYiJfvP1ngFMrCJ
	vTTC5v9RBip8FX7mYf0BS2CF2w0ca80ealKT9agf+Rf49/TOfPsqLYylwsNRDiRB6PtHuUEdigD
	kqkOUgg1JdGBp6/vbdq/jFSo/p7bsnTlD8KA/UFqx
X-Gm-Gg: AYBFou2McKwON3zdSnqZFfWIzW3JkbXhNrwOzhK6arSsABGun4up3t28pzegApstX7r
	f29TKubhANQXMujYWMEuarKrzxovkGCqeMOo2p48dvSzoOIO/7iIU7W2PY7vxntTRwgEHfbRqoK
	WoJW5sLo9/rJ2gysO2SPrOWcZMRHAtk8NSbexRyjEKAMWdsw89sgiE8XAPf+XRW+DXLr9mfb37T
	ATJd/Zk61g+YHGo2jKRW2QvnXpPlc0sCvD77xLVQ+yaZxhtTaRoV3jsC1xjWS/uWvhX2Zp10Ssp
	IA/OOH6jR5WNrZU8Piyv6aCWAwUwG4aSahQShkRqAiuWjzmOAR5YunY/KuYCDViM4LGOBnx9w5b
	Rew8nqyy1nK5DLaKSD8hAUitpJy2kYdWu2NT1Hw==
X-Received: by 2002:a05:6a00:c206:b0:877:ec64:dcfb with SMTP id
 d2e1a72fcca58-877ec64e61fmr7175019b3a.16.1790020684726; Mon, 21 Sep 2026
 12:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-9R8V.v1.20260921065103@mojatatu.com> <CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQT9WkQVeeNzNQHqQ@mail.gmail.com>
In-Reply-To: <CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQT9WkQVeeNzNQHqQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 21 Sep 2026 15:57:52 -0400
X-Gm-Features: AcwNN1U0TtrJlJtmcnLvTjC10KotZWlmoXxQK3RjKM6r8C0XrxC13TtwOf5HRGU
Message-ID: <CAM0EoMmzdRYFRvjvTEQM7QsdPRqiVmHg1pHVCObdMTjAKmZP5A@mail.gmail.com>
Subject: Re: [PATCH net] net: cap skb->queue_mapping when the tx queue is picked
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Tonghao Zhang <xiangxia.m.yue@gmail.com>, 
	Zero Day Initiative <zdi-disclosures@trendmicro.com>, hybris <hybris@mojatatu.ai>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:42=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Sep 21, 2026 at 4:02=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > skbedit can set skb->queue_mapping and __dev_queue_xmit() honors it
> > through the skip_txqueue flag; netdev_tx_queue_mapping() clamps the
> > index it uses to select the netdev_queue but leaves the out-of-range
> > value in skb->queue_mapping.
> >
> > Every later consumer of skb_get_queue_mapping()/skb_get_tx_queue() on
> > that path then reads past the device's queues. Taprio's child array
> > q->qdiscs[] is sized to the device's queue count, so taprio_enqueue()
> > indexes past its allocation; qdisc_restart() likewise dereferences
> > dev->_tx[queue_mapping].
> >
> > A local user in a network namespace can redirect a packet from a device
> > with more TX queues to one with fewer (mirred action) after setting a
> > mapping valid only on the larger device. That reaches these reads and,
> > under KASAN, faults with "slab-out-of-bounds in taprio_enqueue".
> >
> > Store the clamped value back into skb->queue_mapping, as
> > netdev_core_pick_tx() already does for the mapping it picks, so the
> > whole egress path observes an in-range queue index.
> >
> > I have looked at other alternative places to put this "fix", none
> > appealing: an out-of-range queue_mapping is read by every consumer
> > on the xmit path, not just by taprio. For example, upon testing
> > an approach that only bounds-checked taprio_enqueue() I observed
> > the fault relocated to sch_direct_xmit()/qdisc_restart() instead
> > (because dev->_tx[queue_mapping] is still indexed with the raw value).
> > Another approach was to cap it in skbedit;  cannot work: the
> > redirect target, whose queue count bounds the mapping, is not known
> > when the action runs, and act_mirred sets skb->dev afterwards.
> > So the decision is to cap the value where it is first trusted and
> > result is it fixes all downstream readers at once.
> >
> > Conditions to recreate the bug: with CONFIG_NET_SCH_TAPRIO=3Dy,
> > CONFIG_NET_ACT_SKBEDIT=3Dy, CONFIG_NET_ACT_MIRRED=3Dy and KASAN enabled=
,
> > create a 3-queue dummy qa and a 2-queue dummy qb, put a taprio root on
> > qb, then on qa's clsact add matchall with "action skbedit queue_mapping
> > 2 pipe action mirred egress redirect dev qb" and send one packet out
> > qa. Mapping 2 is valid for qa but past qb's two-entry taprio child
> > array.
> >
> > Reproduction: reproducer ran on a KASAN build with panic_on_warn=3D1:
> > the unfixed control faults with "BUG: KASAN: slab-out-of-bounds in
> > taprio_enqueue", a read 0 bytes past a 16-byte taprio_init allocation,
> > and panics.
>
> I do not think this reproducer works. mirred egress redirect re-enters
> __dev_queue_xmit() for qb, which does netdev_xmit_skip_txqueue(false)
> before sch_handle_egress(). qb has no egress filter here, so
> netdev_tx_queue_mapping() is not called for qb at all, and
> netdev_core_pick_tx() rewrites skb->queue_mapping in range before
> taprio_enqueue() runs.
>

The repro from zdi works (and produced the kasan) - but i think you
caught a bad description on how to reproduce.
It reads like it is two devices but it is infact 3:

  qa (3 queues) - clsact egress matchall:
          action skbedit queue_mapping 2 pipe
           action mirred egress redirect dev qb
  qb (2 queues, taprio root) - clsact egress matchall:
       action mirred egress mirror dev qc
  qc (1 queue) - clsact egress matchall:
       action skbedit queue_mapping 0 pipe

The KASAN trace shows exactly that stack (tcf_mirred_act ->
tcf_skbedit_act on qc, then taprio_enqueue on the outer qb xmit).

At a minimum, the commit log needs fixing to describe as above:

> I suspect the real issue is that the per-cpu flag is cleared *before*
> sch_handle_egress(), so a nested dev_queue_xmit() (mirred mirror, or a
> drop after skbedit) can set it and have the *outer* __dev_queue_xmit()
> consume it, for an skb that never went through skbedit.

That could be the root cause or part of it....

> For a forwarded
> packet, skb->queue_mapping is then still skb_record_rx_queue()'s
> rx_queue + 1 from the ingress NIC. That reaches taprio with a garbage
> index, and clamping it only hides the fact that an innocent packet got
> pinned to a random TX queue.
>
> If that is confirmed, I would rather consume the flag where it is read:
>
>     skip_txq =3D netdev_xmit_txqueue_skipped();
>     netdev_xmit_skip_txqueue(false);
>
> right after sch_handle_egress(), dropping the pre-clear. Same number of
> stores, and the request can no longer escape the xmit that set it.
>

I believe your suggestion would fix the poc repro but opens other issues.

How about: save it, clear it before sch_handle_egress(), and restore
it on every exit? Something like:

        skip_txq =3D netdev_xmit_txqueue_skipped();
        netdev_xmit_skip_txqueue(false);
        ...
        skb =3D sch_handle_egress(skb, &rc, dev);
        if (!skb) {
                netdev_xmit_skip_txqueue(skip_txq);
                goto out;
        }
        ...
        if (netdev_xmit_txqueue_skipped())
                txq =3D netdev_tx_queue_mapping(dev, skb);
        netdev_xmit_skip_txqueue(skip_txq);


> Also, taprio_enqueue() is the only qdisc indexing a num_tx_queues sized
> array with skb->queue_mapping. A bounds check there is free and worth
> having regardless.

Likely missing something: how will taprio code be hit if we cover the
egress direction hole above?

cheers,
jamal
