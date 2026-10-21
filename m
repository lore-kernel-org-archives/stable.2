Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792567803;
	b=FhcpvfVX+WZwJLI+cRxBBSaGTElujB3dVZaRnuyIhRihQ/QQQ8sMF8A5F6FBSYZdNXni
	 BBmVOfoKQB4CIP6xkdlSJocQcRujNN51tY8quDSgyl0Fw9qZgqR7BA+cyLNY67qKmIVCF
	 NYsHZUdfPr7cEP9po2FcOidYJyGp5gahc5ng5crZdcAeCd5IAXcHXoAieFBD0wCvUejmM
	 4SdZ4/F9MKWgj9L76sLY/hLIPYhCISt9Pxy335E7iRRyTFnfHLeIcbLB0TPM8k9Gh/phv
	 tYTM6fdyegIBvkoiVrCIjXF7X1yJXnvsyv3zeTUG8rzEZ/nBCzWq9pBMgBEGximrp5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567803;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
	b=HDDOEgAneEVrfbTWt34Hf00ZrZC6UFOnnRizO0jA+FgqpLg/jrQgCWD3QY7SzqXe5X8V
	 hEQE2rVUkyRmnB/boGa+3hZt71chkWT8JYGYHHl/udSc37Ze6WDEIvqRaDX3eVQWhdE+T
	 Q5rheUqdOyDJ5vof2HL/yUVDBzjVSBOJzTKCX2yy+25bgQf72CxIVdOt3idJdmnAntnZK
	 Kwzn+sg2dQUyDcYGbdwa5TMbRPD4NuuVvsdYkVzMedRLZXbnfVb+WsvJAJooZhSnoSWzf
	 SDs47Vbp3umJhadBzzee/D8BlXCYCH+IQXK9ckAMvfBxBs+rLDCdNcV5CZruB6EC57Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MEo0p6wi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iPKj99OK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F84606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82F84606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MEo0p6wi;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iPKj99OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792567801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
	b=MEo0p6wiV0/R/3nHv0Agn6BGUrhqJa+uywYRPZFlq/M0cClJEonQ+FFpq6WLkNWGVgpWdb
	S2FnjkfHj2uAcqsUlCXxqr7bIOLV9xlDVAnLeP6MuVE4dGRbuB6elm8N5ogmYrALCYSi0o
	ucKS4A/+IfSTynEDj0VRe5X2a+ffBpc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-OL4lyizbMNKeTXOqaGn3QA-1; Wed, 21 Oct 2026 03:29:59 -0400
X-MC-Unique: OL4lyizbMNKeTXOqaGn3QA-1
X-Mimecast-MFC-AGG-ID: OL4lyizbMNKeTXOqaGn3QA_1792567799
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0da010661so7201717b3.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792567799; cv=none;
        d=google.com; s=arc-20260327;
        b=P8yNrFOQXbCzSCbF3qZqrF53d4Oi1PJjGTvfBCwbJ1XlZkCMyXKhHXRkow/+lPryio
         p/dFv/n6NbTbQeGpavI0apbM98FjuB0ze60m+Td5n4RMnmtw1b8PZw4akwPSbL3ODeOg
         VsgJ8Biw+wMsGEEBHFImI+JoyUfbeyukrb13xk9LnuCjOf4OzEnoVh+2m6TBIO9tD4Dv
         4BQcynXGtEJ12f3Q+OtDxaDNuYrId4NlyI7dGo0pK8NZuVxReL9Q7+TxAJWNUXyhRB/1
         6hGDB6ykkgw4J56uQlloIT83mL/O+bPR//X+BKu5X+KUDElay2ek/ZsqNkNq/r6aoDBI
         AtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        fh=2/j14M38+KcCJe91lubnoHoQjywibBGTgGoSGVjxc4Q=;
        b=US2pUiBkyenKcD2QoloK7md1BYSDrfW3yGWxQpLN194rR/hXchjZ+H3D9VCAKU4B6k
         cQGpCAYy9RKaZXoL+W6BqGpo9Kbs3E6Y2L+ci28eWBVutGFQ28d8hlsGXI297zS2q/ff
         oMWPd6lYg32p54enOeM+SqakeXnn6YJyBsjPxKhmJqBuiRgDuhAgidUihRoNkbPPPPGp
         cH80FNEJFOsQsCUY6w3nh/hn5+xRDIcMA9LV0x0xDLlMYnF8ei9yyC36z3ZGgWzfi+6i
         aCFru57CadnJDN8zxnD/KBabXM+qWL7W/11IWnvWBwzDynACE605Rlr9U8TT9JT6nrQi
         S1Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792567799; x=1793172599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        b=iPKj99OKCYBLxKoFRZQf2Hg6XfmZny80yGZlMAmrHp5kx5XGo0TgWwOm1D8U1+QkFs
         UERYQore2pDeV1iNLK/bRlznsPf785W4T+NrHK/BAf18mYAiDfpZM/nVmxT27tawAbFd
         XsQVcFDBnTpT0wR8MAtQ9B/oS0eK085+i7rMB0YbRIyFnv7lD6qH+ZNDHWZeuKxmXnri
         EboiCCaMxHi9C1T91+RZpQUHX2EfDuCBuWDo7KFZ7OLZdbcK5IpbHsC4PpR5r5GXnYzx
         rT1z5IzF+foNu4wQnWwAjH9ek8D/VK41l8kXhSuAsNfYzEv/SS3IVpywD7hRuiA9z/rL
         AJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567799; x=1793172599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        b=bGVwwCaWIU06p96QAmsOg6DWczytimd0M8zoTw2Al17oGA6oufx5/Lo7wlnFRMTasE
         rBAC/Svx9HN/Kmq9KmuNr3W4HzMbyodM6NYx+ExezfQfWxhQWiFxp5h/dKOfkEBLzQdD
         bCBNbf51Lm9W08QGZDXGcfe0ejwnOX+4dW8lhiJ12L9vokjYXH68FJRtRsVX37hb4jHq
         qDZGYie0e0fTM0AKbAY5Ad8BuObiwYGHTqobncXoWxJzPcyQ8rDbqkNIEnFfqHPR0YYb
         vs1zIvDV91FjJ3N4NUXpMWH66MFjSnt/RT3QB/p5KOIDgtKplrx9QnP5gRomhpUiW0hw
         66VQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2AW4kOW3Y/XSM5E6SS4UKDT82UtGmRHgsvd0xz/pKTfXtmRjzZ77K6ba04wVqJH+5llPu+UI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1L1RHb+uByFt7tRb+Akce2Cxp0IrUhvx/kB6qJ9iT+Ysg4zeq
	FIHEPlxXo+qAEGNyC7Y29ezLq2t5hII+OtOf9bq0RqBRqzOk2Mzqw+8WDsKnWBdYHaZJoCZwnhf
	1vq9ItKDRcb7IYkl2shrwhn4CNhUTNZQdZ4lomoGx7XVvs2Z2oLYU1+2G1xZLBdlzDhbXyOjBEM
	QKFV6UjATF/KrmNA7J0dJ+Fr/iPk0/ngZ5
