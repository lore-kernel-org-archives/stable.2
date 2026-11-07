Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049428;
	b=I/DYezESOpOTSbOyDZGXmLEEQ9f3PVJcXfJzB6RHyZ0pAcMOMefqbdgI3iHbcM4P1pld
	 cs4VS5Z6ClLbdhu4uU8NOLhljdLFKT0bz1PETN9i1KNmeoxHO4cchpt2cdqDJLKPdTLin
	 TEvUMw7N1PNqXb9Zeq/K2YCV9FYA9iGSvlsiEzwU/0nEVmpm7pyBe17OsaNorN7EdT449
	 RPUDA/FpBJYinj24hAopnqWVpdEJlo+6wC2Zq8UjpAwraZPfVFablMnYbQ6d72vFyuQof
	 ltlfSBImsACyrFY3lCP6wpwVEn6hml6V2QH36ZK1vJ65g+XUCU+LqoMamBTFqKSNigg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=L7b4XkieShU+Ru4pyO2gDg4tuI7XMFDP4PV7o3XhoX0=;
	b=YvC5Ypv6IoEgfR+D3Dcz1SeEpQcAhGkMrknuX3QGvXQi7hnzCprl9TcdnnibCLgRCsh/
	 TmMVxRfxqUw2IqwfWd7h7IKSV9fghqNLlVX1DEGvWNlsowzxec+KetPCKY5gioS3a6hFd
	 Kan4oR2rNZ8BBh1ymC2C2ZPb2qCd+FV3oWJcCsM6FPb2Pzc0ogTpXfYjk9F98q0LxKYse
	 nyu4DMFeInhvsHjzleGktfux2ROP3XgG6cexbcpnUIINqaKKjK6byMBQnAlz/GVGbk3XR
	 4k8AL1Sh4WqnAKYi6ZlrkO1pJsoBaUHr1g/yvSbmju7n6v4HZ/9ROlej18Vy+vZLsRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0XOZjcL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0XOZjcL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCF91F0089F;
	Sat,  7 Nov 2026 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049428;
	bh=L7b4XkieShU+Ru4pyO2gDg4tuI7XMFDP4PV7o3XhoX0=;
	h=From:To:Cc:Subject:Date;
	b=E0XOZjcLmhGwA8uaMmfObCsYo5Y5E1n/NtdwUQMfXdKX4ngnB+Y6L5PUOp/AO2mFr
	 ehJkVva8qAM72NKdclTPTNIoGzWoArN0jD26TaIN08vWSiHRZwTMCX9Hs9Ea7N9wao
	 jlP5yQmpLmChaYVj7Zr+Ip0f7JkqQjd8blozEQHyMswplHQPlI7kMzd9C+/t/VecFA
	 abQSzMLR1i/aSQbNAguvqCM31R8xm1d05Y2IQMcQGBUo7FquGRnLr3nynegEgbzu+W
	 9WWp0Z5jiGwcngD1KIIhpM6PMeMLBLH9NQbo+71pnkTwspAk66obTf6JMKy4B0U1hx
	 hz2cvxkO80vFw==
From: Sasha Levin <sashal@kernel.org>
To: ross.lagerwall@citrix.com,
	roger@xenproject.org,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen-blkfront: Fix IO race during unplug" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:03:46 -0500
Message-ID: <20261107060346-failed-5.15-61b6d1df1d62@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 61b6d1df1d6234c38a6ea7e4f58e7da035ef6ab4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060346-failed-5.15-61b6d1df1d62@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 61b6d1df1d6234c38a6ea7e4f58e7da035ef6ab4 Mon Sep 17 00:00:00 2001
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Tue, 6 Oct 2026 17:34:07 +0100
Subject: [PATCH] xen-blkfront: Fix IO race during unplug
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/block/xen-blkfront.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 86f5dd3aced13..ad0cb42c10197 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2142,10 +2142,8 @@ static void blkfront_closing(struct blkfront_info *info)
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




