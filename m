Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D16463B8F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351994; cv=pass; b=WZ9Zrf07gw/31bLW1OcPyRO8x1TBvtnZ77o9q/rijv8kdvcHJcx5ArYvIqyomHqUtAxAVIQcWc7Kx1wQIDbxyROuN7Ibb2tRb3FIervZ4TtXUjaAfRRDqsJjuvwmL2pKu0Se0ZvgmaJlTOtWSe9pQIoGP9SzlIB25+IpuGW3dO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351994; c=relaxed/simple;
	bh=6WPhx8PReV46HTsCogkuoq6nCnjySOBHp1E70tMVQgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vag8dB2OH1cijbBUxgI3Vw6bWtW1bc47QvSK9rv+eAuQ8l0EoupZi0IAePl1mt3ymuzeRzL468SZrLEFA/SBxnG56s1FqxPGqafKyw3al3Nu8oLorZqqKpFcTocssJFAaU3tAvSD4eScK4DPCMuc873bFN1ssZ4tYeg8j/ZJe/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORPLAY/l; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORPLAY/l"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c167aa9500dso177554366b.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785351991; cv=none;
        d=google.com; s=arc-20260327;
        b=BKuMQDoZ9/6PT6w/BZSi/g6zCjp+Iks5zwENRLqobylmZ8UwPBFcMGPzkIjdhIpeQk
         VeLXqR7zwCWcizjZUPRgk0WJGIVXILSFGxUscfDvLCB7YU846fBw11FVARZOlQbbzuo/
         5gcUldEkK9hVfsC5GgrHFLbcLIh+jWpITgZcCKyXaCNZXh26PsJNdIXBuRa5iWbyUiVN
         0ayMd8VIM3t5wt6jQt91dcEC+o8ECn9DszQX5lASlq8i1TQusVN74bteiqBD4V20ClFF
         vMKJdIOyRCJ6uXoGOWK3IMT/aY6x4hVV2V3zOkJBaoQbJoWiSU3XquCdxJd0Thap1PhZ
         S4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xnnMp3bYdgLemtWGnJyzOun3f7Jn2r77yt762F4YIuA=;
        fh=078HcSxB7GTCabQ642ngBIn3RpYgKDcVgJNWQTmCy00=;
        b=hKem44C1eBZxPlD62TajKRtLJoqNUWQzkSR7pb+0VKnalfqiUIDuazOysQQ8OlTjum
         P0YqDqlpf8lnrXJtEC6nQ8AyCCptlEuiJ7ykXWgDboxjULsRkHXSwgNcRY8BYRGlwY/w
         ETv5yX3CcvENL81mmcL7V8OXgjfrArtEg+UPlSd0rVLTMIZFHoLS7ItGPH3QALlXsIFv
         dLjHKSRnIpt0n08aKgtWKWnqMlQk113FV7oVQvb2igHtfzDrCj/wNFeuqiBMqbZJPnl7
         ekkglavxevCmE7+x4VFOb+eow8AJLHJKYudUVgFQsPHlNc1QUgimveIEip2xeJ1+S0Q6
         SdGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351991; x=1785956791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xnnMp3bYdgLemtWGnJyzOun3f7Jn2r77yt762F4YIuA=;
        b=ORPLAY/lrOjps4RBgWwNtc3wVlIhc8J41F/qnZEa8/rRqfJLyh0LGQojGRhYVb9dvr
         fR2SOID+Negk2PCqYP0z3u53BYcU2gaRxLV7cQhRlC8amZSQRvXO7g25z4orkOLCKlS/
         QiQQZTBHOknFDTq3fwt32ah/NDhRdZwPcwmT8E31NjcRZUYUOOtDEsa7LBc0sh4JNZ7p
         FoV2O1PL2piJuqwE3VU5KPiwzkDO8TojAzt6yb+LIzxd2A/dpxPGaIUjtpM6B23DBRvN
         2nMDseuK3VxhrNHNSfLmRR6+Yqgs2gMZ8eBEAsWoAk+0LxyO1yctaEZUvYprHd/90qMv
         bT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351991; x=1785956791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnnMp3bYdgLemtWGnJyzOun3f7Jn2r77yt762F4YIuA=;
        b=qZS/+WH6QtYMIsnRfVwUC7KIuU6CdQ9bHlGvjwowDihu4yfHZ11TjoHBZS4KUAkLsi
         SyCYFqMa/WX2a/oMHWxtCxAeLeObuwo4bKiWJUyAmd/73twabb52yjpLkpPQkU2j2MWb
         y5Cnsqc5kkxCP+2ENdM51vVo5WpbzbSv3xckKAaV07Yd1pKpiTjWWmej2YjaK8OwQ1lA
         yo5MfP8WNrGlqH/zXt/GoXGZkr7EdpDWXvFL3007y3v2+jx7pGx+fiBZim4gZ8iC9pgU
         s9JRuJImmuZZlIc8AxAssig9wr7PVjweseKocUaPmCxZSwCezMY32Jg75S06+TrOu+iV
         35dw==
