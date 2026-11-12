Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504224;
	b=wshC/2ndNq8SiGT7U8NtR5p4axeEwyskj2/zFmAaGU7WY6LOZMLUw5M1ZMe7gfR3HH2J
	 VdSWnViQ19UnhGM90LE8EN5VPrGuZmdG8C7PHfIFTkWKijMa0wMo+g/f/z9mYrH2Dq07c
	 4s3B+tKvYW4rqJGdJ/K0hIulLaq07HomQeAYwR8iJjEhUObPgQ2JC3bHrlKkLt99iFvuL
	 DnjQixOhieHQie527CXZ0aZWXpbZMMSWa9OIAyKfR6R7gfcUDCd21waKZFcRLFTGpjIHU
	 W9D55/5/8FFJk7DqwuS1Emm5pMkLEB9ekvkDnXvXgerzw5NmTgeHyXpLxh0UCdtyMVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504224;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Afhs0UD2/muICMANXtYRGRJeNv91U/qFXGHXS8V9iyc=;
	b=Xx5y6BVtnBZjBYIQk8lWni6guWMGD1MuveMPOuBkAsK3SgFBFghGOXxwkAQ9RPAI+MRr
	 WV7K1FzmsjD5GCwuHoghivn3uP1arttONPTSbzrQT3SYPWKqWj6hGZMePVHXWCe6agCs4
	 L8vn7tzj5ExHeAnyXVwMQkUNPO3lxey0xKuHc4DmjlefCYK2yVN7jnv6B1L9D8U2CisE3
	 YDb76dvL4qPCaVtqy3WNvL1t+9l57smokBUMr6rsJUY3XyMZWs+YQk56xtS7lUVs1UKJo
	 7SMvtaoYN9b5j9lDS+dqf4/Qv7QPDNiK2MLEc5sTR5Ro+meGqwtPv3VJcx6DoKHSFcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nwr2sskv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=adDmi+5I;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B89606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B89606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nwr2sskv;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=adDmi+5I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794504222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Afhs0UD2/muICMANXtYRGRJeNv91U/qFXGHXS8V9iyc=;
	b=Nwr2sskvXVZVh45mCfUNgB1NafoQAZ9hM8329iDWJ9ii8BjTfNZ+e/26dO9CiFzbuSnZ1r
	wCO103OVIJU7Vrf+LXeJ/mU+PzEMutEWLTitIJftXAS+WUrK/mJVEb/UGcvVd60plCyqfg
	VvcO8GLHXcNq/0qawZ4fXdkAs0SyGMY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-2GezOfsROXWhMpKEU-YtcA-1; Thu, 12 Nov 2026 12:23:39 -0500
X-MC-Unique: 2GezOfsROXWhMpKEU-YtcA-1
X-Mimecast-MFC-AGG-ID: 2GezOfsROXWhMpKEU-YtcA_1794504218
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae6fda7a00so570a91.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794504218; x=1795109018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Afhs0UD2/muICMANXtYRGRJeNv91U/qFXGHXS8V9iyc=;
        b=adDmi+5IuAkZhQxUrUkZpuLzCN90cyBbb3ei2b/lJqZZMeuYzu8jJ4lhXcgHlblB2N
         hIwxvuoF41WhsRAbBKOa+xfY+TtEX3bXzeK5BKNWxzoM/4UWvzSX8s/2LIrJ/ERL/6Z9
         6jmD28bJYXE/T4CQ06fMBYt4mvSXq9y1YUKRygUh/5BU04kBzl4yyjJdjXqgy6EAg7l1
         QnaHDJ8NuFjOdu9Pe0jpj3VTt4HbDewZ2r/IS0ZSv/ViuGa6rjprtqTCtGCMX0j/rdKN
         0pez2P5UFrB3RIbzBwYqMOMl6T8ti8OwoZE4b4SrhqzFyuyUkxMkXmB4a31uHnHabLl2
         L5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504218; x=1795109018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Afhs0UD2/muICMANXtYRGRJeNv91U/qFXGHXS8V9iyc=;
        b=0SIDSxxBODIDIVsm2GG71KCRhf7nUEydOtuveu4Rg8CSXrggpfo4Yx/3IAtQly1one
         Vd+h/QYqkus9lLNYOPzk6baQCpG/dXYc9oeXvIKRNtM7wfvOtGGoQbOiwNooeP7OEifz
         99F6V836f31f93c81eVN1FzrQ6nQkigb2nLlrP7KkS9RJ6w0QBnkdlgEhNwOW1rNPWTZ
         D1oDZtz4bjvEDd6KW7jRNZthHjODb9XU00JQ1+PBe1ybUorvtPeZJuVaL3tYbC4j9o+y
         +lsqVhhuIjdawcET19Dgop2Oam8a4KwgHzD1/ZcVu2G68c+jSKnR3L6ov8HXBOxkPeZD
         66Yw==
