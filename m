Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC030DEB2
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208434; cv=none; b=OYePpm55cUv3a+0Hg86uaW9qp3EfOF22W5iDV4BxnAKg8NDznfbKR+Ex9gfn+wJAlwUWuCXszPfYnrcT3QBDc85i3jZREH2kbWWjnPfTgoh0ofXxmGk040GdgbdPPUv6rPD9kuKDlIm4GkuF2geA5DNIzeADWtaH/9KsUv/VUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208434; c=relaxed/simple;
	bh=v7oBAjJMIhVfdijcfMPA9HrTDSWEC2QWu+BjAmEIkd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A85d7WNp4zwHwhgyHxrPjnEMl3ZIS7Kf5ck2McXUDYxKSzqpOa5NmpGQF3STom9JKlGxnVzztjGmYh66SnEBTMElM3byLgUBGDY2C7XGl8xVIZmUxKVJdhluIjGNbpenH7urhynlSU7/m9nGKN9aHveBP+tpdlr20eRQ3LxpeWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRpnxh2B; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRpnxh2B"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d01548ac96so204655ad.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 20:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208433; x=1785813233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ts5/Y1TVWAmyd7a1WEfthTQKByaZz802Qr0m4Iw99Us=;
        b=jRpnxh2BjD4Irvz/8bwy6eobCX7e0L+jRCNGDNr5xNpjIFNLj1gAtYzmLfEnHOD3JD
         IkHW5oViIYENmXp5R2Mffiinkz8HsFJbv/RCVEZxAWawGmTJn/70Q3jMRNoKLrItmbsR
         TJTlfF3q/yNXHbSD/efHInii8SYtK1zFy4VlLsFSawOPBgvEoYKrd8MQIW/8HzGoipaO
         yl1iE1nhUpsglenSVhM0vBvCuhKlf/evN9fHc2MO4TlqqgfhtmpQTQcRPczMdgo2aslE
         hgVxyq8Zl7oFVdlTJdOxYz/M6hTvzlh/4du4s44fb0hHvUrLPSKaVHX/vTapQS0Y/aOV
         U98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208433; x=1785813233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ts5/Y1TVWAmyd7a1WEfthTQKByaZz802Qr0m4Iw99Us=;
        b=AO2IlFD1u3i7fCA5qQm7j6bEw7csXenzw6bnzJ0zv2txbhV94h3TqjWcx39iF/TpxS
         E0XW2AIg4Zd/Jd2siQZA8gvfhiF8Me/NScPtkaAHTXHPnCsEImhbnJfaOwn+8lEynF1s
         ZRrvz6NPnyRola2KhxS+Akl0HctTl2KiHk0lZ1ygktlIb13w5aR3DKyCQa4WE5nNoKt9
         WH55OdnMT8Sb1FqWtBujgc6UdmtyAmyCVlpYJVIP00rkpeyOyfSxDor7HByYcAc8tbTg
         fkKNn9SlzMNhRO/nLEVMLo6QB79NFfkJmrBPSMXGDw2cD5i4FPr6peu4L5aYMZTcs0Yl
         vF8w==
X-Forwarded-Encrypted: i=1; AHgh+Rpx+SkYFDtHzoefLJNnZKmKO70UyA2G6JFKCOj79DyU6bNEcvy1XFrYlWhbpCmfT1uLCV0MMzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLX2xDM1JSR0YTOUBqYYETUzj79XDZ4iC6rRv9iXIyAKOjAohP
	LUdCxumvUeSRNp/6hRYUpBvAZSJDzpQQazzHPwAbpvnV4+G9grHJNHe9
X-Gm-Gg: AR+sD118nOoKidv7C6NgLQpKB6akRGFbI85u/UZ5tBmNt2wNi/470Ai/zKZYWdX5qds
	zVVTj2BfWhTEaf0E51phkph+2mwQ/R+2P8L8OOtBia/af5nkaRE8KLRDx6lE8MgiSswymf4M2dc
	ww6CjjKRWR86QJlnkyrr7mO7qWKYS47rzGAv3jh8bqJP/FefSoXzwWgi6rxdt9UkfB8DqKo3+ha
	n2lfKDs7OiEfJqLy2/rmfvjWUHLfYAIlN4pto32Dn9CShCWE8ijboNW9Z0ZD5K+H+39UmdenRBZ
	WQotG/gWKajR1VCnCOOafm/jJBk8Usvz8weu35v9Zgd6niqZoklTjZP7cYrkItgxXQY5miqXxCg
	Xlx7D5XVEZTihep7gfyPdHv9sL2t3P0+7l3kPF3pX6sUegsENLv8aezDw6mcOjAqGC7DaUXBNPY
	IE5timL39tRV5bwm2dHc9clzSJNHxT/DlhebUvH2BDTJlPe5o1Dljj1dgzYUwaVLez
X-Received: by 2002:a17:903:9cf:b0:2c9:b96a:2855 with SMTP id d9443c01a7336-2d0157926c3mr9244445ad.0.1785208432832;
        Mon, 27 Jul 2026 20:13:52 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bb13sm44311065ad.1.2026.07.27.20.13.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 20:13:52 -0700 (PDT)
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
Date: Tue, 28 Jul 2026 11:13:43 +0800
Message-ID: <20260728031345.49562-1-q.h.hack.winter@gmail.com>
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

