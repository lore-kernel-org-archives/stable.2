Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13092530DE6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950718; cv=none; b=WHgBLzeiZdcCS6lguLqjYoIvsUDSO0ds1s5irVio7GGRU+D/IG4Q3Nt9XduM8ql0sT/xh6bwLvzxN31Ioa/0ax8zz6nktL6dJXpwe9ny9nyjLsl4uKU3F6dr1Sj1lqGKCHK/va8ssQ552jTR2L7bg96hBpdhanZYaiWEecnO1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950718; c=relaxed/simple;
	bh=9ubklIJY1gXbAHnG6989UzdcuFJbfoaBKiuU4eJny7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2Tc57ZJ1opKyRoMHFXnTxr4Xa5vbWHh3e6Tar7z+Kvd4QWsVmio8yrnVR1ov6EH3w9oPYokNj/PjCiG4TJUQwSW/JWrO2TGOhTCj1EGqDrqocJQlDndZFc2OvXjxI+7WaUJnGdDDP+BdMf6/hVdiTELkpJZBQjc4WqmxHhTEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXFmoJF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXFmoJF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732001F00A3E;
	Wed,  9 Sep 2026 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950717;
	bh=Ay3rMA2Q+GWBLElCGrTWOh1SC688ltF47H//oVzb4pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TXFmoJF1PF/cbW9AeI20VRCdrt2J+3uCz4YyVSJDWi4xlkyiNfAvhdpJncrKqXTDx
	 a/tcGnZw5pxlKavoJUKgI6xIgSWdGHSq5TYyd0dSSHSExvnBbsXo4C1FuzifXfWhUS
	 FMO6cy2BbBz7uJiNJsG/mZD1UjNESGCLxUNB7Um1zuhyWXAJUvR4wx+iXqE7AUdtCC
	 fGCTpsh+Pn0YuMeUK4wdPT9zcLhA4N91mPiR54DfnvdS18LxCopJa2aziDbUHXtaAs
	 yKsaWEnSbQOdM4oAWOvbZZ1xX/tU/pv4+PigyvpwvbNrj4keqY0IGdYkVdZsGXR0zy
	 GBulJ2QAGuXrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] nvme-tcp: fix host memory disclosure on R2T for a read command
Date: Wed,  9 Sep 2026 06:45:13 -0400
Message-ID: <20260909104513.1560898-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909104513.1560898-1-sashal@kernel.org>
References: <2026090304-lazily-cauterize-57c7@gregkh>
 <20260909104513.1560898-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

[ Upstream commit 6efbc52237facda35d2d874fe1765bb4839275d8 ]

nvme_tcp_handle_r2t() does not check the direction of the request the
R2T refers to. A malicious controller can send an R2T for a READ and
the host will answer it: nvme_tcp_setup_h2c_data_pdu() builds the
H2CData header and nvme_tcp_try_send_data() sends the request's data
buffer. That buffer is the READ destination, so its contents go to the
controller.

The command then completes normally and nothing is logged.

Against a test controller that answers every READ with an R2T, a 4096
byte buffered read returned all 4096 bytes, split over two R2Ts. The
pages contained stale kernel data, including an array of struct page
pointers.

Reject an R2T for a request that is not a write.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 01d42b854be2d..c9436767534a7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -645,6 +645,13 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
+	if (unlikely(rq_data_dir(rq) != WRITE)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t for a non-write command\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	if (unlikely(!r2t_length)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len is %u, probably a bug...\n",
-- 
2.53.0

