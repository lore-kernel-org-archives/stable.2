Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7A4A64CF
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845300; cv=none; b=FTZeZDq/V6NajbETGb2orejePgY1MsaURVi/KyDKh6AvmvQruujVGcJXCmSawCAcdLdnXQPXQJQv6KT1Q5/dOd3PhKRgRl8opQxErR58lbh2bGpdLAl8aR6QOmCz+OMiTosULvceGRgLK35C0QiQoWZQiOKB5hWJ3ryoxglQxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845300; c=relaxed/simple;
	bh=ZT6ldM6Rero3wx3eaj6hdpLUx6fVOW1BsVRzAoran5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh6np2wLDGXPMKXzH6kQ36aLiVxsF2FF6oyUXUj7BDTCI8aPiAlR+fWVbgbgpPVOcp33k8K+A/GvZvXwEkeFf1qb+YmiGcNuIAERIFsGw7+syNyRiqRah4c4UxHIeJcpU33c/EB/9hYKSAD6FGsLhgh2nYN7cW1gkQmVrdN4Zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhT2GLcL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTn09Egc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhT2GLcL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTn09Egc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790845297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3KLyDgLq+sWfesxSNS4ik2xszHhIAyJ1EGfG6IG1kIs=;
	b=NhT2GLcLb3q13laHZKmUUFj3PFyuS+pchklnpxTpkaWQ3r4z2kYWvML59Oz/LSkKRxo2mK
	Umng8mGKRs2f4urSV7HXQvfZXbewIrE2csKplHMYzob7zdmPk80TedEolh0iC+AxO/lXp0
	zF+2yyRTNyMeUNGVcL1N/p9c3CBpmhg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-O6NxHoiFNtG018oWrLrKFA-1; Thu, 01 Oct 2026 05:01:36 -0400
X-MC-Unique: O6NxHoiFNtG018oWrLrKFA-1
X-Mimecast-MFC-AGG-ID: O6NxHoiFNtG018oWrLrKFA_1790845295
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a021b1b561so2991135e9.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790845295; x=1791450095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3KLyDgLq+sWfesxSNS4ik2xszHhIAyJ1EGfG6IG1kIs=;
        b=gTn09EgcaPcic7Yk2kjCwv7/csOhuVmQtbaIBnZgLzLxvN//yxhv2IT+5Yl2LpFiCV
         10huUsIIONtncO5qCExIwVwNL0MAQmcSLSxPQo/4tfk7y7n+hzotL/WygY7Nv4uAuHHR
         C6+jz7e/ZaNBFQSJdK7xP+GMHh3+3VJcJD0CsBW6Za29p+vvSmOQkODCTewFhCRyDZM2
         nlJxT6h5YQauDdy4n74YXxH9LT6o6w9/v2ZdPwjsBhvw4BY86IEidjGVIzForOBmfcNy
         0ByDtPuoJ+D2CyzdvUESE6dnEYHPeqOhJTkHn0WYUbEnZKxjCZdRQTR936ICz80zUUMe
         4cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790845295; x=1791450095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3KLyDgLq+sWfesxSNS4ik2xszHhIAyJ1EGfG6IG1kIs=;
        b=gH1+8uUCasj03zNF0yu1Ry5wxGjt9dqfgQaLiMMVMXwwKxGlVqVIVANhgvkgus3Q7U
         MSwhWuHQR6+unOOPDj9Yn+6K1IKRj6x5WQJYsmu7vPxiSqYvHX4PJMenGwTt2Vi6HbcW
         gs3C631A0OhQwllxo+YC8Rouf6pdTMD3CLGmqxjlClJdghk2B+DD8CD2h9MMinECVMyy
         5GGyUk+oRr1Ocf3k226hD0tcsD5Tu04TIZYIRWhb4TCitm8Inu5HPnbr/q7tD8vAetKB
         01GotWmo4CtiS7C+X4LLvkrfobgn5lx1iYa7DG+bmrUtHF+Y0m9/N9YADjJzsxuLlril
         AAWA==
X-Forwarded-Encrypted: i=1; AKwUvBwmef0mkSGadzDwRVOvOHkaU/WIB5Uth+e1MRteDIUuiXHxfIYJ/HKx59TpF0uriOIkG+thpHo=@vger.kernel.org
X-Gm-Message-State: AFuF++mgItxDfX7GNivws1OScjHvmslQqHR7cMdf/Fh4IQSRMJUxQHsi
	utXjc72Vxskq471x2FoopAjLzI90QDkfej37YcRD7xjvmHIHSI+XylvH4Sa7MSRKcTrMVmoH2y3
	EMxZTMgqP48SLYl91VdsWYo/XHuW8QYb4Ei1kvRHaa4ibY5/VkNgCcMOeWQ==
