Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967321;
	b=ea4zk0/+CUeN+j/r+FEQQrdGDMZK4sFvXQJg7/rtPrTv0k5GpCwao+21WaYxZEjdi3qr
	 Wl5YNli6UaiJ/+LmoO7OCOMypV1xZ2+XVnMO5zr1uLmhC+DfEJZXHeuMlfetugqiPcEes
	 VDTX4bpejGtc0Urw7RfqvI25H819aazoBFhupwlqoX/iUpWcWBx1/FCcxG+5YKAk1OQmo
	 7yYnjAZbFIXobVCBdmHmjlWbj8YXCDI7ukTxH3F4rcmxiAeQ3Nzd9sO87e4NMxiggEzJy
	 tq5C0JDoFja6gDSwHdVxBBISIRLmHnj7vi/PyMKYr5szyPq2vxUHzAb18Ew38EyQv0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
	b=fxPBVwJKSzsCHeihr66NHtuyv0i2/bCncajGpR8vQWECz1+/k/M7MsI/Q737KQyKDQmQ
	 d9zg/ZeM+zGbbwOO+MfjUCxJdgf0i+eBYBF6KQm1E/uarhBcUWm65FMMHpFR9dJkRRWsF
	 AZYRjHxTii85QsgIUQvw423l1SR+u+RB5rDN7CcpHIq7zq+5XqFCCGzRpOz99d+fioFP/
	 DeloGzP/8L2MeIJsocfCFuk0I/+96z8y7hFWAxegDbGNQv3d91fa5Z7m0WhemM6rpcaTS
	 IMpRFkYhmmdJfis/rCK1Xkhc7STCOSCOIo89klhP7UBpcx5vcJbwxlASRFqikAbsVTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p2BGQp6s;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF9606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3BF9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p2BGQp6s
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a214af2076so16376805e9.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792967319; x=1793572119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
        b=p2BGQp6sRxjFIlt739uBkYlEfeLM4fL+afRAJwBssN/Zdn1xFqC+02PZ0ltikYuQM8
         wk9BBbPXX4/IZp+60zkCLQek/ez1LVnjayMA0ohiKnPYIZ2e4kGudNuO6diBICKum4kD
         hubsXoJ+iccN7zROVh3nOeFKebEdXp0hWaZ8Y1sJ/ThuPgNdQu6TdOAmkmabfgGb+TQZ
         434/6jSWS0dtTrlb7GdIIQDvqurz5PGVv0P/o9er2H0WWy7QrxXZ/E4FoFodYX768HnA
         zPRHfYUOdgDcCpm1bW+lyRgqrbOmJuwvzfRTf6NT0q1SXwWoxNvCyuhzjd8peBhC0WKN
         RZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792967319; x=1793572119;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
        b=hgN+JyaoRxdDSSLrfFX6HgA4a8IUuJgvSnQkKF1dMWjP0ZL244FRBML3adKO6QWSN0
         6PEcSSkb0EL2GcZNWMDu8F0RlC6p3DHrcCtXnh/3GnPr8eK+ZKnMwWp77rCkRrDmnbE1
         R2Fts3U8y17CoQYY8eC5D7j7Ag1Ze+/So4Fq255WmoPJPVeltNu9AtabXKZjxVWpXCbd
         mVHnf8OwrdrOrCGR2T5iH7QG3x8E8gKCg//5OwurOJ7jT5TL6p77eQUlso0C4FmgEMm3
         QQwxZ5uXixQzecpl0RNUSTqBhEPmQJ1e8WZX2etC259PlHoLFHl0yhohmbaQKlX1hHhT
         ykow==
X-Forwarded-Encrypted: i=1; AKwUvBzI82EixlqwlbMM9hOfjm8PxDsu1TxCxmMcm5mp4BtJbzoBqqcwz1y4IW0IKqKf+ZYU1u+tt/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcztLthW9sV7VapSUNFmKBRsAuMyxddbNwvytdgq75cxcfh+MF
	ivLp/ZGKwJYEiLhtn0af1l1HX13FV0Q75USMKwlOeluKL+etZO1cjpM=
X-Gm-Gg: AYBFou3EAzlEOHD59iBQf1P9ij6XHqar/JAkrdzNodDFcWggcaFQD16pICy8FrVH7cB
	gSNhMzXhkvzAV/rmp/yw8BKNkwBEFzjFiPzfjMgGoMujsmsMRDTBe8reS9H1W6+pSSNoT1L4QXz
	xPtmnmUwKRw6MRyRdccbeXycN0t/bRApQwFDIOAD+4wxbabv2R+9N4vol5ylbIN7YT3xTfAGcoG
	NLPK9RYZL1tXOZSQQHWjEwnz0/x7y6nz5c4h2UBACA5WHh5jZoI2qkKZKqZQln9Hlkby0vtIEv5
	Du3E279zlVGJSP9HY8C0CIsxbfXt7PGu2OK9i8onS9zCWe0v5mw/QH3+b2oqxm0Y5r0lfabg9Pr
	l74cWLgtdKcMb2y16g65xRAXXvey0UFDJiddL6KALWnhgvJLq6xLFs9u8tsrDaX13iWtWiarc+C
	qRlq8+uRI/JxCBOlmJ8I0IRgrYhTAdx2vPPWIbdr+xJXw8F4nI0lxdacr/o8Ro486WPzxawxifB
	3X4BLZr5XsAoENnh4hFVmqrXs51PCqkqXN6wg==
X-Received: by 2002:a05:600c:1987:b0:4a1:96cd:2f73 with SMTP id 5b1f17b1804b1-4a35ac3a777mr91598165e9.1.1792967319382;
        Sun, 25 Oct 2026 15:28:39 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a59d998sm156357385e9.15.2026.10.25.15.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:28:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linville@tuxdriver.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: llcp: use timer_shutdown_sync to prevent timer rearm
Date: Sun, 25 Oct 2026 22:28:38 +0000
Message-ID: <20261025222838.1096455-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179278531637.3327.11947058101101849130@kernel.org>
References: <179278531637.3327.11947058101101849130@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by manual code inspection while auditing timer lifecycle
patterns in the NFC LLCP subsystem.  The issue is theoretical --
found by reading the source, not triggered in production.