X-Forwarded-Encrypted: i=1; AHgh+RpXq9P2ADQ/yjjlqB90upFsGi622Xsqc8CvpDLfvAnXteVrBqtUQnywfZvti8FCG4aesOlCJUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4o3zrt/4/gKXAL1Ez7SCsDQPh8XyiycETzmGBRZLcCsYEwiuR
	c0R90zjJcIrJKiCVSL8F+C3+QHR/s1KYtAzq4j4iA3DbH71cCA0iP5go4CjF662lbPtci5NGRuo
	tIF0V5M54U86cq2vrQZtUtxjmWt+d1gQ=
X-Gm-Gg: AR+sD1171AT1GXXgub2bSL9sSZjpHOTwVBnPSFfQYYgkOn0IVq51S+e9u1pckBVJsGa
	uqyvDb91HpbMjSZ1Drh9ZTxEl/fz4Aa7356m3jVxFTzhcMOQz24JO7cTGAAPXYizWITy93wqXnb
	4EjDyqPc4PqorN2VfuZQsSfM2S36DoaGzBAcaM/Up3VBkYj+30VCTZMR0H7s84+sxgQWuSzKrt7
	OxCnC+ZCylf5kRHntrHEKrWlHl5W4ipc9gro2BtMtR5fW6B4NngUeFZLVxT3mwpr7acgmmDKGyI
	nwylwEWn9GR9JdkatWEARDhXZT3Ki7gdmnyUr6BiXYg4q58QAT2B6Trl+2/TlhoLDFHXrkdap+4
	=
X-Received: by 2002:a17:907:9802:b0:c1c:4d19:f733 with SMTP id
 a640c23a62f3a-c1f720eefe6mr463168666b.40.1785351990816; Wed, 29 Jul 2026
 12:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727035804.1860862-1-bestswngs@gmail.com> <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
 <amoR0pnMO2OQ2E6z@sgarzare-redhat>
