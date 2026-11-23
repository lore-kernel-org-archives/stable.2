Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450641;
	b=exueAUd72Ps1hMxVAmOhO2WeAdzF/AG0rTMnT43axXuBTT4/XaFHaZQbq2wMoFyVUgFr
	 2/B4aQtF4T471ioIet1aVHiJkT9GSC9n5ys7yNaT3PGaP143RnmOA62KND2JpVESxEC6T
	 4XcRdN2a9dVgymkN6fkQz1tfcoKRzr8FYFdoiFxTEHdByPti5LR5oWcvxHADrKGC607gg
	 H/W+on8KxB93VNmmvtfGy3eoQ09ZgJvsf2bPHMZdEwXOWwAzrxDBifL/yHmYlisvA7YIr
	 i1JNrPFJdQ0b2FgZ1fSTR52jgKw2I/0ODI2GndigWhFsiV+SAMgaCn1DL2llV4OOwUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450641;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
	b=nthSSr23Tm0b3egkZqEb6e7A60AX49b/ft+SuVgbQsma3UV9ZlAnJq43amQGmf14P40L
	 D6iXdCph2FH6n4XsdPPLhmwrN14wX0XmyFglraRdXkVlHEp/E/j+qSxKRmFv9uw7UpLHu
	 NUfilOtRMYgcXcq6mxNPZ2rk1Su4n2cQ9btJ3Kv0p9DnjwjlkI8cwn2C8zbrfMODj/58a
	 vrI2r85UpbP9xAogy+/7L8pslCFgoGw1BSl0HmCrTXWCXT1geHNzA1w/GyNKelPu8ZPnD
	 mbP3uJ5IP/+O8aP3ZG+t+V+Eo3+EwoZ0kCB4Crtbx73j05oxWm0cpivaGAH4NvMbYCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d0y4f7iL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EFWjYSTs;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3773606A33B
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3773606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d0y4f7iL;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EFWjYSTs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795450639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
	b=d0y4f7iLfivHQWBFjZe0Gb0OBVayfWhwiCEqqJPb++ZTF43w9Evr2zOYx/xaqsOAMzMnWO
	XUq3Pj8B/mM93fSY62IjCEmz/wM6AFBX7ho+YTAqAj1P9+aiPlCOgEwb3QN2JdW8KPYe/E
	5pdEqWMJK7WCfhOPW31VK2v1cVqB7Rw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-WUbOqgssMwCV1FhaB-Gl0A-1; Mon, 23 Nov 2026 16:17:16 +0000
X-MC-Unique: WUbOqgssMwCV1FhaB-Gl0A-1
X-Mimecast-MFC-AGG-ID: WUbOqgssMwCV1FhaB-Gl0A_1795450635
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso5482425e9.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795450635; x=1796055435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
        b=EFWjYSTs6eZbKtZfTzVI20evhQuKBSbQFwBnL7ixe6pYNqb3IX5FdNJ1NXk12la/fo
         mtcq8GhB5fbnQhWtE3XAnfyxUDceh6nkUkIoCsejjiZ5xIUIo3D/lpZrrdqy6JZ1Uw13
         i8gGNOQfWASM9FbNeEqtG58xOZ0gLZR8bMdPEOX2aXVh5toHQitzAoqzO7HXU7XK/nni
         2yJbyWsuJtKRhA10Zs2K92JS5vL+KOQjUYEnkDWYjbNa0+6B+VTKq8E5pBfICJiVZpG4
         jYCFjpoDjxCISpe4VOF/NOPsukP9LGBo41m8ux/OAQcxreEp8Ej6xJTjSYH05IAQwH8/
         xjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450635; x=1796055435;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GHb/SYd6gXinJYqxw1GDlcMLdqBI2V3zFyLkxFbZ0k=;
        b=MqOMwiEe11s++/ee+5d5sKDMjkCDEXRvHEESGhTWSLeaOXM7xXwjkTzKTRwsp5tit/
         gi/wCBCbYmQLX6FDfuZsSSBCTu89VEnVHiiRIx3vpofam+mUr2zNcFLgkUaiUbG+XtZk
         CpJO+maepCrZ103WIErQWO5+TpXRi14dYTOyagSt84L5GXIM3sSWie7FRs/2JAHafm8p
         IfL/nGJSG7OoAm+eBvLmFnaBEeUwswTa5suy3N03PXpf7KvFEQjve9re5iI1bVLiDWCM
         98omhe3VexXXkIR3fE8dgniKcoN5OoAAJRIHKUTOC2wzzpz/oHcRSM/Ljd1rm3g7vAYE
         zglw==
