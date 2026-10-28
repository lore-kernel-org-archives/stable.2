Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210153;
	b=Exnr3RwQUcSlWQaBOEmVbmaduh5XEL2R1BBKmpHyP9OPoQDsd1+NAmGhdrAgdWfptq8p
	 h7SWjdTtdgIo0ow1wOz1kCuBsaI5RL2vBoUW7MTvsxluajLnAeEHF7USXNuayhSQDxvL0
	 M2MYn/BXGrdODsQkr9XljzZcL4+d5DWk8RkW62zmTnCE0GcJv0K90n9/GkrAR7NQ/P4zh
	 HzjYWa+6k3AWE3iJVM3c849gtndA/4GfffBvwRtc4pBj4VJT8Sb6HmT/so0B7qxEuxE3k
	 nk7CDNBgfKVFwoCfIpyPp0bYwR7uXBqCkQWknLh/v2jSW9dyiByAMnHWzJRb2+8n+ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210153;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=17jbkdkItPENhd4Vh8NAsHyi7gmdt8hZfEFg1sHhfLQ=;
	b=eqGX29Sqyl700Ai2aqr7cDA8epHbMAi2GhPUY7ZQNtyGXXR10WpW5GOG2Kf72oAnWUMT
	 LLQK6uwinNn6A1laNlF2olzcK1W7MJIHjhRA1U1tFgei+BB2fjBH4+FO5vpHhtH0tMiy9
	 QjsqnVmNcLien6OYS6bc12EboWf0r8nvFDdEOTUUTm0FVetxQ+jEPvoUi3hcTvJThX7+H
	 DwyEj6kjSoxybEzSH24MS7hsBQF9hkzB+pLtNXlkF4FuGuyAJ9LYM8NbPv6H/0HyRBisr
	 2ZnrPGWESbVNWSyElf9uPQhgy+fL/asgDvOtQ71G9esEf6yCt+a0eHdKh9oYCR7jXIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=oYzKOgow;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.171
Received: from mail-200171.simplelogin.co (mail-200171.simplelogin.co [176.119.200.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196C60A260B
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6196C60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=oYzKOgow
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793210146;
	cv=none; b=UC0eApm5dIZwWLlFOhahU4En3V6504bc3d+Ld4YrJKT7Mvm7cGBnhu/+j4gcA8Ms7e5X3Y9Ycj0qKSDac+qJ7XT8UL4hWOf+ilk8wJUn6lxiCbH9xfntICQGSGXSrtb3Zkgv//9HKW6N0QPhLids/601Z/fVtY9TzO8hxD7fUNyQRHQFCgO7eTtGdzBOe0mB3tB6X/PYFNvHgLenCb3oKRXDUEIzT9C+izFe0dMca3Th0qB1Az63GxfsZw23JxCcRoEyBrq48w1hu+0CFRieeZ69UJqzBHVXOEqruw7UAAfgMABtQtBgkrwaJ3fmH9VZ34NsVpUahgQZ7QDNmDeO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793210146; c=relaxed/simple;
	bh=17jbkdkItPENhd4Vh8NAsHyi7gmdt8hZfEFg1sHhfLQ=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=devQZawep+mcr0bC8QBq2v/TQdEOe92b1LEsB6dE1JQZIcotXbooZcZR5T1HgFaU8463yJ4Jp/DeROm+9YGVjsk9CNwkX7gPbtTCK+iCqo7bVXPWrm19rBiqy6tnn1/+Ra6s14SGBtSCnHQnq2UwdzG1AuCT1kv+zDusW/OlUd+75TXMpiGUpumX298/yRAWbEdQe8PU9KkXv1wmAOXiML9TCTiW9E346g9e+7Lv5mH/6iQRufy5SgLMqcbjvGLnMmD19sGJ3pV9bhT0Cykgbvoy+EmLpOKtbNioeD5ZLcwIo23um+Icnz+urkA1Y8zaFUKWMtBJnUsBiLPBEwHWuw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793210146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17jbkdkItPENhd4Vh8NAsHyi7gmdt8hZfEFg1sHhfLQ=;
	b=oYzKOgowLD3u3eP2GABrI/IrDqcF1DMga26D88/cif3KN4lxtaKsToGpY7RQhIanEImtDH
	TRQr4DdXUPQCcJr0UMBNqLuG9BZSjTJvTTOpOBHCrGvfsKQWjJKNNojjOcBriX54k+j+1j
	0lxL+DNNMP9t3JmldQ7l+hknT7/ijsU=
Date: Wed, 28 Oct 2026 17:55:35 +0000
Subject: Re: [PATCH net] vsock/bpf: release sock lock while waiting for data
 in recvmsg
In-Reply-To: <4dfb9200-8bd1-4806-90d8-892529b79962@rbox.co>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: jrmmhm.kernel@eldare.de
To: Stefano Garzarella <sgarzare@redhat.com>,Bobby Eshleman
 <bobbyeshleman@meta.com>,Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,Eric Dumazet
 <edumazet@google.com>,Jakub Kicinski <kuba@kernel.org>,Paolo Abeni
 <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,bobby.eshleman@bytedance.com,"Michael S. Tsirkin"
 <mst@redhat.com>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179321014563.7.16847274233062903088.1728128549@eldare.de>
References: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
 <ar4gvlZL1JyPycg1@sgarzare-redhat>
 <4dfb9200-8bd1-4806-90d8-892529b79962@rbox.co>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1728128554
X-SimpleLogin-Want-Signing: yes

On 10/5/26 09:59, Michal Luczaj wrote:
> I took a look at v2 and I don't really have any functional comments. Well=
,
> besides the use of READ_ONCE, but that's probably something we need to
> tackle separately?

Thanks for looking. Yes, I'd keep it separate. As far as I can see, the
virtio_transport_common.c writers of vsk->peer_shutdown run under
lock_sock() from virtio_transport_recv_pkt(); its WRITE_ONCE() is there
for the lockless vsock_poll(). The writes outside lock_sock() are in the
reset paths: virtio_vsock_reset_sock() (sk->sk_state, sk->sk_err),
vhost_vsock_reset_orphans() (those plus peer_shutdown and SOCK_DONE) and
vmci_transport_handle_detach(). Both wait loops read these fields; the
state check is new in v3. The native vsock_connectible_wait_data() reads
sk_err the same plain way, so I'd rather annotate both paths together in
one patch than only the sockmap copy. Did you have other accesses in
mind?

> A single-patch v2 addresses not only the original bug, but also sashiko's
> complains about the pre-existing issues (making the subject stale?), but =
I
> didn't know if you'd rather have all of that stuffed together, so I
> refrained from commenting to avoid confusing the author.

Good point, thanks. v3 is a two-patch series: 1/2 keeps the subject and is
the lock release with the wait loop it needs, 2/2 handles the len =3D=3D 0,
MSG_ERRQUEUE and MSG_OOB reads. It also addresses the Medium and Low
netdev Sashiko comments on v2; the pre-existing ingress_skb case will be a
separate patch.

Bobby, since the vsock sockmap support is yours, a look at v3 would be very
welcome whenever you find the time.

Thanks,
Jerome

