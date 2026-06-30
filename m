Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA51DDC37
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850542; cv=none; b=mhcSzYCb5tcoXoQr83rJ66CKbQIGu3JsM1dfHCI9zbc3cHVW5ucqcl7vWHV8xDypxyCSwMoZ822nupE9QT8qvKzc5gwU0Xda/n2zW3Q0Rj/Bkrnbn1VFYM4PTU4vGfXq+Mf6MyT8SBi94WXFP8gzlUeqRC7AArPmPvT78VtZ/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850542; c=relaxed/simple;
	bh=KIFyvcUp0DrVIt8fHT9eaTmd9j+JW0nG/kc0JEntHo0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=HYoH5DZhMM7W3AyVvR4Twox4QYZvGhIoE8oJ/ZkM4OjQPd1dJUj+KSIqKB4NqzhaWVEYR5oeuqnLitVb/ltvbBZVKSJZcZqhZPjLYVTIOFkzcHDMcJsqDf5Slqmw62f9zGkevbbLl0uPx0dzQUoxDpCYLqD0s2laTGXepE1frqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=H5LecyNZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="H5LecyNZ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51a1fe8f578so51277401cf.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782850540; x=1783455340; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFbHVAQO3lUQEfR1Rl9bV17oIFy3lRBFLhFrds1anbs=;
        b=H5LecyNZ6LGZ2KRWNnVCeCb5OtKt3yilbGl1jWJTb0+APodq9+4kjVxAEcIJ76Ll7l
         rE8QY+P8UbdtIAosO/kLyiV+VqwNkNs3NF0O52nrLolnLLq9k/i+6Fb//6eWIkUgN6FN
         PFVPmRuBFdMKQQYddLfTzPwxHlfpcnF+WGcrfEiQnjMtAf3JjPVy29KsB+y3qxRUmrXE
         yhosmBf7njB3Qg/zrVWEN00Qj7D3WPxHGafGpmUEvh7pShCm8YjzAhoDB+RdP6GV7SJh
         6nEDKDxuYZCEreZtl10qy+dNHZZ0GFRSBzCHdE/JdjlJ+YQsJF9DHCSgEuo5xxNucLMg
         tHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782850540; x=1783455340;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFbHVAQO3lUQEfR1Rl9bV17oIFy3lRBFLhFrds1anbs=;
        b=YxVziODjfBf4VjDi5iUf2TIWeDbBL00UtSjbezi3uLEjPEHL3JbXEQuiBbbpXPvd+M
         WNBZ95YyVri2B59ISF9tGRra9h5FbvhAARAkv6ytlcBI/io0Wft63jLLvVMhnC0w7od3
         hArL6SkT4zAcZ25bmSZYC0LEyhXg7Ic1IqJXtwtIySbVL74qh4dzVDPMyr8xVozxzW7e
         ZQDWtj+oah+b0+tMjsrElGtAtdgC4hxR3EpdDhtO9e48pCn7KRuQpJSiQj1D25MpylnU
         lDtWiAwGDESaOoHQXvoqPgrCLluKnFYWx0MlKMbTQrSupPrTNq2w2DxJQXxUYHFhTiKw
         wtTg==
X-Forwarded-Encrypted: i=1; AFNElJ+FnzJs4HOeUatC/fjDHdUQTudKUSwIHhVkqmoO549uqrZgA/C6U33CeILfOHjxAD/2rgmJ078=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAHbpnjNgCcZi3WpZE7UsD72j6HdsVrSQGoRWipGPy7oGZ4jd
	f+0c9XRWWXqCfd0QX4lPEsGUiG7cS5vWD4Lp/00dsWFdxZNxUnhUggoOdRt/BItdxQ==
