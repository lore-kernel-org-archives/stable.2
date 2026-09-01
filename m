Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB542C21D8
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249932; cv=none; b=sk9wYOGC1BVCgnA5o+ewUj2+OF8yIPiCJbRp87BpO0PPGC1TlLhgz81vq30+iD56JAdi0xqk2voAJST3VOBR6il6JJEfK95fnabDGLFI2+VpGkpDjr4M1jAX1a7mC+LDpb5AkrLcDjq1J9XdBoAunEO3yRilp+o+lbbXiDriYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249932; c=relaxed/simple;
	bh=2OP2L7SzkBrg/QvLyKIZXfRlLBLWuoclJ+HmnVt54lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XilEQA/EN2Z/0ThlMO65fU5C8RAcRHd7Yeco8fazj67GiVETwylFM5wFYsQUx+NZ8bF3zKKUr7DRxfVgV7oYS1YRVkF6lJc5c5endH+6BiYhoSbhEcXZIXjumCWYnHUYZjsihSy76y3xEfn3KGw5BFRy3kS1lvOYw8+QoIRteBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpOhFFr9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Un1bKO4Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpOhFFr9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un1bKO4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788249929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6II7OJOvbSf1qn4a78SQvZqHlqlRqW3TztU7vrsw3A=;
	b=VpOhFFr9vXRMRjbjoPeS323NaSNo2qW/BJnx0oxFypfEzu3yoI+SE9n9Tr93/stDX3/x9H
	3lH4HCgDspGnuFUDjvK7Zs1wEvyrtX8l3W1vdDg9Yiq9pJFjQt4X2waaA6mLqWAzi1IhT0
	k5Q63dLdpFZqaiw4hH5WHFvnsXazn3M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-CpZmHBLdNraSubcENvwNNQ-1; Tue, 01 Sept 2026 04:05:07 -0400
X-MC-Unique: CpZmHBLdNraSubcENvwNNQ-1
X-Mimecast-MFC-AGG-ID: CpZmHBLdNraSubcENvwNNQ_1788249906
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cc9f5bee2so33415755e9.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788249906; x=1788854706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c6II7OJOvbSf1qn4a78SQvZqHlqlRqW3TztU7vrsw3A=;
        b=Un1bKO4Z9incYEUKrW3iYSYnkZR/XqLYk3VknH7xvFbkYeR4ajOSje0PywTKPfhaoT
         SYH9b0ws6Lh8yfgBeZIF0ciB9t10lH/bSB8fYQ05aYhj363O47DQwm6pihGtKVq51MpL
         o790vpEXdFhXKu+M2z9d04VJKmgl2jiMepU7wls9Qt8BNprfaUCKHYBzs2Be4w2HgRML
         nA8SgyL70W7wTA0nlcuwgeJMHy/GabKov4hXr6jeTX+46pao8E8/QQzEuO6sR6lyAK3p
         ZFOvrBTJsY4R2wUGbQsFnFDL8yRL4Z7RxMVx+Z/TJp8SkIws8XB3BfwMY1SOXt1++6pz
         dtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249906; x=1788854706;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c6II7OJOvbSf1qn4a78SQvZqHlqlRqW3TztU7vrsw3A=;
        b=eDixgHJ/4Mr0T15gfBPQjvzmDPB9R/Klxi8JgF7I2ENe47l1Z0RSNOY6ctNUzAB83b
         x2aKTqiPPu05LUNABLpOtE0l9iH6y1rG4a6/xkx5Slu5BiJOSECvUFfpHwVw7HyUB2as
         gXRrzIE2h/nifKDhbMg+Jw85X1XLLJ/LraqgslzqDcMne/+Q8o9facL8Or/8oVgDjqGP
         7aAqCodoprnZmRyAAmt8v38z+18n3hBAuFvmDyAQ2uCe7HzSnifd06SpgqY4wldq/NHN
         jl98/CZ4Y34SvR+1bQlXkFDRD1OSlEGiFKxlXsNKTsh7pkXiZgL7tV2TKz2cK905uDxY
         ojMw==
