Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645422;
	b=f4cFPpTqWVga1qpBNN5rVH7iPf4O64iBUGLcy9zG8twkS1SAh2wDtu6nmxoIhaajBr5v
	 JFmgIjQ0M+anjkTqNol5E42KSNiRvMS6q0dbaREjPgeGoLuJRQga5k1DoCXos2+PWXjZZ
	 EZ2kwUXdzBE++8Egmmwq6buRi5ijtJoTMdxhLwExGbsyF1Gl+JfnIPKpSSx8/74My0xy7
	 w6qbwsK9EwKe/JH8Uof3oTHA+f9/rNNzx4VhSQ7rNYuJRbLGCdWBXIMS0sUhkxse4Qzf0
	 XI94g9CPkzQGxn4FAkZN00THy6n3wIc7Ae3KG5T6fOPMfnXHL5yorUBtBVxBF4/BVIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1+PqdBY+Kn+vTVD8wBIeE/Wp76LdlfMZhSQGe7/rnXI=;
	b=4CuYB4bn9CjRgRhXtiyT0XUUHPMcwNcKOp4UaLzP+GeKWJEEHiP30KytMW+rOtNUHpO/
	 jLG1eimzyizJwjhG5IA0FzgWwv+q3ouy8BFwfbCNt8kiSszruMbCK4GN81tmb8Om7X6rL
	 XunnCx3C4mp7tTcKxItm4hq6AvAOiO0zs5s/8ZRHYbXjMWO6XpzRNrnfxgkL54/XKzx+X
	 oEyCpyoVPYExPl2NxF5LNSnXnpdg7D/ncElP4UyN1YzyApadonq+65oC76eWovLZ1fU63
	 9G4oKWYS8is6jOR/TIQrFQpSvl0ild3EKJCDDigVqkvMZGh2Mpab5vlYjx6a59YCBMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p2+Piy3s;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F61606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 18:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35F61606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p2+Piy3s
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3535a54bed9so5037639eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1793645419; x=1794250219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1+PqdBY+Kn+vTVD8wBIeE/Wp76LdlfMZhSQGe7/rnXI=;
        b=p2+Piy3sAooPGQJVbNsD99Y816ezaXqpod5YbnBem2fq6wIOuOW3ZsHW+jNTagbfZK
         JPLSW1xihm9pdnsrcrPQWoNmVok3fvK+cX27K8SeproOZJKxvtn2pObWdkr/aTJavyHc
         fYp5snY7hjz+rKceH+kTDA+BRVTkaashLjqQVUQSU5IdrcxIGeuJC21uSYb1kbYJnU1r
         Yi829yFsVjhlbCPauZzn4kXivWq5mfqJziwL7B1TuF3sW0ubsYV1bgkSVy3Os7vDgGhJ
         xX8OPMnDDNxuS5ieQVzgpNHuiFHFXu9XCasJ3nyqMX8VVzG2z2EjYhDpmY6i7ba8Jo0H
         ZcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645419; x=1794250219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1+PqdBY+Kn+vTVD8wBIeE/Wp76LdlfMZhSQGe7/rnXI=;
        b=XG/ma3Z5BXfO75pUCfEmMkENYCBLe1m1/7/0DxRIIF2CSPC7rwB74WJd/N4fWY34GP
         ZsoWO53nUWVF8OwSvL3Fygs4EagZWwliJODgX1cm+j0hUS1+knQrB60cb9FDsRMIsa5K
         RypVxdwmrugMjQc6LPisWU8kUEqLWV9F8wWSNZh3YaSQ4KLIVeKD060DgXvOIgylkX51
         NkL6fTtr/xrruUZLgbU+WcctmOix0x9VE9HZQbuhJxY37OBSlO8+kulgwz/O1QPx7YWn
         AwopOGwHMwLFFUUqHhNQRuT35LsV3W9h9+WUW4jZrYZ9KVkgrQkOsUHwNpzxr+Uu4llA
         sMrg==
X-Forwarded-Encrypted: i=1; AKwUvBwayaIRxFhsL5qXDWjR0aajWXZ8q1ZeZYudKgBCA56wjIpLTsDkIxTF5gUObj+Wq82m6W6Q9DI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BdYtE9HdVEsf2sggFvp3ZCRt1jArU7YkwrywgmjPJ9yxjdaLD
	tp9qiWTRBuXpvU/3NFXZRd2A68fgEh4G2amhwVumUzvAStA7ue6nV82OiiU5Abo/1vJ0joOybsJ
	G9O0cRpVA4hakjxfVPbDaLqk0A8/wLboBHGAupVHn8rIEVWpatpc=
