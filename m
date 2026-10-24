Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872691;
	b=EZ08wJgR8WNS0CYwdUpQz6m6rsGAO1jkH8KSKBqqxxPABCnBFLqUiVWKllv5l+/ocEjo
	 qis9efdge6AcFkjgOpd76eD5dcqxkf29iEd8CMe1W9QlClpJOAH2Xqctbu5KyfdW1zoKL
	 lI/EmyHxBxoTZYVgSd2e2GY7y2S3HWk9mQ1MQaCPzdAxL2omF/1RE/iG6CfIVrzopkx4j
	 AaWLzs9mGkpqAfQj6a1RmFd2Z5LXnDwN+CoxV4oLxPGCSdBCRc+LPVlz68vWP4KLv8SH7
	 HkbNzPe286qrVgc2+em9RH7J0AAu+uL9iU7TBT+NzOnugYl+Trc5QICEolLY/2bXAqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872691;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=apcVCufCK5KKcqi97TvYuusJjuATmJdUzDgOuT4VsII=;
	b=Qfb369YgurwaKm36iuxwVSLhzGQsUI0IcxQ+gOuKZzl/0InhM73V1U7L8oYg9PUvms/S
	 pa9yiejlNatQk2F/6rgo01I6TnOFsKwQ1MnW+y5A3zT3vq3qLdr0MgvEqNIMDQVEXKrco
	 pgfS7lvRSKsQmj8vgmwgXEFYiB63quRAZkaCafFWZDKZL8ZEIHV6JQYl1HPfyc2bRuDVw
	 ds2LwDyWv1VaazBuMvbLkXhQs8HZjJg+oUmfTSG9hfyOgY5I2+pTARRq2IydZUu3SIyr/
	 LO6acFtg8APguTR+ZLc4BtC8RlWMQxSxcLqjOxZ8yL/xmxLkSOS++APBOG2PkbzkiHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhNcgt86;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF69606A324;
	Sat, 24 Oct 2026 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhNcgt86
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E61F01829;
	Sat, 24 Oct 2026 20:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872690;
	bh=apcVCufCK5KKcqi97TvYuusJjuATmJdUzDgOuT4VsII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HhNcgt86wIkz/wgKKj/O2CyWG6xT3iyev+jPcuoSucQMeqDys82zhwkPUj0aQxkEn
	 LVpnZMqWX5Xlb8g22RewZHf19FUc4fMheQ0uV3fxz9anrhpXVXzBKKYTzu2yCAxPhf
	 pgdB7Y/kM7zmR0FkxXYvYEFxjFLlGa958BkCfEMAwh8d94CKF+ZMXoQzUNbXnDHRn7
	 0INax6bvEAA3IWdYsPWzdSPSSTqxcJhfvaQq1BtxphAjYPvWxEbxfoBYWXwVx00gyS
	 HYoPvdAujqf0aD+Prk1pvQSA3szB4DBR5wTOnEjrXZmzqXZSIuOrm80jPQIF0Z5v24
	 6HHV+sekjaQkg==
From: Sasha Levin <sashal@kernel.org>
To: Bernard Pidoux <bernard.f6bvp@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	kuba@kernel.org,
	linux-hams@vger.kernel.org
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Sat, 24 Oct 2026 16:11:04 -0400
Message-ID: <2026-10-24-1-daily-reply-0006-rose-ax25-netrom-suite-v2-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YBCwY2iEh-5NFmckvAS+RzDstJO7dY8Q=fzVCrgK04kZA@mail.gmail.com>
References: <CAFAa3YBCwY2iEh-5NFmckvAS+RzDstJO7dY8Q=fzVCrgK04kZA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> v2 of 02/26 is attached for 6.12.y and 6.18.y.
>
> Patches 03 to 26 apply unchanged on top of it, and net/netrom builds
> with W=1 and KASAN on both branches, with no warning.
>
> [PATCH 6.18.y 16/26] ax25: serialise the transmission of I frames on a connection
>
> +	spin_lock_bh(&ax25->lock);
>  	if (ax25->va != nr) {
>  		while (skb_peek(&ax25->ack_queue) != NULL && ax25->va != nr) {
>  			skb = skb_dequeue(&ax25->ack_queue);
> -			kfree_skb(skb);
> +			__skb_queue_tail(&acked, skb);

Thanks for the v2 of 02/26. The series still can't go in as is, because
16/26 adds a NULL dereference in ax25_frames_acked(). ax25_clear_queues()
purges ack_queue without taking ax25->lock, so the skb_peek() check above
can be stale by the time skb_dequeue() runs, and skb_dequeue() can then
return NULL. The old kfree_skb(NULL) tolerated that, but
__skb_queue_tail(&acked, NULL) dereferences it in softirq context.

-- 
Thanks,
Sasha
