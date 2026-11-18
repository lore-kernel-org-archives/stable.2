Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968106;
	b=PjPA62612AwdCGAr9c387wGtQA8KwX88rOEugYELaqp3Jm0oY1Oa1DeUXt3PeRKYzUvV
	 qpztPSzRn9cL3uLGTE+I3RYud/7do1sFO6qFz7OlL1gpYNhppunV46jK0BWY26v93iVI5
	 9p+Z498LLeCq7LszWOyAcmg9nrL5gdri9p7nwvXvQNy0j5rDtVKLpr6GOYrC3D8FAVzVm
	 YRnTLQHu4aKPdNomBW6saLNGEFU4iLq67JMqCaqsZfTLyYm+s0hq43aVSqfsNm6rSLp7+
	 J+ig3cnCazYvneDcUSeZxfsS6WZ+MKi0uLxFV+Hk8IDVUvnLWsTmn7vP7lgLiiOlZsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Hek+ZE9sdaq9Ge80vFXi/7LSVSangUgBYjZCzNy2wbw=;
	b=5GzshS7VNYLdelUTOapMpT1S+5ZXIr1twxr7YL9ZwvyLXEfcYnpf7JaI9jMpZpLaKGPK
	 sPCZSWZxrQeCDCMm22mx4qqNBioggpuGuwz3bZRdfjsIlLCMeF+6NHqgJ8sWhU2aw+FQN
	 cYG3k5S4fTa9PiIYWGvvnKNiERD17Oni12iz/Kn2kiZVU0juA29z+/IN2OYXXFZFb3XOx
	 2sdrQBFM39gUzSovpXJLz827DdoZO8OsFqaxusX9kcwzmOxSG/XSUXzfI3BR1W4FpaDNx
	 iTznMFDI+UHsyOT7RmITN3sbztbs8Gqwe0f0o+OdVwGDWYwVXj0LbXjtRVv9BhPM0sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hcNs234f;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B4606A330
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 936B4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hcNs234f
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed08904845so5684625ad.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794968105; x=1795572905; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hek+ZE9sdaq9Ge80vFXi/7LSVSangUgBYjZCzNy2wbw=;
        b=hcNs234fv2gBaZqCmj9VF5K0kL1XLIKNqqfa9Ib7n00vrxU4xjZB89GqYUPwRoKKPR
         HQZiz/q+uS/wdr9I4W56QJaECk5u/vHYslwah52MEuCs+Feoq/mLB8AknBzRQQxDKsvj
         LdTEIlPJ+YCz6rvXc+WGq3Bqt/lgn0RFe7LNZl9RecSftLv/8AtzOPEMo1JPSB1vzdw/
         y0iabgq2OoPSmtNqEOqU8n0XEcAykRFq7aEmPU0YVgKvYOIXKKfOj4PEJ7/TivNFqVdF
         L54ZIBHKMZHi9Y6jlofa+en7kQzLsCNXgGfDGyW3raz0HrVuhhEvsEACUu4JNU60TyzA
         COGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794968105; x=1795572905;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hek+ZE9sdaq9Ge80vFXi/7LSVSangUgBYjZCzNy2wbw=;
        b=x5cncAinDlgXsyKPRkfVZnfRUSF4+Pyq3fjETnPL2FnYmQb1YFLP87BQIK7k14Z454
         onoN/WDjleWwK5pjwRPiE/IK2PLDnNh4a8uVAzd3Rbc6T4FmS2lHd8HegdIbHBXGWZ7x
         oTNcYAEaXZW6d5sTGd+ONwFU1pw+BTndISu/vfLgWM2eWO9z1xQ5AUZEzVCIHvPAZ7k6
         KsCOc6W8AN81Zhz069Sx8kkE0W10Rayix3R0rQ6teGQF6MusUv65OryalT9aRSeTEjuy
         qcfkM8oo+husm/6xIm4QuPq19BkuSLib/J8ZCCnIMzfjwGjy9FrzxB3FLcMI3bCwxM4K
         U2tQ==
X-Forwarded-Encrypted: i=1; AL+hErGbIt9rmOCK5hFHcJjkRmoNN6nsh2KbL9vU2NC0LwVV3LfpmFotdamxKKSdHTwvS0ng9yjs1Ew=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cBfM8bV6RNlXD6m44kClL8bzu6D4lcl3tTlqHkkxULXl+5AI5
	ssIqaEvZhXJ4qIDDbcj/qU7ggbYVC2McblRNcDbfHSrs0vUd8Y348HKSwLlJzVDOQLIJ5UHTkmg
	nO+EIMg==
X-Received: from plhq17.prod.google.com ([2002:a17:903:11d1:b0:2eb:4a7:306e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:90f:b0:2e9:8202:509c
 with SMTP id d9443c01a7336-2eff70fd303mr11865625ad.7.1794968104719; Tue, 17
 Nov 2026 18:15:04 -0800 (PST)
Date: Wed, 18 Nov 2026 02:15:04 +0000
In-Reply-To: <20261117-work-net-peerpidfd_short_optlen-v1-1-a93f56288501@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
 <20261117-work-net-peerpidfd_short_optlen-v1-1-a93f56288501@kernel.org>
Message-ID: <av0KF1liMktF5Hg-@google.com>
Subject: Re: [PATCH net 1/2] net: don't leak pidfds through a short
 SO_PEERPIDFD optlen
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, 17 Nov 2026 16:25:30 +0100, Christian Brauner wrote:
> sk_getsockopt_peerpidfd() caps the caller's optlen at sizeof(int) but
> never checks that it is at least that large. sk_getsockopt() only
> rejects a negative optlen. So with an optlen of 0 to 3 we still
> allocate a pidfd via pidfd_prepare(), copy zero to three bytes of the
> fd number to userspace, write the short optlen back and then
> fd_install() the pidfd anyway.
> 
> getsockopt() reports success but the caller only got part of the fd
> number or none of it at all. It has no sane way to find out which fd it
> has to close and the pidfd stays in its file descriptor table until the
> process exits. Calling it in a loop fills up the table.
> 
> scm_pidfd_recv() deals with the same problem for SCM_PIDFD. Since
> put_cmsg() doesn't fail on truncation it checks the size of the control
> buffer itself and sets MSG_CTRUNC before it allocates a pidfd.
> 
> There's no point in handing out part of a file descriptor number. So
> fail with EINVAL if optlen is smaller than sizeof(int) before we
> prepare a pidfd. Since commit e10899b2a098 ("net: add
> SO_PEERPIDFD_THREAD to get a thread-specific pidfd") SO_PEERPIDFD and
> SO_PEERPIDFD_THREAD share the helper and the latter inherited the bug,
> so this fixes both.
> 
> Fixes: 7b26952a91cf ("net: core: add getsockopt SO_PEERPIDFD")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-205984@kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
