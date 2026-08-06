Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7737D11F
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009875; cv=none; b=D35H0zVpWZ66dQTAbcTwrEntlfPshMxf0k1aMmg/gYNZXFvsquQYWXCO6ubTVeUFAXLr5AKC5HBudBg5/C0KUP5Wpu+3NgaPpYn2qyaQipgl2Vmwy9EKHefQHuuJKUykb2KORytvdHTxWArCvu+nuvFwDIzI5LzBRNWqeaD2C+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009875; c=relaxed/simple;
	bh=BBS2llsyBXlMMEFVnV3Vqme+CPr4KYuAOK8RLTlwRNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkBw/X3TdV2XTdliDf4cMUdtOgSbqUG8U43x6q5dwzzoQD1yANsQV7bsLUMNYEsoXbO1rWG6j3px0EHz+Hqg9T7k6Ut40l7+zk0rQRS5DZYAtPZ2LaW5DnDCj82q6O9CWmU+7mlMoBE66nOyAtAXVsYNH7NmA5ftnsNMmX62jfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Is0sErDG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Is0sErDG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49553515a8bso29594625e9.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786009870; x=1786614670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jdPKyoXHfLY/Q9bnRaheIyeMtvycemI/+0+xRlC9rLA=;
        b=Is0sErDGzc8AmAHiosQbgNEn4t6jeA9PMeY2UUCPNVtrF3hL4rvuXjJrOqfvF3kB/j
         eb2h6O7/0Nx3hhfkzV4FlmPN/j/a5FL1dC7IUhHPsx6aO28oQZuwRfkl0BeQ1pGib6EG
         X4MJrRfCrJDzfUM+Sr5zMDYf7OyxoOk1zDQfFY0e3k6qUHtYcU8v/dotkTosZFqIkYG6
         UtTOCvyo1oCE9UNFFQNtxLm1jw1sGnrk5a9un60sDPJRPHGXv0SePzTFR8/gCKvL9ecx
         4X+fkKn0U/29N8UNTnLKH06sfHgtpwPGEqIajg3W1nVpwtXaOgzUcvdbCsoCDpFcx0Cs
         7iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009870; x=1786614670;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jdPKyoXHfLY/Q9bnRaheIyeMtvycemI/+0+xRlC9rLA=;
        b=anooXVPxIABJ3TJ+IMx8kNFZjWAbmd+AyQ47r/LXqEIpkzwpA9J7pjqpheYnC6gUyB
         cBRsxSll/6X8EUc78Up/9xwlgIviUy8rhy9NS1ySYkU+BQTwW2MNBXlpi0R3uqVpAYYP
         WiTNaJmd2wupop3JK/YrUsrKSIEltzWFVRI3HLCsjwyBaU41iCJddAlYxCJK5r1delFw
         9hyfkaFJDr4OhLBbJ+ZL0g9fyP9lK5viHt9kcxm0UwZiVMg/nG7B6scSFdxmQ+0bELpY
         7Hn4X3IkBQgHYC15D0eukJLPUVIxJxklCeXDzdiodPfCF6jAM8mEx9fPRa9+f5I5LJb1
         Q8Zw==
X-Forwarded-Encrypted: i=1; AHgh+RrEKLkTwljSehaUa86pDerEoWZLlFvU63Zi35KaYWPsB1AEhWNXlrmpGN1yXcYA9+zU8ocwpms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHi7U074wbig5TixNxpT+jkHOFQQPqgUy5RTEhCb6hfTt6Jld
	F5ppolh3zGCXzDq28jAE+aPxy3rrYaqyiSCd63WapYeknj04fn1CXnvHOEXOYcM9OFouJxb5KZl
	S77Q8u7N+tOEMQiCN3ZfCTRfjqb9sjDWbv/F0GB3fSPAmNe8GWkk=
X-Gm-Gg: AR+sD10NwWNfuGEAAob0hOI+RhiqX1RHTdibxrBZ504RFfS1jswnerMqtqM0EAqDOQS
	2c1XQqvR/sbyHlj9ImM+4XHdnLJlS/Ts+uX46Pe7r2DMrf1fKP8rJN3lRPdJPf+8U/VOk6D5QkB
	NuHZD+HFehpgdc5RsbWTvz8jIpkXJFoxZv+C6GepsO6KvpPVfxov3d67edbhqwyf8DLhuE9qXFT
	dWIQqub5gqgS4DHPVtdiB2oS7V1ZRjlLRJwWe6fGdnVHFajlw0HQIqE8dx4ViVk3boTiaKN3JMT
	cPJ+1xQbLkwwYi0T1uGmF6gbT6La8Be0IhQQ9rgq53h316mr0ZMujrl7wnt72nQE57FqeeJNkTZ
	2Rlf8usFf8FK5p6Tvd5x1b5tzYR4mBzbcVkssiUJsEdM7EMxk4mJ8NTUoLpS+fxnJM00Rp0botI
	BoLG0C2btAbUaVEuwGzBrsG31gr3aOAApNaam1w3V1ncPPci+x+RawHoTFn5kyZQ+m/rV/Stmnj
	OVGmbcE
