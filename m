Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074044FC8C4
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417898; cv=none; b=J3Ko6Ir5kXQdAyocNHiuxV87JLJz/zpdDuFqTKDotbESVMs5rKFw23GZvTOyI0keRy6plQ29v4Ebdga6HbfQzi9LlR1rsH3Zzl2SUNvO4xA0yCPRZhft9aMKxEu9zGlo8cYRroT96irxb0+LgIq89/xJy9RLuCnWHzdFc2GMcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417898; c=relaxed/simple;
	bh=9VLOtyiejhxDGW0ifbC/1D+jtwCf2kyEatZ8buqURrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPWMnpTRBgGXB3w/9xtBASnbhVdGnC2Ykp2/felRFWaYw8rUgjj+2MvZMcdoxeffEji1MwU3PrXrvebEPQ4P5uPGFEe5Dc20HVoyltIU9PYUWBO48ddOmYjUOLayB3tslI3oKT/WHkzeUdMooOj+hmjiNuTP68YWKUTH2IY0HAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRHS1U5E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsyOkGHC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRHS1U5E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsyOkGHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792417896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djlN6gLHt7zEzJibUkVKYA1VW63CzqJLxE5NjIS3F+M=;
	b=CRHS1U5Eo7MKL201iqUFYxxB/xCNSR6YIG8PQBVjauyWMm6Jm8l3/+XAHcOg5JeQsa+xVX
	/Pm4c2w2fD7L3sVbybU8SDBOTG117lsc7aUf2E6mP1+jjOIkqxr5jIxykcfdaUIvlH3Pbc
	Zz8uptAYffelr0L6x8VNKNUaKx/jDj8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-twLkUo47M8GqjXDT5nZjoQ-1; Mon, 19 Oct 2026 13:51:34 +0000
X-MC-Unique: twLkUo47M8GqjXDT5nZjoQ-1
X-Mimecast-MFC-AGG-ID: twLkUo47M8GqjXDT5nZjoQ_1792417893
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so1139767f8f.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792417893; x=1793022693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=djlN6gLHt7zEzJibUkVKYA1VW63CzqJLxE5NjIS3F+M=;
        b=QsyOkGHCbz70hDxdgxv/9kkfIqt/ssRvYh+VpeM4BOT/HPLYdCfBchEX80xR1vrJSI
         O3p5QidXItq4yxDNa7xNXIoXoOxo+4yYE+y6coM46BJDTj9tyeJ23U/RUbSfv5FF3fdJ
         QxLnyXe5N+otQbMVOcwIWOglTOmE7utHjWMSv20BiPdDSEccMWtu57uMAkmLBqB2/eod
         YGtEAUOz5lQbg6zQczPf/r+73im/M/xZ4WVDwl3y+tt/E5Av1FVvwj0GbKeTMW2R7rFF
         oEgKvebnIrEQtz6j/8m2kzokyEV1UZw2DE9v2lPP89Q8W6jHJ0Y7TCiIx0YhUASFMyPB
         TiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417893; x=1793022693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=djlN6gLHt7zEzJibUkVKYA1VW63CzqJLxE5NjIS3F+M=;
        b=C6fOenZZarJ2HqhAkfVPhZ6wsK96iz37OX93Z2zwuD8g5xmk4e2XqcM/BydxoF7HKZ
         MMy19D3HD7daHrmeE+PT8NM/cwgI6PypFOIXpz7x6Wk0yuDi+g/YYBgp90rCItqoObb/
         lEU5NF50f0c3lHFWDQ7Ff+R/v8KyEGd+PfxfFsodCvqvcZlkLJIfDElGxO2m3j7Mqg+C
         j8G8UK2axQrxr5BKMuIdzEfINy70p6IGT7nzxPXiJWv9oyHgRM1vqzjsIgy1NrGmrIGI
         Hrgwe9wvv2exniQLFvwJmcCs9AqnuCEZO7XLlkR1Zpou0yAb4GpeWa8gH0LBtOi2Pqt9
         TD4w==
