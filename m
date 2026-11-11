Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358650;
	b=C0TMZem/r7njZUSYu+P54fPocWudoJ9xAedLj01Yh0fN/F7RwQ/nUUHsN8OMSR4Dohie
	 uzMEYKPUWH9JsWK8ZoS8/EPUjt+pXpohg+cWAFnF+PabJAu3+rX3eZxJlxNdqsm/BHQf8
	 Sk5+DMJ4XOPdMfnFcm9fP1oWFP4TT/kJJtdot5LEfRpF/6HQocU9fwbYr07ju3fSM/TnF
	 Hf3lAS3IAbNg7TPAxPGvKyoXvDPopLBVHACI7SA/+ysExU3+zVokGDYfaZATOBHGK1ABr
	 OHubqwjTmTCfMuK6WOE/+eK3cXtbwjlaXAhedO/s5Mfy713z58vJg4UkXg1pEetwKKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358650;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yctLBBDrhhsJSt6YTkqxLyHF4ZdzrA5rTmwI3a+YrVI=;
	b=pP+e3M4qqPpr7fnZQWckm6ppBTftJ8fEyhMom3RxPdYUfHEvXTDWlb3C/pruklSB1j2d
	 zPYbYZU0NNRXkMioCMANrMCfnB6XbTAEr2g4dwDqyHcByNG0Bsnmx58zSuK7rEAqXBMTe
	 ttPUoSzg2bfR5JM/7eLRmftNHWtMF+jY0KS2AWTsqhFiHT14/crk2NnjU1OE1h0nxnnVT
	 K55jJCPCu4OY6toNkW0pbrbaOknu2jUOoPEW3PmklwN0cRxdls7RBxl+LtIs1pCBohqNg
	 KqKN9zNufFf9HLiPiaiE3XdN5jVkaNTHhWKZnfyu8eYETkI0N5myoaxKdN2cIJIs7Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlFiAdbD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E19606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlFiAdbD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B5E1F0093D;
	Wed, 11 Nov 2026 00:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358650;
	bh=yctLBBDrhhsJSt6YTkqxLyHF4ZdzrA5rTmwI3a+YrVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OlFiAdbDISHS17WtLPwpVmkcjHYUzDsd4tKi9CuEEMyBSwEdwl2cMQkYK78b60IUe
	 6c1nzxYCKYY3+RYesTf9kSfleQ04xR6IHktAh/wECWHjMHj/p4PCDwr4CCBHl8hQ9T
	 5SXQJdNVwwZZStCCHM8q0R+Dqcj+nabm1FAXm4Z/9f/SJtvKE5myXda7a2TNlvPgkE
	 z3fj//zsmpOHjbi59eKmSoGtCkl/6t1+sD8ANQUXgMHrFsY2w597bT3W18ioL5I7M6
	 ySTIaNrX0YUnwU1YfIT+mWYkz4kCXS5Dd3lbm1FPW69PbOuFnW6SHJYKoOCzUGEsIR
	 subuqoRDBeupQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] xen-blkfront: Fix IO race during unplug
Date: Tue, 10 Nov 2026 19:57:27 -0500
Message-ID: <20261111005717.339235-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111005717.339235-1-sashal@kernel.org>
References: <20261107054611-failed-6.1-61b6d1df1d62@kernel.org>
 <20261111005717.339235-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 61b6d1df1d6234c38a6ea7e4f58e7da035ef6ab4 ]

During unplug, blkfront stops the hw queues and marks the disk as dead,
then later during removal calls del_gendisk(). However, IO issued after
the hw queues are stopped but before the call to del_gendisk() will be
queued but never handled. This causes del_gendisk() to hang forever
waiting for the queue refcount to drop to zero.

This can be reproduced by issuing IO during an artificial delay after
stopping the hw queues.

Fix this by simply not stopping the hw queues directly. Marking the disk
as dead already freezes the queue which prevents new requests being
added and it synchronously runs the hw queues to clear anything pending.
If the hw queues are stopped when calling blk_mark_disk_dead(), running
the hw queues is a no-op and can leave queued requests unprocessed.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Roger Pau Monné <roger@xenproject.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20261006163411.2583538-1-ross.lagerwall@citrix.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkfront.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 7ad03bcd9f274..207a2ec844849 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2131,10 +2131,8 @@ static void blkfront_closing(struct blkfront_info *info)
 		return;
 
 	/* No more blkif_request(). */
-	if (info->rq && info->gd) {
-		blk_mq_stop_hw_queues(info->rq);
+	if (info->gd)
 		blk_mark_disk_dead(info->gd);
-	}
 
 	for_each_rinfo(info, rinfo, i) {
 		/* No more gnttab callback work. */
-- 
2.53.0

