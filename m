Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73353D47A6
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142600; cv=none; b=fr9K4D60cCqxkul3dE2/ZeIQBaMitYRZdzaq4wq5us5LVBehacMjwYnH9mMNcQMPBEcTl/2qCRS/dRf1a/X3C+qZUK8BRbkHcRA3q1u6KAxD3d7tSdDq/MKPRYpUgRftK0tZE2OSoqNaW1vdxp+PKIGCiLlZXFVKdInO9JL5fTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142600; c=relaxed/simple;
	bh=BvrofKwocSbNuq7sTD8fYFKd6S6sYIJHjbO+8YnCr5k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OiBUA9qIOKSyey1xhJlZ1y1hFAb5R5mFpJWLqEQMT/Ln5rlertN7fvKBbfykyljy0zKAAZ0DvfLQhFVE6Zuhcksn1PSBKNA9su8n/kbZtA2s1nV/tGdPhjaD9KLKP4d6ZQgKtPVUKHVTp9tAwyeq+edWi0YKFqfYVBSeQ1SABqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvDRhDTr; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvDRhDTr"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8485d853b08so82510b3a.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 15:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786142598; x=1786747398; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ykY5mhg5szJc1ECW0sXmdh6ZKDvqOwzTKdzjZudBEzY=;
        b=VvDRhDTr1cUE74vLgZa9QYSfo5dRSs1KVh5zqKmnLpACFcjxUfTjNzgSreUqR2tgvu
         5XfOLDJcEG2x2KwTkoYO8lN16kOKWMDBp8VAxSR2loJYhSyMWPV91w+9eJBn2vElLDFZ
         YSN/PxGHoMBFvXHn0OWSIUOh4XM6rP0v7YsHmcBKgpfeX2PTKOFyHwh+zSaybKA5EWFP
         7DRcx7itknBB7FL6e4S3xwGB1pTwUe3P1VJZnXSEM4USz1YShf7RueS3/zKhMNO7PQQ3
         o3b1MJqZp5eMDFZNqgkfnB6M9dGw/9lpRPDZ0vTISvF63VE7rhRg1AlU+BOjgao77U/N
         OXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786142598; x=1786747398;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykY5mhg5szJc1ECW0sXmdh6ZKDvqOwzTKdzjZudBEzY=;
        b=Jyp+HNDnKW2HrjUKugHLq2McNEKpmgoMjIYNYsyUhY3etdbm30OvrTBysL335/cBPC
         0wthZAWolIpivKNxm56hpopNmNxXWQH/XUTbK02LchbOkmfEEJyf4KgSqgmD3Q+SEY4Z
         XmIiGxct8oJ5VQGwlNyfAEiJcudJ7a3oCN22ib2OKj4ei1udy92LzjyejkQ2JH4yVfwC
         ZMUDTLniBNsS6j8ltGsan/X3BhSQgq4Zauo0wL+DeSVdlAX9AZ94A7lPVepl3lB7Uny9
         U0o1RpqQ7XiRgODnYMeP/BVUHvXWzyRxq7ntYR0IeRANs/6ahgobAkYi7DTGT5tWB9b1
         nqVA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8P+3laRejNxUYB5qA4H1Glc8T7KXTYULdDupJkl04rdON5/ZU5CcZu/Dy1IwAEkncwahvEmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynkiWf+qvrowT+qrL8pHknHBRg/Otk07U4z94BX2KDX4sKckvG
	mszpaO+vwyOZIH5lRLBtIaWkJ4FMczO+fp3oZHjxnFKKbz68OVPGcLfrVmNRTJaSv+VBZBkXcPD
	Bq2IkvESrh0zZ7YktQ6Yzm1GO8A==
X-Received: from pfmy18.prod.google.com ([2002:aa7:8052:0:b0:84a:6fe4:b6bf])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1821:b0:84f:21ba:54e9 with SMTP id d2e1a72fcca58-84f2e0dbe2cmr28795655b3a.38.1786142597834;
 Fri, 07 Aug 2026 15:43:17 -0700 (PDT)
Date: Fri,  7 Aug 2026 22:43:13 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807224315.234152-1-hramamurthy@google.com>
Subject: [PATCH net 0/2] gve: Bug fixes for header-split and PTP
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, thostet@google.com, jordanrhee@google.com, 
	ziweixiao@google.com, willemb@google.com, nktgrg@google.com, 
	pkaligineedi@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series contains 2 bug fixes for gve.

Patch 1 fixes an issue which causes TX timeouts due to HW detection of
an illegal descriptor. This happens when receiving header-only packets
with header split enabled - this produces an SKB with a zero-length
fragment.

Patch 2 prevents a kernel NULL pointer dereference by stubbing the PTP
adjfine callback.

Jordan Rhee (2):
  gve: fix zero-length skb frag with header-split
  gve: fix NULL dereference due to missing ptp adjfine

 drivers/net/ethernet/google/gve/gve_ptp.c    | 6 ++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 5 +++++
 2 files changed, 11 insertions(+)

-- 
2.55.0.679.g6767b8d81c-goog

