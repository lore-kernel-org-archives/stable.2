Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679992;
	b=T+9oe68+YzltrRVu4H4vV7R8+gNGkdOETmD44wLZY9u+fiJoBhX8V+Hsq2OPZdX/9tlH
	 OU+IjYPy2J5JOsyCfXuZrzhd74SGZd1xTGFShZiE9TFUsZ1jUnnuNfsVFC95qRPkAtizq
	 zEgqpFFfq4v+1koqrZuC1e3myESnJ1gI4DflckEapWaCRuEB90cqdF5hezlhZremBbzyN
	 Ud3oyUVjEkjmljPcYT3p/x2iKjwL9p5+JL8kPO4IEfpPEGjImnT4Mqy+dg+weKj4FiXAD
	 Sqt6+r0i/tcCBmt15SwfK+UJdBOiWRebeutRLsa1VBOiu3S1R0+KFyDKpTs23T0c1Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SOI7yT0OHrSyCHbtS6CSym+qiCE7LQk8h/07mNJ/aRI=;
	b=lVM/mlqKCu26eSSdlkNNMrs0e+rnuvnh/OT8aF74hAu/4g7jfb7sjr4/CmRy3b8j1ZNq
	 JhA7j8Gq9o7YuBrslisqRL1RsjsMai6Oec1+tljOMYJJPpxvHJXeRNX2Dnp0tFjX5rK7N
	 c/hEHMgypgL8hvACTQ/yE2E0/KyOc2ICxrIWDGsDHviXye7+Cb/EBUqtDv0bxtMSDk8Rl
	 G2+PTc9DnZR/64FHo8qTcB53h1TT9bI9AkM/LGtLhNb8+Cj8gYYFKvsC3NjzFJmenwNAs
	 mxeXTtaZio/Bi/ODujZPLZPfRpNWFOUEXBsDe2aHlZYs2A6A/PHJkOFF0QHMG/mkQtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="HPC/DVkB";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847F606A322
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3847F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=HPC/DVkB
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1141821a91.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792679990; x=1793284790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SOI7yT0OHrSyCHbtS6CSym+qiCE7LQk8h/07mNJ/aRI=;
        b=HPC/DVkBo4HcbBXil45ZFefmZkRsZyJkf3WYjjWDRzkhswnw0IxNmsVw/vWBCZmtpL
         GfdrFrThBDAB15NBTdsVsGxhZ49VDftZoWjPsXHPPXBQt/bnhHp3WHvZbjWolg9rrmJb
         rVJx8p+uCVT1r+6J+5jrppkkxchpu8L6zqSdMJk6rSCThBnfXMYWZBH4a9V220QNexTi
         LTQrfnJEr0ZCGQ/4+GEqCOdOQgA2C5MDpb6ncaOU8rrbCEKr0gcP/5qr0F39vqXTyyvf
         TCSwVfEWwVUqRPS/v+ao7k0KAHkCrAUTaz+4BH2eGa7JqttC+rCRT3HVbHDfoQDfEKKQ
         CJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679990; x=1793284790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SOI7yT0OHrSyCHbtS6CSym+qiCE7LQk8h/07mNJ/aRI=;
        b=dolg/xQ5A4Bx2FVehLyQ2yMilzStGNXTfp8vzt9+ILTp1VtI8cNjGbIo6n9N2FUm4v
         ed1DCWdqA05Dgmu1gcl3aGoWotfV3fvBvGtpd1lb/IUS2XBvuAWrIcp9/avSLEfRTT70
         18RX7lEnfTtzMhR42ZP6vt750yFTdWkvKuzWL9bbX/L+rp1JdVQJvq2ZrBFyVVIZ9Amw
         47+B3i19DrSKkHgRSBETKnSevznpZcdLbFB+KZyLjlhi8oOkJBB75fWcTbIyEGw4+ItH
         rqF4ptWR/tlkkmTqSeNcZZ9anwp+kzNYMU05IU0kd9LKOri0w1OseDT38JpnBu41cR74
         GMug==
