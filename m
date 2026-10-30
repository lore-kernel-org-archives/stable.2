Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388761;
	b=09slKIbHDCT2wSV9zmbk1tUd9HuWopn6c4mJ5PdR3rTAMkC8YhopzFrapUd/PnnKW3Q6
	 TOPu87w/9j5HJPbdsSeHjK5D3F+57JUf7HjRcYYfYa0Da3jYrGZOmrB7slnHyafJHEYWS
	 g0m7AfADMqvxLgi5qgBDQ00XqdmZtDQEhaXjmZRcMvUsKrEzhB4nsBz35P5JkKhW7oze0
	 QGjrg8o5kyw+166oFrErmsG6+yRkHvgjAp22DkHcHCmTyOFS1/kzYBzW2TUe4Y52xvLFP
	 jbu/eh/36i0e0wg7O4t71bvLDejk/OtGCI/WnDl5DyQ9z4xKrH/7aiIPOIrGapX4oBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UricF8dhHQUK8+p9bWTkhzvIESEgdx4WPZL4PB3uCxs=;
	b=YxCzDqt3Hg1tHDXQeWCfNf62HQTMtbW5ix6YWUGD30dLN8a8pJ08z2jHHzAcJZ36+E9o
	 wmceSl30+ngrTwmDZkrZefzTDPlH2JYqYg8hvz3nyhJ6o7iBvqVCdPO8B6MhKbLKch6nP
	 3J3UgKX4s7748mcymx6it8d+3/JVQg8g5zD9hbxoh68cPFF3CWVKvAQX2E80Uj6h/1qzI
	 z0HJqyP5H7iMQCl1Kmrt7FSoUSqhnyf8LBN4D9kfDsU3qUkQAb9ULDBOjKbABPKzWA6cl
	 JvaRaWFffqkdvfvwyahezIY4Ru3Z9NGx4e5ny9ySUKNJCISuM6xzd6hfiYTA991OJBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fcnx4+Rr;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF8606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 19:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47BF8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fcnx4+Rr
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4d870d54so702291f8f.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388759; x=1793993559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UricF8dhHQUK8+p9bWTkhzvIESEgdx4WPZL4PB3uCxs=;
        b=Fcnx4+Rrjm/nDD6WRKlaJ/WARw8uNp8dwMJ8dIK2HrDazIIxcNwGPqJYgQReAIIYZp
         923FMZkGWT45Hw5bE0d3rw0vckjors7BLX52pO+3Td0x4Svb4WybDyyfL5NHykodrDVi
         JvbBN1DstKTvCagQOTCT/doNsjyybEF1DsDxMviyPE1r64cght6GZzG418wE7Ec8dmdb
         nlHm37TVAG0GA/dJCeaikSZbZyFGR+cAG7LZvVQFlMfNSdT797XvhSOgu/TDnM/qLYVd
         mVj2h+9/xRbB8hTYNpl7KHCB9g1lecWiGvIIWU/lIJbGQCMxzgsQv2a3IWkywnhCKDRV
         MZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388759; x=1793993559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UricF8dhHQUK8+p9bWTkhzvIESEgdx4WPZL4PB3uCxs=;
        b=pON0s+qFHZWbAzWKNHj4OaE7jzMvmPPDTk+FRANoSoFXh88PAH6zkBfVJCnNZci81s
         3fsvKQCgA4fkaOR38WYNMHVw700mN4Ie5p0Owrx8HfzccdoYXpqJrhTx2UpwX0YawcNT
         3x1ogiA3t6WLGNbzShgIuThqB8c92qBKvfYkgQX6uzYfhTYO6A5DkGcz3enUnoBnQW8A
         y6Q1ZiCR2wCWXckbyTQNw7MQxhHLvb2cRWtnYjCQ6w3/HOQItycf2QufclE32am7VBaW
         Bc3Uq0Y/pli3erKe5Yhsb7uht1XTVf+OnETUTmU+kB6abgb7uYqd57Edm/Ezsn4c2c87
         pdsA==
X-Forwarded-Encrypted: i=1; AKwUvByg1bzHbTYkR3EzMObfgEH8oO0xYdMa3kme3LAOjdBIe2GP/ZZsvFMV+85XaiiEY+wY5AKWE7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs8Qnzk+D09yoBze9z9znv5t3pH69VRUJE/ZXsGgnCFHU5ERu+
	w6e8bi06OCtO3AWH/kLj8DvvsPN75kUGHG+1Ax2zqypuhxzRCUbcrpE=
X-Gm-Gg: AYBFou1yHw2rw3tiaRQGY6RWaD9hy3YKwvqEEd+ftzsJoFiAYfH3wKBdwkhnmeF3uNo
	7dwmorUa+LhTLJDybSmnfyhU3iDxU1uVaJ8usuvXkz7MagTN+iX2/0U5+NdToj2/t36p2H3wCpU
	s0pGTiDNuu3ArVXiu2SeAn/Q+tX3Pqyn9vQMOn0hvwvIc8Fm9qJAb1rAT1WpjFmbs7WEMqArjAP
	LLf4uImjuCfPvrW0Uz4K2RUjkdTdlSw05QWf7dYuRslA9Wyd58WFkz9z3h4WsQYkC3amXlIMqRr
	c5kIJTukShj7k8KoyqRKaj0njLhBcht/GPzFDJBRtZoTIBafyiq+Q49Rk5miencPYaqsDF8atpy
	U5GhV/L9+X5DfcT5wFOLI3QjnbAo23FFcNbYWy0bj7qnOfA/uF8XhV9x2fq4NjhamEJUznQs1aD
	4MNDs4FIUgwUS3EheP59whVwZ2Mxr14f96FtR/ItUZKIlqGU0KbabiDLtKHnb/GbjY20W2LvFSY
	QWbDw5JE3woV696xn05rJCUipcJcxBIB32wpzawO1FzdHDFqfE7qFiuh5EonPLGjdaF21rpil+u
	CkmlQMVL2KA=
X-Received: by 2002:a05:6000:615:b0:48e:5b50:9c52 with SMTP id ffacd0b85a97d-48e6e4fca88mr7640794f8f.57.1793388758641;
        Fri, 30 Oct 2026 12:32:38 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a6bsm4799150f8f.27.2026.10.30.12.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:32:36 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v10 0/2] RDMA/rxe: copy send WQE to kernel buffer (TOCTOU hardening)
Date: Fri, 30 Oct 2026 19:32:33 +0000
Message-ID: <20261030193235.3470653-1-tristan@talencesecurity.com>
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

Changes since v9:
  - Patch 1: check dma.resid != sizeof(u64) instead of just > to
    also catch undersized resid that leaks uninitialized pad bytes.
  - Bisection fix: move qp->comp.comp_wqe_valid invalidation from
    patch 1 to patch 2, where the field is first defined.

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

