Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355571;
	b=wiRZFYxOD0ZsNZ/nqKX9W2kSto440q9Ff2mgC7r39xjpowRCtx01JClm/b54tbTZQMHy
	 VJ/4XJ1k9epRCdgGuKa51qW0jqOXg1TjOpwTeddVk7XcwvHCU+JDffPCGXSs6FSTb5XS/
	 Fo2soKfBUNXEe5k3ruL8ZCfXm0B/U9+iRcWtkmyFkFHWsfWe+bYRESQVcZNJnWu+VQcEn
	 ApkQFqyaDXYPxNjOttMMi2XEDr/5k1sCUy4LJkEc1hFwbUw1PnviStdTbBJAKnkKe4E78
	 Rkw1JOhVjalUvHFTJ/IOttvzfwGHp0VCdq+zNNwcuY+OKl9cUgyOm5sOyjcazcOq1Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=JGIyabnuomdMY4mzyJl+FsweC4t2Xg/CjKOuJT2HG3U=;
	b=ndwpj00hsN1tCtQ9FsuLdwlmD/7XbqvNidwMUzxvSnVgFa5YyrmK3XqMBL8f2JbG+Ix2
	 hICBGHzlTlQPXW8bhGVS7XeeeQN0j9KQqsVUetBfgFBO1p7WYzBlPT993yezShEXg1htQ
	 wh2dh8+VenfwgacXVPcLOdUUwNfs6mMFg0Ewrlt/ak5JdV9QjDV/ujJK8EasroHJ+PxCo
	 GaMMPnrrGf1h7OqOtzhw33X24ieMnbSdDnpDjPVEgpX/3uXfezJRZWuIzkEfe2E1FZo9X
	 vQhQ3fFkPnjcAb5ohqFsn2s3/Vqqyr4xffxgQJCnSECRp3FKhjABsaxDHTd6TCniVzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="PoILoG/6";
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522660A3801
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D522660A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PoILoG/6
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4fb73e868aaso3620836b6e.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794355570; x=1794960370; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGIyabnuomdMY4mzyJl+FsweC4t2Xg/CjKOuJT2HG3U=;
        b=PoILoG/6p+f+9LXq9J50v3+N0Q53C8nTDvAgAjVsNPZjLFaIMfmdTcjreg75LI4Znl
         uzfQWGGZ3p1O5g2p7ZcZsiGGfPtsmso8Adw/ahuVk5tU8HwbC8clf3uGf8eyhZ2gobR0
         6qmhPbrFgw3F6kx5S0DKGHN1Gy4Z0DdKNgTZPdwx/h0K7M/EHrWRlRgdDXx+xtHOus3u
         S0IFd2Gp1+849+2ggKghGFYWLSOubmX4cY5NCMMAPfTJuvFD4IN/P6aObsdS6RuO6hb4
         s375eP/99gD1tUB+08NahTdAu43C+76f8ubwFeDKdH131LMC+VRIBYKGo5JWiMus5Zfb
         QOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355570; x=1794960370;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JGIyabnuomdMY4mzyJl+FsweC4t2Xg/CjKOuJT2HG3U=;
        b=Omu7qoNVcevkdfnHplKGyCz8+iFfJYRj36HwZHLpuYAkA+t+ha+aG8HHozqjjg3kpN
         yi7z566zi4sfgYPdxyik4D3k/SNJohCltYisW4tuRcHYJge8KknnH0F0YhjSbsJtcyIT
         qx2cZs8QLcU37lY5CE+LZEZp01jBOVnCI27SmB8FSFLb73If9HBxfJDazaiPPIMvlUL3
         z2wNInJjP0erqsTEIVW0w+92VYCDWSw4Pk6CpZgjAZk7ytZXdhPPxZahroSeXXQnV3fv
         Nj/uoE3V+KoUGVkgmALEb4J27g2Ix1ovVPfGh8JKsyTTiozGPu2XyxW5KyDkoVvQ7UEg
         oVqQ==
X-Gm-Message-State: APuU4Z+dz+WRbh1NDHMxRwAJgjnBiTu72K5qN609ukAxhnBYDylcPPnL
	5rjatIJJsqsbzyEcMpP4GUQHxvx1q9ySujdpwCWEEcfLP0wvbeUXZgk6Or2kHPKcTz1KOyt2VnT
	VpG9mtdQsV0OOydK2lXJ2T7BGNHrxQhh0NUURITy2DU4EraTbFmWVxaQSnXD+odL0lsVKc+laqo
	TbhykYhAsrh4Q9miP0SqAOZp4xNPznRrzGjyrQBWP9yl60Pd4=
X-Received: from jaql27.prod.google.com ([2002:a02:ccfb:0:b0:5fe:be7:9ab2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2f0f:b0:4df:5cd0:89c1 with SMTP id 5614622812f47-56b96bd15aemr537368b6e.23.1794355569138;
 Tue, 10 Nov 2026 16:06:09 -0800 (PST)
Date: Wed, 11 Nov 2026 00:06:03 +0000
In-Reply-To: <20261109200936-failed-6.12-71555ae8c757@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109200936-failed-6.12-71555ae8c757@kernel.org>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111000605.3227011-1-skhawaja@google.com>
Subject: [PATCH 6.12.y 0/2] mm/gup: memfd_pin_folios() fixes
From: Samiullah Khawaja <skhawaja@google.com>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

71555ae8c757 depends on c83ee2fa5a94, which is not in 6.12.y yet, so
backport both. Patch 2 had a trivial conflict with the existing next_idx
variable in 6.12.

Tested with the udmabuf selftest.

Chris Mason (1):
  mm/gup: fix clearing folios in memfd_pin_folios()

Samiullah Khawaja (1):
  mm/gup: check folio->mapping under folio lock in memfd_pin_folios()

 mm/gup.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

-- 
2.56.0.542.g3ef89b7020-goog

