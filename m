Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60039099C
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305968; cv=none; b=GNwT2f6H0gmVzOInFXJWIswISHjHJCm+m7pfyknYkyR+NdjPv/RhFwCZkB+09Z2ouCt+6Dgdc+482/1utnK4G4TNfF6p49Id8jb04Y2IV+VQKzKG5aZ/95Ck+3fFWuAPPTboAZDnHhlun5Rmp5I9/2f2nsR+WXGVqjLDiFnTpVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305968; c=relaxed/simple;
	bh=92tjw0qOeTMiu/O2oXMKbRtKwgW0ttd71f9F8miPIDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOG2KICSnD9hjAZ8HciDlMmAbJ6Muzz5uTVQtj3xZtTx6f3CPuGIG/3VK6r11Qomk41EUfx+ZszRvngR/UtgosbtS6bL+enaqgq9ml+Yz3NzdfVbYY0uGVNVD9z9j3y948R/k1g52+Ajn+J5iVptYkmD7NZkc4AT+Pd2Iq7plRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B61DGT/N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HB6Y4NFH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B61DGT/N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB6Y4NFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780305965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbDQ1hQ8dNMnVHUs2DSdKneMuLGxvpohPlMlW5RIgfM=;
	b=B61DGT/NIzeLUmycnfrQiTsLVBBkIPz6/WyX+hc+aoyL/apoWCZ6peSIazmcXFXdbiUr3w
	XKt8ZhELyTj9vwbi2wPSLDK9cSvfTf70C9OB8Mz+giNa0dN7ryQqDcrZtKUidk2A0chNmt
	03nuRg5WVr4s8V0f+cuc26lT6oacPqg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-LgiZmirnN8y-R5YybakoUw-1; Mon, 01 Jun 2026 05:26:02 -0400
X-MC-Unique: LgiZmirnN8y-R5YybakoUw-1
X-Mimecast-MFC-AGG-ID: LgiZmirnN8y-R5YybakoUw_1780305962
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efa2f7009so1010373f8f.3
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780305961; x=1780910761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbDQ1hQ8dNMnVHUs2DSdKneMuLGxvpohPlMlW5RIgfM=;
        b=HB6Y4NFHNixrbjzXBkgd4id9xC8TXSBSqDB0E9UtM1J0owEVrFX0QKTuHvFsFXqo2w
         zpcSx+J0QYeDeoTs9+fTjcs8ccAgDsU5XM1TS9FjPDOrkn2RcEYVmYDDkzvPjGUUGucx
         ++H0P9OcwiODjy453xYQmietUatsbStAwAMNDhY99HwEcGeD/nthRNV5BSYme3sQ2QFB
         dUka6Azfve6XzeHnvJlvW45jbgZ5WwPfLVo3zAikbzRVCOEi5JTq3jmy50DO0f78t2jd
         ym7vwoKrfuWR034xx+9k09x8QKjjsUwihWUVzOUYvhAWkWEFO9F8ljHaQkL4qPF8QXOw
         LNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780305961; x=1780910761;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbDQ1hQ8dNMnVHUs2DSdKneMuLGxvpohPlMlW5RIgfM=;
        b=TkX6wjOSQshDOKRY8tkLs1faEZIrghLbw6S2fd8qGabEWnV8+0Kcz/qEp0XBoc07BF
         RIJTRgJa7ur5dCR4DswVkn+Q+1NIT17zjhuZO8lhEd6Y+Z2mlgV+6xCKaPON71DITokJ
         DO5MzYQ3Zt0JjaWD3bDJ6hHX3qPUQpzk+9SG8cMpzRvmDMgNdoc6JRi602x5GmAbhWis
         No5DV1CTRB/H+zgR5Bywcbewgde4S/eIW1JFYiaroX19ABHeQxk86xcTyGTmESPdkL+j
         +aI2YLmRx8pQ+i3uh+IOZ8SLOZGIddLKD/uNy9lrnNpt77vXKtiD4W8GX3pg5m+92qf7
         LBgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7SHIwkt8oxEr7fXE5WEk6v+efr4bvhQizy5QRzD+AJG3KGGPVbeQK87l4iotT+F49rhja+G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKY4P68z9aZZ4lMTuax9J8aQK13oGvdWOZSX9UNKau9Bc94pjK
	YP9Aq0T6mksQO+4ftFj/5V20kVJZq/kSukvJjVX7qfiLwyTqDJQra4BOUyr9idWsTQk1ZWweaqz
	inckKSaI9Ykdm3vhnpLdqtx8wzimFUs16nEiBHULsXfLLZF2195VpX8Gnbg==
