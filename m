Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2337CD45;
	Mon,  5 Oct 2026 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187174; cv=none; b=Er3aYZviywFjSYVM4ViP2pTOguW22zU12gOYVv+sZtx8Z5CLC7paRDmh4R3Sg7JznfiRNslTvWkkIaNnlRggUNMECx74k9WkwRmf+UPk9wmTiAZkj/MGnvddOjWH/CtUQ2mcbQwr2WlZQetjblEsOhM/ZxZkMrSpoXeTc27SIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187174; c=relaxed/simple;
	bh=jpWF2fgTTsQNMBqjrX3o9f1OjcJ8sDKl5kFBIYtr1z0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UWZmz+qjdsWt8abl8jOKucaODetlClNmn4NG1Ty0rXykU8ErT14ajkausQf7nc+81t9gTP9fusLCAmgtUh+PuimaUCDeKO21olL9srufrnlShshX4q1LSnJwZDq811p37vxRnLeVPcbHwYlHR6FAE4pUNKwCC+sVPASIDWKEQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=kW049N0E; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="kW049N0E"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xDdbY-00C9cH-Ug; Mon, 05 Oct 2026 09:59:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=AJpRXQHRBb4+gY4/3S+W6fpaM8ojmDIBRhQ4aGx7Imw=; b=kW049N0Ewaq+URE6huHVFmZ0di
	5O0JtV6sqo7SlROpp2utVSdu3YzDX5lKRidExLdFTskN2YdxIyaKXQG+B9wLNElUC0aSCDYQyQTDz
	8seBh+lh8ri+ifM0z1MWwthdR1gbJoDH8C5Twx8PQBN0rbOqvdA9w1rvfp8M0I1FJwQeTJ+O6nMVV
	G8uPsJnnDTacK7qJUwq1tNEEKfWVYmoS46OwFI4cyb1kQz5jAZzyp7tm3I6Quw+Gm3t12A2+5paHy
	rz3OpuC88yeL4Ik0UvyCBETAtNP4Fri4EjRfTIF4WX4bEY3JcnsKSTo8TjurZpYBWdFYr6HbiaWSL
	1GLZjbNg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xDdbR-0003yJ-Qv; Mon, 05 Oct 2026 09:59:17 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xDdbJ-00BpL3-Pe;
	Mon, 05 Oct 2026 09:59:09 +0200
Message-ID: <4dfb9200-8bd1-4806-90d8-892529b79962@rbox.co>
Date: Mon, 5 Oct 2026 09:59:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vsock/bpf: release sock lock while waiting for data
 in recvmsg
To: Stefano Garzarella <sgarzare@redhat.com>, jrmmhm.kernel@eldare.de,
 Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
References: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
 <ar4gvlZL1JyPycg1@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <ar4gvlZL1JyPycg1@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/26 11:01, Stefano Garzarella wrote:
> +cc Bobby and Michal who touched this code recently
> 
> On Tue, Sep 29, 2026 at 06:33:04PM +0200, Jerome Mohm via B4 Relay wrote:
>> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>>
>> vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the whole
>> receive loop, including vsock_msg_wait_data(), which sleeps in
>> wait_woken() without dropping the lock. When data arrives, the
>> transport's delivery context (the vsock-loopback worker, or the
>> virtio/vhost rx path) calls virtio_transport_recv_pkt() -> lock_sock()
>> on the same socket and blocks. That context is the only one that would
>> queue the skb and call sk_data_ready() to wake the reader, so neither
>> side makes progress. A blocking recv() hangs until a signal arrives (a
>> finite SO_RCVTIMEO also breaks it); while it lasts the shared delivery
>> worker is stalled, so all vsock rx on that transport stops, not only
>> the affected socket. The hung-task watchdog reports the worker blocked
>> in D state:
>>
>>  INFO: task kworker/1:3:107 blocked for more than 5 seconds.
>>  task:kworker/1:3 state:D Workqueue: vsock-loopback vsock_loopback_work
>>  Call Trace:
>>   __schedule
>>   schedule
>>   __lock_sock
>>   lock_sock_nested
>>   virtio_transport_recv_pkt
>>   vsock_loopback_work
>>
>> The reader holds the same sk_lock-AF_VSOCK it is waiting on, taken in
>> vsock_bpf_recvmsg().
>>
>> This code is based on net/unix/unix_bpf.c, whose unix_msg_wait_data()
>> drops u->iolock around wait_woken() and re-takes it afterwards. The
>> vsock port substituted lock_sock() for that serialisation lock but
>> omitted the unlock and relock. tcp_bpf and the native
>> vsock_connectible_wait_data() both drop the lock across the wait;
>> vsock_bpf is the only one that does not.
>>
>> Release the socket lock around the wait and re-acquire it before
>> re-checking for data, so the caller's locking is unchanged.
>>
>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>> ---
>> net/vmw_vsock/vsock_bpf.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>> index 9049d2648646..bb7d81a95baa 100644
>> --- a/net/vmw_vsock/vsock_bpf.c
>> +++ b/net/vmw_vsock/vsock_bpf.c
>> @@ -50,7 +50,9 @@ static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long ti
>> 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>> 	ret = vsock_has_data(sk, psock);
>> 	if (!ret) {
>> +		release_sock(sk);
>> 		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>> +		lock_sock(sk);
>> 		ret = vsock_has_data(sk, psock);
>> 	}
>> 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>>
>> ---
>> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
>> change-id: 20260929-kbh3-1-022-fix-340aa3f7f071
>>
>> Best regards,
>> --
>> Jerome Mohm <jrmmhm.kernel@eldare.de>
>>
> 
> LGTM, but I'd like also Bobby and Michal opinion:
> 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>

I took a look at v2 and I don't really have any functional comments. Well,
besides the use of READ_ONCE, but that's probably something we need to
tackle separately?

A single-patch v2 addresses not only the original bug, but also sashiko's
complains about the pre-existing issues (making the subject stale?), but I
didn't know if you'd rather have all of that stuffed together, so I
refrained from commenting to avoid confusing the author.

thanks,
Michal
