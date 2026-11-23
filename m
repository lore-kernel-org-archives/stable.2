Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795436845;
	b=FjNUt3n53Ho4VE3pZVfsxsY+9y+Q9OM53utdOkL/XJ7BqUi8eV1mY+Y9D4WcDSoXsdG2
	 gstGeFro3bdmTpw0xXcXPBsnIrp0OxIqRhoIIMvnKm6xxDwq1XSKGgKrfGtXi5ZLLtw4+
	 d3g3k9V0OM6D/ZVl3obD4/f4ICKsM2bAtQQvVyzcjZLbxwB1IF7UpzufrcwXEC9G/iiOr
	 hdwxU7SkRaaPFUUMArIIOpZFtbNaFgzzCoOpcSNAWU1y2GhaZFiClim0egVHnBYtV5WXa
	 QVK/wthKVk9miikiHez1OiYaLSZNNauQEydl641qG1FnEYfrYgoMy/3gG0alv3pTblw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436845;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=YImJ/ALCtekb57+DaL5zQvBLKaVvYqpkrQRdHCmg3Uk=;
	b=AD6vzxKh58HPf+CplBzfeUX8yWmT+1r9GagDthSNEyc81a0hyAo/7I9D6tp1v0DjK+iW
	 o0xxIDme8HxKvew8Sa0vJLP29EMszkUU33SGz/Rge3Ippf7WZYjyLfn67vXR+44ovCLJw
	 kM/h0rOLDqbCCwQdR0SNRa+9/yMlbkwwmKrnHqsOqpFgamsEo1wPqrt+eBv7gqzlew7I1
	 W/MzqwHJe9OyevPeO8VGvv26xAGTD8kRV5qk+dgyoyQ1tmv/0W3z+ewO8W4LuLypdCNxH
	 RlJQz/edtQViNPc+/6oNBc2W4cH8IGZglbwkQsG6ChLgxB3NlPv8Vttk1WVjgU3mnbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W0KebLCz;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a86GKC8Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2100606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2100606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W0KebLCz;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a86GKC8Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795436843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YImJ/ALCtekb57+DaL5zQvBLKaVvYqpkrQRdHCmg3Uk=;
	b=W0KebLCzLTJnd3CNMGnE9C+XXc+gONbXHqadX3sN5Kr3URGkYt3R6ADS0gVy29T5edGZLW
	egkrSti8pNzqkz8TzJ+CWDWjwRsMPw4K1OrHJzpDrhBvWblQod2USeFK35EKSvgQMunFVS
	83BQbgWV32hClaTRYccGiXVwdNQ91/w=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-_lzw_7fEMQC0q0wD-_Iy5A-1; Mon, 23 Nov 2026 12:27:22 +0000
X-MC-Unique: _lzw_7fEMQC0q0wD-_Iy5A-1
X-Mimecast-MFC-AGG-ID: _lzw_7fEMQC0q0wD-_Iy5A_1795436841
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67dae919cb1so5483122d50.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795436841; cv=none;
        d=google.com; s=arc-20260327;
        b=jRdoqWZfUYsmwKPkxUTrh2szPl01ActCMmv9sDIqCNjzxmqyrbRd/P5ZB4vkz7Anqe
         +XwPE7/JVU77CZkhUtIEPx3WgGxGdCEXCa1cFWaYGMpe3ON9Nma4LCJb2Av0fQgO+Ib6
         P2KwHvYrLKYCK4QNoQMD/0k3bkS/9YMnPXN5SSSSRJqAnKHc9CnXNl/3KU8l4dAg7jXe
         qnuaa87THD1dnTkqcQkBa6vhKe174WdGBgrUi3qB24goDmgbvh0Sh5qdTVwG+JvsutiF
         PCetFeNHIN8JtX4Jds785QceYq2rF2KfBwBunPLc5TqFV3w9QJd/HgiiVTdCX2nxtfDh
         M77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YImJ/ALCtekb57+DaL5zQvBLKaVvYqpkrQRdHCmg3Uk=;
        fh=ORFHJRKsAQo/L8nqnYhDs74FTVwaGMuMWYjCHpbJvAk=;
        b=l/qTu8ULUUV7C104qUxiE8OLutFlw+N9DTykZpL3CU0m6jd16OM7ffm7nTmVLfRtyv
         3cRXFcoIpToF0FfeGdXyHmql55OxtOrwIgdyIDSNhJSfz74Io/zUL/ofdOpnGab/5Hry
         FqxJuvOjQ53Y0YNTGZxQr+qBffe9t4MZcKESFcWjd79CwLBhGqog8SuNAn5UqkPypfHM
         cNNpYe969bUhoH9dj+lmaLUoqzfz576N8Urt30N7KXpa1qbR8wEbg2qKQJqeOGY5zjtM
         iO1W5hjdYASOcv2zRB2hjnN6/vx56oj3vJ24b4A7c4+rjjdoJcyCC0XFHis5oBsXumXH
         fpzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795436841; x=1796041641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YImJ/ALCtekb57+DaL5zQvBLKaVvYqpkrQRdHCmg3Uk=;
        b=a86GKC8ZxMPKgJZBDZRTlBSk8eqs3NKGyoXvQZNXgJ2QG306KpoonkcXzpIHDWZTaV
         acN/sK2jxtp6cPVd0LtowwY8x53KENScPGFKXPzytnNlXt+RPHUtfllQYvh/+tL7jtHe
         sIuXfl+e4VLHOfmKFycq9kV4LPCofXNpeh5ORhbgfFraEcgHuwain8ZFZwtv/wdEC4iq
         5K1lmjyGW9SCQAD2kGEG424KC7pj898Lt0Fp33UBL1/oS/1OY5FgYrIwd/d3ukH469ZH
         /W0cfPFnw1XjRHf+Bonny1O02OW5XBum2khW1w65Sc8t54Y2pWObcF1r9hiwskMD5jHd
         Kzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436841; x=1796041641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YImJ/ALCtekb57+DaL5zQvBLKaVvYqpkrQRdHCmg3Uk=;
        b=Jf7n+F1LJ9tFHyWl+ZOIDWnQL2lWkkh2Emem6r6j6MDZo8FoPRZ8XUUCCt/T2leLiK
         UNhQYCzMarDRT5lbDlUXN6sxlJ46wYm292Rk6l49xFUXD7c3ouESbluyjYKLxEG2/mcB
         qefTV9gZH3cBaE1W3yXBFPIWWi88i4f6BGFUq3jsYCjgOdk7uCJh97XXwOTVRTVDB+k2
         eUVN0s3Mfh5dHKzbMt++e+rJwIYO6ElBKNcoLxRwYMt4+Axldgp1LQmNKQY56Rui04Np
         KTUElSh4ln+UcMCsNeFVmaMplalBym9VQjXwPBtTsJYcNR2IxeKV6ivUdZyNQRfub48E
         Zr/w==
