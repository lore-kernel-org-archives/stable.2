Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465178;
	b=VQszbs+bDlvXJR6TqR8BC/aux8y/YLpTDaWh/Mv2dhWXLrh2srnA2faBZZNWNlmzbqQp
	 x7jrpcwYoAdI3D2aOL8zB3OPae/y+DFHuFS0QW/ULwLzjcP98SwYbXHR6c2VavZhrQz/v
	 49nynr0Elx+0I9pg/bIFL/m9cMjmqZYI/TEPQYf7Y2C8GaZmzhCHOFoHLJ7CF5RuyLJib
	 HaqvQaAqIQ/s7MQlimOy2UelGfOVy2HZT5ByNJ8bJ4tFpVdFEOF0KMRxbg7ucCIn2oUBR
	 VtPjGNFVhOcpB4GoNRrjthdWQZRQWjt/BtFdjntMxZtluCBwG8EajiY+ewmh1G2BxKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=k9JvOVz5fdfo9Ol5UQWej8qJ9KZGY8CDn+BGwa9BvBA=;
	b=YfjEili5U5oJj34ak2eIA0ugUCHXsQ8f/PowQ0WiBDJ1lLYDaQm8O2d46wi4X1Vf5B9j
	 IMY8CdEvGQ+HNhMGBSDf5q2LMxrOo33TMMY9GlFlOgtVu2zGKXM1ihpUsg3KJbwudlZuT
	 5K9rVrVqfs+NB7ypeYQKht+ciXjuO5vlQXi893sEDpXkNJ3Mcvq4HWuaubkBWDPh1bEDb
	 U1ZN7nUO08EYMw4zaxqDclTe1A2DxBlQKuo0QMlRi5rONsqERejsPZElYPzN2xAspod6d
	 yXEGXnIwe5uBbhDofuCQtOJ905ls30iZzMduj4pDPHGG8C4HgvWMMKUAyToOzlH3BvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lgUJfAb/";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCA606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3BCA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lgUJfAb/
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38644aedba1so5659221eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465177; x=1796069977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k9JvOVz5fdfo9Ol5UQWej8qJ9KZGY8CDn+BGwa9BvBA=;
        b=lgUJfAb/vyxZQ6/b6tuAVyFytFPBYr8TkJTXTys3zhzRbIAxfR9jFkSb7TG+uPZZef
         5CGy6n4d+zrF2erPnqe7uVws1QY64qO3DlQWVCtpZQIkmy4qTeKPeJ2VMi1M5oiDbg5M
         QM7ceSymN2Qarxo0SAbtKcG/FRVWqF+cArIml6tCkIt32oLIThKRYO5Qjavp8hzzwzv8
         klTkxXk4CG0koeX+RhBwwgLsy2QjQrMaMp6poSckzPsWvoR95dCL0vVvqmBn+eYf9e8R
         CJTys15HmCdjcNciWuVwodHuErLtMRA2+kphH4EDWVHopgQncYQu0vFpKPxEhgliqlAw
         L/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465177; x=1796069977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k9JvOVz5fdfo9Ol5UQWej8qJ9KZGY8CDn+BGwa9BvBA=;
        b=mabsII3HDkzR9PnYmKfladwP7xkNfktGG1cCkIsMmRQfzfGprKs3e0QIjGieQ0mtxH
         HbequETWCCMqDtTZM3eA62HA38aOCefSS20fuQ5JuJOHzaHcTf5Pm4Q4Sl0ZyoR4sES4
         gJeMikU/GqS0KxH0Cszh/s+Xi/x0eO/i89PXEOAAnsUrpw4gWHeS73FEze1K+Li261iB
         qKX8ObHOO/1oSgu4e9ChDy2hAHfZflzdLrByg+uyWcVVbcNOohALWoizJrCUr4ArwZsf
         cZGg0P6cAdszPMIsrMcxcFVw0jSP5X3f7HjGhGx2k/ayj0uQLVkMh9OGmRTj2tKUsRjU
         dt3w==
