Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B506476680
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253599; cv=none; b=IxDVyHbsnDc2dm0++q8Oh0HIPRn3nfOEK5Xux7oDpWMEwzN9Z9srQ5DjHJ7gWgaytZCnHs317wBpI2OPfD1+2ue3lkUV8VFIX2XekmWZlnRUvN+NRAVBjkXKey2/XNVw4HQIPdaK1XV9KJsXhDY/UpJGRLRXi9eyvfF0WiplOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253599; c=relaxed/simple;
	bh=xSGJC3uVLd/xFM7wRKCUQodGFWq0YqmvT3Vh1LlmJUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEzFGoBiiKJ1ydQ1ToyCTaV5pe42oUQNozUNkxYsiu8h6vG3cPMDhwoKiAHB1BUfYRHgNiXIrPJc5leC3H1WMPyyJ9TbZeY8jLLeN1hn7zwk8rBdSFkSbo+B6j93kD+rFQ/5vElKn/d3Re/Ts/UVwIr2+M9YStKc5BB8QmbiTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUOFXo5f; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUOFXo5f"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so5362033a91.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788253595; x=1788858395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fP2UN3diq48/L8O+IU4I2EwyEv8t+/1QfjRECv67lqM=;
        b=WUOFXo5fZr+aVQ5i1ZSeyiRmEEzvbFBsCo/XgRs9ZS0CqChZiLEDinFEbZxb+3Ne7I
         G5lJpf405SeenHuzAvlCGrg7rq0OPfsr/wvT5gKvYnEWECiNBeQbKZr30lK4+/eQMfNm
         VV4qAcH4nmhwr30lnSTkwGe1CehdAaB0rarwabXoIawcdYeLeA7CYEpkQqKM0Tsn26AD
         QGsN1q/rrhUwlzlduknThWaAGriuy4CLj4ab6oI1rd84IQHkUkIHNzl6PlI/Sa0Aw+rW
         fc3gO/V8zuIO7Fqafb//nK4B8C4PGsBNtUPFvKYwzFgFA5jp2oW+WpiTBRcxEkr81wsP
         DXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253595; x=1788858395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fP2UN3diq48/L8O+IU4I2EwyEv8t+/1QfjRECv67lqM=;
        b=RCNzoz+HZ8w3wQ7SSmkRThz2dS1kxZgWxJyPIBf3c5wWoEla1hMG1jomyKBIc5ubfp
         M71s489yOC9gKMjyVc6kkMtHqHkhFX6SRp3GLjHXSHbRVtbTQYnQdio9fAM2uNtXmZOD
         XVwS00/8sqH8+hRyMX6I7GVKg/ZNfuQB1eJGGyzmYK0p1HOsDGJe4QBHB49v6EP2pt8k
         33+jIZjA/oFpZbQuTYg1lI5EYr5cASlThGalp5auaouiz1pZUgL0vlh8KNrAjlA8fRAW
         V8f0nsKa1y9ZLiiZYpn53bQBWzqK0A0f9mg3VqqGJe6Cu5NtXYm6RXStT+OuQvJSfi1g
         CfXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJVDMJcX5tw8cLl6Wx0hnt/taN7ZKJu8oadKNiHRq0tQDH0iVq8J/qBqTgQo/e5xRxhd9sG80=@vger.kernel.org
X-Gm-Message-State: AFuF++liNP8/5MVSLWVFMecLbwlJOoYOSz8pncYs3ZswQtsn3XuwsR3l
	Px/JIfSN650LdjmLoTwBGJwaQ31sZcm/qCq9eqIXu89eH8c6nMm5+94s
X-Gm-Gg: AYBFou1DbYV6C8XFWGScyouyUMkIJDAaZ8H7bzNTJZQdiAMYRQOKH1afBBAQMpMZZ9q
	idYDMyKrCjo2TT4qYveKp3jZ8Q6C4+/bgzRwomvKchLeZXnGdLS8NnSiyjZpQnnuTItJXz9pIeb
	eZ+M4THNF/AmoKyHZ90OJvDb7ycnwCJt49fME1OcDZ5+X1m/EPnUQKkjUJrh7KX5DVR52tioI93
	YB5uWXm0Z3VsO6lNDng55kFoluOnozuEdr4F71sNrI0NCJcSbxBj5i1Y6+8/FSkh4Dqo2HuKdCW
	srs6PcIMheUDY1OS+TnT1VxKtKflELK1Hc1rXxijcULCOu5og00PfP8n4Eu7SW243bdq6dy46TT
	g+P02wwN6jjj30nfNXWUp7Y72KdX5/K2hGrUVoeNR95pcr1i9ARVNMDTlLQs8CZ9XopjDbLM49X
	hkiQ4t8SiPjiVeKRNcp064z1QoJlWzVvEhMdHZkskN49qpXpfpOTPPnTDpSYk+ISGFbpywbBX4u
	mXwNOWW6B21H4WPqGbn
X-Received: by 2002:a17:90b:3904:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-39907ed4294mr8299953a91.23.1788253594793;
        Tue, 01 Sep 2026 02:06:34 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39914b4ea7asm3906800a91.13.2026.09.01.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:06:34 -0700 (PDT)
Date: Tue, 1 Sep 2026 18:06:28 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	ncardwell@google.com, dsahern@kernel.org, idosch@nvidia.com,
	kuniyu@google.com, horms@kernel.org, willemb@google.com,
	andrew+netdev@lunn.ch, kees@kernel.org, jiayuan.chen@linux.dev,
	kerneljasonxing@gmail.com, ij@kernel.org, martin.lau@kernel.org,
	shakeel.butt@linux.dev, matttbe@kernel.org, martineau@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
