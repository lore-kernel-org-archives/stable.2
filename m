Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5E31AAAA
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208269; cv=none; b=gfIX48pZSxZ+bbUOdUd4mX9owSWNbOgdQUKHkpvOeXIKqp4SPCwbOg+lUkZeIeKtgc/r8s5KIGIDXDToMlCWLIdhh8sWx5yeZDjEaDK29CZ4hKNcW4AVVgk4aAZnFGVJG2TR+wU2rQDJtanBs6Co0I+8mNGe2lE/9ZDFycvfhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208269; c=relaxed/simple;
	bh=v7oBAjJMIhVfdijcfMPA9HrTDSWEC2QWu+BjAmEIkd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwAxz7zRMGIoyULGUEjaUzjznwKI8FsgjvXqdxrVT9M8MNEmnRrd8hOqawvKMY93YN/ZPPNCkgpLRGPWVrDjTW1axU6e6fXWM1mDy7dW5uEWp0FCfObDXy59BXynKdo/d5OcNoH5DjoHF8LHpmhNZC3ZCl2bwJQt7oLi0trxRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxhU7aSB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxhU7aSB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e252fbb7bso228863b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 20:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208267; x=1785813067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ts5/Y1TVWAmyd7a1WEfthTQKByaZz802Qr0m4Iw99Us=;
        b=cxhU7aSBNN+wxB3L5ZBNnm2fTXbC2E557Nc9xgSUMjcyabWrxAPWFgptQGOaD1CWQG
         cP2EwNbo8+O5olnpSVL23H1zmZuCgu4j+7oB5J3tU+XMV7x4Z0mU+bvRvXEloMi52NRE
         k7u5mHIyHkJE5dqQWjW9Kw1K0OqBeOsWtTnSjX+QDl6obMl7WaVofX/HZaPvMvXTtC7A
         +x0rNXZMDcXuhnuIdHrOO8EYSUna8hBWgd0jCPixb3iRd3s8VjzXkFf+naxslr5gfqQ3
         Xz122+/IHJMlw9B9Wfo/MQkJ1r4BKxIxzA2xgrGcGL6xE+wrzddESM93An2AolfIq7Nz
         lAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208267; x=1785813067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ts5/Y1TVWAmyd7a1WEfthTQKByaZz802Qr0m4Iw99Us=;
        b=jtxdiaMadghFwgWMGsE+jqAbmkhk/7D67FUeno+soIM1m+ws8vubIUDpkneSdeQxKQ
         DSTQko6XxTq639rXEvSZ6hAt0qdRJqtLUSrRrK+JG27lyX2tKGdYMHaQwe+1ujQUsC/T
         Q+Kx6C/ygFFO+aOLfF/3XKzvkHa8LRFf0YkMJVpyg7Xd0OjntVykvOp3dK1TSgdBHjcZ
         O/ejEOK/NH492GhSOKCAdWsBx8gVSwLFORylh6E14YRUAaRtT+ex46Whlw+gzwtVq0hR
         PX6fHY4yngVriwJFDO58+WYs1bkXxXSl5HQFKPYwniLt1kW4zfEzfZCQf8R6TTWRT5uw
         Bzyw==
X-Forwarded-Encrypted: i=1; AHgh+RofLNSjYpREmxK/G/l4d+U/qX5X2Bq3ZvU3/Av22SmVx4UN8UBGyyPm5K5P6aJcyG5vokW5tGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza120VkuUZ8uPfz6pf/PDkiNoxkSAAkmF90WUGoQZJuKvBI/5F
	qHYO83hkOwyKsthRBpA91Yccu9DfpU6hrHnQXFTvGX7vrq7Kg5jUPea5
X-Gm-Gg: AR+sD13vgG2aa9BRbWBp1BI5ryd73pDCV41zqBZbus+jad4eZFh9nazkatnIlnDpmSH
	sewXhTUqFFX+wsq2lOsJG14y93Zk22MEK8jU4va4yHjhL7JqysjRC3OwPdCYbcpT8Cpx+woETTe
	Tu3CfNjtkjWhMqppmm+3Rcmsl+Tve9NAgfeWs7KOgXX/lerOzpoQKA24sid8VxYIw78ud+I1g2I
	y6xEtjgjXCg+kVhrTA6SBzd2+q6LUNrkAv6hxeT3u1TybFfz6UbiRzbW9h32CFZ9Jg33PZYU7t5
	/9zC2fawl5XwZGo04gn85zRqolpX/eqxciIf9zKele7isilAp4n8GjU4pwPIY7BRuYd2l8WAqXo
	e3rW8GaLwhV8qDdO7GTFjKIOFScqrs3jXWcb4qkYu70zdyg8ylOyI1GHy+8MBvmkp0mfo+FpZJ3
	vSq2GOOhpP3geZM9Lvxda+r4wwSOcEWsEsOJiqNAMZbxmORaNOrSOtlIgPwBuefiYM
X-Received: by 2002:a05:6a00:2302:b0:847:8971:87d8 with SMTP id d2e1a72fcca58-84e9335ee6dmr364413b3a.6.1785208267429;
        Mon, 27 Jul 2026 20:11:07 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53470a92sm3709432b3a.60.2026.07.27.20.11.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 20:11:06 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] packet: use consistent hard_header_len in send paths
Date: Tue, 28 Jul 2026 11:10:53 +0800
Message-ID: <20260728031055.49375-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
References: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
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

Changes in v3:
- Split into two patches, one Fixes tag each.
- Add LL_RESERVED_SPACE_EX() for calculations using a saved length.
- Use int consistently for saved header lengths.
- Drop unnecessary READ_ONCE(header_ops).
- Snapshot hard_header_len per-frame in the TX_RING path.
- Reset copylen for each frame.

Link to v2: https://lore.kernel.org/netdev/20260726092110.80185-1-q.h.hack.winter@gmail.com/

Qihang (2):
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h |  6 +++--
 net/packet/af_packet.c    | 47 ++++++++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 20 deletions(-)

-- 
2.50.1 (Apple Git-155)

