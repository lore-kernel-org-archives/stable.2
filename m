Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8F377AAD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294098; cv=none; b=MjvM9jH1OV4VZ5fo0KnjbxXAp95SczuMv+CT61CqfRIqG+R26mbKp3b2l8p1luANftt6c5A/xNwAH26TVq6Yi/WwBkvUBYcj/a6uFgn9BVvex1Xb4rj68fAQTLy0FUyAGdjmhs82Fn0q9CziP90Ms1GBpKFcsdq4GtT/xyGtNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294098; c=relaxed/simple;
	bh=QADeywbTPdfKB8Qp6OcHSYccEUAFfm+PWOQ/PnFtrK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRRDsVJ0nYyjuORm3gz9Ty+iG9QtKbbdcTYdZL4/mZDxdimxYrT3yDyy8zAYfna+4HwpDs5vcs9TFIUaMw2qpXmAcs8hOHryZYeVczt6j4FeIDgt1bMakgvFQdXbSSPuuZ1vCK6pyjRcOtlnXVsCsBOAi0zNhqc/BA/l/OVtjlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv1NXtlE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv1NXtlE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceeee8c46bso548625ad.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785294096; x=1785898896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OG4+KkePz7FqiZVxRiKijjGdnD6TtTFfUDUGu0gsNfA=;
        b=gv1NXtlEpOdhqOZwIRzBYkKg0BX7dK/nJCHZCIgnepxpFi7eDl2YFZ99mLtyGan4AP
         Ly9gMVRhFPMcl33bCrnaGRfcI9VYHvWB1HT/8NoU7phKB4pL0L2z4WfKKDdibg2/0DSo
         x4UnZHdSWhhtAliFEsHQ8vpmHXaly69E6u+lyjW7Z9CPE6yhMXyzJYXmS8VypN4cuMC3
         6Y/g8TWi9izV809sowt0UA+KDM/UoPTJrKgAw7I7/0yZAHRbEgAks2opEoDcttfFwJdi
         rzdX2tv8W3hQ3SRNZ2lNRHhgm07bjy3CTcGC3aRpJu1F5H76VgHu9P4bbV5jFXXtbYPt
         QyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294096; x=1785898896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OG4+KkePz7FqiZVxRiKijjGdnD6TtTFfUDUGu0gsNfA=;
        b=ncpAcS7oaWkpHw4yXNXt16ysBTloiHTSVBQpOapKIwST/MDFhJcRPXbWItZfo3gA1E
         aiEgoRoZR+8CYvXAJgNIFeK1yvQGC2PkR1yI3VrnaCQ78QjnR09Gb/ZgjFbuY8sRn0dR
         90lVFu1NQuoEQP7ysl0t3et1aZtTnRhNJyEN3zXKbR9Qt/98j4t/oAZabNSu2lDG4e/v
         +kWUwvHLBWKygReqSwwPdQL/Jxqa3HRKaKOMcL4VmzGKXWGUQ6STTVQwcaJpMn7nQo4C
         kJK+wvsxKdyyV2bkk8D1BWCGNxgF2w3wp/lpy391VbxUPoWPBnu2iqK3AxcqKjZBissS
         kmJA==
X-Forwarded-Encrypted: i=1; AHgh+RptrFBR+NJa4Y9HA+N9FYzvnsFVqvxJUkhR+5sg/OZoxnVb/azo26J6ffHS3XDJzbujffCJpio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HyGnikNROp5WuhNiyASBqzysFQIoycYPM9C3mMAZetMsFMyJ
	C1QCqw0kweDaG9irxT+V7I8xUF5zM9SWy63AqQZT7g4aDuGVYPV2zd1g
X-Gm-Gg: AR+sD12xaxrB3OtpB+dncIF6nZ7Y++QimpbagZrbPmcOKyShcJBpdQ0t5friC+iYIUy
	WkQ1uZ3j6XFCBKRbBu1plLpXr+qFDJUP1nbscBSyb64nVlJb8dPZCf/znUd+qSo+f2vrHS+PCD9
	CQcLQrtFsRFhysjWI5E0cgl5am5GJLLBgFjk+8E0JpRq6AGA+puYjkFKKseQoPAF2XAckEhLi4E
	0+R/YhdO6osOUzu/7V/ZZmcU8JjjOSLPw6ArKFkYuU3HXY+hKVNWQoZ4FOmmJRcknl7ZYVpCBXl
	NrLM1iq7O6dWidsM54I3zZCwgEtnSjnEYrCfpdamaEXVmZedUKksWSaf609w27lLSlPFnP165yB
	XoWszRcRFvY6aIuDofLljN1uDsuN3T0zzo1SANAbYCzipO7rHwYEZb/ntOxpehKz3at3sSJS1cm
	gbXSif9zKwfj7fHmrkJZb5YyPAAr+siNNAMRh/KC0D8qHn4UlK8SecEGAkb6KibqjN1EndV+Mqz
	63WCDiH5twRYorX1Usp5yQ1xuM+n+k7jGBupN7cpa1YU3TdHiyjQgIGaaGhduE=
X-Received: by 2002:a17:902:ce10:b0:2c4:397:dd7a with SMTP id d9443c01a7336-2d015c54f1amr44563625ad.4.1785294095995;
        Tue, 28 Jul 2026 20:01:35 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c3721esm4097385ad.77.2026.07.28.20.01.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:01:35 -0700 (PDT)
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
Date: Wed, 29 Jul 2026 11:01:20 +0800
Message-ID: <20260729030122.21462-1-q.h.hack.winter@gmail.com>
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