X-Forwarded-Encrypted: i=1; AL+hErHxob1V6q6h7zLg/ZC5CXpUKOqemkCkjY1eDKMBxxQOalvMXI41MgaJW7iIsVn89GYZsSwKWQw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QoIGWer+VfiJUHN44rQOruXuQQXqDAqU87HcbtkdSm6wEUhqk
	wjsOQIdUDVnLaW5VdfOuuUVW191kbbt9u2x9x9x507P+LBUEESQjM8uYTbC04wBE7BTMw8YChfZ
	uI1k8lfu8kV0jy6VQ6Q2vmA8ceKC/m8bFTmpqHu8MTGoOotq+24R+XyfhpNmrFqMpNzb99/WJ9x
	xwnU4ZIiMF7DTH/jmjDvCWMaYGgbd5ru7C
X-Gm-Gg: AZFdTZcETq2rdnFqy3bxP/S7uX+AKgIhJ9858OSgNrdIsRnmHGBO/+zFr+F8+754wcX
	VS1juomFxOKCitxPHdP9AKUMFICbTf+NQE2Ia40zzuMyPyg1+pjNkoj1V4s6Qj6pjULAaDUiLUN
	xQpvb8YxxapDj+W3VAAGa5akj0Y7I7+wX81X4peDkLFugBDNOhgG+4FhvLYzOcLCrTncNq39p+R
	VWFRkwq2cJiP2B62B4hJK8c04YztUolQ/RhXnKG7SsWUukEG0EaZytWjp4=
X-Received: by 2002:a05:690e:11c5:b0:67d:a3c2:c95 with SMTP id 956f58d0204a3-67dec2bd130mr4963365d50.3.1795436841328;
        Mon, 23 Nov 2026 04:27:21 -0800 (PST)
X-Received: by 2002:a05:690e:11c5:b0:67d:a3c2:c95 with SMTP id
 956f58d0204a3-67dec2bd130mr4963360d50.3.1795436840812; Mon, 23 Nov 2026
 04:27:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me>
