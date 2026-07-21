Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737623C8716
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618779; cv=pass; b=KBcYde5itB/fO93dV0qf9okLKIiYqpVm0r5eb9qXjqysFIitrhzB7ppPvJ4NpI421gyg+K7Wx1d0u2KBDGFqz78vaqtYVIrjWphswaQF1WoTrFjYgqBHcz4yejWJuKdbVASVKqN9fgcpRwlhY/MjBXcPIoiqQLZN3g3tPmbEhIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618779; c=relaxed/simple;
	bh=MzE7KXfZZvmR5yOWeMXJywazKBRUNEbDRhgMybpP/NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkNnGL+wE/YQR1gSE7xfVYkVd+lJkuSzrkNYWeKjpduWXOZ4F9iRINXNhvO9RJj26wNS+CQfAAJ92BOc99MUGxRPPSf8pm/E/tNPT3OkpFFk9dYFwCIm6jl0oy13dtocZtfLVkHqVZEb+zriubOsTsDHc6EBwcpgTfTqBFVGvjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzJszTdR; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzJszTdR"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c1372f84dso73259821cf.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784618777; cv=none;
        d=google.com; s=arc-20260327;
        b=eoD0ytveKqJ/Q50lqy1KT7tJ33F+3kQxn2I0QvxJeStD3UI5oVTeyt8OKUcq3nWyhl
         3D0C7U+0rnXobEsGcR4HT9QGJ6sz457c3qtENfUylIn8vchHGLr6hgAO9sHMYcZalen8
         V5x7oD89Gs3agEk+HG7VF8p+5J+g252UPX6Q/edATrNc5S1tdfbXGeFIGc+F7VzOF76k
         SIZ0lW7Cb6Mv49CU6b7x4z7ORmVTvmd3PR9AwYU/V0VG9gN/+Zl/2Pmd3IpjiPwiPLLC
         Re394mprIedd7qnYYMT6n6YByOq88GdaeoqkyzPxcp6kFzmja0s0UGUZa3FxJKxbY9BN
         jx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzE7KXfZZvmR5yOWeMXJywazKBRUNEbDRhgMybpP/NA=;
        fh=PQUlnO6e08hdQHxSV55hN5Ijiu91lqyFrsOWsaQ2Q9I=;
        b=LscPIi9su6JfEvQzEN85IOb95PxhYUGRQTVzuB0fj0PLZmC9GkpHEyP+DvIqNoKRVv
         0izGOoZKtZ8/t6pr8/Fq4jHp+HJSryyQTrLh4VKDJDSR4+Ywe3nEJbiPr5JgkNXjqYrj
         U1jNKF1ybCpbOTnZhP3aJowvQG7bh14psZqx3YJ4+s4iIi+qxlHutdfXwzfd3I2zJIfy
         mxbIh1Uzf8yMCc381OO772S5NYRNzHDaIM4hdr6TiZWQHe7+2GcHW7Pf1b6IdlFp2uYm
         TItWd9Sx7uTEmsMd/BRpE12FxHMBubHZGmmmB+KFCk4l0ili9o52gafGCXK/ow1Z1PCk
         812Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784618777; x=1785223577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MzE7KXfZZvmR5yOWeMXJywazKBRUNEbDRhgMybpP/NA=;
        b=mzJszTdRhJwPqbZ0VylPVx1nBwhJP1SrW2eR0Q75sBz8A5n6aXkP+xH1fFG4xY8yfh
         7Q9J4lZrX4pAtRw8vjdGvs/LQP2Eczw3n52GUWoQ7j1hZMlRWfxtZ7tcN5M5aqlYZ3jP
         XiKQcwhDbSswiJrzjHIdEwTiWRxvcNMAvLH/PJG+1oGktgP56kBuYTAUi1TjPamcAf05
         VPg9m70+FLIdZXd6se9Ye74qv3tt50j2IY/MkfUcez8DgZYHdTHiB30m7mXzTCXbRp+3
         ecJn01+kpgA/dA5rys1OCC5bP6E4ocQDezW2YTgAD7iwd/c9jb9IRgkKWXvpIPheXq7C
         f2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784618777; x=1785223577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzE7KXfZZvmR5yOWeMXJywazKBRUNEbDRhgMybpP/NA=;
        b=FP3HIMg3NO7JMcFHAXtp2nN46q5Am7lvlSQW8XJ0v9Jjml4XDiHgOZXIgYgw5iMXHK
         15pNflwygP3aV0w4fYppC7P1uMt0NnGjFY4VkCOLCyEER9yTvfrh2di3ZCbYj7TWWM9H
         o3Kg9gOluJQhbFKA49tAgh8Hnj0eyc+TH5OXcrlvujO6mLl662desvrjthySyeSi2PKN
         Gn5pdFunpSt2uBEfp0Q3MJF4RcRMV2yZnlZJ4x8kDDoSMhNv4nbsADWhooNKrZ/UhwcZ
         Qw7QDxZot4j/RM3pLHbRXK/k1Cpoh1kTjCqn2Ucz9Huu6MBvEl3vKQYH5CmIc/7Pzqhp
         szVg==
