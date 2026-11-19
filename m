Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079435;
	b=43Qrybl/usLURgQSY4xunZpq13uEOZHlFSFo+205KTx/LqwWNyuLFZ8tauFdjW5B05sC
	 gmQzLxgei68FLvLloMjn74fAU/6XCQ/jsAQ73cuattl6XzcOhOAbxna0YG0Ej/jhPokUU
	 EhEVlMUdrWwxe0gPoAGPQc3Cml838FT6yxA4z6Ha8mZ2YI2xeDGH/8O4yKN/ywGY1EyxA
	 JizVDbujbx3WFyT5RFURav7HuWtBnWK6UZ5Wf7TGNPPAlUSJ3CxOYoJbGsK6NePn/gd+I
	 s3A4az7dWJcr+Cx2bMgFvZazgtWeGco5zhQyllcP7in8pyUtAyAQSdwSAq6bC9255ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079435;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tuBOCCiH6AYUcrUIRQklRkNbz1Dojigm78BR7t4qnhM=;
	b=dMxz8aeh4yP2KJHaPZ2QeoKNmsRcqZjgplpsWlXjFGkJMAenIxrJQfnB+tjBQMg3uIVi
	 QVSOW++Xa7XJsSY+V8573i6nKaIHChngE4jjslU5uTqaaSViCqZwly20aP0mCGz7pIUpF
	 A3kQ6wsOeXkOpdeDB2wOpgWzVz3QUccQnsJJCplKrRZHTwneOBeI6MJOirJw32RqS1GgV
	 5/KfXX4JN8j4yUDtgGrz04NNXZELTKBf+O1nmipmkPFSN6caTaH7fKoiPF3EYWu+/CCDM
	 0Rm9BOCtolgdR4xTQwq8DBjX+Z5R72ZhnNVeib4MtiJqh7jmTmEbA5maEiblCTMABgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P64Dlkd0;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S2tpJH4W;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92531606A332
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92531606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P64Dlkd0;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S2tpJH4W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795079433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tuBOCCiH6AYUcrUIRQklRkNbz1Dojigm78BR7t4qnhM=;
	b=P64Dlkd0H+Yr1orC347Gfysn/DDU7S0PFINxC2C3+7Rwnok16CvZL61foZ0ZYEbwueBMRQ
	J6fQHZ28HiJcrjr4NPe9AQ+hGOuL70REvlNSS58lUl/wZpKxfJHqLpmXL3ZTTMVqLF+iYF
	RsYNyrOVdPHLmXle+ASKAnLzlrBhd94=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-x2xFybYJMEWTZdmWpi9mDQ-1; Thu, 19 Nov 2026 04:10:30 -0500
X-MC-Unique: x2xFybYJMEWTZdmWpi9mDQ-1
X-Mimecast-MFC-AGG-ID: x2xFybYJMEWTZdmWpi9mDQ_1795079429
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4a3052225cbso1787007f8f.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 01:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795079429; x=1795684229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tuBOCCiH6AYUcrUIRQklRkNbz1Dojigm78BR7t4qnhM=;
        b=S2tpJH4Wj6jciNhL/J4DjTGLFb3gFzo/LgkP9ow8OTPov7qEGZJckh5wjM75Xa3QHp
         8wXSJRthuAGTzqs+NHkEp9uOE2/ayyCcyx1feo5KuZTHAv89ydrHab6WETnQ2gNZHeC/
         QPe9Z0XuEaZLj5Gd/ozaNEV1BvoJO2aDBu1Zj6wXCALmqGv1E3f6guEJIAzy0/cfXOay
         c/fzvbbUszZZROATz2kQZML2KwVQ8l+GlL1gNGaCUpfCnmvFQ/NlMUTj6Nm2rgQSEJM8
         /YPpo7sOoeR64D/4g64N9wUNvR0XtN3/Yb5gSaCsPKnoJtnLC1Iw8KMwk0v9NXp7alcs
         DaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795079429; x=1795684229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuBOCCiH6AYUcrUIRQklRkNbz1Dojigm78BR7t4qnhM=;
        b=NZNhEr/BZN/N8sh3w8wBdUSQieikWTSP/Ajk+vMVCs+MYrE7wKmqOAcPdr/VRMWT7b
         h2Ot/P531nyG4OM0y0rLX9JIN30YHH8fMDCI1b5aZaW6V1taptlUwUj2rppVFrnkZdYW
         Bx133JmFTW0YcNwl7NxHXIgdd9srGQ0aXINCQ7n4unptvB8n2ql7W0aQhOrjI+3I+2U1
         9Vobzynl1ZxVqg9DX4aSeeyRomHxXFCACKL8bqXtMpFn28eMTp+Hpt59lvHY6tK7+SYG
         nPuE31Gqc/aE+7qvweTyqom7uSPmvLo2Ta+JciIG85f4AVNtGslKQqaXdw2mywb/oQ84
         JMVw==
