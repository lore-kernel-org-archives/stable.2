Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685236;
	b=LNb5PCDxmrn3218MiyjWUPqksQmC3OC8Vz3ZLVbrzevxOOehgjLQsptjY9aTpflDhDKc
	 l9LiZx6MH+OEnNPSMBTn751YBy3eXFPng9swMN/OD8fjR3cNJOrNJ1cIqn3eAE5l3XMVL
	 gGrDUl6ZyAlFfbJ41Zi2OpaqnFRVPONG0EUPRLOA77GBbn0oPFr8cyCHhqAWAwJwJ0SD4
	 N76/HfMiOgcR/lBoE7Wf9Jz8ojX8Hjx6I0SDwb/ue4pUWKHeP7fAT521mWhg+F6M0qFJJ
	 w71f2e7JGEHhWuW83TJbppVqN3clvX7ZT9M8wrfx/11ijdLV19njshJD4I1lmAoWoig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LQOSfvYjsc0pne7U/QqZbr4f9DH/Fqk28lPhlIhBOEA=;
	b=lbWUQeEjuJLRrFmPBBeKqxFWpRuy1nBpTt2lFF+dGmzpakvyCH+ve+2dqT8cRiBTMf9g
	 CpShqCSfwfXYVGMhNSal9skO82ZXvLG9ML5zclpfmHV2oGZwVgkobJF26Yg5MqbL9itxQ
	 hV8RHKCTlVZfjXGVDx3MtDvYLPOLopeNVM002fpSVFao1wxRcwcBVOPk8LBz6jgqhUQHP
	 Jvp9423nV5XG8JsVGFRVnFpKQ8P9p6mZ4v1ERnPI5lSSW1zC01sgM3qopk/zqw84uX6mx
	 p4GX2N6DjA8EKOsmAsisvAvbyqZ7xELWuDxsz5m1DiKl5Sl6oA5FFrQtLWrSX6zbknQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=StFthbsA;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B1606A32E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 05:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D2B1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=StFthbsA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e9572e892dso26981265ad.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 21:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793685235; x=1794290035; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQOSfvYjsc0pne7U/QqZbr4f9DH/Fqk28lPhlIhBOEA=;
        b=StFthbsAOp6jdyLITZCeesv53uxGdx7tmGtLXJFplgrKgU6dRrKMf31aKh5NByS080
         ZOxD6LKwIZiR5Fk42GJDFakkKnrBJZAWMGjtRT2y+xdNvyAUiHjcENxUIk4LM/GrR/1l
         chTPZSNddCb07kj3GMXweJSzTRLUzlQRt6I19JPyha71MOsj3hAnhvMT0yLOKGNSFdRW
         S1mqRoQrXlfpI+3YE+odNwJHwKsb8IwbjujPeAs4Qk+RXB6r/XmUNwBYD9H8dDoUsiDc
         D6tOZ+xc1vtUEIQEuTP3Ap2xUIq9vUAp8iPPcuQeO5YORSsE8Gnfaz4+GZXoE2dn2IuD
         M6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793685235; x=1794290035;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQOSfvYjsc0pne7U/QqZbr4f9DH/Fqk28lPhlIhBOEA=;
        b=Y3C/IBRK/qS67nxLxD42k3Ks/ZQjB8DA7PjDgcF95dedK15NzYg39LIMHx7QWvt8vg
         yh0PT2ZyBrzmFZBjWq9cbXj9CNk/XsiUNtQaBCG/WHvSig2vykNpqNy5b8UnF/YptysO
         uU2ZYh5XoXzuOm9AAJBpgmGqTrA0+7KCBrDhgbAbrC9wDWMOjKs1AHzTKKhYqNTZByQK
         EGsp+/j6zB4xwfv6bfXxihCTY91aHQqdvmGEljJ7GbTb21b6Y6OJFUAYsp1bOvpnvi39
         OIkbkoOfLClgBcxsi3rzgTN8tnnhMyXYDKlfVFLAvcvA0tIFCEOtuqmSYTQm08TXW1B4
         f6YQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8LylpY9/oF7iof0uqplWx2RpyLgBEv6OtLDzLdh1GloHiJjjG/LRED4EE2s2b+RegoFguQKE=@vger.kernel.org
X-Gm-Message-State: APuU4Z++HjU3ikvFICLBWoZSNgikBRUBwQpZ7hEGXGN5gINuSv1fQR8w
	z0JIhUIXDBFUeFowNPt0Ju/Qpzyadb+DSlA69CkJkQWbv4rZrN8dzm0LnCNevSxtmJxxnoKHjhz
	qBBVPtg==
X-Received: from plbmv11.prod.google.com ([2002:a17:903:b8b:b0:2e9:4bb7:2719])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1251:b0:2df:9497:3c89
 with SMTP id d9443c01a7336-2eb36526a09mr102814215ad.59.1793685235115; Mon, 02
 Nov 2026 21:53:55 -0800 (PST)
Date: Tue, 3 Nov 2026 05:53:54 +0000
In-Reply-To: <34f32e63b803f9f7faf0b0a5754219e48a986136.1793616950.git.x-professor@outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <34f32e63b803f9f7faf0b0a5754219e48a986136.1793616950.git.x-professor@outlook.com>
Message-ID: <aulzHJaoSQOWbw_l@google.com>
Subject: Re: [PATCH net] tcp: free saved_syn after an RCU grace period
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, 02 Nov 2026 10:55:58 +0000, Yingjie Wang wrote:
> tcp_reqsk_record_syn() allocates saved_syn separately from its request
> socket.  bpf_sock_ops_get_syn() can load that pointer while processing a
> retransmitted SYN under RCU.
> 
> There are two ownership transfers which can let another CPU reclaim the
> allocation while such a reader is still using it.
> 
> First, tcp_move_syn() transfers req->saved_syn to a newly created child
> socket.  The child can be closed and tcp_saved_syn_free() can reclaim the
> allocation before a reader of the old request finishes.
> 
> Second, inet_reqsk_clone() shallow-copies request_sock during request
> migration.  The migrated clone becomes the owner after
> reqsk_migrate_reset() clears the old request's pointer, but a reader which
> already loaded the pointer from the old request can still be using it when
> the clone is released.
> 
> Both request and full TCP sockets currently free saved_syn with plain
> kfree().  Embed an rcu_head in struct saved_syn and use kfree_rcu() for
> both teardown paths.

Please add rcu_dereference() in bpf_sock_ops_get_syn()
and RCU_INIT_POINTER() on the writer side.



> This follows commit e3f33b0a1d89 ("ipv4: free
> inet_opt and ireq_opt after an RCU grace period"), which fixed the same
> ownership-transfer pattern for IPv4 options.
> 
> The issue was confirmed with KASAN on v7.3-16007-g36aad21d50d1 using
> temporary kernel instrumentation to widen the reader and request-migration
> window.  KASAN reported a slab-use-after-free read in
> bpf_sock_ops_get_syn(), with the allocation freed by __reqsk_free() from
> reqsk_timer_handler().  The same explicit migration test completed without
> a report with this change.  A patched kernel without the delay
> instrumentation also completed a successful migration and seven saved-SYN
> reads without a KASAN report.
> 
> Full allmodconfig and allyesconfig builds completed with W=1.  Existing
> warnings outside the modified files were made non-fatal with
> KCFLAGS=-Wno-error; the modified files emitted none.

I'd drop this paragraph or move after --- since it does not
add any value after review.

---
pw-bot: cr
