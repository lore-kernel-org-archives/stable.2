Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465544;
	b=lyULmAtLn8g5yyZQ+UQWASqasFJj160VzztUKTj1ANuUnWfTGydFckrT1eeK9KqfAN5E
	 JvInvyqZOs8mYAlUg6S5CfxvJDRoB66g7DIsS3/oStvk3WfUx06cVV11BErtQXvORciDz
	 fwdbuCj8+7nMXjjQEjZmYLbu4zhga9Nz9obuMLxxAq211ZtLbRFn7lQk0ogoumC7cCavo
	 ZsfGZeZQzgtdJMUWc7WgHhsKrANLkk/l4BcweeT9vHDMzphBYmM5HVjxgZa56W4dRKGIt
	 wdovona4KliNLBorng69rQaTAmw2Qxp50sZ/dVaXNO4E755a3Kr9QJPnibv5gzN0gpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=htaRIjRweiLZjcs4Tzl0zEgyIU7UNaepRLCTi+oWXpM=;
	b=Me3MQGQXkOBWDNWavyrmCAd5r5XDsTobnqfQXLFKG8p/aPUgCOilrb28U7rURfQ+xwpb
	 gXv+Ch6L/rNb06Mo/I26nfcwopKXEshiVVStQEnfU/mA4Cw+MR4HpLehp0o7zen8QIc8q
	 m/3rJb0ZWV6RjXql6mkID2Lj5989FRyjO8DCOWPVMhRnmZHGql+Xy7mzw/eV9SFiSi4Dz
	 F/4SiBJ1tv2IJLJXBWM3ILgGW0B12UzhYHvsNMS2IzUPRZ+WPlaW7LXP3lck3pHKST8Qm
	 yvINKvMUgF7JA607INCKihpah/E5qQRgyogPS5/oeFKhTkSJIAWMQtqZKgJRHJrLsiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGoQEP38;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1B606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5E1B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGoQEP38
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38644aedba1so5668571eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465543; x=1796070343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=htaRIjRweiLZjcs4Tzl0zEgyIU7UNaepRLCTi+oWXpM=;
        b=LGoQEP38QC3mznKKpYLgQAySy0alTcR0n0d7eNlMT3FTZ1BpQLcmGokdl0DN0D4DEi
         47ol5mg9dX4fE+VZWjDPKzH2w00w48XuQmGfvKWD30EwXq4wBxe2OswhF+w8cYXN8Yvh
         GXWkJ4OuH/HOLmkq91vhcZdPy2oROb6p1SQsZzZC49xdJZVUd0doiVxlS2wNVTRB1Zf1
         swaGUIsQ4cEvd35wpIMB3iECKpLwpiSKr8ymAleMNompx+7dgzkqhjVtbNdU7D1+KLbS
         4UqVK2cEA/Gnqkl6pXK7FD3rEANBEflkhlpTtkxAXmeEQWmOIp72hjpMQ1KC9MFWoxje
         HGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465543; x=1796070343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=htaRIjRweiLZjcs4Tzl0zEgyIU7UNaepRLCTi+oWXpM=;
        b=wzNwrWBhxe4TXrChOvbcg3GJwW5Glq7ZnO5IzLPK58dSKP3DJd6HJLQBkFFxwnCM3W
         i43SMV3VZOk9nlg1FW7w6LUxRaLw75R5wrP+RRUlRwZNz4UMNotfprZDtAbTfbe8s+g/
         UkMVef3VB8ig3zwjCIl/v6tItURyV3NqU3vM2z+hg/gKEBPTprAOz1BpdkaH/vRAhrJV
         OeHWOL/l4b++P6NWN73z0MbrA+966rJ4h8Nm4GRmEtDpRBZ5xCoUutDuifacO77DFbWj
         dJ7+u8qeAMBAjkEaP2kRWlbPl3aDvXj5c+dmEtx54yagqtywgbnFSQPuOkfwoS/jR19Q
         9HkA==
