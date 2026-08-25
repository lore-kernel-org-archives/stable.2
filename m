Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD50355819
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645029; cv=none; b=UWKkP1/vmcIzVxr88Xl7LbJ7fmUr94/a96Q9zEUdWwhREpqo2KAaMynKpOy+v+IUHU9gXdJZYXIArMIUWCSR14kH0T6vKmZaUdOFJSYpHSLobFUUUviePDlzR2Tj1yzjOjXuAKHE3oyWIii0ClfCR+/WfRiBNokdGXv3ctf7UTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645029; c=relaxed/simple;
	bh=h6jeY6kUt05J87fFLVEavDXhYt+yiXHgVOp+BHg7Xuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUGP1+CE56qiQVqOCEqqSLa+CQbJRACh1bFhMpw4mizO7HlOzNjZxDyFJTzc5QoHMtpX8nGkcjRhFpVStpXu43SW1Jp1p5vjjHaAYiTI6uTLtDiQVGa4ABh+PvjxD5yDiuZbe8U4rKD9LPk2JR+Gmt8KnIgFj8zqYCXJiF41IYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ds+YncoK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbEk0HSZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ds+YncoK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbEk0HSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787645026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4t5HTh+6lmJKuFy4RSIDMrUEkIcD/jxh7XivmoZM5sU=;
	b=Ds+YncoK/HnWEFW4aUoPn8JOhWREewTkM0uzBAq/EPfJOpiTNhgsg3IwQQYQtNGOkK/iWh
	xDYTQsaGptzpQifYO2jpF9NYGHLIQnWOuHL3EYnFQl09GMwylvMwg4W8r4TqAYyLmrHLS2
	HH7MiivmtZsZXVYMpoAjyX1DxXSBKRM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-m3idKD_rNsiKIButiaoihw-1; Tue, 25 Aug 2026 04:03:45 -0400
X-MC-Unique: m3idKD_rNsiKIButiaoihw-1
X-Mimecast-MFC-AGG-ID: m3idKD_rNsiKIButiaoihw_1787645024
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15e555a164so49943066b.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787645024; x=1788249824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4t5HTh+6lmJKuFy4RSIDMrUEkIcD/jxh7XivmoZM5sU=;
        b=IbEk0HSZv3WUK7S6137xw+H9HYR4S/dRu/l+C6U1h//F6PWg1W4LvbTkJ0QH0Pg9MK
         wq4CWu9H2+FGhScBhYs3nCnJEvpr+I0qQ9Cjj5+zO6bCPJ8ae5s9JM2JiixhEJnkiQmv
         FtpyKifMuKVMj5Lc86OIVt+iBij5FiI7rf0905UDH/CTGjzvvVk6mhQAz8uNDdmDvRlb
         OhOgrF4RIWS1ks3yGgfCBOF0CYaPdC5UygXZpmOVTHkRahDkgLwUZGMkUVnO7GwtXfgF
         Gd7LHPTJA39QTAGFBR2ppaGVLDWf8UQfCXbYwhV5UkO+bR4WEz4bN8SBJ/zy24ZymCnT
         aVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645024; x=1788249824;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4t5HTh+6lmJKuFy4RSIDMrUEkIcD/jxh7XivmoZM5sU=;
        b=jk5kRHg5aWdY32bwIzwfykjdvCTkqUzodPyRyIU4xMXEQ/s7qOxw/LNWA0vbvIXFgK
         fbhI0Qf9GW0727P7ypRNl1sAfZle6f/rAXqeCqJePeslAWIDtu2BLoAJIBtUD26NPUxd
         ZoaLHjl9Q4DmlTkICd7bOQF+pReaW68nKgHL9IKBfiP0SV34owZfHPPKMSdKq1c/njwu
         kWI29enhze53LR/FGon0Q92vDec4JLjtOAzZPJyNth3YanHqQpDZfgwvbqFnvhxvvJc5
         f5CMLxXe8uFQ0A9A6esdlNfCC5SseJBpRrxLPSpa7v/brQjpep7Gpmw/o4wG3183ZoJH
         rMNQ==
X-Gm-Message-State: AFuF++lTGOYuLYjJ9n8AxxLlXXKf4IYO0TnBt2o9qTzFxWchaSGL1vzG
	xvQNPprBNj97IyLI30HPR/9R+Z+r7CTPWL+WUYdJMfWSeozRS4QH/4uPJ9njebXtaeeTeEafF/8
	jP7E0HZnMn1NEUYdqXvEgeUOZVHjhiraXECV0nPq9IUR6y4b7ktT4G5c+/A==
X-Gm-Gg: AR+sD10v7ka7yiBaQ/qKToCahZEx2hjjE8csTJGdJzfVrm5y9vMfJXpc0ZHF1kZxV7G
	QqzxKMOHusuO7P+m9cAQVpfqwsg8p1aB/IlNSl2I/ctsqEs058fwFvLPujnPqShiPfNhlXkeRG/
	mk/nNAOCqMCHn5rDwUA5XtcXrQQtZ3Zi3szsI2nXr8xHK1vqcjD+8hJY4DlIcFG78gEXs8PjK0c
	E0MfyL0GWBd5pKpOg3pX0damfBbGGZ6dL+61be4BKKioSQ8QM9RTooSO6FnQBIuPnTPwvQBg/6B
	zB+jJlBJaPYe/TN5dGe/Rls9GRckYINmNYcIaV7/myQ2cx+L/bvGpG54uaYErgg5kubZiLmqc/L
	nLmI9wbGOn21SAFxN7ZKt9qKN/9RPsn81ZAM492BIsjTdeamU4e6jVKGtERtsBb3KXqSRsxIw
