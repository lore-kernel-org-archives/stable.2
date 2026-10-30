Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385252;
	b=GjN2k6SR+N3N/eZ9UGyBBCE871TW3Qf7E6SIP0ky8INQ6d7ZB8BOT6RWzkQgq15aByAR
	 +iKLjESOHvZZZwLuleRFvMBUPf58aeIQBCuAmJUl5CQXO9Q276vHeKFO6uQg0uFZj4WzA
	 GDJXel3RJXYYN7Wle1rkf8KOSz/AAI7iTPP5bbYsBADwejtpJ74vKqrC//QxYlzF3WzDi
	 uKtC7x94njCdZsMX1euZpbS1htRcPM5JD+6so/Eh5wDXEGi4it6iCryGs1U/L3mBmqkJ6
	 mlp1qPxTf7Gu6EsDEt5jdjFz5Dj/03WBMexiRUi0gCT8ePbwqrjgMPR1vXBk7Xd+v7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=or/hcrtFhExIO4tP3jPbR5S7A2yzzhQGok/N2Gaa1/s=;
	b=y/BT/wBZo0aiZEz8GGLOLaxN4AHVxaMgCKEj3hYfPH9bib6hKN7o2/zUNXBGfp0Iwc0I
	 ZMOKBWvXdm1FCvpEGkA26b3THWLzTmOD/yifyWXjBW0NX3VXHCtz2ZYJJ6wX9+OXM5mgK
	 43Qn6hXBVd5B+8j6x1AGY+zcjhnaOoJOslgfm9YnGtno7uyToYlMkDeok1QkpyDOUq5sL
	 cp8ZmONQHt9up8RyWPIdTmyfQOU4XuhN5Fn1jsQSV1qHslIvOchpqOWtq3hpn60OGiigR
	 EvSCsBQ2GRxUtFHffNdJ8n7uD6qs6P90OCSo3nAPQSKQJtJYYsN/YDfdew46HmT4A0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Iks3YX2/";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1E606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64F1E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iks3YX2/
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so8493165e9.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385251; x=1793990051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=or/hcrtFhExIO4tP3jPbR5S7A2yzzhQGok/N2Gaa1/s=;
        b=Iks3YX2/0EiBYpxyRq9L/+JpAh+bHfsk9Ggk4ukRqOCtNBgh/yBwrfZGim1/R3oe9q
         3yyd+xRPlNqupipQRP14UnptNdOpAD9FrTyheW7gQYXffUddQoov7wpu4d1+LBpI8owP
         XR+ZElHljH/+LZbhB/adYGkKbDqxYsksqBZOEVY0Tpx/KR8H27PvTfVR4xUwRNrq4LW+
         UEpDuSMUJ1gykpC85h9FBkqWPrgq/Moz9MuDxXLr5YOTC1dQ29BsZlN9TEJ50j+Whspz
         uuoawIk2OIL/sveoQdA0VreCFJXKatLvpWo9Uuf3pPVZ6lWTYz7jyTgKwz8OZ2O2NgNS
         3wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385251; x=1793990051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=or/hcrtFhExIO4tP3jPbR5S7A2yzzhQGok/N2Gaa1/s=;
        b=vXXFSkv2+Rx+/PBV7Yl1I67Qbm8wTHMZ6nCKdp9xM04JvDDWSsuDfwUBD4dTzGaryE
         fBbiygf+Ep0yci4Ud0QYtToxeV/7vYNlZ25Rv8OVZO9KeLKnuifFP6hIU5kg8BgOY4k8
         R1y7e8QcQGmpF8u7hNTZxfxMHy5nSMDcvLSgNH9Oy5vX1O5P1X2FczrIvKMp1Dsife8e
         GdplpEcU7UG+EyBdq0LhMjKyjYMTjdQEPvbdxVXw2I0wFabb2888u+eJ+UeG6XdiSiP4
         uC6aZORsD4BwVeVldr4WTd0btASTYV8u2Bt88XwqOd4pb29PtPz0lASbVbCfiPFJpTEA
         53sg==