X-Forwarded-Encrypted: i=1; AL+hErEUfvsgWYEDixhiq21nc+FpUjfsE2GXHlGnSYscRCba7rOAXPAe/mPY311kihNcEG+0gVpJY+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yY6DcJpnWvDdSM0kmsBJb7GVY13fGguQg8tEMsi+GO5wQarPw
	LjjDdxLqb7XJvAA8AGP36Bc4fUuedV8QZnONAhjnRzwJbzkZRUSZS1aEIcWcQM+a0Iu/bgBE8Cs
	CMpP7Xlvt1spC+CEbj4/DBU0YpVOUFFJQ0W9zSGYtKx1Eesm2lW+86o6/eg==
X-Gm-Gg: AZFdTZctaRTyzEvvWDS9cUYJHD7RmwTEekHNrOQ9VAyv8kHTUOANBOHOoW7zh2DRn8q
	u03/3eg5EH1JvT7pFKu0mbDMZN8oTo/dVaCFu57zlVzs3U8HYyMgU57eJm9pcY8RrojMTj9J1ir
	h6Pxx2YNYxreNivdhrRUhISVt79EaF3UnzBMRH5GOP8JgGVBgDYJkkyxpsounY2aG3fjJI0NMPg
	8Cr45kk/aZEID6xf6Uqv/q5sy0r+1b+K2OOMuSMOK2EfIkxF6XoUaw7tbPMC/FbbmMqqE2/r7ky
	6eXbOPU6HtX1ru/8M11ay6ffSQKC+38amnvrEDsTkn3HgvO7jm57kTro5UaBrMfwDwX5G/az6Vq
	6W6p29FfovFWMNQ6OETbClKWo0ircG2LGBF1Fw/JljkdjbSon7nfxiQ==
X-Received: by 2002:a05:6000:4812:b0:490:50c1:f359 with SMTP id ffacd0b85a97d-4a63bea9888mr10985199f8f.39.1795079429137;
        Thu, 19 Nov 2026 01:10:29 -0800 (PST)
X-Received: by 2002:a05:6000:4812:b0:490:50c1:f359 with SMTP id ffacd0b85a97d-4a63bea9888mr10985146f8f.39.1795079428655;
        Thu, 19 Nov 2026 01:10:28 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a655db6d45sm9145491f8f.33.2026.11.19.01.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:10:28 -0800 (PST)
Date: Thu, 19 Nov 2026 10:10:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] vsock/vmci: reject datagram binds in local network
 namespaces
Message-ID: <av682hncPM1ksJtf@sgarzare-redhat>
References: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
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
In-Reply-To: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>

On Tue, Nov 17, 2026 at 08:01:52PM +0100, Sergio Lopez wrote:
>VMCI already rejects datagram sends from local network namespaces, but a
>datagram bind still creates a receive handle in VMCI's global port space.
>A VMCI sender outside the namespace can therefore deliver to the local
>socket. Its handle also prevents a global-namespace socket from binding
>the same port.
>
>Reject VMCI datagram binds in local namespaces. No namespace-local
>datagram transport exists, so EOPNOTSUPP reflects the available receive
>paths. Unbound datagram connect() and sendmsg() also return EOPNOTSUPP
>because both call vsock_auto_bind(). The receive callback rejects any
>local-mode socket as a defensive check.
>
>In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
>delivery and the global port collision before the fix. After the fix,
>local bind returns EOPNOTSUPP, the global bind succeeds, and a global
>VMCI datagram still reaches the global socket.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
>Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
>Signed-off-by: Sergio Lopez <slp@redhat.com>
>---
>Changes in v2:
>- Combine the VMCI receive checks and clarify the auto-bind effects on
>  datagram connect() and sendmsg() (thanks to Stefano Garzarella).
>- Carry Bobby Eshleman's Acked-by.
>- Link to v1: https://lore.kernel.org/r/20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com
>---
> net/vmw_vsock/vmci_transport.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

