Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935735;
	b=bIDt230bUH+ADa3b0iVYZnqwVtIzMlSw6v4jiMwgDZKbnIs1PwiFaW5gvQmhuN4ZqPB6
	 mHX0TOIlRxOkSYkwoNfLPBN8rhDQHCZUMJuchoh33FLwbAPUV5y53pqqrqPxdNQ5tUQSY
	 Dqv8zZ3/6CFK/KJvUcyd3GqqE3pIuqtiIej+/DdRP/+Wx3Jd5zpxatwp+fb9enj/m62ob
	 ZjdCijmW8+N+BBITUSHKTGaVbF8mRFBefjsnx3XFYyu+ALIvGVGVnPzQNgM9ktyIsKd2v
	 75Rm0bb6ROmLAHFZHzu5jkaPex4FLlW6xH+4WZYXr6AcixwXj2+yOWeqAZRfqevHF+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jShjFF4Sq6gPLLl5+8nJzOEA7mRuIBIl4olxLWqQ+z8=;
	b=iNZy42DVUzMhdO//czVZkWsaUCqcgI0RhtiwgY9dUA+XHpwJrlMlPRTjnKpbnTH9j2qh
	 KaSt7AN9qVRR81Tp2cjnibBmdn73ERwblD/uFon7N/s9nbA6hTMmD7sT/53bwNxBMTVVB
	 MiXguKvRrV8JpKULpwPw/oXXAH8vdzTjagvEo9kyqOSbnvcXmTDkrIAiIn9tM6QdPAyZO
	 SAKtSQmBDCInLzeOU2qYlZXHfr6vzm/1s2zZ5mEbw7W126/tactEv1XcAwGrsENnN9cFf
	 qHCN1ygbLo+aiRrCNl7fzfngiOPl9LV35LgdPe0PAI5xMfgZBs8Xw62Q/VqLicqmzqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rKqT+MaY;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A6606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 496A6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rKqT+MaY
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-706113e92f9so13090eaf.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794935734; x=1795540534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jShjFF4Sq6gPLLl5+8nJzOEA7mRuIBIl4olxLWqQ+z8=;
        b=rKqT+MaYydX0PsyeQqfFKGGm/slS3UpjlNun4tLMIpYejfEiygK8/IBn1vvUiQtrlp
         yR7GoCUu8LtosOIWFz2oIBYH9sZO3U1TnnrrIKGqm2EK5L0qPNHVFIUmOsD4JkwkzCgj
         /cJrY3sFHyQz4DusZL1fHtuLBw5b8UVPQTtoNcHRzGeagRJhAgIaaaqSkKxA2ryf0mal
         XtT+WkZotBUFNS4hDJ+oivVgmP6RRNwOJl5TO5xIf/BXFqVvhvyBR8ePn9tuF4V4n4s5
         NQsePix3m/QplEFRDNBW2AzSh6UVM2L1wUKraim4QKsqZLloPcgxY4OE2AGgPZ3nU39o
         xaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794935734; x=1795540534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jShjFF4Sq6gPLLl5+8nJzOEA7mRuIBIl4olxLWqQ+z8=;
        b=fUQkybn7AXRnYOOTeDDCHEhf/CO5OlymRfLTm+KOvFJuh9CC1/QHdFS+tGml7BT495
         9YuFVOkHYWCXJLo3qij0zD/vOKpo4IiYwe+1hYYCcdsRlr5Si3aXI07zYx0l5YfN0y9m
         qvS3vHccadb2v4wbFYxQzZHK5YoLi1JF2xZt3EwBE3Xrdq8lIh3AVa1ahWNGv+m/+1lM
         HmqxMrpAkgdCYAqmAh4+ofcK2TOWNeMS1ocrUwA5EjxUg1Yi8DJ41b/ZmPkkATXxY9Xy
         j+TqPoGb6j518cfdFUNnKCQ4mk9k/0/2hLY67TgUV34J40CSMv5VypOqQK9Y+64APEJf
         vicA==
X-Forwarded-Encrypted: i=1; AL+hErEoB8yfE3z03jy7wrVNy4uDu2TmbMztemNPuLD1AZw2jCcZVf7Il1Cqs+SF27D2iI8BQEdXDvA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wkrnfQKuozZGUuPk8B3oBA7XVRZUU+PxNLfTZ5EERRdHCT4Za
	/cJ55or63FvVhpbAzFdfTydD/XwIb/+5ZHpfHa3xTf0AzZa7WfAZd0Al
X-Gm-Gg: AYBFou1enDLq8GA+QzQEUww6+Hv8tnFiBTJ+1v80iy7gy9yWhoXjN9BCy5oEhaLXSC0
	Y9GW1dAYbTBLD8toPeU5g2ZrJCBaVlUtiHwtxSx2S5DcI+Lwhgs8R3ZXYxHiyBZJNOz4UAegCYR
	ce++5jjdZLnBuPcGQfnBwDORNl6QZq7sxLMjYAZvIgpas/6XZgmewgu0DBJGh5wpHor+w3zfH1R
	FmZb5rJHnkafkxokYN/LazeQc5/yZw5sTYXjPQLQ9OvSADGuNSBxozLnUSBKDUTF5fqnNelMRuL
	CRw5lRUzp9dYOlNVdq24e1Bdqyd/MF68ceNY/IHko62XAEDMsqJgzoocvVVhjYP9LrGhGSROTQv
	1aEeL8ZVYUdFtn37y3ckWTZnHsX7dZdzOhvcGmVE7/ycidDTuP7p8+bVQNgMew3m5GBLu91PPN0
	SnnwIaYgaO/jXApyYYO7C+nVArt9c/inpEaDfGh9cWBG/paF+uAV1TaiebllTrKrkQB6raGWcIO
	GVITRO3nbsoQu3k9iPHFpv41lgWskIIFg6GM1PmRXTjenwkv26GzUrr6aM/x4GwBHE/VQLERnMM
	1wltB1oWLV9ajQuN3opfDA==
X-Received: by 2002:a05:6820:2203:b0:6cd:3ffc:ad01 with SMTP id 006d021491bc7-71ace39b3b4mr7492285eaf.81.1794935733793;
        Tue, 17 Nov 2026 09:15:33 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:15::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab42cc12dsm11351357eaf.7.2026.11.17.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:15:33 -0800 (PST)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	mason@kernel.org,
	osandov@osandov.com,
	josef@toxicpanda.com,
	fdmanana@suse.com,
	boris@bur.io,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix bytes_may_use underflow after a failed tree block allocation
Date: Tue, 17 Nov 2026 09:15:26 -0800
Message-ID: <20261117171526.1083793-1-vlad.wing@gmail.com>
In-Reply-To: <700e302d-c85e-4bd8-84b1-0e6eb8565740@gmx.com>
References: <700e302d-c85e-4bd8-84b1-0e6eb8565740@gmx.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Nov 14, 2026 at 08:05:47AM +1030, Qu Wenruo wrote:
> Can you simplify the commit message, not only by a little but by a ton?
[...]
> To be honest, most (if not all) of your commit message can be extracted
> into a single call trace graph:
[...]

Thanks for the review, and sorry for the overly long changelog. v2 will
follow with a much shorter one, built around a call trace like yours.

Vlad
