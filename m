Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92511389455
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400185; cv=none; b=f7HZWQKRY0ADpNwmYfsajcPuDAbOY8GrLYLThb/fhDXg9FocRRv2qmGJHJvBSXXHzqXt8RrU29htf8h5znkJZw6+y1WoWNbMiujOjcU7KyF3H+sDk3+PEZEtC5auiYM5etIKzUTmk9gYA6KN1bPhwyIdE+pfzfMkhgaQmGfR5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400185; c=relaxed/simple;
	bh=B42SBYl9aaiB6nmRTz1a/KnUKAuigPrYtj6ZNfBf1yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBgFIpzUOHPNivuAk+7edkJKHuh+m9xsoZ+4Y3YPjvIomGbRKmddGW2r1mO7+LA6iKcv7iacDHa+VYD8PC3IJcR4xhmQYnxBMB2X7Pgg189LGwQu+xOr1UzfIvzSoGSwpHRJ1NLLTK6TqICNUnEHGCpkzI9MB9GqMPk7wfG6us4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKvyorm3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKvyorm3"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca132e9c54aso191142a12.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 01:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400182; x=1786004982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bw64pOvp75tqjEbxe44Ni3tYR32AoO/7olUauM7iC3c=;
        b=GKvyorm3ah+QffBXR3s74KWJCVMGmLEA4+kk0g0Q3c/WUNQU49N1bNTce6OJ9v9Vm0
         Zd9v6TvsTBG3wg81kD7ScTFREJvrJPe0J9wWNAI2CpGwxCwy4dUvp5xozR8SSAZOWLCX
         RvYAsWDO+IkyshN3O2t2Etb+Mqcdn0olytCgxBCTOu6REzj3QwjwnL3qCPTqSO/wOVy9
         G/Ghsw8AX4suneRoR5XamhBdpGcxJI2QXwhj0+u76dQkcxg41p6iGiMxxg9JArxzlF/V
         39iCi33B/LJELbRiaMEWqPXoKN73iEEpZEkPS29lGvlg76NQEZ+xwFqA3ciLDeYHaFVw
         OxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400182; x=1786004982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bw64pOvp75tqjEbxe44Ni3tYR32AoO/7olUauM7iC3c=;
        b=E3YlBZzLGaZ2X2evd6AQTVv0MNgzfde+qle72kRCxE6wjkb6SoyErvGNkLc9L0SDwQ
         BsCfkXewhieVfJPogwHzyFLqyx1r5n8XGaTzwgY86l7maPTMQss9xWlVnADmV3i7vns5
         vYEnx+w+4YhsTQakzhMyVEvwNfZrBOX0gfTlWVr7KwwK0Ay6hXhgJ+dlG+SEZvWD6O51
         p4IVeiwewcc4/cU5+kg9JndwUSCC8CEdCsdb4La1D7WQP6NKG0OoMz31axC6ydxaOEhk
         6Tn7ngdWHPIdD3LZEqkp6VlLrPf/7Re6a02iMT7IO6KxosOmXRiIm7sU052YGy9ItZv/
         Y5vg==
X-Forwarded-Encrypted: i=1; AHgh+RojLlItCHpFhPC2s9UjGHciTSoLOduj4s+q0KqKlyCAybh8fYWbfkpGZPmI/y+2CkV9YvYBegA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRewpYNXHayZKJJBAnY/vJQllAHyVTpgkIInv3cMMKSVdcUXo
	HxmYgAXLkNJXsGbTvLy4ic2vg2s4DOW08MYzKPrIdaW8mfZTDU6uzAcU
X-Gm-Gg: AR+sD10X2h5RndsUCVwcfIl4Uw9ZagvRV7NzilyYEVPLEcqDWxBcksDLQaV48KZaoM7
	Rfbd4lq1vuzHiF/09rss9ugTYZcS4PHGUk7qY3qU7m0bvnElKd4KAC0zmEGIMalx3kJfVuILE9s
	qh1+zBy1iUUzRw1zbhHZO0JY0CSh/qaNQF9zJxqKAhD9sZzNRNz5H4lZUPjzKksa7FuEGMW6QqG
	my9EYv9as22+T4wLKrn9C67WUUfTSY3MPUZGrAy1mCKSR6GnUiZd++8gztR4gncs6j7TG96kJAq
	g7+Mjhb1pDuMrI2Mi5RXO8rsVBDZlAFDLh9FkdpnILcolA+UD21j++7iF74SdCbnGj+JgyoYi20
	by4c+y2AVfqi5oIxA1W4Z4GwEYStbIgmDYKFfidQbwYo2Pdf0dKM0LvwP4RjdoHzsyegKQXHTY0
	0fDt5nAamlINEcc6glUH1J1KbBaqQxuJyOCw7Jka5ztqKoXIBiViwpC84z8ipt82Za1CI3dK0I0
	fLn5eH22Xkq6r9stprRnYDPw7v8LOhm/k4d9bJnuTwN+vPIwn8=
X-Received: by 2002:a17:90a:ec8d:b0:38e:7069:7117 with SMTP id 98e67ed59e1d1-38f9bb18cbemr2207672a91.0.1785400181820;
        Thu, 30 Jul 2026 01:29:41 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b770e33sm664279a91.15.2026.07.30.01.29.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 01:29:41 -0700 (PDT)
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
Subject: [PATCH net v5 0/2] packet: use consistent hard_header_len in send paths
Date: Thu, 30 Jul 2026 16:29:23 +0800
Message-ID: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
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

Changes in v5:
- Drop the unnecessary per-frame copylen reset from patch 2.

Changes in v4:
- Use one hard_header_len snapshot throughout tpacket_snd(), including
  reserve and per-frame skb construction.
- Carry Willem's Reviewed-by on patch 1.

Link to v4: https://lore.kernel.org/netdev/20260729030122.21462-1-q.h.hack.winter@gmail.com/
Link to v3: https://lore.kernel.org/netdev/20260728031345.49562-1-q.h.hack.winter@gmail.com/

Qihang (2):
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h |  6 ++++--
 net/packet/af_packet.c    | 45 +++++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 20 deletions(-)

-- 
2.50.1 (Apple Git-155)
