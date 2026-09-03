Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC333EFFD2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428158; cv=none; b=u2iwmeqJ8KGWtBEeaXN3uI12ui2NxrSA52LCG0nusn6uNCTZiCfBNUYD2ZdcTYynYuDW4J4teLrLUX9IbteJCMD+WOlFnIBBL5vGkski8Ri9tWlziQjaehB/iiEzsuLHkW0tC8iPdczLxYRkL/I4O9fmF7/uALJ2JJyknlTyevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428158; c=relaxed/simple;
	bh=6dxSwnVMhBQ6QrxcI00aXBMeMsbJMY0TD4I+y+LKu/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvxbFve+6fqdF4q9fvRarNmWWWn+3aH2T7poxh1Vpmx70rRYbvzHFtL5h19lERLPviRjEHvaUED0TBS+348P2c2Jaau8a1wlKghJ2XlKDZ5blDtNqHYkA2UyoXgciXIQbwF2Vl5E58l+uB77TzJaLGhBOHhE3atLhCt87lzzpP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exUGNFig; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exUGNFig"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so15173405e9.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788428154; x=1789032954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SA0YMkKZrk5pHRtNM6ynurrEGkiVyx5dwe1u190lCDo=;
        b=exUGNFigLqG7qUWyYpfXvNYjTx/7yDbbBtTm/KWAsQhVB4CYbGOUHDf8wYBy6sCAhw
         1FsCyDToJJWi/T0jsZNlAx3vvXNG7Umlr7QMUFHTTI3mOo8KAeea+M6yYNAM6351/4zc
         aqC0Qfekez5FKPZGgqI15mgdQuvmbNhWV3abWKd2ZaJTjJbU/+aoUq9BRIP77f9llJA3
         luOztfFpL9WqdtmXjpeJdq/oUTTTMYS3iZMXq1YK0RjtJO+IwREWyyWNTat31yeU2+mw
         e5pYvFaMROzMXnmWB7CYfHoKJ9+GwdyjNB2t1tLB1Q/1KXNjvOTRtx85yPKJcUSLKF3w
         HdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428154; x=1789032954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SA0YMkKZrk5pHRtNM6ynurrEGkiVyx5dwe1u190lCDo=;
        b=SqUunvBT0Pj+Pvsxc+mlfo82vcvQ3+uqtJmB1E2oa3//8pS+bZm7QU/PwS5QFgXuwC
         w8jxX+VnjPDEOcJxRHL84gtFGY2yNC/W7nWKIwKA95+lhth9EK9/AFCfzdFeL0vgFW8T
         srcvExIJfD+0WZFp5FlOLvgcPuPbDtEN9Wz05/a2HEtX5fZ1z7naxxDtxE5CsHyd4cDt
         H2DZFkY6Q6xMw7NqaKbipsRr+dMD3js0pIpBWg3mOTtOkDbvaNmUzUJUS6OkgFwNpIM1
         WOyQ2s4kj6PoB7FbM2NHmxgdu5jP3+zlR8e+1nWorsXYt6xMw07a9cTAAXULgQnKUNX9
         21Vw==
X-Gm-Message-State: AFuF++lW0xUfrpbrB8w/dCX7Eo+jovU8FlLeE1GN33Cj25eTb0LSIIgs
	+SKvPFfoWBbwufG41UOPazzKvADzksF6W498G779tMDjEjMQD/gL1r5oVDyYtlKPeg==
X-Gm-Gg: AYBFou3dMCgyyE5MEyxvru+4H8nt37lyf5WwYFG+lqUYvCEYsfiXz9c07XZeRb6koLo
	f0Nbv2aqqOF4Xn0HLtjGluyd0Sel+XesfkEfa5RO5B9tnJTXuO2y9iT3i8ek/zBDoD0R4SgVm04
	MG3i9vfOBiCf42QC+RxduiB+K9Jcfuof0NmuiELPg6qksGggQ67oB7fAuKm28/nj7ncPOH8m/Ax
	uTPXWq4xTUlRMLoWA6WI9FTqLtkXZMu19v8phn5SNda9/2fg9rDTMqD29bWJtFSaqqmM4DtMFUM
	Ihu8RKrRiCYvtTZoT5TG3P9gNHFuoYLFg9lg4pFewBilMBjtiwK0OG6eWbgvvcWUnJbavKkwE0N
	VQGfKfkwAfjb2sY8ZXLHHclpcbZEqrsGavdwOkDMR74kgzKVb7GVPna0n5EJFdoBlqudOlO1Ua/
	9fxpoTY1H8yHD6Cnfn9oFMXBf4UeHurM2DX71zBdNfkdd7XLeZkCa5r6c1LyFxuawK0BHmcaWqm
	c5Fu7tybGuGL6mVp5J8BLMas+3pNofY
X-Received: by 2002:a05:600c:4ed0:b0:499:726a:a017 with SMTP id 5b1f17b1804b1-49ce57ec163mr200889865e9.1.1788428153444;
        Thu, 03 Sep 2026 02:35:53 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm55247145e9.15.2026.09.03.02.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:35:52 -0700 (PDT)
Date: Thu, 3 Sep 2026 10:35:49 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <apk_dQ4Q6msdw_Ub@google.com>
References: <20260901123444.GA1350131@google.com>
 <20260902-daily-reply-0006-tracing-subbuf-resize-7-2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-daily-reply-0006-tracing-subbuf-resize-7-2@kernel.org>

On Wed, Sep 02, 2026 at 06:14:05PM -0400, Sasha Levin wrote:
> > Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> > uninitialized memory to userspace due to stale size values.
> >
> > Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> >
> > Not sure if this is the latest version or not?
> >
> > I see review comments, but no v6.  Anyway, no matter, it'll do.
> 
> Queued for 7.2, thanks.
> 
> -- 
> Thanks,
> Sasha

This isn't the last version of this patch, I have just posted a v9 [1] and
Steven hasn't reviewed it yet.

[1] https://lore.kernel.org/all/20260901155445.1475405-3-vdonnefort@google.com/

-- 
Vincent