X-Forwarded-Encrypted: i=1; AL+hErHXMyw3cIlQtlU+c5QgJg//3acNMHkCYwazPbVpz/UgmqHoo8eYRiV9/CNRm8DVK/DTaTl7Nu0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bSbyzHxSbkz19EZyDNJGiFVi7KbbimZ/LOfntIAY6/GMCxe/h
	HoGdnLd5xr6vFFv/kuDxHelkXY3SdKulsiCChgtDGmfgn6Fp/M8UeJOxAJD0jy4g8h3JDQ5SCiH
	vJ5+GXjVMDyIHn/aNWfm2+gs9ENnO9vNF1RkFasRJDSfvwasj9u6LDi0kaA==
X-Gm-Gg: AYBFou1vpbzJGz4grrf4sjSKwbLyLK0QagCj478Zpkb7wD/srjDDWh9q5IyY9NdQHOy
	2hWfuhm/Ejqmc8NCtvIo8ShgB7Fo02nFt7Hd5acqIc8waRItk52MO2qzy5nAy0W6YPjbmRevpHZ
	TleM4mFQzb3LsFxJP+sNK8a+PVAXpoEKYFHS54vARZiL7rw4IXmT8n0chGHKJCYS8zzgsrmhN26
	k8SQV6UZmIo5FZ/w13oPeTj7vCTLWph7SMZSejCU6FcCinZcy5aFzRYYnLCownf9BenWgW8CW8j
	YqqAW2XH4P/n0AYyH490DvCTkpuoa2j/lp/KWd7+EEZUOXKFFp1t0/dc+vexEYjemsGfNJlyM0Z
	NMjJ0lQ/EWBgevedJ8nDg8vEhkk/ML+6gVH/jwwtlPLAFaGLwI9ZF
X-Received: by 2002:a17:90b:2f04:b0:3b0:9317:5849 with SMTP id 98e67ed59e1d1-3b182e1076dmr5100308a91.1.1794504218204;
        Thu, 12 Nov 2026 09:23:38 -0800 (PST)
X-Received: by 2002:a17:90b:2f04:b0:3b0:9317:5849 with SMTP id 98e67ed59e1d1-3b182e1076dmr5100284a91.1.1794504217598;
        Thu, 12 Nov 2026 09:23:37 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d04336sm5592725a91.7.2026.11.12.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:23:37 -0800 (PST)
Date: Thu, 12 Nov 2026 18:23:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5] vsock/bpf: release sock lock while waiting for
 data in recvmsg
Message-ID: <avXyzxvIN3ngFepE@sgarzare-redhat>
References: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
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
In-Reply-To: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>


On Mon, Nov 09, 2026 at 09:08:29PM +0100, Jerome Mohm via B4 Relay 
wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>vsock_bpf_recvmsg() sleeps in vsock_msg_wait_data() with the socket lock
>held, so the virtio delivery worker, which needs that lock, deadlocks
>with the reader and all vsock rx on that worker stops.
>
>Release the lock around the wait. The reader can then wake without
>data, so the wait loops until data arrives, the timeout, a signal
>(wait_woken() returns at once while one is pending), or a state in
>which __vsock_recvmsg() would not wait. Those states, and zero-length,
>MSG_OOB and MSG_ERRQUEUE reads, go to __vsock_recvmsg(), as Alexei
>suggested; a non-blocking read now sees them before -EAGAIN. The loop
>and the zero-length check belong to the fix (without them the reader
>returns early or spins with the lock held), so this is one patch;

I don't understand why that fix can't be in a fist patch of the 
series...

