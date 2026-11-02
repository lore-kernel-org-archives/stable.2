Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600387;
	b=UFmPU/O2USzt519RewYP5s3zGcg0V51wpSKprWxHKmwuS/4XglDFCXgYo/LSRbA9EyLR
	 5r46btHt2rDuaw0kkD4ByTTYeGIQJvdncFTUx9WVQasZbxZApo2nfQGM5ZlltmmjfJYeG
	 myPsx9+1Wtg9tWsUjmTiUJRgLOhWGhxY/na8JCdmCTICPR/WQqmwV7wvVTNjzyIdMIzii
	 5uQpyvtd0ISpqG+ZCyERp8KNG9HbTe9CgLmDG2d4LiX7CDQYrVxydi3LcBn7oZL9WQgJM
	 oRRH++ZYX7ARMsgIiamFmW+mS3T0ABbSivS9Hck3ffV/WnN/CdU8fYdZzl+VwsjQzHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hhQA2nqnfR/ndnC07pGNFH3CL1SQgHrxqNYm+C24yjU=;
	b=Hd06ZixmDrJdhNRD7F1s85x71+NRSsDvXcE2dOusf5MBtssjIu1W5Zgqj8csj7ZDC3Re
	 edv0pJ0TuHsyd/WqvsWBJdDD2d6sQy56v4iM2XwIZ8TtsLLpWz6hWGPKrq0oKw01xI/KU
	 1JspPe++0aChfH/hPu1VEjCEOdij7AMV9qGPDUtghdfQg5kxWlYQqNZ5zUXymeV1BL6ru
	 yWR9CRTEyufHlK+8czsMO8ab6aVTuT6fDNyenD46cPw9kw4ukEJH7AfAb4NRzzepdpi5F
	 PvqwbuHkOt3KtOx2Zhy034nGCd5Xri7+9T7BLRIOGnlfueSIydl5RhKAIOW5KxeHUNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sQyRLgm+;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259B8606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 06:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 259B8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sQyRLgm+
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so451427a12.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 22:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1793600386; x=1794205186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hhQA2nqnfR/ndnC07pGNFH3CL1SQgHrxqNYm+C24yjU=;
        b=sQyRLgm+OdDyP4kgtLa0LSm+Ddh1xN7YgRjEbGmaDVJP2XJ/mWfWZAZ6cQXhRrgQLj
         QtQ0PA1C9XBxxVVANtsaixK2sdITqFW+ARZI4WDcrKth2//uy+EmAXh+GC4/p6r77TU/
         EVgkK5/v4yc/1W2AtgAfs0/WqIqivtXgZE5fMHHZuxc30n3cyRVo+StwSxGY76w8CmFV
         XY/Q5u2NBXDiAWlOBZ8J16FvTZ3Kz+mqUl7DH5NngnpajtukWu/XRVtqMYUMJxQzwCaT
         s65qDG7J5sUcY2jTT1O8K/1uFlkIAU34U/geHBRVJT+wNCcRJRXH5eq7MMcbml2P4u0B
         uxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600386; x=1794205186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhQA2nqnfR/ndnC07pGNFH3CL1SQgHrxqNYm+C24yjU=;
        b=jRbxjzSSZNoPVM4ghHvQRbJfej251Y9B8ZIhu65ZNrDamvwXp93nIxLh6XQpKXR4V0
         V9MwBogjLUuFlbIpFR0bhiEvgutGm/JjRP9iJgI59JNmnyyGiYdf/fh0AJdFXqmQC1t/
         8e5Oob0SHfIbQOWIuWoMuJxD+3izOvv7YIMT/9JPyggDk7F0h6812GTUbZXnCsHeCQmk
         HmrcUbxJlwe0ur0OhE0CEKi7TtyVTOGQd+5zocxHwOeb0glKYBGPI0VZQEBxuiE3nr5S
         bqVWYEDOCi+ETMsvLkv/X6gLKoOp64xYzkilWfD0mELu+4ZI34CbKZu+kYgdPL/7i6fn
         3pIA==
X-Forwarded-Encrypted: i=1; AKwUvBzZKUyjRq8ifRLmMprl9SkZGjuwDLvF9wNQlbYYL+DBvLL4zmyWD5MErHcXG270HhAh6QhAIFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rWIDZwaTR2UbxwnLTbFjsgHfYQE8i200eO+cKNF79Z7Kz6Kz/
	0OISzbr8NwjBEqfSX0tHyNeD9E2gLBh6X9FS1yxZqhO9gJiLg9ZuN0S6y7rMDYftaTY=
