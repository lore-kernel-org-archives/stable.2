Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792847916;
	b=a5F0YF9RuIH2zE1Zk7O+uejzWRgeBpct7AIl+5DvdRBpD9SOE9COf+UVqjjgUvtgbocw
	 G8Jc8wM3YMF2d6wyIWkU7ghFvTaanzOdTj21KDTJhot9GL/2hp3ux6ecCQ4YKN5UUeO3i
	 UBrvaT1hKQNuwaWWOS0uf2+8cwROPuzMu37nj2tgvKMr4POTV2qb/G67PoT5+7Pw+KAFJ
	 YfNphs4/k24TgBt4KFOYxqDtPn1P/L9UXblvlIxaI/bdAQte7zfftjml7VOenIAh11cyK
	 iUCg/NxkKJpqhoEGgCN6S/PNg/Jg7xAqGmnCMh1xrJIMz7O7rLu1zOqF5Xw/AxpUIKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r53zQBd90L9qdkyWqx4Yp32RyLUSfl8WDtc6jDamlsM=;
	b=R/lRfOKntHvn8Q5MhSgoC9Wcl1tBf1D1+w9+g/J//rbpIVDldSVeBgN3gKeCT18Y+8qR
	 3u6TKd2BHuayWDxwnye23x45VWQcvDrD9vvz95AChiYSNTqWRe+cgLYMw/NXHlWbHxj4r
	 TLPtsynPJIZz//yjp1+CGGTnMy52OkrR0qqi/0NCHAguGYiM4QyHdecv1wmcoeFP/2MC9
	 N706NKkFBvuAOGjE9g49FMiy3+yb4XVbnnWzU3d8yvP93t9ItzkVA3lxuUkWoucRI8hnK
	 4D0IBrsBAQa4fuYP04NfxzkzVpnx7ju898tYn82cERLZuY6oNn0M/NsKZqTHZftT8DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VSvFNyqh;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC52606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CC52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VSvFNyqh
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso268526666b.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792847914; x=1793452714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r53zQBd90L9qdkyWqx4Yp32RyLUSfl8WDtc6jDamlsM=;
        b=VSvFNyqhMUeeID/TDzuFbF9AoZ+sHEGSyXve2GFhLKesyMr5IA5cVkmgRSLKKaaR0e
         agkgQf/p/unG7iiN8jrnfTc/hxW4VheXSO6Peulizc6v+ZxKLt+D52hwA3f7/kEzEFSL
         PbX7kOh0xjFYPR/cfRYX/nTYXs7K3UrucU5SD+BDfHKXs9o6z2lZgHLD4mpc0AwLxme1
         BywKhG1NQ6Ce/PMfM3T5hBLr7OCv1DV87fbpnTtSoHu6oXrkCUu0uoamWo/xkcueiiGn
         +q3WdnbQx9TjBf8UjcfWQEx1UTAQ+TwO5a743f+DB+1b6FEmLulHety77WvNW2rvQZUq
         r3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792847914; x=1793452714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r53zQBd90L9qdkyWqx4Yp32RyLUSfl8WDtc6jDamlsM=;
        b=DOPiFBKQpaNsk8S4G06owjinzP0jnv2fpD/34R84QC1qO1a0jAM7wZ6j3j1xpQ1o3z
         mjKmzDCFSNEfZWaS20RNAW6RRWd+jwOR95CG2+H1jkQK/Mw6ZZX215ytqXW6rswLdIYf
         KH8HN78+ZncJOc3Nnkglqo4YKTSejF2HAkQ7b1UbVOCnk7W16nBX7wwy95KqmL2dLgq1
         xb7HTvTLOkI2yNp3oXmswnocAV16KCrsrGtbg4O4ESF7U9U4nyTgCWmG+oVbEQxC7krQ
         SP7daV7vZiDeKPzRhkjlMRx1HD6ESsGDvXGNVHYppADS52SMo4D2i43QTdxDYl/mncVM
         RDzg==
X-Forwarded-Encrypted: i=1; AKwUvBwB0F9p608XsbVpmb1P4bZoZ6CEVuowZ1Gp2I5087L9tyxHp6jAeN5q2yyUHnW3TDNJv4Mrasw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLw116y3i+W3Ab8U84THBOzKHlEMlNpUNL9exZq50+efKhi1Wrt
	IDx5LURQ10hOFtW5ory0NM1DigmXDHbvxyewAyPHkUVTvMENGjBMEdT/
X-Gm-Gg: AYBFou3kq59KgXSWeeRUYYyDKS8NuMWSYhJGMR9QI5IYj1UK73gJofrN+ehzsf6jEKL
	iezelH3ioPV5jRJqqnrxKfDOPI6P3sfjfZ1f1+BjhlU09D7JSLF4OwrBDveQYTOoWQ1djZ6UScG
	uLnW7WdVrr78huHvgTDZggFGe15gx+OjzwE9qoTOApj+i7dB14k+r2nfSb2do/yixUYgESGdNqd
	he21GjzhSrnRpp8lhQViN5M/HG1RGYfv2niOObY/fv9uiHgOmNmbJL2cc7FQ+tysNQEt/LIT46N
	mj5shyz8Q8hPC8v0Hx2eNC0ZKD2WCOdwmjUjKnSbdLIENTfbw1VhhsqaKV6Mz03aSK5DdfKG8c3
	5JhVS27lcIVVSoLALzGVnmgQ0ih5IvgF+fI6FNte0KpJph0fc2EJTI7J2zSfVoGcixmfVWhvg9Q
	bndWm3C5G5UlpQvbUOScuA3LDfrXHikpCvGVuVi7OmYDAZBTYxzFW21YIQUXduAJjC/fjROQ0nI
	cbh66n5bBwVyVsIS1RFHmCx8pBPAoun5ELpNuPhoNPgpRTiC1gER5rXB7Jbcgw76MD8wqNbsg==
X-Received: by 2002:a17:907:6e90:b0:c46:8909:963b with SMTP id a640c23a62f3a-c46bddb52camr227292866b.9.1792847914396;
        Sat, 24 Oct 2026 06:18:34 -0700 (PDT)
Received: from localhost.localdomain ([185.65.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd6276d8sm87306666b.41.2026.10.24.06.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 06:18:33 -0700 (PDT)
From: Hedi Ben Hamida <hedihamida096@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Hedi Ben Hamida <hedihamida096@gmail.com>
Subject: [PATCH v2 0/2] wifi: mt76: mt7921: fix hibernate and suspend resume
Date: Sat, 24 Oct 2026 09:16:51 -0400
Message-ID: <20261024131715.64435-1-hedihamida096@gmail.com>
X-Mailer: git-send-email 2.47.3
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

This series fixes two MT7921/MT7922 power-management resume paths.

Patch 1 adds a dedicated .restore callback for hibernate. Without it the
S4 restore path runs the normal resume sequence and times out waiting for
the HIF suspend MCU handshake.

Patch 2 recovers from the same HIF resume timeout on S3: the firmware does
not return the HIF_CTRL response after D3, so reset the device and report
success instead of failing the resume.

Both were tested on MEDIATEK MT7922 (14c3:7922) on kernel 6.12.113.

v2: add the suspend resume fix; patch 1 is unchanged.


Hedi Ben Hamida (2):
  wifi: mt76: mt7921: add pci restore for hibernate
  wifi: mt76: mt7921: reset on HIF resume timeout

 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 34 +++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

-- 
2.47.3