X-Forwarded-Encrypted: i=1; AHgh+RoxYhg3VIGaKymWVu4PwTafz/XAGAbmZSht6YNxPi3mf4PGgipsanGuJ1ZXb5uAreOyud6pHbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFAVJkTfen4NAfoUGSNUil+ajcFLBXnjvXOl41mai/1vfBlLX
	dBew5eOVUO6V+zNewPXJ8SLvdItyPMwk4H/fms5JqUiQaXYgrUkM6VcuOeiqFehp7Io4olTg4QB
	ku8XPuE8AGGvFb9MziG0AQa/R7A6INdqQEiF3fUUX
X-Gm-Gg: AfdE7cnS3bqMjijdO2GNopjlaa2uw8Mq0M1Ve0w/CN+kuX4c5ztzXuq6vamWNNOmAfz
	CZSawniMyEHFebmw7YbHV+ooDy92yjc0Sm77UmnxdeujTBG4W6anzxFsPll69uhJFuV68WG+ZlA
	JjDj+ofoMhPAV9vHFg3Bnpu9z361kH0YV88a2ywWfBB/vRSSZ/u+SQUoX2pqTaALyebRkBX2Pjr
	JfGgQFBQhvGnslMo5Z90SUsMKZ7NZdssTxCmX3DXgZQv+Uw/hkNN/ld/21F1V9HTuV2AVHQynSK
	Vj9dNS3ZdVreSaJN+fbXTgcs2m553JUnkXTePLShJAPoROWX8eZuuTMFVchDTPDgzLFg1Uuaoik
	tBui3EfN6
X-Received: by 2002:a05:622a:15d3:b0:51e:f4df:2898 with SMTP id
 d75a77b69052e-5213d4b8bcamr159959241cf.72.1784618776678; Tue, 21 Jul 2026
 00:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721015824.45829-1-kylebot@openai.com>
In-Reply-To: <20260721015824.45829-1-kylebot@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Jul 2026 09:26:05 +0200
X-Gm-Features: AUfX_mxqIm2PCbPMZavwj8QfyZoT8HMPVoojJD_2vUX--xC0B9_hkVqsDzEHamk
Message-ID: <CANn89i+YuuBJ1J8CGD0Eo3JKeNjEd=5tT-3h=6stE5QoYczYXw@mail.gmail.com>
Subject: Re: [PATCH net] net/packet: defer vmalloc TX_RING free until skbs finish
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:58=E2=80=AFAM Kyle Zeng <kylebot@openai.com> wrot=
e:
>
> AF_PACKET TX_RING skbs keep a raw pointer to their ring frame. The skb
> page references preserve page-backed ring blocks after pg_vec is freed,
> but they do not preserve a vmalloc mapping.
>
> tpacket_destruct_skb() currently drops the pending reference before
> writing the timestamp and TP_STATUS_AVAILABLE to the frame. Move the
> decrement after those stores. The smp_wmb() in __packet_set_status()
> orders the frame stores before the decrement.
>
> On socket close, scan every pg_vec entry because allocation can produce
> a mixture of page-backed and vmalloc-backed blocks. If any block is
> vmalloc-backed and TX skbs remain pending, defer the whole vector to
> system_long_wq.
>
> After pg_vec is detached, a late destructor can skip the pending
> decrement. Use socket write-memory accounting as the deferred lifetime
> gate instead: an skb remains charged through its final sock_wfree(),
> after all ring-frame accesses. The delayed work retains a socket
> reference and reschedules itself until no TX skbs remain. Fall back to
> a synchronous wait if the work allocation fails.
>
> Move pending_refcnt release to packet_sock_destruct() so late skb
> destructors and deferred cleanup can safely use it after
> packet_release(). Page-backed teardown remains synchronous, and no lock
> is added to the TX completion hot path.
>
> Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> Cc: stable@vger.kernel.org
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---

Hi Kyle,

Rather than doing kmalloc() inside free_pg_vec() during socket teardown/clo=
se,
would it be better to pre-allocate the deferred work storage at ring setup
time (in alloc_pg_vec / packet_set_ring)?

Pre-allocating at ring setup has a few advantages:

1) If allocation fails, setsockopt(PACKET_TX_RING) fails early with -ENOMEM=
,
avoiding allocation failures during socket close/teardown.

2) Teardown becomes deterministic: free_pg_vec() is guaranteed to have
the storage available to queue work.

3) We can drop the extra fallback logic (packet_wait_for_tx_skbs(),
po->skb_completion, and the 1-jiffy fallback polling loop).

You could embed a struct delayed_work (or a header struct) into the allocat=
ion
returned by alloc_pg_vec().

Thanks,
