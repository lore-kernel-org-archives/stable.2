Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBE1F3B85
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809838; cv=none; b=ZD2cAHRs5QnGEoBbW9a9Na9Ea60Zcqm1w7XRG7oOIpFhmHhj4TSmtVK6EAWGUsMu1fE9ck5QmEtgOXbx8OVCM730pkQzhYR/dMe2OhkraFLtWpJ0F6JQezeJUaXQ44iUFHHrxF23sS+rCUEknf3kx9/aJaFq+qsE6lUEw1juJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809838; c=relaxed/simple;
	bh=K3kmaFsARFB0MVXy8SS5byiGEIlyRwnovf/RCFlAoQ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZrRhYp3+UihyFx4EHmoEppkf5jKrFaxkWa919Fj1+Beidd7OIKkfFeJ14V0loXuDLQnnjTURfBI8/5pfd4o/FSOmnPI8ZBHvKEOu477Z8tJ9pCw5ZpARqBYJUJgkMYqWIbe3rsl8RdG4v7GnjJ8R5iNUi8bcUoSAQoHNJco+cGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Qmm9Csst; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Qmm9Csst"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb545db3afso2695866a34.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785809835; x=1786414635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qofCxvfgHqvdmuJYuBV7qbAn9jPgnX3RDR7CsSpoFqg=;
        b=Qmm9Csstr7raRt2lNVDH/hya8p6Mv4ARGgO6p2pVnZrA4oHAY9FlFU+B/YCAGbOnLj
         VEkDCNrHgsigs4RGmry5qWro65AjCPIJkDGexn45+NoVhe4sGaR+yzbK3LyX0z0Vgptt
         bIyhHoGI0oZTXW1yB1U7AjUGfWg7TJKBpr3DVrxORa33GhfYZVYWR6kIvV2qQAZll6fZ
         Y9h6IU+uwRcd2kJEs21+cR7j+84ot4nUyKdebx19hU1ZaIUiZb87RABISbAqkf2v2LRj
         I7GNUxcZruvKPAn+1FNgsHPOB67SOsyVHQFzf1Y1yhu5zLbGfDrpc6rTb6XBRl6goU09
         ZOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785809835; x=1786414635;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qofCxvfgHqvdmuJYuBV7qbAn9jPgnX3RDR7CsSpoFqg=;
        b=N1vFEjb2FxbgFX+s+MA6rV8Yr7WmyGWVgpjvYcHPH0aStOGKBeinUtrC7Lung3GTUf
         p9DZy+dpSLFQ+qCnx96kddYTbTmeFwb4TT0IQksYTVbD7AujZBr8nk1gYt5nJ7tpw1fJ
         NGWUUmuWkQEZ8epgJTcsUyzISfgCwmvETXbOzqpkaFNkU28+fDP8Uw6Y5wIxT+EUP8DF
         W4ylAPudaGfDtClqGFPWXyqzkiBT1OZg6OmCAklnxbyXbzGEaGnWmnrA5nDlLOnMXRzH
         vFJRB9LxXcqZDLmMO9SnKKZKm2I6pRcNFYNOFrI/JBWOjCYVa50sSDoKhfWhq1MAfJ58
         BVlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq58Znnk/oKcuoxnFy5+SKeAJDsUkM9Mo7mxSjEXq2fNd/2EzKdopK1DsCEUkhFt2y1mRFRJsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9c2JcTpTkm7cawMPD0Z4MFuZTORiubmNrlbH9gU7kEYNsNYMJ
	vVbNTU165z4vkmBT0gCWrbXeNYVjyjdWvsBsSOv4P1MZpnPriI8Jz+/gChAhtXC6nrs=
X-Gm-Gg: AR+sD13CEBaDCRWx+FJ/43lIFsUcaRf+HBnRmB9e/PjbhGTKdObEaQmd7ejg7S+T3oz
	Ox4aUhMdiRwx8czTJ3uKXbpMBKRMB1P3IxBEgdONXHyVXmO9yXSKApVrzTH8qC8VvMCJlAO/DMA
	7zK6tqs0eYiWIBgPSGXf38Wt0/3lIdNq2kmMlav6vs968bpDvkaoE4Hk//2ymyIokAC2R31ALGv
	mz1kt5E2ttNgHoOnv9ghIWysUtUj7r/NahJBpx+KNdUUFt6XHa1VrK04ckF8RC1A6Lr7rr1/okn
	3CROq2LhDMGv4rmqSLbIIUsdIafuU1dclsQHbvtDv6m35S/diibN+84uPj8QQ9lI2Hk08Njqnuw
	ibkkcc2MAw7PW+EKNfLr2eaFSv7r5IokeFo3hmdLRmV+IXNUyfdef3orrrNJzvEjW/X8g0IqhUk
	5apOQrpLt8Ue2Xp85G1mto1gZRnzUStflV9y58jx0i4H0Fm+icsfpKVIGrlgbjNVI4atCQ4moLu
	0L8IualqQzNi3cLuI9Y5Dm7tGAiIAY0rLpSjf0zZnSBigCiBjg5
X-Received: by 2002:a05:6830:4992:b0:7eb:c8ed:71d5 with SMTP id 46e09a7af769-7f196ef1d76mr22155527a34.14.1785809835387;
        Mon, 03 Aug 2026 19:17:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a55asm8914812a34.13.2026.08.03.19.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:17:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Woraphat Khiaodaeng <worapat.kd2@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260802073518.419-1-worapat.kd2@gmail.com>
References: <20260802073518.419-1-worapat.kd2@gmail.com>
Subject: Re: [PATCH] io_uring/cmd: fix iovec leak when the async cmd is not
 recycled
Message-Id: <178580983389.518281.10453902447939031176.b4-ty@b4>
Date: Mon, 03 Aug 2026 20:17:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 02 Aug 2026 14:35:18 +0700, Woraphat Khiaodaeng wrote:
> An io_async_cmd carries an iovec array in ->vec.iovec, allocated when the
> vec has to grow and kept across recycling through ctx->cmd_cache.  On two
> paths nothing frees it and io_clean_op()'s kfree(req->async_data) drops
> the io_async_cmd without it.
> 
> io_req_uring_cleanup() clears the async data flags only when
> io_alloc_cache_put() succeeds, and the cache holds IO_ALLOC_CACHE_MAX ==
> 128 entries, so once it is full the put fails and the vec is left behind.
> An NVMe passthrough workload gets there without doing anything unusual:
> nvme_uring_cmd_io() returns -EIOCBQUEUED, so the io_async_cmd stays
> attached for the lifetime of the command and the live object count tracks
> the queue depth.  Above 128 the puts start failing.
> 
> [...]

Applied, thanks!

[1/1] io_uring/cmd: fix iovec leak when the async cmd is not recycled
      commit: bb34ae5da3365699d53a756f4c96b6ea9f8ba0c1

Best regards,
-- 
Jens Axboe