>MSG_OOB and MSG_ERRQUEUE just share that path. One tested difference
>remains: a reader asleep at a virtio transport reset gets -ENOTCONN,
>where a native socket gets -ECONNRESET (0 on seqpacket).
>
>The deadlock and the MSG_ERRQUEUE case were found with the help of
>Anthropic's Claude, the rest by the netdev Sashiko reviews and Alexei.
>Each was reproduced in a VM without kernel changes or error injection
>(the resets unbind the guest's virtio-vsock device), except one Sashiko
>case that was checked in the code; with this patch they behave as on a
>native socket apart from the reset case above. The vsock vmtest.sh
>single-VM tests and the BPF sockmap selftests still pass, though they
>never sleep in this wait.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
>Changes in v5:
>- One patch, using Alexei's approach: in the states where
>  __vsock_recvmsg() does not wait, and for zero-length, MSG_OOB and
>  MSG_ERRQUEUE reads, fall back to __vsock_recvmsg() instead of
>  copying its return values (Alexei).
>- So after a reset, recv(), a zero-length read and MSG_OOB return
>  -ENOTCONN, and a peer shutdown with SO_INQ reports SCM_INQ, as on a
>  socket outside a sockmap. A reset while the reader sleeps now
>  returns -ENOTCONN instead of -ECONNRESET.
>- This also covers the netdev Sashiko review of v4: SEQPACKET after a
>  reset, MSG_OOB on a closed socket and SCM_INQ on a zero-length read;
>  SHUT_RD with a pending sk_err by code reading only. A SEQPACKET
>  reader asleep at a reset still gets -ENOTCONN (native 0).
>- Don't cite the selftests as coverage of the wait (Alexei).
>- Link to v4: https://patch.msgid.link/20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de
>
>Not tested: virtio-mmio, repeated runs, a sockmap delete while a
>reader sleeps, a signal arriving in the same wakeup as the timeout
>(returns -EAGAIN, native -EINTR), and the vmtest.sh ns_* tests.
>Still left for separate patches, as in v4: data that sits only in
>psock->ingress_skb, and READ_ONCE()/WRITE_ONCE() for the lockless
>accesses.
>
>Changes in v4: comments, one data <= 0 check and message changes
>(Stefano); rebase; retest with a new dataless-wakeup reproducer.
>Changes in v3: split into two patches (Michal); end the wait after a
>reset read with SO_ERROR, and MSG_OOB returns -EOPNOTSUPP (Sashiko).
>Changes in v2: loop in the wait, len == 0 guard (Sashiko); MSG_ERRQUEUE
>to the native path.
>---
> net/vmw_vsock/vsock_bpf.c | 43 ++++++++++++++++++++++++++++---------------
> 1 file changed, 28 insertions(+), 15 deletions(-)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 9049d2648646..c0c9e69860dc 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -34,24 +34,35 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
> 	return vsock_sk_has_data(sk, psock);
> }
>
>-static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
>+/* __vsock_recvmsg() doesn't wait in these states and knows what to return. */
>+static bool vsock_rx_done(struct sock *sk)
> {
>-	bool ret;
>+	return sk->sk_err || sk->sk_state != TCP_ESTABLISHED ||
>+	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
>+	       (vsock_sk(sk)->peer_shutdown & SEND_SHUTDOWN);
>+}
>+
>+static int vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>+			       long timeo)
>+{
>+	int ret = 0;
>
> 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>
>-	if (sk->sk_shutdown & RCV_SHUTDOWN)
>-		return true;
>-
>-	if (!timeo)
>-		return false;
>-
> 	add_wait_queue(sk_sleep(sk), &wait);
> 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>-	ret = vsock_has_data(sk, psock);
>-	if (!ret) {
>-		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>-		ret = vsock_has_data(sk, psock);
>+	while (!vsock_has_data(sk, psock) && !vsock_rx_done(sk)) {
>+		if (!timeo) {
>+			ret = -EAGAIN;
>+			break;
>+		}
>+		if (signal_pending(current)) {
>+			ret = sock_intr_errno(timeo);
>+			break;
>+		}
>+		release_sock(sk);
>+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>+		lock_sock(sk);
> 	}
> 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> 	remove_wait_queue(sk_sleep(sk), &wait);
>@@ -80,6 +91,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	struct vsock_sock *vsk;
> 	int copied;
>
>+	if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>+		return __vsock_recvmsg(sk, msg, len, flags);

... I mean, why this change ^^^ can't be in patch 1/2?

BTW I'm not asking to split it (at least for now).

I saw some comments from sashiko, can you reply to them?
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad%40eldare.de

Thanks,
Stefano

