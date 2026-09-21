Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EB47886E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001761; cv=pass; b=Yk7uREUKquWXaYOHVQsceA/RkCGxoltY6P6gg0RAM73f88EFalLeaaSriRSEYXyr8HnrphLiWHPSuK39cP0MCL7MrzukjiB1bKiu0gKLFdUzYvYOmmKNHOGyQazGkO8Fvjq5b20QXC0vTAoruw5RERsWRxogqYKkVcWjPyUs93k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001761; c=relaxed/simple;
	bh=kbZaopDYBVMx85fKsqs4rCEG1F3x+bxLKSSwopPsKYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQozifUeSsy/sccf/4x4/MoeT4EqCP4+HIxE7poJ9u6MQegMz0/4/3sEsV9jCQcB4oHRMxAdja57qd7uXwd2LI/91xJ+WLCmbvzzvUxcRwMhfgDbbLkrb3e06i0p+GRUZREAJNa60RLUZzvwX9hjYxGXu8HGqQ4XWm6YpzilsnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQlfERhl; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQlfERhl"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb767cc7fso25527481cf.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790001758; cv=none;
        d=google.com; s=arc-20260327;
        b=F1mlBRMXXKJWTQ3ZlxKnqBryVsSdkNogV12mcmbo7wzagleBS5La0Hr9IdN7AvWJKV
         V5ZYagumjVObWLLGPR2AMx1R8VgRljoWJkYCqavOrPYuyv79IX4C8PRpmKri3udyc5fp
         zT7GFaHBA+FDVxjEgaHtZQve7XYGAVBYIPQ3Wg5HuwKdHADPFHO/0KuxQZdAcqBp8zF1
         +2rL8pm4/6mkLixsO4LXHO/AAPtzYPULypKmaamVWcMA2WeXCqT8c4SK0CnfGcaC/KH0
         3/fT7uiD8lDtXoafHht93Znmu+bWHhh29jEM7pAZqmQ21aSCUtKYotA6rPUdsC43gqda
         kEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+yrdrELMZyL9v2+cXbL2/rgwUQ0W15U+RDCD6OYCG/k=;
        fh=L/Z4cVEGZ80kfyDE6OhCYbCxO8e0NlE7p8JN+Y4XxJM=;
        b=TFxbh6RctJTZFGqrf31VnJtDHYVBysUPb3KhgkwTTUH7vlMKV+164j96XovDK2ERML
         nUBjMN4KJ4a+TzhpZKehr0mR0fB6dz4izZC4GEBgfX8IXqI9Qxr9k6gQcdvPghJmltmS
         4kpDt4dYW/5I1nt5f0sgZSwprCxmQ6KhWDyTELUAXDTChRGvX8K0qDWeypi8oMYuHF29
         YOoPXMvk3eGwevElRE8iczlip2V68TFH/CvcDMKVgCNRhWu8tsMGw6vKDt8mMW7DCLi3
         U3JhFhWY7pCOrPZQ/2+OLbhLqP92qTQcZB0PDwoS9U3t9DKFcG52rxmjyoU4uQ0zNyuc
         kl7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790001758; x=1790606558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+yrdrELMZyL9v2+cXbL2/rgwUQ0W15U+RDCD6OYCG/k=;
        b=PQlfERhlNQf3oW28MUrjQRbCYdQ2JxnSsRRNOkAx35tryCDd9Ed7rHgN6s+OLCQDMb
         CLe/lJNvfUb9+sD5bwK8Y5wpHYUHcil53nHxVvtUi+myinbUTBLf3POei+pF6oo9EUNh
         8MhIEDGL/KrreH6DcKs3b+auU1gB/zWBtYeBRNeO1VD7mpHcWnbjkW8OwQ7f8lA1oWP5
         QZn/YJNX3Ke4neO5r6hp8R2G+gKHpn6qhBwzuiCYdM8vzyTROjiT+Dng8ZhgtRYX3qDm
         ZfDn7nhLCnNp+xe21V9nm9OArgQFQFZaYLy2k7NKAS51hvbekZXlR27EmPxdfpFJsm1d
         YLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001758; x=1790606558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yrdrELMZyL9v2+cXbL2/rgwUQ0W15U+RDCD6OYCG/k=;
        b=c7FoEWl+nV9HAMN8rEwpAkAkTg48jTDXsU9xlrS/FalpWvfUD0NJ2Svf1OkKjRguec
         MHBeOGHSdZk5BZWbg/AciyfrCfoNddlJ4rOPsuqdRpiP1zINAPKoOyF4PQsG2lDpFaWN
         ztA1nTZX032UsZ1f3w6uG5WM88Z7DAQzFm74F2bkUboZIp8ssBmeoJIZlFudqfpxSHWJ
         jh2vzysfB/TmayXf5R5MDgAe/KsHqJqM/ZLzEyzWZI7YS89NQIjcUBcfWeAnd97aXcFc
         p/g/bTpWmnKAiYfr70P4zHZmj8RAK6TvscGxAb1PNIHYWIMSuPx8hFo4tMyTrXuUplbc
         hLVg==