X-Gm-Gg: Acq92OHOBNiO/gU5OB4gZhKns2Ls8xSYj8rq+NZwYSll/dgHTOdcZB3CfCoD2EaQa/C
	VXiV3lH3u5XqgaqgyNMkq3icgSQfueDULw3ozYfTTf+ya5ZnjnrSLxnYf/XQ3y4KzstwrggEpNK
	VaDJ9UNa5/M+7VBXiYlT5xtB+C3viSspm6wY29FjvJHpwAWDF2h4i606JnI9ib86OLISixiUbQR
	NJu0WhiD2YcyV9k21BjGslOuiPN5U9mfk7g9HHGV0/8pe4Wv5Kr7LkUg0MLf/cEKUJn4aa4T0vx
	SYOEgo5SEunnYvwUCwg4levEK+UI+5rhLnRMEbjcZ84pY8ez8FVRNc6i6iQCfFBFaQqJI7vqV6r
	qRyWeq2ctvdtdeGDMJOjl9nD0nlcVQpxCRixIRW6m43nmrDqm31rQGqwgQ+CQzWsuwlBq
X-Received: by 2002:adf:ef12:0:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-45ef6ba1e31mr13765421f8f.37.1780305961529;
        Mon, 01 Jun 2026 02:26:01 -0700 (PDT)
X-Received: by 2002:adf:ef12:0:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-45ef6ba1e31mr13765397f8f.37.1780305961103;
        Mon, 01 Jun 2026 02:26:01 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35598e5sm21777598f8f.27.2026.06.01.02.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 02:26:00 -0700 (PDT)
Message-ID: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
Date: Mon, 1 Jun 2026 11:25:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
To: Raf Dickson <rafdog35@gmail.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: sgarzare@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com,
 vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 stable@vger.kernel.org
References: <20260526104356.469928-1-rafdog35@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526104356.469928-1-rafdog35@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 12:43 PM, Raf Dickson wrote:
> When vmci_transport_recv_connecting_server() returns an error,
> vmci_transport_recv_listen() calls vsock_remove_pending() but never
> calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
> permanently.
> 
> Repeated handshake failures (malformed packets, queue pair alloc
> failure, event subscribe failure) cause sk_ack_backlog to climb
> toward sk_max_ack_backlog. Once it reaches the limit the listener
> permanently refuses all new connections with -ECONNREFUSED, a
> silent denial of service requiring a process restart to recover.
> 
> The two existing sk_acceptq_removed() calls in af_vsock.c do not
> cover this path: line 764 checks vsock_is_pending() which returns
> false after vsock_remove_pending(), and line 1889 is only reached
> on successful accept().
> 
> Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
> the error path.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Waiting for Stefano's feedback - should be back in a couple of days.

> ---
>  net/vmw_vsock/vmci_transport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index d2579380f5..88ccc55455 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -980,8 +980,10 @@ static int vmci_transport_recv_listen(struct sock *sk,
>  			err = -EINVAL;
>  		}
>  
> -		if (err < 0)
> +		if (err < 0) {
>  			vsock_remove_pending(sk, pending);
> +			sk_acceptq_removed(sk);

I'm wondering if sk_acceptq_removed() should be bounded in
vsock_remove_pending() ? (even if that change would probably be net-next
material).

/P



> +		}
>  
>  		release_sock(pending);
>  		vmci_transport_release_pending(pending);

