Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911012;
	b=mKjU41bFIbeG289bCJvNw62Ryplgcjfzh+vKWj0iFmBWsOaZmceExjSH+ULucmHBX7m3
	 nY/JCrhjVpZpRwatfYKKranqmIu8H9IzpdKaGk2z29UXnBTN/3GduN0yKgpAALbZZx0BF
	 5GdM69rsd4F76ZNYIzSuz00YOcO+NA5BDhceCl16OLdwojOiw3kUi7/BRRfrxk/uwJC7q
	 HCM017nzEDiHsgYzCIkzZFMkPvAfHFq/irNPzj+tIAUkaW81L8MLtfKKV6BsXEt3dsCmt
	 F0VdKNlfGiNy/rraFX9/ofW9mn7AdscEypJXofM9Xj96fscxbLQqFUc+docT76OaiAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Ho0ssxdcOFZYydNEqXR/HyGk3gfggTzWbAzroYVX1OE=;
	b=HwyG58TLFWlhKSrdFQATFlFyE8KsvftS5fMlVL0yVDN4QzlObF1v1B4ufng36Y58yXW4
	 11qGAjHEBjh05shDTtfIeZUkbEhyJILTtPx5RGD+MLCbUGs5/zp7FjrrgQ+Ru5JkG2AcE
	 hehMTiGLbMwy+i7wafWVxTuLie6aHSqMLZFVSKZUCNrSXuUHys1AIu19dbuTRlT53Q1v3
	 ix5vVTjwELO4jQpCq4uohSfbmc/LvnAdlD++yqheDsMsEqdZd7cUJMmNRFKRUuQjwTza5
	 VOC8hXBy6poq4Z/O2kg0HkUz6BsAFX8aJ7DhiO82F/9WIEoJmrjZzl0lMD6PDZ/lxMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ww0Od+k6;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8268606D829
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 20:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8268606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ww0Od+k6
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb4c49e52fso2064659a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 12:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793911011; x=1794515811; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ho0ssxdcOFZYydNEqXR/HyGk3gfggTzWbAzroYVX1OE=;
        b=Ww0Od+k6WA74rbnGWCyPafAGJwjeDn1zHh7oJWkaWumgIa6Wy+e5IlIqTWjI7w6GYd
         C6cJe85FRieOS64oVYv5URhTugXLp52pjBylTbvV8WcaB4AbgqHDVzvCWQdRa0xE6vi1
         YxjurHWH1nWasxOOJVPy7eyMiUu7PfoPd/5mTJOeSx0z4LVN7sqL+W+B+HdigvItufdV
         CXaTu0ebmA3QFMUvX5aTAXUf2zufir0N/4WAoE5QL7GnTqnAIWYzFM+1UoqZbSElpcbI
         dr1NZzihgJNWbVrSgE/0TihQHwfsphK2MjMQZpwIcEP7jS6DRCk2Wz9nPUc/H94c4Q/2
         LYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911011; x=1794515811;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ho0ssxdcOFZYydNEqXR/HyGk3gfggTzWbAzroYVX1OE=;
        b=E8VFXsMUhhe+HtMxgeaQdkellSqCKcytEALZ0MqmD6JmdFae1MHYtJxJRLAKwDK2Sh
         Usb1+PSnKT0FG2NYnakrwLn2Irq4bMJ5jMLJ7/pVb27ul5KdBCkxQEkN1Zf7XUsxHf25
         sKA5a25GI+YWQKa8Ci3mpa9jclSTwNcY/LQ48D/jBbNCFnZCELF73zR9GsZoWtYXF2b4
         V8LeiLDhN5kDK2be7jpPM8p7mfA+ctEX1idlTxqRRIR0pqGoaD8fvFdMO+hNofSVymFK
         CCIfi7pa/BhZJpmJaqxYeQFZ4RF7pznqI7MWSYY2+j03T7rCcVaXs8tCoG4Fi05pkpsO
         SG3A==
X-Forwarded-Encrypted: i=1; AKwUvBzsHbRVzypj+QFUdkz3OongYZpSxsLKJTMCagQYElQVcNKNTmJlABvYQSxNRkpUmtOgJV0cL50=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RTv7fOWekcG0WjG7FexHfzsyxh5v06wMpI/iDP0RIuMWiArP1
	B1Pv2Cze16OsD6PeILWYQArHC5eEDKnE6uglk6+5Rx3xOp8JBsirADxUAkF5kpJ0L+kzS806nYu
	DvAGcjQ==
X-Received: from pgca13-n1.prod.google.com ([2002:a05:6a02:638d:10b0:cd8:5a84:95f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db09:b0:3e2:7c10:d46b
 with SMTP id adf61e73a8af0-3ebb29af117mr653557637.13.1793911010709; Thu, 05
 Nov 2026 12:36:50 -0800 (PST)
Date: Thu, 5 Nov 2026 20:36:50 +0000
In-Reply-To: <38fa9f2cc476502e9b1c1fef09ebba1df5dd5901.1793795528.git.x-professor@outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <38fa9f2cc476502e9b1c1fef09ebba1df5dd5901.1793795528.git.x-professor@outlook.com>
Message-ID: <auzo2EcG7UWMVdtn@google.com>
Subject: Re: [PATCH net v3] tcp: free saved_syn after an RCU grace period
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, 04 Nov 2026 12:32:19 +0000, Yingjie Wang wrote:
> tcp_reqsk_record_syn() allocates saved_syn separately from its request
> socket. bpf_sock_ops_get_syn() can load that pointer while processing a
> retransmitted SYN under RCU.
> 
> There are two ownership transfers which can let another CPU reclaim the
> allocation while such a reader is still using it.
> 
> First, tcp_move_syn() transfers req->saved_syn to a newly created child
> socket. The child can be closed and tcp_saved_syn_free() can reclaim the
> allocation before a reader of the old request finishes.
> 
> Second, inet_reqsk_clone() shallow-copies request_sock during request
> migration. After reqsk_migrate_reset() clears the old request pointer, the
> migrated clone owns it. However, a reader which already loaded the pointer
> from the old request can still be using it when the clone is released.
> 
> I found this through LLM-assisted concurrency fuzzing.
> 
> Mark the request-socket saved_syn pointer as RCU protected and use RCU
> accessors for its reads and updates. Keep the full-socket pointer plain
> because all of its accesses hold the socket lock. Embed an rcu_head in
> struct saved_syn and use kfree_rcu() in both teardown paths. This lets a
> request-side reader which loaded the object before an ownership transfer
> finish.
> 
> This follows commit e3f33b0a1d89 ("ipv4: free inet_opt and ireq_opt
> after an RCU grace period"), which fixed the same ownership-transfer
> pattern for IPv4 options.
> 
> The issue was confirmed with KASAN on v7.3-16007-g36aad21d50d1 using
> temporary kernel instrumentation to widen the reader and request-migration
> window. KASAN reported a slab-use-after-free read in
> bpf_sock_ops_get_syn(), with the allocation freed by __reqsk_free() from
> reqsk_timer_handler(). The same explicit migration test completed without
> a report with deferred reclamation. A patched kernel without the delay
> instrumentation also completed a successful migration and seven saved-SYN
> reads without a KASAN report.
> 
> Fixes: 0813a841566f ("bpf: tcp: Allow bpf prog to write and parse TCP header option")
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
