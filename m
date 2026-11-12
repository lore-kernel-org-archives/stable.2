Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502972;
	b=iC5aVzUZX87FMbLFEt1cAQmgIkQKRgV2xZFnjmNkH02XkjoXfNCctlm/pGq4PBNSSa2W
	 fCxz9qNhvE0pOe2SGf2iu2EcQCZHE1WLb0w3eZ7I2WWVgC/HHVY/mbu+JQCKEZJs2oUOx
	 gfBdExJMlaqVvCQuNHRP22KcQQ9//6m/T7xlS3QLAP6BKudNQLU9ad28VGBazdG++9JMi
	 yCLE3f55m2rJiuPQtUcL0+6t9OqBGpg4UbX5NyyTjgtkYL2uMZfCeufStUxq/u8HASmMy
	 Y0/fMZ7W0rAxC/nUPVvbCabxtLCaQR3cTc6emADiuFbE2xsh0e6SNfgXxRHcTNNyccw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502972;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
	b=cyXzVKEz8cPuCP/IylkjMRzZZ3Q3PSbK54VVi5b0KmnrbvrL/mZ+m9vEaVXbdhM2DGAj
	 3WeRG/QcZtCnSgwNhpaLe7uLa0toNCVh457LgIdzX8/wj6xf/erLQmeMm24pL3T6k0oIN
	 PqE1MUhA1gAmdKSAdELjzvkpsFdC1cKfYpyVSLBto2HdUVu05wmsd+9qVVWFo5M/6XdFL
	 LBYwLc16QyFLfWEaRg1doIoy9/Ymz6BYwm7JhRUkxw2kMvB4w5QImJR2rDSajqoo8g5Cd
	 Wa3vxlVobdCLbVBFDOMmGNEBlVn+i+ED/XGk83YfIkBmixjhJj1b/+WSw+4UjNhHmOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ST5nZOgd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fq7YFxue;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70758606A885
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70758606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ST5nZOgd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fq7YFxue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794502970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
	b=ST5nZOgdaM5oYAwyzANy9iO0L2W903pF+PUBQv7e+mmmHs0z5tTlkyO3+XsiO4R5yfie+m
	5gmUsSAG439Zi9vrGA9Aq8VKhKeV53UHbAaqy/J9H2rWEE4MaL/eJjzCOk4/x3KqUsMEnJ
	QZz3EhZIjMySXHYmveR73QHsHBfrkUw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-rpLsDw4TNnekZ2CM1zbWzw-1; Thu, 12 Nov 2026 12:02:46 -0500
X-MC-Unique: rpLsDw4TNnekZ2CM1zbWzw-1
X-Mimecast-MFC-AGG-ID: rpLsDw4TNnekZ2CM1zbWzw_1794502966
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-70eadc5b37fso3610632eaf.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794502966; x=1795107766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
        b=Fq7YFxuew4y7VYWcjll5e78rzl8lIIgzpNXpaYN/Q8NWnVIoAajywtbu6NvnCpqxUW
         +1IAiKP12pJlcr+LGTE6q7iwkNzffOFimZkthIQn5OnHflCcBpuOIU4F2vmUVcgEigUo
         XuvFw8xYfhpop8HoWiKm3c498ITO9JXm68E4K22WtAijG3eEqrT4s0Z2oJMcj3QxRKV1
         JPbF2XywvRdd+B1f0ik6ycufeWJuRVIF8Xa2OS9nDUvAIJhq8q6xdaL3vBluXbncjohj
         GrWaYnh80smBPTcYIj4VqyDEw+RsqxujDxB13NBxbkVpU7nsfJToThSwbqKFLRBVEKK9
         gjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502966; x=1795107766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
        b=dkR3yhMeM0I6brLILvm8HIuoemSNkko0k6CruoQvGY1PBQNLh724D3Qo5h1K3eM9hv
         bVPti3uTJVZNkelaRyIgn8Na9dYM7vtcYH/BBpX2lTImQVDwEZcJQTy50q535sC0zZ8K
         PVCPfEDaMOPu8QxoAaMObhqhxiMC1iT6xbZq3AxznGczvWXnRzE0YZkInmxee4h6Z37z
         sTpj6ysPoqmcH9zClfvZqd9bqxaIh+QPCPyBE1q4thxiXrbE1u3Ov1CdDPoH0cVQ/8iw
         jIkhTiCCdk+S4Mqhjcs+uP16s5R4WzaqH34QX708qiQ3xedsDvQIJhG3HEc4v2PjEdyS
         5+dw==