X-Gm-Gg: AfdE7ckRyBR6W7S+Qh2hxOmF1HxDqXFtM5/fY9F2Hq5L36NBda47it8Fgr1aduqpX43
	zcyakQy6ZJ945wdQGghAzHjt4MMCK03y2stdtWGSrpLiULAsoGECJVtQhkf/ifpLwvXJkCm4HpU
	A94FmGWoJldDkJJbx3jLMTJ9F2VHm6i1vWFKDRJVhfksObJGiC2ctxHfH4o4EGogJW4riW2QpmG
	afTLruC/QPjzGl4/vpSzlyyAdnTaOfFEFggZqYixpf4mFAM0uB4AMyIW5fWFL7/PUXDIhFZRsTO
	PkZKhEUmSjEMcBNyEebNYiFIRssmzlJ7piWAVElxNrZU4WIA0oBoN+oW+JWnaG5YL6421TZihMr
	smfevvRVjVPEczjFWa65cP2B9dwXGFzSR/XWYylm1DMPZYHWpfKUgluhYocpiQp6buSi3rJwJA2
	SB+qm4zTm0wryonBjdyJ0e6Pz9qDNeNmugLbbE0AwV0ly6x7KAIwZKwizMgg==
X-Received: by 2002:ac8:7d52:0:b0:51a:8c97:9375 with SMTP id d75a77b69052e-51c108d823bmr65449501cf.61.1782850540414;
        Tue, 30 Jun 2026 13:15:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a727429fsm32068956d6.37.2026.06.30.13.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:15:39 -0700 (PDT)
Date: Tue, 30 Jun 2026 16:15:38 -0400
Message-ID: <790e5ee50f15c85b8b1e36c85f0e7f2f@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260630_1523/pstg-lib:20260630_1303/pstg-pwork:20260630_1523
From: Paul Moore <paul@paul-moore.com>
To: Chi Wang <wangchi@kylinos.cn>, Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ricardo Robaina <rrobaina@redhat.com>, Chi Wang <wangchi@kylinos.cn>
Subject: Re: [PATCH v2] audit: Fix data races of skb_queue_len() readers on  audit_queue
References: <20260619074244.377226-1-wangchi@kylinos.cn>
In-Reply-To: <20260619074244.377226-1-wangchi@kylinos.cn>

On Jun 19, 2026 Chi Wang <wangchi@kylinos.cn> wrote:
> 
> Multiple readers access audit_queue.qlen via skb_queue_len() without
> holding the queue lock or using READ_ONCE(), while kauditd writes to
> this field via the skb_dequeue() → __skb_unlink() path with WRITE_ONCE()
> protected by a spinlock. This constitutes data races.
> 
> All affected skb_queue_len(&audit_queue) call sites:
>   - kauditd_thread() wait_event_freezable() condition
>   - audit_receive_msg() AUDIT_GET handler (s.backlog assignment)
>   - audit_receive() backlog check
>   - audit_log_start() backlog check and pr_warn()
> 
> KCSAN reports the following conflicting access pattern (one example):
> ==================================================================
> BUG: KCSAN: data-race in audit_log_start / skb_dequeue
> 
> write (marked) to 0xffffffff8512ee20 of 4 bytes by task 661 on cpu 57:
>  skb_dequeue+0x70/0xf0
>  kauditd_send_queue+0x71/0x220
>  kauditd_thread+0x1cb/0x430
>  kthread+0x1c2/0x210
>  ret_from_fork+0x162/0x1a0
>  ret_from_fork_asm+0x1a/0x30
> 
> read to 0xffffffff8512ee20 of 4 bytes by task 36586 on cpu 1:
>  audit_log_start+0x2a0/0x6b0
>  audit_core_dumps+0x64/0xa0
>  do_coredump+0x14b/0x1260
>  get_signal+0xeb2/0xf70
>  arch_do_signal_or_restart+0x41/0x170
>  exit_to_user_mode_loop+0xa2/0x1c0
>  do_syscall_64+0x1a3/0x1c0
>  entry_SYSCALL_64_after_hwframe+0x76/0xe0
> 
> value changed: 0x00000001 -> 0x00000000
> ==================================================================
> 
> Resolve the race by switching to lockless helper skb_queue_len_lockless(),
> which internally uses READ_ONCE() and properly pairs with the WRITE_ONCE()
> write accesses already present on the writer side.
> 
> Fixes: 3197542482df ("audit: rework audit_log_start()")
> Signed-off-by: Chi Wang <wangchi@kylinos.cn>
> Cc: stable@vger.kernel.org
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/audit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Merged into stable-7.2, thanks.

--
paul-moore.com