In-Reply-To: <amoR0pnMO2OQ2E6z@sgarzare-redhat>
From: Weiming Shi <thebestswings@gmail.com>
Date: Thu, 30 Jul 2026 03:05:53 +0800
X-Gm-Features: AUfX_mz3TgQR8C_4x8K7ZMCwqKKo1i2lXmGLm4XOyvkUGevFYGQ5eIt1hRXQEV0
Message-ID: <CANgPUi2LFBiBG1c7+s_AyzrtDdncXDXQQuphNqmC0uktvBY1dg@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted virtqueues
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=B8=89 22:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 28, 2026 at 10:17:55AM -0700, Bobby Eshleman wrote:
> >On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
> >> The RX, TX and event workers read their virtqueue pointers before taki=
ng
> >> the mutex that protects the queue and its run flag. A work item delaye=
d
> >> across freeze and restore can therefore retain a pointer deleted by
> >> virtio_vsock_vqs_del(), observe the run flag for the replacement queue=
s,
> >> and use the freed pointer.
> >>
> >> RX has an additional path: when rx_run is clear, the common exit still
> >> refills the RX queue. A queued worker can consequently call
> >> virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
> >>
> >> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
> >> Read of size 4 by task kworker/2:1
> >> Workqueue: virtio_vsock virtio_transport_rx_work
> >> Call Trace:
> >>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
> >>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
> >>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
> >>  process_one_work (kernel/workqueue.c:3314)
> >>  worker_thread (kernel/workqueue.c:3478)
> >>  kthread (kernel/kthread.c:436)
> >>  ret_from_fork (arch/x86/kernel/process.c:158)
> >>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> >> ...
> >> Freed by task 141:
> >>  kfree (mm/slub.c:6566)
> >>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
> >>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
> >>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
> >>  virtio_device_freeze (drivers/virtio/virtio.c:658)
> >>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
> >>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
> >>  device_suspend (drivers/base/power/main.c:1968)
> >> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> >>
> >> Read each worker's virtqueue under its mutex after confirming that the
> >> queue is running, and only refill RX while RX is running.
> >>
> >> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()"=
)
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Xiang Mei <xmei5@asu.edu>
> >> Assisted-by: OpenAI-Codex:gpt-5
> >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >> ---
> >>  net/vmw_vsock/virtio_transport.c | 14 ++++++++------
> >>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_t=
ransport.c
> >> index 57f2d6ec3ffc..79cf19f58943 100644
> >> --- a/net/vmw_vsock/virtio_transport.c
> >> +++ b/net/vmw_vsock/virtio_transport.c
> >> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work=
_struct *work)
> >>      struct virtqueue *vq;
> >>      bool added =3D false;
> >>
> >> -    vq =3D vsock->vqs[VSOCK_VQ_TX];
> >>      mutex_lock(&vsock->tx_lock);
> >>
> >>      if (!vsock->tx_run)
> >>              goto out;
> >>
> >> +    vq =3D vsock->vqs[VSOCK_VQ_TX];
> >> +
> >>      do {
> >>              struct sk_buff *skb;
> >>              unsigned int len;
> >> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct w=
ork_struct *work)
> >>              container_of(work, struct virtio_vsock, event_work);
> >>      struct virtqueue *vq;
> >>
> >> -    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> >> -
> >>      mutex_lock(&vsock->event_lock);
> >>
> >>      if (!vsock->event_run)
> >>              goto out;
> >>
> >> +    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> >> +
> >>      do {
> >>              struct virtio_vsock_event *event;
> >>              unsigned int len;
> >> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work=
_struct *work)
> >>              container_of(work, struct virtio_vsock, rx_work);
> >>      struct virtqueue *vq;
> >>
> >> -    vq =3D vsock->vqs[VSOCK_VQ_RX];
> >> -
> >>      mutex_lock(&vsock->rx_lock);
> >>
> >>      if (!vsock->rx_run)
> >>              goto out;
> >>
> >> +    vq =3D vsock->vqs[VSOCK_VQ_RX];
> >> +
> >>      do {
> >>              virtqueue_disable_cb(vq);
> >>              for (;;) {
> >> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_s=
truct *work)
> >>      } while (!virtqueue_enable_cb(vq));
> >>
> >>  out:
> >> -    if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >> +    if (vsock->rx_run &&
> >> +        vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >>              virtio_vsock_rx_fill(vsock);
> >>      mutex_unlock(&vsock->rx_lock);
> >>  }
> >> --
> >> 2.55.0
> >
> >Not a strong opinion from me, but since this last hunk is the one that
> >fixes the bug and the other hunks are moreso hardening, maybe break
> >these out into two patches?
>
> I think also the other hunks fix an issue, but I agree on the split
> since IMO we are fixing 2 different commits. Commit b917507e5ad9
> ("vsock/virtio: stop workers during the .remove()") was before
> freeze/resume added by commit bd50c5dc182b ("vsock/virtio: add support
> for device suspend/resume"). Only after that one we can have the false
> -> true transition of *_run variables.
>
> So IMO hunks 1-3 should have Fixes: bd50c5dc182b ... and hunk 4 should
> have Fixes: b917507e5ad9 ...
>
> That said, it's not a strong opinion here too, but if you prefer a
> single patch, please add both Fixes.
>
> Thanks,
> Stefano
>
> >
> >Besides, that all looks good to me.
> >
> >Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> >
>

Thanks for your review. v2 sent.

Best,
Weiming Shi