X-Gm-Gg: AYBFou1xbsHoiXvUz3T1YbKvNz0X5oQYGs0/OVX4BfYEu2P0alShZuTT//YNg4ynbFT
	3/xKpUxwrqe+pEbmawNi39y8SCxYqtXv82KQ96P0IaMH7u20PjNEpmaAqGguE5OjP7756LzNim0
	ROtM2k/6C+f1YunoPfVlhV/Q1ri+kMhFEcr9gbUBvmJJzpBIkOpXRIaMqa9ufy2s2Rwb++ipt6G
	bqpOP8lvI9ZPyiM/YSnHqq2YvsL7e+JymFdatqzqlhPGsNNx2u1ZsPUX1p8+zF6tTQKIAypqV2+
	nAbamiXiOVNFTv21wjNd+tB3UOQoJTLsJUXuQzn27enj0PeDr1g+yKIFxKP905iI/8xxr++qGUt
	Mt32b39e0OG1j7nE2EgGKcVPI88nxgyRrZE/EXRmLfT1BihUm21s6MBzkrju8sv4/nA/Rs+iRGl
	h6/ko/CxEtRbN+w+OFEkelVhGsldPIpouEqfNKbqtC4OjE3LiFPz0cXhdS4hHgzl/AU+TEE+DeG
	zM7/QVFKDaS8G7phm8YRdPa9Tw51zfcbGlkOo4jela3BndVEigJB1U4JkB2iMqqStvkFNi9IPM4
	Wde8YBnIEQx3HsSpspA14Ysti2Q/VPlc0m257BLWfQ==
X-Received: by 2002:a05:693c:41d9:20b0:368:4acb:f8a with SMTP id 5a478bee46e88-36a4242f5fdmr16518897eec.17.1793645418844;
        Mon, 02 Nov 2026 10:50:18 -0800 (PST)
Received: from localhost.localdomain ([174.136.204.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429000f8sm39651738eec.13.2026.11.02.10.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:50:18 -0800 (PST)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	stable@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2 net] inet: frags: limit the truesize of a reassembly queue
Date: Tue,  3 Nov 2026 02:50:00 +0800
Message-ID: <20261102185000.2384364-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030081225.2575462-1-edumazet@kernel.org>
References: <20261030081225.2575462-1-edumazet@kernel.org>
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

On Fri, 30 Oct 2026 09:12:25 +0100 Eric Dumazet wrote:
> The truesize of fragments in a reassembly queue is only bounded by
> the per netns ipfrag_high_thresh sysctl, which has no upper limit.
>
> inet_frag_reasm_finish() sums the truesize of all fragments in an int.
> If this sum reaches 2^32, it wraps, and the final sk_wmem_alloc
> adjustment of the socket owning the reassembled skb can cancel its own
> reference, leading to a use-after-free of this socket.
>
> This can be triggered from an unprivileged user/network namespace,
> raising ipfrag_high_thresh and using padded TUN packets, which keep
> a large truesize after being trimmed by ip_rcv_core().

Another data point: the described trigger also requires ip_defrag() to run
before skb_orphan(), e.g. via nf_ct_bridge_pre().  In plain TUN local
delivery, ip_rcv_core() orphans the skb first, so inet_frag_reasm_finish()
sees sk == NULL.

> Track the sum of the truesize of fragments in each queue, and refuse
> a fragment that would make it bigger than INT_MAX / 2. Callers kill
> the queue on this error. This bound is far above the needs of
> legitimate traffic.
>
> Fixes: 18685451fc4e ("inet: inet_defrag: prevent sk release while still in use")
> Cc: stable@vger.kernel.org
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Tested on QEMU TCG x86_64:
Padded fragments traversed tun_get_user() and nf_ct_bridge_pre().

Before this patch:

  [   62.400852] ------------[ cut here ]------------
  [   62.401690] refcount_t: saturated; leaking memory.
  [   62.402231] WARNING: lib/refcount.c:22 at refcount_warn_saturate+0x74/0xe0, CPU#0: init/1
  ...
  [   62.416741] Call Trace:
  [   62.417754]  inet_frag_reasm_finish+0x734/0x8c0
  [   62.419460]  ip_defrag+0x149c/0x25d0
  [   62.420502]  nf_ct_bridge_pre+0x95c/0x12a0
  [   62.423684]  br_handle_frame+0x6d9/0xf10
  [   62.425568]  __netif_receive_skb_core.constprop.0+0x576/0x2bd0
  ...
  [   62.430759]  netif_receive_skb+0x7b/0x3c0
  [   62.431822]  tun_get_user+0x1a1e/0x3a90
  [   62.435183]  tun_chr_write_iter+0x138/0x260
  ...
  [   62.455272] ------------[ cut here ]------------
  [   62.455348] refcount_t: underflow; use-after-free.
  [   62.455376] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x9a/0xe0, CPU#0: init/1

After this patch, inet_frag_queue_insert() returns IPFRAG_TOOBIG:

  # tracer: nop
  #
  # entries-in-buffer/entries-written: 8193/8193   #P:1
  ...
            init-1 [000] b..1. 44.803126: frag_ret: (ip_defrag <- inet_frag_queue_insert) ret=4
            init-1 [000] b..1. 44.804161: <stack trace>
   ...
   => ip_defrag
   => nf_ct_bridge_pre
   => br_handle_frame
   => __netif_receive_skb_core.constprop.0
   => __netif_receive_skb_one_core
   => netif_receive_skb
   => tun_get_user
   => tun_chr_write_iter

No refcount warning was observed with v2.

Tested-by: Wang Zhan <wang.zhan@smartx.com>