X-Forwarded-Encrypted: i=1; AKwUvByHJUxm9XeiSZyrArUqKJ+XXQJXl1VujWxZYYSFM9VWmxVY9yuQL88TyeafEKKwoG4OM5Gq2lM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDbHC11+QnMS/8FTp9u1s1KJi6zU9WhcVYRh1876mMkwM6gs1G
	FR5zpU9BMDdw7eo3s0Ak1NQIkNHmZP5LJRghTijKh8hD0Qzc0Kce31EzhXTOGDXHP9g=
X-Gm-Gg: AYBFou2U6mht27FFUv6+7ttn9TJIMVma/z6g2uWqsVNO9H2tGcu/SJLtXoGmEomyLbJ
	kQ1jAfzM9XFzbR/xct3JMgvMXFgipqr9h2sjFhwBGacDTodudusze9zqpSQfTWNootWZramH12I
	XPZOcXWbeFJinDpv7OBB/yNOJ/F4K/3pQtdb0KzJTwQkj/Z97y/e0JtraG5MFq5Mj6O6FWs0A1e
	GhChQP8IpcjC0rZ9zdBrsmih7eV0ZUu0VlXvkI/kAw8T7inLvENrKUERGAQzv9WD6h/PBQOexV6
	ur9rkgLDgql0tB0qBf/yL9Nqm/YxVp0W5K+puza1zkkHqfkYb/nl0l+vt5XDSbxOZ0500H/0T9Y
	dA5L40UkZ8NSQLDnAZpXA8VY7yJqV8iLB4ena3EW0B0jBE9zts1gW5KmDe/q1kZVv0f/R6OFAeI
	kQvq2rbmv1EE6MAfmfBQCYmvqCTyQhRluNMbPb4QarL3uMKLjDSbPNekyVLeMYQILAZOceUxWIy
	ZLAD0YYXC1UHRAOWtlDVCogHGocNUHf4JAUhDu6DShtuiViTF35SxOddJo52ElYSPWy8uSpQpnU
	8I4=
X-Received: by 2002:a17:90b:1dc1:b0:3ac:80dc:f407 with SMTP id 98e67ed59e1d1-3ad86dd7f06mr4369996a91.60.1792679990283;
        Thu, 22 Oct 2026 07:39:50 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:13e0:b266:5a7d:e119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4887669sm4719043a91.2.2026.10.22.07.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:39:49 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v3 0/2] RDMA/srpt: fix the indirect descriptor table bound and the context counters
Date: Thu, 22 Oct 2026 23:38:59 +0900
Message-ID: <20261022143901.2991062-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
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

Both changes are needed, and they fix different things.

A 510 entry table fits in the default 8276 byte IU when the additional CDB
is empty, so the bound accepts it and the counters then have to hold it.
With only the bound, a conforming command carrying 256 or more descriptors
still wraps n_rw_ctx and leaks every context it allocated. With only the
wider counters, a command that sets ADDITIONAL CDB LENGTH to its maximum
still walks a descriptor table that runs past the receive buffer.

The two defects also come from different commits, which is why they are
split here.

Changes since v2, all from Bart's review. The two fixes are separate
patches now. The widening patch says that n_rdma accumulates the
rdma_rw_ctx_init() work request counts, so it can pass 255 with only a
handful of descriptors, which is more than the 256 descriptor wrap. The
separate descriptor header pre-check is gone, folded into one room test
placed after the existing count guard, because the header can never fall
outside the buffer.

Yehyeong Lee (2):
  RDMA/srpt: bound the indirect descriptor table to the IU
  RDMA/srpt: widen the indirect RDMA context counters

 drivers/infiniband/ulp/srpt/ib_srpt.c | 12 +++++++++++-
 drivers/infiniband/ulp/srpt/ib_srpt.h |  4 ++--
 2 files changed, 13 insertions(+), 3 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