X-Received: by 2002:a17:907:e98a:b0:c20:7cb0:f33c with SMTP id a640c23a62f3a-c24e3005531mr482561466b.16.1787645023523;
        Tue, 25 Aug 2026 01:03:43 -0700 (PDT)
X-Received: by 2002:a17:907:e98a:b0:c20:7cb0:f33c with SMTP id a640c23a62f3a-c24e3005531mr482547766b.16.1787645022908;
        Tue, 25 Aug 2026 01:03:42 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e19a05bsm18230076a12.17.2026.08.25.01.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:03:39 -0700 (PDT)
Message-ID: <b1ede30d-5c03-4514-980f-c656acf3bc13@redhat.com>
Date: Tue, 25 Aug 2026 10:03:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] tls: device: fix out-of-bounds write in
 tls_append_frag()
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Ilya Lesokhin <ilyal@mellanox.com>,
 Aviad Yehezkel <aviadye@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 linux-kernel@vger.kernel.org
References: <20260823084758.20936-1-jiayuan.chen@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260823084758.20936-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/26 10:47 AM, Jiayuan Chen wrote:
> Found with syzkaller and a local syzbot instance running on top of a
> netdevsim TLS offload emulation; tls_device.c is otherwise only reachable
> on a machine with a NIC that implements the offload.
> 
> tls_push_data() only checks whether the open record still has room for
> another frag at the bottom of its loop, and the MSG_MORE early break
> skips that check.  The record survives to the next syscall with the frag
> count it already had, and tls_append_frag() does not check either, so
> with TLS_TX_ZEROCOPY_RO every splice(SPLICE_F_MORE) of a byte or two adds
> a non-coalescing pipe page and num_frags walks off the end of
> tls_record_info.frags[MAX_SKB_FRAGS].  Once the record is pushed,
> tls_push_record() runs the same index over sg_tx_data[MAX_SKB_FRAGS] and
> the sg_set_page() writes land on the destruct_work that follows it, which
> the workqueue then calls.
> 
> The byte limit is fine because copy drops to 0 and the loop falls through
> to the same check; the frag count has no such feedback.
> 
> Push the record rather than keep a full one open, which is what a plain
> TCP socket does - tcp_sendmsg_locked() uses tcp_mark_push() and
> new_segment in both the copy and the MSG_SPLICE_PAGES paths, and tls_sw
> already sets full_record when the sk_msg ring fills up, MSG_MORE or not.
> 
>   BUG: KASAN: slab-out-of-bounds in tls_append_frag ( net/tls/tls_device.c:269)
>   Write of size 8 at addr ffff8881104d1530 by task tls_oob/450
> 
>   CPU: 2 UID: 0 PID: 450 Comm: tls_oob Not tainted 7.2.0-rc7+ #329 PREEMPT
>   Call Trace:
>    <TASK>
>    dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
>    print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
>    kasan_report (mm/kasan/report.c:595)
>    tls_append_frag (net/tls/tls_device.c:269)
>    tls_push_data (net/tls/tls_device.c:518)
>    tls_device_sendmsg (net/tls/tls_device.c:583)
>    inet_sendmsg (net/ipv4/af_inet.c:865)
>    sock_sendmsg (net/socket.c:775 net/socket.c:790 net/socket.c:813)
>    splice_to_socket (fs/splice.c:884)
>    do_splice (fs/splice.c:936 fs/splice.c:1349)
>    __do_splice (fs/splice.c:1431)
>    __x64_sys_splice (fs/splice.c:1634 fs/splice.c:1616)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>    </TASK>
> 
> and, once the record is pushed:
> 
>   UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:300:24
>   index 18 is out of range for type 'skb_frag_t [17]'
>   UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:301:41
>   index 18 is out of range for type 'scatterlist [17]'
>   UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:302:39
>   index 18 is out of range for type 'scatterlist [17]'
>   UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:307:38
>   index 26 is out of range for type 'scatterlist [17]'
> 
>   kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>   BUG: unable to handle page fault for address: ffffea000411a680
>   #PF: supervisor instruction fetch in kernel mode
>   #PF: error_code(0x0011) - permissions violation
>   Oops: Oops: 0011 [#1] SMP KASAN PTI
>   Workqueue: ktls_device_destruct 0xffffea000411a680
>   RIP: 0010:0xffffea000411a680
>   Call Trace:
>    <TASK>
>    worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>    </TASK>
> 
> Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> ---
> Hope to get capture attention
> 
> netdevsim + tls (revised a lot locally):
> https://lore.kernel.org/netdev/20260728125658.390500-1-jiayuan.chen@linux.dev/
I must admit that RFC series have low chances of getting full attention
these days, due to constant flood situation.

Could you please re-submit that series formally?

Thanks,

Paolo

