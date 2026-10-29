Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310925;
	b=UWEShg+YXduTLvJyvWCohzHxiaNGENyru+OAIqYNYIVtadIaF9iQB613NfPH+IgE03Sb
	 UH9/hI/RjgST7lLus6JX0iwI/b7uaKKkw+UqSy7MuMXHmFJrShY2UgwiK8C9mdKUUrYWo
	 JmygIE+S9VFqk0NC8Vhk3l7Zk3MujoE35Xkzy0zz3N0w1onP34cowE7W1Z/hAFVo8ldgl
	 LMRR6dYKMkHzC8YtSYea/X4MnR54gsxWlOmI8zHTRnA7JHOB/yga4yhPry69mSocPHkTM
	 Ge2Dvpbv9sIHpmUJSzT8oPAVcNQCQcrbb/21vPAzj1wn1gYEGiP+P6EgifhQNIyDKCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ftlqZLP89MBtbSltOHsyj/D3xJMjzaj4uqQVSc1oH/Q=;
	b=Ek/QB1fgVUyPXfPgTIg/MbCRtqCoUIadZWxAr9RSSjxnDI8bBcbOGzzhDuEqDvkU349I
	 DKZa/1yZzZjisR0bDWmj8vXOBkUhvsf4na1U/QbFKy85g4vubhlI3IuFyqBnOjRli5eDb
	 4PhTLZ0BtzcnAUq3kMIMbc98ZI2b4fmb3IAKY18aRXg+khDECEDhdxv15LN/BVthvORlp
	 JCusI0ksrwp4UrmIdTGjGD7/4pDzm3Xgs42y8ELfYs04tQiygqF4DLR1eP5RI4mJCbr0z
	 ErotkfS8Exzcinm8zQd748mJe/BZGUXOFGPreAvCxL164aAAjB2AHhWO4WxoKYtaw4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WA7jJW+I;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55034606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55034606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WA7jJW+I
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so33217a12.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793310924; x=1793915724; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftlqZLP89MBtbSltOHsyj/D3xJMjzaj4uqQVSc1oH/Q=;
        b=WA7jJW+I5jF5wu5Zdeb7AVdLfzhelM2Iq6Irm2MN/1udk2BhY/Y8vBAHlESg5eLkvu
         v1LCZllwoYwFtbyfglEcZWxvL1VXuQ0JaaqkCUWz0Iq6uNOC97lr2mS43ZxMMn5MyBcf
         mBTAKhG+texc4RvMh6UMgClhJgdkrsmLCcQBZzMu+8JxOYVoMVtxZmNasWG/i6+a/LGo
         MrOW29iKqAAHibCkAE3ICJIETu+eanUBa7qYNbLZuZnWbOBkw1ifmmGFoXK5xMHv8L+g
         tPPP9tIDvzb7qtHBt9QczljviGWNzTuzzRdPfn8dSKP/y3IW2i7LpWh6xKtUHmgWth9H
         J2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310924; x=1793915724;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftlqZLP89MBtbSltOHsyj/D3xJMjzaj4uqQVSc1oH/Q=;
        b=aLkD45RwRPKP+Npj96PVA/A0foxBCAa3+GVX+dWqPeuHtGSThjKPUkVTJ3MC4Is+Ue
         kI84RvgOqNULr3ZM5NzyBQL+vZz3DPauebsKs4sJip6Yp/j45WUMQeUNMAu2jE0HUodF
         EhFcb2tEhYlTDWySE95OcjH5ZZOvjKuo6dswzkTpD8e1RQCEXt0ZNhOwjd+dF2O65YUQ
         QSFk/xT0Mp+aTE+wUJtOmivuWKNrui+SD1cFx6pQGt8aJRwE4ecD+IFe6zHeodmrSzs/
         S1XxIqM1+9ZgCAXz0WNQp5vTTg3sL0T66SlRbuZL+phHQpZNCCMmWmHFa25LkCZYVRyC
         KXNw==
X-Forwarded-Encrypted: i=1; AKwUvBwl4m2TGT3sL5bpXPKCDjfc7AUOzRjP1TRNb0xJThU+fkbHV0q6aIsXmDAbsRtaUeoE/xtA4ZQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAgCkM6z+IjUv8M4WDwPAWZO6cwaEmEMSOxDUyTnbvmmR8hfqz
	Fbotrj1t+F6TxDPbIem8oEa3UFE1JS+FKMpn3bjbDWSd4msEVjFetjqzzYv2q71Ewwbyl283PKV
	HhouMSg==
X-Received: from pfbgl11.prod.google.com ([2002:a05:6a00:84cb:b0:890:ac21:250c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d91:b0:3e1:180b:402b
 with SMTP id adf61e73a8af0-3e9289ac4bbmr469413637.39.1793310924447; Thu, 29
 Oct 2026 14:55:24 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:55:23 +0000
In-Reply-To: <20261029214219.1035176-3-imv4bel@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029214219.1035176-1-imv4bel@gmail.com> <20261029214219.1035176-3-imv4bel@gmail.com>
Message-ID: <auPAvbIZ8XmOHKaE@google.com>
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 30 Oct 2026 06:42:17 +0900, Hyunwoo Kim wrote:
> Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> of refcount_t"), default builds implemented refcount_inc_not_zero() using
> atomic_add_unless(), which provided full memory ordering on success. The
> commit removed that ordering on weakly ordered architectures, allowing
> accesses after a successful reference acquisition to be reordered before
> it.
> 
> Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> lookups and in inet_twsk_purge(), where the socket is validated again
> after taking a reference.
> 
> bpf_sk_assign() can receive a socket pointer obtained through BTF
> without a reference. Use acquire ordering when it takes its own reference
> for a refcounted socket.
> 
> Use refcount_set_release() when setting refcounts in the SYN cookie,
> TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
> TIME_WAIT smp_wmb(), which separately orders the refcount store before
> ehash publication.
> 
> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !
