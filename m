Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277572;
	b=RHD1YwAqkRVmuEE7y9Xml8FggzLGUu0NlvOGi3odaJ07QBKZYPaaB3qiHzqGXzgKn2xE
	 w6UuPnQo18ApkoI2ZbFxoS4BMMns2/PySCfpqQ505G3djC/y/VhC3M8F7lH/unlrYlIGX
	 HwoOI4MIk9tO0UbKSjN7DbHOUpfD0UW9p8z62H73gaDdZzSIL+giAVp/ozuIqWN1pj4jA
	 H4QOcfJW9eQKEbDjODFejLBSd0066AB71hHP/Y1UJUaLjcn8NaQ/nqiwInFxNndLJoZa7
	 /jEU+YMwMEdVrMadiPOZ7Pcl8ARV/PPHe+Z5yo7oRkaQU/qiW4/mBId5qq1mNEeJnpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nMXozHSfJxf2AvAMtoshFLuIIIU01l+UNOII+lpoa8A=;
	b=nowHVdW0AO5Xha57Lf8sCVuFcuqkaeKQ18hj/508xkwzD1seqJQ9/zBFIeweICcq8uPC
	 toaeQJs06tfo3OYsBs8L4rSGuS+jeJYzT9Z+im4LqPGDFYT0BIue+lfsE0aMgx3DMY/VU
	 X9WIXXpI/mqJdYv8SdU/5BNAiKCXdiHOgYrnk+QFdHz4YZ83PQYQtOEuAqyznn24Me9r1
	 FGEzzSwHaX8EYPFP6uj9yBrMPxgjsMXLFOQs9aG540I28VkcjMmqLTMyninI97rOlyAnw
	 xZFRVO/Z421hyJrqWpE4LU0jci0SSNwa1hKe8a7+ZTtWs0DVD3//knxuSpLEslsmK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FX2fVbNe;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6C606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C6C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FX2fVbNe
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15ea896ddc8so2609697c88.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 18:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794277571; x=1794882371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nMXozHSfJxf2AvAMtoshFLuIIIU01l+UNOII+lpoa8A=;
        b=FX2fVbNeoet9tNqnAuC9GEH/7TT9G7rqH8VlPFwlBju9rj/G/2HAvWODd8cPiGy44L
         FAZHHgZnjBA1pLMi2MiD7vHLbzjf95YB0LR2q3VAp1R7/RV37wZkcIBexM+qO+OT0U/r
         RLw5PEnxaEnZ8ZU3mo2CniUlNQsDBNnKoYCyxR85/LNIxslu+yQGuwvFnaKLIQ75fG1U
         AK/IXhHrvDMQfZFbj5iqf/9+oPOnWekp0Cjy3LvY0lH1eZyB36/3AKI/8rPpaqZY3SIO
         omjKeBfgiPKhvBcZS11FEH/0ej1rGMS6BM4QSaU/lAzkYzpLxdkUskMp+21iCtebfe/6
         9rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794277571; x=1794882371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMXozHSfJxf2AvAMtoshFLuIIIU01l+UNOII+lpoa8A=;
        b=buJzjif0n+6W/lrRDYZBJJoEdsZwl9p+XNwct/ucqdoKGvBbWd++OfXvZCuw2drFaN
         NaI5NG2fo2Bn8znWhYvL/guxRtGHtoVvKzBO+jHL9ExwtIEEaAzMkBmiS+dSMfp26yJB
         fxT2ONVdLtBxaXaO0inrWlsP+V78rvB6WRqHFGrUM0MIJ5zmZsbekEhbTCIAzFNVO9NK
         OsiOb3eGmbh6htZH5OOksr/91YTNVLj+zbPmdLVwVrSGeLZ0n+uag6/CNQKJreh3tzXx
         d79eqywN7gOlY8kYS9LhcPQa2SSOzboKh73bxaofGm+NlPbVwQpvw6O4uZOjyUtIo3Lq
         Scbw==