X-Received: by 2002:a05:600c:a597:b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-4994e7d9be3mr113312645e9.14.1786009868935;
        Thu, 06 Aug 2026 02:51:08 -0700 (PDT)
Received: from [192.168.182.19] ([185.242.181.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b25c01sm4435750f8f.29.2026.08.06.02.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:51:08 -0700 (PDT)
Message-ID: <96c13143-ada5-4a38-bf31-eb36e5828b43@openvpn.net>
Date: Thu, 6 Aug 2026 11:51:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ovpn: don't re-hash a removed peer on float
To: moonafterrain@outlook.com, Sabrina Dubroca <sd@queasysnail.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <20260805-ovpn-fixes-v1-0-763f8c237fb9@outlook.com>
 <20260805-ovpn-fixes-v1-2-763f8c237fb9@outlook.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <20260805-ovpn-fixes-v1-2-763f8c237fb9@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junrui,

On 05/08/2026 15:29, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> ovpn_peer_endpoints_update() releases peer->lock before sending the
> float notification, then re-acquires ovpn->lock and peer->lock to move
> the peer to its new bucket in the by_transp_addr table. The only
> re-check in that second critical section is for a NULL bind, which
> cannot detect removal: bind is cleared by ovpn_peer_release() only
> after the refcount drops to zero, and the RX path holds a reference
> across the whole float.
> 
> Both paths take ovpn->lock, but that only serialises them - it does
> not order them:
> 
>    CPU0 (RX softirq)              CPU1
>    ovpn_peer_endpoints_update()
>      spin_unlock_bh(&peer->lock)
>      ovpn_nl_peer_float_notify()
>                                   ovpn_nl_peer_del_doit()
>                                     ovpn_peer_remove()  <- unlinks peer
>                                     unlock_ovpn()       <- drops last ref
>      spin_lock_bh(&ovpn->lock)
>      hlist_nulls_add_head_rcu()   <- removed peer re-linked
> 
> ovpn_peer_release_rcu() then frees the peer without unlinking it again,
> leaving a dangling node in by_transp_addr that every later datagram
> walks in ovpn_peer_get_by_transp_addr():
> 
>    BUG: KASAN: slab-use-after-free in ovpn_peer_endpoints_update+0xa5a/0x1010
>    Write of size 8 at addr ffff888008576858 by task trigger/78
> 
>    Call Trace:
>     ovpn_peer_endpoints_update+0xa5a/0x1010
>     ovpn_decrypt_post+0x212/0x1040
>     ovpn_recv+0x2b6/0x540
>     ovpn_udp_encap_recv+0x21c/0x420
>     udp_queue_rcv_one_skb+0x1060/0x11a0
>     process_backlog+0x451/0x600
> 
>    Freed by task 0:
>     kfree+0x11a/0x390
>     rcu_core+0x7aa/0x1570
> 
>    Last potentially related work creation:
>     call_rcu+0x82/0x720
>     ovpn_peer_release_kref+0x5c/0xd0
>     ovpn_nl_peer_del_doit+0x355/0x550
> 
> Fix it by extending the existing early return to also bail out when the
> peer is no longer hashed by ID. hash_entry_id is unhashed with
> hlist_del_init_rcu() by ovpn_peer_remove() under ovpn->lock, which the
> float path holds across both the check and the rehash, so a peer that
> passes the test cannot be removed before it is re-linked.
> 
> Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

A fix for this issue was recently merged to net:

commit 33ec10567fe14456063daf549fdf1a4f53448e4c
Author: Antonio Quartulli <antonio@openvpn.net>
Date:   Tue Jul 28 13:48:47 2026 +0200

     ovpn: skip rehash for peers already removed from by_id

Probably you came up with this fix on an older codebase.

I suggest two things:
1) always check the openvpn-devel mailing list and our patchwork 
instance for already submitted patches that are waiting review (or that 
are queued for sending to net/net-next)
2) make sure to always pull the latest tree patches are based on (net or 
net-next) before sending them over.

In this period of hectic AI works things are moving exceptionally fast 
(well, not always :))

Thanks a lot anyway for looking after our code!

Best Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

