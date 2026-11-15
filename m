Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730963;
	b=yg1CVFqlxqYT23AI2HN0KzfPTjXVlXNWuycBlNjUzGiazGR800AC8GVw9gV+1vWG7Vh7
	 uuAd/uRzyRH72F+jVtkJzGGLdF2rzNbuDuTfNrWQWFN7ehN975cTvJ1WEQk5B+GrD9aP6
	 DefQgdK/uF8FmC7ueRHY0v444bswwu0N4MBGeby+9+alb891ECEUjzRWiM77KXkfLlkzl
	 iJ7FJx65bJbh5PMx+7Cnz9KrJcM5Mjkv0nUDVi3chE52WCcvHUMkaf6fLAH0qXqxmLdLG
	 NV45GWsblGjA5pIkoxVR9+ImcTFYxqvRVJIZ4YnE2/vX3dk45jWh+7h3Ds0R7qlgmIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730963;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hOqx9PI7nO87s05epf/KxKW2rSgtDSMLjv2nLVv2RsY=;
	b=Oqo9v6aZkhBNBq0lSjZTmnCFfgVgdV5LUAF34TBu58sEdfZngzvIEjR7HG1k+kcgSn41
	 a0F9woPKXmsxNLuc0Rsg59w+qPWzYlJf2D0Ndr2iEJ2sgfkjtHmNBmMlPzEO/iYi1Hp+T
	 R0g0AGIL5EA546X/bSvrQKpchJVb4diW9xhL73VQkKhhEqzu0H0lNHjC4W6wcmhGeY7I1
	 LMYdgwocqSN6so+nc6khCFzZcFE/tgrbEec1bqyN134ZaZjvufcW32L3H3XMeurtvv+Ba
	 9fXi2l7JNuvOqTUbGZfTY6Tfax5Wq6LEiJZtzGlMn++lVGUGNMK+ZqnRpOorkgkbkHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzae79s4;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DmTM11z2;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840A606A31F
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 08:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C840A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzae79s4;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DmTM11z2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794730960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOqx9PI7nO87s05epf/KxKW2rSgtDSMLjv2nLVv2RsY=;
	b=fzae79s4r33XIm4X0Qplugnvzcx6gmPVHrx9mtrZBkRTm4nlRPUcw1+SPvXJg7RI2vN7db
	cMANMWjWd4+a8HcnjUfAdloBcKJBlC61C8d9w+Yj3H6YmqZPNcP33FoP1P7YrLhbM37cjL
	fv+ZjYa3kgtVouWIOS3xtRXdYH3jv8s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-lM2BI4huNw6X_q-MlHk-Lw-1; Sun, 15 Nov 2026 03:22:39 -0500
X-MC-Unique: lM2BI4huNw6X_q-MlHk-Lw-1
X-Mimecast-MFC-AGG-ID: lM2BI4huNw6X_q-MlHk-Lw_1794730958
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so2093077f8f.3
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794730958; x=1795335758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hOqx9PI7nO87s05epf/KxKW2rSgtDSMLjv2nLVv2RsY=;
        b=DmTM11z2mj0Ygyj+SNk4FmJDtfZr0mpv1PUS2jGNBIKf8NMHOQcQqCCVH78jJnYr8w
         BcLd6CjxdqglHGwJ5zLoZ2EH+AXT5DksN/YWmNfMWshEiGPfB5wbL3ur3RXMt+eak/bo
         AJU3htHY47nwfMp58dD7JeMtvLCU83xjPwW+zQGwNZUK53OG10JeUWhK4dqc4phQswdW
         Ar/lr9h7EaYwautyYFc1ZvinugH7pbRkEDJxsZ/bXqOBotJbEZcAGAiALRAhePW6TbLY
         iL0iS/8I5xz+qWtOxPYrgduXx37RHZ69MBAqu39Tu6g0e1g5xBYYkd11SclSGtv3Hsdb
         8IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794730958; x=1795335758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOqx9PI7nO87s05epf/KxKW2rSgtDSMLjv2nLVv2RsY=;
        b=zqG4e+lgY71umZv1DcHR5amNJwjVFZs2lFR8gayDZEI6gShJP2oGED8D2aNgG7s+QE
         heIwr5nsB31AceS2wDsi8J68CqGJViR01hFxfIfn/zd3RCfX3P2qOvVwLMhUALll48qk
         LSvlhpeolixT1AoVOKaX8GGJKeY1DOtTGnBPCjov2hUp4tqIj7RSgX9XTr9tSpTtH89z
         0r0C/gM0V0Ug8wU2Co5YizyC6B/2hEtrmzvhqR6EttZejCUMfW540N4OHryD/mgEJJ2x
         qe/4W/TwtJwCzqEK6hOvx55CqncyuKAl82j3tkNQGaPcbGPXEi50cio6CfuITAEyBMbz
         u3pg==