X-Forwarded-Encrypted: i=1; AL+hErGzeM6HtiHO5dgMlHkztnr9ygXIe43Z4ry62joveC2z2W+QHexb+8ZGiZvnaNGMGyVDz8qKc5c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QXMG9qiNBQWgdyih7xPjtk7NmqPp7lhdfW/GklIBKFlZle+o3
	E4piLvg7fE9WakBjJTvKU9ps3np+nO5GztNr366l+tmdVi7aJqpQlnR6
X-Gm-Gg: AYBFou2zmq0VtdYmCk6rnpIZIScAO3dkoqjmxIY7MD6SQshCs47/RTQDfIii9W12w4U
	uMtz8fTpltBn/HA5gkA7u5fFk1mQUneovDBUIDCWqPlFaQPy2kriMdAtSfHCqIcsCzFdfM/YUv6
	9mY1a3ZCe+IAtbOpzfXWhGzqslq/LaJcPgGU6bpND+K9rgFMpVc+IoqcnhiUlz6CUaGlQwYbIjC
	gOj0BCH2He5fdRa6AiEA+1WSH8s+MngSMwxGzWXxQekugRS0tAeqfhkPZOJrwUv4cQ6mh4JHxMj
	8wrLm8IALeltvLXb4xMgCci0eoB/Vt+/3ilfDFAoaOIh/4ZEdYugXsNCWbNJy+620AUop9MBu2u
	L4nQWdQ2WWFWqE06Y/KWWorVGUXIdvtytpXVDEgGpTZuE/5ofL3ZCcmkZ8cM2yjUTsOwpHqfDrv
	n4efO51WC4HvISfoa8SLFL2+cG8xQ/+35BmVcY1FsVArhuJA+a0GqUA/dSgSq3Dug1svA74KMsx
	qm/lUhrxsKb9F6LegdTqJ2UWJPaH3FjMfqpdvyWPK+fKsJ3iWgLKcgb1Mk1RkEXxFfUXJI+EZN8
	1j0+gw94XITQlLOSoDls70sQZ8syJ3S67sNgd6biAVB2AOaHq0dOImauBxh/umR7pr/Chw==
X-Received: by 2002:a05:7022:220a:b0:1a6:4679:6cf4 with SMTP id a92af1059eb24-1b3b603ef0dmr2264248c88.36.1794277571093;
        Mon, 09 Nov 2026 18:26:11 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:856b:460b:b522:14ec])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4ecccsm2486079c88.13.2026.11.09.18.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:26:08 -0800 (PST)
Date: Mon, 9 Nov 2026 18:26:05 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: ivanverbovoy@gmail.com
Cc: Support Opensource <support.opensource@diasemi.com>, 
	Roy Im <roy.im.opensource@diasemi.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: da7280 - do not advertise FF_GAIN
Message-ID: <avKAtJ8VJ7mL2gP4@google.com>
References: <20261109-da7280-fixes-v1-1-09cc3650261c@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-da7280-fixes-v1-1-09cc3650261c@gmail.com>

On Mon, Nov 09, 2026 at 07:15:55PM +0200, Ivan Verbovoy via B4 Relay wrote:
> From: Ivan Verbovoy <ivanverbovoy@gmail.com>
> 
> The driver sets FF_GAIN in the device's force feedback capabilities but
> provides no set_gain() callback. input_ff_event() checks the capability
> bit, not the callback, before calling ff->set_gain(), so an EV_FF/FF_GAIN
> event written to the event node by any process with write access to it
> calls through a NULL pointer.
> 
> The driver has no global gain to set: a constant effect carries its own
> level, and a periodic effect plays a pattern from the device's waveform
> memory. Drop FF_GAIN from the capabilities, so that input_ff_event()
> ignores such an event.
> 
> Fixes: cd3f609823a5 ("Input: new da7280 haptic driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ivan Verbovoy <ivanverbovoy@gmail.com>

Applied, thank you.

-- 
Dmitry