X-Forwarded-Encrypted: i=1; AHgh+RrfzNB4ga87NfXTj89oyD2WYCjrJaBIx4kT/1XlCxTCV86xyc3Rn3MRmhXvnAgGGZLN+nwX0Ws=@vger.kernel.org
X-Gm-Message-State: AFuF++kpDbb2N8H/+wP90oXz3C/Pxwov3KeubIe/x15JChrdRxRPuC3y
	16MfEUQwGkQC8f9lh5EiwOsH7FfKyo2gB0H28HBRZUVbCtPWcXKmYjPlK3FMs7oEy7ayGbFCtsI
	SUPyHSqSmyPfUYrhbRwKMAStHLMm8qMKKJykGmBQChNJSz9LSz/yLNX9olg==
X-Gm-Gg: AR+sD12Oat1rlbWf7vPhfaPk+lVaDMLvXbMq2apWmqcvQK5tlr/v7en6vGlhY6P81XE
	TcdPC541OH9U+VAKRjA6sDmCIA9paK2z0dFap8VmZgCtysrUKd62jHcECzdSTZonuySqL5+SCMm
	280kDKaCsykFwSKjt8z6CrEb0PLbvXXUSZu8nhZspNefmkAVWDDK9BvfjaN13NoPaEa3B7sc+e5
	NXCybtn5zkgAQwsUPiYJ/MrUuxkxceYx/MAuUylBEfiE8w3Wk6x+whZhhZg73C3VieKlCXdJR19
	NcORqObeWI7XTjs10kF9itriOuRVS+xQQWoEDJcOdUT64+bUWS9K3BJCKjvO94AmZeSsKGqdd8M
	OjMikH/T3P/qDGVKG2GpdV8ulZsbvL7YtbyuaS40KixH/naWSQPoV8SzVvDR7WZeAnXO9IvTXxw
	==
X-Received: by 2002:a05:600c:a012:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49cd81887aemr179668685e9.11.1788249879366;
        Tue, 01 Sep 2026 01:04:39 -0700 (PDT)
X-Received: by 2002:a05:600c:a012:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49cd81887aemr179602105e9.11.1788249844819;
        Tue, 01 Sep 2026 01:04:04 -0700 (PDT)
Received: from [192.168.188.103] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce08862sm49860305e9.1.2026.09.01.01.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 01:04:03 -0700 (PDT)
Message-ID: <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>
Date: Tue, 1 Sep 2026 10:03:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
To: Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ncardwell@google.com,
 dsahern@kernel.org, idosch@nvidia.com, kuniyu@google.com, horms@kernel.org,
 willemb@google.com, andrew+netdev@lunn.ch, kees@kernel.org,
 jiayuan.chen@linux.dev
Cc: kerneljasonxing@gmail.com, ij@kernel.org, martin.lau@kernel.org,
 shakeel.butt@linux.dev, matttbe@kernel.org, martineau@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260824033331.1084971-1-imv4bel@gmail.com>
 <20260824033331.1084971-7-imv4bel@gmail.com> <apaAskNL-IvdcR7h@v4bel>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <apaAskNL-IvdcR7h@v4bel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/26 9:37 AM, Hyunwoo Kim wrote:
