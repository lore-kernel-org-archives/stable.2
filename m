Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1D367B9C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294071; cv=none; b=GPrgM4yFAno9WUnhqOcSz7tOFFeC+gtEZ8y1F2pZKp9DYfivuBMKQp3VAAQ6Y/kCQfoLnBWTvztiFYztQ3NNqCV9SUq9/dYX0I0a6fWqSQJrebZSDV9CoigDpYCNr8PoWcB3gzR1xKwJt9rFY3/kdBb8yOgEIsNIxYWL9OXnYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294071; c=relaxed/simple;
	bh=QADeywbTPdfKB8Qp6OcHSYccEUAFfm+PWOQ/PnFtrK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ui53B3DiMNpgSIgdannNTHRXnYrj+Y1del8M7vfxI2r/RsG01/lHNvoS+cX5gdU5cuuLDfPeS0lJswE++JnqY8zH7J3mT14jRKPeWkKW8CWCrKLSFYf3xhtpX/ocDeDkprtiQjDo7W82Z4M8x6vyv6tjZtA0nc0/AlhzOgmBHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfABCdKF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfABCdKF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cecdc24b1cso79155ad.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785294070; x=1785898870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OG4+KkePz7FqiZVxRiKijjGdnD6TtTFfUDUGu0gsNfA=;
        b=bfABCdKF1X5u1rvpnwEtk3LNgv/n9zXufz/o3Ort5I/pq0AHnokDbemxXR+Pio8s52
         RaTEi1rJgC6NaBj9LpIal97z5SQneQykMuRpOQzk5uf7OcaHwPgK8Izd4d9ocZ3+tHRb
         EDWFRLFe2lRAg2XVbC+JWyigs2INIwK8ggxpGL1+f3yyGOQTWxQ/5qHU+QLbFFXHLAeW
         +wHMeCOlxmzR9lPJ6fMeHkJEwkwMxmgj1qhCK1CF5C+sAbFngPchTaV2FPxyUC+5cV++
         7ocoq0xXPzjUnvmTfcVJU7GQAHkchnmII5TmP/RXZjEW7C3xoL0VZxGqhAcGm1IF7bW2
         5f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294070; x=1785898870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OG4+KkePz7FqiZVxRiKijjGdnD6TtTFfUDUGu0gsNfA=;
        b=dLEscoalr+cohig1Ei88xBVD0JDOGMZutktqtzBx6jGTQsluhSl9wExaPilX95e5bW
         tDfBPIkKQYPrqorDZYZHnjOHsu6W/lHUnFnClG/QjIImxxi9n/e6+Pg5EUbxlX3rXpVq
         PXSB711zXOV/ZuE1kKb9J+VpuKNvBZx+KPy9r5VHhHa9FBf+dPPzaHg7dnUsw3hh6UBO
         LvJU0ymuYQ1SIPsRbx88PoACyB5nbIZtuLmaf1QmaBuOl8sHKwuz+n3TBlnP1yN8ixAZ
         KjU847LOQfATHGERpVJr7gqnrdNDtBEF8YtC5vPX/OO0QQFLa5JbB16KROasU7mxbdrO
         96HQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwRbKrljLIP1PiSHLLiY6qeCT96kGMQtPN+2jXEKkgmW50thjj1K5M6ei2GQHgCcKkB3yE9Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgvd5vFQZMeY+t+s8cjVMHIlNjpq1pOgMf2hpEfw6gWppQWV9r
	LFiG9Z8EuW741YSPhIOfC1iyxsgEg++qbUPdBpzY99fYOnjq1a+YwBBU
X-Gm-Gg: AR+sD11wXC9PfyZA9Dd6pnXwbG2ZLg7+kgQ1DVmbmuBRn+wbAoapd+68O6O8wsOgSCC
	u84abqs5LWoP9gGVvgLMtx41Nj6RY7zD5z3AMU5d0pPuz7OfqkjAIwE45gMbGrZAdYaZY15ojeQ
	K5rhzwoN7fGygFF99CUK8Q+RDH8Uijd9oPkiBOB+Dl8lf1D3PjqEZMw/m5sAYSpBjYnuzbTLO6j
	A0Sgx8/qWewlDNglul11QaDOagteZMC3JxmgHMoPUgT4p67BG5Z/XMfK9qXzXDWWIX5/WKu9M33
	cEqX3SnrQnwnUazCRMIw//UOhZ//cmklZN6kl3xyhXw8UvcYwQZXPUudzDXgKG78zDfPOeAAGVd
	J9Io2Eak7d/2flmufnzf2SWmEXe2k9CPZeM6ufXs/TiHZ5rFlTQHDJW3+QP6RxCIeLknZJvawS9
	D/O6TrreGhAsgd6LFolspPC9Iyzu+ADuT2QGyEbm3oeH4fmzXUkEvPx3+L85xQ3ib3nMyBhnBXY
	mxT5UhGn28uN8vZau0WoMmxP69Vs9+hHt7fZmX5MCVFpmXQNaa7wKqoBE3e7hw=
X-Received: by 2002:a17:903:2f07:b0:2cc:d6de:d58e with SMTP id d9443c01a7336-2d015c2fa1bmr45167035ad.4.1785294069801;
        Tue, 28 Jul 2026 20:01:09 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf4bfesm4086165ad.58.2026.07.28.20.01.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:01:09 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v4 0/2] packet: use consistent hard_header_len in send paths
Date: Wed, 29 Jul 2026 11:00:53 +0800
Message-ID: <20260729030055.21334-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_PACKET send paths read dev->hard_header_len at several stages of skb
allocation and construction. Concurrent netdevice reconfiguration can
make those reads inconsistent and cause skb headroom underflow.

Split the regular and TX_RING paths so each patch has one Fixes tag.
The separate SOCK_DGRAM consistency issue between hard_header_len and
header_ops->create remains outside this series.

Changes in v4:
- Use one hard_header_len snapshot throughout tpacket_snd(), including
  reserve and per-frame skb construction.
- Carry Willem's Reviewed-by on patch 1.

Link to v3: https://lore.kernel.org/netdev/20260728031345.49562-1-q.h.hack.winter@gmail.com/

Qihang (2):
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h |  6 +++--
 net/packet/af_packet.c    | 46 ++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 20 deletions(-)

-- 
2.50.1 (Apple Git-155)