X-Gm-Message-State: AFq9FYJZ54NOTHY2aXHXe9U341eHTvckfRqAtcWXeTB4o13WbRUSFCxL
	0chzxZf//jqh9upV2KUO39dWM99ggSNz2L52rHZuBPi3t5ZO1AQJN2dhBpyyIJayS3D/30T+61t
	ThZ9c4CIkQyKnY0Kib6X2pO05p8xq8v870F3eCcBd36feiIMIwRwaYE7IRw==
X-Gm-Gg: AYBFou0djxHpHXZ5MHymOK1HbRBaR8QVuosATE7TYiqGNG7wHWmXG5mgLvHzY6WAanT
	Ss2i3VqCNUHxExhMJYHTZhCsVkdptM7UwF1Fu5kxJfCRfDbGlScgfnPGmoa1pAZ5yxKTaZG4YZi
	L9GxVKEv+mmxKe5oZEspCu2yoRCSUJ6DFFcxQeTJltu+oK4WbMyW6O8CJzrYQ9iVOGaJqzm8SEN
	mSPKdp7KwJYtiMkVQkwSfHZ1G37LBjIV3+PB6fQYFpVk4+cQu8m8kNOb/IKraQtTUGFrdpzsdTj
	B6j6ajOapYfSWgeeV2pCsGwcmuCswNFHUKVBE6SXgEjSm9DNWA7Vl83/aMP0nPurqLXyOr69/70
	1DHuI
X-Received: by 2002:a05:6000:4a12:b0:48d:ef75:8b37 with SMTP id ffacd0b85a97d-48e07fa8816mr15506774f8f.36.1792417893030;
        Mon, 19 Oct 2026 06:51:33 -0700 (PDT)
X-Received: by 2002:a05:6000:4a12:b0:48d:ef75:8b37 with SMTP id ffacd0b85a97d-48e07fa8816mr15506448f8f.36.1792417890572;
        Mon, 19 Oct 2026 06:51:30 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.74.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1af194bbsm1870082f8f.57.2026.10.19.06.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:29 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:51:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1008/1674] vsock/virtio: fix potential unbounded skb
 queue
Message-ID: <atYgJz85081YBziv@sgarzare-redhat>
References: <20261017160431.119607952@linuxfoundation.org>
 <20261017160457.007728876@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261017160457.007728876@linuxfoundation.org>

On Sat, Oct 17, 2026 at 05:54:40PM +0200, Greg Kroah-Hartman wrote:
>6.6-stable review patch.  If anyone has any objections, please let me know.
>
>------------------
>
>From: Eric Dumazet <edumazet@google.com>
>
>[ Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5 ]

Be careful with this patch, this caused data loss. It's fixed upstream 
by commits:
a4f0b001782b ("vsock/virtio: reset connection on receiving queue 
overflow")
2a12c05aef21 ("vsock/virtio: collapse receive queue under memory 
pressure")
c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve 
full buf_alloc")

So if you want to backport this patch, I strongly recommend that you 
include these others as well in the same backport.

Thanks,
Stefano


>
>virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>
>virtio_transport_recv_enqueue() skips coalescing for packets
>with VIRTIO_VSOCK_SEQ_EOM.
>
>If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>a very large number of packets can be queued
>because vvs->rx_bytes stays at 0.
>
>Fix this by estimating the skb metadata size:
>
>	(Number of skbs in the queue) * SKB_TRUESIZE(0)
>
>Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>Cc: "Eugenio Pérez" <eperezma@redhat.com>
>Cc: virtualization@lists.linux.dev
>Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e2a5803c0bbb7..24aa9194e6862 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 					u32 len)
> {
>-	if (vvs->buf_used + len > vvs->buf_alloc)
>+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>+
>+	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> 		return false;
>
> 	vvs->rx_bytes += len;
>-- 
>2.53.0
>
>
>