> On Mon, Aug 24, 2026 at 12:32:50PM +0900, Hyunwoo Kim wrote:
>> tcp_v{4,6}_rcv() calls tcp_v{4,6}_do_rcv() without holding the socket
>> lock when sk->sk_state is TCP_LISTEN. Every other path into
>> tcp_v{4,6}_do_rcv() holds it.
>>
>> tcp_v{4,6}_do_rcv() and tcp_rcv_state_process() below it read
>> sk->sk_state again. A listener can leave TCP_LISTEN through
>> connect(AF_UNSPEC), and if that happens in between, the second read
>> returns a different state.
>>
>> tcp_rcv_established() or tcp_rcv_state_process() then runs without the
>> lock. If the second read returns TCP_SYN_SENT, the incoming SYN is
>> treated as a crossed SYN and reaches tcp_send_synack(). When the SYN skb
>> at the head of the retransmit queue is skb_cloned(), that function
>> replaces it with a copy and releases the original with
>> tcp_rtx_queue_unlink_and_free().
>>
>> The original is the skb that a thread on another CPU is transmitting
>> right now in __tcp_transmit_skb(). skb_cloned() is true because the
>> clone made for that transmit is still alive. Once the transmit returns,
>> tcp_update_skb_after_send() calls list_move_tail() on the skb's
>> tcp_tsorted_anchor.
>>
>> In short:
>>
>>   socket(AF_INET) -> bind() -> listen()   // the socket that changes state
>>   socket(AF_INET) -> bind() -> listen()   // the peer
>>
>>   Several threads keep opening new sockets and connecting to the first
>>   socket's address.
>>
>>   Another thread repeats this on the first socket:
>>     connect(AF_UNSPEC)      // TCP_LISTEN -> TCP_CLOSE
>>     connect(peer address)   // TCP_CLOSE -> TCP_SYN_SENT
>>                             // another CPU still sees a listener, handles
>>                             // one of those SYNs without the lock and
>>                             // releases the SYN skb that this connect()
>>                             // is transmitting
>>                             // -> use-after-free
>>     connect(AF_UNSPEC)
>>     listen()                // TCP_LISTEN again
>>
>> KASAN log:
>>
>>   BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x14/0x140
>>   Read of size 8 at addr ffff88800a5d1460 by task poc/125
>>   ...
>>   Call Trace:
>>    __list_del_entry_valid_or_report+0x14/0x140
>>    tcp_update_skb_after_send+0x62/0x170
>>    __tcp_transmit_skb+0xe33/0x1e40
>>    tcp_connect+0x1b67/0x2490
>>    tcp_v4_connect+0x998/0xab0
>>    __inet_stream_connect+0x22c/0x700
>>    inet_stream_connect+0x48/0x70
>>    __sys_connect+0x101/0x130
>>   ...
>>   Allocated by task 125:
>>    __alloc_skb+0xd1/0x370
>>    tcp_stream_alloc_skb+0x2d/0x2b0
>>    tcp_connect+0x72d/0x2490
>>    tcp_v4_connect+0x998/0xab0
>>    __inet_stream_connect+0x22c/0x700
>>    inet_stream_connect+0x48/0x70
>>    __sys_connect+0x101/0x130
>>   ...
>>   The buggy address belongs to the object at ffff88800a5d1400
>>    which belongs to the cache skbuff_fclone_cache of size 472
>>
>> Instead of taking the lock, keep the lockless path from reading
>> sk->sk_state again to decide how to process the packet. Move the
>> TCP_LISTEN handling out of tcp_rcv_state_process() into
>> tcp_rcv_listen_state_process(), and let the TCP_LISTEN branch of
>> tcp_v{4,6}_rcv() call a new tcp_v{4,6}_rcv_listen(). Listener processing
>> does not change. The TCP_LISTEN arm of tcp_v{4,6}_do_rcv() is left
>> alone, because a socket can finish listen() after the state check and a
>> backlogged skb is then processed there.
>>
>> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> 
> Looking at this further, unhashing the listener and then calling
> synchronize_net() lets the disconnect path handle it. MPTCP needs a fix
> too, though, because it closes and reuses the first subflow directly
> without going through tcp_disconnect().

This looks like a more palatable approach: this patch in the current
format looked way too invasive to me.

> This also closes the trigger path for patches 4, 5 and 8. I would still
> keep those, since they add no work to the fast path and they remove the
> root cause itself. Their changelogs would have to change though.

I'm unsure accepting new connections is not fast-path: the connection
per second rate is a relevant metric for a sever, even if the additional
cleanup is possibly not visible in most benchmarks.

Still I would avoid additional unneeded patches.

Thanks,

Paolo