X-Gm-Gg: AYBFou2CGc0IfbmbFzvdDTPQsZ4dUwTIneTkA5Xy+6pKKHraBrfA9umM9IGuoFTunsj
	zijPPnOtzUC93MHa3/z9IK3znPAlIL9HDftH2DhMczuNQsGrfDb3mHPe+ro0cOibSwULIO/W9dJ
	TmxYhS7Is8sEx2OX0KUMliDiVEVB/LIw7AVU7JkJV5uQvEGBEkzzUXa2S2ROI7P31/rvtfyA3Ii
	B+Zd3EZ7c1qP+QntxBYDs2/gE6rdHyPba9DefsdgJgcWAb8Ov9DtTgAKz+o0zKi3iNMP5tuyrJI
	ND8QXJRLeFQ2xwEazAW+6uV5wJqRy1iw02B26StZDIgqhIuLfkpNP3guQa11DXiCwVHG+QStIc9
	7
X-Received: by 2002:a05:600c:4e42:b0:4a0:1d:3ac4 with SMTP id 5b1f17b1804b1-4a01aff06d5mr64713605e9.6.1790845295074;
        Thu, 01 Oct 2026 02:01:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4e42:b0:4a0:1d:3ac4 with SMTP id 5b1f17b1804b1-4a01aff06d5mr64713135e9.6.1790845294456;
        Thu, 01 Oct 2026 02:01:34 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.112.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01feb7198sm42199885e9.1.2026.10.01.02.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:01:33 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:01:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de, Michal Luczaj <mhal@rbox.co>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: release sock lock while waiting for data
 in recvmsg
Message-ID: <ar4gvlZL1JyPycg1@sgarzare-redhat>
References: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>

+cc Bobby and Michal who touched this code recently

On Tue, Sep 29, 2026 at 06:33:04PM +0200, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the whole
>receive loop, including vsock_msg_wait_data(), which sleeps in
>wait_woken() without dropping the lock. When data arrives, the
>transport's delivery context (the vsock-loopback worker, or the
>virtio/vhost rx path) calls virtio_transport_recv_pkt() -> lock_sock()
>on the same socket and blocks. That context is the only one that would
>queue the skb and call sk_data_ready() to wake the reader, so neither
>side makes progress. A blocking recv() hangs until a signal arrives (a
>finite SO_RCVTIMEO also breaks it); while it lasts the shared delivery
>worker is stalled, so all vsock rx on that transport stops, not only
>the affected socket. The hung-task watchdog reports the worker blocked
>in D state:
>
>  INFO: task kworker/1:3:107 blocked for more than 5 seconds.
>  task:kworker/1:3 state:D Workqueue: vsock-loopback vsock_loopback_work
>  Call Trace:
>   __schedule
>   schedule
>   __lock_sock
>   lock_sock_nested
>   virtio_transport_recv_pkt
>   vsock_loopback_work
>
>The reader holds the same sk_lock-AF_VSOCK it is waiting on, taken in
>vsock_bpf_recvmsg().
>
>This code is based on net/unix/unix_bpf.c, whose unix_msg_wait_data()
>drops u->iolock around wait_woken() and re-takes it afterwards. The
>vsock port substituted lock_sock() for that serialisation lock but
>omitted the unlock and relock. tcp_bpf and the native
>vsock_connectible_wait_data() both drop the lock across the wait;
>vsock_bpf is the only one that does not.
>
>Release the socket lock around the wait and re-acquire it before
>re-checking for data, so the caller's locking is unchanged.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..bb7d81a95baa 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -50,7 +50,9 @@ static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long ti
> 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> 	ret = vsock_has_data(sk, psock);
> 	if (!ret) {
>+		release_sock(sk);
> 		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>+		lock_sock(sk);
> 		ret = vsock_has_data(sk, psock);
> 	}
> 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>
>---
>base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
>change-id: 20260929-kbh3-1-022-fix-340aa3f7f071
>
>Best regards,
>--
>Jerome Mohm <jrmmhm.kernel@eldare.de>
>

LGTM, but I'd like also Bobby and Michal opinion:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

