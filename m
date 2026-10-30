Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379050;
	b=Lpc88+6YEjD4XU38wpAP/2VTjNhrbonJWKqqEXX5EmqA7gyfUxLuPfQxVcQbvFoU0kBx
	 9JZy4PTf84H5KW8iPAhgs7upWBD/EmIiOmc6Ujam9k0EM2bA0vrvTpoX9A8b88RHfdu0q
	 sV5PEnxyY9PtgWcjeEaQSw4ZMgDEWL4/H6va1JQPQNDeSXCLHwuRPF05nOv36LiGLLxoX
	 Lsp4Sd3aUj+vVw3YbMUMOQbLvOORoKN5vbT4fa2gEw90hs8Pgw9lR7+0fYjzvTAFy8Azh
	 6eAW74LTgxlluEwMSbkz/PjRsSEGhhLljRiaS1gaMxVJfvCuydTzo/Jju2iKtPhc4dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gzV6WXzPcFzRX8VB8o7goTo1RH2RiPQDDsNBXgNksVA=;
	b=HZsJg8YxO3Vnjg/8h8XONhFDyag1RKW/vgdE6ZvuFZEMCyws4bEgL6JD/iV6fnqwYfku
	 oO+bJoTcZVIhcpWgZTbixsh6rmnqd3PL2IbdBR6yhD1Fc3/aYXgx3HNlxUI55YoEboAaQ
	 OLnJfu2kAeHVyWKq1wx3mRNPMOU9c16tckm94Kwe/XKXs2jo7YTx58y9Th15Vq9CRqj6+
	 t5dvTe7VPb5Zel0bXPxULdLf97iZYBv+qRSrNXE1ZdeQVuXCbh11qDDPpCAWy669Dt3RS
	 Z4CFiEDwWYnowAhmz/1FJf4JOkMKzQkmQVJ9d0s1gdWPNyQQMup3+MGGL4VLgGXKL7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XqGTI6OU;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1C606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45C1C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XqGTI6OU
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso8228305e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379048; x=1793983848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gzV6WXzPcFzRX8VB8o7goTo1RH2RiPQDDsNBXgNksVA=;
        b=XqGTI6OUecTTaaf49qWDvR+vr2Vei3Sw0oVZPnz9BfHkMLJdwcL/zzGA0EGQY0grky
         uy/08+N7oVRIw9WHLIlXQ5rZ/2pyH9p1T45RNy7ldqs+VJunQVqrInsEzSLJKFzdC+P2
         04DbvXLUlhwy9vGSU469Oq5zkSdUQbkhC6owWbXuahelT2nxiAjyF1GcyLvhLNZeqlAl
         b6E2LKhFnWZlJcHLgDulwwaIiFHl4AIPHsJvP3F7sy1RB/nevpfkP7iqFIOaKcI6JGaz
         5X5GP4W5T3FLl5I21Ac85lgHGmwGpP25CYGRXkiBmKpG5iePIJiBmwk6kvldz7cJNCC1
         wCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379048; x=1793983848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gzV6WXzPcFzRX8VB8o7goTo1RH2RiPQDDsNBXgNksVA=;
        b=ELTapK4Yyp5H4NVha/+ZVdKi9wOSdotiwHwA7pEbW9sJcr+fcZBkmX6Rr3Jelvrmxq
         nQ7G3ECdYWqiN4QTX3EwX9P5WtOCL3xGq9iZskPFMPRAYEBCkaikFhBmJ4pdk2uvDqT+
         EMxwjVzJ9Z4Bq8lVfKclXbibc0lKY2AnRnWU/dRiPBNT+1xDQLEPeAZDc1y7b5t+TAqu
         KheyKzEIbtNC0VO7t3xZYqLmgNOMoAEtMpl7z2EPQJveeNSuX07rSQR1HLHx14kR1loz
         daXTTgl6pb/ABX0tGyPh8w+ZwFfTV0qeeBgLs+B8DLXH2w3pr44+7DeH9p01x2tpAYVM
         zbMw==
X-Forwarded-Encrypted: i=1; AKwUvBwZXtt6h14NAvl584YIy10Gg7x0J0DAA587UEbwaAaGqP1z8p+H5319ABLecgsrFDobFfvgZOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqKKT4FS9TTybY7PHQu/6mfgnhevJEryFSM+sqTW2ERW4SCLID
	FUfufSxbMRS2jeSPkTs0RXpZSXtLUagKWC0HPROfLs6qCy5tpldnxow=
