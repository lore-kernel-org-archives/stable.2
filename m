Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976924;
	b=rJr+lYFtT44F8TTSJ51l6MCEBf2stPla4KEJC2aZtzQ+hra4jguX1WspP7Ny4Foipp4c
	 iUbCSAZA3Rw/DHOuJ4eT/9ew08/E3g9edReywrQAFdnSAIHB1NfykFxWvD90oXvBvE5nq
	 M0s0stwFKzeCbxLecZ2KrixMBxDBAa4phqyZ/PRxblWZgmsStDoTLbNmz/mWEIbbWmKar
	 bv4pqRT916uf4NzAVrZqMhz2QhVkN3ifITN9FAdcdgqjCBAApWk/s9KZlLrnWzjGaO5k/
	 D6hJ5Ivn8IYeqbRsavgs9p+N5PBZ/tTeoflOqRZEL31F5h3CZSr2+iOB4/t25kFTx0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=CEvqs1X/nNyjFGF57/UwB1GPydCvgLvUiPVC3sYODKY=;
	b=rIoy5dC/3WBD4tdjn8RSNFSwskmEKCC1QgsCP7buRlk2N8fNKlHE4vIekqDPmMyysukc
	 Og7oIv6riRCWg00vPxIHTvhxxqW3UCG8QOVTVfIAnjwWlmsyzMJZiChvOrjp+M2nAkp2Q
	 AjFVlDhDBFN6CC6NyZWVsvCZ0g3/lT8LJVbPKofI9hBNSRsJJ1K9w6+9YogOX6+biLrQl
	 mAfPrEIacXq7pt3wAlFg7zQeyP1Zlr5kRkAB6Q50L/mxnu80nv7876TLzH/9H+h3risIM
	 hdecCZAwFnZxNQdWa3kkQulYU6AyDF/Rog5CJwClkYWisKFIvmyNFtjtzmmE8NZ7QMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvEcq5EW;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9F606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BD9F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pvEcq5EW
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso339643a91.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976923; x=1794581723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CEvqs1X/nNyjFGF57/UwB1GPydCvgLvUiPVC3sYODKY=;
        b=pvEcq5EW5p5RyHhNApIpanjG+XM0py0wkLCpq1Xoa3Rz+fpzGcOAiH/VQsXsemgM2S
         9/PT4v1X1PrWv/6wko+hr5538Uzoi1ZxC/AFsLOhd+bY+DRPLkKcZleqOOGtCDQoD8M1
         mM+eeXRYItk6md6ykyYNeDjO7DnyXRssj+9poenaAlETqHqgC2ei9cd5PQGhXJvEHMpk
         kpIkYRIWkVJQf+Vzm9fgwIXNAbdVd8ZfceNtJOW4YQRZKD/LlADYQsXXuNKPzzq4wbV4
         10BaI/kiV81y1PXRDYlGI2+oI5LvaqZsbIOBT6KGXLMGbic1FIcM+oW6WCpBUL7XCdmP
         vB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976923; x=1794581723;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEvqs1X/nNyjFGF57/UwB1GPydCvgLvUiPVC3sYODKY=;
        b=Ew4pzmsB27Yi0XkMA52c01dTVGUdC5PmDHBcmVgn2N6dQiXLLTYXOJCzQaxcJP6KY7
         1qInWRnc/vrLJExZ9LKczjQQK02sFjYZFF7wVBzM4NNrrvrKHLajPFaijfMt2mu/TZnV
         goWO+YSpT8rLHuggUAiJKPkDwdQEuFfDYL5QD2d7bxdHHX+wBhfE/ThKPKsEDSl280de
         19CxY3hFw0HhYWloTxmqQarYB09dKyHvMkIjCP2hXo95mZTX06k+QhnghvBvw+KV7Z7F
         PylB479+TtsyrL6qMD3tPxkdiCCBt7OcWXgFoOM7SIKtHctsUP6ilcZ+7HQvWplEq2Nc
         ChYw==
X-Forwarded-Encrypted: i=1; AL+hErG40rd3jfh5O6CuijMaVsqRGr8F2BovbHA+6+DkPlT9Hqp/Sjkiz1GdBdTEeHWOtjfZHEXbI+U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IeefULhs2MmYgD4HV37MQlt9ec0WQDXrm3lF7ee5y54kYQFZ3
	D04Q1eYybaK5zcMDqsG7uNlt3+8KFbnBT+cGYYIlMgYYIeXZT2w9aYRhtxpigZQURAA=