X-Forwarded-Encrypted: i=1; AKwUvBzLijrYXnf5z5Ar+2IDMWjdU44iqVJOpyHhRBwdQZm8+7fhx554W4WmyaYipA+wYM1/cLDOxhM=@vger.kernel.org
X-Gm-Message-State: AFuF++lrOJU3zAbq4I1Ldw3zpKEGL7lHaenS2CF1mdo/3OqLOOswWb/4
	QOczeM6kiGDQm1ObvRMTnfDD1sN+ty8cKgPUx0ZXTm4FmNc1SnXuCNK9pWWfpls6tdQKKEkhKEF
	SCnlPKUIZUiKVQRdqHdYkT1v9sqHvFAnfYqPyGhpe
X-Gm-Gg: AYBFou2jLJdmrHvcRtj6K1WlaYgt9M+d3y9eMqwXHyhsihZhblVGcwX7H9xY7zkfysj
	zbvqlhygfosjtKPdYgZP18W3D0PXHUmU0Uc+mRi14jc7M/6yvnW5/e2c3bAKrePWZX1r3mtDhtW
	PfmSlB21qiyzfOZ/gKCi+Be5WCTYShMUnkENWv/fWLH/bDx21dqLwbNkMkkeXZfoB16vegcIeS5
	dHZYrZVS8cntbIIiogqY+h6mkW7TaNsgKjmfdZgnhDsUwVxdYofJN9SdO0MFoG7b3C5g8f/O51J
	vZuTqjZP3eEplDMHBdzFhtYekTe5T3XhVsdcKh5YDYXflsg7XHOI9vdFotjep0h94UDmSmvqGJw
	W1I+GIJWNPbZ0B4zij22wYDIMon+MszyvsLaPy9gEntwkxpHoY1g2q773ZBYpTBW8XVOGbg==
X-Received: by 2002:ac8:5e0c:0:b0:51c:d1c:10e3 with SMTP id
 d75a77b69052e-532d8e3854emr9389261cf.35.1790001757788; Mon, 21 Sep 2026
 07:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-9R8V.v1.20260921065103@mojatatu.com>
In-Reply-To: <QDISC-9R8V.v1.20260921065103@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Sep 2026 16:42:26 +0200
X-Gm-Features: AcwNN1U98nW-4BMQAAQSJtgmzufGlXOEVZ058mnNWvJvlgkpIL02Q-3ZtJajOv4
Message-ID: <CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQT9WkQVeeNzNQHqQ@mail.gmail.com>
Subject: Re: [PATCH net] net: cap skb->queue_mapping when the tx queue is picked
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Tonghao Zhang <xiangxia.m.yue@gmail.com>, 
	Zero Day Initiative <zdi-disclosures@trendmicro.com>, hybris <hybris@mojatatu.ai>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:02=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> skbedit can set skb->queue_mapping and __dev_queue_xmit() honors it