X-Forwarded-Encrypted: i=1; AL+hErHwODcOWSIZScuyG/cBsIJhTJJJuNAJvmnVXRWPQK25WLixb3lQzgNY8CV86i221cBXkuqAXPY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UyKkzW90Y6Wy26ElEL0cC+2m4aIvhsN5fmootYZbCa+Kmya07
	tEiE33TdYd7nbstbQoeTvIygc/vInRXmNex48vkB79pTS5A6Boehzr2G
X-Gm-Gg: AZFdTZcuMpKItjUkz84YIeob018b5DhL1uRd/c8Y4Y5gqbT1StP9HjIPGBRTHMm5Pik
	1SsweN3RZDqZZ2CEeRQ6A2Pb+8ujzTUDpBQrCQ5AsGcNwa79980LuzBPtGNUw1JoG1YgyTiMJpL
	IrankbNWcPcpn2ZO1A6iwD7kqRakb6XI9b28gthUZmZN5qR+oX8y/K702Kb3VjnFtkntkUuQ9ZY
	NR6z6oST+o58Lz6NMRN5CvnFw7Cef8x4R73H8zQxypHHb6bZq2qKBS1AlZ1cEZ3EPKBqSQXQgdY
	uins1lY9TegnbpK7JfSxFXoMa5/rbaYTXAm/bLNpr3dQ+Jb90Ap1VjWSjLjoW7AZJbcvTtSK6wR
	uPdaDcXsjk+lN7LeUIkRd8yEjs0vqlnAIx0e/I1l7fJ70sCHYCh20E2t0aBCa/QYyOOAgToCAdD
	y2arc48x+80DIYzDWDjuUYVWJvWr+KfL0WL96KFY2FHSInzdShuStLaY7sLPeC+ItDnATu+aLEb
	4JmR3XqNMnJDTbsp856mChID/9btn1+50pYw0bEhnrgRaaTkdvtPPeZ7a/ikIR9qHVUQjya+ODs
	n6750RIFiEXNWbNX/MUYKvEFuoxJNG/fV7LONxGZjO5UKNMM37uAxP2Ll0UjdEe8sc3AOd4=
X-Received: by 2002:a05:7300:ce93:b0:36c:a44c:1763 with SMTP id 5a478bee46e88-386bbfa6402mr1219667eec.32.1795465176733;
        Mon, 23 Nov 2026 12:19:36 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm44019037eec.26.2026.11.23.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:19:36 -0800 (PST)
Date: Mon, 23 Nov 2026 12:19:33 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Vojtech Pavlik <vojtech@ucw.cz>, Greg Kroah-Hartman <gregkh@suse.de>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 05/10] Input: stinger - zero-initialise driver state in
 stinger_connect()
Message-ID: <awSf0LtS9H2o_hWi@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-6-lee@kernel.org>
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
In-Reply-To: <20261123183200.3900004-6-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:11PM +0000, Lee Jones wrote:
> stinger_connect() allocates struct stinger with kmalloc_obj() without
> initialising the signed packet index stinger->idx.
> 
> When serial bytes arrive in stinger_interrupt(), negative values of
> stinger->idx pass the stinger->idx < STINGER_MAX_LENGTH check and cause
> stinger->data[stinger->idx++] to write before the start of stinger->data
> on the heap, corrupting stinger->dev or adjacent slab memory.  Initial
> values of 4 or greater never match the stinger->idx == 4 reset check and
> permanently wedge packet assembly.
> 
> Allocate struct stinger with kzalloc_obj() so stinger->idx and the
> packet buffer start zeroed.
> 
> Fixes: 17dd3f0f7aa7 ("[PATCH] drivers/input/joystick: convert to dynamic input_dev allocation")
> Closes: https://sashiko.dev/#/bug/linux-bad333c0-5b62-4ca5-ad93-204400bcba3a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