X-Gm-Gg: AYBFou2M5FEMjhvHA0k7p7IoPKuq6bqA7Ta7YQnKndwQYNSEXVtjMJdcMf1xXIJN2bw
	oP80g8LUm85M42oSH8fjs26T7+yn0ltQDLAeFZytNAsuUNClspl/0kaxrkPZBEdV0tDBZPnoECp
	pKoTAHSn5qihE/dRC+7ADEDC7T79EwySy/94TgB4SCK4E77hyHbtBkq0Wc9LxD1zF0R3cMtxlNm
	LNRYcR+E5fh4af+qVKedxMYyUBrLwUNZ7+kf2Dkr8ZT2Ouji4cOIprOyVbnS2Za1qA0Zg8FIeCj
	fUvDMkPLRuaKjW9CgMo5NE1f1AfxvXORTMUykFs6kwJWuKjaayiNfsg0IF3hiLvXo+AUxgYcTaj
	bIL3YipYiJl/EALOP5KCSgbQU99N5m0X6XJ7mVV5+AYtn2JtnGZVGhEmFCZ1j1vbpGf9K5JHQQW
	3J2+Eoya7vlE5kkVT3tkLRHbS5V46V4GrpWbrIIH4Qpuk88H5RURPyx11QecYi3Fi2BrFE5USt+
	7TCEq9lXxLpF5BHd2ojV1g7/7SIVRa9anCu/o95LywsBbtImIy/qlDLRvDmc0fWUn9JZli4y0yk
	HUo4bbT88tAh
X-Received: by 2002:a05:600c:848c:b0:4a6:42cc:bf65 with SMTP id 5b1f17b1804b1-4ac1709b206mr69703855e9.17.1793379047454;
        Fri, 30 Oct 2026 09:50:47 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm94366765e9.12.2026.10.30.09.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:50:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v8 0/2] RDMA/rxe: copy send WQE to kernel buffer before processing
Date: Fri, 30 Oct 2026 16:50:42 +0000
Message-ID: <20261030165044.2799619-1-tristan@talencesecurity.com>
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

The SoftRoCE send queue is mmapped into userspace. Both the requester and
completer read WQE fields directly from shared memory, so userspace can
modify them between kernel reads.

This series copies each send WQE to a kernel-private buffer before
processing in both the requester and completer paths, with field-level
writeback to the shared queue and cache invalidation on completion,
retry, and QP reset.

Patch 1 covers the requester path (req_next_wqe).
Patch 2 covers the completer path (get_wqe).

Changes since v7:
  - Patch 1/2: reject atomic write WQEs with oversized resid to
    prevent OOB read in finish_packet() (sashiko finding).
  - Patch 2/2: write back DMA progress before invalidating completer
    cache on error retry, so req_retry() resumes multi-packet reads
    from the correct offset (sashiko finding).
  - Patch 2/2: invalidate completer cache in COMPST_RNR_RETRY to
    prevent stale state after RNR timer fires (sashiko finding).

Changes since v6:
  - Fixed all sashiko review findings (2 Critical + 9 High).
  - FORTIFY_SOURCE: memcpy into enclosing struct, not inner member.
  - Copy size: max(max_sge * sizeof(ib_sge), max_inline).
  - Opcode bound: IB_WR_REG_MR (was IB_WR_ATOMIC_WRITE).
  - Requester: removed silent num_sge clamp, use mask=0 for invalid opcodes.
  - Completer: validate num_sge + cur_sge, preserve smp_load_acquire state.
  - Both paths: DMA progress writeback (resid, cur_sge, sge_offset).
  - Completer: *wqe_p = NULL for posted state, invalidate on retry.
  - Addressed Zhu Yanjun review feedback.

Changes since v5:
  - Added opcode bounds check and num_sge clamp after copy.

Changes since v4:
  - Resent from the correct sender address.

Changes since v3:
  - Copy full queue element (max_sge SGEs) instead of per-WQE size.
  - Invalidate on QP reset, ERR flush, RESET state check.

Changes since v2:
  - WRITE_ONCE/smp_store_release for field writeback.

Changes since v1:
  - Split into per-path patches. Cache across multi-packet ops.

Tristan Madani (2):
  RDMA/rxe: copy send WQE to kernel buffer before processing
  RDMA/rxe: copy send WQE to kernel buffer in completer path

 drivers/infiniband/sw/rxe/rxe_comp.c  | 75 +++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  2 +
 drivers/infiniband/sw/rxe/rxe_req.c   | 71 ++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 12 +++++
 4 files changed, 151 insertions(+), 9 deletions(-)

-- 
2.47.3