X-Forwarded-Encrypted: i=1; AL+hErEGT7PLSHpu1IlT3tAlN5lfvYQVrhUmcHbP5U8lDYpNrUA8M31RGrLJIGBkeHm7P7dsg66V1oc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qJydI7iKIAKOSQWSQpsYmUDw8YzKwgsduuEqNsiNTnrlx6JC2
	AcaIQpUQmmTu0LVjmJjrObPTSCe7+ykUfiNrZSBLkWF2YS6QEJPcT/f+/JXUxY9tijl5dM8iVAO
	1Wj+BbVKD+uZZjwERrqQHwlnZIdebhYJ8ahDdPDhdOm7X6lNCGU9phh8pkg==
X-Gm-Gg: AYBFou3rrqyohrtKfJ7V4IrjXZQPHvpAaABGPjWQ8bgD4F4d+eWtl0IikScgyjz7viO
	eW7R/yspU/nCQOfpGvzB0pSARC1rMj9Tn/uYxplCuekJkLllvCDA+ZKxiaZUnl8J2hwCjGpYEQy
	51leLeI0dI5+Ij2DW/RK0H1oRp4wqfRFbC/vTYJhdACrNKCp2CZRkQfP/PyFRDYEm25Ol1oJJr7
	fISIB643/0TEZCXX283l0J70T9p+ddIcN87k4mrj32KlNbNTR5n1ZebWD5vdZLwe+6kpC21c/Ck
	gwilfneKxD6ZZDtrOn5OWwp8qYz+CWOy7oNGjzUg7yw96R49mnSGd1pbvVHw2oTIlXIopNqDy3k
	sV1bIxuS2KzkzSMzx5L+NuQcM7gyiIJHpXxPDRf4kRUfZMi+cukZFVQ==
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr155906545e9.34.1794730958279;
        Sun, 15 Nov 2026 00:22:38 -0800 (PST)
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr155906215e9.34.1794730957813;
        Sun, 15 Nov 2026 00:22:37 -0800 (PST)
Received: from sgarzare-redhat ([193.207.75.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm297980195e9.15.2026.11.15.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:22:36 -0800 (PST)
Date: Sun, 15 Nov 2026 09:22:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: reject datagram binds in local network
 namespaces
Message-ID: <avlpwYZr4pSpunEl@sgarzare-redhat>
References: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
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
In-Reply-To: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>

On Fri, Nov 13, 2026 at 06:04:40PM +0100, Sergio Lopez wrote:
>VMCI already rejects datagram sends from local network namespaces, but a
>datagram bind still creates a receive handle in VMCI's global port space.
>A VMCI sender outside the namespace can therefore deliver to the local
>socket. Its handle also prevents a global-namespace socket from binding
>the same port.
>
>Reject VMCI datagram binds in local namespaces. No namespace-local
>datagram transport exists, so EOPNOTSUPP reflects the available receive
>paths. The receive callback also rejects any local-mode socket as a
>defensive check.
>
>In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
>delivery and the global port collision before the fix. After the fix,
>local bind returns EOPNOTSUPP, the global bind succeeds, and a global
>VMCI datagram still reaches the global socket.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
>Signed-off-by: Sergio Lopez <slp@redhat.com>
>---
> net/vmw_vsock/vmci_transport.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/net/vmw_vsock/vmci_transport.c 
>b/net/vmw_vsock/vmci_transport.c
>index 1f186e8f8364..282131544c42 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -627,6 +627,8 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
> 	 * outside of the create and destruct socket functions.
> 	 */
> 	vsk = vsock_sk(sk);
>+	if (!vsock_net_mode_global(vsk))
>+		return VMCI_ERROR_NO_ACCESS;
> 	if (!vmci_transport_allow_dgram(vsk, dg->src.context))

Why duplicating the VMCI_ERROR_NO_ACCESS return? Can we just put them in 
OR ?

The rest LGTM, if you respin, maybe we should mention that also 
connect() and sendmsg() are affected since they call vsock_auto_bind().

@Bryan, @Vishnu PTAL.

Thanks,
Stefano

> 		return VMCI_ERROR_NO_ACCESS;
>
>@@ -1697,6 +1699,10 @@ static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
> 	u32 flags;
> 	int err;
>
>+	/* VMCI handles are global and cannot serve local namespaces. */
>+	if (!vsock_net_mode_global(vsk))
>+		return -EOPNOTSUPP;
>+
> 	/* VMCI will select a resource ID for us if we provide
> 	 * VMCI_INVALID_ID.
> 	 */
>
>---
>base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
>change-id: 20261113-vsock-vmci-netns-isolation-7e46732dcd73
>
>Best regards,
>-- 
>Sergio Lopez <slp@redhat.com>
>