X-Forwarded-Encrypted: i=1; AL+hErFLyQEMse7fbJ6y3FW7x3npXN5Tb5CyxtJtgkPWfdBAC1mD/4jfI1/L0jkqdWAwToK8ezr3Odc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PsuG5deftqKvR8oZ3VFgAsNU8XKJi1/h/P0r9i0v+QzNjlLWd
	GQab2bF7Q1qNzSNTRZYp9afl8BC8gHTK2kHvpoE/7X0r0NLe69PwTSWzs/nlEz6SklhL8ncV0mt
	mzUYxwh7C9KIWoprBbD+C4lmamxSMOK/N5E8Tt0Rfh8esDHYrGjce81bHQA==
X-Gm-Gg: AYBFou2RItjJfEsiZBhZ5Byte6SMW741Rxae4FnziD5sAqUZSYtrAGfI01U5NucEfGY
	+XBbNrOMtYPa1/tp6PZdr5il9v5JbT99pYRmTJ6XNfYtjN0Rvsb+qmEoz0JVjE8+brF2E2dC8QP
	Q375KLSI2UIcoGKPdMVPQ9sMl9FTXzNVdIQqYzwdWdIjGenle8Kqzc94hmgdGHyyIH7+zEOJVOQ
	1w5X1j6/SvBIHjSK8hAitUauD3fWU2bQSgpdFKgVOGcoE3+AC5oFkyw+24CqqF7usBymK5ArHhg
	LHjt/sBvqhSL95N2ZzfM4P+2aIDpMnzeXR8Gk7G1yRwe6YyHwV/ZXmV4CuxV4j7xXRBtau+HMgF
	3taPN/5tVgOJ7oPO1RcUS+6JGnEqLAoE2PB8IAOPUfxAs9Iq0csKS
X-Received: by 2002:a05:6820:83c2:10b0:6dc:e1c3:b2ac with SMTP id 006d021491bc7-7191798a171mr2797276eaf.73.1794502965996;
        Thu, 12 Nov 2026 09:02:45 -0800 (PST)
X-Received: by 2002:a05:6820:83c2:10b0:6dc:e1c3:b2ac with SMTP id 006d021491bc7-7191798a171mr2797227eaf.73.1794502965373;
        Thu, 12 Nov 2026 09:02:45 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6a1c7sm5433524fac.6.2026.11.12.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:02:44 -0800 (PST)
Date: Thu, 12 Nov 2026 18:02:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Message-ID: <avXxFnqVLMgBMjBP@sgarzare-redhat>
References: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>

On Mon, Nov 09, 2026 at 08:39:24PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>virtio_vsock_vqs_del() frees the virtqueues but leaves vsock->vqs[]
>pointing at them. If virtio_vsock_restore() then fails, the driver
>stays bound with a dangling vqs[], and the next freeze or unbind
>passes a freed virtqueue to virtqueue_detach_unused_buf():
>
>  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
>   virtio_vsock_remove
>  Freed by task ...:
>   vp_del_vqs
>   virtio_vsock_freeze
>
>Clear vqs[] after del_vqs() and when virtio_find_vqs() fails. Return
>early from virtio_vsock_vqs_del() when vqs[] is empty: the detach
>loops would pass NULL to virtqueue_detach_unused_buf(), and a second
>del_vqs() would free virtio-mmio's IRQ again, which only WARNs in
>free_irq() ("Trying to free already-free IRQ").
>
>Found with the help of Anthropic's Claude and reproduced on virtio-pci
>and virtio-mmio by failing the restore with failslab, without other
>kernel changes; the virtio-mmio WARN was found by the netdev Sashiko
>review and reproduced with v1 of this patch. With this patch neither
>report appears on virtio-pci or virtio-mmio guests, and the vsock
>vmtest.sh single-VM tests pass. A find_vqs() failure after some
>virtqueues were set up was not exercised.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
>Changes in v4:
>- Say why the early return is needed: the detach loops would pass NULL
>  to virtqueue_detach_unused_buf() (answering Stefano).
>- Say in the message and the comment that freeing virtio-mmio's IRQ
>  again only WARNs (Stefano).
>- Move the send queue purge before virtio_reset_device() (Stefano).
>- Message: the use-after-free also reproduces on virtio-mmio.
>- Rebase onto current net; rebuilt and retested on virtio-pci and
>  virtio-mmio, and the vmtest.sh single-VM tests rerun on this version.
>  The moved purge ran with an empty send queue only; the ns_* tests of
>  vmtest.sh were not run (they need root on the host). The reproducers
>  are available on request.
>- Link to v3: https://patch.msgid.link/20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de
>---
> net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