X-Forwarded-Encrypted: i=1; AL+hErFH0UwqiXtzQKxAGznydp0AMwS7OT+poIKVuEZXt8KC2GRoHaY+vSzbSe4zWeBQfEjQKdLAOuw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FWifCkEecQ2CHlvpibImYc288OZT2XUknN6V6+esYD0grYToB
	V8O2g9+QGe+QmH+uEpCRtAmiogcy9BYRMI1hvMtQBno6tiTAY3KIzM4iTPapn9w7l0Lqu4XaiDC
	2jkVl9hC/Mzv+J3hXRVc1vzM71FzVmfRKPQCcInCvWxcQgYlLOKTCk7vMiQ==
X-Gm-Gg: AZFdTZe5od55leo3KJ9xLU1x0GE6Sv2oki4u7fL4OaKvLcm7fIXkz4eLUbPw4wdfog0
	TuUfZjwY1OzmSCaRF+3DlmfliQCLDKwQRXXS3vYP5zxgEtqmBe9Dfn5DillVeTK7y529CMS/tVD
	enLXDDNNjbr1FA0QhO2I9MiFM4JkwIVGxsHszL+3OeYcwaM1bKl589M557EDWQfdOZU1SufKN0K
	s6GxjGgZkx2CQdqQi1fKm+2Qs7gOFNxPvCE17pExbrpQcK6QeAmt4bIZnRvEWixP+QQMKpglK8G
	uXUFN1JI6rb4GdkPD5sZa6qqoLjTMbV/4CCxGbC9qSdrvcFHYNNkJDb5Kn56cg8Jdefueqlq6gF
	l9xKdddvGHC4KuPy1QaOBD5mkB0EKh1r0yt3FV/7/84ree0GRB8RqOg==
X-Received: by 2002:a05:600c:674d:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4bb88808263mr270420345e9.14.1795450634806;
        Mon, 23 Nov 2026 08:17:14 -0800 (PST)
X-Received: by 2002:a05:600c:674d:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4bb88808263mr270419595e9.14.1795450634202;
        Mon, 23 Nov 2026 08:17:14 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm209571105e9.4.2026.11.23.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:17:13 -0800 (PST)
Date: Mon, 23 Nov 2026 17:17:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads
Message-ID: <awRlwL1epH1j61Z7@sgarzare-redhat>
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
 <20261114-kbh3-1-022-fix-v2-v6-1-96b6029bbffa@eldare.de>
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
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-1-96b6029bbffa@eldare.de>

On Sat, Nov 14, 2026 at 12:59:14PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>On a vsock socket in a sockmap, vsock_bpf_recvmsg() sends zero-length,
>MSG_OOB and MSG_ERRQUEUE reads down the sockmap path whenever the psock
>queue has data or nothing is queued at all. That path copies from the
>psock queue and waits for data, and it handles none of these reads:
>
> - a zero-length read with data in the psock queue spins with the
>   socket lock held, and the delivery worker blocks on that lock;
> - MSG_ERRQUEUE consumes stream bytes from the psock queue, and the
>   zero-length MSG_ERRQUEUE read that MSG_ZEROCOPY users make to collect
>   completions gets -EAGAIN or blocks instead of reading the error
>   queue;
> - MSG_OOB consumes ordinary stream bytes or waits for data, where a
>   connected native socket returns -EOPNOTSUPP.
>
>Hand these reads to __vsock_recvmsg(), the path of a socket outside a
>sockmap, which does not wait for any of them. They now take one path,
>so the order of the checks no longer matters.
>
>The MSG_ERRQUEUE case was found with the help of Anthropic's Claude,
>its stream-byte and MSG_ZEROCOPY parts by Stefano, and the zero-length
>and MSG_OOB cases by the netdev Sashiko reviews. Each was reproduced in
>a VM with a vsock-loopback socket in a sockmap, without kernel changes
>or error injection. With this patch alone they behave as on a native
>socket. The vsock vmtest.sh single-VM tests and the BPF sockmap
>selftests pass with the series; I did not run them on this patch alone.

nit: IMO talking about series/patch is confusing while reading when the 
patches will be applied.

>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..c9b399f37720 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -80,6 +80,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	struct vsock_sock *vsk;
> 	int copied;
>

nit: a brief comment here with the reason would be nice

>+	if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>+		return __vsock_recvmsg(sk, msg, len, flags);
>+
> 	psock = sk_psock_get(sk);
> 	if (unlikely(!psock))
> 		return __vsock_recvmsg(sk, msg, len, flags);
>
>-- 
>2.56.0
>
>

Code LGTM, if you have to respin, maybe you can improve a bit more.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


