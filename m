Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795286354;
	b=jIry/uY4JUa+vLCsA8K57fdB1+/t/qv4JzZ2rYGOdTc02BcViUGG1CJY5ppVkmb/Op/O
	 7Cy3vaz1pzUs7jaXh6T4IzZRp8FtAkcTz8aiQaH8ycBnfYxhmap5uwgINAbHA0Nx7v7v0
	 MZUrvGHpCLp2/T8TNppnydsBSRb+kGAZCctMLq5s3kxXFQRNUEVJFuunX0/k7jKwSSAru
	 d7R0WA71oZj7D9k7sJFV0T5MESyjUxXltjJJh79BStLzAzjmYOJVFx8upopBaqpbSB2Jh
	 J3H1+sqvsSiiKLuhaWWWiDb0KK2jM1Zh6ok2kOUAQWCWagOkCJOPzG+s3mYuHc8JoJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795286354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=B+C2/33K4kduexdkENaQSrBZ5xc/12xNlj0pd3fSUlo=;
	b=SH1elCzznEBMvDIR9ITloSG0dDlDz5QQABPv7us3HIn76Qum1E2hyPBkHFMC5IxbjqHF
	 ckw6xseJnI+Tzn/kYTG3Goi01t/Mu1e4AzJLnHPl/3sKZK2Hj53eKNftB7VtVJdNlLJRP
	 aJukrPNpDKQfAcmz7GgDltHTdbk0KvVV+NXmj5vsjS9W3R65gUdcziYTE2TFntwofGtNI
	 lI040zUf7mMntB6uNLjnSDWTsgBNRikM0358mcgmQ3pmXGBtsgFakCnN6QZrNfokUh2gY
	 Ht+vkdOjYZQTGkXyeRUQOzKDbk+A3uaP0WAk5olDo/uRkjQadzRScz6rJCshxYx1G9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N4LRxPnN;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEC606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 18:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FEEC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N4LRxPnN
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b691cf0eeaso2464480b3a.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795286353; x=1795891153; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+C2/33K4kduexdkENaQSrBZ5xc/12xNlj0pd3fSUlo=;
        b=N4LRxPnNO1YjitxvDLP5/5kIqInUyAb2PxwB47pUzyklLYXgDRLm+hBGOagI9wIIHu
         zqGxOyfeJMlgyeICmsIL5liJN+MwmXywg7S1NQL94dcQresjALSGWYMSxAB+agNmQic+
         CIG5lRe9aZBEsF6MZKhIi22V+Bd78oiJBpcwsVJLmRbfv1ulzKuLuen4EPSlL9XpZz8E
         aw9FldXk7Su1f172F9G+Lz6zw4K7JFXDMOpv6euElqN69npigs8dtlapsNhkItca4PtU
         Yot9+fi3GxfeKm6XTWv4sK6rrRHpHhcvMEEa8na6M8UbGqns0ypFEnf30gskc6/yTBxG
         IqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795286353; x=1795891153;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+C2/33K4kduexdkENaQSrBZ5xc/12xNlj0pd3fSUlo=;
        b=Jbqza9VFfk+0zVi9WFxLlkW0NLABaLxCpfqeEM7TZSlrY7cZz3cO0ppZjEcpd7Fhw+
         baS5ISiy9Y07vPhVTX7zlEb27hQbLMA1hZtxGGTYBbngX0DBcWUOKMRcK5E1ZsyaP45t
         GQr4Ozmenxj6W8B/DNwtTNTsgSlwEZIJXBfGyEKFfGJ2MC2XI+ZZ1NvlvV62kZfNp8Du
         ipPougQvVihkzTXw70gcr+9XNNsPEHn4UjYe/UzfgwBVg3HbZc/+475s68oUWj6k+tJd
         dhCT/2gml0w+++6HQJQPRjmWCX+YgXOD6Dtjw6Ta9orhYFWzPmXN0Hul1M1FeuITZopv
         kJpQ==
X-Forwarded-Encrypted: i=1; AL+hErEgCwwbzxLWjj4dzXML0fiu1wV7q5zhuwaSRZj2P7mDibedDFKECJlmgu8TD4HKMyu7f9/T+8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8t1/fK5d/QBV4+xi1FidLfbIzg5PcRWFvrbmS+LEKSmE15aCHU
	djUjB/tCPoV6SK8ai+fZYa/zFQkOgaP5GY2zZhq1I7xCQYXpOOgoVydwjcchtO1Q92mYgwKrAL0
	m1p0aCg==
X-Received: from pfdb13.prod.google.com ([2002:a05:6a00:94ed:b0:89f:41ff:99c0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c3:b0:89e:779b:d0f
 with SMTP id d2e1a72fcca58-8c87ce3165emr7009702b3a.37.1795286353159; Sat, 21
 Nov 2026 10:39:13 -0800 (PST)
Date: Sat, 21 Nov 2026 18:39:12 +0000
In-Reply-To: <20261118101752.1989502-1-bsdhenrymartin@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118101752.1989502-1-bsdhenrymartin@gmail.com>
Message-ID: <awHkoGTQ71NbCeU0@google.com>
Subject: Re: [PATCH net] net: initialize sk_peer_lock in cloned sockets
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, 18 Nov 2026 18:17:52 +0800, Henry Martin wrote:
> sock_copy() clones a struct sock with two memcpys that both include
> sk_peer_lock.  sk_clone() re-initializes sk_lock, but nothing resets
> sk_peer_lock, so a clone created while the parent's sk_peer_lock is held
> inherits the lock in the locked state.
> 
> The first getsockopt(SO_PEERCRED) on such a child spins forever in
> queued_spin_lock_slowpath().  spin_lock() disables preemption, so the
> task never schedules and its CPU stops reporting quiescent states; RCU
> grace periods then stop and callers of synchronize_rcu(), such as
> expand_files() from accept(), hang.
> 
> Initialize sk_peer_lock explicitly for the clone.
> 
> This issue was discovered by Tencent CodeBuddy Security.
> 
> Fixes: 35306eb23814 ("af_unix: fix races in sk_peer_pid and sk_peer_cred accesses")
> Cc: stable@vger.kernel.org
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

As Eric mentioned in v1, restricting SO_PEERCRED etc to AF_UNIX
and AF_BLUETOOTH makes more sense.