X-Gm-Gg: AYBFou2lCqoKruSMRdntX50qeSH8kI5Dk4Z+EHBuXhRJ35M57dRQCBuYu2XSnMeVL9u
	qxDHySFHJ80T4PiU7Mci4aJA2UWYkpfOtHoYlzMeX8Jm5qVsmWaJTc+ENmCdYVXBXeOb4g9UMwC
	8IseiksJ2H4OADhlDyd8rMUY0Ml13HzNRq6n91id/OBVr76zk4MgozHXyvPwIMH2oWwgo6DyExL
	8iV4IjcTUOFItrGBqf4jfBXzj+XBq0eAhybzVpos/gxpnh8p2GH9QNEoRk=
X-Received: by 2002:a05:690c:a909:10b0:8b0:e238:2719 with SMTP id 00721157ae682-8b133fff1d6mr5006447b3.31.1792567798949;
        Wed, 21 Oct 2026 00:29:58 -0700 (PDT)
X-Received: by 2002:a05:690c:a909:10b0:8b0:e238:2719 with SMTP id
 00721157ae682-8b133fff1d6mr5006297b3.31.1792567798485; Wed, 21 Oct 2026
 00:29:58 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020232956.99970-1-fangxy@xiaopeng.com>
In-Reply-To: <20261020232956.99970-1-fangxy@xiaopeng.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 21 Oct 2026 09:29:21 +0200
X-Gm-Features: AclHuK-PqFWCN8ST8zFxglfpmVJtYh8ceAExLMaLATIvJ8UfZfghlr_8jg8ahUM
Message-ID: <CAJaqyWdoQXHiWEh6aCGt7T+U4U4S8Z79hhp5=QYzzkODeDVyOw@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix used ring index wrap in vhost_add_used_n_in_order
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Weibin Liu <liuwb@xiaopeng.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:30=E2=80=AFAM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> vhost_add_used_n_in_order() advances start by nheads[i] but wraps it
> with a single subtraction.  If start + nheads[i] >=3D 2 * vq->num, start
> can remain outside the ring.
>
> With used-ring logging enabled, start > vq->num makes (vq->num - start)
> underflow.  log_write() then sets bits beyond the dirty-log bitmap,
> potentially corrupting adjacent userspace memory.  This is reachable on
> the vhost-net TX path with VIRTIO_F_IN_ORDER: done_idx can reach
> VHOST_NET_BATCH (64), triggering the issue with a 32-entry ring.
>
> Wrap start with a mask to keep it within the ring.  VHOST_SET_VRING_NUM
> enforces a nonzero power-of-two ring size, allowing start to be wrapped
> using & (vq->num - 1).
>
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
> Reproducer (verified on a kernel containing commit 67a873df0c41 with a
> temporary WARN_ON_ONCE probe in log_used(); the probe is not part of
> this patch):
>
> With VIRTIO_F_IN_ORDER, num=3D32, and used-ring dirty logging enabled, th=
e
> TX batch reaches done_idx=3D64.

Can you send the reproducer? I'm very curious about how vhost_net
reaches to done_idx=3D64. It seems some bound needs to be added there
too, isn't it?

The patch itself looks good to me, even if we will need to modify it
for packed vqs, so

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>  In the observed run, the initial index is
> 3, so the single subtraction leaves start=3D35.  The resulting length
> calculation wraps to 34359738344 bytes, as confirmed by the log_used()
> probe.
>
> A 64-byte canary immediately after the 512-byte log bitmap changes from
> 0xA5 to 0xFF, confirming the out-of-bounds write.  The used-ring canary
> remains intact because vhost_put_used() runs before start is advanced;
> the demonstrated corruption is in the dirty-log bitmap.
>
>  drivers/vhost/vhost.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 44cac11b68d2..0226c4c59709 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -3172,8 +3172,7 @@ static int vhost_add_used_n_in_order(struct vhost_v=
irtqueue *vq,
>                 }
>                 start +=3D nheads[i];
>                 new +=3D nheads[i];
> -               if (start >=3D vq->num)
> -                       start -=3D vq->num;
> +               start &=3D vq->num - 1;
>         }
>
>         if (unlikely(vq->log_used)) {
> --
> 2.50.1
>