In-Reply-To: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 13:26:44 +0100
X-Gm-Features: Aa3M54pt5PWY45sVKrMEfHYWn7Rl4h8pw_TEQAIUnc03qW3ChT2fpOFP_O-rkHg
Message-ID: <CAJaqyWdOF3LVF+WHaGw8gimULaCunRkuLnKAhciB7HWpYhnm9w@mail.gmail.com>
Subject: Re: [PATCH] vhost: mask the in-order used-ring log cursor
To: fadouse@pm.me
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Linfeng Sun <linfeng.sun.dev@gmail.com>, Fang Xieyan <fangxy@xiaopeng.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 2:20=E2=80=AFPM YanXin Li via B4 Relay
<devnull+fadouse.pm.me@kernel.org> wrote:
>
> From: YanXin Li <fadouse@pm.me>
>
> vhost_add_used_n_in_order() plays the batch of used-ring writes back a
> second time for dirty logging.  Commit e244725e86be ("vhost: fix used
> ring index wrap in vhost_add_used_n_in_order") masked the index in the
> descriptor-publishing loop.  The dirty-logging loop introduced by
> bfcde6b64769 still uses the single-subtraction form
>
>     next =3D start + nheads[i];
>     if (next >=3D vq->num)
>         next -=3D vq->num;
>
> If the guest refills the available ring while get_rx_bufs() collects
> one mergeable-RX packet, that packet can consume more heads than
> vq->num.

Although I'm ok with the proposed patch as hardening or optimization,
this sounds more like a bug in get_rx_bufs. Where are the memory
addresses for these pieces stored if there are no more buffers in the
virtqueue? Or is it able to loop through the vq?

> get_rx_bufs() permits up to UIO_MAXIOV =3D 1024 descriptor
> chains in one call, so a single subtraction is not enough.  For
> vq->num =3D 32, last_used_idx =3D 0 and nheads[0] =3D 64, next becomes
> 64 - 32 =3D 32, which is still equal to vq->num and out of bounds.  The
> next iteration then logs
>
>     used =3D vq->used->ring + 32;
>     log_used(vq, 4 + 32 * 8, 8);
>
> which starts past the end of the 260-byte ring body (4 + 32 * 8).
> For a used ring placed inside page 7 at guest address 0x7ef8 (so the
> entire 262-byte ring occupies [0x7ef8, 0x7ffe) and
> vq_log_used_access_ok() validates only log_base[0]), log_used()
> marks [0x7ffc, 0x8004) as dirty.  log_write() then sets a bit in
> log_base[1] for page 8, past the single validated byte.  On a
> vhost-net RX queue configured with VIRTIO_F_IN_ORDER,
> VIRTIO_NET_F_MRG_RXBUF,
> VHOST_F_LOG_ALL, VHOST_VRING_F_LOG, vq->num =3D 32, and
> log_guest_addr =3D 0x7ef8, delivering one 8 KiB frame consuming 64
> mergeable buffers followed by one 1-buffer frame in the same
> count =3D 2 flush writes
>
>     log_base[1] =3D 0x01
>
> where log_base[0] =3D 0x80 is the only byte the kernel was entitled to
> touch.  A guest attached to a vhost-net backend with dirty-page
> logging enabled (for example during live migration) and a small RX
> ring can therefore corrupt dirty-log bitmap memory that the VMM owns
> outside the region registered for this ring.
>
> Wrap the logging loop index the same way the first loop does:
>
>     next =3D (start + nheads[i]) & (vq->num - 1);
>
> vhost_vring_set_num() already enforces that vq->num is a nonzero
> power of two, so this is well defined for every accepted ring size.
> The coalescing invariant is preserved: if a run is not flushed,
> next =3D=3D start + 1.  When start =3D=3D vq->num - 1, start + 1 =3D=3D v=
q->num,
> whereas the masked next is always less than vq->num.  The run is
> therefore flushed before the cursor wraps.
> With this change the same vhost-net configuration publishes
> used->idx =3D 65 and confines the dirty log to log_base[0] =3D 0x80,
> leaving log_base[1] =3D 0x00.  The mask keeps next in [0, vq->num) for
> every accepted power-of-two ring size.  As a bounded cross-check of
> the index arithmetic, a Z3 model over ring sizes {1, 2, 4, 8, 16, 32}
> and buffer counts in [1, 64] finds an out-of-range result for the old
> subtraction (vq->num =3D 16, start =3D 15, nheads =3D 17) and none for th=
e
> mask within those bounds.
>
> Runtime verification and fix validation were performed in an x86-64
> QEMU/KVM guest running mainline after v7.4-rc3, with Generic KASAN,
> UBSAN, lockdep, and DEBUG_OBJECTS.
>

Can you post the reproducer? Even better if it is integrated in
tools/virtio/vhost_net_test.c.

Thanks!

> Fixes: bfcde6b64769 ("vhost: fix dirty logging for in-order used ring ent=
ries")
> Cc: stable@vger.kernel.org
> Signed-off-by: YanXin Li <fadouse@pm.me>
> ---
>  drivers/vhost/vhost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index dc973287567..80b887e1511 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -3206,9 +3206,7 @@ static int vhost_add_used_n_in_order(struct vhost_v=
irtqueue *vq,
>                                 log_start =3D start;
>                         log_count++;
>
> -                       next =3D start + nheads[i];
> -                       if (next >=3D vq->num)
> -                               next -=3D vq->num;
> +                       next =3D (start + nheads[i]) & (vq->num - 1);
>                         if (i + 1 =3D=3D count || next !=3D start + 1) {
>                                 used =3D vq->used->ring + log_start;
>                                 log_used(vq,
>
> ---
> base-commit: c44104f3642da720164042623e4832836aefdd8e
> change-id: 20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-43734ad1=
0f0a
>
> Best regards,
> --
> YanXin Li <fadouse@pm.me>
>
>
>