X-Gm-Gg: AYBFou2Pjw4Fhziy3ESTUj7OW1bqvePAIl9mGczNNtb77qpwQ087mAA5tmvZTBsJyMB
	s1cpduy4Q1ikRUal4J30IBZfohEj/7X+t+tjPUzuzYBB7AFS/bUL8ZzEqWFtWusJInQFG70FBdm
	xWbDtjRYohnpW8N3yiucMr0uDaq0DG0KkKtBQW6WRxwi6zLtS892lyJJGcwGlB+YSTt6+Kry4oU
	R/bwQouN7FrzWXDtJngQeBQmOA/xch0W8XwyQcmmD2D+7Ks7nolKJhVHyevsiHGGtC9jpKL4Yzi
	4NMhlStmHi+d0ZCJ0dQ5Uf5e20XZhLh5GanbSdkv51SeHzpl7fKHrxKyEQfMv028y7T6+gmKoto
	3b39DyxwNLo4Ny+QiJ23eacCbdASCQTwxYSIr4wWQyx9O7jOfkSWAHy/NDQQUBV70C0qQmNi+lw
	N6J1P/ZdB2vg70pcwW0j9tALpZN2x+/w3+G1R0JBe0HugDwyEOWWbvwNtTj7IijSNF8Fc+Fdj3S
	7v4X639pg1RM9y9W2vRfh17mHTUfm5SUs4H56D6PPHQN4oKT01iP+YdrjXQ9FPil9gieh3KaFkP
	hMJVZX0Lr9g73dwfeDokdAiGF6ZCs7pX8Tml+9WO1xy3hN6a3r3bO1U=
X-Received: by 2002:a17:90b:2d85:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3b0db700c35mr2482629a91.64.1793976923367;
        Fri, 06 Nov 2026 06:55:23 -0800 (PST)
Received: from [192.168.255.10] ([111.55.212.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c42a72sm3783225a91.3.2026.11.06.06.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 06:55:22 -0800 (PST)
Message-ID: <4c5e04a6-afba-4f7e-b790-c109ddad0318@gmail.com>
Date: Fri, 6 Nov 2026 22:55:10 +0800
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
Subject: Re: [PATCH net] net: reuseport: avoid duplicate closed socket
 insertion
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, TencentOS Corvus AI <corvus@tencent.com>,
 stable@vger.kernel.org, Lin Jiapeng <jiapenglin@tencent.com>
References: <20261106135841.418-1-ljp1205831794@gmail.com>
 <179397371960.488859.17332481477084448537@kernel.org>
From: Lin Jiapeng <ljp1205831794@gmail.com>
In-Reply-To: <179397371960.488859.17332481477084448537@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-11-06 10:01 p.m., netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


The issue was actually triggered, not found by code inspection.

Reproducer outline (unprivileged, uid 65534, inside a fresh user + network
namespace with net.ipv4.tcp_migrate_req = 1):

   1. Create two TCP listeners in the same SO_REUSEPORT group (one is kept
      hashed as an anchor).
   2. setsockopt(SO_REUSEPORT, 0) on one listener: sk_reuseport is cleared
      but sk_reuseport_cb stays attached.
   3. Repeat connect(AF_UNSPEC) + listen() 129 times on that socket. Each
      disconnect goes through inet_unhash() -> reuseport_stop_listen_sock(),
      which re-inserts the same socket into the closed section until
      num_closed_socks exceeds max_socks.
   4. The 129th insertion writes socks[-1], which overlaps reuse->prog on
      x86_64. Attaching a classic BPF filter with SO_ATTACH_REUSEPORT_CBPF
      on the other socket then consumes the struct sock pointer stored in
      reuse->prog as a struct bpf_prog *.

Kernel: v7.4-rc1 based tree (d68ce4e71248), x86_64, CONFIG_KASAN=y,
CONFIG_UBSAN_BOUNDS=y, QEMU.

Symptoms, first the out-of-bounds write itself:

   UBSAN: array-index-out-of-bounds in net/core/sock_reuseport.c:152:9
   index -1 is out of range for type 'struct sock *[] 
__counted_by(max_socks)'
   CPU: 0 UID: 65534 PID: 22 Comm: poc
   Call Trace:
    __ubsan_handle_out_of_bounds+0x91/0xa0
    reuseport_stop_listen_sock+0x290/0x310
    inet_unhash+0xd5/0x400
    tcp_set_state+0x125/0x260
    tcp_disconnect+0x47/0x1950
    __inet_stream_connect+0x2d0/0xab0
    __x64_sys_connect+0x71/0x80

then, after SO_ATTACH_REUSEPORT_CBPF is issued on the second listener, the
corrupted prog pointer reaches the RCU free path as a struct sock *:

   Oops: general protection fault, probably for non-canonical address
   0xdffffc000000008e: 0000 [#1] KASAN
   KASAN: null-ptr-deref in range [0x0000000000000470-0x0000000000000477]
   RIP: 0010:call_rcu+0x10d/0x260
   Call Trace:
    ? reuseport_attach_prog+0x6c/0x140
    reuseport_attach_prog+0xdd/0x140
    sk_reuseport_attach_filter+0x97/0xf0
    sk_setsockopt+0x973/0x1cc0
    __x64_sys_setsockopt+0xac/0xc0

   followed by "Kernel panic - not syncing: Fatal exception".

With the proposed fix applied, the same reproducer completes cleanly: no
UBSAN report, no oops, the SO_ATTACH_REUSEPORT_CBPF call and socket
teardown all succeed, PoC exits 0.

I can share the reproducer program if that is useful.
