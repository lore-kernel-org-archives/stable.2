Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794988048;
	b=yxFkaMFzbHKwbWjO2y5SDtwaTO3DvQkeHTYyGZff/mMqygo+rZu3Ya3T27nzm0ymfhwe
	 YWWoPK3IVh8S9mHbghCNnKumZkRD6d1hCEOHg0DlIL4B1W4JjkYAbz/Se+ONsxW0D+chs
	 KnP4I+9YOoSXu5rV87ce45LBxHUN97MZUbFrHJLdSYYpr6dH/WjJklehc7HrCXeLSnijV
	 UWuBCYnPcjUg0Ntjz9p0LGPZn+IirYSPkCNxadj13wt4FjgkSBbXcE+Qbp7cqAq1epzxE
	 aENRGxLm8JnhPXz8RRnT/Hvx7XrqekNsUcwv41C/+EfyPFghmr+qSCSz6V/bvkw7zsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988048;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yp3BTD6nQWlUPRESQ1+Z3775XsajsPNxx6sfD+CD9AY=;
	b=J90AIF2PWeJlkZtJkfIsAF9MzcGNUFVhxmmZ0nK0GU0O4V2G8jZfHPIH0d3W9k1RTs/8
	 fbv8CDVEVV8v+iXQ1SVc0G/QlZ5bO/nomW+dm+EdWIsNqce+sdHBKpcTC5Mv2RlYrWf2n
	 falmQnF3Qik2hXMfFFbuCmVKazXWsNUoE2orK91mjkgs2txb680gc1vERR/J8kHZIL+3K
	 tv6XcBcZvye/UdXDh70Kt5DYeQpS5PQbiI2E71JfD9fU4Gzx+Uw+TJ+wLffTrOsq8M3Kt
	 2fObhAnhQKuL46VyjyfWSjSZT+heGPUE6SxQdTHv6myxZSwNd1OTdIzCgkL685UKmUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Xj22RsYq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=P7X8dg6v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F05606A31C;
	Wed, 18 Nov 2026 07:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3F05606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Xj22RsYq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=P7X8dg6v
ARC-Seal: i=1; a=rsa-sha256; t=1794988037; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bv292idDRFZybTZo21cZRfqpLO82IKNKNClTZpHWn4QchrQHqKKWR0TsqFqpxQdnH+
    ae3aKJ2ud3O0x1YB3qNYI/Wh5R+r9GRZJ8+mwmXZ/6l47L+aUBjC5CwaDq5MJqT/toZE
    /RhB3eMXT5vnycfLogR7euDELuj3BvchJKfoIBT7/jpeQ8qbNxgW1HvutHKh03gze1GW
    qLTkWpE1VsPQ9ij8TylyHPV1Xq83srp+2ggN1jN1zahb7L6bmsxOAo1p8sCXpd22buBs
    Z48KIQ/q0d/4VXSirg1HTw21keqbaMsQJb4pVO7gxPszr8lWWUt2AGH0p8tPyxLYM+U4
    HJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794988037;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yp3BTD6nQWlUPRESQ1+Z3775XsajsPNxx6sfD+CD9AY=;
    b=TbzHZ/WVv02071okqYqh3RcJ5a4lGXiR611JKO5fZqodUoqvtqhbBkbHfTNTw2Y2V/
    x/JLgO1uJzBE4ntVfu3w0w7Ejq66UI2aSa0A5ScYDyjXQLMf+njuY4S8wMdJw8o9Mqqu
    7iP3okL20PNcqHCHNeIdGPfAunj+i9qSxu1cFbqtW5XTKv71U2AwwiHc9q+2eLf+sd9M
    eS6WO6IXaORx3OmAhv3d6NlNm/P0FncBoC71K+M+dXHBooIMg+HaBkayDGi48zum71uF
    58I39I46g2AEDEMBCFt9Um2Gxjq/lCcM5MmukytfqMFjscbCR6btMU9T2Yl5cBUYZ3CE
    xOAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794988037;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yp3BTD6nQWlUPRESQ1+Z3775XsajsPNxx6sfD+CD9AY=;
    b=Xj22RsYqGtbEADDThMB4RxzDoGIBRNwb3I8d8Db/WfA7zT4JE97kUiM4hq4lBd7u3H
    +mu9ahUQF1CDiGzc7smb/0MHof45/LYGbLVlBr84UAOCY7QonJH+V5BNh8ACPlJFTmZo
    8Ly65x2vqPFl+kSYKb5FK/qzqJZGKSEXJOXEXVn1XxuQY7dK3ANh7y9zI+6+w8kZhYVw
    pe+mqI7mVQrdVYYvm8c6yvK4oiP1Hec5EsBQhQ8JKPBeBm4fRkU6J917lVwO7qMUFlPT
    p9U3qkf48y3bALsvhOCEAzTcC8TVRVkLfGP/IriD1huO0n0symzhTmxNEzJVZmUpFxoO
    CRow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794988037;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yp3BTD6nQWlUPRESQ1+Z3775XsajsPNxx6sfD+CD9AY=;
    b=P7X8dg6vpPUt1cGEt/fboDIc6gB4WaTVJK3Af1wm09FAoIWxbyo+ZP2rMxWjiSElgd
    baM3mxB9DYMIE68a5MAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AI7lH5VW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Nov 2026 08:47:17 +0100 (CET)
Message-ID: <c72cd2f8-755d-4223-8c84-d8ff831b63fd@hartkopp.net>
Date: Wed, 18 Nov 2026 08:47:11 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/11] can: bcm: copy the CAN frames outside of
 lock_sock()
To: netdev-bot+sinfo@kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Zhu Ling <zhuling0805@qq.com>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
 <20261117220818.1142581-2-mkl@pengutronix.de>
 <179495352427.3291.18107293383947918297@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179495352427.3291.18107293383947918297@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17.11.26 23:12, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by LLM and not proven at runtime). If it was triggered
>     please include the symptoms, like the stack trace or kernel messages.
> 
The issue was not reported or observed in production. It was found in
a review and later proven by a test that provokes an RTNL stall:

The Sashiko AI review (LLM) of a former CAN_BCM patch found a wait
chain, where a task that is blocked in a copy to user space holds
lock_sock() while the netdev notifier waits for it under RTNL. At that
time the chain was a stalled reader of the CAN_BCM procfs entry, which
is fixed by "can: bcm: do not remove the procfs entry in bcm_notify()"
in this pull request. Following this, the CAN_RAW and CAN_ISOTP socket
options have been moved outside of lock_sock() with commit 43c973a0887d
("can: raw, isotp: copy socket options outside of lock_sock()").

A subsequent LLM assisted review of the locking in net/can identified
bcm_sendmsg() as the remaining instance of this wait chain: the CAN
frames are copied from user space with memcpy_from_msg() under
lock_sock(), while bcm_notify() takes lock_sock() of every CAN_BCM
socket in the namespace on NETDEV_UNREGISTER under RTNL.

The issue has now been triggered at runtime, analogue to the test for
the procfs reader.

With this patch, "can: bcm: do not remove the procfs entry in
bcm_notify()" and "can: bcm: use a private mutex instead of
lock_sock()" in this pull request, stalled user space accesses on
CAN_BCM sockets can not block RTNL anymore.

Best regards,
Oliver
