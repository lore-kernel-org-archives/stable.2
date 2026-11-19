Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069387;
	b=wGTrXgbPykxNDOGVZN6J33vXy/tXNdUIflGjm0c2nYeuLzR6eqrmJ2jkjyCDe0sJFssF
	 Gjd4PZ22uE0Zuf07BPuylIZqvp/2EiqqZj0TW1YE0TC2J6lndc5OXmqz2gGedsDC8OrEn
	 K+CRWNgCQGz+KfSjLMVTaWa1XOpJhu8NyKoh5oEHwz5A6bk6NHHcj5KP6bPkt4oPsrys7
	 HVhXrXT9E5xhr/uRciNz7+3wOzSE/dztKrim3VQatYXDu1IkP+M4F5bn9DU2No2G345U/
	 CFZgyz6Op9T0rF9YCZYsZIMrzLbAplfsrAYWtdV/PjDq3kOVqSjQMr+vXYO4vlpfWGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=V3V+gW+4QnpXlZqmDyQKdC1vPF8DCpUTnjwDnqaNguw=;
	b=lhxgCb2K98d7tZN9FuthMtI7j9VWCFWKl2mBT9kz4T294l59/BHoZ6N3IMEs6rOa/Y2c
	 tWe48uAH89uQHdrwpf2L0jdXaPEup4pNuE3sdYQZ77bvBgHX0kUMwm2qOhYl6hPiZtOfP
	 1ypGzbx0fZjD+ajUeFgkk1XhKTqYvT2KAwGOSDVnxyHNUhbjVh7ncAV8k9uFZXLbpSstZ
	 mz0hgYyZBx1x9jMvviz2Ou7LKWdwR6eScSSdUwabVzYyEX90NLsoFQqnw2xjW2ildWESc
	 O0iO7PjX/oJm6yW+30+7Ane5ZustLnxbO9ii15+iK8eslkdTlcQoxPQmYhDkOXSpPsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KOgBuV34;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E65606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39E65606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KOgBuV34
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eddadcce7cso11230585ad.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795069386; x=1795674186; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3V+gW+4QnpXlZqmDyQKdC1vPF8DCpUTnjwDnqaNguw=;
        b=KOgBuV34NzYfNY8Y7g70SamQjhVlLaZKeKfEStrlLEqNrkjEQMxs+mWIdztfPe2IuW
         ld2bTPY+ZMcX8gQxhvn/YUwDKaBBodHQNG27lxWcTw3Xp3cQRZeW5kKOtH5pWWqI5lRs
         td4jULqH+ziG/zKS7VwPoDi2kgyXbjx9DRxm4njhquRZnAWZUmh/Ih3KffQXWQyRT+Mm
         1rsg/R2Ej58t6Qrk4pSFNyypN71dg4Pfuci1g71q36JkoDt/v6o52jJeA4FJTij9QmW8
         a5s/bCeUqPkm4q1kxGmovmgSvFhNXKf2s9o6x8BTnK2qwSksvKwBboTij8xvZRvF60YT
         8WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069386; x=1795674186;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3V+gW+4QnpXlZqmDyQKdC1vPF8DCpUTnjwDnqaNguw=;
        b=wRL5FdRvzZLIY/y9ndtzuHgLCXTVoD3MV4S6qrQ5fGp6CclD+zn3qM+Y9fMl1b9BGx
         e/CDx4vGYjy1Y2cRmkCULwBNOLatjLEnFucNghxk5TpoKhikyH9Wicy2H3ZiciYkzjlz
         vs0QvLSAG1nBiFam78fHQcuFdxoFzwlSn789zVvYNjS6zonwSr4+TsAjvniyQMeEGx6Y
         5zs8khzaOygN3MM5NXa4EqPcjyi/wQ4fGTm4DFh2A9qNwud+eFZCGrdd6k9wzejEgSEC
         CI69IDNs3pkYzKUhThpJaLv2m4IJfvcGJqwp6D8ZhzTzrULgCN3ALOTGCvYqDuU5T7gr
         EUoQ==
X-Forwarded-Encrypted: i=1; AL+hErFu9u9fnfkl4jmmUZFaJBDd2X6Ph+Ln8QFePq1vHwIvfoAm75svQjqmbgxGpWcytZ/zLBwdrkU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BgZdZNrn5bMr+wluQk71IR8HAPQKnY++zUvzKn3aGNnzLJjti
	Ehp/26p1qLeGa9sincHDplmSMslPrMQqmMizlLFcRZ6sPPv8oUJho7XUcAGCi5+WsF4bFSSevaY
	cnl2RXg==
X-Received: from plgi10.prod.google.com ([2002:a17:902:cf0a:b0:2e8:f377:a4d4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e3:b0:2ef:ced7:9ff4
 with SMTP id d9443c01a7336-2eff740c243mr51107455ad.31.1795069369890; Wed, 18
 Nov 2026 22:22:49 -0800 (PST)
Date: Thu, 19 Nov 2026 06:22:49 +0000
In-Reply-To: <0907415D86226AEA+20261119025619.3485277-2-guanwentao@uniontech.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <0907415D86226AEA+20261119025619.3485277-2-guanwentao@uniontech.com>
Message-ID: <av6VHCsEnrAMOx0M@google.com>
Subject: Re: [PATCH net] tcp: cancel cloned request timers without waiting
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: edumazet@google.com, ncardwell@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, melotti@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, 19 Nov 2026 10:56:20 +0800, Wentao Guan wrote:
> When a cloned request is migrated again, its timer has the same lockdep
> class as the running request callback. Using timer_delete_sync() through
> __inet_csk_reqsk_queue_drop(..., false) can therefore trigger a
> recursive-locking splat and disable lockdep.

This is net-next material.


> 
> The clone is unhashed when inet_ehash_insert() fails, so
> reqsk_queue_unlink() is a no-op. Its timer is pinned to the current CPU,
> allowing it to be cancelled without waiting for its callback. Use
> timer_delete() and drop the timer reference directly instead of
> synchronously deleting it through the queue helper.

This change depnds on 4e2b3ef19e0e, without that, __reqsk_free()
frees reqsk immediately and timer triggers UAF.

So please mention the commit.


> 
> Fixes: 97c8a3c1f73d ("tcp: Fix potential UAF in reqsk_timer_handler().")
> Cc: stable@vger.kernel.org

Please drop two tags above.

---
pw-bot: cr
