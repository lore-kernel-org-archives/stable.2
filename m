Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141423B9DB6
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097435; cv=none; b=BBH8Pa4zTDPcjX216dVZnFMWybqGumwtw0gfxH3ZEsjV/RwP7mI2tq8TaoIRRxFckmMFv3tvoUX9OXjseCTDoBa79O31IV5kNDUokKoIhrVyYROS0CI6x+CIgbdPDqTMwXKeG49knbGvIJxz/xrzt/2LfXN2ZGG7SPnGN5j1Wc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097435; c=relaxed/simple;
	bh=5VfGpfbLznahZqGU9RlkcC47AWDw3j0dUXkczRoMAv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJx4tj6njRj4uLYdP1EgzsZNdq4+YO+mt/SzfksI3FuAeUYOMM+AuEcFs7GFTKIvbNuH2+AEgoZKjGNbORLsidjI68O8S82lF1KpWTEcWmy0Z3MEppAxTPG8k8RTUcuUIRkNkfm52xA2mv5rYmC9QTk6YJWzKHLQOdgqi9VK9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHNmGIRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHNmGIRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A4B1F00898;
	Fri, 29 May 2026 23:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097432;
	bh=jsvxr8MEMo1EbMhjdf6gucffsPXfmPDhFXZzQ+tgUso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RHNmGIRfxEvirle6R5yHGMTWD8xzhAP4p+9qMvyUJTXk8TLfJogZmMqz5aReAdMbm
	 UgZg4e202U7Gjihan65elPzi4JF80sbSTM4YVNBGXTbTNvkf8rcYKsPLZwxborYXQr
	 nTCFDg6GR/sS7wTaeOXsYMtLSYQgQZgl++4bSfeJGqfy2/3u/8ks+0IFjH1LsIUCJi
	 LngZT94I4PjHW72+/8G9+ssUlkO8E7ZYF9bX5a47T/vUVK5sEKt9IydaVQbpVHypjC
	 TBJFlk0EnkMp5Qx3vMACl/ryAnpjf77DeOmwWtdi9iHnY8vchxeMbB1TNhYo/9SGok
	 flIgu5TFOZ8kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] qed: fix double free in qed_cxt_tables_alloc()
Date: Fri, 29 May 2026 19:30:29 -0400
Message-ID: <20260529233029.1896294-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529233029.1896294-1-sashal@kernel.org>
References: <2026052808-multitask-shelf-9b39@gregkh>
 <20260529233029.1896294-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Feng <dawei.feng@seu.edu.cn>

[ Upstream commit 2bccfb8476ca5f3548afbd623dc7a6980d4e77de ]

If one of the later PF or VF CID bitmap allocations fails,
qed_cid_map_alloc() jumps to cid_map_fail and frees the previously
allocated CID bitmaps before returning an error. qed_cxt_tables_alloc()
then calls qed_cxt_mngr_free(), which invokes qed_cid_map_free()
again.

Fix this by setting each CID bitmap pointer to NULL after bitmap_free()
to avoid double free.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc3.

Runtime reproduction was not attempted because exercising the failing
allocation path requires device-specific setup.

Fixes: fe56b9e6a8d9 ("qed: Add module with basic common support")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Link: https://patch.msgid.link/20260520070323.2762379-1-dawei.feng@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index d5a31119e3f3e..ccf2e31a5f4b1 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -1038,11 +1038,13 @@ static void qed_cid_map_free(struct qed_hwfn *p_hwfn)
 
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
 		bitmap_free(p_mngr->acquired[type].cid_map);
+		p_mngr->acquired[type].cid_map = NULL;
 		p_mngr->acquired[type].max_count = 0;
 		p_mngr->acquired[type].start_cid = 0;
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
 			bitmap_free(p_mngr->acquired_vf[type][vf].cid_map);
+			p_mngr->acquired_vf[type][vf].cid_map = NULL;
 			p_mngr->acquired_vf[type][vf].max_count = 0;
 			p_mngr->acquired_vf[type][vf].start_cid = 0;
 		}
-- 
2.53.0