X-Gm-Gg: AYBFou31NRPT0VmQUqqL6V/3MVA5RM6LILUP+rn1uc57E5FxUJShc+IUpSfistx22W/
	5oCiV2017JQyTmN2/HdXr3/jLKGYMpbacsRmJforRxzBOWrc5vX7/bbBu3Q1Us3HvvzpVN4Kgt+
	CTDvPETiW63PqQAtfsqvC0jtcfmXf6gUw1XAR/t0yEVgctIrL3BXtbBhQWnFNNDwTeGzpvi9QyH
	Bmne+flML8CYBmDOTLUDHqXQ0NnQrfEbpmpK7SqKFAJsSZGt9GpDMlUyly44QmHOBzkZflmg11P
	1N7ji3h65RfCvwwEkfHup1kMbudw0xjZCEb7V5IigHYkaV64SJn0kHmOpnr3zcJ4LEREHlXyhaw
	L4mrYBRUTMdAk80UPpOzOugB8KK19Q+gOusHM13JwaM4Fuz4emvXbKiTeZxv8YWDjNXUnl/3Jsg
	7Gu0rJWFc4TzNppYKQFkT1OCxvFzqbLkPvmoec7Oc7QMMNDidwKwZQVUwFejMzbRlLyI64s7skg
	r/07kqqNCdpfsd4wnGPf3j1xl4Kz01hk4AYlMXzIHoMwPsArmsio48CNx8bTPemgY+ygqRvV4AR
	CwggvEvKE/SnYjn7vVEqXx2zSlKtKgCfeeaPFpZEZoZL0L6A1U2Pe0uaBYkIaUzFW3TSoarp9Mp
	LbaPXJun9t8qpPfaeoeztuEt4iEEUw3+ukZCG4BfKN+2tjAnUq+ojQPLA3mA=
X-Received: by 2002:a17:90b:1b03:b0:3ab:2ad1:f10a with SMTP id 98e67ed59e1d1-3ae89287394mr6957156a91.0.1793600386333;
        Sun, 01 Nov 2026 22:19:46 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:d115:e4f4:23fd:61df])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a5ecsm12927752a91.2.2026.11.01.22.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:19:46 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v3 0/2] RDMA/srp: bound the receive IU the target asks for
Date: Mon,  2 Nov 2026 15:19:36 +0900
Message-ID: <20261102061938.617371-1-yhlee@isslab.korea.ac.kr>
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

The target decides how large the initiator's receive buffers are, and the
initiator never checks the answer.

srp_cm_rep_handler() takes max_ti_iu_len out of the SRP_LOGIN_RSP and
srp_alloc_iu_bufs() sizes every receive IU with it. The first patch refuses
a login that reports less than an SRP_RSP, because such a login hands the
receive path undersized buffers, and a report of zero is worse: kzalloc()
answers it with ZERO_SIZE_PTR, which ib_dma_map_single() accepts on a
virtually mapped transport without looking at the length.

The second patch stops srp_recv_done() from syncing those buffers with
ch->max_ti_iu_len. The receive ring is allocated once and kept across a
reconnect while max_ti_iu_len is taken from every login response, so a
target that reports a larger value the second time around makes the driver
sync past the end of the mapping. iu->size is the length that was mapped,
and the length srp_post_recv() posts.

v2 -> v3: commit message of 1/2 only. The KASAN report now comes from
a real rxe connection instead of a KUnit harness. No code changes.
This is the repost after the merge window that Bart asked for.
v2 RESEND: https://lore.kernel.org/r/20261026055430.406487-1-yhlee@isslab.korea.ac.kr

Changes since v1:
1/2 unchanged. Dropped v1 2/2 (drop a truncated SRP_RSP): the floor makes
the buffer always >= sizeof(srp_rsp) so there is no out-of-bounds read, and
dropping the response would lose its req_lim_delta credit (per review). New
2/2 bounds the two srp_recv_done() DMA syncs to iu->size, the reconnect
case review noted 1/2 did not cover.

Yehyeong Lee (2):
  RDMA/srp: refuse a target that cannot receive an SRP_RSP
  RDMA/srp: do not DMA-sync a receive IU past its mapped length

 drivers/infiniband/ulp/srp/ib_srp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