X-Forwarded-Encrypted: i=1; AKwUvBzEtUZ8vYSUoiEx/H8s8wNSWkR4yO57vlJl2DgvxfBAfLlEGQiP5iqmYoe09tE7CvzzDZj7PZg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvveWUdj78YlggKLpo6ZFQw+pIOCPH4bpeR8N5ZiRSid8zOrrC
	wbEH9e0fCkkcBEnqgXQ223YZRPRfTy3/dVTIuvxqrK/OnY1UAUgSKvA=
X-Gm-Gg: AYBFou0DX6MqOpRIjTmzq1s4zNy7H3suQs9HzfWxTTQbSE7qQSh6qixjRFXsjKvY8M7
	v3uRIVym06sR1FUNxmQH3aLt3X7FAuuZ/4sJY/gFVlZrl5+OnCX6TGpJZOupz4u7IgcoyMHHQUk
	CNe1D2z9Bm85S6oryS2x/1hCl/B93R3g9O49WtW4/zVqVivSoDOdSUT3bG2YQeQon/FTZe543XX
	09ZHcwEWWD37mQqnOYeyYcrLbV/S9HBiVK28V+iakyDMtkL+xr5DPwGJTS5xPF5JSLlPdo1S5pk
	p9VhQEGfiCaeq2oCGx3f+45ZRcoUtQ6e2jROfyMBBtS0eFlJRM0FxM2befnzg3AO6qbDM4wVLqJ
	3pOAKf4sy/w/H3rwkV965uPUFP4X8/OJlIuwFjCtB+GdlDeYWtPDVL480JosdLB2Iv8HzId957V
	vkKdM8CvwdQb94eHPImDXqxGVlCC+3Enm/gJz2Uyf7s+gK72JFUYpHR85qWe2BK6tqHPVIRPj/m
	54KvuWYbnUEz1aVq9ZOv601f4oZ47JdoYcUu5YxpvwGrVdDEkEGjVrPzXoWNNRzH/P5ul11Htlv
	OsLbk00zTa0a
X-Received: by 2002:a05:600c:1c0f:b0:4a1:ac66:6059 with SMTP id 5b1f17b1804b1-4ac19233381mr69475205e9.26.1793385250702;
        Fri, 30 Oct 2026 11:34:10 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm114204175e9.12.2026.10.30.11.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:34:10 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v9 0/2] RDMA/rxe: copy send WQE to kernel buffer (TOCTOU hardening)
Date: Fri, 30 Oct 2026 18:34:07 +0000
Message-ID: <20261030183409.195671-1-tristan@talencesecurity.com>
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

The SoftRoCE (rxe) send queue is mmap-ed into userspace, allowing
the requester and completer to process work queue entries (WQEs)
whose fields can change between kernel reads.

This series copies each WQE to a kernel-private buffer before
processing: patch 1 for the requester, patch 2 for the completer.
Both paths validate opcode bounds and SGE indices after copying,
preserve DMA progress across multi-packet operations, and write
back updated fields to the shared queue via WRITE_ONCE / smp_store_release.

Changes since v8:
  - Patch 1: fix atomic write resid check -- use WR_ATOMIC_WRITE_MASK
    (WR-level) instead of RXE_ATOMIC_WRITE_MASK (packet-level), and
    clamp dma.resid instead of setting mask to 0 (sashiko finding).
  - Patch 1: invalidate completer WQE cache on retry so the
    completer re-reads after retransmission.
  - Patch 2: write back DMA progress after each intermediate response
    packet so a forced cache re-read picks up current progress.

Tristan Madani (2):
  RDMA/rxe: copy send WQE to kernel buffer before processing
  RDMA/rxe: copy send WQE to kernel buffer in completer path

 drivers/infiniband/sw/rxe/rxe_comp.c  | 76 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  2 +
 drivers/infiniband/sw/rxe/rxe_req.c   | 72 +++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 12 +++++
 4 files changed, 155 insertions(+), 7 deletions(-)

-- 
2.47.3