X-Forwarded-Encrypted: i=1; AL+hErEELERiB+diIX0I+8YGFyvrYNm1A9Po7rVely8xCxZiahHwUqJHk0cyHEtKTsUaZxp6fFHZefc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5uml1DYQYWvg72FfyPHv1r5QYHEd9/j36g5uwhEOMCMyEQP/k
	p3SWlzV/CJKz/trNRAKbFTv3bbiyjQm0+APHLeGqseYTh4AD4NK/y09MUP7mS1e0
X-Gm-Gg: AZFdTZcnt/+dEM5jHjgCSA57Yhqhcdk0KBzxMIzOIB7/0YZUAGEdCvdx5I0P1MPGRl/
	2fBdF/7Z1nbBQxybNwYhAzDzIy323hzYKedwOVS0JYpr5fmpEJRapgct7wQIQqvFuPm6aTRWVSU
	ROjiT4l6p6YNGPws2Y1WkIbd6M0RAvnLVtmlJEkh/1udbeZdOmjlxpNFS2SEmfOOtB7iC+b6pyv
	PXHJO50OgC3DDyec/OuzyweWD4iF9SBHebfLgh5MMkg8GmHGfcr4OXGksvDysloMHjVuzayv03M
	PiiLhz7IpgCPU4POfP8LWkHlE4GyWprzo5TeHuX1dEIp24Czutcbp+KzLq28RMGuAKsD+mDYnf7
	Y1G5Q6CWHe5b/K46dN95b3P5luPhuFbGX4th/yPMqPB+WhvkddTz1goe+3fhty0F/396X1tRO0C
	VOZl0/7oE9N4j3Ghhykccs5HBpQ6jT0zAVl1ag7uXRV0PTaUEDSaBzrHMzOxQW6zYdWhv4VLqSg
	aFwExquc+K+eOpyHl5LBH8+wbJ2X9OR5PgYLSj+n5oM5FYuCYuvrOXHpK/889FLVEyKHUH9HyYz
	treqIH1+90TZAoEbGXS+G9Dk4EEFTcG9Vu4l8d8HkPOm8neXGxPHRiH4hzOpKH13y1OMlog3TxR
	T2EjbHuSmf8c/J/rF
X-Received: by 2002:a05:7301:211a:b0:373:5561:8d06 with SMTP id 5a478bee46e88-38570c36e7cmr11463927eec.37.1795465542635;
        Mon, 23 Nov 2026 12:25:42 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm46389898eec.11.2026.11.23.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:25:40 -0800 (PST)
Date: Mon, 23 Nov 2026 12:25:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 09/10] Input: pinephone-keyboard - request IRQ before
 registering input device
Message-ID: <awShPfjuvVjlw-Kj@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-10-lee@kernel.org>
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
In-Reply-To: <20261123183200.3900004-10-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:15PM +0000, Lee Jones wrote:
> ppkb_probe() registers ppkb->input before installing its threaded
> interrupt handler with devm_request_threaded_irq().
> 
> As soon as input_register_device() exposes the keyboard (including
> synchronous open by the console keyboard handler), ppkb_open() enables
> matrix scanning.  If a key is held during this window, the controller
> asserts its level-triggered interrupt line before the handler is
> registered, causing the kernel to disable the unhandled IRQ.  In
> addition, devres unwinds in reverse order on unbind, freeing the IRQ
> handler before input unregistration invokes ppkb_close() to disable
> scanning.
> 
> Request the threaded IRQ before calling input_register_device() so the
> handler is in place before scanning can be enabled and outlives input
> unregistration on teardown.
> 
> Fixes: 17406967ec0f ("Input: pinephone-keyboard - add PinePhone keyboard driver")
> Closes: https://sashiko.dev/#/bug/linux-f24d8390-cd48-42d7-a3ea-c075b69c127a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
