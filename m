Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669A73ACF1D
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081501; cv=none; b=i5aPCHcIOeI1y3FP0r65yRQe0QfR2M4qUhx2fdncmDNIC2XusTmVX9JtYoWtasIWioyJHfHihEf3XkA3eAHsjY5Yq2y8ajdhl2QGoIRWzWMJ4NL/RFGw/hcAUTjyjY9AKiCoxUT7910EnEAIFBq4UwrQ5+203KBMx8CokVHD0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081501; c=relaxed/simple;
	bh=IY1LKt+8Q8+kPGo1Ko3vVJrVGRpB3s0k4zLsCvAhxVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwP0+zPEszdNUzl8yttGe/18KIRkMTpylD5qoo26fL01TQiP2Aht+F6tnna8FP5Hz0MUsJCAAFwz7w0ZbOXKgHq0CVepxEa8DmEQ3l5AaRl1EuKCS/b7+bzTbu9nvAdjccKK99lhT9Z2Xg55GZ3FHKJjksaSOWF60bhJiz+QZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R6Jjbaf0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R6Jjbaf0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so4412811a91.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781081499; x=1781686299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZTUwD5334qhMn45Nv6zFjWXwDHnBznaVHmh9fHzOkw=;
        b=R6Jjbaf0vY+5OW3s5bM/pbNmYWvSEwKqfW6i95X9d7ynzhqzgPnoo2XEOUvdSdIX12
         sjphriV99Kt78yH7VRjIg2+lE0BRthJyrmApA/m/t3o0VVOOT6mJloFWCcM/hXXMRjWC
         skosHBFCaSFOCAuKansBON7j133zfEFtGurh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081499; x=1781686299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZTUwD5334qhMn45Nv6zFjWXwDHnBznaVHmh9fHzOkw=;
        b=EM79IQeYAohW0GElbCP9MukeOix8X725MGdb3mVFGvyxcLe55Lp2zecFuo3aJBoesN
         W6W2hTvZOpz2uAaBRcMiVC5KwFTfzpX38DGCcAQ+0b6hfujF+T3oWnl1BQPzq191cl4H
         g/VehUkxi480yaYVekSE5RtMnH1AcXcn+NmfclqPF388naEN2jCuOJ3pVb5nAS9a1kof
         pFWN4pU2C33JvQ0CVSQiBxfGwALT+EosVyYL+8bdMdqKcaLEbLNhwQpS6QFJHYi/CuxT
         gg1oYRm5vLaFmgdEHgM94+4QmsyzveLS62kEBT/NmkKWaavCinx0dwVW2z3HMxK0kRgj
         g2yg==
X-Forwarded-Encrypted: i=1; AFNElJ8cb12nvZwzgeuU5W3t+IbNwZi2+o9/mTZFpXFw3N2lAsMBokyVF3oElozADMgDrSdnfSMCc8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyamC5ACzT7NhnuTcD1ZNonDxXzLCdaSWNVrYM+BhH8pzsWZhGe
	OM4uvN+LqP7B2ZLp+5+ay5jgAgvYK2+x24BhKwsPz0ISwYC9d0kZXo+GWcayomNZXg==
X-Gm-Gg: Acq92OGZrfIugC5Irpe6/R07In83S89FZezM57b/gAI4+Q4HnGRHDNfHVbKYFtT/0xI
	nKajrng+ctppKpCozBojSZ0Hui5E71sfL7frin2ovpKqSp/2OhOmvkf42VjoqdrSyzX/skON53C
	gFDrdzgM/GbbBe0IQRruQC/AulKu22NjAuy6HSncSNyxL2LiRBFuDLP+oUEFZhaXGB2Ajo5QYrZ
	gwqmo470QcY/MDwubxyihKA2VyVN0wrVUBbz31YWS7VjMtj0InLWAuVB/eFzeSqzcZGXwZ6Z8k+
	jo7CsqVtPgQ5bGLePvw+OvHbbgUQK6UJj8Ia5/pfzcMm7OqLWZh8gpCHe107PzKE4rLMHYjHr9q
	kMt/1ABN4s5iTk/1ujcj2Qfj2CURKv48m6faOthqvGuC7znfj2wC2ILAz8XoQxf5fE/HQmXOK2b
	wu3GMUCwa4FcvqofTypxJFzWTeJmr5budq8Qn4bgFU3JhNvqieHSkdlV4kysPo2kh2ppGa0msxc
	g==
X-Received: by 2002:a17:90b:390e:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-370ee82f93cmr24837129a91.3.1781081499588;
        Wed, 10 Jun 2026 01:51:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8717:e062:7cab:4cbf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a285a1sm21900817a91.9.2026.06.10.01.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:51:39 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:51:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Mark-yw Chen <mark-yw.chen@mediatek.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Tomasz Figa <tfiga@chromium.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] Bluetooth: btmtksdio: fix infinite loop in
 btmtksdio_txrx_work()
Message-ID: <aiklN2uHqmJNemws@google.com>
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609121329.1262170-1-senozhatsky@chromium.org>

On (26/06/09 21:10), Sergey Senozhatsky wrote:
> Every once in a while we see a hung btmtksdio_flush() task:
> 
>  INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
>  __cancel_work_timer+0x3f4/0x460
>  cancel_work_sync+0x1c/0x2c
>  btmtksdio_flush+0x2c/0x40
>  hci_dev_open_sync+0x10c4/0x2190
>  [..]
> 
> It all boils down to incorrect time_is_before_jiffies() usage in
> btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expected
> to be terminated if running for longer than 5*HZ.  However the
> timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5*HZ)
> evaluates to true when old_jiffies + 5*HZ is in the past i.e. when a
> timeout has occurred.  Using OR with time_is_before_jiffies(txrx_timeout)
> means that:
> - before the 5-second timeout: the condition is `int_status || false`,
>   so it loops as long as there are pending interrupts.
> - after the 5-second timeout: the condition becomes `int_status || true`,
>   which is always true.
> 
> When the loop becomes infinite btmtksdio_txrx_work() loop never
> terminates and never releases the SDIO host.
> 
> Fix loop termination condition to actually enforce a 5*HZ timeout.

Please hold off this patch, this change alone might not be enough.
Let us look closer into it, we'll come back you.