> through the skip_txqueue flag; netdev_tx_queue_mapping() clamps the
> index it uses to select the netdev_queue but leaves the out-of-range
> value in skb->queue_mapping.
>
> Every later consumer of skb_get_queue_mapping()/skb_get_tx_queue() on
> that path then reads past the device's queues. Taprio's child array
> q->qdiscs[] is sized to the device's queue count, so taprio_enqueue()
> indexes past its allocation; qdisc_restart() likewise dereferences
> dev->_tx[queue_mapping].
>
> A local user in a network namespace can redirect a packet from a device
> with more TX queues to one with fewer (mirred action) after setting a
> mapping valid only on the larger device. That reaches these reads and,
> under KASAN, faults with "slab-out-of-bounds in taprio_enqueue".
>
> Store the clamped value back into skb->queue_mapping, as
> netdev_core_pick_tx() already does for the mapping it picks, so the
> whole egress path observes an in-range queue index.
>
> I have looked at other alternative places to put this "fix", none
> appealing: an out-of-range queue_mapping is read by every consumer
> on the xmit path, not just by taprio. For example, upon testing
> an approach that only bounds-checked taprio_enqueue() I observed
> the fault relocated to sch_direct_xmit()/qdisc_restart() instead
> (because dev->_tx[queue_mapping] is still indexed with the raw value).
> Another approach was to cap it in skbedit;  cannot work: the
> redirect target, whose queue count bounds the mapping, is not known
> when the action runs, and act_mirred sets skb->dev afterwards.
> So the decision is to cap the value where it is first trusted and
> result is it fixes all downstream readers at once.
>
> Conditions to recreate the bug: with CONFIG_NET_SCH_TAPRIO=3Dy,
> CONFIG_NET_ACT_SKBEDIT=3Dy, CONFIG_NET_ACT_MIRRED=3Dy and KASAN enabled,
> create a 3-queue dummy qa and a 2-queue dummy qb, put a taprio root on
> qb, then on qa's clsact add matchall with "action skbedit queue_mapping
> 2 pipe action mirred egress redirect dev qb" and send one packet out
> qa. Mapping 2 is valid for qa but past qb's two-entry taprio child
> array.
>
> Reproduction: reproducer ran on a KASAN build with panic_on_warn=3D1:
> the unfixed control faults with "BUG: KASAN: slab-out-of-bounds in
> taprio_enqueue", a read 0 bytes past a 16-byte taprio_init allocation,
> and panics.

I do not think this reproducer works. mirred egress redirect re-enters
__dev_queue_xmit() for qb, which does netdev_xmit_skip_txqueue(false)
before sch_handle_egress(). qb has no egress filter here, so
netdev_tx_queue_mapping() is not called for qb at all, and
netdev_core_pick_tx() rewrites skb->queue_mapping in range before
taprio_enqueue() runs.

I suspect the real issue is that the per-cpu flag is cleared *before*
sch_handle_egress(), so a nested dev_queue_xmit() (mirred mirror, or a
drop after skbedit) can set it and have the *outer* __dev_queue_xmit()
consume it, for an skb that never went through skbedit. For a forwarded
packet, skb->queue_mapping is then still skb_record_rx_queue()'s
rx_queue + 1 from the ingress NIC. That reaches taprio with a garbage
index, and clamping it only hides the fact that an innocent packet got
pinned to a random TX queue.

If that is confirmed, I would rather consume the flag where it is read:

    skip_txq =3D netdev_xmit_txqueue_skipped();
    netdev_xmit_skip_txqueue(false);

right after sch_handle_egress(), dropping the pre-clear. Same number of
stores, and the request can no longer escape the xmit that set it.

Also, taprio_enqueue() is the only qdisc indexing a num_tx_queues sized
array with skb->queue_mapping. A bounds check there is free and worth
having regardless.