Message-ID: <apaVlDUS_1NIb_lq@v4bel>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
 <20260824033331.1084971-7-imv4bel@gmail.com>
 <apaAskNL-IvdcR7h@v4bel>
 <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>

On Tue, Sep 01, 2026 at 10:03:51AM +0200, Paolo Abeni wrote:
> On 9/1/26 9:37 AM, Hyunwoo Kim wrote:
> > On Mon, Aug 24, 2026 at 12:32:50PM +0900, Hyunwoo Kim wrote:
> >> tcp_v{4,6}_rcv() calls tcp_v{4,6}_do_rcv() without holding the socket
> >> lock when sk->sk_state is TCP_LISTEN. Every other path into
> >> tcp_v{4,6}_do_rcv() holds it.
> >>
> >> tcp_v{4,6}_do_rcv() and tcp_rcv_state_process() below it read
> >> sk->sk_state again. A listener can leave TCP_LISTEN through
> >> connect(AF_UNSPEC), and if that happens in between, the second read
> >> returns a different state.
> >>
> >> tcp_rcv_established() or tcp_rcv_state_process() then runs without the
> >> lock. If the second read returns TCP_SYN_SENT, the incoming SYN is
> >> treated as a crossed SYN and reaches tcp_send_synack(). When the SYN skb
> >> at the head of the retransmit queue is skb_cloned(), that function
> >> replaces it with a copy and releases the original with
> >> tcp_rtx_queue_unlink_and_free().
> >>
> >> The original is the skb that a thread on another CPU is transmitting
> >> right now in __tcp_transmit_skb(). skb_cloned() is true because the
> >> clone made for that transmit is still alive. Once the transmit returns,
> >> tcp_update_skb_after_send() calls list_move_tail() on the skb's
> >> tcp_tsorted_anchor.
> >>
> >> In short:
> >>
> >>   socket(AF_INET) -> bind() -> listen()   // the socket that changes state
> >>   socket(AF_INET) -> bind() -> listen()   // the peer
> >>
> >>   Several threads keep opening new sockets and connecting to the first
> >>   socket's address.
> >>
> >>   Another thread repeats this on the first socket:
> >>     connect(AF_UNSPEC)      // TCP_LISTEN -> TCP_CLOSE
> >>     connect(peer address)   // TCP_CLOSE -> TCP_SYN_SENT
> >>                             // another CPU still sees a listener, handles
> >>                             // one of those SYNs without the lock and
> >>                             // releases the SYN skb that this connect()
> >>                             // is transmitting
> >>                             // -> use-after-free
> >>     connect(AF_UNSPEC)
> >>     listen()                // TCP_LISTEN again
> >>
> >> KASAN log:
> >>
> >>   BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x14/0x140
> >>   Read of size 8 at addr ffff88800a5d1460 by task poc/125
> >>   ...
> >>   Call Trace:
> >>    __list_del_entry_valid_or_report+0x14/0x140
> >>    tcp_update_skb_after_send+0x62/0x170
> >>    __tcp_transmit_skb+0xe33/0x1e40
> >>    tcp_connect+0x1b67/0x2490
> >>    tcp_v4_connect+0x998/0xab0
> >>    __inet_stream_connect+0x22c/0x700
> >>    inet_stream_connect+0x48/0x70
> >>    __sys_connect+0x101/0x130
> >>   ...
> >>   Allocated by task 125:
> >>    __alloc_skb+0xd1/0x370
> >>    tcp_stream_alloc_skb+0x2d/0x2b0
> >>    tcp_connect+0x72d/0x2490
> >>    tcp_v4_connect+0x998/0xab0
> >>    __inet_stream_connect+0x22c/0x700
> >>    inet_stream_connect+0x48/0x70
> >>    __sys_connect+0x101/0x130
> >>   ...
> >>   The buggy address belongs to the object at ffff88800a5d1400
> >>    which belongs to the cache skbuff_fclone_cache of size 472
> >>
> >> Instead of taking the lock, keep the lockless path from reading
> >> sk->sk_state again to decide how to process the packet. Move the
> >> TCP_LISTEN handling out of tcp_rcv_state_process() into
> >> tcp_rcv_listen_state_process(), and let the TCP_LISTEN branch of
> >> tcp_v{4,6}_rcv() call a new tcp_v{4,6}_rcv_listen(). Listener processing
> >> does not change. The TCP_LISTEN arm of tcp_v{4,6}_do_rcv() is left
> >> alone, because a socket can finish listen() after the state check and a
> >> backlogged skb is then processed there.
> >>
> >> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > 
> > Looking at this further, unhashing the listener and then calling
> > synchronize_net() lets the disconnect path handle it. MPTCP needs a fix
> > too, though, because it closes and reuses the first subflow directly
> > without going through tcp_disconnect().
> 
> This looks like a more palatable approach: this patch in the current
> format looked way too invasive to me.
> 
> > This also closes the trigger path for patches 4, 5 and 8. I would still
> > keep those, since they add no work to the fast path and they remove the
> > root cause itself. Their changelogs would have to change though.
> 
> I'm unsure accepting new connections is not fast-path: the connection
> per second rate is a relevant metric for a sever, even if the additional
> cleanup is possibly not visible in most benchmarks.
> 
> Still I would avoid additional unneeded patches.

Yeah, I will drop those patches when I send v3.


Best regards,
Hyunwoo Kim
